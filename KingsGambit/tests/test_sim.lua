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
            assert(item.classes ~= 0 or item.fit, item.name .. " has neither a class nor a fit")
        end
    end
    eq(MC.items[17076].name, "Bonereaver's Edge"); eq(MC.items[16863].name, "Gauntlets of Might")
end)
test("who wants what follows class, spec and the item's real stats (no list of items)", function()
    local function wants(id, class, spec, off) return Sim.Wants(MC, MC.items[id], class, nil, spec, off) end
    eq(wants(16863, "WARRIOR", "Protection"), "need", "tier gloves for a warrior"); eq(wants(16863, "PALADIN", "Holy"), nil)
    eq(wants(17109, "PRIEST", "Holy"), "need", "Choker of Enlightenment: healing"); eq(wants(17109, "MAGE", "Fire"), "need", "and spell damage")
    eq(wants(17109, "WARRIOR", "Fury"), nil)
    eq(wants(17066, "WARRIOR", "Fury", "Protection"), "off", "Drillborer Disk: a dps warrior's off-spec tank shield")
    eq(wants(18816, "ROGUE", "Combat"), "need", "Perdition's Blade"); eq(wants(18816, "PRIEST", "Holy"), nil)
    eq(wants(17103, "MAGE", "Frost"), "need", "Azuresong Mageblade is a caster sword"); eq(wants(17103, "WARRIOR", "Fury"), nil)
end)
test("items that only become something are judged by what they become: the Bindings by Thunderfury", function()
    local function wants(id, class, spec) return Sim.Wants(MC, MC.items[id], class, nil, spec) end
    for _, id in ipairs { 18563, 18564, 19017 } do -- Bindings of the Windseeker (Geddon, Garr), Essence of the Firelord
        eq(wants(id, "WARRIOR", "Fury"), "need", MC.items[id].name); eq(wants(id, "MAGE", "Fire"), nil, MC.items[id].name)
    end
    eq(wants(17204, "PALADIN", "Retribution"), "need", "Eye of Sulfuras: Sulfuras, a two-handed mace")
end)
test("where the heuristic can't judge an item, an officer's call decides, from the ledger", function()
    local sim = Sim.NewMoltenCore({ seed = 1 })
    local shard = sim.engine:ItemSuits(17082) -- Shard of the Flame
    eq(shard.roles[1], "tank"); assert(shard.reason:find("for tanks"))
    eq(Sim.Wants(MC, MC.items[17082], "WARRIOR", nil, "Protection", nil, shard), "need")
    eq(Sim.Wants(MC, MC.items[17082], "WARRIOR", nil, "Protection"), nil, "without the call, nobody")
    eq(Sim.Wants(MC, MC.items[17082], "MAGE", nil, "Fire", nil, shard), nil)
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
                local want = Sim.Wants(data, item, info.class, info.role, info.spec, info.offSpec, sim.engine:ItemSuits(item.id))
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
test("the Master Looter is a raider like any other: in a raid night they start anywhere on the list", function()
    local places = {}
    for seed = 1, 6 do
        local sim = Sim.NewMoltenCore({ seed = seed })
        for i, n in ipairs(sim:order()) do if n == "You" then places[i] = true end end
    end
    local distinct = 0
    for _ in pairs(places) do distinct = distinct + 1 end
    assert(distinct >= 4, "the learner's starting place varies with the seed")
    eq(Sim.NewRaid({ members = { "A", "B" } }):order()[3], "You", "a training scenario still sets its own layout")
end)
test("the guild's rules apply to simulated drops too: an officer's eligibility rule lets the learner bid", function()
    local sim = Sim.NewMoltenCore({ seed = 1 })
    local MC = SK.modules.MoltenCore
    assert(sim.engine:Write("ItemClasses", { item = 16805, classes = { "WARLOCK", "PRIEST" }, reason = "testing" }))
    sim.held = { { item = MC.items[16805], boss = "Lucifron", seen = sim.client:serverTime() } } -- Felheart Gloves (warlock tier)
    assert(sim:handOut())
    assert(sim.session:bid("You", 1, "need"), "a priest may need them now")
    local mage
    for _, n in ipairs(sim.names) do if sim.info[n].class == "MAGE" then mage = mage or n end end
    eq(select(2, sim.session:bid(mage, 1, "need")), "wrongclass")
end)

H.section("Sim: scenario items are real items")
test("in 'the first drop' only warriors may bid on the warrior-only gauntlets; a paladin is refused", function()
    local sc = SK.modules.Scenarios.find("first-drop")
    local sim = Sim.NewRaid({ members = sc.members })
    sim.policies = {}
    assert(sim:drop(sc.items))
    sim.client:setRaid({ { name = "Aldric", class = "WARRIOR" }, { name = "Pally", class = "PALADIN" }, { name = "You", class = "WARLOCK" } },
        { leader = "You", lootMethod = "master", masterLooter = "You" })
    sim.session:refreshRoster()
    eq(select(2, sim.session:bid("Pally", 1, "need")), "wrongclass", "a paladin can't need a warrior-only item")
    eq(select(2, sim.session:bid("You", 1, "need")), "wrongclass")
    assert(sim.session:bid("Aldric", 1, "need"))
    local fit = sim.session:fitOf(1)
    assert(fit and fit.classes, "the item is known to the session, with the classes it names")
end)
test("every training scenario's bidders can have the items they bid on", function()
    for _, sc in ipairs(SK.modules.Scenarios.list) do
        local sim = Sim.NewRaid({ members = sc.members })
        sim.policies = sc.policies or {}
        local refused = 0
        assert(sim:drop(sc.items))
        local bid = sim.session.bid
        sim.session.bid = function(self, player, id, kind, extra)
            local ok, why = bid(self, player, id, kind, extra)
            if not ok and (why == "wrongclass" or why == "cantequip") then refused = refused + 1 end
            return ok, why
        end
        sim:runUntil("main", 40)
        eq(refused, 0, sc.id .. " has a bidder whose class can't have the item")
    end
end)

H.section("Sim: nothing unrealistic can be dropped")
-- Sampled from the real loot tables (MoltenCore.lua, AQ40.lua): what real raid loot looks like.
test("raid loot is realistic: gear has a slot and nearly always stats; only quest items, reagents and tokens have no slot", function()
    for _, data in ipairs { SK.modules.MoltenCore, SK.modules.AQ40 } do
        local gear, withStats = 0, 0
        for _, it in pairs(data.items) do
            assert(it.id and it.name and it.fit and it.fit.class, "an item with an id, a name and a type")
            if it.fit.slot then
                gear = gear + 1
                assert(it.fit.class == 2 or it.fit.class == 4, it.name .. ": equippable items are weapons or armor")
                if next(it.fit.stats or {}) then withStats = withStats + 1
                else assert(it.fit.slot == "INVTYPE_TRINKET" or it.fit.slot == "INVTYPE_RELIC", it.name .. ": only trinkets and relics are statless") end
            else
                assert(it.fit.class == 7 or it.fit.class == 12 or it.fit.class == 15, it.name .. ": a slotless item is a reagent, quest item or token")
            end
        end
        assert(gear > 80 and withStats / gear > 0.9, "almost all gear has stats")
    end
end)
test("every training scenario drops real, equippable items with stats", function()
    for _, sc in ipairs(SK.modules.Scenarios.list) do
        for _, name in ipairs(sc.items) do
            local it = Sim.FindItem(name)
            assert(it, sc.id .. ": '" .. name .. "' is not a real raid item")
            assert(it.fit.slot and next(it.fit.stats), sc.id .. ": '" .. name .. "' has no slot or stats")
        end
    end
end)
test("free play drops real gear to a classed raid, and no bot bids on what its class can't have", function()
    local seenItems, classes = {}, {}
    for seed = 1, 60 do
        local free = Sim.FreePlay(seed)
        eq(#free.items, 3); eq(#free.members, 7)
        for _, name in ipairs(free.items) do
            local it = Sim.FindItem(name)
            assert(it and it.fit.slot and next(it.fit.stats), name .. " is real gear"); seenItems[name] = true
        end
        for _, m in ipairs(free.members) do assert(ItemFit.SpecOf(m.class, m.spec), "a real spec"); classes[m.class] = true end
        assert(ItemFit.SpecOf(free.learnerClass, free.learnerSpec))
        local sim = Sim.NewRaid({ members = free.members, seed = seed, learnerClass = free.learnerClass,
            learnerSpec = free.learnerSpec, learnerRole = free.learnerRole })
        sim.policies = free.policies
        local refused = 0
        assert(sim:drop(free.items))
        local bid = sim.session.bid
        sim.session.bid = function(self, player, id, kind, extra)
            local ok, why = bid(self, player, id, kind, extra)
            if not ok then refused = refused + 1 end
            return ok, why
        end
        sim.autoLearner = true
        assert(sim:runUntil("review", 600)); assert(sim.session:confirm())
        eq(refused, 0, "seed " .. seed .. ": a bot made a bid it couldn't")
    end
    local n = 0
    for _ in pairs(seenItems) do n = n + 1 end
    assert(n >= 25, "free play draws from the whole table: " .. n)
end)
test("free play is repeatable from its seed", function()
    local a, b = Sim.FreePlay(5), Sim.FreePlay(5)
    eq(table.concat(a.items, ","), table.concat(b.items, ","))
    assert(table.concat(a.items, ",") ~= table.concat(Sim.FreePlay(6).items, ","))
end)

H.section("Sim: the disenchanter is a raider, not the Master Looter")
test("each simulated raid names a disenchanter who is not the Master Looter, and unwanted loot goes to them", function()
    local night = Sim.NewMoltenCore({ seed = 1 })
    local designated = night:disenchanterName()
    assert(designated and designated ~= night.learner, "a raider, not the learner")
    local cl = night.info[(designated:gsub("%-.*$", ""))].class
    assert(cl == "MAGE" or cl == "WARLOCK" or cl == "PRIEST", "a cloth-wearer, the usual enchanter: " .. cl)
    local sc = SK.modules.Scenarios.find("nobody-wants-it")
    local sim, ok = Sim.RunScenario(sc)
    assert(ok)
    local de
    for _, ev in ipairs(sim.engine:Get("main").events) do if ev.type == "Disenchant" then de = ev end end
    assert(de and de.data.to ~= "You-Realm" and de.data.to == sim:disenchanterName(), "the disenchanter, not You")
    eq(Sim.NewRaid({ members = { "Solo" }, disenchanter = "Solo" }):disenchanterName(), "Solo-Realm")
end)
test("the Master Looter chooses the disenchanter for the raid; the choice is recorded and used for the next hand-out", function()
    local sim = Sim.NewRaid({ members = { "Aldric", "Brann", "Cass" } })
    sim.autoLearner = true
    local first = sim:disenchanterName()
    assert(first and first ~= sim.learner)
    eq(select(2, sim:setDisenchanter("Nobody")), "notinraid", "must be someone in the raid")
    assert(sim:setDisenchanter("Brann"))
    eq(sim:disenchanterName(), "Brann-Realm")
    local found
    for _, ev in ipairs(sim.engine:View().authApplied) do if ev.type == "SetDisenchanter" and ev.data.name == "Brann-Realm" then found = ev end end
    assert(found and found.author == sim.learner, "recorded in the ledger by the Master Looter")
    assert(sim:drop({ "Crimson Shocker" })); assert(sim:runUntil("review", 100)); assert(sim.session:confirm())
    eq(sim.session.deHandler, "Brann-Realm")
end)
test("if the learner lets the ring go unclaimed, the lesson says what happened", function()
    local sc = {}
    for k, v in pairs(SK.modules.Scenarios.find("minor-upgrade-proxy")) do sc[k] = v end
    sc.you = { claim = false }
    local _, ok, message = Sim.RunScenario(sc)
    assert(not ok and message:find("nobody claimed the ring"), tostring(message))
end)
test("a salvager can gift only to someone eligible for the item; the page is told who", function()
    local MC = SK.modules.MoltenCore
    local sim = Sim.NewRaid({ members = { { name = "Wara", class = "WARRIOR" }, { name = "Pria", class = "PRIEST" } },
        learnerClass = "MAGE" })
    sim.autoLearner = false
    assert(sim:drop({ "Gauntlets of Might" })) -- warrior tier
    local item = sim:snapshot().items[1]
    eq(table.concat(item.giftTargets, ","), "Wara", "only the warrior may have warrior gloves")
    sim.session:bid("Wara", 1, "pass"); sim.session:bid("Pria", 1, "pass"); sim.session:bid("You", 1, "pass")
    eq(sim.session.turn.type, "claim"); eq(sim.session.turn.player, "You-Realm")
    eq(select(2, sim.session:claimItem("You", { to = "Pria" })), "wrongclassto", "a priest can't have them")
    assert(sim.session:claimItem("You", { to = "Wara" }))
    assert(MC)
end)
test("the proxy lesson accepts a gift to any raider who can use the ring, not only Aldric; keeping it is explained", function()
    local base = SK.modules.Scenarios.find("minor-upgrade-proxy")
    for _, who in ipairs { "Aldric", "Dara", "Brann" } do
        local sc = {}
        for k, v in pairs(base) do sc[k] = v end
        sc.you = { claim = true, claimTo = who }
        local sim, ok, message = Sim.RunScenario(sc)
        assert(ok, who .. ": " .. tostring(message)); assert(message:find("gifted to " .. who), message)
    end
    local keep = {}
    for k, v in pairs(base) do keep[k] = v end
    keep.you = { claim = true }
    local _, ok, message = Sim.RunScenario(keep)
    assert(not ok and message:find("kept it"), tostring(message))
end)
test("a lesson with a step still to do is not judged early: 'fix a mistake' waits for the undo", function()
    local sc = {}
    for k, v in pairs(SK.modules.Scenarios.find("fix-a-mistake")) do sc[k] = v end
    sc.after = nil -- the learner has handed the staff out but not undone it yet
    local sim = Sim.RunScenario(sc)
    local hint = sc.todo(sim)
    assert(hint and hint:find("Undo last award"), tostring(hint))
    local last
    for _, ev in ipairs(sim.engine:Get("main").events) do if ev.type == "Award" then last = ev end end
    assert(sim.engine:Append("main", "Revert", { target = last.id }))
    eq(sc.todo(sim), nil, "once undone, nothing is left")
    assert(sc.expect(sim))
    for _, other in ipairs(SK.modules.Scenarios.list) do
        if other.todo then
            local done = Sim.RunScenario(other)
            eq(other.todo(done), nil, other.id .. ": a finished run has nothing left to do")
        end
    end
end)
