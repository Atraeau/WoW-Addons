-- King's Gambit: the schema of every ledger event type, for every format that has ever been published. Pure Lua.
--
-- Why this exists. The ledger is append-only and never rewritten, so every event ever written stays in the shape it was written in.
-- To migrate a ledger however old it has become, we have to know exactly what each event looked like in each format. This file is that
-- record: one table per format, one entry per event type, naming every field, its type, and whether it is required.
--
-- The rule: a published (format, type) entry is FROZEN. tests/schema_baseline.lua holds a hash of each, and tests/test_schemas.lua
-- fails if one changes or disappears. To change an event, make a new format: a new table here, and an upcaster from the old one
-- (Migrations.lua). Adding an event type to a format is a change to the ledger's surface and starts a new compatibility line
-- (Version.lua), and its hash is added to the baseline on purpose.
--
-- A field spec is a type name, with "!" after it when the field is required: "name!", "pos", "int!". Fields not listed are ignored by
-- validation (readers ignore what they don't know); the field lists are what the format's own code reads and writes. `list` says whether
-- the event belongs to a list (so its envelope carries `list`) or is a ledger-wide event.
-- Keep this file Lua 5.1-safe.
local _, SK = ...
local Hash
local M = SK:NewModule("Schemas", { "Hash" }, function(d) Hash = d.Hash end)

local CLASS_TOKENS = { WARRIOR = true, PALADIN = true, HUNTER = true, ROGUE = true, PRIEST = true, SHAMAN = true, MAGE = true,
    WARLOCK = true, DRUID = true }
local ROLES = { tank = true, melee = true, hunter = true, caster = true, healer = true }
local SALVAGE = { keep = true, gift = true, sell = true, disenchant = true, bank = true }

local function isName(v) return type(v) == "string" and v ~= "" end
local function allOf(list, ok)
    if type(list) ~= "table" then return false end
    for _, v in ipairs(list) do if not ok(v) then return false end end
    return true
end

-- The field types. Each takes a value and says whether it is valid.
M.TYPES = {
    name = isName,                                   -- a non-empty string (a player, an item name, an id, a reason)
    text = function(v) return type(v) == "string" end,
    number = function(v) return type(v) == "number" and v == v end,
    int = function(v) return type(v) == "number" and v == math.floor(v) end,
    time = function(v) return type(v) == "number" end,
    pos = function(v) return v == "top" or v == "bottom" end,
    names = function(v) return allOf(v, isName) end,
    classes = function(v) return allOf(v, function(c) return CLASS_TOKENS[c] == true end) end,
    roles = function(v) return allOf(v, function(r) return ROLES[r] == true end) end,
    salvage = function(v) return SALVAGE[v] == true end,
    table = function(v) return type(v) == "table" end,
}

-- Fields that may appear on any event: when the loot became visible, and who asked for it and why (a corrected or requested entry).
local COMMON = { seen = "time", requestedBy = "name", rid = "name" }

-- The envelope every event has, in format 2.
local ENVELOPE2 = { v = "int!", ledger = "text!", chain = "name!", seq = "int!", prev = "name!", ts = "time!", author = "name!",
    type = "name!", list = "text", data = "table!", id = "name!" }

local FORMATS = {}

---------------------------------------------------------------- format 2 (released in 0.1.x)
FORMATS[2] = {
    envelope = ENVELOPE2,
    types = {
        -- events on a list
        CreateList = { list = true, data = { name = "name!" } },
        AddMember = { list = true, data = { member = "name!", class = "text", to = "pos", above = "name" } },
        RemoveMember = { list = true, data = { member = "name!", reason = "text" } },
        Award = { list = true, data = { member = "name!", item = "name!", to = "name", replaces = "name", reason = "text" } },
        Pass = { list = true, data = { member = "name!", item = "name!", kind = "text" } },
        Transfer = { list = true, data = { award = "name!", to = "name!", member = "name", reason = "text" } },
        Disenchant = { list = true, data = { item = "name!", to = "name!" } },
        -- what disenchanting an item actually gave (0.5.0): written by the Master Looter, for the disenchanter it was given to
        -- (`requestedBy` when the disenchanter reported it). `disenchant` is the id of the Disenchant event it is about; `results` is a list of
        -- { name, count, item? }. It moves nobody. The Disenchant event itself is never changed.
        DisenchantResult = { list = true, data = { disenchant = "name!", results = "table!" } },
        Salvage = { list = true, data = { award = "name!", action = "salvage!", member = "name" } },
        MovePlayer = { list = true, data = { member = "name!", reason = "name!", to = "pos", above = "name" } },
        Revert = { list = true, data = { target = "name!", member = "name", reason = "text" } },
        -- ledger-wide events
        Genesis = { list = false, data = { name = "name!" } },
        SetGuildMaster = { list = false, data = { name = "name!" } },
        SetOfficers = { list = false, data = { names = "names!" } }, -- (no longer used from 0.7.0: officers are the game's; old entries still read)
        -- an officer says to ignore a player's entries from now on (0.7.0), or to stop (`lift` = 1); the same on every client. It moves nobody.
        Disregard = { list = false, data = { name = "name!", reason = "name!", lift = "int" } },
        Elevate = { list = false, data = { raid = "name!", ml = "name!", minutes = "number!" } },
        Revoke = { list = false, data = { raid = "name!" } },
        RaidClose = { list = false, data = { raid = "name!" } },
        SetDisenchanter = { list = false, data = { raid = "name!", name = "name!" } },
        Declined = { list = false, data = { request = "name!", requestedBy = "name!", declineReason = "name!", kind = "text", member = "text", item = "number",
            class = "text", spec = "text" } },
        ItemClasses = { list = false, data = { item = "int!", classes = "classes!", reason = "name!", class = "text", spec = "text", name = "text" } },
        ItemSuits = { list = false, data = { item = "int!", roles = "roles!", reason = "name!" } },
        -- who was in a raid (0.6.0): written by the raid's Master Looter as the group changes. `joined` and `left` are the players who came and went since
        -- their last entry for this raid; the first entry's `joined` is everyone there when it started. It moves nobody.
        Attendance = { list = false, data = { raid = "name!", joined = "names", left = "names" } },
        -- the cutover to a new format (see Migrations.lua): written by the ledger owner, in the NEW format
        Migrate = { list = false, data = { from = "int!", to = "int!", cut = "table!", digest = "name!", reason = "name!" } },
        -- how raids pick their list (see the design journal, "a raid chooses its list when it opens")
        SetRaidList = { list = false, data = { raid = "name!", list = "name!" } },
        SetListPolicy = { list = false, data = { mode = "name!" } },
    },
}
M.FORMATS = FORMATS
M.COMMON = COMMON

---------------------------------------------------------------- reading the registry
-- The formats described here, lowest first.
function M.Formats()
    local out = {}
    for f in pairs(FORMATS) do out[#out + 1] = f end
    table.sort(out)
    return out
end

-- The schema of one event type in one format, or nil.
function M.Get(format, type_)
    local f = FORMATS[format]
    return f and f.types[type_]
end

-- Every event type of a format, sorted.
function M.Types(format)
    local f = FORMATS[format]
    local out = {}
    if f then for t in pairs(f.types) do out[#out + 1] = t end end
    table.sort(out)
    return out
end

local function check(spec, value, where)
    local typeName, required = spec:match("^(%a+)(!?)$")
    local ok = M.TYPES[typeName]
    if not ok then return nil, where .. ": unknown field type " .. spec end
    if value == nil then
        if required == "!" then return nil, where .. " is required" end
        return true
    end
    if not ok(value) then return nil, where .. " is not a valid " .. typeName end
    return true
end

-- Does `ev` (an event as stored, in `format`) match that format's schema? Returns true, or nil + why.
function M.Validate(format, ev)
    local f = FORMATS[format]
    if not f then return nil, "unknownformat" end
    if type(ev) ~= "table" then return nil, "notanevent" end
    for field, spec in pairs(f.envelope) do
        local ok, why = check(spec, ev[field], "envelope." .. field)
        if not ok then return nil, why end
    end
    local t = f.types[ev.type]
    if not t then return nil, "unknowntype" end
    if t.list and not isName(ev.list) then return nil, "envelope.list is required for " .. ev.type end
    for field, spec in pairs(t.data) do
        local ok, why = check(spec, ev.data[field], ev.type .. "." .. field)
        if not ok then return nil, why end
    end
    for field, spec in pairs(COMMON) do
        local ok, why = check(spec, ev.data[field], ev.type .. "." .. field)
        if not ok then return nil, why end
    end
    return true
end

-- A fingerprint of one format's entry for one type (what the frozen baseline records).
function M.Hash(format, type_)
    local t = M.Get(format, type_)
    if not t then return nil end
    return Hash.Sum(Hash.Canon({ list = t.list, data = t.data }))
end
function M.EnvelopeHash(format)
    local f = FORMATS[format]
    return f and Hash.Sum(Hash.Canon(f.envelope))
end
