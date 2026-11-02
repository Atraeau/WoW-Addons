-- King's Gambit: the migration lab. Pure Lua, development only: it is never part of the addon the game loads.
--
-- It holds everything needed to try the ledger migration strategy (design journal: "Decision: ledger migration") against a SIMULATED breaking
-- change, and is shared by the tests (tests/test_migration.lua) and the simulator page (the Migration lab tab), so both run the same code:
--
--   Lab.rules(variant)    the simulated format 3: Award's `member` and `to` become `winner` and `recipient` (structural), and a new member with no
--                         stated position goes to the TOP of the list instead of the bottom (semantic). A variant breaks the upcaster on purpose.
--   Lab.evaluate(seed, lossy)  a scored run: a guild of real engines on a simulated network moves from format 2 to format 3 with players on
--                         different releases. Returns a scorecard.
--   Lab.mutations()       breaks the strategy three ways on purpose and checks the evaluation notices each.
--   Lab.New()             an interactive world to poke at (what the page's lab drives).
--
-- A correct migration keeps both honest: an old Award means what it always meant, and an old AddMember with no position still lands at the bottom,
-- because its upcaster makes the old default explicit.
local SK = ...
local M = SK.modules
local MockClient, Engine, Sync, SimNetwork = M.MockClient, M.Engine, M.Sync, M.SimNetwork
local Ledger, Migrations, Standings = M.Ledger, M.Migrations, M.Standings

local Lab = {}

local function copy(t) local o = {} for k, v in pairs(t) do o[k] = v end return o end

---------------------------------------------------------------- the simulated format 3
-- variant: nil (correct), "forgetdefault" (the upcaster forgets to make the old default explicit), "dropawards" (it refuses old awards)
function Lab.rules(variant)
    local base = Standings.HANDLERS
    local handlers = copy(base)

    -- format 3's own reading of the two events that changed
    handlers.Award = function(s, ev, d)
        local d2 = copy(d)
        d2.member, d2.to = d.winner, d.recipient
        d2.winner, d2.recipient = nil, nil
        return base.Award(s, ev, d2)
    end
    handlers.AddMember = function(s, ev, d)
        if d.to == nil and d.above == nil then d = copy(d); d.to = "top" end
        return base.AddMember(s, ev, d)
    end

    -- format 2 -> 3: same meaning, new shape; the old default is written down
    local function up2(ev)
        local d = copy(ev.data)
        if ev.type == "Award" then
            if variant == "dropawards" then return nil, "refused" end
            d.winner, d.recipient = d.member, d.to
            d.member, d.to = nil, nil
        elseif ev.type == "AddMember" and d.to == nil and d.above == nil and variant ~= "forgetdefault" then
            d.to = "bottom"
        end
        return Migrations.Derive(ev, { data = d })
    end

    -- format 3 -> 2: to write the old format while the ledger has not moved yet
    local function down3(ev)
        local d = copy(ev.data)
        if ev.type == "Award" then
            d.member, d.to = d.winner, d.recipient
            d.winner, d.recipient = nil, nil
        elseif ev.type == "AddMember" and d.to == nil and d.above == nil then
            d.to = "top" -- format 3's default, made explicit for readers who only know format 2
        end
        return Migrations.Derive(ev, { data = d })
    end

    return { current = 3, read = { [2] = true, [3] = true }, upcast = { [2] = up2 }, downcast = { [3] = down3 }, handlers = handlers,
        name = "simulated format 3" .. (variant and (" (" .. variant .. ")") or "") }
end

---------------------------------------------------------------- a world of real engines on a simulated network
local seedCounter = 0

function Lab.world(netOpts)
    return { net = SimNetwork.New(netOpts or { latency = 0.1, seed = 1 }), nodes = {} }
end

-- A player: their own client, engine and sync, running the code `rules` describes. build = the addon version they report.
function Lab.node(w, name, rules, build, client)
    seedCounter = seedCounter + 1
    client = client or MockClient.New({ name = name, seed = seedCounter * 53 })
    client:setAddonVersion(build or "0.2.0+1")
    local engine = Engine.New(client, { rules = rules })
    local sync = Sync.New(engine, { heartbeat = 5, firstHeartbeat = 0.5, firstJitter = 1 })
    w.net:attach(client); sync:start()
    local nd = { name = name, full = name, client = client, engine = engine, sync = sync, rules = rules, unreadable = {} }
    sync:on("unreadable", function(e) nd.unreadable[#nd.unreadable + 1] = e end)
    w.nodes[name] = nd
    return nd
end

-- A player updates the addon: the same saved ledger on the same machine, new code.
function Lab.update(w, name, rules)
    local old = w.nodes[name]
    old.sync:stop()
    return Lab.node(w, name, rules, "0.2.0+2", old.client)
end

local function order(nd) local c = nd.engine:Get("main"); return c and (table.concat(c.state.order, ",")) or "none" end
local function fp(nd) return nd.engine:Fingerprint() or "none" end
Lab.order, Lab.fp = order, fp

-- Run the clock until everyone named has the same ledger (at most `limit` simulated seconds). Returns seconds, and whether they agree.
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
Lab.settle = settle

-- Run the clock until `cond()` holds (at most `limit` simulated seconds). Returns seconds, and whether it held.
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

---------------------------------------------------------------- the evaluation
-- One scored run. Returns a scorecard, { { name, ok, detail }... }, and numbers about the run. `lossy` makes the network drop and repeat messages.
function Lab.evaluate(seed, lossy)
    local rnd = (function() local s = seed * 7919 + 13 return function(n) s = (s * 1103515245 + 12345) % 2147483648; return s % n + 1 end end)()
    local w = Lab.world({ latency = 0.1, seed = seed, dropRate = lossy and 0.2 or 0, duplicateRate = lossy and 0.2 or 0 })
    local net = w.net
    local rules3 = Lab.rules()
    local card, stats = {}, { seed = seed, lossy = lossy }
    local function mark(name, ok, detail) card[#card + 1] = { name = name, ok = ok and true or false, detail = detail } end

    -- who runs what: the guild master and two raiders are on the new release; an officer and a raider have not updated yet
    local gm, cass, dara = Lab.node(w, "GM", rules3), Lab.node(w, "Cass", rules3), Lab.node(w, "Dara", rules3)
    local off, eira = Lab.node(w, "Off", Migrations.Default), Lab.node(w, "Eira", Migrations.Default)
    assert(gm.engine:CreateList("main", "Main")); assert(gm.engine:Write("SetOfficers", { names = { "Off" } }))
    for i = 1, 6 do assert(gm.engine:Append("main", "AddMember", { member = "M" .. i, to = "bottom" })) end
    settle(w, { "GM", "Cass", "Dara", "Off", "Eira" })

    -- history, written by the new release (GM) and the old one (Off) alike
    local function active(nd)
        local out = {}
        for _, m in ipairs(nd.engine:Get("main").state.order) do out[#out + 1] = m end
        return out
    end
    local function liveAwards(nd)
        local out = {}
        for id in pairs(nd.engine:Get("main").state.awards) do
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
        if op == 1 then return nd.engine:Append("main", "AddMember", { member = "N" .. n })                  -- no position: format 2 bottom, format 3 top
        elseif op == 2 then return nd.engine:Append("main", "AddMember", { member = "N" .. n, to = rnd(2) == 1 and "top" or "bottom" })
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
    for i = 1, 30 do
        local nd = (i % 2 == 0) and off or gm
        randomOp(nd)
        if i % 5 == 0 then net:advance(1) end
    end
    -- The one case a wrong upcaster of this change breaks is a member added with NO position by the old release (format 2: the bottom). The digest
    -- only proves the history it covers, so make sure this one does, and that nothing later moves them: a migration is only as well tested as its corpus.
    assert(off.engine:Append("main", "AddMember", { member = "Legacy" }))
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
    local m = gm.engine:View().auth.migrations[1]
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
    assert(gm.engine:Append("main", "AddMember", { member = "Newcomer" }))
    local winner = (order(gm):gsub("^[^,]+,", "")):match("^[^,]+")
    assert(gm.engine:Append("main", "Award", { winner = winner, item = "After" }))
    local staleWrites = 0
    for i = 1, 2 do
        if off.engine:Append("main", "MovePlayer", { member = "M" .. i, to = "top", reason = "old release, after the cutover" }) then staleWrites = staleWrites + 1 end
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
    local fenn = Lab.node(w, "Fenn", Lab.rules("forgetdefault"))
    waitFor(w, function() return fenn.engine:Frozen() ~= nil end, 400)
    mark("a client whose upcaster disagrees with the migration notices (its replay does not match the digest)", fenn.engine:Frozen() ~= nil and fenn.engine:Frozen().reason == "migrationmismatch")
    local ev, werr = fenn.engine:Append("main", "Pass", { member = "M1", item = "x" })
    mark("and refuses to write rather than writing something the guild would not agree with", ev == nil and werr == "frozen", tostring(werr))
    mark("while the correct clients are unaffected", gm.engine:Frozen() == nil and cass.engine:Frozen() == nil)

    -- the laggards update and catch up
    Lab.update(w, "Off", Lab.rules())
    Lab.update(w, "Eira", Lab.rules())
    local tl, convAll = settle(w, { "GM", "Cass", "Dara", "Off", "Eira" })
    mark("when the old releases update they catch up from the same saved ledger and everyone converges", convAll, "settled in " .. tl .. " s")
    mark("on the same standings", order(w.nodes.Off) == order(gm) and order(w.nodes.Eira) == order(gm))
    mark("with the same record of what was stale", #w.nodes.Off.engine:Conflicts() == #gm.engine:Conflicts() and w.nodes.Eira.engine:Format() == 3 and w.nodes.Off.engine:Format() == 3)
    local late = w.nodes.Off.engine:Append("main", "Award", { winner = "M3", item = "Updated" })
    mark("and the updated officer can write again, in format 3", late ~= nil and late.v == 3)
    stats.lateSeconds = tl
    return card, stats
end

-- The names of the checks that did not hold.
function Lab.failed(card)
    local out = {}
    for _, c in ipairs(card) do if not c.ok then out[#out + 1] = c.name .. (c.detail and (" (" .. c.detail .. ")") or "") end end
    return out
end

---------------------------------------------------------------- does the evaluation have teeth?
-- Break the strategy three ways on purpose and check the evaluation notices each. Returns { { name, caught, detail }... }.
function Lab.mutations()
    local function anyContains(list, text) for _, s in ipairs(list) do if s:find(text, 1, true) then return true end end return false end
    local function run(patch, restore)
        patch()
        local ok, card, stats = pcall(Lab.evaluate, 1, false)
        restore()
        return ok, card
    end
    local out = {}

    local realVerify = Ledger.VerifyMigrations
    local ok, card = run(function() Ledger.VerifyMigrations = function() end end, function() Ledger.VerifyMigrations = realVerify end)
    local failed = ok and Lab.failed(card) or {}
    out[#out + 1] = { name = "clients stop checking the migration's digest",
        caught = not ok or (anyContains(failed, "a client whose upcaster disagrees") and anyContains(failed, "every new client replayed")),
        detail = ok and (#failed .. " check(s) failed: a client with a wrong upcaster went unnoticed") or "the guild stopped working" }

    local realFor = Migrations.FormatFor
    ok, card = run(function() Migrations.FormatFor = function() return 3 end end, function() Migrations.FormatFor = realFor end)
    failed = ok and Lab.failed(card) or {}
    out[#out + 1] = { name = "the cut is ignored (every entry is treated as already in the new format)", caught = not ok or #failed > 0,
        detail = ok and (#failed .. " check(s) failed") or "the guild stopped working: its own old entries were refused as stale" }

    local realCut, calls = Ledger.CutDigest, 0
    ok, card = run(function()
        Ledger.CutDigest = function(store, cut) calls = calls + 1; return calls == 1 and "0000000000000000" or realCut(store, cut) end
    end, function() Ledger.CutDigest = realCut end)
    failed = ok and Lab.failed(card) or {}
    out[#out + 1] = { name = "the guild master records a wrong digest",
        caught = (not ok) or anyContains(failed, "every new client replayed the old history"),
        detail = ok and (#failed .. " check(s) failed") or "every client refused to write: the guild stopped" }
    return out
end

---------------------------------------------------------------- an interactive world (the page's lab)
local MEMBERS = 6

-- Players: GM (guild master) and Cass, Dara are on the new release; Off (an officer) and Eira have not updated. Fenn can join with a wrong upcaster.
function Lab.New()
    local L = { log = {}, counter = 0 }
    local w, rules3

    local function note(text) L.log[#L.log + 1] = { t = w.net.time, text = text } end

    function L:reset()
        rules3 = Lab.rules()
        w = Lab.world({ seed = 3, latency = 0.15 })
        L.w, L.log, L.counter = w, {}, 0
        local gm = Lab.node(w, "GM", rules3)
        Lab.node(w, "Off", Migrations.Default); Lab.node(w, "Cass", rules3); Lab.node(w, "Dara", rules3); Lab.node(w, "Eira", Migrations.Default)
        assert(gm.engine:CreateList("main", "Main")); assert(gm.engine:Write("SetOfficers", { names = { "Off" } }))
        for i = 1, MEMBERS do assert(gm.engine:Append("main", "AddMember", { member = "M" .. i, to = "bottom" })) end
        settle(w, { "GM", "Off", "Cass", "Dara", "Eira" })
        w.net:advance(2)
        L.log = {}
        note("Five players share one ledger in format 2. GM, Cass and Dara run the new release (it can read formats 2 and 3). Off and Eira have not updated yet (format 2 only).")
    end

    function L:advance(sec) w.net:advance(tonumber(sec) or 0) end

    -- kind: "member" (a new member, no position stated) or "award" (the player at the top wins an item)
    function L:write(name, kind)
        local nd = w.nodes[name]
        if not nd then return false, "noplayer" end
        L.counter = L.counter + 1
        local fmt = nd.engine:Format()
        local ev, err, text
        if kind == "member" then
            local who = "N" .. L.counter
            ev, err = nd.engine:Append("main", "AddMember", { member = who })
            if ev then
                if nd.rules.current >= 3 and fmt < 3 then
                    text = ("%s added %s with no position. The ledger is still in format 2, so the new release wrote its own default, the top, as an explicit entry: %s is at the top for everyone."):format(name, who, who)
                elseif nd.rules.current >= 3 then
                    text = ("%s added %s with no position, in format 3: no position means the top."):format(name, who)
                else
                    text = ("%s added %s with no position, in format 2: no position means the bottom."):format(name, who)
                end
            end
        else
            local top = nd.engine:Get("main").state.order[1]
            if not top then return false, "nolist" end
            local data = nd.rules.current >= 3 and { winner = top, item = "Item " .. L.counter } or { member = top, item = "Item " .. L.counter }
            ev, err = nd.engine:Append("main", "Award", data)
            if ev then text = ("%s awarded Item %d to %s, written in format %d (%s)."):format(name, L.counter, (top), ev.v,
                nd.rules.current >= 3 and "the new release's fields are winner and recipient" or "the old release's fields are member and to") end
        end
        if not ev then return false, err end
        note(text)
        return true
    end

    function L:migrate()
        local ev, err = w.nodes.GM.engine:Migrate(3, "migration lab")
        if not ev then return false, err end
        note("The guild master wrote the cutover to format 3. It records exactly which entries are before it and the standings they produce. Players on the new release check that against their own replay; players on the old release can't read it.")
        return true
    end

    function L:update(name)
        local nd = w.nodes[name]
        if not nd then return false, "noplayer" end
        if nd.rules.current >= 3 then return false, "alreadynew" end
        Lab.update(w, name, rules3)
        note(("%s updated to the new release: same saved ledger, new code. They now read formats 2 and 3 and catch up."):format(name))
        return true
    end

    function L:joinWrong()
        if w.nodes.Fenn then return false, "alreadyjoined" end
        Lab.node(w, "Fenn", Lab.rules("forgetdefault"))
        note("Fenn joined with a new release whose conversion of old entries is wrong (it forgets that an old 'no position' meant the bottom). Watch what it does when it replays the history.")
        return true
    end

    function L:net(drop, dup)
        w.net.dropRate, w.net.duplicateRate = tonumber(drop) or 0, tonumber(dup) or 0
        note(("Network now: %d%% of messages are thrown away, %d%% are delivered twice."):format(w.net.dropRate * 100, w.net.duplicateRate * 100))
    end

    function L:state()
        local names = { "GM", "Off", "Cass", "Dara", "Eira" }
        if w.nodes.Fenn then names[#names + 1] = "Fenn" end
        -- what most players agree on
        local tally, best = {}, nil
        for _, nm in ipairs(names) do
            local f = fp(w.nodes[nm])
            tally[f] = (tally[f] or 0) + 1
            if not best or tally[f] > tally[best] then best = f end
        end
        local gm = w.nodes.GM
        local m = gm.engine:View().auth.migrations[1]
        local out = { time = w.net.time, inFlight = w.net:inFlight(), stats = w.net.stats, drop = w.net.dropRate, dup = w.net.duplicateRate,
            format = gm.engine:Format(), migrated = m ~= nil, players = {}, log = L.log }
        if m then
            local cutTotal = 0
            for _, n in pairs(m.cut) do cutTotal = cutTotal + n end
            out.cutover = { events = cutTotal, digest = m.digest:sub(1, 8) }
        end
        for _, nm in ipairs(names) do
            local nd = w.nodes[nm]
            local view = nd.engine:View()
            local top = {}
            for i, who in ipairs(view.lists.main and view.lists.main.order or {}) do if i <= 6 then top[i] = (who) end end
            local stale, other = 0, 0
            for _, c in ipairs(nd.engine:Conflicts()) do if c.reason == "staleformat" then stale = stale + 1 else other = other + 1 end end
            local events = 0
            for _, chain in pairs(nd.engine.store.chains) do events = events + #chain.events end
            local release = nd.rules.current >= 3 and (nm == "Fenn" and "wrong" or "new") or "old"
            local verified
            local mm = view.auth.migrations[1]
            if mm and nd.engine.store.verified[mm.ev.id] then verified = nd.engine.store.verified[mm.ev.id].ok end
            local frozen = nd.engine:Frozen()
            out.players[#out.players + 1] = { name = nm, role = nm == "GM" and "guild master" or nm == "Off" and "officer" or "raider", release = release,
                reads = Migrations.Readable(nd.rules), format = nd.engine:Format(), events = events, head = fp(nd):sub(1, 8),
                top = top, members = view.lists.main and #view.lists.main.order or 0,
                status = fp(nd) == best and "in sync" or "behind", frozen = frozen and frozen.reason or nil, verified = verified,
                stale = stale, otherConflicts = other, unreadable = #nd.unreadable > 0 and nd.unreadable[1].format or nil }
        end
        return out
    end

    L:reset()
    return L
end

return Lab
