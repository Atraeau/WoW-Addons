-- Randomized convergence test (ledger v2): several officers, parallel raids with Master Looters whose
-- privilege expires, random writes, splits, heals, loss, duplication and restriction. Afterwards the network
-- is repaired and every peer must agree on one valid ledger: the same fingerprint, the same standings and the
-- same skipped conflicts. Each seed is a deterministic run, so any failure is reproducible from its number.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local Ledger, Standings = SK.modules.Ledger, SK.modules.Standings

local function rng(seed)
    local s = (seed * 7919 + 13) % 2147483647 + 0.0
    return function(n)
        s = (s * 16807) % 2147483647
        return n and (math.floor(s / 2147483647 * n) + 1) or (s / 2147483647)
    end
end

local function describe(seed, peers)
    local out = { "seed " .. seed }
    for _, p in ipairs(peers) do
        out[#out + 1] = ("%s: fp %s, %d conflicts"):format(p.name, tostring(p.engine:Fingerprint()):sub(1, 8), #p.engine:Conflicts())
    end
    return table.concat(out, "; ")
end

local function conflictKey(engine)
    local out = {}
    for _, c in ipairs(engine:Conflicts()) do out[#out + 1] = c.id .. ":" .. c.reason end
    return table.concat(out, ",")
end

local function run(seed)
    local r = rng(seed)
    local net = SimNetwork.New({ seed = seed, latency = 0.15, quantum = 0.25,
        dropRate = r() * 0.25, duplicateRate = r() * 0.4, jitter = r() * 0.5 })
    local count = 3 + r(2) - 1 -- 3 or 4 peers
    local peers, names = {}, {}
    for i = 1, count do
        local name = "P" .. i
        local client = MockClient.New({ name = name, realm = "Realm", seed = seed * 31 + i })
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
        net:attach(client)
        sync:start()
        peers[i] = { name = name, full = name .. "-Realm", client = client, engine = engine, sync = sync }
        names[i] = name .. "-Realm"
    end
    local gm = peers[1]
    assert(gm.engine:CreateList("main", "Main"))
    local officers = {}
    for i = 2, count do if r() < 0.7 then officers[#officers + 1] = names[i] end end
    assert(gm.engine:Write("SetOfficers", { names = officers }))
    for i = 1, 6 do assert(gm.engine:Append("main", "AddMember", { member = "M" .. i .. "-Realm" })) end
    net:advance(3)

    local counter, raids = 100, 0
    local function randomGroups()
        local g, n = {}, r(count)
        for i = 1, count do
            local k = r(n)
            g[k] = g[k] or {}
            g[k][#g[k] + 1] = peers[i].full
        end
        local out = {}
        for _, v in pairs(g) do out[#out + 1] = v end
        return out
    end

    for _ = 1, 45 do
        local roll = r()
        local p = peers[r(count)]
        local chain = p.engine:Get("main")
        local order = chain and chain.state.order or {}
        if roll < 0.35 then
            counter = counter + 1
            p.engine:Append("main", "AddMember", { member = "X" .. counter .. "-Realm" })
        elseif roll < 0.55 and #order > 0 then
            counter = counter + 1
            local data = { member = order[r(#order)], item = "Item" .. counter }
            if r() < 0.5 then data.seen = p.client:serverTime() - r(1800) end -- loot held since it dropped
            p.engine:Append("main", "Award", data)
        elseif roll < 0.60 and #order > 1 then
            counter = counter + 1
            p.engine:Append("main", "MovePlayer", { member = order[r(#order)], above = order[r(#order)], reason = "fuzz" .. counter })
        elseif roll < 0.66 then
            raids = raids + 1
            p.engine:Write("Elevate", { raid = "r" .. raids, ml = names[r(count)], minutes = r(3) })
        elseif roll < 0.70 then
            for _, raid in ipairs(p.engine:ActiveRaids()) do
                if raid.ml == p.full then p.engine:Write("RaidClose", { raid = raid.id }); break end
            end
        elseif roll < 0.78 then
            net:partition(randomGroups())
        elseif roll < 0.86 then
            net:heal()
        elseif roll < 0.91 then
            p.client:setRestricted(r() < 0.5)
        end
        net:advance(r() * 6)
    end

    net:heal()
    net.dropRate = 0
    for _, p in ipairs(peers) do p.client:setRestricted(false) end
    net:advance(240)

    H.lastPeers, H.lastNet = peers, net
    local base = peers[1].engine
    for _, p in ipairs(peers) do
        local e = p.engine
        assert(e:Fingerprint() == base:Fingerprint(), "fingerprints differ. " .. describe(seed, peers))
        assert(not next(e.problems), p.name .. " has a corrupt chain")
        eq(conflictKey(e), conflictKey(base), "seed " .. seed .. ": the same events skipped everywhere, " .. p.name)
        eq(Standings.Digest(e:Get("main").state), Standings.Digest(base:Get("main").state), "seed " .. seed .. ": same standings, " .. p.name)
        local fresh = Ledger.View(e.store)
        eq(Standings.Digest(fresh.lists.main), Standings.Digest(e:Get("main").state), "seed " .. seed .. ": live view equals a fresh replay, " .. p.name)
        local saved = { chains = {} }
        for cid, c in pairs(e.store.chains) do saved.chains[cid] = { events = c.events } end
        local _, problems = Ledger.LoadStore(saved)
        assert(not next(problems), ("%s's chains do not verify. %s"):format(p.name, describe(seed, peers)))
        assert(p.sync:status().pending == 0, p.name .. " still has unsent messages. " .. describe(seed, peers))
    end
end

H.fuzzRun = run
H.section("Fuzz: convergence under random faults (officers, parallel raids, expiry, batched hand-outs)")
local SEEDS = 40
for seed = 1, SEEDS do
    test("seed " .. seed .. ": everyone converges to one valid ledger", function() run(seed) end)
end
