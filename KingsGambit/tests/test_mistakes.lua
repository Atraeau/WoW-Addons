-- Mistakes: what happens when people get it wrong, and whether the Master Looter can put it right fairly and simply.
-- Each case is played through the text interface over the simulated network, the way a guild would meet it.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local LootNet, Commands, Requests = SK.modules.LootNet, SK.modules.Commands, SK.modules.Requests

local function text(node) return table.concat(node.client.printed, "\n") end
local function clear(node) node.client.printed = {} end

local function settle(w, limit)
    for _ = 1, (limit or 120) do
        w.net:advance(1)
        local fp, same = nil, true
        for _, nd in pairs(w.nodes) do
            fp = fp or nd.engine:Fingerprint()
            if nd.engine:Fingerprint() ~= fp then same = false end
        end
        if same then return true end
    end
    return false
end

-- The guild from test_requests: GM, an officer, a Master Looter (Looter), raiders Aldric, Brann and Cass.
local NAMES = { "GM", "Off", "Looter", "Aldric", "Brann", "Cass" }
local function guild()
    local net = SimNetwork.New({ latency = 0.1, seed = 7 })
    local w = { net = net, nodes = {} }
    local function build(n, client)
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 10, firstHeartbeat = 1, firstJitter = 1 })
        net:attach(client); sync:start()
        local nd = { name = n, full = n .. "-Realm", client = client, engine = engine, sync = sync }
        nd.requests = Requests.New(sync, engine)
        if n == "Looter" then nd.host = LootNet.NewHost(sync, engine) else nd.player = LootNet.NewPlayer(sync) end
        nd.cmd = Commands.New({ client = client, engine = engine, sync = sync, host = nd.host, player = nd.player, requests = nd.requests })
        return nd
    end
    for i, n in ipairs(NAMES) do
        local client = MockClient.New({ name = n, realm = "Realm", seed = i * 31 })
        client:setRaid(NAMES, { leader = "GM", lootMethod = "master", masterLooter = "Looter" })
        w.nodes[n] = build(n, client)
        w[n] = w.nodes[n]
    end
    function w.reload(n)
        local old = w.nodes[n]
        old.sync:stop()
        local nd = build(n, old.client:reload())
        w.nodes[n], w[n] = nd, nd
        return nd
    end
    w.GM.cmd.handle("create main")
    for _, n in ipairs { "Aldric", "Brann", "Cass", "Looter" } do w.GM.cmd.handle("add " .. n) end
    w.GM.cmd.handle("officers set Off")
    assert(settle(w), "the guild's ledgers agree")
    for _, nd in pairs(w.nodes) do clear(nd) end
    return w
end

local function order(nd) return (table.concat(nd.engine:Get("main").state.order, ","):gsub("%-Realm", "")) end
local function everyone(w, fn) for _, n in ipairs(NAMES) do fn(w.nodes[n]) end end
local function openRaid(w)
    w.Off.cmd.handle("raid open Looter 4")
    w.net:advance(3)
end
local function events(nd, type_)
    local out = {}
    for _, ev in ipairs(nd.engine:Get("main").events) do if not type_ or ev.type == type_ then out[#out + 1] = ev end end
    return out
end

H.section("Mistakes: recording the right winner after the fact")
test("award: the Master Looter records the real winner, who drops to the bottom as if they had won the bid", function()
    local w = guild(); openRaid(w)
    w.Looter.cmd.handle("award Aldric Gauntlets he won the roll but the hand-out failed")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Cass,Looter,Aldric", nd.name) end)
    local ev = events(w.GM, "Award")[1]
    eq(ev.author, "Looter-Realm"); eq(ev.data.member, "Aldric-Realm"); eq(ev.data.reason, "he won the roll but the hand-out failed")
    assert(text(w.Looter):find("Aldric won Gauntlets and moves to the bottom"), text(w.Looter))
    clear(w.Cass); w.Cass.cmd.handle("history 1")
    assert(text(w.Cass):find("Aldric won Gauntlets"), text(w.Cass)); assert(text(w.Cass):find("hand%-out failed"), text(w.Cass))
end)

test("award needs a reason, a real member, and someone allowed to write", function()
    local w = guild(); openRaid(w)
    w.Looter.cmd.handle("award Aldric Gauntlets"); assert(text(w.Looter):find("award <name> <item> <reason>", 1, true), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("award Zed Gauntlets he is new")
    assert(text(w.Looter):find("Zed is not on the list"), text(w.Looter)); assert(text(w.Looter):find("add Zed", 1, true), text(w.Looter))
    eq(#events(w.Looter, "Award"), 0)
    clear(w.Off); w.Off.cmd.handle("award Aldric Gauntlets x")
    assert(text(w.Off):find("only its Master Looter"), text(w.Off)); assert(text(w.Off):find("request award", 1, true), text(w.Off))
    eq(order(w.GM), "Aldric,Brann,Cass,Looter", "nothing changed")
end)

test("the wrong winner put right in two steps: undo, then award, with the reasons on the record", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Gauntlets" }))
    w.net:advance(2)
    eq(order(w.Looter), "Aldric,Cass,Looter,Brann")
    w.Looter.cmd.handle("undo yes")
    w.Looter.cmd.handle("award Aldric Gauntlets Aldric had the higher need bid; Brann agreed")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Cass,Looter,Aldric", nd.name) end)
end)

H.section("Mistakes: undoing one award of several")
test("undo <name>: the first of three wrong, fixed alone, then the right winner recorded; nobody else is disturbed", function()
    local w = guild(); openRaid(w)
    for _, p in ipairs { "Brann", "Cass", "Looter" } do assert(w.Looter.engine:Append("main", "Award", { member = p .. "-Realm", item = "Item-" .. p })) end
    w.net:advance(2)
    eq(order(w.Looter), "Aldric,Brann,Cass,Looter")
    clear(w.Looter); w.Looter.cmd.handle("undo")
    assert(text(w.Looter):find("Looter's award", 1, true) and text(w.Looter):find("undo <name>", 1, true), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("undo Brann")
    assert(text(w.Looter):find("This would undo Brann's award of Item-Brann", 1, true), text(w.Looter))
    assert(text(w.Looter):find("Awards made since stay as they are", 1, true)); assert(text(w.Looter):find("undo Brann yes", 1, true), text(w.Looter))
    eq(order(w.Looter), "Aldric,Brann,Cass,Looter", "asking changed nothing")
    w.Looter.cmd.handle("undo Brann yes")
    w.Looter.cmd.handle("award Aldric Item-Brann Aldric had the higher bid")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Cass,Looter,Aldric", nd.name) end)
end)

test("undo <name> explains when that player's award can't be undone, and what can", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Belt" }))
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Ring" }))
    clear(w.Looter); w.Looter.cmd.handle("undo Cass yes")
    assert(text(w.Looter):find("Cass has no award of yours that can be undone", 1, true), text(w.Looter))
    assert(text(w.Looter):find("Brann won Ring", 1, true), text(w.Looter))
    -- Brann's latest is the one named: the earlier Belt stays until the Ring goes.
    w.Looter.cmd.handle("undo Brann yes"); w.Looter.cmd.handle("undo Brann yes")
    eq(order(w.Looter), "Aldric,Brann,Cass,Looter")
end)

test("undo of a player who has since left the list is explained, not a crash", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Belt" }))
    assert(w.Looter.engine:Append("main", "RemoveMember", { member = "Brann-Realm", reason = "left the guild" }))
    clear(w.Looter); w.Looter.cmd.handle("undo yes")
    eq(order(w.Looter), "Aldric,Cass,Looter")
    assert(not text(w.Looter):find("stack traceback"), text(w.Looter))
end)

H.section("Mistakes: a manual correction says where the player was")
test("remove and move tell the Master Looter the old place, so a mistake can be put back", function()
    local w = guild(); openRaid(w)
    clear(w.Looter); w.Looter.cmd.handle("move Cass top tester")
    assert(text(w.Looter):find("was place 3", 1, true), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("remove Brann gone by mistake")
    assert(text(w.Looter):find("at place 3", 1, true), text(w.Looter))
    assert(text(w.Looter):find("add Brann", 1, true), text(w.Looter))
end)

H.section("Mistakes: during and around a session")
-- A raid with one item dropped and a session started; Aldric needs it, the rest pass.
local function session(w, nitems)
    openRaid(w)
    w.Looter.cmd.handle("disenchanter Cass")
    local drops = {}
    for i = 1, (nitems or 1) do drops[i] = { link = "Gauntlets" .. i } end
    w.Looter.client:dropLoot(drops)
    clear(w.Looter); w.Looter.cmd.handle("loot")
    assert(text(w.Looter):find("Loot session started"), text(w.Looter))
    w.net:advance(2)
    return w.Looter.host.session
end
local function answer(w, n, kind, item) w[n].cmd.handle(kind .. " " .. (item or 1)); w.net:advance(1) end
-- Everyone in the raid answers item 1: `kinds` says what each named player says; everyone else passes.
local function allAnswer(w, kinds, item)
    for _, n in ipairs(NAMES) do answer(w, n, kinds[n] or "pass", item) end
end

test("cancel writes nothing, a second cancel is harmless, and the same loot can be run again", function()
    local w = guild(); local s = session(w)
    allAnswer(w, { Aldric = "need" })
    eq(s.phase, "review")
    w.Looter.cmd.handle("cancel"); w.net:advance(2)
    eq(s.phase, "cancelled"); eq(#events(w.Looter, "Award"), 0); eq(order(w.Looter), "Aldric,Brann,Cass,Looter,GM,Off")
    clear(w.Looter); w.Looter.cmd.handle("cancel")
    assert(text(w.Looter):find("No loot session is running"), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("loot")
    assert(text(w.Looter):find("Loot session started"), text(w.Looter))
    local s2 = w.Looter.host.session
    assert(s2 ~= s); eq(s2.phase, "bidding", "everyone answers afresh")
end)

test("confirming twice records the award once", function()
    local w = guild(); local s = session(w)
    allAnswer(w, { Aldric = "need" })
    w.Looter.cmd.handle("confirm"); w.net:advance(2)
    clear(w.Looter); w.Looter.cmd.handle("confirm")
    eq(#events(w.Looter, "Award"), 1); eq(order(w.Looter), "Brann,Cass,Looter,GM,Off,Aldric")
    assert(not text(w.Looter):find("Confirmed and recorded"), "the second confirm does not claim to have recorded anything: " .. text(w.Looter))
end)

test("a player who answered wrongly can change it until bidding closes; after that the Master Looter cancels and reruns", function()
    local w = guild(); local s = session(w)
    answer(w, "Brann", "pass"); answer(w, "Brann", "need")
    eq(s.bids["Brann-Realm"][1].kind, "need", "the last answer counts")
    for _, n in ipairs { "GM", "Off", "Aldric", "Cass", "Looter" } do answer(w, n, "pass") end
    eq(s.phase, "review"); eq(s.items[1].winner, "Brann-Realm")
    clear(w.Aldric); w.Aldric.cmd.handle("need 1"); w.net:advance(2)
    assert(text(w.Aldric):find("closed") or text(w.Aldric):find("too late"), "a late answer is explained, not silently dropped: [" .. text(w.Aldric) .. "]")
    eq(s.items[1].winner, "Brann-Realm", "a late answer changes nothing")
end)

test("the raid ends before the Master Looter confirms: nothing is handed over that could not be recorded", function()
    local w = guild(); local s = session(w)
    allAnswer(w, { Aldric = "need" })
    eq(s.phase, "review")
    w.Off.cmd.handle("raid revoke Looter"); w.net:advance(3)
    clear(w.Looter); w.Looter.cmd.handle("confirm"); w.net:advance(2)
    eq(#w.Looter.client.given, 0, "no item left the loot window")
    eq(#events(w.GM, "Award"), 0)
    assert(text(w.Looter):find("Nothing was handed out or recorded, and the session is still waiting", 1, true), text(w.Looter))
    eq(s.phase, "review", "the session waits; nothing is lost")
    w.Off.cmd.handle("raid open Looter 4"); w.net:advance(3)
    clear(w.Looter); w.Looter.cmd.handle("confirm"); w.net:advance(2)
    assert(text(w.Looter):find("Confirmed and recorded"), text(w.Looter))
    eq(#events(w.GM, "Award"), 1, "once the raid is open again the same session confirms")
end)

test("a hand-out that fails is not recorded; the Master Looter fixes it with award, and the winner pays then", function()
    local w = guild(); local s = session(w, 2)
    for _, n in ipairs(NAMES) do
        answer(w, n, n == "Aldric" and "need" or "pass", 1)
        answer(w, n, n == "Brann" and "need" or "pass", 2)
    end
    eq(s.phase, "review")
    assert(w.Looter.client:give(2, "Cass-Realm"), "someone grabbed slot 2 from the window")
    clear(w.Looter); w.Looter.cmd.handle("confirm"); w.net:advance(3)
    assert(text(w.Looter):find("NOT recorded"), text(w.Looter))
    eq(#events(w.GM, "Award"), 1, "only the item that was really handed over")
    eq(order(w.GM), "Brann,Cass,Looter,GM,Off,Aldric")
    w.Looter.cmd.handle("award Brann Gauntlets2 it was taken from the window by mistake; handed over by trade")
    w.net:advance(3)
    eq(order(w.GM), "Cass,Looter,GM,Off,Aldric,Brann", "Brann pays for it now, as if he had won it in the session")
end)

test("the Master Looter reloads mid-session: nothing was recorded, and the loot can be run again", function()
    local w = guild(); local s = session(w)
    answer(w, "Aldric", "need")
    local looter = w.reload("Looter"); w.net:advance(3)
    eq(looter.host.session, nil, "the session did not survive the reload")
    eq(#events(looter, "Award"), 0); eq(order(looter), "Aldric,Brann,Cass,Looter,GM,Off")
    clear(looter); looter.client:dropLoot({ { link = "Gauntlets1" } })
    looter.cmd.handle("loot")
    assert(text(looter):find("Loot session started"), text(looter))
end)

H.section("Mistakes: the item went to someone else after the award")
test("trade: the Master Looter restores the winner and the real recipient pays, as one entry", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Gauntlets" }))
    assert(w.Looter.engine:Append("main", "Award", { member = "Aldric-Realm", item = "Ring" }))
    w.net:advance(2); eq(order(w.Looter), "Cass,Looter,Brann,Aldric")
    clear(w.Looter); w.Looter.cmd.handle("trade Brann Cass he traded it to her at the door")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Looter,Aldric,Cass", nd.name) end)
    assert(text(w.Looter):find("Brann is back in their place and Cass moves to the bottom", 1, true), text(w.Looter))
    local ev = events(w.GM, "Award"); ev = ev[#ev]
    eq(ev.data.member, "Cass-Realm"); eq(ev.data.replaces ~= nil, true); eq(#events(w.GM, "Revert"), 0, "one entry, not two")
    clear(w.Cass); w.Cass.cmd.handle("history 1")
    assert(text(w.Cass):find("Cass took Gauntlets, which had been recorded for Brann", 1, true), text(w.Cass))
end)

test("trade is explained when it can't be done, and changes nothing", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Gauntlets" }))
    clear(w.Looter); w.Looter.cmd.handle("trade Cass Aldric no award"); assert(text(w.Looter):find("Cass has no award of yours"), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("trade Brann Zed no such raider"); assert(text(w.Looter):find("Zed is not on the list"), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("trade Brann Brann same person"); assert(text(w.Looter):find("Not recorded"), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("trade Brann Aldric"); assert(text(w.Looter):find("trade <name> <to> <reason>", 1, true), text(w.Looter))
    eq(order(w.Looter), "Aldric,Cass,Looter,Brann", "nothing moved")
end)

test("request trade: the raider asks, the Master Looter accepts; request gift is the explicit case and moves nobody", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Gauntlets" }))
    assert(w.Looter.engine:Append("main", "Award", { member = "Cass-Realm", item = "Ring" }))
    w.net:advance(2); eq(order(w.GM), "Aldric,Looter,Brann,Cass")
    w.Brann.cmd.handle("request trade Brann Aldric I sold it to him in the raid")
    w.net:advance(2)
    assert(text(w.Looter):find("restore Brann, Aldric moves to the bottom", 1, true), text(w.Looter))
    w.Looter.cmd.handle("accept 1"); w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Looter,Cass,Aldric", nd.name) end)
    -- now the explicit case: Cass deliberately gave her Ring to Looter: nobody moves
    w.Cass.cmd.handle("request gift Cass Looter a deliberate gift"); w.net:advance(2)
    w.Looter.cmd.handle("accept 2"); w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Looter,Cass,Aldric", nd.name) end)
end)
