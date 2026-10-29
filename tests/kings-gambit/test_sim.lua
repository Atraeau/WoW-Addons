-- Simulated raids and training scenarios. Every scenario is run against the real engine, so
-- the lessons shown to learners cannot drift from the rules.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Sim, Scenarios = SK.modules.Sim, SK.modules.Scenarios

H.section("Sim: scenarios")
for _, sc in ipairs(Scenarios.list) do
    test("scenario '" .. sc.id .. "' ends as its lesson says", function()
        local _, ok, message = Sim.RunScenario(sc)
        assert(ok, "scenario failed: " .. tostring(message))
    end)
end
test("scenarios are deterministic for a given seed", function()
    for _, sc in ipairs(Scenarios.list) do
        local a = Sim.RunScenario(sc, { seed = 7 })
        local b = Sim.RunScenario(sc, { seed = 7 })
        eq(a.engine:Get("main").head, b.engine:Get("main").head, sc.id)
    end
end)
test("every scenario has the fields a training UI needs", function()
    local seen = {}
    for _, sc in ipairs(Scenarios.list) do
        assert(sc.id and not seen[sc.id], "unique id"); seen[sc.id] = true
        assert(type(sc.title) == "string" and type(sc.lesson) == "string" and #sc.lesson > 40)
        assert(type(sc.members) == "table" and type(sc.items) == "table" and type(sc.expect) == "function")
    end
    assert(Scenarios.find("first-drop") and not Scenarios.find("nope"))
end)

H.section("Sim: raid and bots")
test("a raid starts with the learner last and bots answering over time", function()
    local sim = Sim.NewRaid({ members = { "Aldric", "Brann" } })
    eq(sim:orderString(), "Aldric,Brann,You")
    sim.policies.Aldric = { bid = { ["X"] = "need" } }
    assert(sim:drop({ "X" }))
    eq(sim.session.phase, "bidding")
    sim:advance(0.5); eq(sim.session:status().answered, 0, "nobody has answered yet")
    sim:advance(16)
    assert(sim.session:status().answered >= 2, "the bots answered; only the human learner is still out")
    eq(sim.session.phase, "bidding", "still waiting for You")
    assert(sim.session:bid("You", 1, "pass"))
    eq(sim.session.phase, "review")
end)
test("a shuffled raid is repeatable from its seed", function()
    local a = Sim.NewRaid({ members = { "A", "B", "C", "D", "E" }, shuffle = true, seed = 9 })
    local b = Sim.NewRaid({ members = { "A", "B", "C", "D", "E" }, shuffle = true, seed = 9 })
    local c = Sim.NewRaid({ members = { "A", "B", "C", "D", "E" }, shuffle = true, seed = 10 })
    eq(a:orderString(), b:orderString()); assert(a:orderString() ~= c:orderString())
end)
test("the human learner's draft turn waits for them", function()
    local sim = Sim.NewRaid({ members = { "Aldric" }, learnerPosition = "first" })
    sim.policies.Aldric = { bid = { ["X"] = "need", ["Y"] = "need" } }
    assert(sim:drop({ "X", "Y" }))
    assert(sim.session:bid("You", 1, "need")); assert(sim.session:bid("You", 2, "need"))
    sim:advance(16)
    eq(sim.session.phase, "main"); eq(sim.session.turn.player, "You-Realm", "bots wait for You; the turn does not auto-play")
    assert(sim.session:pick("You", 2))
    -- ...and like any turn, it times out if the human does nothing.
    local sim2 = Sim.NewRaid({ members = { "Aldric" }, learnerPosition = "first" })
    sim2.policies.Aldric = { bid = { ["X"] = "need", ["Y"] = "need" } }
    assert(sim2:drop({ "X", "Y" }))
    assert(sim2.session:bid("You", 1, "need")); assert(sim2.session:bid("You", 2, "need"))
    sim2:advance(16); eq(sim2.session.turn.player, "You-Realm"); sim2:advance(21)
    assert(not sim2.session.turn or sim2.session.turn.player ~= "You-Realm", "the unanswered turn counted as a skip")
end)
test("snapshot is plain data (no functions or cycles) ready for a UI", function()
    local sim = Sim.NewRaid({ members = { "Aldric", "Brann" } })
    sim.autoLearner = true
    assert(sim:drop({ "X" })); sim:runUntil("review", 100)
    local function check(v, depth)
        assert(depth < 8, "too deep or cyclic")
        local t = type(v)
        assert(t ~= "function" and t ~= "userdata" and t ~= "thread", "no " .. t)
        if t == "table" then for _, x in pairs(v) do check(x, depth + 1) end end
    end
    local snap = sim:snapshot(); check(snap, 0)
    eq(snap.phase, "review"); eq(#snap.items, 1); eq(snap.items[1].status, "de", "nobody wanted it")
end)
