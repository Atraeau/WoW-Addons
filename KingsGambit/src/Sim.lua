-- King's Gambit: simulated raids with bot raiders (Phase 4.5, training mode foundation).
-- A Sim is a MockClient + Engine + a roster of bots that answer loot sessions according to
-- simple data-driven policies. The learner (the Master Looter) is the one human in it.
-- Runs anywhere Lua runs, including a browser. Keep this file Lua 5.1-safe.
local _, SK = ...
local MockClient, Engine, Loot, ItemFit, Tokens, MoltenCore, AQ40
local M = SK:NewModule("Sim", { "MockClient", "Engine", "Loot", "ItemFit", "Tokens?", "MoltenCore?", "AQ40?" }, function(d)
    MockClient, Engine, Loot, ItemFit, Tokens, MoltenCore, AQ40 = d.MockClient, d.Engine, d.Loot, d.ItemFit, d.Tokens, d.MoltenCore, d.AQ40
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

local function short(name) return (name:gsub("%-.*$", "")) end

-- opts: seed, learner (default "You"), members (array of names, or of { name, class, role, spec, offSpec };
--       top of the list first), learnerPosition ("last" default, "first", or "random": the Master Looter is a
--       raider like any other, so in a raid night they start anywhere), learnerClass, learnerRole,
--       learnerSpec, learnerOffSpec, shuffle (random order from the seed).
function M.NewRaid(opts)
    opts = opts or {}
    local learner = opts.learner or "You"
    local client = MockClient.New({ name = learner, realm = "Realm", seed = opts.seed or 1 })
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
        engine:Append("main", "AddMember", { member = n .. "-Realm", class = class })
    end
    client:setRaid(roster, { leader = learner, lootMethod = "master", masterLooter = learner })

    -- The disenchanter is usually not the Master Looter: a raider (an enchanter) volunteers. Default: the first
    -- raider whose class has the profession in mind (mage, warlock, priest), else the first other raider.
    local de = opts.disenchanter
    if not de then
        for pass = 1, 2 do
            for _, n in ipairs(names) do
                local cl = info[n].class
                if n ~= learner and (pass == 2 or cl == "MAGE" or cl == "WARLOCK" or cl == "PRIEST") and not de then de = n end
            end
        end
    end

    -- The learner is the Master Looter of this raid, and designates who disenchants (a record in the ledger, as in
    -- the real addon: loot is not handed out until it is done). Without another raider it is the learner.
    assert(engine:Write("Elevate", { raid = "sim", ml = learner .. "-Realm", minutes = 24 * 60 }))
    assert(engine:Write("SetDisenchanter", { raid = "sim", name = (de or learner) .. "-Realm" }))

    return setmetatable({
        client = client, engine = engine, names = names, learner = learner .. "-Realm",
        policies = {}, autoLearner = false, session = nil, log = {}, info = info, held = {}, rngState = opts.seed or 1,
    }, Sim)
end

-- Who disenchants: the Master Looter's designation for this raid, from the ledger.
function Sim:disenchanterName() return (self.engine:RaidDisenchanter()) end

-- The Master Looter changes who disenchants (any raider in the raid).
function Sim:setDisenchanter(name)
    name = self.client:normalize(name)
    local known = false
    for _, n in ipairs(self.names) do if n .. "-Realm" == name then known = true end end
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

function Sim:policyFor(fullName) return self.policies[short(fullName)] or {} end

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
    self.session = session
    local ok, why = session:start(items)
    if not ok then return false, why end
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
            for _, it in ipairs(s.items) do
                client:after(1 + client:random() * window, function()
                    if s.phase ~= "bidding" then return end
                    local kind, extra = wantedKind(policy, it.link)
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
            if turn.type == "pick" then
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
            local me = self.info[short(self.learner)]
            local may, why = Loot.MayHave(fit, me and me.class)
            snap.items[i].youMay, snap.items[i].youWhy = may, why
            snap.items[i].classes = ItemFit.ClassList(fit or {})
            -- who the learner may gift it to: raiders who are eligible for it themselves
            local targets = {}
            for _, n in ipairs(self.names) do
                if n ~= short(self.learner) and Loot.MayHave(fit, self.info[n] and self.info[n].class) then targets[#targets + 1] = n end
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
        end
    end
    return snap
end

---------------------------------------------------------------- scenarios
-- sc: { id, title, lesson, members, items, policies = { [name] = policy }, you = policy,
--       after = function(sim), expect = function(sim) -> ok, message }
function M.RunScenario(sc, opts)
    opts = opts or {}
    local sim = M.NewRaid({ members = sc.members, seed = opts.seed or 1, learner = "You" })
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
    { "WARRIOR", "Protection", "Fury", 3 }, { "WARRIOR", "Fury", "Protection", 5 },
    { "ROGUE", "Combat", nil, 5 }, { "HUNTER", "Marksmanship", nil, 4 },
    { "MAGE", "Frost", "Fire", 3 }, { "MAGE", "Fire", "Frost", 3 }, { "WARLOCK", "Destruction", "Affliction", 4 },
    { "PRIEST", "Holy", "Shadow", 4 }, { "PRIEST", "Shadow", "Holy", 1 },
    { "DRUID", "Restoration", "Balance", 2 }, { "DRUID", "Feral (bear)", "Feral (cat)", 1 },
    { "PALADIN", "Holy", "Retribution", 3 }, { "PALADIN", "Retribution", "Holy", 1 },
}
local MC_NAMES = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn", "Garo", "Hale", "Ilsa", "Jory", "Kest", "Lio",
    "Mirel", "Nyx", "Orsa", "Pell", "Quill", "Rhea", "Soren", "Tavi", "Ulf", "Vera", "Wren", "Xan", "Yara", "Zed",
    "Ansel", "Bryn", "Corin", "Delia", "Emrys", "Fia", "Gideon", "Halia", "Ivo", "Jessa", "Kael", "Lysa", "Moro" }
local ARMOR = { WARRIOR = "plate", PALADIN = "plate", HUNTER = "mail", SHAMAN = "mail", ROGUE = "leather",
    DRUID = "leather", PRIEST = "cloth", MAGE = "cloth", WARLOCK = "cloth" }
-- Hybrids can also use the other role's gear as off-spec.
local OFFSPEC = { DRUID = { healer = "tank", tank = "healer" }, PALADIN = { healer = "melee", melee = "healer" },
    WARRIOR = { tank = "melee", melee = "tank" }, PRIEST = { healer = "caster" } }

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
    local classes = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "MAGE", "WARLOCK", "DRUID" }
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
    local learnerClass = opts.learnerClass or "PRIEST"
    local learnerSpec = opts.learnerSpec or (not opts.learnerClass and "Holy") or ItemFit.SPECS[learnerClass][1].name
    local sim = M.NewRaid({ members = members, seed = opts.seed or 1, learner = opts.learner or "You",
        learnerClass = learnerClass, learnerSpec = learnerSpec,
        learnerOffSpec = opts.learnerOffSpec or (not opts.learnerClass and "Shadow") or nil,
        learnerRole = opts.learnerRole or ItemFit.SpecOf(learnerClass, learnerSpec).role,
        shuffle = opts.shuffle ~= false, learnerPosition = opts.learnerPosition or "random" })
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
    if not hold then self:handOut() end
    return boss, dropped
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
    self.held = {}
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
    return self:drop(links, cfg, seen, ids)
end
