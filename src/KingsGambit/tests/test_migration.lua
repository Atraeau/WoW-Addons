-- Ledger migration: does the strategy work? (design journal: "Decision: ledger migration").
--
-- The strategy is judged against a SIMULATED breaking change (tests/migration_fixture.lua: a hypothetical format 3 that renames Award's fields
-- and changes where a new member goes). First the pieces, then an evaluation: a guild of real engines on a simulated network moves from
-- format 2 to format 3 with players on different releases, and a scorecard says what held. A deliberately wrong upcaster must be caught.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local Ledger, Migrations, Standings = SK.modules.Ledger, SK.modules.Migrations, SK.modules.Standings
local makeRules3 = assert(loadfile("tests/migration_fixture.lua"))(SK)
local golden = H.goldenFormat2 or assert(loadfile("tests/ledgers/format2.lua"))()

local function deepEqual(a, b)
    if type(a) ~= type(b) then return false end
    if type(a) ~= "table" then return a == b end
    for k, v in pairs(a) do if not deepEqual(v, b[k]) then return false end end
    for k in pairs(b) do if a[k] == nil then return false end end
    return true
end
local function deepCopy(v) if type(v) ~= "table" then return v end local o = {} for k, x in pairs(v) do o[k] = deepCopy(x) end return o end

H.section("Migration: the pieces")
test("a ruleset must read every format it claims, with an upcaster for each one below the newest", function()
    assert(Migrations.Check(Migrations.Default)); assert(Migrations.Check(makeRules3()))
    local rules = makeRules3(); rules.upcast = {}
    eq(select(2, Migrations.Check(rules)), "noupcaster:2")
    rules = makeRules3(); rules.read = { [3] = true, [1] = true }; rules.upcast = {}
    eq(select(2, Migrations.Check(rules)), "noupcaster:1")
    rules = makeRules3(); rules.read[3] = nil
    eq(select(2, Migrations.Check(rules)), "cannotreadcurrent")
    eq(table.concat(Migrations.Readable(makeRules3()), ","), "2,3"); eq(table.concat(Migrations.Readable(Migrations.Default), ","), "2")
end)

test("upcasting maps old events to the new shape without touching the stored ones, and keeps what identifies them", function()
    local rules = makeRules3()
    local n = 0
    for _, chain in pairs(golden.ledger.chains) do
        for _, ev in ipairs(chain.events) do
            local before = deepCopy(ev)
            local up, why = Migrations.Up(rules, ev)
            assert(up, ev.type .. ": " .. tostring(why))
            assert(deepEqual(ev, before), "the stored " .. ev.type .. " was changed")
            eq(up.v, 3); eq(up.type, ev.type); eq(up.id, ev.id); eq(up.chain, ev.chain); eq(up.seq, ev.seq); eq(up.author, ev.author); eq(up.ts, ev.ts)
            if ev.type == "Award" then assert(up.data.winner == ev.data.member and up.data.member == nil, "Award renamed") end
            n = n + 1
        end
    end
    assert(n >= 40)
    local ev = { v = 3, type = "Award", data = {} }
    eq(Migrations.Up(rules, ev), ev, "an event already in the newest format is returned as it is")
    eq(select(2, Migrations.Up(Migrations.Default, { v = 3, type = "Award", data = {} })), "unreadable")
end)

test("downcasting writes the old format, and round-trips what the old format can express", function()
    local rules = makeRules3()
    local award = { v = 3, type = "Award", list = "main", data = { winner = "A-Realm", item = "X", recipient = "B-Realm" } }
    local down = Migrations.Down(rules, award, 2)
    eq(down.v, 2); eq(down.data.member, "A-Realm"); eq(down.data.to, "B-Realm"); eq(down.data.winner, nil)
    local back = Migrations.Up(rules, down)
    assert(deepEqual(back.data, award.data), "up(down(x)) == x")
    eq(Migrations.Down(rules, { v = 3, type = "AddMember", list = "main", data = { member = "Z" } }, 2).data.to, "top", "format 3's default is written down for format-2 readers")
    local bad, why = Migrations.Down(Migrations.Default, { v = 2, type = "Award", data = {} }, 1); eq(bad, nil); eq(why, "nodowncast")
end)

H.section("Migration: any old ledger can be read by new code (the golden ledger of format 2)")
local function viewOf(rules)
    local store, problems = Ledger.LoadStore(golden.ledger, nil, rules)
    eq(next(problems), nil, "every chain still verifies")
    return Ledger.View(store), store
end
local function standings(view)
    local out = {}
    for id, s in pairs(view.lists) do
        local wins = {}
        for name, m in pairs(s.members) do wins[name] = m.wins end
        out[id] = { order = table.concat(s.order, ","), wins = wins, count = s.count }
    end
    return out
end

test("replaying format 2's golden ledger under the simulated format 3 gives exactly the standings it was frozen with", function()
    local view, store = viewOf(makeRules3())
    eq(#view.conflicts, 0, "nothing refused: " .. (view.conflicts[1] and view.conflicts[1].reason or ""))
    for id, want in pairs(golden.expect.lists) do
        local got = standings(view)[id]
        eq(got.order, table.concat(want.order, ","), "order of " .. id .. " is unchanged by the new code")
        eq(got.count, want.count)
        for name, m in pairs(want.members) do eq(got.wins[name], m.wins, name .. " wins") end
    end
    eq(Ledger.Fingerprint(store), golden.expect.fingerprint, "and the ledger itself is untouched: same chains, same heads")
end)

test("a wrong upcaster changes history, and the golden ledger shows it (so a migration can be tested before it is released)", function()
    local good = standings(viewOf(makeRules3()))
    local bad = standings(viewOf(makeRules3("forgetdefault")))
    assert(good.main.order ~= bad.main.order or good.off.order ~= bad.off.order, "forgetting the old default moves people: that is exactly what must be caught")
    local view = viewOf(makeRules3("dropawards"))
    assert(#view.conflicts > 0, "an upcaster that refuses events leaves conflicts")
end)

H.section("Migration: the evaluation (a guild moves from format 2 to a simulated format 3)")

local seedCounter = 0
local function node(w, name, rules, build)
    seedCounter = seedCounter + 1
    local client = MockClient.New({ name = name, realm = "Realm", seed = seedCounter * 53 })
    client:setAddonVersion(build or "0.2.0+1")
    local engine = Engine.New(client, { rules = rules })
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    w.net:attach(client); sync:start()
    local nd = { name = name, full = name .. "-Realm", client = client, engine = engine, sync = sync, rules = rules, unreadable = {} }
    sync:on("unreadable", function(e) nd.unreadable[#nd.unreadable + 1] = e end)
    w.nodes[name] = nd
    return nd
end
-- a player updates the addon: the same saved ledger, new code
local function update(w, name, rules)
    local old = w.nodes[name]
    old.sync:stop()
    local nd = node(w, name, rules)
    nd.client = old.client
    nd.client:setAddonVersion("0.2.0+2")
    -- rebuild the engine and sync on the saved data of the same client
    w.nodes[name] = nil
    local engine = Engine.New(old.client, { rules = rules })
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    w.net:attach(old.client); sync:start()
    nd = { name = name, full = name .. "-Realm", client = old.client, engine = engine, sync = sync, rules = rules, unreadable = {} }
    sync:on("unreadable", function(e) nd.unreadable[#nd.unreadable + 1] = e end)
    w.nodes[name] = nd
    return nd
end

local function order(nd) local c = nd.engine:Get("main"); return c and (table.concat(c.state.order, ","):gsub("%-Realm", "")) or "none" end
local function fp(nd) return nd.engine:Fingerprint() or "none" end
local function settle(w, names, limit)
    local t = 0
    while t < (limit or 180) do
        local same = true
        for i = 2, #names do if fp(w.nodes[names[i]]) ~= fp(w.nodes[names[1]]) then same = false end end
        if same and t > 0 then return t, true end
        w.net:advance(1); t = t + 1
    end
    return t, false
end
-- run the clock until `cond()` holds (at most `limit` simulated seconds); how long it took, and whether it held
local function waitFor(w, cond, limit)
    local t = 0
    while t < (limit or 300) do
        if cond() then return t, true end
        w.net:advance(1); t = t + 1
    end
    return t, cond() and true or false
end
local function allEventIds(nd)
    local ids = {}
    for _, chain in pairs(nd.engine.store.chains) do for _, ev in ipairs(chain.events) do ids[ev.id] = ev.v end end
    return ids
end

-- One evaluation. Returns a scorecard: { { name, ok, detail }... } plus numbers. `lossy` makes the network drop and repeat messages.
local function evaluate(seed, lossy)
    local rnd = (function() local s = seed * 7919 + 13 return function(n) s = (s * 1103515245 + 12345) % 2147483648; return s % n + 1 end end)()
    local net = SimNetwork.New({ latency = 0.1, seed = seed, dropRate = lossy and 0.2 or 0, duplicateRate = lossy and 0.2 or 0 })
    local w = { net = net, nodes = {} }
    local rules3 = makeRules3()
    local card, stats = {}, { seed = seed, lossy = lossy }
    local function mark(name, ok, detail) card[#card + 1] = { name = name, ok = ok and true or false, detail = detail } end

    -- who runs what: the guild master and two raiders are on the new release; an officer and a raider have not updated yet
    local gm, cass, dara = node(w, "GM", rules3), node(w, "Cass", rules3), node(w, "Dara", rules3)
    local off, eira = node(w, "Off", Migrations.Default), node(w, "Eira", Migrations.Default)
    assert(gm.engine:CreateList("main", "Main")); assert(gm.engine:Write("SetOfficers", { names = { "Off-Realm" } }))
    for i = 1, 6 do assert(gm.engine:Append("main", "AddMember", { member = "M" .. i .. "-Realm", to = "bottom" })) end
    settle(w, { "GM", "Cass", "Dara", "Off", "Eira" })

    -- history, written by the new release (GM) and the old one (Off) alike
    local function active(nd)
        local out = {}
        for _, m in ipairs(nd.engine:Get("main").state.order) do out[#out + 1] = m end
        return out
    end
    local function liveAwards(nd)
        local out = {}
        for id, a in pairs(nd.engine:Get("main").state.awards) do
            for _, e in ipairs(nd.engine:Get("main").state.undo[nd.engine:MyChain()] or {}) do if e.id == id then out[#out + 1] = id end end
        end
        table.sort(out)
        return out
    end
    local n = 0
    local function randomOp(nd)
        n = n + 1
        local names = active(nd)
        local pick = names[rnd(#names)]
        local isNew = nd.rules.current >= 3
        local op = rnd(7)
        if op == 1 then return nd.engine:Append("main", "AddMember", { member = "N" .. n .. "-Realm" })                  -- no position: format 2 bottom, format 3 top
        elseif op == 2 then return nd.engine:Append("main", "AddMember", { member = "N" .. n .. "-Realm", to = rnd(2) == 1 and "top" or "bottom" })
        elseif op == 3 or op == 4 then
            local data = isNew and { winner = pick, item = "I" .. n } or { member = pick, item = "I" .. n }
            return nd.engine:Append("main", "Award", data)
        elseif op == 5 then return nd.engine:Append("main", "MovePlayer", { member = pick, to = rnd(2) == 1 and "top" or "bottom", reason = "fix" })
        elseif op == 6 then return nd.engine:Append("main", "Pass", { member = pick, item = "I" .. n })
        else
            local awards = liveAwards(nd)
            if #awards == 0 then return nd.engine:Append("main", "Pass", { member = pick, item = "I" .. n }) end
            return nd.engine:Append("main", "Revert", { target = awards[rnd(#awards)] })
        end
    end
    local writes = 0
    for i = 1, 30 do
        local nd = (i % 2 == 0) and off or gm
        local ev = randomOp(nd)
        if ev then writes = writes + 1 end
        if i % 5 == 0 then net:advance(1) end
    end
    -- The one case a wrong upcaster of this change breaks is a member added with NO position by the old release (format 2: the bottom). The digest
    -- only proves the history it covers, so make sure this one does, and that nothing later moves them: a migration is only as well tested as its corpus.
    assert(off.engine:Append("main", "AddMember", { member = "Legacy-Realm" }))
    local t0, converged = settle(w, { "GM", "Cass", "Dara", "Off", "Eira" })
    mark("before the cutover everyone, old release and new, ends with the same ledger", converged, "settled in " .. t0 .. " s")
    local before = {}
    for name, nd in pairs(w.nodes) do before[name] = order(nd) end
    local same = true
    for name in pairs(before) do if before[name] ~= before.Eira then same = false end end
    mark("and the same standings: the new code reads the old format the way the old code does", same, before.GM)
    local idsBefore = allEventIds(gm)
    local allV2 = true
    for _, v in pairs(idsBefore) do if v ~= 2 then allV2 = false end end
    mark("until the guild master says so, even the new release writes the old format", allV2)
    stats.events = 0
    for _ in pairs(idsBefore) do stats.events = stats.events + 1 end

    -- the cutover
    local mig, why = gm.engine:Migrate(3, "simulated breaking change")
    mark("the guild master can write the cutover", mig ~= nil, why)
    local newNames = { "GM", "Cass", "Dara" }
    local tc, convNew = settle(w, newNames)
    mark("every player on the new release receives it", convNew, "settled in " .. tc .. " s")
    stats.cutoverSeconds = tc
    local view = gm.engine:View()
    local m = view.auth.migrations[1]
    mark("the ledger is now in format 3", m ~= nil and gm.engine:Format() == 3 and cass.engine:Format() == 3 and dara.engine:Format() == 3)
    local verified = 0
    for _, nm in ipairs(newNames) do
        local nd = w.nodes[nm]
        local c = m and nd.engine.store.verified[m.ev.id]
        if c and c.ok and not nd.engine:Frozen() then verified = verified + 1 end
    end
    mark("every new client replayed the old history itself and got the guild master's digest", verified == #newNames, verified .. " of " .. #newNames)
    local oldReading = m and Ledger.CutDigest(eira.engine.store, m.cut)
    mark("and that digest is what the OLD release computes for the same history (the migration lost nothing)", m ~= nil and oldReading == m.digest)
    local unchanged = true
    for _, nm in ipairs(newNames) do if order(w.nodes[nm]) ~= before[nm] then unchanged = false end end
    mark("the cutover moved nobody", unchanged)
    waitFor(w, function() return #eira.unreadable >= 1 end, 400)
    local idsAfter = allEventIds(gm)
    local intact = true
    for id, v in pairs(idsBefore) do if idsAfter[id] ~= v then intact = false end end
    mark("not one old event was rewritten: every id and format is as it was", intact)
    mark("the old release that cannot read format 3 is told, once", #eira.unreadable == 1 and eira.unreadable[1].format == 3 and eira.unreadable[1].newer == true,
        #eira.unreadable .. " notice(s)")
    mark("and its own ledger and standings are untouched", order(eira) == before.Eira and #eira.engine:Conflicts() == 0)

    -- life after: the new release writes format 3 (a new member with no position goes to the top); the unupdated officer writes format 2
    local topBefore = order(gm):match("^[^,]+")
    assert(gm.engine:Append("main", "AddMember", { member = "Newcomer-Realm" }))
    local winner = (order(gm):gsub("^[^,]+,", "")):match("^[^,]+")
    assert(gm.engine:Append("main", "Award", { winner = winner .. "-Realm", item = "After" }))
    local staleWrites = 0
    for i = 1, 2 do
        if off.engine:Append("main", "MovePlayer", { member = "M" .. i .. "-Realm", to = "top", reason = "old release, after the cutover" }) then staleWrites = staleWrites + 1 end
    end
    settle(w, newNames)
    -- the old release (Eira) hears of the cutover when the entry reaches her: wait for it (a lossy network drops and repeats messages)
    waitFor(w, function() return #eira.unreadable >= 1 and #gm.engine:Conflicts() >= staleWrites end, 400)
    w.net:advance(10)
    local post = true
    for _, ev in ipairs(gm.engine:Get("main").events) do
        if ev.seq > (m and m.cut[ev.chain] or 0) and ev.author == "GM" and ev.v ~= 3 then post = false end
    end
    mark("after the cutover the new release writes format 3", post)
    mark("a new member with no position goes to the top, as format 3 says", order(gm):match("^[^,]+") == "Newcomer", order(gm))
    mark("the new clients agree with each other on everything", fp(gm) == fp(cass) and fp(cass) == fp(dara) and order(gm) == order(cass) and order(cass) == order(dara))
    local stale = 0
    for _, c in ipairs(gm.engine:Conflicts()) do if c.reason == "staleformat" then stale = stale + 1 end end
    mark("what the unupdated officer wrote after the cutover is recorded as a stale-format conflict on every new client, not silently applied",
        staleWrites == 2 and stale == staleWrites and #cass.engine:Conflicts() == #gm.engine:Conflicts() and #dara.engine:Conflicts() == #gm.engine:Conflicts(),
        stale .. " of " .. staleWrites)
    stats.stale = stale

    -- a client whose upcaster is wrong joins: it cannot reproduce the digest, so it must refuse to write
    local fenn = node(w, "Fenn", makeRules3("forgetdefault"))
    waitFor(w, function() return fenn.engine:Frozen() ~= nil end, 400)
    mark("a client whose upcaster disagrees with the migration notices (its replay does not match the digest)", fenn.engine:Frozen() ~= nil and fenn.engine:Frozen().reason == "migrationmismatch")
    local ev, werr = fenn.engine:Append("main", "Pass", { member = "M1-Realm", item = "x" })
    mark("and refuses to write rather than writing something the guild would not agree with", ev == nil and werr == "frozen", tostring(werr))
    mark("while the correct clients are unaffected", gm.engine:Frozen() == nil and cass.engine:Frozen() == nil)

    -- the laggards update and catch up
    update(w, "Off", makeRules3())
    update(w, "Eira", makeRules3())
    local tl, convAll = settle(w, { "GM", "Cass", "Dara", "Off", "Eira" })
    mark("when the old releases update they catch up from the same saved ledger and everyone converges", convAll, "settled in " .. tl .. " s")
    mark("on the same standings", order(w.nodes.Off) == order(gm) and order(w.nodes.Eira) == order(gm))
    local offConflicts = #w.nodes.Off.engine:Conflicts()
    mark("with the same record of what was stale", offConflicts == #gm.engine:Conflicts() and w.nodes.Eira.engine:Format() == 3 and w.nodes.Off.engine:Format() == 3)
    local late = w.nodes.Off.engine:Append("main", "Award", { winner = "M3-Realm", item = "Updated" })
    mark("and the updated officer can write again, in format 3", late ~= nil and late.v == 3)
    stats.lateSeconds = tl
    return card, stats
end

local function report(card, stats)
    local failed = {}
    for _, c in ipairs(card) do if not c.ok then failed[#failed + 1] = c.name .. (c.detail and (" (" .. c.detail .. ")") or "") end end
    return failed
end

test("evaluation: a clean network (every check on the scorecard must hold)", function()
    local card, stats = evaluate(1, false)
    local failed = report(card, stats)
    if os.getenv("KG_SCORECARD") then
        for _, c in ipairs(card) do print(("    %s %s%s"):format(c.ok and "held  " or "FAILED", c.name, c.detail and (" (" .. c.detail .. ")") or "")) end
    end
    print(("  scorecard (clean network): %d of %d checks held; %d events in the history, cutover seen everywhere in %d s, %d stale write(s) recorded, laggards caught up in %d s"):format(
        #card - #failed, #card, stats.events, stats.cutoverSeconds or -1, stats.stale or 0, stats.lateSeconds or -1))
    if #failed > 0 then error("the strategy failed these checks:\n       " .. table.concat(failed, "\n       "), 0) end
end)

test("evaluation: a lossy network that also repeats messages, over many random histories", function()
    local totalChecks, totalFailed = 0, {}
    for seed = 2, 9 do
        local card, stats = evaluate(seed, seed % 2 == 0)
        totalChecks = totalChecks + #card
        for _, f in ipairs(report(card, stats)) do totalFailed[#totalFailed + 1] = ("seed %d: %s"):format(seed, f) end
    end
    print(("  scorecard (8 random guilds, half on a lossy network): %d checks, %d failed"):format(totalChecks, #totalFailed))
    if #totalFailed > 0 then error("the strategy failed:\n       " .. table.concat(totalFailed, "\n       "), 0) end
end)

H.section("Migration: the evaluation has teeth (it fails when the strategy is broken on purpose)")
local function failedChecks(card) local out = {} for _, c in ipairs(card) do if not c.ok then out[#out + 1] = c.name end end return out end
local function anyContains(list, text) for _, s in ipairs(list) do if s:find(text, 1, true) then return true end end return false end

test("if clients did not check the migration digest, a client with a wrong upcaster would go unnoticed, and the scorecard says so", function()
    local real = Ledger.VerifyMigrations
    Ledger.VerifyMigrations = function() end
    local ok, card = pcall(evaluate, 1, false)
    Ledger.VerifyMigrations = real
    assert(ok, tostring(card))
    local failed = failedChecks(card)
    assert(anyContains(failed, "a client whose upcaster disagrees"), "the scorecard must flag it: " .. table.concat(failed, " | "))
    assert(anyContains(failed, "every new client replayed the old history"), "the scorecard must flag it: " .. table.concat(failed, " | "))
end)

test("if the cut were ignored, writes in the old format after the cutover would be applied instead of recorded, and the scorecard says so", function()
    local real = Migrations.FormatFor
    Migrations.FormatFor = function() return 3 end -- every event treated as already new: old-format events would be refused as stale... and old history too
    local ok, card = pcall(evaluate, 1, false)
    Migrations.FormatFor = real
    -- either the guild stops working outright (its own writes are refused as stale) or the scorecard fails: never a pass
    assert(not ok or #failedChecks(card) > 0, "a broken cut must not pass the evaluation")
end)

test("if the guild master recorded a wrong digest, every client refuses to write, and the scorecard says so", function()
    local real = Ledger.CutDigest
    local calls = 0
    Ledger.CutDigest = function(store, cut)
        calls = calls + 1
        return calls == 1 and "0000000000000000" or real(store, cut) -- only the guild master's own computation is wrong
    end
    local ok, card = pcall(evaluate, 1, false)
    Ledger.CutDigest = real
    -- the guild master's own client can't reproduce the digest it wrote, so it freezes and the guild cannot go on: the evaluation must not pass
    if ok then
        assert(anyContains(failedChecks(card), "every new client replayed the old history"), table.concat(failedChecks(card), " | "))
    else
        assert(tostring(card):find("frozen", 1, true), "it stopped because clients refused to write: " .. tostring(card))
    end
end)

H.section("Migration: the cutover entry is guarded")
test("only the guild master can migrate, only to the next format, only once, and only with a reason", function()
    local net = SimNetwork.New()
    local w = { net = net, nodes = {} }
    local rules3 = makeRules3()
    local gm, off = node(w, "GM", rules3), node(w, "Off", rules3)
    assert(gm.engine:CreateList("main", "Main")); assert(gm.engine:Write("SetOfficers", { names = { "Off-Realm" } })); net:advance(5)
    eq(select(2, off.engine:Migrate(3, "not the guild master")), "notguildmaster")
    eq(select(2, gm.engine:Migrate(4, "too far")), "badmigrate"); eq(select(2, gm.engine:Migrate(2, "backwards")), "badmigrate")
    local ev, why = gm.engine:Migrate(3, ""); eq(ev, nil)
    assert(gm.engine:Migrate(3, "the first one"))
    eq(select(2, gm.engine:Migrate(3, "again")), "badmigrate", "the ledger is already in format 3")
    local old = Engine.New(MockClient.New({ name = "Old", realm = "Realm", seed = 5 }), { rules = Migrations.Default })
    eq(select(2, old:Migrate(3, "this build can't write format 3")), "cantwrite")
    -- a forged cutover: not from the guild master, or with a cut or digest that doesn't hold
    net:advance(5)
    local forged = Ledger.Build(off.engine.store, off.engine:MyChain(), "Off-Realm", "Migrate", { from = 2, to = 3, cut = {}, digest = "x", reason = "forged" }, off.client:serverTime() + 100, nil, 3)
    local status = Ledger.Receive(off.engine.store, forged)
    assert(status == "appended"); off.engine:rebuild()
    local conflict
    for _, c in ipairs(off.engine:Conflicts()) do if c.type == "Migrate" then conflict = c.reason end end
    assert(conflict, "a Migrate entry that is not the guild master's is refused by every client")
end)
