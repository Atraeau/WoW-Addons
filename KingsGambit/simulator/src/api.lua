-- King's Gambit simulator: the thin layer between the page (JavaScript) and the real engine.
-- Everything crosses the boundary as JSON strings. The rules all live in the engine bundle.
local js = require "js"
local S = KG_SK.modules
local Sim, Scenarios = S.Sim, S.Scenarios

---------------------------------------------------------------- JSON encoder
local function isArray(t)
    local n = 0
    for k in pairs(t) do
        if type(k) ~= "number" then return false end
        n = n + 1
    end
    return n == #t
end

local ESC = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t" }
local function encode(v)
    local t = type(v)
    if t == "string" then
        return '"' .. v:gsub('[%c"\\]', function(c) return ESC[c] or ("\\u%04x"):format(c:byte()) end) .. '"'
    elseif t == "number" then
        if v ~= v or v == math.huge or v == -math.huge then return "null" end
        return (v == math.floor(v)) and ("%d"):format(v) or ("%.6g"):format(v)
    elseif t == "boolean" then
        return v and "true" or "false"
    elseif t == "table" then
        local out = {}
        if isArray(v) then
            for i = 1, #v do out[i] = encode(v[i]) end
            return "[" .. table.concat(out, ",") .. "]"
        end
        local keys = {}
        for k in pairs(v) do keys[#keys + 1] = tostring(k) end
        table.sort(keys)
        for _, k in ipairs(keys) do
            local val = v[k]
            if val == nil then val = v[tonumber(k)] end
            if type(val) ~= "function" then out[#out + 1] = encode(k) .. ":" .. encode(val) end
        end
        return "{" .. table.concat(out, ",") .. "}"
    end
    return "null"
end

local function short(name) return name and (name:gsub("%-.*$", "")) end

---------------------------------------------------------------- state
local sim, scenario, startCount = nil, nil, 0

local function describe(ev)
    local d, t = ev.data, ev.type
    if t == "Award" then
        return short(d.member) .. " won " .. d.item .. (d.to and (" and gave it to " .. short(d.to)) or "")
    elseif t == "Pass" then
        return short(d.member) .. " passed on " .. d.item .. (d.kind and (" (" .. d.kind .. ")") or "")
    elseif t == "Disenchant" then
        return d.item .. " was disenchanted by " .. short(d.to)
    elseif t == "Revert" then
        return "The last award was undone"
    elseif t == "CreateList" then
        return "The " .. tostring(d.name) .. " list was started"
    elseif t == "AddMember" then
        return short(d.member) .. " joined the list"
    elseif t == "Transfer" then
        return "An item was re-routed to " .. short(d.to)
    elseif t == "MovePlayer" then
        return short(d.member) .. " was moved (" .. tostring(d.reason) .. ")"
    end
    return t
end

local function logLines()
    local out = {}
    local applied = sim.engine:View().applied
    for i = startCount + 1, #applied do
        local ev = applied[i]
        if ev.list then out[#out + 1] = { list = ev.list, ts = ev.ts, text = describe(ev) } end
    end
    return out
end

local function state()
    if not sim then return { phase = "none" } end
    local snap = sim:snapshot()
    local s = sim.session
    snap.scenario = scenario and scenario.id or "free"
    snap.you = "You"
    -- every raider's class, main spec and off-spec, so the page can show who is who
    snap.who = {}
    for n, info in pairs(sim.info) do
        snap.who[n] = { class = info.class, spec = info.spec, off = info.offSpec, role = info.role }
    end
    snap.log = logLines()
    if scenario then snap.lesson = { title = scenario.title, text = scenario.lesson } end
    if sim.raid then
        local bosses = sim.raid.bosses
        local nextBoss = bosses[sim.bossIndex + 1]
        snap.night = { next = nextBoss and nextBoss.name or nil, held = {}, killed = sim.bossIndex,
            last = bosses[#bosses].name, raid = scenario and scenario.title }
        for i, h in ipairs(sim.held) do snap.night.held[i] = h.item.name .. " (" .. h.boss .. ")" end
    end
    if not s then
        snap.phase, snap.items, snap.players, snap.pending, snap.now = "idle", {}, {}, {}, sim.client:now()
        snap.cfg = { bidSeconds = 30, pickSeconds = 20, claimSeconds = 10 }
        return snap
    end
    local off = sim.engine:Get("off")
    if off then
        snap.offOrder = {}
        for i, n in ipairs(off.state.order) do snap.offOrder[i] = short(n) end
    end
    -- who has answered what (public: passes are visible by design)
    snap.bids = {}
    snap.players = {}
    for _, n in ipairs(s.eligibleList) do
        local row = { name = short(n), answers = {} }
        for _, it in ipairs(s.items) do
            local b = s.bids[n] and s.bids[n][it.id]
            row.answers[#row.answers + 1] = b and { kind = b.kind, to = short(b.to), passKind = b.passKind, ready = b.ready } or false
        end
        snap.players[#snap.players + 1] = row
    end
    snap.pending = {}
    for _, a in ipairs(s.pending) do
        if a.type == "award" then
            snap.pending[#snap.pending + 1] = { type = "award", tier = a.tier, member = short(a.member), to = short(a.to), item = a.item.link }
        elseif a.type == "disenchant" then
            snap.pending[#snap.pending + 1] = { type = "disenchant", to = short(a.to), item = a.item.link }
        elseif a.type == "enroll" then
            snap.pending[#snap.pending + 1] = { type = "enroll", member = short(a.member), list = a.list }
        end
    end
    snap.cfg = { bidSeconds = s.cfg.bidSeconds, pickSeconds = s.cfg.pickSeconds, claimSeconds = s.cfg.claimSeconds }
    if scenario then snap.lesson = { title = scenario.title, text = scenario.lesson } end
    return snap
end

---------------------------------------------------------------- freeplay
local function freeScenario(seed)
    local free = Sim.FreePlay(seed)
    return { id = "free", title = "Free play", members = free.members, items = free.items, policies = free.policies,
        learnerClass = free.learnerClass, learnerSpec = free.learnerSpec, learnerRole = free.learnerRole,
        lesson = "A random raid (each raider has a class and spec) and a random drop of real Molten Core gear. Run the loot as the Master Looter and watch how the bots behave. Everyone's answers are public, as they are in the real addon.",
        expect = function() return true, "Free play has no right answer. Look at the history on the right to see what was recorded." end }
end

---------------------------------------------------------------- the API
local api = {}

-- Raid nights: a whole raid with a 40-person roster and real loot from real bosses.
local NIGHTS = {
    { id = "mc", title = "Molten Core night", new = Sim.NewMoltenCore,
      lesson = "A full Molten Core night with a 40-person raid and real loot from real bosses. Kill the bosses in order and hand loot out after each one, or hold it and hand it all out at a break: the same rules apply either way. Every raider has a class, a main spec and an off-spec, and answers from how well each item's real stats fit them: need for the main spec, off for the off-spec. Items for other classes they leave alone (the session would refuse them anyway). You are the Master Looter and a Holy priest." },
    { id = "aq40", title = "Ahn'Qiraj night", new = Sim.NewAQ40,
      lesson = "The Temple of Ahn'Qiraj drops tokens beside gear: each is for a group of classes and is turned in, with materials and reputation, for a tier piece. Tokens are handed out like any item, under the same rules. Each bidder's readiness is shown (ready, says ready, not ready) so the raid can see it, but it is only a hint and never enforced: materials in the bank can't be seen, and taking a token you can't use yet is your own call." },
}

function api.scenarios()
    local out = {}
    for _, n in ipairs(NIGHTS) do out[#out + 1] = { id = n.id, title = n.title, lesson = n.lesson } end
    for _, sc in ipairs(Scenarios.list) do out[#out + 1] = { id = sc.id, title = sc.title, lesson = sc.lesson } end
    return out
end

local function result(ok, why)
    local s = state()
    s.ok, s.why = ok and true or false, why
    return s
end

function api.start(id, seed)
    seed = tonumber(seed) or 1
    for _, n in ipairs(NIGHTS) do
        if n.id == id then
            scenario = { id = n.id, title = n.title, lesson = n.lesson }
            sim = n.new({ seed = seed })
            startCount = #sim.engine:View().applied
            return state()
        end
    end
    scenario = (id == "free") and freeScenario(seed) or Scenarios.find(id)
    if not scenario then return { error = "unknown scenario" } end
    sim = Sim.NewRaid({ members = scenario.members, seed = seed, learner = "You",
        learnerClass = scenario.learnerClass, learnerSpec = scenario.learnerSpec, learnerRole = scenario.learnerRole })
    sim.policies = scenario.policies or {}
    startCount = #sim.engine:View().applied
    local ok, why = sim:drop(scenario.items, scenario.config)
    if not ok then return { error = tostring(why) } end
    return state()
end

function api.state() return state() end

-- A raid night: kill the next boss; hold = "1" keeps the loot for a later hand-out.
function api.kill(hold)
    if not (sim and sim.raid) then return { error = "not a raid night" } end
    if sim.session and sim.session.phase ~= "done" and sim.session.phase ~= "cancelled" then
        return result(false, "finish handing out the current loot first")
    end
    local boss, why = sim:killBoss(nil, hold == "1")
    return result(boss ~= nil, why)
end

function api.handout()
    if not (sim and sim.raid) then return { error = "not a raid night" } end
    if sim.session and sim.session.phase ~= "done" and sim.session.phase ~= "cancelled" then
        return result(false, "finish handing out the current loot first")
    end
    return result(sim:handOut())
end
function api.advance(sec) if sim then sim:advance(tonumber(sec) or 0) end return state() end

-- kind "needready": need, and you say you can turn the token in.
function api.bid(itemId, kind, to)
    if to == "" then to = nil end
    local ready
    if kind == "needready" then kind, ready = "need", "says" end
    return result(sim.session:bid("You", tonumber(itemId), kind, { to = to, ready = ready }))
end

-- You are the Master Looter: make your own class eligible for an item restricted to others. It is written to the
-- ledger as the guild's rule for the item, with your reason, like an accepted eligibility request.
function api.eligible(itemId, reason)
    local s = sim.session
    local it = s and s.items[tonumber(itemId)]
    if not it then return result(false, "noitem") end
    if not reason or reason == "" then return result(false, "a reason is required: it goes in the record") end
    local fit = s:fitOf(it.id)
    local me = sim.info.You.class
    local ok, why = S.Loot.MayHave(fit, me)
    if ok then return result(false, "your class may already bid on it") end
    if why == "cantequip" then return result(false, "your class can't wear or wield it") end
    local classes = {}
    for _, c in ipairs(fit.classes or {}) do classes[#classes + 1] = c end
    classes[#classes + 1] = me
    if not it.itemId then return result(false, "this item has no item id") end
    local ev, err = sim.engine:Write("ItemClasses", { item = it.itemId, classes = classes,
        reason = reason, requestedBy = sim.learner, class = me, name = it.link })
    if not ev then return result(false, err) end
    it.fit = nil -- read the item again, with the new rule
    return state()
end

function api.passAll()
    for _, it in ipairs(sim.session.items) do sim.session:bid("You", it.id, "pass") end
    return state()
end

function api.pick(itemId) return result(sim.session:pick("You", tonumber(itemId))) end
function api.skip() return result(sim.session:skip("You")) end
function api.claim(to)
    if to == "" then to = nil end
    return result(sim.session:claimItem("You", to and { to = to } or nil))
end
function api.decline() return result(sim.session:decline("You")) end
function api.extend(sec) return result(sim.session:extend(tonumber(sec) or 30)) end
function api.resolveNow() return result(sim.session:resolveNow()) end

function api.confirm()
    local ok, failures = sim.session:confirm()
    local s = result(ok, ok and nil or failures)
    if ok then s.failures = failures end
    return s
end

-- Undo the most recent award by writing a Revert event (fix-forward).
function api.undo()
    local chain = sim.engine:Get("main")
    local stack = chain.state.undo[sim.engine:MyChain()]
    local top = stack and stack[#stack]
    if not top then return result(false, "nothing to undo") end
    local ev, err = sim.engine:Append("main", "Revert", { target = top.id })
    return result(ev ~= nil, err)
end

-- Run every training scenario headlessly inside this runtime (used to verify the browser build).
function api.selftest()
    local results = {}
    for _, sc in ipairs(Scenarios.list) do
        local _, ok, msg = Sim.RunScenario(sc)
        results[#results + 1] = { id = sc.id, ok = ok and true or false, message = msg }
    end
    return results
end

function api.check()
    if not scenario then return { ok = false, message = "no scenario" } end
    local ok, message = scenario.expect(sim)
    return { ok = ok and true or false, message = message }
end


---------------------------------------------------------------- sync lab
-- Several real engines (each with its own MockClient) joined by a SimNetwork. Nothing here is
-- special-cased: the Sync module is the same code that will run in the game.
local lab

local function labLog(text) lab.log[#lab.log + 1] = { t = lab.net.time, text = text } end

local function labAddPeer()
    local i = #lab.peers + 1
    local name = lab.names[i]
    if not name then return false end
    local net = lab.net
    local client = S.MockClient.New({ name = name, realm = "Realm", seed = 1000 + i,
        clock = 1000 + net.time, unix = 1760000000 + math.floor(net.time) })
    local engine = S.Engine.New(client)
    local sync = S.Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    net:attach(client)
    sync:start()
    local peer = { name = name, full = name .. "-Realm", client = client, engine = engine, sync = sync, restricted = false }
    sync:on("forkResolved", function(p)
        if p.winner == "theirs" then
            labLog(name .. " found a fork at event " .. p.at .. " and switched to the longer chain; " .. p.orphaned .. " of their own events were set aside for review")
        else
            labLog(name .. " found a fork at event " .. p.at .. " and kept their chain (it was the longer one)")
        end
    end)
    lab.peers[i] = peer
    return peer
end

local function labReset()
    lab = { net = S.SimNetwork.New({ seed = 3, latency = 0.15 }), peers = {}, log = {}, counter = 0, groups = nil,
        names = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn" } }
    for _ = 1, 4 do labAddPeer() end
    local a = lab.peers[1]
    a.engine:CreateList("main", "Main")
    local officers = {}
    for _, n in ipairs(lab.names) do officers[#officers + 1] = n .. "-Realm" end
    a.engine:Write("SetOfficers", { names = officers })
    for i = 1, 5 do a.engine:Append("main", "AddMember", { member = "Raider" .. i .. "-Realm" }) end
    lab.counter = 5
    lab.net:advance(4)
    lab.log = {}
    labLog("Four players are in sync. Try splitting the network, then writing at both ends.")
end

local function labState()
    if not lab then labReset() end
    -- what most peers agree on (ties go to the peer with more events)
    local tally = {}
    for _, p in ipairs(lab.peers) do
        local fp = p.engine:Fingerprint() or "none"
        local n = 0
        for _, c in pairs(p.engine.store.chains) do n = n + #c.events end
        local t = tally[fp] or { fp = fp, votes = 0, n = n, peer = p }
        t.votes = t.votes + 1
        tally[fp] = t
    end
    local best
    for _, t in pairs(tally) do
        if not best or t.votes > best.votes or (t.votes == best.votes and t.n > best.n) then best = t end
    end
    local majority = best.peer.engine.store
    local out = { time = lab.net.time, inFlight = lab.net:inFlight(), stats = lab.net.stats, peers = {}, log = lab.log,
        drop = lab.net.dropRate, dup = lab.net.duplicateRate, split = lab.groups, canAdd = #lab.peers < #lab.names }
    for i, p in ipairs(lab.peers) do
        local e = p.engine
        local n, subset = 0, true
        for _, c in pairs(e.store.chains) do
            n = n + #c.events
            for _, ev in ipairs(c.events) do
                if not majority.byId[ev.id] then subset = false end
            end
        end
        local status = "in sync"
        if (e:Fingerprint() or "none") ~= best.fp then status = subset and "behind" or "diverged" end
        local list = e:Get("main")
        local order = {}
        if list then for j, m in ipairs(list.state.order) do if j <= 6 then order[#order + 1] = short(m) end end end
        local orphans = 0
        for _, o in ipairs(e.db.orphans or {}) do orphans = orphans + #o.events end
        local st = p.sync:status()
        out.peers[i] = { index = i, name = p.name, count = n, head = (e:Fingerprint() or "none"):sub(1, 8), status = status,
            order = order, members = list and #list.state.order or 0, pending = st.pending, blocked = st.blocked,
            rejected = st.rejected, orphans = orphans, restricted = p.restricted }
    end
    return out
end

function api.lab_state() return labState() end
function api.lab_reset() labReset(); return labState() end
function api.lab_advance(sec) if not lab then labReset() end lab.net:advance(tonumber(sec) or 0); return labState() end

function api.lab_write(i, kind)
    if not lab then labReset() end
    local p = lab.peers[tonumber(i)]
    if not p then return { error = "no such player" } end
    local chain = p.engine:Get("main")
    lab.counter = lab.counter + 1
    local ev, err
    if kind == "member" then
        ev, err = p.engine:Append("main", "AddMember", { member = "Raider" .. lab.counter .. "-Realm" })
        if ev then labLog(p.name .. " added a member") end
    else
        local top = chain and chain.state.order[1]
        if not top then return labState() end
        ev, err = p.engine:Append("main", "Award", { member = top, item = "Item " .. lab.counter })
        if ev then labLog(p.name .. " gave an item to " .. short(top)) end
    end
    local s = labState()
    if not ev then s.error = tostring(err) end
    return s
end

-- spec like "1|234": peers in the same group can talk, groups cannot.
function api.lab_partition(spec)
    if not lab then labReset() end
    local groups, names, desc = {}, {}, {}
    for part in tostring(spec):gmatch("[^|]+") do
        local g, label = {}, {}
        for digit in part:gmatch("%d") do
            local p = lab.peers[tonumber(digit)]
            if p then g[#g + 1] = p.full; label[#label + 1] = p.name end
        end
        if #g > 0 then groups[#groups + 1] = g; desc[#desc + 1] = table.concat(label, " + ") end
    end
    lab.net:partition(groups)
    lab.groups = table.concat(desc, "  |  ")
    labLog("Network split: " .. lab.groups)
    return labState()
end

function api.lab_heal()
    if not lab then labReset() end
    lab.net:heal(); lab.groups = nil
    labLog("The network healed. Watch the heads converge.")
    return labState()
end

function api.lab_net(drop, dup)
    if not lab then labReset() end
    lab.net.dropRate = tonumber(drop) or 0
    lab.net.duplicateRate = tonumber(dup) or 0
    labLog(("Network: %d%% of messages lost, %d%% duplicated"):format(lab.net.dropRate * 100, lab.net.duplicateRate * 100))
    return labState()
end

function api.lab_restrict(i, flag)
    if not lab then labReset() end
    local p = lab.peers[tonumber(i)]
    if not p then return labState() end
    p.restricted = (flag == "1")
    p.client:setRestricted(p.restricted)
    labLog(p.name .. (p.restricted and " can no longer send addon messages (like during a boss fight)" or " can send again"))
    return labState()
end

function api.lab_join()
    if not lab then labReset() end
    local p = labAddPeer()
    if p then labLog(p.name .. " logged in with no data and will catch up") end
    return labState()
end

-- JS entry point: window.KG(name, a, b, c) -> JSON string.
js.global.KG = function(_, name, a, b, c)
    local fn = api[name]
    if not fn then return encode({ error = "no such call: " .. tostring(name) }) end
    local ok, res = pcall(fn, a, b, c)
    if not ok then return encode({ error = tostring(res) }) end
    return encode(res)
end
