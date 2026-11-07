-- Stored ledgers: listing, retiring, restoring, expiry, and the officers' retirement notices over sync (Ledgers.lua).
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork, Ledgers, Commands = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork, SK.modules.Ledgers, SK.modules.Commands

local function world(id, name, extra)
    local events = { { id = id, type = "Genesis", ts = 1000, data = { name = name }, ledger = "" }, { id = id .. "L", type = "CreateList", ts = 2000, data = { name = "Main" }, list = "main" } }
    for i = 1, (extra or 0) do events[#events + 1] = { id = id .. i, type = "AddMember", ts = 3000 + i, data = {}, list = "main" } end
    return { ledger = { chains = { ["c" .. id] = { events = events } } }, mine = { Me = "c" .. id } }
end

H.section("Stored ledgers")
test("every stored ledger is listed with what it holds; an empty world is listed too", function()
    local db = { worlds = {
        ["mode15-Alliance-guild:blue parse"] = world("aaa", "Guild ledger", 3),
        ["mode18-Horde-guild:gray parse"] = world("bbb", "Guild ledger"),
        ["mode15-Alliance-solo:Me_Self"] = {} } }
    local rows = Ledgers.Stored(db, "mode18-Horde-guild:gray parse")
    eq(#rows, 3)
    eq(rows[1].key, "mode15-Alliance-guild:blue parse"); eq(rows[1].events, 5); eq(rows[1].lists, 1); eq(rows[1].id, "aaa"); eq(rows[1].faction, "Alliance")
    assert(rows[3].open and not rows[1].open)
    eq(rows[2].id, nil); eq(rows[2].kind, "solo")
    local d = Ledgers.Describe(rows[1], 3004 + 86400 * 2)
    eq(d.title, "Blue Parse (Alliance)"); assert(d.detail:find("last entry 2 days ago"), d.detail)
end)

test("retiring removes the stored data and keeps a tombstone; the open ledger goes at the next login; a world with no ledger just goes", function()
    local db = { worlds = { ["mode15-Alliance-guild:blue parse"] = world("aaa", "G"), ["mode18-Horde-guild:gray parse"] = world("bbb", "G"), ["mode15-Alliance-solo:Me_Self"] = {} } }
    local open = "mode18-Horde-guild:gray parse"
    local ok, t, later = Ledgers.Retire(db, "mode15-Alliance-guild:blue parse", "Me", 5000, open)
    assert(ok and not later); eq(db.worlds["mode15-Alliance-guild:blue parse"], nil); eq(t.id, "aaa"); assert(Ledgers.IsRetired(db, "aaa"))
    ok, t, later = Ledgers.Retire(db, open, "Me", 5000, open)
    assert(ok and later and db.worlds[open], "the open ledger stays until the next login"); assert(Ledgers.IsRetired(db, "bbb"))
    ok, t = Ledgers.Retire(db, "mode15-Alliance-solo:Me_Self", "Me", 5000, open)
    assert(ok and t == nil and not db.worlds["mode15-Alliance-solo:Me_Self"])
    local gone = Ledgers.Sweep(db, 5001)
    eq(#gone, 1); eq(gone[1].key, open); eq(db.worlds[open], nil)
    local rows = Ledgers.Stored(db, nil)
    eq(#rows, 2, "both retired ledgers are still listed, as removed"); assert(not rows[1].held)
    eq((Ledgers.Retire(db, "nope", "Me", 1, nil)), false)
end)

test("keep restores a retirement; a restored one is forgotten after a while", function()
    local db = { worlds = { k = world("aaa", "G") } }
    Ledgers.Retire(db, "k", "Me", 100, "other")
    assert(Ledgers.Keep(db, "aaa", 200)); assert(not Ledgers.IsRetired(db, "aaa"))
    eq(Ledgers.Keep(db, "aaa", 300), nil, "nothing to restore twice")
    Ledgers.Sweep(db, 200 + Ledgers.PRUNE + 500)
    eq(db.retired.aaa, nil, "forgotten")
end)

H.section("Retirement notices (sync)")
local function peer(name, net, db, key, o)
    o = o or {}
    local client = MockClient.New({ name = name, seed = 7 })
    client.storage = function() return { account = db.worlds[key], char = {}, shared = db, world = key } end
    client.world = function() return key end
    if o.officer == false then client:setOfficers({ "Boss" }) end
    local engine = Engine.New(client)
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    net:attach(client)
    sync:start()
    return { client = client, engine = engine, sync = sync, db = db }
end

test("an officer's retirement reaches the others once; they can let it expire or restore it; nobody re-fetches a retired ledger", function()
    local net = SimNetwork.New()
    local key = "mode15-Alliance-guild:blue parse"
    local a = peer("Boss", net, { worlds = { [key] = {} } }, key)
    assert(a.engine:CreateList("main", "Main"))
    net:advance(3)
    local id = a.engine:LedgerId()
    local b = peer("Aide", net, { worlds = { [key] = {} } }, key)
    net:advance(10)
    eq(b.engine:LedgerId(), id)
    local told = {}
    b.sync:on("ledgerRetired", function(t) told[#told + 1] = "R:" .. t.by end)
    b.sync:on("ledgerRestored", function(t) told[#told + 1] = "K:" .. t.by end)
    local now = a.client:serverTime()
    Ledgers.Retire(a.db, key, "Boss", now, key)
    net:advance(12)
    eq(table.concat(told, ","), "R:Boss", "told once, though heartbeats repeat")
    local t = b.db.retired[id]
    assert(t and t.r == 1 and not t.mine); eq(t.due, t.t + Ledgers.EXPIRES)
    assert(b.db.worlds[key], "it stays here until it expires")
    Ledgers.Keep(b.db, id, b.client:serverTime())
    net:advance(12)
    assert(not Ledgers.IsRetired(a.db, id), "the restoration reached the one who retired it")
    Ledgers.Retire(a.db, key, "Boss", b.client:serverTime() + 5, key)
    net:advance(12)
    assert(Ledgers.IsRetired(b.db, id))
    eq(#Ledgers.Sweep(b.db, b.client:serverTime() + Ledgers.EXPIRES + 100), 1); eq(b.db.worlds[key], nil)
end)

test("a retirement from someone who isn't an officer is ignored, and a retired ledger isn't fetched from someone who still has it", function()
    local net = SimNetwork.New()
    local key = "mode15-Alliance-guild:blue parse"
    local a = peer("Boss", net, { worlds = { [key] = {} } }, key)
    assert(a.engine:CreateList("main", "Main"))
    net:advance(3)
    local id = a.engine:LedgerId()
    local c = peer("Pleb", net, { worlds = { [key] = {} } }, key, { officer = false })
    net:advance(10)
    eq(c.engine:LedgerId(), id)
    Ledgers.Retire(c.db, key, "Pleb", c.client:serverTime(), key)
    net:advance(12)
    assert(not Ledgers.IsRetired(a.db, id), "ignored: the sender isn't an officer")
    local db2 = { worlds = { [key] = {} }, retired = { [id] = { id = id, name = "G", world = key, by = "Me", t = 1, r = 1, mine = true, due = 1 } } }
    local d = peer("Newbie", net, db2, key)
    net:advance(20)
    eq(d.engine:LedgerId(), nil, "no ledger fetched")
end)

H.section("Commands: ledgers")
test("ledgers lists, asks before retiring, retires on yes, and keep brings it back", function()
    local key = "mode15-Alliance-guild:blue parse"
    local open = "mode18-Horde-guild:gray parse"
    local db = { worlds = { [key] = world("aaa", "Guild ledger", 2), [open] = world("bbb", "Guild ledger") } }
    local client = MockClient.New({ name = "Me" })
    client.storage = function() return { account = db.worlds[open], char = {}, shared = db, world = open } end
    client.world = function() return open end
    local engine = Engine.New(client)
    local printed = {}
    client.print = function(_, text) printed[#printed + 1] = text end
    local cmds = Commands.New({ client = client, engine = engine, sync = Sync.New(engine) })
    local function say(text) printed = {}; cmds.handle(text); return table.concat(printed, "\n") end
    local listing = say("ledgers")
    assert(listing:find("1. Blue Parse %(Alliance%)") and listing:find("2. Gray Parse %(Horde%)") and listing:find("in use now"), listing)
    local ask = say("ledgers retire 1")
    assert(ask:find("ledgers retire 1 yes") and db.worlds[key], ask)
    assert(say("ledgers retire 1 yes"):find("Retired Blue Parse")); eq(db.worlds[key], nil)
    assert(say("ledgers"):find("retired by you"))
    assert(say("ledgers keep 2"):find("not retired any more"))
    assert(say("ledgers retire 9"):find("No such ledger"))
end)

H.section("Guild book: Ledgers")
test("the Ledgers section lists the stored ledgers with Retire or Keep, and the page asks before retiring", function()
    local GuildBook, UI = SK.modules.GuildBook, SK.modules.UI
    assert(GuildBook.Section("ledgers"), "a section for it")
    local key, open = "mode15-Alliance-guild:blue parse", "mode18-Horde-guild:gray parse"
    local db = { worlds = { [key] = world("aaa", "Guild ledger", 2), [open] = world("bbb", "Guild ledger") } }
    local client = MockClient.New({ name = "Me" })
    client.storage = function() return { account = db.worlds[open], char = {}, shared = db, world = open } end
    client.world = function() return open end
    local engine = Engine.New(client)
    local m = GuildBook.Ledgers({ client = client, engine = engine })
    eq(#m.rows, 2); eq(m.rows[1].title, "Blue Parse (Alliance)"); assert(m.rows[1].canRetire and not m.rows[1].canKeep)
    assert(m.rows[2].open and m.rows[2].status == "in use now")
    Ledgers.Retire(db, key, "Me", client:serverTime(), open)
    m = GuildBook.Ledgers({ client = client, engine = engine })
    assert(m.rows[2].canKeep and not m.rows[2].canRetire and not m.rows[2].held, "a removed ledger can only be kept (restored)")
    local none = GuildBook.Ledgers({ client = MockClient.New({ name = "Me" }), engine = engine })
    eq(#none.rows, 0); assert(none.note)
    -- without the game's dialog nothing is retired: the page never retires without asking
    eq(UI.ConfirmRetire({ n = 2, title = "Gray Parse (Horde)", open = true }), false)
end)
