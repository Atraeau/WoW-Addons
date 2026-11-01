-- Versions: the addon's build number, and the protocol numbers that decide whether two players' addons can work together.
-- Releases are cut from every push, so players will run different builds at the same time.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local LootNet, Commands, RealClient = SK.modules.LootNet, SK.modules.Commands, SK.modules.RealClient

local seed = 0
local function node(name, net, build)
    seed = seed + 1
    local client = MockClient.New({ name = name, realm = "Realm", seed = seed * 101 })
    client:setRaid({ "ML", "A", "B", "C" }, { leader = "ML", lootMethod = "master", masterLooter = "ML" })
    if build then client:setAddonVersion(build) end
    local engine = Engine.New(client)
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    net:attach(client)
    sync:start()
    local nd = { name = name, full = name .. "-Realm", client = client, engine = engine, sync = sync }
    nd.player = LootNet.NewPlayer(sync)
    nd.cmd = Commands.New({ client = client, engine = engine, sync = sync, player = nd.player })
    return nd
end
local function text(nd) return table.concat(nd.client.printed, "\n") end
local function clear(nd) nd.client.printed = {} end
local function events(sync, name)
    local got = {}
    sync:on(name, function(e) got[#got + 1] = e end)
    return got
end

H.section("Versions: comparing builds")
test("builds compare numerically, part by part; a build that isn't numbers can't be compared", function()
    local cmp = Sync.CompareBuild
    eq(cmp("0.0.1.57", "0.0.1.60"), -1); eq(cmp("0.0.1.60", "0.0.1.57"), 1); eq(cmp("0.0.1.57", "0.0.1.57"), 0)
    eq(cmp("1.10", "1.9"), 1, "10 is more than 9, not less as text")
    eq(cmp("0.1", "0.1.0"), 0, "a missing part is zero")
    eq(cmp("dev", "0.0.1"), nil); eq(cmp("0.0.1", nil), nil); eq(cmp("", "0.0.1"), nil); eq(cmp("1.2-beta", "1.2"), nil)
end)

H.section("Versions: the client reports the addon's version")
test("the real client reads the TOC's version; none found means a development copy", function()
    local function realWith(env)
        local E = { GetTime = function() return 1 end, GetServerTime = function() return 1 end, GetNormalizedRealmName = function() return "Realm" end,
            UnitFullName = function() return "Me", "" end,
            CreateFrame = function() return { RegisterEvent = function() end, SetScript = function() end } end }
        for k, v in pairs(env) do E[k] = v end
        return RealClient.New({ env = E })
    end
    eq(realWith({ GetAddOnMetadata = function(addon, key) assert(addon == "KingsGambit" and key == "Version"); return "0.0.1.57" end }):addonVersion(), "0.0.1.57")
    eq(realWith({ C_AddOns = { GetAddOnMetadata = function() return "0.0.1.58" end } }):addonVersion(), "0.0.1.58", "the newer API wins when there is one")
    eq(realWith({}):addonVersion(), "dev")
    eq(realWith({ GetAddOnMetadata = function() return "" end }):addonVersion(), "dev")
end)

H.section("Versions: what the sync heartbeat says")
test("players learn each other's builds from heartbeats, and a newer build is announced once", function()
    local net = SimNetwork.New()
    local a, b = node("A", net, "0.0.1.57"), node("B", net, "0.0.1.60")
    local newer = events(a.sync, "newerBuild")
    net:advance(20)
    local seen = a.sync:peerVersions()
    eq(#seen, 1); eq(seen[1].name, "B-Realm"); eq(seen[1].build, "0.0.1.60"); eq(seen[1].protocol, Sync.PROTOCOL); eq(seen[1].relation, "newer")
    eq(b.sync:peerVersions()[1].relation, "older", "and from B's side, A is older")
    eq(#newer, 1, "announced once, not on every heartbeat"); eq(newer[1].peer, "B-Realm"); eq(newer[1].build, "0.0.1.60"); eq(newer[1].ours, "0.0.1.57")
    b.client:setAddonVersion("0.0.1.61")
    net:advance(20)
    eq(#newer, 2, "a still newer build is announced again")
end)

test("the same build, or a development copy, is not announced", function()
    local net = SimNetwork.New()
    local a, b, c = node("A", net, "0.0.1.57"), node("B", net, "0.0.1.57"), node("C", net) -- C is a development copy
    local newer = events(a.sync, "newerBuild")
    net:advance(20)
    eq(#newer, 0)
    local rel = {}
    for _, p in ipairs(a.sync:peerVersions()) do rel[p.name] = p.relation end
    eq(rel["B-Realm"], "same"); eq(rel["C-Realm"], "unknown")
end)

test("a heartbeat from before versions existed counts as protocol 1 and still works", function()
    local net = SimNetwork.New()
    local a = node("A", net, "0.0.1.57")
    assert(a.engine:CreateList("main", "Main"))
    a.sync:handle({ t = "H", c = { ["Z#00000001"] = { n = 5, h = "abc" } } }, "Z-Realm") -- no p, no a
    eq(a.sync:peerVersions()[1].protocol, 1); eq(a.sync:peerVersions()[1].relation, "unknown")
    assert(a.sync.waiting["Z#00000001"], "compatible: A asked for the chain Z has")
end)

test("a different sync protocol is announced once, and nothing is requested from that player", function()
    local net = SimNetwork.New()
    local a = node("A", net, "0.0.1.57")
    assert(a.engine:CreateList("main", "Main"))
    local incompatible = events(a.sync, "incompatible")
    local hb = { t = "H", c = { ["Z#00000001"] = { n = 5, h = "abc" } }, p = Sync.PROTOCOL + 1, a = "9.0.0.1" }
    a.sync:handle(hb, "Z-Realm"); a.sync:handle(hb, "Z-Realm")
    eq(#incompatible, 1, "once per player and protocol"); eq(incompatible[1].peer, "Z-Realm"); eq(incompatible[1].protocol, Sync.PROTOCOL + 1); eq(incompatible[1].ours, Sync.PROTOCOL)
    eq(a.sync.waiting["Z#00000001"], nil, "their chains are not requested")
    eq(a.sync:peerVersions()[1].relation, "incompatible"); eq(a.sync.stats.incompatible, 2)
    a.sync:handle({ t = "H", c = {}, p = Sync.PROTOCOL + 2 }, "Z-Realm")
    eq(#incompatible, 2, "a further protocol change is announced again")
end)

H.section("Versions: the loot session")
test("a Master Looter on another loot protocol is announced and its session ignored; no protocol field means 1", function()
    local net = SimNetwork.New()
    local p = node("A", net, "0.0.1.57")
    local got = events({ on = function(_, ev, fn) p.player.on(ev, fn) end }, "incompatible")
    local ls = { t = "LS", sid = "s1", items = { { id = 1, link = "item:1" } }, who = {}, p = LootNet.PROTOCOL + 1 }
    p.sync:handle(ls, "ML-Realm")
    p.sync:handle(ls, "ML-Realm")
    eq(#got, 1); eq(got[1].host, "ML-Realm"); eq(got[1].protocol, LootNet.PROTOCOL + 1)
    eq(p.player.session, nil, "the session was not opened")
    p.sync:handle({ t = "LS", sid = "s2", items = { { id = 1, link = "item:1" } }, who = {} }, "ML-Realm")
    assert(p.player.session and p.player.session.sid == "s2", "a session with no protocol field is protocol 1: accepted")
end)

H.section("Versions: the text interface")
test("version shows this build, the protocols, and what the others run; warnings appear on their own", function()
    local net = SimNetwork.New()
    local a, b, c = node("A", net, "0.0.1.57"), node("B", net, "0.0.1.60"), node("C", net, "0.0.1.40")
    clear(a)
    a.cmd.handle("version")
    assert(text(a):find("King's Gambit 0.0.1.57 (ledger format 2, sync protocol 1, loot protocol 1)", 1, true), text(a))
    assert(text(a):find("No other King's Gambit players seen yet", 1, true), text(a))
    clear(a)
    net:advance(20)
    assert(text(a):find("B runs King's Gambit 0.0.1.60, newer than yours (0.0.1.57)", 1, true), "the heads-up appeared by itself: " .. text(a))
    clear(a); a.cmd.handle("version")
    assert(text(a):find("B: 0.0.1.60 (newer than yours)", 1, true), text(a))
    assert(text(a):find("C: 0.0.1.40 (older than yours)", 1, true), text(a))
    clear(a)
    a.sync:handle({ t = "H", c = {}, p = 2, a = "2.0.0.1" }, "Dara-Realm")
    assert(text(a):find("Dara runs a King's Gambit this one can't talk to (sync protocol 2, yours 1)", 1, true), text(a))
    clear(a); a.cmd.handle("version")
    assert(text(a):find("Dara: 2.0.0.1, sync protocol 2. INCOMPATIBLE", 1, true), text(a))
    clear(a)
    a.sync:handle({ t = "LS", sid = "s9", items = {}, who = {}, p = 2 }, "ML-Realm")
    assert(text(a):find("The Master Looter (ML) runs a loot version this one can't talk to (protocol 2, yours 1)", 1, true), text(a))
end)
