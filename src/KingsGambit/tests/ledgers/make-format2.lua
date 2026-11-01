-- Builds tests/ledgers/format2.lua: a REAL saved ledger in format 2 (the format released in 0.1.x) that uses every event type
-- that format has, together with the standings it must always replay to.
--
-- It is data, not a test: once written and committed it must NEVER change, and nobody should regenerate it. Its whole value is that
-- it is what format 2 looked like on the day it was published, so every later release can be held to loading, verifying and
-- replaying it to the same standings (tests/test_schemas.lua). Run from src/KingsGambit:  lua tests/ledgers/make-format2.lua
local H = dofile("tests/harness.lua")
local SK = H.SK
local Ledger, Hash = SK.modules.Ledger, SK.modules.Hash

local store = Ledger.NewStore()
local T = 1760000000
local EPOCH = { GM = "00000001", Off = "00000002", MLA = "0000000a", MLB = "0000000b" }
local function write(author, type_, data, ts, list)
    local cid = author .. "#" .. EPOCH[author]
    local ev = assert(Ledger.Build(store, cid, author, type_, data, T + ts, list))
    local status, err = Ledger.Receive(store, ev)
    assert(status == "appended", type_ .. ": " .. tostring(err))
    local view = Ledger.View(store)
    assert(#view.conflicts == 0, type_ .. " at +" .. ts .. " was refused: " .. tostring(view.conflicts[1] and view.conflicts[1].reason))
    return ev
end

local t = 0
local function tick() t = t + 10; return t end

write("GM", "Genesis", { name = "Golden Guild" }, tick())
write("GM", "SetGuildMaster", { name = "GM" }, tick())
write("GM", "SetOfficers", { names = { "Off" } }, tick())
write("GM", "CreateList", { name = "Main" }, tick(), "main")
write("GM", "CreateList", { name = "Off-spec" }, tick(), "off")
for _, m in ipairs { { "A", "WARRIOR" }, { "B", "PRIEST" }, { "C", "MAGE" }, { "D", "ROGUE" }, { "E", "DRUID" }, { "F", "HUNTER" } } do
    write("GM", "AddMember", { member = m[1] .. "-Realm", class = m[2] }, tick(), "main")
end
write("GM", "AddMember", { member = "G-Realm", class = "PALADIN", above = "C-Realm" }, tick(), "main")
write("GM", "AddMember", { member = "H-Realm", class = "WARLOCK", to = "top" }, tick(), "main")
write("GM", "AddMember", { member = "I-Realm", to = "bottom" }, tick(), "main")
for _, m in ipairs { "A", "B", "C" } do write("GM", "AddMember", { member = m .. "-Realm" }, tick(), "off") end

-- a raid: the Master Looter hands out loot
write("Off", "Elevate", { raid = "r1", ml = "MLA", minutes = 360 }, tick())
write("MLA", "SetDisenchanter", { raid = "r1", name = "E-Realm" }, tick())
local a1 = write("MLA", "Award", { member = "B-Realm", item = "Sword of Truth" }, tick(), "main")
local a2 = write("MLA", "Award", { member = "D-Realm", item = "Ring of Luck", to = "A-Realm" }, tick(), "main")
write("MLA", "Pass", { member = "C-Realm", item = "Ring of Luck", kind = "upgrade" }, tick(), "main")
write("MLA", "Pass", { member = "F-Realm", item = "Sword of Truth" }, tick(), "main")
local a3 = write("MLA", "Award", { member = "A-Realm", item = "Helm of Might", seen = T + t - 5 }, tick(), "main")
write("MLA", "Transfer", { award = a2.id, to = "C-Realm" }, tick(), "main")
write("MLA", "Salvage", { award = a3.id, action = "keep" }, tick(), "main")
write("MLA", "Disenchant", { item = "Cracked Wand", to = "E-Realm" }, tick(), "main")
write("MLA", "Award", { member = "B-Realm", item = "Cloak of Dust", reason = "won the off-spec roll" }, tick(), "off")
write("MLA", "Revert", { target = a1.id }, tick(), "main")                                    -- B's win undone, out of order
write("MLA", "Award", { member = "F-Realm", item = "Sword of Truth", replaces = a3.id, reason = "traded at the door" }, tick(), "main")
write("MLA", "RaidClose", { raid = "r1" }, tick())

-- the officer corrects, and the guild sets rules
write("Off", "MovePlayer", { member = "C-Realm", to = "top", reason = "fix a mistake" }, tick(), "main")
write("Off", "MovePlayer", { member = "H-Realm", above = "B-Realm", reason = "fix a mistake" }, tick(), "main")
write("Off", "RemoveMember", { member = "I-Realm", reason = "left the guild" }, tick(), "main")
write("Off", "AddMember", { member = "I-Realm", to = "top" }, tick(), "main")
write("GM", "ItemClasses", { item = 19019, classes = { "WARRIOR", "ROGUE" }, reason = "melee only" }, tick())
write("GM", "ItemSuits", { item = 18832, roles = { "melee" }, reason = "a melee sword" }, tick())
write("GM", "ItemSuits", { item = 18832, roles = {}, reason = "back to the heuristic" }, tick())
write("Off", "Declined", { request = "move B to the top", requestedBy = "B-Realm", declineReason = "not a mistake" }, tick())
write("Off", "Elevate", { raid = "r2", ml = "MLB", minutes = 120 }, tick())
write("Off", "Revoke", { raid = "r2" }, tick())

---------------------------------------------------------------- what it must replay to
local view = Ledger.View(store)
assert(#view.conflicts == 0)
local expect = { fingerprint = Ledger.Fingerprint(store), lists = {}, itemRules = {}, declined = #view.declined, applied = #view.applied }
for id, s in pairs(view.lists) do
    local members = {}
    for name, m in pairs(s.members) do members[name] = { active = m.active, wins = m.wins, passes = m.passes } end
    expect.lists[id] = { order = s.order, members = members, count = s.count }
end
for id, r in pairs(view.itemRules) do expect.itemRules[tostring(id)] = r.classes end

---------------------------------------------------------------- write it as Lua source
local function ser(v, indent)
    indent = indent or ""
    if type(v) == "string" then return string.format("%q", v) end
    if type(v) == "number" then return math.type(v) == "integer" and tostring(v) or string.format("%.17g", v) end
    if type(v) == "boolean" then return tostring(v) end
    local keys, isArray = {}, #v > 0
    for k in pairs(v) do keys[#keys + 1] = k; if type(k) ~= "number" then isArray = false end end
    table.sort(keys, function(a, b) if type(a) == type(b) then return a < b end return type(a) == "number" end)
    local inner, parts = indent .. "  ", {}
    for _, k in ipairs(keys) do
        local key = isArray and "" or (type(k) == "string" and k:match("^[%a_][%w_]*$") and (k .. " = ") or ("[" .. ser(k) .. "] = "))
        parts[#parts + 1] = inner .. key .. ser(v[k], inner)
    end
    if #parts == 0 then return "{}" end
    return "{\n" .. table.concat(parts, ",\n") .. ",\n" .. indent .. "}"
end

local chains = {}
for cid, chain in pairs(store.chains) do chains[cid] = { events = chain.events } end
local out = {
    "-- A real saved ledger in FORMAT 2, as released in 0.1.x, using every event type that format has. GENERATED once by",
    "-- tests/ledgers/make-format2.lua and then frozen: do not edit or regenerate. Every release must load it, verify it and",
    "-- replay it to `expect`. See tests/test_schemas.lua and the design journal (ledger migration).",
    "return " .. ser({ format = 2, ledger = { chains = chains }, expect = expect }) .. "\n",
}
local f = assert(io.open("tests/ledgers/format2.lua", "wb"))
f:write(table.concat(out, "\n"))
f:close()
print("wrote tests/ledgers/format2.lua: " .. (function() local n = 0 for _, c in pairs(chains) do n = n + #c.events end return n end)() .. " events")
