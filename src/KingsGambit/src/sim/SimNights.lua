-- King's Gambit: the practice raid, the raid nights (Molten Core, Ahn'Qiraj), free play and practice: the raiders, their wants, killing a boss and handing out loot. Keep this file Lua 5.1-safe.
-- Part of Sim (sim/Sim.lua): Sim calls Install, which adds these to the Sim class.
local _, SK = ...
local ItemFit, MoltenCore, AQ40
local P = SK:NewModule("SimNights", { "ItemFit", "MoltenCore?", "AQ40?" }, function(d) ItemFit, MoltenCore, AQ40 = d.ItemFit, d.MoltenCore, d.AQ40 end)

-- M, Sim: the table to add to; h: what Sim shares (and what the parts installed before this one exported).
function P.Install(M, Sim, h)
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
    if not self:raidOpen() then return nil, "noraid" end
    local boss
    if name then
        for i, b in ipairs(MC.bosses) do if b.name == name then boss, self.bossIndex = b, i end end
    else
        self.bossIndex = self.bossIndex + 1
        boss = MC.bosses[self.bossIndex]
    end
    if not boss then return nil, "noboss" end
    if self.attendance then self.attendance:enemyKilled() end -- the raid officially starts with its first kill
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
        self.client:setTradeable(item.name, 2 * 3600) -- a bind-on-pickup drop can be traded for two hours
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
end
