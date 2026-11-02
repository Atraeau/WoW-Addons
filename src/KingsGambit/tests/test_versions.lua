-- Versions: Semantic Versioning, who may work with whom, and what players are told. Releases are cut from every push, so players
-- will run different builds at the same time; only a change that affects the shared ledger may require them to match.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local LootNet, Commands, RealClient, Version = SK.modules.LootNet, SK.modules.Commands, SK.modules.RealClient, SK.modules.Version

H.section("Version: reading and comparing (SemVer)")
test("a version is MAJOR.MINOR.PATCH with optional pre-release and build metadata; anything else is not one", function()
    local v = Version.Parse("1.2.3-beta.1+84")
    eq(v.major, 1); eq(v.minor, 2); eq(v.patch, 3); eq(v.pre[1], "beta"); eq(v.pre[2], 1); eq(v.build, "84")
    eq(Version.Parse("0.1.0").pre, nil); eq(Version.Parse("0.1.0+84").build, "84")
    for _, bad in ipairs { "dev", "", "1.2", "1.2.3.4", "01.2.3", "1.02.3", "1.2.3-", "1.2.3-a..b", "1.2.3-01", "1.2.3+", "v1.2.3", "1.2.3 beta" } do
        eq(Version.Parse(bad), nil, "not a version: '" .. bad .. "'")
    end
    eq(Version.Parse(nil), nil); eq(Version.Parse(5), nil)
end)

test("precedence follows the SemVer rules: numeric parts, pre-release below release, identifiers in order, build ignored", function()
    local c = Version.Compare
    eq(c("0.1.0", "0.1.1"), -1); eq(c("1.10.0", "1.9.0"), 1, "numbers, not text"); eq(c("2.0.0", "1.99.99"), 1); eq(c("1.2.3", "1.2.3"), 0)
    eq(c("0.1.0+84", "0.1.0+99"), 0, "build metadata never changes precedence")
    -- the example ordering from semver.org, item 11
    local order = { "1.0.0-alpha", "1.0.0-alpha.1", "1.0.0-alpha.beta", "1.0.0-beta", "1.0.0-beta.2", "1.0.0-beta.11", "1.0.0-rc.1", "1.0.0" }
    for i = 1, #order - 1 do
        eq(c(order[i], order[i + 1]), -1, order[i] .. " < " .. order[i + 1])
        eq(c(order[i + 1], order[i]), 1)
    end
    eq(c("dev", "1.0.0"), nil); eq(c("1.0.0", nil), nil)
end)

test("two versions are on the same line when they share MAJOR, or MAJOR.MINOR while MAJOR is 0", function()
    eq(Version.Line("1.4.2"), "1"); eq(Version.Line("0.3.7"), "0.3"); eq(Version.Line("0.0.1"), "0.0"); eq(Version.Line("2.0.0-rc.1+9"), "2")
    eq(Version.Line("dev"), nil)
    local function rel(a, b) return Version.Relation(a, b) end
    -- same line: compatible whatever else differs, and order says who is newer
    local r = rel("1.2.0", "1.7.3"); assert(r.compatible and r.known); eq(r.order, 1)
    r = rel("1.7.3", "1.2.0"); assert(r.compatible); eq(r.order, -1)
    r = rel("0.3.1+10", "0.3.9+99"); assert(r.compatible); eq(r.order, 1, "0.x: the same MINOR is the same line")
    r = rel("1.2.0", "1.2.0-beta.1"); assert(r.compatible); eq(r.order, -1, "a pre-release is on the same line, and older")
    r = rel("2.0.0", "2.0.0+5"); assert(r.compatible); eq(r.order, 0)
    -- another line: not compatible, and the one on the older line has to update
    r = rel("1.9.0", "2.0.0"); assert(not r.compatible and r.known); eq(r.mustUpdate, "us"); eq(r.line, "2"); eq(r.ourLine, "1")
    r = rel("2.0.0", "1.9.9"); assert(not r.compatible); eq(r.mustUpdate, "them")
    r = rel("0.3.0", "0.4.0"); assert(not r.compatible); eq(r.mustUpdate, "us", "while MAJOR is 0, a new MINOR is a new line")
    r = rel("0.4.0", "0.3.9"); assert(not r.compatible); eq(r.mustUpdate, "them")
    r = rel("0.9.0", "1.0.0"); assert(not r.compatible); eq(r.mustUpdate, "us")
    -- what can't be read is let through
    r = rel("0.1.0", "dev"); assert(r.compatible and not r.known)
    r = rel("0.1.0", nil); assert(r.compatible and not r.known)
    r = rel("dev", "0.1.0"); assert(r.compatible and not r.known)
    r = rel("0.1.0", "0.1.0.84"); assert(r.compatible and not r.known, "a four-part build from before SemVer can't be read")
end)

H.section("Version: the client reports the addon's version")
test("the real client reads the TOC's version; none found means a development copy", function()
    local function realWith(env)
        local E = { GetTime = function() return 1 end, GetServerTime = function() return 1 end, GetNormalizedRealmName = function() return "Realm" end,
            UnitFullName = function() return "Me", "" end,
            CreateFrame = function() return { RegisterEvent = function() end, SetScript = function() end } end }
        for k, v in pairs(env) do E[k] = v end
        return RealClient.New({ env = E })
    end
    eq(realWith({ GetAddOnMetadata = function(addon, key) assert(addon == "KingsGambit" and key == "Version"); return "0.1.0+57" end }):addonVersion(), "0.1.0+57")
    eq(realWith({ C_AddOns = { GetAddOnMetadata = function() return "0.1.1+58" end } }):addonVersion(), "0.1.1+58", "the newer API wins when there is one")
    eq(realWith({}):addonVersion(), "dev")
    eq(realWith({ GetAddOnMetadata = function() return "" end }):addonVersion(), "dev")
end)

local seed = 0
local function node(name, net, build)
    seed = seed + 1
    local client = MockClient.New({ name = name, seed = seed * 101 })
    client:setRaid({ "ML", "A", "B", "C" }, { leader = "ML", lootMethod = "master", masterLooter = "ML" })
    if build then client:setAddonVersion(build) end
    local engine = Engine.New(client)
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    net:attach(client)
    sync:start()
    local nd = { name = name, full = name, client = client, engine = engine, sync = sync }
    nd.player = LootNet.NewPlayer(sync)
    nd.cmd = Commands.New({ client = client, engine = engine, sync = sync, player = nd.player })
    return nd
end
local function text(nd) return table.concat(nd.client.printed, "\n") end
local function clear(nd) nd.client.printed = {} end
local function events(emitter, name)
    local got = {}
    emitter:on(name, function(e) got[#got + 1] = e end)
    return got
end
local function fp(nd) return nd.engine:Fingerprint() or "none" end

H.section("Version: what the sync heartbeat says")
test("players on the same line but different versions keep sharing the ledger; a newer one is announced once, optionally", function()
    local net = SimNetwork.New()
    local a, b = node("A", net, "0.1.0+57"), node("B", net, "0.1.3+60")
    local newer = events(a.sync, "newerBuild")
    assert(a.engine:CreateList("main", "Main")); assert(a.engine:Append("main", "AddMember", { member = "X" }))
    net:advance(20)
    eq(fp(a), fp(b), "different versions, same ledger")
    local seen = a.sync:peerVersions()
    eq(#seen, 1); eq(seen[1].name, "B"); eq(seen[1].build, "0.1.3+60"); eq(seen[1].relation, "newer")
    eq(b.sync:peerVersions()[1].relation, "older")
    eq(#newer, 1, "announced once, not on every heartbeat"); eq(newer[1].peer, "B"); eq(newer[1].ours, "0.1.0+57")
    b.client:setAddonVersion("0.1.4+61")
    net:advance(20)
    eq(#newer, 2, "a still newer version is announced again")
    eq(fp(a), fp(b))
end)

test("the same version, a different build of it, and a development copy are not announced", function()
    local net = SimNetwork.New()
    local a, b, c = node("A", net, "0.1.0+57"), node("B", net, "0.1.0+99"), node("C", net) -- C is a development copy
    local newer = events(a.sync, "newerBuild")
    net:advance(20)
    eq(#newer, 0)
    local rel = {}
    for _, p in ipairs(a.sync:peerVersions()) do rel[p.name] = p.relation end
    eq(rel["B"], "same", "build metadata is not a difference"); eq(rel["C"], "unknown")
end)

test("a heartbeat with no readable version (older build) is let through and still works", function()
    local net = SimNetwork.New()
    local a = node("A", net, "0.1.0+57")
    assert(a.engine:CreateList("main", "Main"))
    a.sync:handle({ t = "H", c = { ["Z#00000001"] = { n = 5, h = "abc" } }, p = 1, a = "0.0.1.84" }, "Z") -- the old four-part build and its old protocol field
    eq(a.sync:peerVersions()[1].relation, "unknown")
    assert(a.sync.waiting["Z#00000001"], "compatible: A asked for the chain Z has")
end)

test("another line is announced once, says who must update, and nothing from that player is acted on", function()
    local net = SimNetwork.New()
    local a = node("A", net, "0.1.0+57")
    assert(a.engine:CreateList("main", "Main"))
    local incompatible = events(a.sync, "incompatible")
    local hb = { t = "H", c = { ["Z#00000001"] = { n = 5, h = "abc" } }, a = "0.2.0+3" }
    a.sync:handle(hb, "Z"); a.sync:handle(hb, "Z")
    eq(#incompatible, 1, "once per player and version")
    eq(incompatible[1].peer, "Z"); eq(incompatible[1].build, "0.2.0+3"); eq(incompatible[1].mustUpdate, "us"); eq(incompatible[1].line, "0.2"); eq(incompatible[1].ourLine, "0.1")
    eq(a.sync.waiting["Z#00000001"], nil, "their chains are not requested")
    eq(a.sync:peerVersions()[1].relation, "incompatible")
    -- their live events are dropped too, not applied
    local before = #a.engine:Get("main").events
    local ev = { v = 2, type = "AddMember", list = "main", data = { member = "Evil" } }
    a.sync:handle({ t = "E", c = "Z#00000001", n = 1, events = { ev } }, "Z")
    eq(#a.engine:Get("main").events, before, "nothing applied"); assert(a.sync.stats.incompatible >= 3)
    -- when they update to our line they are accepted again
    a.sync:handle({ t = "H", c = {}, a = "0.1.2+8" }, "Z")
    eq(a.sync:peerVersions()[1].relation, "newer")
    -- and an older line is told they must update
    a.sync:handle({ t = "H", c = {}, a = "0.0.9" }, "Y")
    eq(incompatible[2].peer, "Y"); eq(incompatible[2].mustUpdate, "them")
end)

test("two players on different lines don't share a ledger; one update puts them back in step", function()
    local net = SimNetwork.New()
    local a, b = node("A", net, "0.1.0+57"), node("B", net, "0.2.0+3")
    assert(a.engine:CreateList("main", "Main")); assert(a.engine:Append("main", "AddMember", { member = "X" }))
    net:advance(30)
    assert(fp(a) ~= fp(b), "B never receives A's ledger")
    b.client:setAddonVersion("0.1.5+70")
    net:advance(30)
    eq(fp(a), fp(b), "once on the same line they converge")
end)

H.section("Version: the loot session")
test("a Master Looter on another line is announced and its session ignored; the same line, or no version, is accepted", function()
    local net = SimNetwork.New()
    local p = node("A", net, "0.1.0+57")
    local got = events({ on = function(_, ev, fn) p.player.on(ev, fn) end }, "incompatible")
    local ls = { t = "LS", sid = "s1", items = { { id = 1, link = "item:1" } }, who = {}, a = "0.2.0+1" }
    p.sync:handle(ls, "ML"); p.sync:handle(ls, "ML")
    eq(#got, 1); eq(got[1].host, "ML"); eq(got[1].build, "0.2.0+1"); eq(got[1].mustUpdate, "us")
    eq(p.player.session, nil, "the session was not opened")
    p.sync:handle({ t = "LS", sid = "s2", items = { { id = 1, link = "item:1" } }, who = {}, a = "0.1.9+4" }, "ML")
    assert(p.player.session and p.player.session.sid == "s2", "a different version on the same line is fine")
    local q = node("B", net, "0.1.0+57")
    q.sync:handle({ t = "LS", sid = "s3", items = {}, who = {} }, "ML")
    assert(q.player.session, "no version at all: let through")
end)

H.section("Version: the text interface")
test("version shows this build, its line and what the others run; warnings appear on their own", function()
    local net = SimNetwork.New()
    local a, b, c = node("A", net, "0.1.0+57"), node("B", net, "0.1.3+60"), node("C", net, "0.1.0+40")
    clear(a)
    a.cmd.handle("version")
    assert(text(a):find("King's Gambit 0.1.0+57 (works with 0.1.x", 1, true), text(a))
    assert(text(a):find("No other King's Gambit players seen yet", 1, true), text(a))
    clear(a)
    net:advance(20)
    assert(text(a):find("B runs King's Gambit 0.1.3+60, newer than yours (0.1.0+57). An update is available; it is not required.", 1, true), "the heads-up appeared by itself: " .. text(a))
    clear(a); a.cmd.handle("version")
    assert(text(a):find("B: 0.1.3+60 (newer than yours, compatible)", 1, true), text(a))
    assert(text(a):find("C: 0.1.0+40 (same as yours)", 1, true), text(a))
    clear(a)
    a.sync:handle({ t = "H", c = {}, a = "0.2.0+1" }, "Dara")
    assert(text(a):find("Dara runs King's Gambit 0.2.0+1, which this version (0.1.0+57) can't work with: update King's Gambit", 1, true), text(a))
    a.sync:handle({ t = "H", c = {}, a = "0.0.9" }, "Old")
    assert(text(a):find("Old runs King's Gambit 0.0.9, an older line than yours (0.1.x)", 1, true), text(a))
    clear(a); a.cmd.handle("version")
    assert(text(a):find("Dara: 0.2.0+1. INCOMPATIBLE: they are on 0.2.x, you are on 0.1.x; you must update", 1, true), text(a))
    assert(text(a):find("Old: 0.0.9. INCOMPATIBLE: they are on 0.0.x, you are on 0.1.x; they must update", 1, true), text(a))
    clear(a)
    a.sync:handle({ t = "LS", sid = "s9", items = {}, who = {}, a = "0.2.0+1" }, "ML")
    assert(text(a):find("ML runs King's Gambit 0.2.0+1, which this version (0.1.0+57) can't work with", 1, true), text(a))
    assert(text(a):find("They are the Master Looter: you won't see their loot sessions", 1, true), text(a))
end)
