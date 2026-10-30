-- Ledger v2: hashing, per-list rules (anchors), per-writer chains, the deterministic merge, and authority.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Hash, Standings, Ledger = SK.modules.Hash, SK.modules.Standings, SK.modules.Ledger

-- A tiny world: a store and writers with fixed chain ids. w:write(author, type, data, ts, list).
local EPOCH = { GM = "00000001", Off = "00000002", MLA = "0000000a", MLB = "0000000b", Rand = "000000ff" }
local function world()
    local w = { store = Ledger.NewStore() }
    function w:write(author, type_, data, ts, list)
        local cid = author .. "#" .. (EPOCH[author] or "0000abcd")
        local ev = assert(Ledger.Build(self.store, cid, author, type_, data, ts, list))
        local st, err = Ledger.Receive(self.store, ev)
        assert(st == "appended", "receive failed: " .. tostring(err))
        return ev
    end
    function w:view() return Ledger.View(self.store) end
    return w
end
H.ledgerWorld = world

-- A ledger with a guild master (GM), one officer (Off) and list `main` holding A..E.
local function guild()
    local w = world()
    w:write("GM", "Genesis", { name = "Guild" }, 100)
    w:write("GM", "SetOfficers", { names = { "Off" } }, 101)
    w:write("GM", "CreateList", { name = "Main" }, 102, "main")
    for i, n in ipairs { "A", "B", "C", "D", "E" } do w:write("GM", "AddMember", { member = n }, 102 + i, "main") end
    return w
end
H.ledgerGuild = guild

local function order(view, list) return table.concat(view.lists[list or "main"].order, ",") end
local function reasons(view)
    local out = {}
    for _, c in ipairs(view.conflicts) do out[#out + 1] = c.type .. ":" .. c.reason end
    return table.concat(out, " ")
end

H.section("Hash")
test("same data hashes the same regardless of key order", function()
    eq(Hash.Canon({ a = 1, b = { x = 1, y = 2 } }), Hash.Canon({ b = { y = 2, x = 1 }, a = 1 }))
    eq(Hash.Sum("hello"), Hash.Sum("hello"))
end)
test("different data hashes differently", function()
    assert(Hash.Sum("hello") ~= Hash.Sum("hellp"))
    assert(Hash.Canon({ a = "1" }) ~= Hash.Canon({ a = 1 }), "string vs number must differ")
end)
test("the hash algorithm is locked (golden values from two different Lua runtimes)", function()
    eq(Hash.Sum("hello Fenn-Realm"), "3dcf24964da09ca2")
    eq(Hash.Sum("hello Zed-Realm"), "0dda1aa26cc53a36")
    eq(Hash.Sum(""), "811c9dc59e3779b1"); eq(Hash.Sum("abc"), "1a47e90bdf63f96f")
end)
test("hash is 16 hex chars", function() assert(Hash.Sum("x"):match("^%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x$")) end)

H.section("Standings: anchors, not numbers")
test("members join at the bottom, or at the top, or above someone", function()
    local w = guild()
    w:write("GM", "AddMember", { member = "F", to = "top" }, 120, "main")
    w:write("GM", "AddMember", { member = "G", above = "C" }, 121, "main")
    eq(order(w:view()), "F,A,B,G,C,D,E")
end)
test("a win drops the winner to the bottom and keeps everyone else in order", function()
    local w = guild()
    local ev = w:write("GM", "Award", { member = "B", item = "Sword" }, 120, "main")
    local v = w:view()
    eq(order(v), "A,C,D,E,B"); eq(v.lists.main.members.B.wins, 1); eq(v.lists.main.members.B.lastWinId, ev.id)
end)
test("pass, gift and transfer", function()
    local w = guild()
    w:write("GM", "Pass", { member = "A", item = "X", kind = "upgrade" }, 120, "main")
    local aw = w:write("GM", "Award", { member = "E", item = "Ring", to = "A" }, 121, "main")
    w:write("GM", "Transfer", { award = aw.id, to = "B" }, 122, "main")
    local v = w:view()
    eq(v.lists.main.members.A.upgradePasses, 1); eq(v.lists.main.awards[aw.id].to, "B"); eq(order(v), "A,B,C,D,E")
end)
test("MovePlayer needs a reason and an anchor or an end", function()
    local w = guild()
    w:write("GM", "MovePlayer", { member = "E", to = "top", reason = "fix" }, 120, "main")
    w:write("GM", "MovePlayer", { member = "A", above = "C", reason = "fix" }, 121, "main")
    w:write("GM", "MovePlayer", { member = "D", reason = "no place given" }, 122, "main")
    w:write("GM", "MovePlayer", { member = "B", to = "bottom" }, 123, "main")
    w:write("GM", "MovePlayer", { member = "B", above = "B", reason = "self" }, 124, "main")
    local v = w:view()
    eq(order(v), "E,B,A,C,D")
    eq(reasons(v), "MovePlayer:badpos MovePlayer:noreason MovePlayer:badanchor")
end)
test("undo restores the winner above the players who were below them", function()
    local w = guild()
    local aw = w:write("GM", "Award", { member = "B", item = "X" }, 120, "main")
    w:write("GM", "Revert", { target = aw.id }, 121, "main")
    local v = w:view()
    eq(order(v), "A,B,C,D,E"); eq(v.lists.main.members.B.wins, 0); assert(v.lists.main.awards[aw.id].reverted)
end)
test("undo still restores the order when another writer's awards came in between", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, 110)
    w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 360 }, 110)
    local aw = w:write("MLA", "Award", { member = "B", item = "X" }, 120, "main")
    w:write("MLB", "Award", { member = "C", item = "Y" }, 121, "main")
    w:write("MLB", "Award", { member = "A", item = "Z" }, 122, "main")
    w:write("MLA", "Revert", { target = aw.id }, 123, "main")
    local v = w:view()
    eq(reasons(v), "")
    eq(order(v), "B,D,E,C,A", "B is back above D (who was below B); everyone else is untouched")
end)
test("only the writer's own latest award can be undone", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, 110)
    w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 360 }, 110)
    local a1 = w:write("MLA", "Award", { member = "B", item = "X" }, 120, "main")
    w:write("MLA", "Award", { member = "D", item = "Y" }, 121, "main")
    w:write("MLB", "Revert", { target = a1.id }, 122, "main")
    w:write("MLA", "Revert", { target = a1.id }, 123, "main")
    eq(reasons(w:view()), "Revert:notrevertible Revert:notrevertible")
end)

H.section("Ledger: chains")
test("tampering with any event is detected", function()
    local w = guild()
    local chain = w.store.chains["GM#00000001"]
    local saved = { chains = { ["GM#00000001"] = { events = chain.events } } }
    chain.events[5].data.member = "Evil"
    local _, problems = Ledger.LoadStore(saved)
    eq(problems["GM#00000001"].reason, "badhash"); eq(problems["GM#00000001"].index, 5)
end)
test("gaps, forks, time travel, wrong chain names and foreign ledgers are refused", function()
    local w = guild()
    local cid = "GM#00000001"
    local nxt = Ledger.Build(w.store, cid, "GM", "AddMember", { member = "F" }, 200, "main")
    local copy = {}
    for k, v in pairs(nxt) do copy[k] = v end
    copy.seq = copy.seq + 1; copy.id = Ledger.EventId(copy)
    local _, a = Ledger.Receive(w.store, copy); eq(a, "gap")
    local rival = Ledger.Build(w.store, cid, "GM", "AddMember", { member = "G" }, 200, "main")
    assert(Ledger.Receive(w.store, nxt))
    local _, b = Ledger.Receive(w.store, rival); eq(b, "fork")
    local early = Ledger.Build(w.store, cid, "GM", "AddMember", { member = "H" }, 50, "main")
    local _, c = Ledger.Receive(w.store, early); eq(c, "timetravel")
    local wrong = Ledger.Build(w.store, "Someone#00000001", "GM", "AddMember", { member = "H" }, 300, "main")
    local _, d = Ledger.Receive(w.store, wrong); eq(d, "badchain")
    local other = world()
    other:write("GM", "Genesis", { name = "Another guild" }, 100)
    local stranger = Ledger.Build(other.store, "X#00000009", "X", "AddMember", { member = "Q" }, 300, "main")
    local _, f = Ledger.Receive(w.store, stranger); eq(f, "wrongledger")
    local _, g = Ledger.Receive(Ledger.NewStore(), stranger); eq(g, "noledger")
    local otherGenesis = other.store.chains["GM#00000001"].events[1]
    local _, h = Ledger.Receive(w.store, otherGenesis); eq(h, "wrongledger")
end)
test("receiving the same event twice is harmless", function()
    local w = guild()
    eq(Ledger.Receive(w.store, w.store.chains["GM#00000001"].events[3]), "duplicate")
end)
test("the fingerprint changes with any event and is the same for the same history", function()
    local a, b = guild(), guild()
    eq(Ledger.Fingerprint(a.store), Ledger.Fingerprint(b.store))
    a:write("GM", "Pass", { member = "A", item = "X" }, 200, "main")
    assert(Ledger.Fingerprint(a.store) ~= Ledger.Fingerprint(b.store))
end)

H.section("Ledger: merging parallel raids")
test("two raids' events arriving in any order give the same view", function()
    local function build()
        local w = guild()
        w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, 110)
        w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 360 }, 110)
        return w
    end
    local w = build()
    local evs = {
        w:write("MLA", "Award", { member = "A", item = "X" }, 120, "main"),
        w:write("MLB", "Award", { member = "D", item = "Y" }, 120, "main"),
        w:write("MLA", "Award", { member = "C", item = "Z" }, 125, "main"),
        w:write("MLB", "Award", { member = "E", item = "W" }, 122, "main"),
    }
    local expect = order(w:view())
    for _, o in ipairs { { 1, 2, 3, 4 }, { 2, 4, 1, 3 }, { 2, 1, 4, 3 }, { 1, 3, 2, 4 } } do
        local w2 = build()
        for _, i in ipairs(o) do assert(Ledger.Receive(w2.store, evs[i])) end
        eq(order(w2:view()), expect)
    end
end)
test("a raid's players keep the same relative order whatever the other raid did", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, 110)
    w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 360 }, 110)
    w:write("MLA", "Award", { member = "A", item = "X" }, 120, "main") -- raid 1 has A, C, E
    w:write("MLA", "Award", { member = "C", item = "X" }, 121, "main")
    local function raid1(v)
        local out = {}
        for _, n in ipairs(v.lists.main.order) do if n == "A" or n == "C" or n == "E" then out[#out + 1] = n end end
        return table.concat(out, ",")
    end
    local before = raid1(w:view())
    w:write("MLB", "Award", { member = "B", item = "Y" }, 119, "main") -- raid 2 has B, D (arrives late, sorts earlier)
    w:write("MLB", "Award", { member = "D", item = "Y" }, 122, "main")
    eq(raid1(w:view()), before)
end)

H.section("Ledger: who may write")
test("ordinary writers, and officers during a raid, are skipped as conflicts", function()
    local w = guild()
    w:write("Rand", "AddMember", { member = "X" }, 110, "main")
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 120)
    w:write("Off", "AddMember", { member = "Y" }, 130, "main")
    w:write("MLA", "AddMember", { member = "Z" }, 131, "main")
    local v = w:view()
    eq(reasons(v), "AddMember:notauthorized AddMember:duringraid")
    eq(order(v), "A,B,C,D,E,Z")
end)
test("the Master Looter's privilege expires on its own", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 1000)
    w:write("MLA", "Award", { member = "A", item = "X" }, 1000 + 3599, "main")
    w:write("MLA", "Award", { member = "B", item = "X" }, 1000 + 3600, "main")
    w:write("Off", "Pass", { member = "C", item = "X" }, 1000 + 3600, "main")
    eq(reasons(w:view()), "Award:expired", "after expiry the officer may write again; the Master Looter may not")
end)
test("an officer can extend a raid; closing or revoking ends it early", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 1000)
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 120 }, 2000)
    w:write("MLA", "Pass", { member = "A", item = "X" }, 1000 + 3600 + 60, "main")
    w:write("MLA", "RaidClose", { raid = "r1" }, 5000)
    w:write("MLA", "Pass", { member = "A", item = "X" }, 5001, "main")
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 5002)
    w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 60 }, 6000)
    w:write("Off", "Revoke", { raid = "r2" }, 6100)
    w:write("MLB", "Pass", { member = "A", item = "X" }, 6101, "main")
    eq(reasons(w:view()), "Elevate:raidended Pass:expired Pass:expired", "authority conflicts are listed first (pass 1)")
end)
test("only officers elevate, only the guild master sets officers, and anyone can be elevated", function()
    local w = guild()
    w:write("Rand", "Elevate", { raid = "r1", ml = "Rand", minutes = 60 }, 110)
    w:write("Off", "SetOfficers", { names = { "Off", "Rand" } }, 111)
    w:write("Off", "Elevate", { raid = "r1", ml = "Rand", minutes = 60 }, 112)
    w:write("Rand", "AddMember", { member = "F" }, 113, "main")
    local v = w:view()
    eq(reasons(v), "Elevate:notofficer SetOfficers:notguildmaster")
    eq(order(v), "A,B,C,D,E,F", "a non-officer Master Looter writes while elevated")
end)
test("guild master hand-over", function()
    local w = guild()
    w:write("GM", "SetGuildMaster", { name = "Off" }, 110)
    w:write("GM", "SetOfficers", { names = {} }, 111)
    w:write("Off", "SetOfficers", { names = { "Rand" } }, 112)
    local v = w:view()
    eq(reasons(v), "SetOfficers:notguildmaster"); eq(v.auth.gm, "Off"); assert(v.auth.officers.Rand)
end)
test("declined adjustment requests are recorded by the Master Looter", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 110)
    w:write("MLA", "Declined", { request = "move E to top", requestedBy = "Off", declineReason = "already fixed" }, 111)
    w:write("MLA", "Declined", { request = "x" }, 112)
    w:write("Rand", "Declined", { request = "x", requestedBy = "Off", declineReason = "y" }, 113)
    local v = w:view()
    eq(#v.declined, 1); eq(reasons(v), "Declined:baddecline Declined:notauthorized")
end)
test("replaying the store is deterministic", function()
    local a, b = guild(), guild()
    eq(Standings.Digest(a:view().lists.main), Standings.Digest(b:view().lists.main))
end)

H.section("Ledger: the format spec")
test("the worked example in docs/ledger-format.md is real", function()
    local store = Ledger.NewStore()
    local function w(author, epoch, t, d, ts, list)
        local ev = assert(Ledger.Build(store, author .. "#" .. epoch, author, t, d, ts, list))
        assert(Ledger.Receive(store, ev))
        return ev
    end
    local g = w("Guildmaster-Realm", "1a2b3c4d", "Genesis", { name = "Guild ledger" }, 1760000000)
    eq(g.id, "89cf69b1d9689705")
    eq(w("Guildmaster-Realm", "1a2b3c4d", "CreateList", { name = "Main" }, 1760000010, "main").id, "2e3878a6c2111092")
    eq(w("Guildmaster-Realm", "1a2b3c4d", "AddMember", { member = "Aldric-Realm" }, 1760000020, "main").id, "46c60894660959a8")
    eq(w("Guildmaster-Realm", "1a2b3c4d", "AddMember", { member = "Brann-Realm" }, 1760000030, "main").id, "f4594a4cd28c07e0")
    eq(w("Guildmaster-Realm", "1a2b3c4d", "Elevate", { raid = "thu-1", ml = "Looter-Realm", minutes = 360 }, 1760000100).id, "dc646491b3a302e5")
    local aw = w("Looter-Realm", "5e6f7a8b", "Award", { member = "Aldric-Realm", item = "Gauntlets of the Ashen Vow" }, 1760000200, "main")
    eq(aw.id, "07c2ae4df2d4dc39"); eq(aw.ledger, "89cf69b1d9689705")
    eq(table.concat(Ledger.View(store).lists.main.order, ","), "Brann-Realm,Aldric-Realm")
    eq(Ledger.Fingerprint(store), "2cc0444c8382fd78")
    eq(Hash.Canon({ v = 2, ledger = "", chain = "Guildmaster-Realm#1a2b3c4d", seq = 1, ts = 1760000000, author = "Guildmaster-Realm",
        type = "Genesis", data = { name = "Guild ledger" } }),
        "{s6:author=s17:Guildmaster-Realm,s5:chain=s26:Guildmaster-Realm#1a2b3c4d,s4:data={s4:name=s12:Guild ledger,},s6:ledger=s0:,s3:seq=n1,s2:ts=n1760000000,s4:type=s7:Genesis,s1:v=n2,}")
end)

H.section("Ledger: ordered by when the loot became visible")
local function twoRaids()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, 1000)
    w:write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 360 }, 1000)
    return w
end
test("a raid that hands out at a break is ordered by when its loot dropped", function()
    local w = twoRaids()
    -- raid 1 holds A's loot (dropped at 1100) and hands it out at 3000; raid 2 awards C per boss at 2000
    w:write("MLB", "Award", { member = "C", item = "Y", seen = 2000 }, 2000, "main")
    w:write("MLA", "Award", { member = "A", item = "X", seen = 1100 }, 3000, "main")
    eq(order(w:view()), "B,D,E,A,C", "A's loot dropped first, so A sorts first even though it was handed out last")
end)
test("without seen, the same events order by hand-out time", function()
    local w = twoRaids()
    w:write("MLB", "Award", { member = "C", item = "Y" }, 2000, "main")
    w:write("MLA", "Award", { member = "A", item = "X" }, 3000, "main")
    eq(order(w:view()), "B,D,E,C,A")
end)
test("a writer's own events never swap places, whatever their seen times", function()
    local w = twoRaids()
    w:write("MLA", "Award", { member = "A", item = "X", seen = 2500 }, 3000, "main")
    w:write("MLA", "Award", { member = "B", item = "Y", seen = 1200 }, 3001, "main") -- earlier drop, handed out second
    eq(order(w:view()), "C,D,E,A,B", "B is still after A: the key never goes below the writer's previous key")
end)
test("loot can't be handed out before it was visible, or a day after", function()
    local w = twoRaids()
    w:write("MLA", "Award", { member = "A", item = "X", seen = 3500 }, 3000, "main")
    w:write("MLA", "Award", { member = "B", item = "X", seen = 3000 - 86401 }, 3000, "main")
    eq(reasons(w:view()), "Award:badseen Award:badseen")
end)
test("authority is checked when an event was written, not where it sorts", function()
    local w = guild()
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 1000)       -- until 4600
    w:write("Off", "AddMember", { member = "F" }, 1050, "main")                      -- officer, during the raid
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 120 }, 4000)      -- extended to 11200
    w:write("MLA", "Award", { member = "A", item = "X", seen = 1100 }, 5000, "main") -- sorts at 1100, written at 5000
    local v = w:view()
    eq(reasons(v), "AddMember:duringraid"); eq(order(v), "B,C,D,E,A")
end)
test("events in the same second are ordered exactly, the same way everywhere", function()
    local w = guild()
    w:write("Off", "AddMember", { member = "F" }, 500, "main")                      -- before the raid opened (same second)
    w:write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 60 }, 500)
    w:write("Off", "AddMember", { member = "G" }, 500, "main")                      -- after it opened
    eq(reasons(w:view()), "AddMember:duringraid")
end)
