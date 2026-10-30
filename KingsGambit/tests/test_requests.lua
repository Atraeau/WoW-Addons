-- The dispute path: during a raid only its Master Looter writes; everyone else, officers included, sends requests,
-- which the Master Looter accepts or declines, both on the record. Played over the simulated network, through the
-- text interface, the way a guild would meet these situations.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local LootNet, Commands, Requests = SK.modules.LootNet, SK.modules.Commands, SK.modules.Requests

local function text(node) return table.concat(node.client.printed, "\n") end
local function clear(node) node.client.printed = {} end

-- Run the network until every peer has the same ledger (or give up after `limit` seconds).
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

-- A guild: the guild master (GM), an officer (Off), a Master Looter who is not an officer (Looter), raiders
-- Aldric, Brann and Cass. Everyone has the addon. The ledger is founded and synced; no raid is open yet.
local NAMES = { "GM", "Off", "Looter", "Aldric", "Brann", "Cass" }
local function guild(netOpts)
    local net = SimNetwork.New(netOpts or { latency = 0.1, seed = 7 })
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
    -- Simulate /reload of one player: a fresh addon over the same saved data.
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

H.section("Disputes: who writes during a raid")
test("an officer opens a raid; then only its Master Looter writes, and officers are pointed to requests", function()
    local w = guild()
    w.Aldric.cmd.handle("raid open Aldric"); assert(text(w.Aldric):find("Only an officer can open a raid"), text(w.Aldric))
    openRaid(w)
    assert(text(w.Off):find("Raid open: Looter is Master Looter"), text(w.Off))
    everyone(w, function(nd) eq(#nd.engine:ActiveRaids(), 1, nd.name .. " sees the raid") end)
    clear(w.Aldric); w.Aldric.cmd.handle("raid"); assert(text(w.Aldric):find("Looter is Master Looter for 240 more minute"), text(w.Aldric))
    assert(w.Looter.engine:MayWrite(), "the Master Looter writes")
    clear(w.Off); w.Off.cmd.handle("move Cass top she was skipped by mistake")
    local t = text(w.Off)
    assert(t:find("only its Master Looter %(Looter%) writes"), t)
    assert(t:find("request move Cass top she was skipped by mistake", 1, true), t)
    eq(order(w.Off), "Aldric,Brann,Cass,Looter", "nothing changed")
end)

test("the Master Looter's addon won't start a session it couldn't record", function()
    local w = guild()
    w.Looter.client:dropLoot({ { link = "Gauntlets" } })
    w.Looter.cmd.handle("loot")
    local t = text(w.Looter)
    assert(t:find("You can't record awards"), t); assert(t:find("raid open Looter"), t)
    eq(w.Looter.host.session, nil)
    openRaid(w); clear(w.Looter)
    w.Looter.cmd.handle("loot"); assert(text(w.Looter):find("Loot session started"), text(w.Looter))
end)

H.section("Disputes: requests, accepted and declined")
test("an officer's request, accepted: the change carries who asked and why, on every peer", function()
    local w = guild(); openRaid(w)
    w.Off.cmd.handle("request move Cass top she was skipped by mistake")
    w.net:advance(2)
    assert(text(w.Off):find("Looter has your request %(#1%)"), text(w.Off))
    local t = text(w.Looter)
    assert(t:find("Request #1 from Off: move Cass to the top%. Reason: she was skipped by mistake"), t)
    assert(t:find("accept 1, or decline 1 <reason>"), t)
    w.Looter.cmd.handle("accept 1")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Cass,Aldric,Brann,Looter", nd.name) end)
    local ev = w.GM.engine:Get("main").events[#w.GM.engine:Get("main").events]
    eq(ev.type, "MovePlayer"); eq(ev.author, "Looter-Realm"); eq(ev.data.requestedBy, "Off-Realm")
    eq(ev.data.reason, "she was skipped by mistake")
    assert(text(w.Off):find("Looter accepted your request: Looter moved Cass to top, at the request of Off"), text(w.Off))
    assert(text(w.Cass):find("The list changed for you"), text(w.Cass))
    eq(#w.Looter.requests:pending(), 0)
end)

test("a raider's request, declined with a reason: recorded, standings untouched, the raider sees why", function()
    local w = guild(); openRaid(w)
    w.Brann.cmd.handle("request move Brann top I was offline when it dropped")
    w.net:advance(2)
    clear(w.Looter); w.Looter.cmd.handle("decline 1"); assert(text(w.Looter):find("the reason goes in the record"), text(w.Looter))
    w.Looter.cmd.handle("decline 1 offline players are not eligible, that's the rule")
    w.net:advance(3)
    everyone(w, function(nd)
        eq(order(nd), "Aldric,Brann,Cass,Looter", nd.name)
        eq(#nd.engine:View().declined, 1, nd.name .. " has the decline")
    end)
    assert(text(w.Brann):find("Looter declined your request to move Brann to the top: offline players are not eligible"), text(w.Brann))
    clear(w.GM); w.GM.cmd.handle("history")
    assert(text(w.GM):find("Looter declined Brann's request to move Brann to the top: offline players"), text(w.GM))
end)

test("the wrong winner: undo the award, then record the right one, both at the raider's request", function()
    local w = guild(); openRaid(w)
    -- The Master Looter gave the item to Brann, but Aldric (higher) had bid need and was missed.
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Gauntlets" }))
    w.net:advance(2)
    eq(order(w.Aldric), "Aldric,Cass,Looter,Brann")
    w.Aldric.cmd.handle("request undo Brann I bid need and I'm above him")
    w.Aldric.cmd.handle("request award Aldric Gauntlets my need bid was missed")
    w.net:advance(2)
    w.Looter.cmd.handle("accept 1"); w.Looter.cmd.handle("accept 2")
    w.net:advance(3)
    everyone(w, function(nd) eq(order(nd), "Brann,Cass,Looter,Aldric", nd.name) end)
    clear(w.Cass); w.Cass.cmd.handle("history 3")
    local t = text(w.Cass)
    assert(t:find("Looter undid Brann's award, at the request of Aldric"), t)
    assert(t:find("Aldric won Gauntlets, at the request of Aldric %(my need bid was missed%)"), t)
end)

test("an undo that can't be done any more stays waiting, and is declined with a reason", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Belt" }))
    assert(w.Looter.engine:Append("main", "Award", { member = "Cass-Realm", item = "Ring" }))
    w.net:advance(2)
    w.Off.cmd.handle("request undo Brann wrong person")
    w.net:advance(2)
    clear(w.Looter); w.Looter.cmd.handle("accept 1")
    assert(text(w.Looter):find("can't be undone directly any more"), text(w.Looter))
    eq(#w.Looter.requests:pending(), 1, "still waiting")
    w.Looter.cmd.handle("decline 1 the list has moved since; I'll fix it with a move")
    w.Off.cmd.handle("request move Brann 1 replaces the undo of the Belt award")
    w.net:advance(2)
    w.Looter.cmd.handle("accept 2")
    w.net:advance(3)
    eq(order(w.Off), "Brann,Aldric,Looter,Cass")
end)

test("a gift correction moves nobody: it records where the item really went", function()
    local w = guild(); openRaid(w)
    assert(w.Looter.engine:Append("main", "Award", { member = "Brann-Realm", item = "Cloak" }))
    w.net:advance(2)
    w.Brann.cmd.handle("request gift Brann Cass I traded it to her, I meant to gift it")
    w.net:advance(2); w.Looter.cmd.handle("accept 1"); w.net:advance(3)
    local s = w.GM.engine:Get("main").state
    local award
    for _, a in pairs(s.awards) do award = a end
    eq(award.to, "Cass-Realm"); eq(order(w.GM), "Aldric,Cass,Looter,Brann", "positions unchanged")
end)

H.section("Disputes: things that go wrong")
test("lost messages: the request is re-sent, never queued twice, and the outcome still arrives", function()
    local w = guild({ latency = 0.1, seed = 11, dropRate = 0.35, duplicateRate = 0.2 })
    openRaid(w); assert(settle(w))
    eq(#w.Looter.engine:ActiveRaids(), 1)
    w.Off.cmd.handle("request remove Cass she left the guild")
    w.net:advance(25)
    eq(#w.Looter.requests:pending(), 1, "exactly one request, however many copies arrived")
    w.Looter.cmd.handle("accept 1")
    w.net:advance(60)
    everyone(w, function(nd) eq(order(nd), "Aldric,Brann,Looter", nd.name) end)
    assert(text(w.Off):find("Looter accepted your request"), text(w.Off))
end)

test("the Master Looter reloads: waiting requests survive", function()
    local w = guild(); openRaid(w)
    w.Aldric.cmd.handle("request add Dorn bottom new recruit, trial starts tonight")
    w.net:advance(2)
    local looter = w.reload("Looter")
    w.net:advance(3)
    eq(#looter.requests:pending(), 1)
    looter.cmd.handle("accept 1"); w.net:advance(3)
    eq(order(w.Aldric), "Aldric,Brann,Cass,Looter,Dorn")
end)

test("nobody to ask: no raid, the wrong person, or no addon on the other end", function()
    local w = guild()
    w.Off.cmd.handle("request move Cass top x"); assert(text(w.Off):find("you can make this change directly"), text(w.Off))
    w.Aldric.cmd.handle("request move Aldric top x"); assert(text(w.Aldric):find("no raid is open"), text(w.Aldric))
    openRaid(w)
    clear(w.Aldric); w.Aldric.cmd.handle("request @Brann move Aldric top x"); assert(text(w.Aldric):find("Not sent"), text(w.Aldric))
    clear(w.Looter); w.Looter.cmd.handle("request move Aldric top x"); assert(text(w.Looter):find("make the change directly"), text(w.Looter))
    -- The Master Looter's addon is gone (they turned it off): the requester is told to ask in chat.
    w.Looter.sync:stop()
    clear(w.Aldric); w.Aldric.cmd.handle("request move Aldric top my bid was lost")
    w.net:advance(30)
    assert(text(w.Aldric):find("No answer from Looter's addon"), text(w.Aldric))
end)

test("a request needs a reason, and nobody can flood the Master Looter or speak for someone else", function()
    local w = guild(); openRaid(w)
    w.Aldric.cmd.handle("request move Aldric top"); assert(text(w.Aldric):find("a reason is required"), text(w.Aldric))
    for i = 1, 4 do w.Aldric.cmd.handle("request move Aldric top please " .. i) end
    w.net:advance(3)
    eq(#w.Looter.requests:pending(), 3, "three at a time per player")
    assert(text(w.Aldric):find("you already have 3 requests waiting"), text(w.Aldric))
    -- A request that claims to come from someone else (its id names another player) is ignored.
    w.Brann.sync:send({ t = "QR", rid = "Off-Realm:1:1", kind = "remove", member = "Cass-Realm", reason = "forged" }, "WHISPER", "Looter-Realm")
    w.net:advance(2)
    eq(#w.Looter.requests:pending(), 3)
    for _, p in ipairs(w.Looter.requests:pending()) do eq(p.by, "Aldric-Realm") end
end)

H.section("Disputes: ending a raid")
test("closing with requests waiting asks first; after closing, officers edit directly and the Master Looter can't", function()
    local w = guild(); openRaid(w)
    w.Cass.cmd.handle("request move Cass top x marks the spot")
    w.net:advance(2)
    clear(w.Looter); w.Looter.cmd.handle("raid close")
    local t = text(w.Looter)
    assert(t:find("1 request%(s%) are still waiting"), t); assert(t:find("#1 from Cass: move Cass to the top"), t)
    eq(#w.Looter.engine:ActiveRaids(), 1, "not closed")
    w.Looter.cmd.handle("decline 1 not tonight"); w.Looter.cmd.handle("raid close")
    w.net:advance(3)
    everyone(w, function(nd) eq(#nd.engine:ActiveRaids(), 0, nd.name) end)
    local ok, why = w.Looter.engine:MayWrite(); eq(ok, nil); eq(why, "expired")
    w.Off.cmd.handle("move Cass top correction after the raid"); w.net:advance(2)
    eq(order(w.GM), "Cass,Aldric,Brann,Looter")
end)

test("an officer revokes a Master Looter: their later writes are refused everywhere", function()
    local w = guild(); openRaid(w)
    w.Off.cmd.handle("raid revoke Looter"); w.net:advance(3)
    assert(text(w.Off):find("Looter is no longer Master Looter"), text(w.Off))
    everyone(w, function(nd) eq(#nd.engine:ActiveRaids(), 0, nd.name) end)
    local ev, why = w.Looter.engine:Append("main", "Award", { member = "Aldric-Realm", item = "X" })
    eq(ev, nil); eq(why, "expired")
end)

test("two raids at once: a request goes to the Master Looter of the requester's own raid", function()
    local w = guild()
    w.Off.cmd.handle("raid open Looter 4"); w.Off.cmd.handle("raid open Cass 4")
    w.net:advance(3)
    w.Aldric.cmd.handle("request move Aldric bottom testing"); w.net:advance(2)
    eq(#w.Looter.requests:pending(), 1, "Aldric's raid is Looter's"); eq(#w.Cass.requests:pending(), 0)
    w.Aldric.client:setRaid({ "Aldric", "Cass" }, { leader = "Cass", lootMethod = "group" })
    clear(w.Aldric); w.Aldric.cmd.handle("request move Aldric bottom again")
    assert(text(w.Aldric):find("more than one raid is running"), text(w.Aldric))
    w.Aldric.cmd.handle("request @Cass move Aldric bottom again"); w.net:advance(2)
    eq(#w.Cass.requests:pending(), 1)
end)

H.section("Disputes: asking to be eligible for an item")
-- A priest's robe: the Master Looter's game says "Classes: Priest". Aldric is a warrior (the default class here).
local ROBE = "|cffa335ee|Hitem:19999::::::::60:::::|h[Robe of the Faithful]|h|r"
local function robe(w)
    w.Looter.client:setItemInfo(ROBE, { name = "Robe of the Faithful", equipLoc = "INVTYPE_ROBE", class = 4, subclass = 1 })
    w.Looter.client:setItemStats(ROBE, { stats = { int = 20 }, classes = { "PRIEST" } })
end

test("accepted: the class may bid on the item from now on, recorded with who asked and why", function()
    local w = guild(); openRaid(w); robe(w)
    w.Aldric.client:storage().char.spec = { main = "Protection" }
    w.Aldric.cmd.handle("request eligible " .. ROBE .. " the set bonus is worth it for my tanking")
    w.net:advance(2)
    assert(text(w.Looter):find("let Protection Warriors bid on Robe of the Faithful"), text(w.Looter))
    w.Looter.cmd.handle("accept 1")
    w.net:advance(3)
    everyone(w, function(nd)
        local rule = nd.engine:ItemRule(19999)
        assert(rule, nd.name .. " has the rule"); eq(table.concat(rule.classes, ","), "PRIEST,WARRIOR", nd.name)
    end)
    local ev = w.GM.engine.store.byId[w.GM.engine:ItemRule(19999).id]
    eq(ev.data.requestedBy, "Aldric-Realm"); eq(ev.data.spec, "Protection"); eq(ev.data.reason, "the set bonus is worth it for my tanking")
    assert(text(w.Aldric):find("Looter accepted your request"), text(w.Aldric))
    clear(w.Brann); w.Brann.cmd.handle("history 2")
    assert(text(w.Brann):find("Looter set who may bid on Robe of the Faithful: Priest, Warrior, at the request of Aldric"), text(w.Brann))
end)

test("declined: recorded in the ledger with the reason, and nothing changes", function()
    local w = guild(); openRaid(w); robe(w)
    w.Aldric.cmd.handle("request eligible " .. ROBE .. " I want it")
    w.net:advance(2)
    w.Looter.cmd.handle("decline 1 priests first; ask again if no priest needs it")
    w.net:advance(3)
    everyone(w, function(nd)
        eq(nd.engine:ItemRule(19999), nil, nd.name)
        local d = nd.engine:View().declined[1]
        eq(d.data.kind, "eligible"); eq(d.data.item, 19999); eq(d.data.class, "WARRIOR"); eq(d.data.requestedBy, "Aldric-Realm")
    end)
    assert(text(w.Aldric):find("Looter declined your request to let Warriors bid on Robe of the Faithful: priests first"), text(w.Aldric))
end)

test("an eligibility request that isn't needed is explained, and stays waiting for a decline", function()
    local w = guild(); openRaid(w)
    w.Looter.client:setItemInfo("item:500", { name = "Cloak", equipLoc = "INVTYPE_CLOAK", class = 4, subclass = 1 })
    w.Looter.client:setItemStats("item:500", { stats = { sta = 10 } })
    w.Aldric.cmd.handle("request eligible 500 please")
    w.net:advance(2)
    clear(w.Looter); w.Looter.cmd.handle("accept 1")
    assert(text(w.Looter):find("isn't restricted to classes"), text(w.Looter))
    eq(#w.Looter.requests:pending(), 1)
    w.Aldric.cmd.handle("request eligible"); assert(text(w.Aldric):find("request eligible <item or item#> <reason>"), text(w.Aldric))
end)

test("eligibility follows armor type: a plate item is for plate wearers; a class that can't wear it is told so", function()
    local w = guild(); openRaid(w)
    w.Looter.client:setItemInfo("item:600", { name = "Legplates", equipLoc = "INVTYPE_LEGS", class = 4, subclass = 4 })
    w.Looter.client:setItemStats("item:600", { stats = { str = 20 } })
    w.Looter.client:setItemInfo("item:601", { name = "Mail Boots", equipLoc = "INVTYPE_FEET", class = 4, subclass = 3 })
    w.Looter.client:setItemStats("item:601", { stats = { agi = 20 } })
    -- Brann asks as a mage for the plate (can't wear it), Aldric as a warrior for a mail item restricted... he can
    -- already wear mail, so there is nothing to ask.
    w.Brann.client:setRaid({ { name = "Brann", class = "MAGE" }, "Looter" }, { leader = "Looter", lootMethod = "master", masterLooter = "Looter" })
    w.Brann.cmd.handle("request eligible 600 I'd like the legs")
    w.Aldric.cmd.handle("request eligible 601 boots")
    w.net:advance(2)
    local num = {}
    for _, p in ipairs(w.Looter.requests:pending()) do num[p.by] = p.num end
    eq(w.Looter.requests:pending()[1].class ~= nil, true, "the request carries the requester's class")
    clear(w.Looter); w.Looter.cmd.handle("accept " .. num["Brann-Realm"])
    assert(text(w.Looter):find("that class can't wear or wield that item"), text(w.Looter))
    clear(w.Looter); w.Looter.cmd.handle("accept " .. num["Aldric-Realm"])
    assert(text(w.Looter):find("isn't restricted to classes") or text(w.Looter):find("may already bid"), text(w.Looter))
end)

H.section("Disenchanter: chosen per raid by its Master Looter, before loot is handed out")
test("only the raid's Master Looter designates the disenchanter; it is on the record for everyone", function()
    local w = guild()
    openRaid(w)
    w.Off.cmd.handle("disenchanter Aldric")
    assert(text(w.Off):find("not the Master Looter of an open raid"), text(w.Off))
    w.Looter.cmd.handle("disenchanter")
    assert(text(w.Looter):find("No disenchanter is designated"), text(w.Looter))
    w.Looter.cmd.handle("disenchanter Aldric"); assert(text(w.Looter):find("Aldric disenchants"), text(w.Looter))
    assert(settle(w))
    eq(w.Looter.engine:RaidDisenchanter(), "Aldric-Realm")
    w.Off.cmd.handle("disenchanter"); assert(text(w.Off):find("Aldric disenchants for raid"), text(w.Off))
    w.Brann.cmd.handle("history 3"); assert(text(w.Brann):find("Looter chose Aldric to disenchant"), text(w.Brann))
    -- it can be changed during the raid; the latest choice stands, and every peer agrees
    w.Looter.cmd.handle("disenchanter Cass"); assert(settle(w))
    eq(w.Looter.engine:RaidDisenchanter(), "Cass-Realm"); eq(#w.Looter.engine:Conflicts(), 0)
    -- a forged designation by someone else is refused by the ledger
    local ev, err = w.Aldric.engine:Write("SetDisenchanter", { raid = w.Looter.engine:ActiveRaids()[1].id, name = "Aldric-Realm" })
    assert(not ev and err == "notml", tostring(err))
end)
test("loot cannot be started until a disenchanter is designated; then unwanted loot goes to them", function()
    local Loot = SK.modules.Loot
    local wrapped = Loot.NewSession
    Loot.NewSession = H.rawNewSession -- the real check, without the tests' default
    local ok, err = pcall(function()
    local w = guild()
    openRaid(w)
    local L = w.Looter
    L.client:dropLoot({ { link = "item:1" } })
    L.cmd.handle("loot")
    assert(text(L):find("no disenchanter is designated"), text(L))
    assert(not L.host.session or L.host.session.phase == "idle", "nothing started")
    clear(L)
    L.cmd.handle("disenchanter Brann")
    L.cmd.handle("loot")
    assert(text(L):find("Loot session started"), text(L))
    eq(L.host.session.deHandler, "Brann-Realm")
    end)
    Loot.NewSession = wrapped
    assert(ok, err)
end)
test("a session started with nobody designated is refused by the engine itself", function()
    local w = guild()
    openRaid(w)
    local Loot = SK.modules.Loot
    local s = H.rawNewSession(w.Looter.engine)
    local ok, why = s:start({ { link = "item:1" } })
    assert(not ok and why == "nodisenchanter", tostring(why))
    w.Looter.cmd.handle("disenchanter Cass")
    local s2 = H.rawNewSession(w.Looter.engine)
    assert(s2:start({ { link = "item:1" } }))
    eq(s2.deHandler, "Cass-Realm")
    -- an explicit choice in the session's own settings also counts (tests, the simulator)
    assert(H.rawNewSession(w.Brann.engine, { deHandler = "Brann-Realm" }):start({ { link = "item:1" } }))
    assert(Loot)
end)
