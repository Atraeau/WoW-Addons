-- Randomized rules test: random events of every type, valid and invalid, thrown at a list.
-- Invariants after every event: the order has no duplicates and contains exactly the active
-- members; a rejected event changes nothing; replaying the stored events reproduces the state.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Standings, Ledger = SK.modules.MockClient, SK.modules.Engine, SK.modules.Standings, SK.modules.Ledger

local function rng(seed)
    local s = (seed * 15485863 + 3) % 2147483647 + 0.0
    return function(n)
        s = (s * 16807) % 2147483647
        return n and (math.floor(s / 2147483647 * n) + 1) or (s / 2147483647)
    end
end

local NAMES = {}
for i = 1, 12 do NAMES[i] = "P" .. i .. "-Realm" end

local function checkInvariants(chain, label)
    local s = chain.state
    local seen = {}
    for i, name in ipairs(s.order) do
        assert(not seen[name], label .. ": duplicate in order: " .. name)
        seen[name] = i
        assert(s.members[name] and s.members[name].active, label .. ": inactive member in order: " .. name)
    end
    for name, m in pairs(s.members) do
        eq(m.active and seen[name] ~= nil or (not m.active and seen[name] == nil), true, label .. ": order/active mismatch for " .. name)
        assert(m.wins >= 0 and m.passes >= 0 and m.upgradePasses <= m.passes, label .. ": stats out of range for " .. name)
    end
    for _, stack in pairs(s.undo) do
        for _, u in ipairs(stack) do
            assert(s.awards[u.id] and not s.awards[u.id].reverted, label .. ": undo stack points at a missing or reverted award")
        end
    end
end

local function snapshot(chain)
    return table.concat(chain.state.order, ",") .. "|" .. #chain.events .. "|" .. chain.head
end

local function randomEvent(r, chain, engine)
    local pick = function() return NAMES[r(#NAMES)] end
    local roll = r(11)
    local s = chain.state
    local awardIds = {}
    for id in pairs(s.awards) do awardIds[#awardIds + 1] = id end
    table.sort(awardIds)
    local anchors = { { to = "top" }, { to = "bottom" }, { above = pick() }, { to = "middle" }, { above = "" }, {} }
    local function where(d) for k, v in pairs(anchors[r(#anchors)]) do d[k] = v end return d end
    if roll == 1 then return "AddMember", where({ member = pick() })
    elseif roll == 2 then return "RemoveMember", { member = pick() }
    elseif roll == 3 or roll == 4 then return "Award", { member = pick(), item = ({ "A", "B", "", "C" })[r(4)], to = ({ pick(), "", false })[r(3)] or nil }
    elseif roll == 5 then return "Pass", { member = pick(), item = "I", kind = ({ "upgrade", "x" })[r(2)] }
    elseif roll == 6 then return "Transfer", { award = (#awardIds > 0 and awardIds[r(#awardIds)] or "nope"), to = pick() }
    elseif roll == 7 then return "MovePlayer", where({ member = pick(), reason = ({ "fix", "" })[r(2)] })
    elseif roll == 8 then
        local mine = s.undo[engine:MyChain()] or {}
        local top = mine[#mine]
        return "Revert", { target = (top and r(4) > 1) and top.id or (awardIds[1] or "nope") }
    elseif roll == 9 then return "Disenchant", { item = "I", to = pick() }
    elseif roll == 10 then return "Salvage", { award = (#awardIds > 0 and awardIds[r(#awardIds)] or "nope"), action = ({ "keep", "sell", "burn" })[r(3)] }
    else return "Bogus", {} end
end

local function run(seed)
    local r = rng(seed)
    local client = MockClient.New({ name = "Raidlead", realm = "Realm", seed = seed })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    local chain = engine:Get("main")
    local accepted, rejected = 0, 0
    for step = 1, 150 do
        chain = engine:Get("main")
        local before = snapshot(chain)
        local type_, data = randomEvent(r, chain, engine)
        local ev, err = engine:Append("main", type_, data)
        if ev then
            accepted = accepted + 1
        else
            rejected = rejected + 1
            chain = engine:Get("main")
            eq(snapshot(chain), before, ("seed %d step %d: rejected %s (%s) changed state"):format(seed, step, type_, tostring(err)))
        end
        chain = engine:Get("main")
        checkInvariants(chain, ("seed %d step %d after %s"):format(seed, step, type_))
        if r(5) == 1 then client:advance(r(3)) end
    end
    local replayed = Ledger.View(engine.store).lists.main
    eq(Standings.Digest(replayed), Standings.Digest(chain.state), "seed " .. seed .. ": replay matches live state")
    local saved = { chains = {} }
    for cid, c in pairs(engine.store.chains) do saved.chains[cid] = { events = c.events } end
    local _, problems = Ledger.LoadStore(saved)
    assert(not next(problems), "seed " .. seed .. ": chains verify")
    return accepted, rejected
end

H.rulesFuzzRun = run
H.section("Fuzz: the ledger rules under random events")
local SEEDS = 60
for seed = 1, SEEDS do
    test("seed " .. seed .. ": invariants hold and rejected events change nothing", function()
        local accepted, rejected = run(seed)
        assert(accepted >= 5 and rejected >= 10, ("a useful mix of valid and invalid events (%d/%d)"):format(accepted, rejected))
    end)
end
