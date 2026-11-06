-- Ledger migration: does the strategy work? (design journal: "Decision: ledger migration").
--
-- The strategy is judged against a SIMULATED breaking change (simulator/src/migration_lab.lua: a hypothetical format 3 that renames Award's fields
-- and changes where a new member goes). First the pieces, then an evaluation: a guild of real engines on a simulated network moves from
-- format 2 to format 3 with players on different releases, and a scorecard says what held. A deliberately wrong upcaster must be caught.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine, Sync, SimNetwork = SK.modules.MockClient, SK.modules.Engine, SK.modules.Sync, SK.modules.SimNetwork
local Ledger, Migrations, Standings = SK.modules.Ledger, SK.modules.Migrations, SK.modules.Standings
local Lab = assert(loadfile("simulator/src/migration_lab.lua"))(SK) -- the simulated format 3 and the evaluation, shared with the simulator page
local makeRules3 = Lab.rules
local golden = H.goldenFormat2 or assert(loadfile("tests/ledgers/format_2.lua"))()

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
    local award = { v = 3, type = "Award", list = "main", data = { winner = "A", item = "X", recipient = "B" } }
    local down = Migrations.Down(rules, award, 2)
    eq(down.v, 2); eq(down.data.member, "A"); eq(down.data.to, "B"); eq(down.data.winner, nil)
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

local evaluate = Lab.evaluate
local node = function(w, name, rules, build) return Lab.node(w, name, rules, build) end

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
for _, m in ipairs(Lab.mutations()) do
    test("the scorecard notices when " .. m.name, function() assert(m.caught, "it did not notice: " .. m.detail) end)
end

H.section("Migration: the cutover entry is guarded")
test("only the ledger owner can migrate, only to the next format, only once, and only with a reason", function()
    local net = SimNetwork.New()
    local w = { net = net, nodes = {} }
    local rules3 = makeRules3()
    local gm, off = node(w, "GM", rules3), node(w, "Off", rules3)
    assert(gm.engine:CreateList("main", "Main")); assert(gm.engine:Write("SetOfficers", { names = { "Off" } })); net:advance(5)
    eq(select(2, off.engine:Migrate(3, "not the ledger owner")), "notguildmaster")
    eq(select(2, gm.engine:Migrate(4, "too far")), "badmigrate"); eq(select(2, gm.engine:Migrate(2, "backwards")), "badmigrate")
    local ev, why = gm.engine:Migrate(3, ""); eq(ev, nil)
    assert(gm.engine:Migrate(3, "the first one"))
    eq(select(2, gm.engine:Migrate(3, "again")), "badmigrate", "the ledger is already in format 3")
    local old = Engine.New(MockClient.New({ name = "Old", seed = 5 }), { rules = Migrations.Default })
    eq(select(2, old:Migrate(3, "this build can't write format 3")), "cantwrite")
    -- a forged cutover: not from the ledger owner, or with a cut or digest that doesn't hold
    net:advance(5)
    local forged = Ledger.Build(off.engine.store, off.engine:MyChain(), "Off", "Migrate", { from = 2, to = 3, cut = {}, digest = "x", reason = "forged" }, off.client:serverTime() + 100, nil, 3)
    local status = Ledger.Receive(off.engine.store, forged)
    assert(status == "appended"); off.engine:rebuild()
    local conflict
    for _, c in ipairs(off.engine:Conflicts()) do if c.type == "Migrate" then conflict = c.reason end end
    assert(conflict, "a Migrate entry that is not the ledger owner's is refused by every client")
end)

H.section("Migration lab: the interactive world the simulator page drives")
test("the lab's world walks through a migration: write, cut over, a stale write, update, and a wrong upcaster is caught", function()
    local L = Lab.New()
    local s = L:state()
    eq(#s.players, 5); eq(s.format, 2); assert(not s.migrated)
    for _, p in ipairs(s.players) do eq(p.status, "in sync"); eq(p.format, 2) end
    assert(L:write("GM", "member")); assert(L:write("Off", "member")); assert(L:write("Off", "award")); assert(L:write("GM", "award"))
    L:advance(15)
    s = L:state()
    local top = s.players[1].top[1]
    for _, p in ipairs(s.players) do eq(p.status, "in sync", p.name .. " has the same ledger"); eq(p.top[1], top, p.name .. " the same standings") end
    eq(select(2, L:write("Cass", "member")), "notauthorized", "a raider can't write")
    -- the cutover
    assert(L:migrate()); L:advance(15)
    s = L:state()
    eq(s.format, 3); assert(s.migrated and s.cutover.events > 0)
    local by = {}
    for _, p in ipairs(s.players) do by[p.name] = p end
    for _, n in ipairs { "GM", "Cass", "Dara" } do eq(by[n].format, 3, n); eq(by[n].verified, true, n .. " checked the digest") end
    for _, n in ipairs { "Off", "Eira" } do eq(by[n].format, 2, n); eq(by[n].unreadable, 3, n .. " was told it can't read format 3") end
    -- the unupdated officer writes in the old format; it is recorded as stale, not applied
    assert(L:write("Off", "member")); L:advance(15)
    s = L:state(); by = {}
    for _, p in ipairs(s.players) do by[p.name] = p end
    assert(by.GM.stale >= 1 and by.Cass.stale == by.GM.stale, "stale writes are recorded on every new client")
    -- they update and catch up
    assert(L:update("Off")); assert(L:update("Eira")); L:advance(40)
    s = L:state(); by = {}
    for _, p in ipairs(s.players) do by[p.name] = p; eq(p.status, "in sync", p.name); eq(p.format, 3, p.name) end
    eq(select(2, L:update("GM")), "alreadynew"); eq(select(2, L:migrate()), "badmigrate")
    -- a client with a wrong upcaster
    assert(L:joinWrong()); L:advance(40)
    s = L:state()
    for _, p in ipairs(s.players) do if p.name == "Fenn" then eq(p.frozen, "migrationmismatch") end end
    eq(select(2, L:joinWrong()), "alreadyjoined")
    assert(#L:state().log > 6, "what happened is recorded in words")
end)

H.section("Migration: an older release over a newer ledger (a rollback) loses nothing")
test("an entry in a format this build can't read hides nothing before it: the readable part of the ledger is kept", function()
    local saved = deepCopy(golden.ledger)
    local chain = saved.chains["GM#00000001"].events
    local last = chain[#chain]
    local future = { v = 3, ledger = last.ledger, chain = last.chain, seq = last.seq + 1, prev = last.id, ts = last.ts + 10, author = last.author,
        type = "Pass", list = "main", data = { member = "A-Realm", item = "x" } }
    future.id = Ledger.EventId(future)
    chain[#chain + 1] = future
    local store, problems = Ledger.LoadStore(saved)
    local p = problems["GM#00000001"]
    assert(p and p.reason == "badversion" and p.ahead and p.format == 3 and p.index == #chain, "marked as ahead, not as damage")
    local n = 0
    for _, c in pairs(store.chains) do n = n + #c.events end
    eq(n, 41, "every readable entry is kept (the whole golden ledger)")
    assert(store.id, "the ledger itself is still there")
    local view = Ledger.View(store)
    eq(#view.conflicts, 0)
    for id, want in pairs(golden.expect.lists) do eq(table.concat(view.lists[id].order, ","), table.concat(want.order, ","), "standings of " .. id) end
    -- real damage is still dropped whole
    local tampered = deepCopy(golden.ledger)
    tampered.chains["GM#00000001"].events[5].data.member = "Evil"
    local store2, problems2 = Ledger.LoadStore(tampered)
    assert(problems2["GM#00000001"] and not problems2["GM#00000001"].ahead and not store2.chains["GM#00000001"], "tampering is not the same as a newer format")
    -- and when the FIRST entry is unreadable there is nothing to keep, but nothing is dropped as damage
    local first = deepCopy(golden.ledger)
    first.chains["GM#00000001"].events[1].v = 3
    local _, problems3 = Ledger.LoadStore(first)
    assert(problems3["GM#00000001"] and problems3["GM#00000001"].ahead and problems3["GM#00000001"].index == 1)
end)

test("an older release over a newer ledger shows what it can read, says so, refuses to write and never overwrites the saved data; updating brings everything back", function()
    local w = Lab.world({ latency = 0.1, seed = 11 })
    local gm = Lab.node(w, "GM", makeRules3())
    assert(gm.engine:CreateList("main", "Main"))
    for i = 1, 3 do assert(gm.engine:Append("main", "AddMember", { member = "M" .. i, to = "bottom" })) end
    assert(gm.engine:Migrate(3, "rollback test"))
    local gmCid = gm.engine:MyChain()
    local saved = deepCopy(gm.client:storage().account.ledger)
    local total = #saved.chains[gmCid].events
    -- the player's machine: an older release (format 2 only) is installed over the newer one's saved data
    local client = MockClient.New({ name = "Old", seed = 9 })
    client:storage().account.ledger = saved
    local old = Engine.New(client, { rules = Migrations.Default })
    assert(old:Ahead()[gmCid], "the chain is marked ahead"); eq(old:Ahead()[gmCid].format, 3)
    eq(table.concat(old:Get("main").state.order, ","), "M1,M2,M3", "the readable ledger is there")
    assert(table.concat(client.printed, "\n"):find("newer format", 1, true), "it says so: " .. table.concat(client.printed, "\n"))
    eq(#client:storage().account.ledger.chains[gmCid].events, total, "the saved data still holds every entry, including the unreadable one")
    local ev, why = old:Append("main", "Pass", { member = "M1", item = "x" })
    eq(ev, nil); eq(why, "ahead", "writing is paused rather than building on a truncated view")
    -- it is told through the commands too
    local cmd = SK.modules.Commands.New({ client = client, engine = old })
    client.printed = {}; cmd.handle("migrate status")
    assert(table.concat(client.printed, "\n"):find("newer format", 1, true), table.concat(client.printed, "\n"))
    -- the player updates: the same saved data, a release that reads format 3
    local updated = Engine.New(client, { rules = makeRules3() })
    eq(next(updated:Ahead()), nil, "nothing is ahead any more"); eq(updated:Format(), 3); eq(updated:Frozen(), nil)
    eq(#client:storage().account.ledger.chains[gmCid].events, total, "still every entry")
    eq(table.concat(updated:Get("main").state.order, ","), "M1,M2,M3")
end)
