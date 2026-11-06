-- The record of every event type in every published format (src/Schemas.lua), frozen by a baseline, and the golden ledgers that prove
-- any ledger written in an old format can still be loaded, verified and replayed to the same standings. See the design journal
-- ("Decision: ledger migration").
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Schemas, Standings, Ledger = SK.modules.Schemas, SK.modules.Standings, SK.modules.Ledger

local baseline = assert(loadfile("tests/schema_baseline.lua"))()

-- Event types a format gained AFTER it was first published, so the golden ledger of that release doesn't use them.
local ADDED_LATER = { [2] = { Migrate = "0.2.0", SetRaidList = "0.4.0", SetListPolicy = "0.4.0", DisenchantResult = "0.5.0", Attendance = "0.6.0" } }

local function setOf(list) local s = {} for _, v in ipairs(list) do s[v] = true end return s end
local function sortedKeys(set) local o = {} for k in pairs(set) do o[#o + 1] = k end table.sort(o) return o end

H.section("Schemas: every event type, every format, frozen")
test("the current format's schema names exactly the event types the code handles", function()
    local handled = {}
    for t in pairs(Standings.TYPES) do handled[t] = true end
    for t in pairs(Ledger.GLOBAL) do handled[t] = true end
    local described = setOf(Schemas.Types(Ledger.VERSION))
    for t in pairs(handled) do assert(described[t], "an event type with no schema in format " .. Ledger.VERSION .. ": " .. t) end
    for t in pairs(described) do assert(handled[t], "a schema for an event type nothing handles: " .. t) end
end)

test("a published schema never changes: the baseline holds a hash of every (format, type); new types are added on purpose", function()
    local problems = {}
    for _, f in ipairs(Schemas.Formats()) do
        local b = baseline[f]
        if not b then problems[#problems + 1] = "format " .. f .. " has no entry in tests/schema_baseline.lua"
        else
            if Schemas.EnvelopeHash(f) ~= b.envelope then problems[#problems + 1] = "format " .. f .. ": the envelope changed" end
            for _, t in ipairs(Schemas.Types(f)) do
                if not b.types[t] then problems[#problems + 1] = ("format %d: new event type %s (record its hash in the baseline, and bump the version line)"):format(f, t)
                elseif Schemas.Hash(f, t) ~= b.types[t] then problems[#problems + 1] = ("format %d: the PUBLISHED schema of %s changed: make a new format and an upcaster instead"):format(f, t) end
            end
            for t in pairs(b.types) do
                if not Schemas.Get(f, t) then problems[#problems + 1] = ("format %d: the published event type %s was removed"):format(f, t) end
            end
        end
    end
    for f in pairs(baseline) do
        if not Schemas.FORMATS[f] then problems[#problems + 1] = "the published format " .. f .. " was removed" end
    end
    if #problems > 0 then error("Published schemas changed:\n       " .. table.concat(problems, "\n       "), 0) end
end)

test("validation checks required fields and types, and ignores fields it does not know", function()
    local function ev(t, data, list) return { v = 2, ledger = "x", chain = "A#00000001", seq = 1, prev = "0", ts = 1, author = "A", type = t, list = list, data = data, id = "abc" } end
    assert(Schemas.Validate(2, ev("Award", { member = "A", item = "I" }, "main")))
    assert(Schemas.Validate(2, ev("Award", { member = "A", item = "I", to = "B", replaces = "id", seen = 5, futureField = 1 }, "main")), "unknown fields are ignored")
    local ok, why = Schemas.Validate(2, ev("Award", { item = "I" }, "main")); assert(not ok and why:find("Award.member is required"), tostring(why))
    ok, why = Schemas.Validate(2, ev("Award", { member = "A", item = "I", to = 5 }, "main")); assert(not ok and why:find("Award.to"), tostring(why))
    ok, why = Schemas.Validate(2, ev("AddMember", { member = "A", to = "middle" }, "main")); assert(not ok and why:find("AddMember.to"), tostring(why))
    ok, why = Schemas.Validate(2, ev("Award", { member = "A", item = "I" })); assert(not ok and why:find("list is required"), tostring(why))
    ok, why = Schemas.Validate(2, ev("Frobnicate", {})); eq(why, "unknowntype")
    ok, why = Schemas.Validate(9, ev("Award", {})); eq(why, "unknownformat")
    assert(Schemas.Validate(2, ev("SetOfficers", { names = {} })), "an empty officer list is valid")
    assert(not Schemas.Validate(2, ev("SetOfficers", { names = { "" } })))
    assert(not Schemas.Validate(2, ev("ItemClasses", { item = 1, classes = { "WIZARD" }, reason = "x" })))
end)

H.section("Schemas: the golden ledger of format 2 (released in 0.1.x)")
local golden = assert(loadfile("tests/ledgers/format_2.lua"))()
H.goldenFormat2 = golden

test("every event type format 2 had when it was published appears in the golden ledger", function()
    local used = {}
    for _, chain in pairs(golden.ledger.chains) do for _, ev in ipairs(chain.events) do used[ev.type] = true end end
    for _, t in ipairs(Schemas.Types(2)) do
        if not ADDED_LATER[2][t] then assert(used[t], "the golden ledger does not use the event type " .. t) end
    end
    for t in pairs(used) do assert(Schemas.Get(2, t), "the golden ledger has an event type with no schema: " .. t) end
end)

test("every event in the golden ledger matches its schema", function()
    for cid, chain in pairs(golden.ledger.chains) do
        for i, ev in ipairs(chain.events) do
            local ok, why = Schemas.Validate(golden.format, ev)
            assert(ok, ("%s event %d (%s): %s"):format(cid, i, ev.type, tostring(why)))
        end
    end
end)

test("the golden ledger loads, verifies every hash, and replays to exactly the standings it was frozen with", function()
    local store, problems = Ledger.LoadStore(golden.ledger)
    eq(next(problems), nil, "no chain failed verification")
    eq(Ledger.Fingerprint(store), golden.expect.fingerprint, "the same chains and heads")
    local view = Ledger.View(store)
    eq(#view.conflicts, 0, "nothing refused"); eq(#view.applied, golden.expect.applied); eq(#view.declined, golden.expect.declined)
    for id, want in pairs(golden.expect.lists) do
        local s = view.lists[id]
        assert(s, "list " .. id)
        eq(table.concat(s.order, ","), table.concat(want.order, ","), "order of " .. id)
        eq(s.count, want.count, "events applied to " .. id)
        for name, m in pairs(want.members) do
            local got = s.members[name]
            assert(got, id .. " has member " .. name)
            eq(got.active, m.active, name .. " active"); eq(got.wins, m.wins, name .. " wins"); eq(got.passes, m.passes, name .. " passes")
        end
    end
    for id, classes in pairs(golden.expect.itemRules) do
        eq(table.concat(view.itemRules[tonumber(id)].classes or {}, ","), table.concat(classes, ","), "the guild's rule for item " .. id)
    end
end)
