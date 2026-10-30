-- Tokens (Ahn'Qiraj): the data, readiness (shown, never enforced), and readiness carried by bids,
-- whispers, the live protocol and the text interface. Plus a full simulated AQ40 night.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Loot, Sim = SK.modules.MockClient, SK.modules.Engine, SK.modules.Loot, SK.modules.Sim
local Sync, SimNetwork, LootNet, Commands = SK.modules.Sync, SK.modules.SimNetwork, SK.modules.LootNet, SK.modules.Commands
local Tokens, AQ = SK.modules.Tokens, SK.modules.AQ40

local COMMAND = "|cffa335ee|Hitem:20928::::::::60:::::|h[Qiraji Bindings of Command]|h|r"
local BROOD = 910
-- Conqueror's Spaulders (warrior, from the Bindings of Command): 2 Idol of Night, 5 Clay and 5 Stone Scarabs.
local IDOL_OF_NIGHT, CLAY_SCARAB, STONE_SCARAB = 20875, 20863, 20858
local SPAULDERS_MATS = { [IDOL_OF_NIGHT] = 2, [STONE_SCARAB] = 5, [CLAY_SCARAB] = 5 }
local function bags(o)
    local b = { [IDOL_OF_NIGHT] = 2, [STONE_SCARAB] = 5, [CLAY_SCARAB] = 5 }
    for k, v in pairs(o or {}) do b[k] = v end
    return function(what) return b[what] or 0 end
end
local function rep(at) return function() return at end end

H.section("Tokens: data")
test("the AQ40 data is complete and consistent", function()
    eq(#AQ.bosses, 10); eq(AQ.bosses[1].name, "The Prophet Skeram"); eq(AQ.bosses[10].name, "C'Thun")
    local tokens = 0
    for _, b in ipairs(AQ.bosses) do
        assert(b.drops >= 1 and #b.loot > b.drops, b.name)
        for _, entry in ipairs(b.loot) do
            local item = AQ.items[entry[1]]
            assert(item, b.name .. " drops an unknown item " .. entry[1])
            assert(item.classes ~= 0 or item.role, item.name .. " has neither a class nor a role")
        end
    end
    for _, item in pairs(AQ.items) do if item.token then tokens = tokens + 1; assert(item.token.makes, item.name) end end
    eq(tokens, 11)
end)
test("every class a token is for has a turn-in, with materials, and the right reputation", function()
    local STANDING = { [20928] = "Neutral", [20932] = "Neutral", [20930] = "Friendly", [20926] = "Friendly",
        [20931] = "Friendly", [20927] = "Friendly", [20933] = "Honored", [20929] = "Honored" }
    for id, item in pairs(AQ.items) do
        if item.token then
            for class, bit in pairs(AQ.CLASS_BITS) do
                local options = item.token.turnIns[class]
                if item.classes == 0 or item.classes & bit ~= 0 then
                    assert(options and #options >= 1, item.name .. " has no turn-in for " .. class)
                    for _, t in ipairs(options) do
                        eq(t.needs[1][1], id, t.reward .. " asks for its token first")
                        if STANDING[id] then
                            assert(#t.needs == 4, t.reward .. " needs an idol and two kinds of scarab")
                            eq(t.reputation.factionId, BROOD); eq(t.reputation.standing, STANDING[id], t.reward)
                        end
                    end
                else
                    eq(options, nil, item.name .. " is not for " .. class)
                end
            end
        end
    end
    local spaulders = AQ.items[20928].token.turnIns.WARRIOR[1]
    eq(spaulders.quest, 8544); eq(spaulders.reward, "Conqueror's Spaulders")
    for k = 2, 4 do eq(spaulders.needs[k][2], SPAULDERS_MATS[spaulders.needs[k][1]], "as checked by hand on Wowhead") end
    eq(#AQ.items[20928].token.turnIns.WARRIOR, 2, "shoulders or boots")
    eq(AQ.items[21221].token.makes, "Neck, back or finger")
end)
test("a token is found by link, id or name; gear is not a token", function()
    eq(Tokens.Find(COMMAND).id, 20928); eq(Tokens.Find(20928).id, 20928)
    eq(Tokens.Find("Qiraji Bindings of Command").id, 20928); eq(Tokens.Find("qiraji bindings of command").id, 20928)
    eq(Tokens.Find("Death's Sting"), nil); eq(Tokens.Find("item:21126"), nil); eq(Tokens.Find(nil), nil)
end)
test("class tokens go to their class groups", function()
    local function wants(id, class, role) return Sim.Wants(AQ, AQ.items[id], class, role) end
    eq(wants(20928, "WARRIOR", "tank"), "need"); eq(wants(20928, "PRIEST", "healer"), "need")
    eq(wants(20928, "MAGE", "caster"), nil, "Bindings of Command are not for mages")
    eq(wants(20932, "MAGE", "caster"), "need", "...Bindings of Dominance are")
    eq(wants(21237, "MAGE", "caster"), "need", "Regalia: caster and healer weapons")
    eq(wants(21237, "ROGUE", "melee"), nil); eq(wants(21232, "ROGUE", "melee"), "need")
    eq(wants(21221, "HUNTER", "hunter"), "need", "the Eye of C'Thun is for everyone")
end)

H.section("Tokens: readiness")
test("ready only with every material and the reputation", function()
    local t = Tokens.Find(20928)
    eq(Tokens.Check(t, "WARRIOR", bags(), rep(4)), "ready")
    eq(Tokens.Check(t, "WARRIOR", bags({ [CLAY_SCARAB] = 4 }), rep(4)), "notready", "one scarab short")
    eq(Tokens.Check(t, "WARRIOR", bags(), rep(3)), "notready", "Unfriendly with the Brood")
    eq(Tokens.Check(t, "WARRIOR", bags(), rep(nil)), "notready", "standing unknown")
    eq(Tokens.Check(t, "WARRIOR", bags(), rep(8)), "ready", "Exalted is more than enough")
end)
test("the token itself is not a requirement: it is what the bid is for", function()
    local t = Tokens.Find(20928)
    eq(Tokens.Check(t, "WARRIOR", bags({ [20928] = 0 }), rep(4)), "ready")
end)
test("unknown when the class has no turn-in for the token", function()
    eq(Tokens.Check(Tokens.Find(20928), "MAGE", bags(), rep(8)), nil, "Bindings of Command are not for mages")
    eq(Tokens.Check({ token = { turnIns = {} } }, "WARRIOR", bags(), rep(8)), nil)
end)
test("any one turn-in is enough: the boots' materials make a priest ready", function()
    -- Footwraps of the Oracle: 2 Idol of Death (20877), 5 Bronze (20864) and 5 Gold (20859) Scarabs.
    local t = Tokens.Find(20928)
    local boots
    for _, o in ipairs(t.token.turnIns.PRIEST) do if o.reward == "Footwraps of the Oracle" then boots = o end end
    local have = {}
    for k = 2, #boots.needs do have[boots.needs[k][1]] = boots.needs[k][2] end
    eq(Tokens.Check(t, "PRIEST", function(id) return have[id] or 0 end, rep(4)), "ready")
    eq(Tokens.Check(t, "PRIEST", bags(), rep(4)), "notready", "the warrior's materials are not the priest's")
end)
test("the Eye of C'Thun and the Imperial weapons need no reputation", function()
    eq(Tokens.Check(Tokens.Find(21221), "MAGE", bags(), rep(nil)), "ready", "the Eye alone")
    eq(Tokens.Check(Tokens.Find(21232), "ROGUE", function(id) return id == 18562 and 3 or 0 end, rep(nil)), "ready")
end)
test("the player's own word fills in what the addon can't see", function()
    eq(Tokens.Combine("ready", false), "ready"); eq(Tokens.Combine("ready", true), "ready")
    eq(Tokens.Combine("notready", true), "says"); eq(Tokens.Combine(nil, true), "says")
    eq(Tokens.Combine("notready", false), "notready"); eq(Tokens.Combine(nil, false), nil)
    eq(Tokens.Label("notready"), "not ready (from bags)"); eq(Tokens.Label(nil), "unknown")
end)
test("Mine reads this player's bags and reputation through the client", function()
    local client = MockClient.New({ name = "Aldric", realm = "Realm" })
    local t = Tokens.Find(20928)
    eq(Tokens.Mine(client, t, "WARRIOR"), "notready")
    client:setBags(SPAULDERS_MATS); client:setReputation(BROOD, 5)
    eq(Tokens.Mine(client, t, "WARRIOR"), "ready")
end)

H.section("Tokens: in a loot session")
local function session(links, members)
    local client = MockClient.New({ name = "Raidlead", realm = "Realm" })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    members = members or { "A", "B", "C" }
    for _, n in ipairs(members) do engine:Append("main", "AddMember", { member = n .. "-Realm", class = "WARRIOR" }) end
    client:setRaid(members, { leader = "A", lootMethod = "master", masterLooter = "Raidlead" })
    local items = {}
    for i, l in ipairs(links) do items[i] = { link = l } end
    local s = Loot.NewSession(engine, { bidSeconds = 0 })
    assert(s:start(items))
    return s, engine, client
end
test("a token bid carries readiness; gear and passes do not", function()
    local s = session({ COMMAND, "Death's Sting" })
    assert(s.items[1].token and not s.items[2].token)
    assert(s:bid("B", 1, "need", { ready = "notready" })); assert(s:bid("A", 1, "need", { ready = "says" }))
    assert(s:bid("C", 1, "pass", { ready = "ready" })); assert(s:bid("A", 2, "need", { ready = "ready" }))
    eq(s.bids["C-Realm"][1].ready, nil, "a pass has no readiness"); eq(s.bids["A-Realm"][2].ready, nil, "gear has none")
    local rows = s:readiness(1)
    eq(#rows, 2); eq(rows[1].player, "A-Realm", "in list order"); eq(rows[1].ready, "says"); eq(rows[2].ready, "notready")
    eq(s:readiness(2), nil)
end)
test("nonsense readiness is ignored, not refused", function()
    local s = session({ COMMAND })
    assert(s:bid("A", 1, "need", { ready = "very" })); eq(s.bids["A-Realm"][1].ready, nil)
end)
test("readiness is never enforced: a bidder who is not ready still wins", function()
    local s = session({ COMMAND })
    assert(s:bid("A", 1, "need", { ready = "notready" })); assert(s:bid("B", 1, "need", { ready = "ready" }))
    assert(s:bid("C", 1, "pass"))
    s:resolveNow()
    eq(s.items[1].winner, "A-Realm", "the top of the list decides, readiness is their call")
end)
test("a whispered 'ready' is the player's own word", function()
    local s = session({ COMMAND, "Death's Sting" })
    assert(s:handleWhisper("A", "1 need ready, 2 pass"))
    eq(s.bids["A-Realm"][1].kind, "need"); eq(s.bids["A-Realm"][1].ready, "says")
    local answers = Loot.ParseWhisper("ready need", 1); eq(answers[1].kind, "need"); eq(answers[1].ready, true)
end)

H.section("Tokens: over the network and in commands")
test("readiness and rank reach the host and every raider's view", function()
    local net = SimNetwork.New({ latency = 0.1, seed = 4 })
    local nodes, k = {}, 0
    for _, n in ipairs { "ML", "Aldric", "Brann" } do
        k = k + 1
        local client = MockClient.New({ name = n, realm = "Realm", seed = k * 17 })
        client:setRaid({ "ML", "Aldric", "Brann" }, { leader = "ML", lootMethod = "master", masterLooter = "ML" })
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 30, firstHeartbeat = 5, firstJitter = 1 })
        net:attach(client); sync:start()
        nodes[n] = { client = client, engine = engine, sync = sync }
    end
    nodes.ML.engine:CreateList("main", "Main")
    for _, n in ipairs { "Aldric", "Brann" } do nodes.ML.engine:Append("main", "AddMember", { member = n .. "-Realm" }) end
    local host = LootNet.NewHost(nodes.ML.sync, nodes.ML.engine)
    local a, b = LootNet.NewPlayer(nodes.Aldric.sync), LootNet.NewPlayer(nodes.Brann.sync)
    net:advance(1)
    nodes.ML.client:dropLoot({ { link = COMMAND }, { link = "Death's Sting" } })
    assert(host:start({ { link = COMMAND, slot = 1 }, { link = "Death's Sting", slot = 2 } }, { bidSeconds = 0 }))
    net:advance(1)
    a:bid(1, "need", nil, nil, { rank = 2, ready = "says" }); a:bid(2, "need", nil, nil, { rank = 1 })
    net:advance(3)
    local bid = host.session.bids["Aldric-Realm"]
    eq(bid[1].ready, "says"); eq(bid[1].rank, 2); eq(bid[2].rank, 1)
    eq(b.session.answers["Aldric-Realm"][1].ready, "says", "Brann sees Aldric's readiness")
end)
test("need on a token reports your readiness; ready lists who wants it", function()
    local client = MockClient.New({ name = "Raidlead", realm = "Realm" })
    client:setRaid({ { name = "Raidlead", class = "WARRIOR" }, "A" }, { leader = "Raidlead", lootMethod = "master", masterLooter = "Raidlead" })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    local host = { session = Loot.NewSession(engine, { bidSeconds = 0 }), on = function() end }
    local cmd = Commands.New({ client = client, engine = engine, host = host })
    assert(host.session:start({ { link = COMMAND } }))
    client.printed = {}
    cmd.handle("need 1")
    local t = table.concat(client.printed, "\n")
    assert(t:find("is a token %(Shoulders or feet%)"), t); assert(t:find("not ready %(from bags%)"), t)
    eq(host.session.bids["Raidlead-Realm"][1].ready, "notready")
    cmd.handle("need 1 ready"); eq(host.session.bids["Raidlead-Realm"][1].ready, "says")
    client:setBags(SPAULDERS_MATS); client:setReputation(BROOD, 4)
    cmd.handle("need 1"); eq(host.session.bids["Raidlead-Realm"][1].ready, "ready")
    client.printed = {}
    cmd.handle("ready 1")
    t = table.concat(client.printed, "\n")
    assert(t:find("Raidlead %(need%): ready"), t); assert(t:find("a hint"), t)
end)

H.section("Tokens: a simulated AQ40 night")
test("a full AQ40 clear: tokens go only to their class groups, and readiness is shown", function()
    local sim = Sim.NewAQ40({ seed = 4 })
    sim.autoLearner = true
    local tokenAwards, withReadiness = 0, 0
    for _ = 1, 10 do
        local boss = sim:killBoss()
        assert(boss)
        assert(sim:runUntil("review", 900), boss.name .. " stuck in " .. sim.session.phase)
        for _, it in ipairs(sim.session.items) do
            local snap = sim:snapshot().items[it.id]
            if it.token then
                assert(snap.token and snap.token.makes, "the snapshot describes the token")
                for _, w in ipairs(snap.token.wanted) do if w.ready then withReadiness = withReadiness + 1 end end
                if it.status == "awarded" and it.tier ~= "backstop" then
                    tokenAwards = tokenAwards + 1
                    local class = sim.info[(it.winner:gsub("%-.*$", ""))].class
                    assert(Sim.Wants(AQ, it.token, class, sim.info[(it.winner:gsub("%-.*$", ""))].role), it.token.name .. " to " .. class)
                end
            end
        end
        local ok, failures = sim.session:confirm(); assert(ok); eq(#failures, 0)
    end
    assert(tokenAwards >= 5, "tokens were won: " .. tokenAwards); assert(withReadiness > 0)
    eq(#sim.engine:Conflicts(), 0)
end)
test("the same seed gives the same AQ40 night", function()
    local function night()
        local sim = Sim.NewAQ40({ seed = 11 })
        sim.autoLearner = true
        for _ = 1, 4 do sim:killBoss(); sim:runUntil("review", 900); sim.session:confirm() end
        return sim.engine:Fingerprint()
    end
    eq(night(), night())
end)
test("a seed gives the same night in a different process too (no dependence on table order)", function()
    local lua = arg and arg[-1]
    if not (lua and io.popen) then return end
    local script = os.tmpname()
    local f = assert(io.open(script, "w"))
    f:write([==[
        local H = dofile("tests/harness.lua")
        local Sim = H.SK.modules.Sim
        for _, new in ipairs { Sim.NewMoltenCore, Sim.NewAQ40 } do
            local sim = new({ seed = 3 })
            sim.autoLearner = true
            for _ = 1, 3 do sim:killBoss(nil, true) end
            sim:handOut(); sim:runUntil("review", 900); sim.session:confirm()
            io.write(sim.engine:Fingerprint(), " ")
        end
    ]==])
    f:close()
    local cmd = '"' .. lua .. '" "' .. script .. '"'
    if package.config:sub(1, 1) == "\\" then cmd = '"' .. cmd .. '"' end -- cmd.exe strips one pair of quotes
    local function run()
        local p = assert(io.popen(cmd))
        local out = p:read("a"); p:close()
        return assert(out:match("(%x+ %x+) $"), "the night did not run: " .. out)
    end
    local a, b = run(), run()
    os.remove(script)
    eq(a, b)
end)
