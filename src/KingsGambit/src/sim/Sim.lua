-- King's Gambit: simulated raids with bot raiders (Phase 4.5, training mode foundation).
-- A Sim is a MockClient + Engine + a roster of bots that answer loot sessions according to
-- simple data-driven policies. The learner (the Master Looter) is the one human in it.
-- Runs anywhere Lua runs, including a browser. Keep this file Lua 5.1-safe.
local _, SK = ...
local MockClient, Engine, Loot, ItemFit, Requests, Identity, Tokens, MoltenCore, AQ40, Attendance
local installParts -- defined at the end of the file: the simulated raiders are in SimBots.lua, the raid nights in SimNights.lua
local M = SK:NewModule("Sim", { "MockClient", "Engine", "Loot", "ItemFit", "Requests", "Identity", "Tokens?", "MoltenCore?", "AQ40?", "Attendance?", "SimBots", "SimNights" }, function(d)
    MockClient, Engine, Loot, ItemFit, Requests, Identity, Tokens, MoltenCore, AQ40, Attendance = d.MockClient, d.Engine, d.Loot, d.ItemFit, d.Requests, d.Identity, d.Tokens, d.MoltenCore, d.AQ40, d.Attendance
    installParts(d)
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
    local deName = de or ml
    -- Who is in the raid is written down as in the real addon, from the first kill on (Sim:killBoss).
    local attendance = Attendance and Attendance.New(engine, client)

    local sim = setmetatable({
        client = client, engine = engine, names = names, learner = learner, ml = ml,
        policies = {}, autoLearner = false, session = nil, log = {}, info = info, held = {}, rngState = opts.seed or 1,
        roster = roster, raidId = "sim", raidNo = 1, deName = deName, absent = {},
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
    sim.attendance = attendance
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
    local ev, err = self.engine:Write("SetDisenchanter", { raid = self.raidId or "sim", name = name })
    if not ev then return false, err end
    self.deName = name
    return true
end

---------------------------------------------------------------- raids, one after another
-- Practice runs more than one raid: a raid opens, bosses die and loot is handed out, people come and go, the raid ends, days pass, and the next one opens. Each is
-- a real raid in the ledger (an Elevate and a RaidClose), so Stats, attendance and the Ledger change the way they do over weeks.

-- Is this practice raid open (opened and not yet closed or expired)?
function Sim:raidOpen()
    for _, r in ipairs(self.engine:ActiveRaids()) do if r.id == self.raidId then return true end end
    return false
end

-- Put the group on the roster minus the absent, as the game would show it.
function Sim:setRoster()
    local members = {}
    for _, m in ipairs(self.roster) do
        if not self.absent[m.name] then members[#members + 1] = { name = m.name, class = m.class } end
    end
    self.client:setRaid(members, { leader = self.client:leader(), lootMethod = "master", masterLooter = self.ml })
end

-- Raiders who could leave: not the Master Looter, not the raid leader.
local function leavers(self)
    local out = {}
    local leader = self.client:leader()
    for _, m in ipairs(self.roster) do
        if m.name ~= self.ml and m.name ~= self.learner and m.name ~= leader and not self.absent[m.name] then out[#out + 1] = m.name end
    end
    return out
end

-- Someone leaves the group (disconnects, goes afk, is called away). Returns their name, or nil + why.
function Sim:leave(name)
    local who = name
    if not who then
        local candidates = leavers(self)
        if #candidates == 0 then return nil, "nobody" end
        who = candidates[self.client:random(#candidates)]
    end
    self.absent[who] = true
    self:setRoster()
    return who
end

-- Someone who left comes back (the one who has been away longest). Returns their name, or nil + why.
function Sim:rejoin()
    for _, m in ipairs(self.roster) do
        if self.absent[m.name] then
            self.absent[m.name] = nil
            self:setRoster()
            return m.name
        end
    end
    return nil, "nobody"
end

function Sim:absentCount()
    local n = 0
    for _ in pairs(self.absent) do n = n + 1 end
    return n
end

-- The Master Looter ends the raid (RaidClose). Not while a session is running or loot is held.
function Sim:endRaid()
    if not self:raidOpen() then return false, "noraid" end
    local s = self.session
    if s and s.phase ~= "done" and s.phase ~= "cancelled" then return false, "busy" end
    if #self.held > 0 then return false, "held" end
    local ev, why = self.engine:Write("RaidClose", { raid = self.raidId })
    if not ev then return false, why end
    return true
end

-- The next raid: a few days later, with a few raiders away, the same bosses again. Returns the raid's number, or nil + why.
function Sim:openRaid()
    if self:raidOpen() then return nil, "open" end
    self.client:advance(3 * 86400)
    self.raidNo = (self.raidNo or 1) + 1
    self.raidId = "sim" .. self.raidNo
    -- a couple of raiders can't make it this time; those who missed the last one are back
    for name in pairs(self.absent) do self.absent[name] = nil end
    for _ = 1, 2 do
        local candidates = leavers(self)
        if #candidates > 3 then self.absent[candidates[self.client:random(#candidates)]] = true end
    end
    self:setRoster()
    local ok, why = self.engine:Write("Elevate", { raid = self.raidId, ml = self.ml, minutes = 24 * 60 })
    if not ok then return nil, why end
    assert(self.engine:Write("SetDisenchanter", { raid = self.raidId, name = self.deName }))
    self.bossIndex, self.held, self.session, self.policies = 0, {}, nil, {}
    return self.raidNo
end

-- Write each simulated raider's spec for the current raid into the ledger (as the Master Looter would), except the learner's when specs are required.
function Sim:recordSpecs()
    for _, n in ipairs(self.names) do
        local info = self.info[n]
        local sp = info and info.spec and ItemFit.FindSpec(info.class, info.spec)
        if sp and not (self.requireSpec and n == self.learner) and not self.engine:SpecOf(self.raidId, n) then
            self.engine:Write("SetSpec", { raid = self.raidId, member = n, spec = sp.name, role = sp.role, class = info.class })
        end
    end
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

-- A lesson a person plays (the web page's tutorials, in the game's practice mode): the scenario's raid and drop, with the learner answering for themselves.
-- Nothing starts until `startLesson` (read it first); the clock should not run before that either. `verdict` says whether what they did matches the lesson.
function M.NewLesson(sc, opts)
    opts = opts or {}
    local sim = M.NewRaid({ members = sc.members, seed = opts.seed or 1, learner = opts.learner or "You",
        learnerClass = sc.learnerClass, learnerSpec = sc.learnerSpec, learnerRole = sc.learnerRole })
    sim.policies = sc.policies or {}
    sim.rankingRequired = true -- as in the game: someone who wants several items ranks them
    sim.lesson, sim.lessonStarted = sc, false
    return sim
end

function Sim:startLesson()
    local sc = self.lesson
    if not sc or self.lessonStarted then return false, "started" end
    -- A person is learning here: give their turns room to read and decide (the engine's defaults suit a raid).
    local cfg = { pickSeconds = 60, claimSeconds = 60 }
    for k, v in pairs(sc.config or {}) do cfg[k] = v end
    local ok, why = self:drop(sc.items, cfg)
    if ok then self.lessonStarted = true end
    return ok, why
end

-- Where the learner stands: { ok, pending, message }. A lesson with a step still to do (undoing a mistake, say) is not judged yet; `pending` says what is left.
-- Nil until the session has been confirmed (or for something that is not a lesson).
function Sim:verdict()
    local sc = self.lesson
    if not (sc and self.session and self.session.phase == "done") then return nil end
    local hint = sc.todo and sc.todo(self)
    if hint then return { ok = false, pending = true, message = hint } end
    local ok, message = sc.expect(self)
    return { ok = ok and true or false, message = message }
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

-- Add the other files' functions to M and the Sim class (once every module is loaded: see Registry.lua), handing them what they share.
function installParts(d)
    local h = { short = short }
    d.SimBots.Install(M, Sim, h)
    d.SimNights.Install(M, Sim, h)
end
