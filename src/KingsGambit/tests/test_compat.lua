-- The guard for Semantic Versioning (see src/Version.lua): the parts of the addon that decide whether two clients can share a
-- ledger are written down in tests/compat_baseline.lua, and this test fails when they change without a decision.
--
-- The surface: the ledger format number, every event type (what a list entry can be), every global event type, every request
-- kind, and every addon message type. An older client on the same line rejects an event type or message it doesn't know, so
-- adding or removing one is NOT a compatible change.
--
-- When this fails, you changed that surface. Decide:
--   * Older clients on the current line could not live with it (the usual case: a new or changed event type, a changed
--     meaning, a new message that must be understood): start a new line. Bump the TOC version's MINOR while MAJOR is 0, or
--     MAJOR from 1.0 on, and set `line` below to match. Then update the lists.
--   * It really is compatible (older clients ignore it): update only the lists below, and say why in the commit message.
-- A change in what an existing event DOES (how it moves standings) isn't visible here: that needs the same decision, by hand.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Hash, Standings, Ledger, Requests, Version = SK.modules.Hash, SK.modules.Standings, SK.modules.Ledger, SK.modules.Requests, SK.modules.Version

local function sorted(set)
    local out = {}
    for k in pairs(set) do out[#out + 1] = k end
    table.sort(out)
    return out
end

-- Every two-letter message type the addon sends or registers a handler for, found in the source.
local function messageTypes()
    local set = {}
    for _, f in ipairs { "src/Sync.lua", "src/LootNet.lua", "src/Requests.lua" } do
        local fh = assert(io.open(f, "rb"), f)
        local text = fh:read("a"); fh:close()
        for t in text:gmatch('t%s*=%s*"([A-Z][A-Z]?)"') do set[t] = true end
        for t in text:gmatch('register%("([A-Z][A-Z])"') do set[t] = true end
    end
    return sorted(set)
end

local function surface()
    return { ledgerFormat = Ledger.VERSION, listEvents = sorted(Standings.TYPES), globalEvents = sorted(Ledger.GLOBAL),
        requestKinds = sorted(Requests.KINDS), messages = messageTypes() }
end
H.compatSurface = surface -- tools/tests may print it (a new baseline)

local function diff(now, was)
    local inNow, inWas, out = {}, {}, {}
    for _, v in ipairs(now) do inNow[v] = true end
    for _, v in ipairs(was) do inWas[v] = true end
    for _, v in ipairs(now) do if not inWas[v] then out[#out + 1] = "+" .. v end end
    for _, v in ipairs(was) do if not inNow[v] then out[#out + 1] = "-" .. v end end
    return out
end

H.section("Compat: the ledger-facing surface and the version line")
local baseline = assert(loadfile("tests/compat_baseline.lua"))()

test("the ledger-facing surface matches the baseline; if it changed, the version line was decided on", function()
    local now, changes = surface(), {}
    if now.ledgerFormat ~= baseline.surface.ledgerFormat then
        changes[#changes + 1] = ("ledger format %s -> %s"):format(baseline.surface.ledgerFormat, now.ledgerFormat)
    end
    for _, key in ipairs { "listEvents", "globalEvents", "requestKinds", "messages" } do
        local d = diff(now[key], baseline.surface[key])
        if #d > 0 then changes[#changes + 1] = key .. ": " .. table.concat(d, " ") end
    end
    if #changes > 0 then
        error("The surface that decides whether clients can share a ledger changed:\n       " .. table.concat(changes, "\n       ")
            .. "\n       If older clients on line " .. baseline.line .. " could not live with this, start a new line: bump the TOC version"
            .. " (MINOR while MAJOR is 0, else MAJOR) and set `line` in tests/compat_baseline.lua. Either way, update the lists there."
            .. "\n       See the header of tests/test_compat.lua.", 0)
    end
end)

test("the TOC version is Semantic Versioning, and its line is the one the baseline records", function()
    for _, f in ipairs { "src/KingsGambit.toc", "src/KingsGambit_Camelot.toc" } do
        local fh = assert(io.open(f, "rb"))
        local text = fh:read("a"); fh:close()
        local v = text:match("\n##%s*Version%s*:%s*([^\r\n]+)")
        assert(v and Version.Parse(v), f .. ": '## Version:' must be Semantic Versioning (MAJOR.MINOR.PATCH), got " .. tostring(v))
        eq(Version.Line(v), baseline.line, f .. ": the TOC version " .. v .. " is on line " .. tostring(Version.Line(v))
            .. " but tests/compat_baseline.lua says " .. baseline.line .. ": change both together")
    end
end)
