-- King's Gambit: simulated raids with bot raiders (Phase 4.5, training mode foundation).
-- A Sim is a MockClient + Engine + a roster of bots that answer loot sessions according to
-- simple data-driven policies. The learner (the Master Looter) is the one human in it.
-- Runs anywhere Lua runs, including a browser. Keep this file Lua 5.1-safe.
local _, SK = ...
local MockClient, Engine, Loot, ItemFit, Requests, Identity, Tokens, MoltenCore, AQ40
local M = SK:NewModule("Sim", { "MockClient", "Engine", "Loot", "ItemFit", "Requests", "Identity", "Tokens?", "MoltenCore?", "AQ40?" }, function(d)
    MockClient, Engine, Loot, ItemFit, Requests, Identity, Tokens, MoltenCore, AQ40 = d.MockClient, d.Engine, d.Loot, d.ItemFit, d.Requests, d.Identity, d.Tokens, d.MoltenCore, d.AQ40
end)

local CLASSES = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "MAGE", "WARLOCK", "DRUID", "SHAMAN" }

-- A policy is a table (or you can supply functions with the same names):
--   bid   = { [itemLink] = "need" | "off" | "pass" | { "gift", to = "Name" } | { "pass", passKind = "upgrade" } }
--   default = kind used for items not listed in `bid` (default "pass")
--   pick  = "first" | { itemLink, ... } (preference order when it is this bot's draft turn)
--   skip  = true to skip a draft turn instead of picking
--   claim = true to claim salvage offers (false = decline); claimTo = "Name" to gift the item up
local Sim = {}
Sim.__index = Sim

local function short(name) return Identity.Display(name) end

-- opts: seed, learner (default "You"), members (array of names, or of { name, class, role, spec, offSpec };
--       top of the list first), learnerPosition ("last" default, "first", or "random": the Master Looter is a
--       raider like any other, so in a raid night they start anywhere), learnerClass, learnerRole,
--       learnerSpec, learnerOffSpec, shuffle (random order from the seed).
function M.NewRaid(opts)
    opts = opts or {}
    local learner = opts.learner or "You"
    -- The Master Looter's addon is the one that runs the session, so the simulated client is theirs: the learner by
    -- default, or another raider (a bot runs the loot, and the learner plays a raider).
    local ml = opts.masterLooter or learner
    local client = MockClient.New({ name = ml, seed = opts.seed or 1 })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")

    local names = {}
    for _, n in ipairs(opts.members or {}) do names[#names + 1] = n end
    if opts.shuffle then
        for i = #names, 2, -1 do
            local j = client:random(i)
            names[i], names[j] = names[j], names[i]
        end
    end
    if opts.learnerPosition == "first" then table.insert(names, 1, learner)
    elseif opts.learnerPosition == "random" then table.insert(names, client:random(#names + 1), learner)
    else names[#names + 1] = learner end

    local roster, info = {}, {}
    for i, m in ipairs(names) do
        local n, class, role, spec, offSpec
        if type(m) == "table" then n, class, role, spec, offSpec = m.name, m.class, m.role, m.spec, m.offSpec
        else n, class = m, (m == learner and opts.learnerClass) or CLASSES[((i - 1) % #CLASSES) + 1] end
        if n == learner then
            role, spec, offSpec = opts.learnerRole or role, opts.learnerSpec or spec, opts.learnerOffSpec or offSpec
        end
        names[i] = n
        roster[i] = { name = n, class = class }
        info[n] = { class = class, role = role, spec = spec, offSpec = offSpec }
        engine:Append("main", "AddMember", { member = n, class = class })
    end
    -- There is always a raid leader, who is not necessarily the Master Looter: by default the first raider who is
    -- neither the learner nor the Master Looter (a person can't be both unless nobody else is there).
    local leader = opts.leader
    if not leader then
        for _, n in ipairs(names) do if n ~= learner and n ~= ml and not leader then leader = n end end
        leader = leader or ml
    end
    client:setRaid(roster, { leader = leader, lootMethod = "master", masterLooter = ml })

    -- The disenchanter is usually not the Master Looter: a raider (an enchanter) volunteers. Default: the first
    -- raider whose class has the profession in mind (mage, warlock, priest), else the first other raider.
    local de = opts.disenchanter
    if not de then
        for pass = 1, 2 do
            for _, n in ipairs(names) do
                local cl = info[n].class
                if n ~= ml and n ~= learner and (pass == 2 or cl == "MAGE" or cl == "WARLOCK" or cl == "PRIEST") and not de then de = n end
            end
        end
    end

    -- The learner is the Master Looter of this raid, and designates who disenchants (a record in the ledger, as in
    -- the real addon: loot is not handed out until it is done). Without another raider it is the learner.
    assert(engine:Write("Elevate", { raid = "sim", ml = ml, minutes = 24 * 60 }))
    assert(engine:Write("SetDisenchanter", { raid = "sim", name = (de or ml) }))

    local sim = setmetatable({
        client = client, engine = engine, names = names, learner = learner, ml = ml,
        policies = {}, autoLearner = false, session = nil, log = {}, info = info, held = {}, rngState = opts.seed or 1,
    }, Sim)
    -- A disenchanter disenchants a little after being given the item, and the result is written down (as the real addon does: they tell the Master Looter).
    local MATERIALS = { "Strange Dust", "Soul Dust", "Lesser Magic Essence", "Greater Magic Essence", "Small Glimmering Shard", "Large Glowing Shard" }
    engine:OnChange(function(kind, _, ev)
        if kind ~= "local" or type(ev) ~= "table" or ev.type ~= "Disenchant" then return end
        client:after(2 + client:random() * 6, function()
            local results = { { name = MATERIALS[client:random(#MATERIALS)], count = client:random(3) } }
            local to = ev.data.to
            engine:Append(ev.list, "DisenchantResult", { disenchant = ev.id, results = results, requestedBy = (to ~= client:me()) and to or nil })
        end)
    end)
    return sim
end

-- Who disenchants: the Master Looter's designation for this raid, from the ledger.
function Sim:disenchanterName() return (self.engine:RaidDisenchanter()) end

-- The Master Looter changes who disenchants (any raider in the raid).
function Sim:setDisenchanter(name)
    name = self.client:normalize(name)
    local known = false
    for _, n in ipairs(self.names) do if n == name then known = true end end
    if not known then return false, "notinraid" end
    local ev, err = self.engine:Write("SetDisenchanter", { raid = "sim", name = name })
    if not ev then return false, err end
    return true
end

function Sim:note(text) self.log[#self.log + 1] = { t = self.client:now(), text = text } end

function Sim:isBot(fullName)
    if fullName == self.learner then return self.autoLearner end
    return true
end

-- A raider's policy: keyed by their canonical name (First_Last), or by the plain name a scenario writes ("Aldric", "You").
function Sim:policyFor(fullName) return self.policies[fullName] or self.policies[short(fullName)] or {} end

local function wantedKind(policy, link)
    local b = policy.bid and policy.bid[link]
    if b == nil then b = policy.default or "pass" end
    if type(b) == "table" then return b[1], b end
    return b, nil
end

-- Start a loot session for these item links and wire the bots to it.
-- cfg overrides Loot defaults (bidSeconds, pickSeconds, ...).
-- seen (optional): for each link, when that loot became visible (held loot dropped earlier).
-- ids (optional): each link's item id (the simulator's links are plain names).
function Sim:drop(links, cfg, seen, ids)
    -- A simulation that plays as the game does (practice mode, the web page) asks for rankings, like the game's host.
    if self.rankingRequired then
        local c = {}
        for k, v in pairs(cfg or {}) do c[k] = v end
        if c.requireRanking == nil then c.requireRanking = true end
        cfg = c
    end
    local drops, items = {}, {}
    for i, link in ipairs(links) do
        -- A link that names a known raid item is taught to the game client like a real drop (slot, stats, the
        -- classes it names), so the class and proficiency rules apply to it. Other names are unknown items.
        local known = M.FindItem(link)
        if known then
            self:teach(known)
            ids = ids or {}
            ids[i] = ids[i] or known.id
        end
        drops[i] = { link = link }
        items[i] = { link = link, slot = i, seen = seen and seen[i] or nil, itemId = ids and ids[i] or nil }
    end
    self.client:dropLoot(drops)
    local session = Loot.NewSession(self.engine, cfg)
    local ok, why = session:start(items)
    if not ok then return false, why end -- (e.g. the loot method is not Master Looter: nothing is started)
    self.session = session
    self:wireBots()
    return true
end

function Sim:wireBots()
    local s, client = self.session, self.client
    -- Bids trickle in over the first part of the timer, in a repeatable order.
    local window = math.max(2, math.min((s.cfg.bidSeconds or 30) - 4, 14))
    for _, name in ipairs(s.eligibleList) do
        if self:isBot(name) then
            local policy = self:policyFor(name)
            -- When the session asks for rankings, a bot ranks the items it wants of each kind by its preference (its `pick` list), else by item number.
            local ranks = {}
            if s.cfg.requireRanking then
                local byKind = {}
                for _, it in ipairs(s.items) do
                    local kind = wantedKind(policy, it.link)
                    if kind ~= "pass" then byKind[kind] = byKind[kind] or {}; table.insert(byKind[kind], it) end
                end
                local prefs = type(policy.pick) == "table" and policy.pick or {}
                local function preference(it)
                    for i, link in ipairs(prefs) do if link == it.link then return i end end
                    return #prefs + 1
                end
                for _, list in pairs(byKind) do
                    table.sort(list, function(a, b)
                        local pa, pb = preference(a), preference(b)
                        if pa ~= pb then return pa < pb end
                        return a.id < b.id
                    end)
                    for i, it in ipairs(list) do ranks[it.id] = i end
                end
            end
            for _, it in ipairs(s.items) do
                client:after(1 + client:random() * window, function()
                    if s.phase ~= "bidding" then return end
                    local kind, extra = wantedKind(policy, it.link)
                    if ranks[it.id] then
                        local e = {}
                        for k, v in pairs(extra or {}) do e[k] = v end
                        e.rank = ranks[it.id]
                        extra = e
                    end
                    s:bid(name, it.id, kind, extra)
                end)
            end
        end
    end
    s:on("turn", function(turn)
        if not self:isBot(turn.player) then return end
        local policy = self:policyFor(turn.player)
        client:after(1 + client:random() * 3, function()
            if s.turn ~= turn then return end
            if turn.type == "recipient" then
                -- a bot that bid to gift without saying who: it names someone who may have the item, else withdraws
                local named
                for _, n in ipairs(s.eligibleList) do
                    if not named and n ~= turn.player and not s.away[n] and select(1, Loot.MayHave(s:fitOf(turn.item), s.class[n])) then named = n end
                end
                if named then s:chooseRecipient(turn.player, named) else s:withdrawGift(turn.player) end
            elseif turn.type == "pick" then
                local pick
                if not policy.skip then
                    local prefs = type(policy.pick) == "table" and policy.pick or nil
                    if prefs then
                        for _, link in ipairs(prefs) do
                            for _, id in ipairs(turn.options) do
                                if s.items[id].link == link and not pick then pick = id end
                            end
                        end
                    end
                    pick = pick or turn.options[1]
                end
                if pick then s:pick(turn.player, pick) else s:skip(turn.player) end
            else
                if policy.claim then s:claimItem(turn.player, policy.claimTo and { to = policy.claimTo } or nil)
                else s:decline(turn.player) end
            end
        end)
    end)
end

function Sim:advance(sec) self.client:advance(sec) end

-- Advance the clock until the session reaches `phase` (or done), up to maxSeconds.
function Sim:runUntil(phase, maxSeconds)
    local waited = 0
    while self.session.phase ~= phase and waited < (maxSeconds or 300) do
        self.client:advance(1)
        waited = waited + 1
    end
    return self.session.phase == phase
end

function Sim:order()
    local out = {}
    for i, n in ipairs(self.engine:Get("main").state.order) do out[i] = short(n) end
    return out
end

function Sim:orderString() return table.concat(self:order(), ",") end

-- A plain-table view of everything a UI needs to draw.
function Sim:snapshot()
    local s = self.session
    local snap = { order = self:order(), phase = s and s.phase or "idle", head = self.engine:Get("main").head }
    if s then
        local status = s:status()
        snap.answered, snap.eligible, snap.deadline, snap.now = status.answered, status.eligible, status.deadline, self.client:now()
        snap.items = {}
        for i, it in ipairs(s.items) do
            snap.items[i] = { id = it.id, link = it.link, status = it.status, winner = it.winner and short(it.winner), to = it.to and short(it.to), tier = it.tier }
            -- May the learner bid on it (need, off-spec, gift)? If not, the page offers only a pass, and says why.
            local fit = s:fitOf(it.id)
            local me = self.info[self.learner] or self.info[short(self.learner)]
            local may, why = Loot.MayHave(fit, me and me.class)
            snap.items[i].youMay, snap.items[i].youWhy = may, why
            snap.items[i].classes = ItemFit.ClassList(fit or {})
            -- who the learner may gift it to: raiders who are eligible for it themselves
            local targets = {}
            for _, n in ipairs(self.names) do
                if n ~= self.learner and Loot.MayHave(fit, self.info[n] and self.info[n].class) then targets[#targets + 1] = short(n) end
            end
            snap.items[i].giftTargets = targets
            local rows = s:readiness(it.id)
            if rows then
                local wanted = {}
                for k, r in ipairs(rows) do wanted[k] = { player = short(r.player), kind = r.kind, ready = r.ready, label = Tokens.Label(r.ready) } end
                snap.items[i].token = { makes = it.token.token.makes, wanted = wanted }
            end
        end
        if s.turn then
            snap.turn = { type = s.turn.type, player = short(s.turn.player), options = s.turn.options, item = s.turn.item, tier = s.turn.tier }
            if s.turn.type == "recipient" then snap.turn.canKeep = s:mayKeep(s.turn.player, s.turn.item) end
        end
    end
    return snap
end

---------------------------------------------------------------- scenarios
-- sc: { id, title, lesson, members, items, policies = { [name] = policy }, you = policy,
--       after = function(sim), expect = function(sim) -> ok, message }
function M.RunScenario(sc, opts)
    opts = opts or {}
    local sim = M.NewRaid({ members = sc.members, seed = opts.seed or 1, learner = "You",
        learnerClass = sc.learnerClass, learnerSpec = sc.learnerSpec, learnerRole = sc.learnerRole })
    sim.policies = sc.policies or {}
    sim.policies["You"] = sc.you or {}
    sim.autoLearner = true
    local ok, why = sim:drop(sc.items, sc.config)
    if not ok then return sim, false, "could not start: " .. tostring(why) end
    if not sim:runUntil("review", 400) then return sim, false, "stuck in phase " .. sim.session.phase end
    local confirmed, failures = sim.session:confirm()
    if not confirmed then return sim, false, "confirm failed: " .. tostring(failures) end
    if sc.after then sc.after(sim) end
    local passed, message = sc.expect(sim)
    return sim, passed and true or false, message
end

---------------------------------------------------------------- raid nights (Molten Core, Ahn'Qiraj)
-- A realistic 40-person Alliance raid: class, main spec and off-spec for every bot (the role follows the main
-- spec). The learner is the 40th: a Holy priest with Shadow as off-spec. { class, spec, off-spec, count }.
M.ROSTER_40 = {
    { "WARRIOR", "Protection", "Fury", 3 }, { "WARRIOR", "Fury", "Protection", 4 },
    { "ROGUE", "Combat", nil, 4 }, { "HUNTER", "Marksmanship", nil, 3 },
    { "SHAMAN", "Restoration", "Enhancement", 2 }, { "SHAMAN", "Enhancement", "Restoration", 1 }, { "SHAMAN", "Elemental", "Restoration", 1 },
    { "MAGE", "Frost", "Fire", 3 }, { "MAGE", "Fire", "Frost", 2 }, { "WARLOCK", "Destruction", "Affliction", 4 },
    { "PRIEST", "Holy", "Shadow", 4 }, { "PRIEST", "Shadow", "Holy", 1 },
    { "DRUID", "Restoration", "Balance", 2 }, { "DRUID", "Feral (bear)", "Feral (cat)", 1 },
    { "PALADIN", "Holy", "Retribution", 3 }, { "PALADIN", "Retribution", "Holy", 1 },
}
-- Raiders have a first and a last name, as characters do in the game (the identity is the pair: Identity.lua).
local MC_NAMES = { "Aldric_Stormwind", "Brann_Ironforge", "Cass_Dunmere", "Dara_Whitlock", "Eira_Hollowell", "Fenn_Ashgrove", "Garo_Blackthorn",
    "Hale_Winterbourne", "Ilsa_Greywater", "Jory_Thornfield", "Kest_Marrowby", "Lio_Brightwater", "Mirel_Fairwind", "Nyx_Duskwood", "Orsa_Stonehelm",
    "Pell_Redmane", "Quill_Tanglewood", "Rhea_Silverbrook", "Soren_Oakhaven", "Tavi_Larkspur", "Ulf_Frostbeard", "Vera_Copperfield", "Wren_Highmoor",
    "Xan_Nightshade", "Yara_Goldleaf", "Zed_Ravenscar", "Ansel_Wyndham", "Bryn_Coldwell", "Corin_Ashford", "Delia_Moonbrook", "Emrys_Hartley",
    "Fia_Stoneridge", "Gideon_Blackwood", "Halia_Brightmoor", "Ivo_Fenwick", "Jessa_Thorne", "Kael_Ravenwood", "Lysa_Dawnwhisper", "Moro_Stonefist" }
local ARMOR = { WARRIOR = "plate", PALADIN = "plate", HUNTER = "mail", SHAMAN = "mail", ROGUE = "leather",
    DRUID = "leather", PRIEST = "cloth", MAGE = "cloth", WARLOCK = "cloth" }
-- Hybrids can also use the other role's gear as off-spec.
local OFFSPEC = { DRUID = { healer = "tank", tank = "healer" }, PALADIN = { healer = "melee", melee = "healer" },
    WARRIOR = { tank = "melee", melee = "tank" }, PRIEST = { healer = "caster" },
    SHAMAN = { healer = "melee", melee = "healer", caster = "healer" } }

local function hasBit(mask, bit) return math.floor(mask / bit) % 2 == 1 end

-- Would a raider want the item, and as main or off-spec? Returns "need", "off" or nil.
-- Tier pieces and class tokens go by class. Everything else goes by the fit heuristic (ItemFit): need if the
-- item suits the raider's main spec, off if it suits their off-spec. There is no list of items: the heuristic
-- judges from stats, use effects and what a token or quest item becomes, and an officer's override (suits:
-- Engine:ItemSuits) decides where it has been set. Without a spec, the class's first spec with that role is used.
function M.Wants(data, item, class, role, spec, offSpec, suits)
    if item.classes ~= 0 then
        local bit = data.CLASS_BITS[class]
        return (bit and hasBit(item.classes, bit)) and "need" or nil
    end
    if not spec then
        for _, s in ipairs(ItemFit.SPECS[class] or {}) do if s.role == role and not spec then spec = s.name end end
        offSpec = offSpec or (OFFSPEC[class] and OFFSPEC[class][role] and (function()
            for _, s in ipairs(ItemFit.SPECS[class]) do if s.role == OFFSPEC[class][role] then return s.name end end
        end)())
    end
    if not (spec and item.fit) then return nil end
    local fit = item.fit
    if suits then
        fit = {}
        for k, v in pairs(item.fit) do fit[k] = v end
        fit.suits = suits
    end
    local main = ItemFit.ForPlayer(fit, class, spec)
    if not main.usable then return nil end
    if main.rating == "good" then return "need" end
    local off = offSpec and ItemFit.ForPlayer(fit, class, offSpec)
    if off and off.rating == "good" then return "off" end
end

-- Tell the simulated game client what an item is, as the real one would: its slot, type and stats, and the
-- classes it names (tier pieces). The loot session reads it like any item, so the class rule applies.
function M.FindItem(name)
    for _, data in ipairs { MoltenCore, AQ40 } do
        for _, it in pairs(data.items) do
            if it.name == name then return it end
        end
    end
end

function Sim:teach(item)
    local link = item.name
    if self.client:itemInfo(link) then return end
    local fit = item.fit or {}
    self.client:setItemInfo(link, { name = item.name, equipLoc = fit.slot, class = fit.class, subclass = fit.subclass })
    self.client:setItemStats(link, { stats = fit.stats or {}, classes = ItemFit.ClassesFromMask(item.classes) })
end

---------------------------------------------------------------- free play
-- A small random raid and a random drop, all real: the items are drawn from the Molten Core loot table (gear with
-- a slot and stats, as nearly all loot has), the raiders have a class and spec, and the bots answer from the same
-- fit heuristic as in a raid night, so nobody bids on what their class can't have. Returns a scenario-shaped table
-- (members, items, policies) for Sim.NewRaid / Sim:drop. seed makes it repeatable.
local FREE_NAMES = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn", "Garo", "Hale", "Ilsa", "Jory" }
function M.FreePlay(seed, opts)
    opts = opts or {}
    local count, nitems = opts.raiders or 7, opts.items or 3
    local rng = M.NewRaid({ members = {}, seed = seed }).client
    local classes = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
    local members = {}
    for i = 1, count do
        local class = classes[rng:random(#classes)]
        local specs = ItemFit.SPECS[class]
        local spec = specs[rng:random(#specs)]
        members[i] = { name = FREE_NAMES[i], class = class, role = spec.role, spec = spec.name }
    end
    local lclass = classes[rng:random(#classes)]
    local lspecs = ItemFit.SPECS[lclass]
    local lspec = lspecs[rng:random(#lspecs)]
    -- real gear: it has an equipment slot and stats (the few quest items and tokens are left to raid nights)
    local pool = {}
    for _, it in pairs(MoltenCore.items) do
        if it.fit and it.fit.slot and it.fit.stats and next(it.fit.stats) then pool[#pool + 1] = it end
    end
    table.sort(pool, function(a, b) return a.id < b.id end)
    local drops, items = {}, {}
    for i = 1, nitems do
        local it = table.remove(pool, rng:random(#pool))
        drops[i], items[i] = it, it.name
    end
    local policies = {}
    for _, m in ipairs(members) do
        local p = { bid = {}, claim = rng:random() < 0.3 }
        for _, it in ipairs(drops) do
            local kind = M.Wants(MoltenCore, it, m.class, m.role, m.spec, nil)
            if kind and rng:random() < 0.75 then
                p.bid[it.name] = kind
            elseif kind then
                p.bid[it.name] = { "pass", passKind = "upgrade" }
            else
                -- can't use it: sometimes win it to hand on to a raider who can (anyone may gift)
                local friends = {}
                for _, o in ipairs(members) do
                    if o.name ~= m.name and M.Wants(MoltenCore, it, o.class, o.role, o.spec, nil) == "need" then friends[#friends + 1] = o.name end
                end
                if #friends > 0 and rng:random() < 0.25 then
                    p.bid[it.name] = { "gift", to = friends[rng:random(#friends)] }
                end
            end
        end
        policies[m.name] = p
    end
    return { members = members, items = items, policies = policies,
        learnerClass = lclass, learnerSpec = lspec.name, learnerRole = lspec.role }
end

-- data: a raid data module (MoltenCore, AQ40). opts: seed, learner ("You"), learnerClass ("PRIEST"),
-- learnerRole ("healer"), shuffle (default true), chance (probability a raider who could use an item still
-- needs it; default 0.7), readiness (for tokens: chances a bot is { ready, says } ready; the rest are not
-- ready; default { 0.55, 0.2 }).
function M.NewRaidNight(data, opts)
    opts = opts or {}
    local members, k = {}, 0
    for _, row in ipairs(M.ROSTER_40) do
        local spec = ItemFit.SpecOf(row[1], row[2])
        for _ = 1, row[4] do
            k = k + 1
            members[#members + 1] = { name = MC_NAMES[k], class = row[1], role = spec.role, spec = row[2], offSpec = row[3] }
        end
    end
    -- opts.size: a smaller group (a 5-player party, a 10 or 20), keeping the class mix by taking evenly spaced raiders from the 40.
    -- The learner is one more member, so size counts them.
    if opts.size and opts.size - 1 < #members then
        local want, picked = math.max(opts.size - 1, 0), {}
        for i = 1, want do picked[i] = members[math.floor((i - 0.5) * #members / want) + 1] end
        members = picked
    end
    -- The learner's class: the one asked for if the simulation knows it (a real player's class, in the game's practice mode), else a priest.
    local asked = opts.learnerClass and ItemFit.SPECS[opts.learnerClass] and opts.learnerClass or nil
    local learnerClass = asked or "PRIEST"
    local learnerSpec = (asked and opts.learnerSpec and ItemFit.SpecOf(asked, opts.learnerSpec) and opts.learnerSpec) or (not asked and "Holy") or ItemFit.SPECS[learnerClass][1].name
    local sim = M.NewRaid({ members = members, seed = opts.seed or 1, learner = opts.learner or "You",
        learnerClass = learnerClass, learnerSpec = learnerSpec,
        learnerOffSpec = opts.learnerOffSpec or (not asked and "Shadow") or nil,
        learnerRole = opts.learnerRole or ItemFit.SpecOf(learnerClass, learnerSpec).role,
        shuffle = opts.shuffle ~= false, learnerPosition = opts.learnerPosition or "random",
        masterLooter = opts.masterLooter, leader = opts.leader })
    sim.raid = data
    -- The guild's officers have already judged the items the heuristic can't (the learner founded this ledger,
    -- so they write them), through the same ItemSuits events a real officer's 'suits' command writes.
    local calls = {}
    for id in pairs(data.officerCalls or {}) do calls[#calls + 1] = id end
    table.sort(calls)
    for _, id in ipairs(calls) do
        local c = data.officerCalls[id]
        assert(sim.engine:Write("ItemSuits", { item = id, roles = c.roles, reason = c.reason, name = data.items[id] and data.items[id].name }))
    end
    sim.chance = opts.chance or 0.7
    sim.readiness = opts.readiness or { 0.55, 0.2 }
    sim.bossIndex = 0
    return sim
end

function M.NewMoltenCore(opts) return M.NewRaidNight(MoltenCore, opts) end

-- A practice raid on items that exist in the game being played: `items` is a list of { id, link, equipLoc, class, subclass, stats } (the gear in a
-- player's bags, say). They are shared out among a few practice bosses, four to a boss, each dropping two; the item's link is its name, so the
-- window shows a real link with a tooltip. Same shape as MoltenCore's data, so everything that runs on a raid night runs on this.
function M.NewPracticeData(items, title)
    local data = { name = title or "Your gear", CLASS_BITS = MoltenCore.CLASS_BITS, items = {}, bosses = {}, officerCalls = {} }
    local ids = {}
    for _, it in ipairs(items) do
        data.items[it.id] = { id = it.id, name = it.link, classes = 0,
            fit = { slot = it.equipLoc, class = it.class, subclass = it.subclass, stats = it.stats or {} } }
        ids[#ids + 1] = it.id
    end
    for i = 1, #ids, 4 do
        local loot = {}
        for j = i, math.min(i + 3, #ids) do loot[#loot + 1] = { ids[j], 1 } end
        local n = #data.bosses + 1
        data.bosses[n] = { name = "Practice boss " .. n, id = n, drops = math.min(2, #loot), loot = loot }
    end
    return data
end
function M.NewPractice(items, opts) return M.NewRaidNight(M.NewPracticeData(items), opts) end
-- Ahn'Qiraj: tokens (class-group tier tokens, plus weapon and C'Thun tokens) drop beside gear.
function M.NewAQ40(opts) return M.NewRaidNight(AQ40, opts) end

-- The next boss (or a named one) dies and rolls its loot from the real table. Returns the boss and the
-- dropped items ({ id, name, ... }). With hold = true the loot is set aside for a later hand-out.
function Sim:killBoss(name, hold)
    local MC = assert(self.raid, "not a raid night")
    local boss
    if name then
        for i, b in ipairs(MC.bosses) do if b.name == name then boss, self.bossIndex = b, i end end
    else
        self.bossIndex = self.bossIndex + 1
        boss = MC.bosses[self.bossIndex]
    end
    if not boss then return nil, "noboss" end
    local pool = {}
    for i, entry in ipairs(boss.loot) do pool[i] = { id = entry[1], w = entry[2] } end
    local dropped = {}
    for _ = 1, boss.drops do
        local total = 0
        for _, e in ipairs(pool) do total = total + e.w end
        if total <= 0 then break end
        local r, acc = self.client:random() * total, 0
        for i, e in ipairs(pool) do
            acc = acc + e.w
            if r < acc or i == #pool then
                dropped[#dropped + 1] = MC.items[e.id]
                table.remove(pool, i)
                break
            end
        end
    end
    for _, item in ipairs(dropped) do
        self.held[#self.held + 1] = { item = item, boss = boss.name, seen = self.client:serverTime() }
    end
    self:note(boss.name .. " died and dropped " .. #dropped .. " item(s)")
    local why
    if not hold then
        local ok, reason = self:handOut()
        if not ok then why = reason end -- the loot is kept: nothing can be handed out yet (e.g. no Master Looter set)
    end
    return boss, dropped, why
end

-- A bot's readiness for a token: most dedicated raiders bought their materials; some say so (bank); some
-- are not ready and bid anyway (their call).
function Sim:botReadiness()
    local r, odds = self.client:random(), self.readiness
    if r < odds[1] then return "ready" end
    if r < odds[1] + odds[2] then return "says" end
    return "notready"
end

-- Put every held item up for loot in one session. The bots answer from their class and role.
function Sim:handOut(cfg)
    if #self.held == 0 then return false, "nothing" end
    local held = self.held
    local links, seen, ids = {}, {}, {}
    for i, h in ipairs(held) do
        links[i], seen[i], ids[i] = h.item.name, h.seen, h.item.id
        self:teach(h.item)
    end
    self.policies = {}
    -- Roster order, never pairs(): random draws must happen in the same order in every process.
    for _, name in ipairs(self.names) do
        local info = self.info[name]
        local p = { bid = {}, claim = self.client:random() < 0.3 }
        local wanted = {}
        for _, h in ipairs(held) do
            local kind = M.Wants(self.raid, h.item, info.class, info.role, info.spec, info.offSpec, self.engine:ItemSuits(h.item.id))
            if kind and self.client:random() < self.chance then
                wanted[#wanted + 1] = { link = h.item.name, kind = kind, tier = h.item.classes ~= 0 or h.item.token ~= nil,
                    ready = h.item.token and self:botReadiness() or nil }
            elseif kind then
                p.bid[h.item.name] = { "pass", passKind = "upgrade" } -- could use it, chose not to spend the spot
            end
        end
        -- ranked choice: tier pieces first, then main-spec, then off-spec
        table.sort(wanted, function(a, b)
            if a.kind ~= b.kind then return a.kind == "need" end
            if a.tier ~= b.tier then return a.tier end
            return a.link < b.link
        end)
        for rank, w in ipairs(wanted) do p.bid[w.link] = { w.kind, rank = rank, ready = w.ready } end
        self.policies[name] = p
    end
    self.handedOut = held
    local ok, why = self:drop(links, cfg, seen, ids)
    if ok then self.held = {} end -- (a refused session, e.g. no Master Looter set, keeps the loot to hand out later)
    return ok, why
end

---------------------------------------------------------------- a raider asks the Master Looter
-- When a bot is the Master Looter the learner is a raider: they can't write to the ledger, they ask (undo, a regret-trade,
-- or "it was a gift", for a player's last award), with a reason. The bot Master Looter decides at once, the way the real
-- addon's accept and decline do: what can be done is written as the Master Looter's entry "at the request of" the
-- learner, and what can't is declined with the reason in the record. Returns true + a sentence, or false + a reason code
-- (the request itself was malformed) or false + a sentence (declined).
local DECLINE = {
    noaward = "that player has no award that is still standing",
    notrevertible = "that award can no longer be changed (the list was moved by hand since)",
    notmember = "the player it went to isn't on the list",
    samewinner = "that is who it was recorded for already",
}
function Sim:ask(kind, member, to, reason)
    if self.ml == self.learner then return false, "youareml" end
    if type(reason) ~= "string" or reason:match("^%s*$") then return false, "noreason" end
    self.asked = (self.asked or 0) + 1
    local r = { kind = kind, member = member and self.client:normalize(member), reason = reason, by = self.learner,
        rid = ("sim:%d"):format(self.asked) }
    if to and to ~= "" then r.to = self.client:normalize(to) end
    local ok, why = Requests.Validate(r)
    if not ok then return false, why == "badrequest" and "badtarget" or why end
    local state = self.engine:Get("main").state
    local type_, data = Requests.EventFor(state, r, self.engine:MyChain())
    local ml = short(self.ml)
    if not type_ then
        local text = DECLINE[data] or tostring(data)
        local ev, err = self.engine:Write("Declined", { request = Requests.Describe(r), requestedBy = r.by, declineReason = text,
            rid = r.rid, kind = r.kind, member = r.member })
        if not ev then return false, err end
        return false, ml .. " declined: " .. text
    end
    local ev, err = self.engine:Append("main", type_, data)
    if not ev then return false, err end
    return true, ml .. " accepted and wrote it to the ledger: " .. Requests.Describe(r)
end

---------------------------------------------------------------- the raid leader, the loot method
-- Who the raid leader is (always someone, in a group).
function Sim:leaderName() return self.client:leader() end

-- Someone changes the loot method. Only the raid leader may; for Master Looter, the looter is named. In the simulator the
-- Master Looter is chosen when a run starts (it decides whose addon runs the loot), so a different looter is refused here.
function Sim:setLootMethod(by, method, looter)
    by = self.client:normalize(by)
    if method == "master" and looter and self.client:normalize(looter) ~= self.ml then return false, "otherlooter" end
    return self.client:setLootMethodAs(by, method, looter or self.ml)
end

function Sim:setLeader(name) return self.client:setLeader(name) end
