-- Randomized convergence test: random writes, splits, heals, loss, duplication and restrictions
-- across several peers; afterwards the network is repaired and everyone must agree on one valid
-- ledger. Each seed is a deterministic run, so any failure is reproducible from its seed number.
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
        local c = p.engine:Get("main")
        out[#out + 1] = ("%s: %s events head %s"):format(p.name, c and #c.events or "none", c and c.head:sub(1, 8) or "-")
    end
    return table.concat(out, "; ")
end

local function run(seed)
    local r = rng(seed)
    local net = SimNetwork.New({ seed = seed, latency = 0.15, quantum = 0.25,
        dropRate = r() * 0.25, duplicateRate = r() * 0.4, jitter = r() * 0.5 })
    local count = 3 + r(2) - 1 -- 3 or 4 peers
    local peers = {}
    for i = 1, count do
        local name = "P" .. i
        local client = MockClient.New({ name = name, realm = "Realm", seed = seed * 31 + i })
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
        net:attach(client)
        sync:start()
        peers[i] = { name = name, full = name .. "-Realm", client = client, engine = engine, sync = sync }
    end
    assert(peers[1].engine:CreateList("main", "Main"))
    for i = 1, 4 do assert(peers[1].engine:Append("main", "AddMember", { member = "M" .. i .. "-Realm" })) end
    net:advance(3)

    local counter = 100
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
        if roll < 0.45 then
            counter = counter + 1
            p.engine:Append("main", "AddMember", { member = "X" .. counter .. "-Realm" })
        elseif roll < 0.65 and chain and #chain.state.order > 0 then
            counter = counter + 1
            p.engine:Append("main", "Award", { member = chain.state.order[r(#chain.state.order)], item = "Item" .. counter })
        elseif roll < 0.72 and chain and #chain.state.order > 1 then
            counter = counter + 1
            p.engine:Append("main", "MovePlayer", { member = chain.state.order[r(#chain.state.order)], pos = "top", reason = "fuzz" .. counter })
        elseif roll < 0.80 then
            net:partition(randomGroups())
        elseif roll < 0.88 then
            net:heal()
        elseif roll < 0.93 then
            p.client:setRestricted(r() < 0.5)
        end
        net:advance(r() * 6)
    end

    -- repair everything, then give the group plenty of time
    net:heal()
    net.dropRate = 0
    for _, p in ipairs(peers) do p.client:setRestricted(false) end
    net:advance(240)

    H.lastPeers, H.lastNet = peers, net
    local base = peers[1].engine:Get("main")
    for _, p in ipairs(peers) do
        local c = p.engine:Get("main")
        assert(c, p.name .. " never got the list. " .. describe(seed, peers))
        assert(c.head == base.head, "heads differ. " .. describe(seed, peers))
        assert(not next(p.engine.problems), p.name .. " has a corrupt list")
        local reloaded, err, idx = Ledger.Load("main", c.events)
        assert(reloaded, ("%s's chain does not verify (%s at %s). %s"):format(p.name, tostring(err), tostring(idx), describe(seed, peers)))
        local replayed = Standings.Replay(c.events)
        eq(Standings.Digest(replayed), Standings.Digest(c.state), "replayed standings match live state, " .. p.name)
        assert(p.sync:status().pending == 0, p.name .. " still has unsent messages. " .. describe(seed, peers))
    end
end

H.fuzzRun = run
H.section("Fuzz: convergence under random faults")
local SEEDS = 40
for seed = 1, SEEDS do
    test("seed " .. seed .. ": everyone converges to one valid ledger", function() run(seed) end)
end
