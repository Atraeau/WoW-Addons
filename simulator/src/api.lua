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
local sim, scenario, startSeq = nil, nil, {}
local FREE_ITEMS = { "Gauntlets of the Ashen Vow", "Cloak of Quiet Embers", "Band of Hollow Oaths", "Helm of Tides", "Mantle of Second Chances", "Staff of Lesser Tides" }
local FREE_NAMES = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn", "Garo", "Hale", "Ilsa", "Jory" }

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
    for _, listId in ipairs({ "main", "off" }) do
        local chain = sim.engine:Get(listId)
        if chain then
            for seq = (startSeq[listId] or 0) + 1, #chain.events do
                local ev = chain.events[seq]
                out[#out + 1] = { list = listId, seq = seq, ts = ev.ts, text = describe(ev) }
            end
        end
    end
    table.sort(out, function(a, b)
        if a.ts ~= b.ts then return a.ts < b.ts end
        if a.list ~= b.list then return a.list < b.list end
        return a.seq < b.seq
    end)
    return out
end

local function state()
    if not sim then return { phase = "none" } end
    local snap = sim:snapshot()
    local s = sim.session
    snap.scenario = scenario and scenario.id or "free"
    snap.you = "You"
    snap.log = logLines()
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
            row.answers[#row.answers + 1] = b and { kind = b.kind, to = short(b.to), passKind = b.passKind } or false
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
    local rng = Sim.NewRaid({ members = {}, seed = seed })
    local count = 7
    local members = {}
    for i = 1, count do members[i] = FREE_NAMES[i] end
    for i = #members, 2, -1 do
        local j = rng.client:random(i)
        members[i], members[j] = members[j], members[i]
    end
    local items = {}
    local pool = {}
    for i, n in ipairs(FREE_ITEMS) do pool[i] = n end
    for i = 1, 3 do items[i] = table.remove(pool, rng.client:random(#pool)) end
    local policies = {}
    for _, name in ipairs(members) do
        local p = { bid = {}, claim = rng.client:random() < 0.3 }
        for _, link in ipairs(items) do
            local r = rng.client:random()
            if r < 0.30 then p.bid[link] = "need"
            elseif r < 0.42 then p.bid[link] = "off"
            elseif r < 0.48 then p.bid[link] = { "gift", to = members[rng.client:random(#members)] }
            else p.bid[link] = "pass" end
        end
        policies[name] = p
    end
    -- a gift to yourself is meaningless; the engine would refuse it, so keep the bot honest
    for name, p in pairs(policies) do
        for link, b in pairs(p.bid) do
            if type(b) == "table" and b.to == name then p.bid[link] = "need" end
        end
    end
    return { id = "free", title = "Free play", members = members, items = items, policies = policies,
        lesson = "A random raid and a random drop. Run the loot as the Master Looter and watch how the bots behave. Everyone's answers are public, as they are in the real addon.",
        expect = function() return true, "Free play has no right answer. Look at the history on the right to see what was recorded." end }
end

---------------------------------------------------------------- the API
local api = {}

function api.scenarios()
    local out = { { id = "free", title = "Free play", lesson = "A random raid and a random drop." } }
    for _, sc in ipairs(Scenarios.list) do out[#out + 1] = { id = sc.id, title = sc.title, lesson = sc.lesson } end
    return out
end

function api.start(id, seed)
    seed = tonumber(seed) or 1
    scenario = (id == "free") and freeScenario(seed) or Scenarios.find(id)
    if not scenario then return { error = "unknown scenario" } end
    sim = Sim.NewRaid({ members = scenario.members, seed = seed, learner = "You" })
    sim.policies = scenario.policies or {}
    startSeq = { main = #sim.engine:Get("main").events, off = 0 }
    local ok, why = sim:drop(scenario.items, scenario.config)
    if not ok then return { error = tostring(why) } end
    return state()
end

function api.state() return state() end
function api.advance(sec) if sim then sim:advance(tonumber(sec) or 0) end return state() end

local function result(ok, why)
    local s = state()
    s.ok, s.why = ok and true or false, why
    return s
end

function api.bid(itemId, kind, to)
    if to == "" then to = nil end
    return result(sim.session:bid("You", tonumber(itemId), kind, { to = to }))
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
    local top = chain.state.undo[#chain.state.undo]
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
    for i = 1, 5 do a.engine:Append("main", "AddMember", { member = "Raider" .. i .. "-Realm" }) end
    lab.counter = 5
    lab.net:advance(4)
    lab.log = {}
    labLog("Four players are in sync. Try splitting the network, then writing at both ends.")
end

local function labState()
    if not lab then labReset() end
    -- the "majority" head: what most peers agree on (ties go to the longer chain)
    local tally = {}
    for _, p in ipairs(lab.peers) do
        local c = p.engine:Get("main")
        local h = c and c.head or "none"
        local t = tally[h] or { head = h, n = 0, len = c and #c.events or 0 }
        t.n = t.n + 1
        tally[h] = t
    end
    local best
    for _, t in pairs(tally) do
        if not best or t.n > best.n or (t.n == best.n and t.len > best.len) then best = t end
    end
    local majorityChain
    for _, p in ipairs(lab.peers) do
        local c = p.engine:Get("main")
        if c and c.head == best.head then majorityChain = c; break end
    end
    local out = { time = lab.net.time, inFlight = lab.net:inFlight(), stats = lab.net.stats, peers = {}, log = lab.log,
        drop = lab.net.dropRate, dup = lab.net.duplicateRate, split = lab.groups, canAdd = #lab.peers < #lab.names }
    for i, p in ipairs(lab.peers) do
        local c = p.engine:Get("main")
        local n = c and #c.events or 0
        local head = c and c.head or "none"
        local status = "in sync"
        if head ~= best.head then
            -- behind = our whole history is a prefix of the majority's; diverged = it split off
            status = (c == nil or (majorityChain and majorityChain.byId[head])) and "behind" or "diverged"
        end
        local order = {}
        if c then for j, m in ipairs(c.state.order) do if j <= 6 then order[#order + 1] = short(m) end end end
        local orphans = 0
        for _, o in ipairs(p.engine.db.orphans or {}) do orphans = orphans + #o.events end
        local st = p.sync:status()
        out.peers[i] = { index = i, name = p.name, count = n, head = head:sub(1, 8), status = status, order = order,
            members = c and #c.state.order or 0, pending = st.pending, blocked = st.blocked, rejected = st.rejected,
            orphans = orphans, restricted = p.restricted }
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

-- JS entry point: window.KG(name, a, b) -> JSON string.
js.global.KG = function(_, name, a, b)
    local fn = api[name]
    if not fn then return encode({ error = "no such call: " .. tostring(name) }) end
    local ok, res = pcall(fn, a, b)
    if not ok then return encode({ error = tostring(res) }) end
    return encode(res)
end
