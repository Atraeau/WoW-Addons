-- The live loot protocol: a Master Looter's session driven by other players' addons over the
-- simulated network, plus a raider without the addon who answers by whisper.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local LootNet, Loot = SK.modules.LootNet, SK.modules.Loot

local ADDON_USERS = { "Aldric", "Brann", "Cass" }
local ALL = { "Aldric", "Brann", "Cass", "Zed", "ML" } -- Zed has no addon; ML runs the session

local function build(cfgNet)
    local net = SimNetwork.New(cfgNet or { latency = 0.1, seed = 4 })
    local world = { net = net, players = {} }
    local seed = 0
    local function node(name)
        seed = seed + 1
        local client = MockClient.New({ name = name, realm = "Realm", seed = seed * 17 })
        client:setRaid(ALL, { leader = "ML", lootMethod = "master", masterLooter = "ML" })
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 30, firstHeartbeat = 5, firstJitter = 1 })
        net:attach(client)
        sync:start()
        return { client = client, engine = engine, sync = sync }
    end
    local ml = node("ML")
    ml.engine:CreateList("main", "Main")
    for _, n in ipairs { "Aldric", "Brann", "Cass", "Zed" } do ml.engine:Append("main", "AddMember", { member = n .. "-Realm" }) end
    world.ml, world.host = ml, LootNet.NewHost(ml.sync, ml.engine)
    for _, n in ipairs(ADDON_USERS) do
        local nd = node(n)
        nd.net = LootNet.NewPlayer(nd.sync)
        world.players[n] = nd
    end
    net:advance(1)
    return world
end

local function drop(world, n)
    local drops, items = {}, {}
    for i = 1, n do drops[i] = { link = "item:" .. i }; items[i] = { link = "item:" .. i, slot = i } end
    world.ml.client:dropLoot(drops)
    return items
end

local function order(world) return (table.concat(world.ml.engine:Get("main").state.order, ","):gsub("%-Realm", "")) end

H.section("LootNet: the live session protocol")
test("players receive the session, answer, and get the results", function()
    local w = build()
    local items = drop(w, 1)
    local seen = {}
    w.players.Aldric.net.on("session", function(s) seen.session = s end)
    w.players.Aldric.net.on("result", function(r) seen.result = r end)
    assert(w.host:start(items))
    w.net:advance(1)
    assert(seen.session, "Aldric's addon opened the session")
    eq(#seen.session.items, 1); eq(seen.session.items[1].link, "item:1"); eq(#seen.session.who, 5)

    w.players.Aldric.net:bid(1, "need"); w.players.Brann.net:bid(1, "pass"); w.players.Cass.net:bid(1, "pass")
    w.host.session:bid("ML", 1, "pass"); w.host.client:whisperFrom("Zed", "pass")
    w.net:advance(2)
    eq(w.host.session.phase, "review", "everyone answered, so bidding closed early")
    assert(w.host.session:confirm())
    w.net:advance(3)
    assert(seen.result, "results reached the player")
    eq(seen.result.awards[1].winner, "Aldric-Realm"); eq(seen.result.awards[1].tier, "main")
    eq(order(w), "Brann,Cass,Zed,ML,Aldric")
    eq(w.ml.client.given[1].to, "Aldric-Realm")
end)
test("everyone sees everyone's answers (public by design)", function()
    local w = build()
    assert(w.host:start(drop(w, 1)))
    w.net:advance(1)
    w.players.Aldric.net:bid(1, "need"); w.players.Brann.net:bid(1, "gift", "Cass")
    w.net:advance(3)
    local answers = w.players.Cass.net.session.answers
    eq(answers["Aldric-Realm"][1].kind, "need"); eq(answers["Brann-Realm"][1].kind, "gift"); eq(answers["Brann-Realm"][1].to, "Cass-Realm")
end)
test("a bid is acknowledged, and a refused bid says why", function()
    local w = build()
    assert(w.host:start(drop(w, 1)))
    w.net:advance(1)
    local acks = {}
    w.players.Aldric.net.on("ack", function(a) acks[#acks + 1] = a end)
    w.players.Aldric.net:bid(1, "need"); w.players.Aldric.net:bid(7, "need"); w.players.Aldric.net:bid(1, "gift")
    w.net:advance(2)
    eq(#acks, 3); assert(acks[1].ok); eq(acks[2].why, "noitem"); eq(acks[3].why, "badtarget")
end)
test("the draft is played live: turn is broadcast, the right player picks", function()
    local w = build()
    assert(w.host:start(drop(w, 2)))
    w.net:advance(1)
    local a, b = w.players.Aldric.net, w.players.Brann.net
    a:bid(1, "need"); a:bid(2, "need"); b:bid(1, "need"); b:bid(2, "pass")
    for _, n in ipairs { "Cass" } do w.players[n].net:bid(1, "pass"); w.players[n].net:bid(2, "pass") end
    w.host.session:bid("ML", 1, "pass"); w.host.session:bid("ML", 2, "pass")
    w.host.client:whisperFrom("Zed", "pass")
    w.net:advance(2)
    eq(w.host.session.phase, "main"); eq(w.host.session.turn.player, "Aldric-Realm")
    assert(a:myTurn(), "Aldric's addon knows it is his turn"); eq(#a:myTurn().options, 2)
    assert(not b:myTurn(), "Brann's does not"); eq(b.session.turn.player, "Aldric-Realm", "but Brann can see whose turn it is")

    local acks = {}
    b.on("ack", function(x) acks[#acks + 1] = x end)
    b:pick(1)                                  -- not Brann's turn
    a:pick(2)
    w.net:advance(2)
    eq(acks[1].ok, false); eq(acks[1].why, "notyourturn")
    eq(w.host.session.phase, "review")
    assert(w.host.session:confirm()); w.net:advance(2)
    eq(order(w), "Cass,Zed,ML,Aldric,Brann")
    eq(w.players.Cass.net.session.results.awards[1].tier, "main")
end)
test("a raider without the addon answers by whisper and gets a reply", function()
    local w = build()
    assert(w.host:start(drop(w, 1)))
    w.net:advance(1)
    w.host.client:whisperFrom("Zed", "need")
    local reply = w.ml.client.sent[#w.ml.client.sent]
    eq(reply.kind, "whisper"); eq(reply.target, "Zed-Realm"); assert(reply.text:find("Got it"))
    eq(w.host.session.bids["Zed-Realm"][1].kind, "need")
end)
test("only the Master Looter can open a session on a player's addon", function()
    local w = build()
    local before = w.players.Aldric.net.session
    w.players.Brann.sync:send({ t = "LS", sid = "forged", items = { { id = 1, link = "item:Evil" } }, who = {} }, "RAID")
    w.net:advance(2)
    eq(w.players.Aldric.net.session, before, "a forged session from a non-Master-Looter was ignored")
end)
test("a message from the wrong session or the wrong sender is ignored", function()
    local w = build()
    assert(w.host:start(drop(w, 1)))
    w.net:advance(1)
    local p = w.players.Aldric.net
    w.players.Brann.sync:send({ t = "LP", sid = p.session.sid, phase = "done" }, "RAID")   -- right session, wrong sender
    w.ml.sync:send({ t = "LP", sid = "other", phase = "done" }, "RAID")                    -- right sender, wrong session
    w.net:advance(2)
    eq(p.session.phase, "bidding")
end)
test("a bid for a session that is not running is refused", function()
    local w = build()
    local acks = {}
    w.players.Aldric.net.on("ack", function(a) acks[#acks + 1] = a end)
    assert(w.host:start(drop(w, 1))); w.net:advance(1)
    w.players.Aldric.net.session.sid = "stale"
    w.players.Aldric.net.session.host = "ML-Realm"
    w.players.Aldric.net:bid(1, "need")
    w.net:advance(2)
    eq(#acks, 0, "the host's refusal carries a different session id, so the player ignores it")
    eq(w.host.session.bids["Aldric-Realm"], nil)
end)
test("a player who joins late, or missed the start, catches up from the host's repeats", function()
    local w = build()
    local items = drop(w, 1)
    assert(w.host:start(items)); w.net:advance(1)
    w.players.Aldric.net:bid(1, "need"); w.net:advance(2)
    -- Cass never heard the announcement (as if she had just reloaded)
    w.players.Cass.net.session = nil
    w.net:advance(11)
    local s = w.players.Cass.net.session
    assert(s, "Cass picked the session up from the repeat"); eq(#s.items, 1)
    eq(s.answers["Aldric-Realm"][1].kind, "need", "and sees the answers so far")
    -- a repeat does not reset a player who already has the session
    local aldric = w.players.Aldric.net.session
    w.net:advance(11)
    eq(w.players.Aldric.net.session, aldric, "same session object, not replaced")
    -- the repeats stop when the session ends
    w.host.session:cancel(); w.net:advance(11)
    eq(w.host.beaconTimer, nil)
end)
test("a second session cannot start while one is running", function()
    local w = build()
    assert(w.host:start(drop(w, 1)))
    local ok, why = w.host:start(drop(w, 1)); assert(not ok); eq(why, "busy")
end)
