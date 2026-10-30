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

H.section("Sim: Molten Core")
local MC = SK.modules.MoltenCore
test("the Molten Core data is complete and consistent", function()
    eq(#MC.bosses, 10); eq(MC.bosses[1].name, "Lucifron"); eq(MC.bosses[10].name, "Ragnaros")
    for _, b in ipairs(MC.bosses) do
        assert(b.drops >= 1 and #b.loot > b.drops, b.name)
        for _, entry in ipairs(b.loot) do
            local item = MC.items[entry[1]]
            assert(item, b.name .. " drops an unknown item " .. entry[1])
            assert(item.classes ~= 0 or item.role, item.name .. " has neither a class nor a role")
        end
    end
    eq(MC.items[17076].name, "Bonereaver's Edge"); eq(MC.items[16863].name, "Gauntlets of Might")
end)
test("who wants what follows class, armor and role", function()
    local function wants(id, class, role) return Sim.Wants(MC, MC.items[id], class, role) end
    eq(wants(16863, "WARRIOR", "tank"), "need", "tier gloves for a warrior"); eq(wants(16863, "PALADIN", "healer"), nil)
    eq(wants(17109, "PRIEST", "healer"), "need", "healer neck"); eq(wants(17109, "MAGE", "caster"), nil)
    eq(wants(18875, "PRIEST", "healer"), nil, "leather healer legs are not for a priest")
    eq(wants(18875, "DRUID", "tank"), "off", "but a tank druid takes them as off-spec")
    eq(wants(17066, "WARRIOR", "melee"), "off", "a dps warrior wants the tank shield as off-spec")
end)
test("a full Molten Core night, one boss at a time, ends cleanly", function()
    local sim = Sim.NewMoltenCore({ seed = 3 })
    sim.autoLearner = true
    local items = 0
    for _ = 1, 10 do
        local boss, dropped = sim:killBoss()
        assert(boss); items = items + #dropped
        assert(sim:runUntil("review", 600), boss.name .. " stuck in " .. sim.session.phase)
        local ok, failures = sim.session:confirm(); assert(ok); eq(#failures, 0)
    end
    assert(items >= 20)
    eq(#sim.engine:Get("main").state.order, 40); eq(#sim.engine:Conflicts(), 0)
end)
test("loot held until a break is handed out in one batch under the same rules", function()
    local sim = Sim.NewMoltenCore({ seed = 5 })
    sim.autoLearner = true
    for _ = 1, 4 do assert(sim:killBoss(nil, true)) end
    assert(#sim.held >= 8)
    assert(sim:handOut())
    assert(sim:runUntil("review", 900))
    assert(sim.session:confirm())
    local done = 0
    for _, it in ipairs(sim.session.items) do if it.status == "awarded" or it.status == "de" then done = done + 1 end end
    eq(done, #sim.session.items)
end)
test("the same seed gives the same night", function()
    local function night()
        local sim = Sim.NewMoltenCore({ seed = 9 })
        sim.autoLearner = true
        for _ = 1, 3 do sim:killBoss(); sim:runUntil("review", 600); sim.session:confirm() end
        return sim.engine:Fingerprint()
    end
    eq(night(), night())
end)
test("held loot is recorded with the time it dropped, not the time it was handed out", function()
    local sim = Sim.NewMoltenCore({ seed = 5 })
    sim.autoLearner = true
    local dropAt = sim.client:serverTime()
    sim:killBoss(nil, true)
    sim.client:advance(3600) -- an hour later, at the break
    assert(sim:handOut()); assert(sim:runUntil("review", 900)); assert(sim.session:confirm())
    local awards = 0
    for _, ev in ipairs(sim.engine:View().applied) do
        if ev.type == "Award" then
            awards = awards + 1
            eq(ev.data.seen, dropAt); assert(ev.ts >= dropAt + 3600)
        end
    end
    assert(awards > 0)
end)

H.section("Simulator: raiders with specs, deciding from real item stats")
local ItemFit = SK.modules.ItemFit
test("every raider has a class, a main spec and (hybrids) an off-spec; the learner is a Holy priest", function()
    local sim = Sim.NewMoltenCore({ seed = 1 })
    eq(#sim.names, 40)
    local specs = {}
    for _, n in ipairs(sim.names) do
        local info = sim.info[n]
        local spec = ItemFit.SpecOf(info.class, info.spec)
        assert(spec, n .. " has a spec of their class"); eq(info.role, spec.role, n)
        if info.offSpec then assert(ItemFit.SpecOf(info.class, info.offSpec), n .. "'s off-spec") end
        specs[info.spec .. " " .. info.class] = (specs[info.spec .. " " .. info.class] or 0) + 1
    end
    eq(sim.info.You.spec, "Holy"); eq(sim.info.You.offSpec, "Shadow"); eq(specs["Holy PRIEST"], 5)
    eq(specs["Protection WARRIOR"], 3); eq(specs["Feral (bear) DRUID"], 1)
end)

-- Run a whole night, checking every bid and every win against the raider who made it.
local function night(sim, data)
    sim.autoLearner = true
    local refused, checked = 0, 0
    for _ = 1, #data.bosses do
        local boss = sim:killBoss()
        assert(boss)
        local s = sim.session
        local bid = s.bid
        s.bid = function(self, player, itemId, kind, extra)
            local ok, why = bid(self, player, itemId, kind, extra)
            if why == "wrongclass" or why == "wrongclassto" then refused = refused + 1 end
            return ok, why
        end
        assert(sim:runUntil("review", 900), boss.name)
        for i, it in ipairs(s.items) do
            if it.tier == "main" or it.tier == "off" then
                local item = sim.handedOut[i].item
                local info = sim.info[(it.winner:gsub("%-.*$", ""))]
                local want = Sim.Wants(data, item, info.class, info.role, info.spec, info.offSpec)
                if it.winner ~= sim.learner then
                    eq(want, it.tier == "main" and "need" or "off",
                        ("%s (%s) won on %s by a %s %s"):format(item.name, it.tier, boss.name, info.spec, info.class))
                    checked = checked + 1
                end
            end
        end
        assert(s:confirm())
    end
    return refused, checked
end

test("a Molten Core night: no bot bids for another class's item, and every win fits the winner's spec", function()
    local refused, checked = night(Sim.NewMoltenCore({ seed = 7 }), SK.modules.MoltenCore)
    eq(refused, 0, "bots know their class"); assert(checked >= 15, "wins checked: " .. checked)
end)
test("an Ahn'Qiraj night: the same, with tokens", function()
    local refused, checked = night(Sim.NewAQ40({ seed = 7 }), SK.modules.AQ40)
    eq(refused, 0); assert(checked >= 15, "wins checked: " .. checked)
end)
test("the session's class rule applies in the simulator: a mage can't need a warrior's tier piece", function()
    local sim = Sim.NewMoltenCore({ seed = 2 })
    local MC = SK.modules.MoltenCore
    sim:teach(MC.items[16863]) -- Gauntlets of Might (warrior tier)
    assert(sim:drop({ "Gauntlets of Might" }))
    local mage, warrior
    for _, n in ipairs(sim.names) do
        if sim.info[n].class == "MAGE" then mage = mage or n end
        if sim.info[n].class == "WARRIOR" then warrior = warrior or n end
    end
    eq(select(2, sim.session:bid(mage, 1, "need")), "wrongclass"); assert(sim.session:bid(warrior, 1, "need"))
end)
test("item stats come from the CMaNGOS database: every raid item can be judged", function()
    for _, data in ipairs { SK.modules.MoltenCore, SK.modules.AQ40 } do
        for _, it in pairs(data.items) do assert(it.fit and it.fit.stats, it.name .. " has no fit") end
    end
    local choker = SK.modules.MoltenCore.items[17109].fit.stats -- Choker of Enlightenment
    eq(choker.int, 10); eq(choker.spi, 10); eq(choker.sta, 9); eq(choker.sp, 18)
end)
