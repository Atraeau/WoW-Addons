-- Multi-engine sync tests over SimNetwork (ledger v2: one chain per writer): gossip, catch-up, loss,
-- duplicates, reordering, partitions, parallel raids, restriction, chunking, tampering, and the rare chain fork.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork

local seedCounter = 0
local function peer(name, net, o)
    o = o or {}
    seedCounter = seedCounter + 1
    local client = MockClient.New({ name = name, realm = "Realm", seed = seedCounter * 7919, clock = o.clock, unix = o.unix })
    if o.storage then client.storage = function() return o.storage end end
    if o.raid then client:setRaid(o.raid, { leader = o.raid[1] }) end
    local engine = Engine.New(client)
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    if net then net:attach(client, o.attach) end
    sync:start()
    return { name = name .. "-Realm", client = client, engine = engine, sync = sync }
end

local function fp(p) return p.engine:Fingerprint() or "none" end
local function count(p) local c = p.engine:Get("main"); return c and #c.events or 0 end
local function order(p) local c = p.engine:Get("main"); return c and (table.concat(c.state.order, ","):gsub("%-Realm", "")) or "none" end
local function add(p, names) for _, n in ipairs(names) do assert(p.engine:Append("main", "AddMember", { member = n .. "-Realm" })) end end

-- A founds the ledger and makes everyone else an officer.
local function found(a, officers)
    assert(a.engine:CreateList("main", "Main"))
    local names = {}
    for _, n in ipairs(officers or {}) do names[#names + 1] = n .. "-Realm" end
    assert(a.engine:Write("SetOfficers", { names = names }))
end

local function all(peers, fn) for _, p in ipairs(peers) do fn(p) end end
local function same(peers)
    for i = 2, #peers do eq(fp(peers[i]), fp(peers[1]), peers[i].name .. " vs " .. peers[1].name) end
end

H.section("Sync: gossip and catch-up")
test("live events reach every peer", function()
    local net = SimNetwork.New()
    local a, b, c = peer("A", net), peer("B", net), peer("C", net)
    found(a)
    add(a, { "X", "Y", "Z" })
    net:advance(3)
    same({ a, b, c }); eq(order(c), "X,Y,Z")
end)
test("a late joiner learns the ledger and catches up across several batches", function()
    local net = SimNetwork.New()
    local a = peer("A", net)
    found(a)
    local names = {}
    for i = 1, 45 do names[i] = "M" .. i end
    add(a, names)
    net:advance(1)
    local late = peer("Late", net)
    net:advance(20)
    same({ a, late }); eq(count(late), 46)
end)
test("a peer that missed messages (loss) converges through heartbeats", function()
    local net = SimNetwork.New({ dropRate = 0.2, seed = 5 })
    local a, b = peer("A", net), peer("B", net)
    found(a)
    local names = {}
    for i = 1, 30 do names[i] = "M" .. i end
    add(a, names)
    net:advance(180)
    assert(net.stats.dropped > 0, "the network really dropped messages")
    same({ a, b }); eq(count(b), 31)
end)
test("duplicated and reordered messages are harmless", function()
    local net = SimNetwork.New({ duplicateRate = 0.6, jitter = 0.8, seed = 11 })
    local a, b = peer("A", net), peer("B", net)
    found(a)
    local names = {}
    for i = 1, 25 do names[i] = "M" .. i end
    add(a, names)
    net:advance(60)
    assert(net.stats.duplicated > 0)
    same({ a, b }); eq(count(b), 26)
end)
test("two officers writing at the same moment both count, on every peer", function()
    local net = SimNetwork.New()
    local a, b, c = peer("A", net), peer("B", net), peer("C", net)
    found(a, { "B" }); net:advance(3)
    for i = 1, 5 do
        assert(a.engine:Append("main", "AddMember", { member = "A" .. i }))
        assert(b.engine:Append("main", "AddMember", { member = "B" .. i }))
        net:advance(0.05)
    end
    net:advance(10)
    same({ a, b, c }); eq(count(c), 11); eq(#c.engine:Conflicts(), 0)
end)

H.section("Sync: splits and parallel raids")
test("both sides of a split keep writing; after healing everything is merged, nothing set aside", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a, { "B" }); net:advance(3)
    net:partition({ { "A-Realm" }, { "B-Realm" } })
    add(a, { "X1", "X2", "X3" })
    add(b, { "Y1", "Y2", "Y3", "Y4", "Y5" })
    net:advance(10)
    assert(fp(a) ~= fp(b), "the two sides really differed")
    net:heal(); net:advance(30)
    same({ a, b }); eq(count(a), 9); eq(a.engine.db.orphans, nil); eq(b.engine.db.orphans, nil)
end)
test("two raids at once: each Master Looter's awards reach the other almost at once (guild channel)", function()
    local net = SimNetwork.New()
    local raid1, raid2 = { "MLA", "A1", "A2" }, { "MLB", "B1", "B2" }
    local off = peer("Off", net)
    local mla, mlb = peer("MLA", net, { raid = raid1 }), peer("MLB", net, { raid = raid2 })
    found(off)
    add(off, { "A1", "A2", "B1", "B2" })
    assert(off.engine:Write("Elevate", { raid = "r1", ml = "MLA-Realm", minutes = 360 }))
    assert(off.engine:Write("Elevate", { raid = "r2", ml = "MLB-Realm", minutes = 360 }))
    net:advance(5)
    same({ off, mla, mlb })
    assert(mla.engine:Append("main", "Award", { member = "A1-Realm", item = "Helm" }))
    assert(mlb.engine:Append("main", "Award", { member = "B1-Realm", item = "Cloak" }))
    net:advance(1)
    same({ off, mla, mlb }); eq(#off.engine:Conflicts(), 0)
    eq(order(off), "A2,B2,A1,B1")
end)
test("parallel raids with a split network still converge, and the officer's own writes during the raid are skipped", function()
    local net = SimNetwork.New()
    local off = peer("Off", net)
    local mla, mlb = peer("MLA", net), peer("MLB", net)
    found(off)
    add(off, { "A1", "A2", "A3", "B1", "B2", "B3" })
    assert(off.engine:Write("Elevate", { raid = "r1", ml = "MLA-Realm", minutes = 360 }))
    assert(off.engine:Write("Elevate", { raid = "r2", ml = "MLB-Realm", minutes = 360 }))
    net:advance(5)
    net:partition({ { "MLA-Realm" }, { "MLB-Realm", "Off-Realm" } })
    for _, n in ipairs { "A2", "A1", "A3" } do assert(mla.engine:Append("main", "Award", { member = n .. "-Realm", item = "x" })); net:advance(2) end
    for _, n in ipairs { "B3", "B1" } do assert(mlb.engine:Append("main", "Award", { member = n .. "-Realm", item = "y" })); net:advance(2) end
    local _, why = off.engine:Append("main", "AddMember", { member = "Late-Realm" })
    eq(why, "duringraid", "the officer is told, and nothing is written")
    net:heal(); net:advance(30)
    same({ off, mla, mlb }); eq(#off.engine:Conflicts(), 0)
    local raid1 = {}
    for _, n in ipairs(off.engine:Get("main").state.order) do if n:find("^A") then raid1[#raid1 + 1] = n:gsub("%-Realm", "") end end
    eq(table.concat(raid1, ","), "A2,A1,A3", "raid 1's order is exactly what its own awards made it")
end)

H.section("Sync: robustness")
test("restricted sending queues events and delivers them when the restriction lifts", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a); net:advance(3)
    a.client:setRestricted(true)
    add(a, { "X", "Y" })
    net:advance(6)
    eq(count(b), 1); assert(a.sync:status().pending > 0); eq(a.sync:status().blocked, "restricted")
    a.client:setRestricted(false); net:advance(2)
    eq(count(b), 3); eq(a.sync:status().pending, 0)
end)
test("a large event is split into frames and reassembled", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a); add(a, { "X" }); net:advance(3)
    a.client:clearSent()
    assert(a.engine:Append("main", "Award", { member = "X-Realm", item = string.rep("item-link-", 80) }))
    assert(#a.client.sent > 1, "needed several frames")
    for _, m in ipairs(a.client.sent) do assert(#m.payload <= 255) end
    net:advance(3)
    same({ a, b })
end)
test("a tampered event is rejected and does not change the receiver", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a); net:advance(3)
    local before = fp(b)
    local chain = a.engine.store.chains[a.engine:MyChain()]
    local forged = { v = 2, ledger = a.engine:LedgerId(), chain = chain.id, seq = #chain.events + 1, prev = chain.head,
        ts = 1760000100, author = "A-Realm", type = "AddMember", list = "main", data = { member = "Evil-Realm" }, id = "deadbeefdeadbeef" }
    a.sync:post({ t = "E", c = chain.id, n = forged.seq, events = { forged } }, "GUILD")
    net:advance(3)
    eq(fp(b), before); assert(b.sync.stats.rejected >= 1)
end)
test("another guild's ledger is ignored", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a); found(b); net:advance(12)
    assert(fp(a) ~= fp(b)); assert(a.sync.stats.otherLedger > 0)
    eq(a.engine:LedgerId() ~= b.engine:LedgerId(), true)
end)
test("the same writer on two machines (stale data): the longer branch wins everywhere, the rest is kept", function()
    local net = SimNetwork.New()
    local a, b = peer("A", net), peer("B", net)
    found(a, { "B" }); net:advance(3)
    -- a second copy of A's saved data, as on another PC, writes 3 events; the real A writes 1
    local function copy(t)
        if type(t) ~= "table" then return t end
        local out = {}
        for k, v in pairs(t) do out[k] = copy(v) end
        return out
    end
    local clone = peer("A", nil, { storage = copy(a.client:storage()), clock = 1000 + net.time, unix = 1760000000 + math.floor(net.time) })
    add(a, { "Real" })
    clone.client:advance(1); add(clone, { "Stale1", "Stale2", "Stale3" })
    net:partition({ { "A-Realm" }, { "B-Realm" } })
    net:advance(3)
    for _, ev in ipairs(clone.engine.store.chains[clone.engine:MyChain()].events) do b.engine:Receive(ev) end
    local resolved = {}
    a.sync:on("forkResolved", function(p) resolved[#resolved + 1] = p.winner end)
    net:heal(); net:advance(40)
    same({ a, b })
    eq(order(a):find("Stale3") ~= nil, true, "the longer branch won"); eq(order(a):find("Real"), nil)
    eq(#a.engine.db.orphans, 1); eq(a.engine.db.orphans[1].events[1].data.member, "Real-Realm")
    eq(resolved[1], "theirs")
end)
test("identical histories give identical fingerprints on independent runs (determinism)", function()
    local function run()
        seedCounter = 0
        local net = SimNetwork.New({ seed = 3, jitter = 0.3 })
        local a, b = peer("A", net), peer("B", net)
        found(a); add(a, { "X", "Y" }); net:advance(5)
        return fp(b)
    end
    eq(run(), run())
end)
