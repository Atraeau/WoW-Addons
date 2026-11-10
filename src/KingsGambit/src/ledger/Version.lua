-- King's Gambit: the addon's version, read the way Semantic Versioning (https://semver.org) says to, and who may work with whom.
-- Pure Lua. Keep this file Lua 5.1-safe.
--
-- A version is MAJOR.MINOR.PATCH, optionally with a pre-release ("-beta.1") and build metadata ("+84", which the release build
-- stamps and which never affects precedence or compatibility).
--
-- Compatibility. Two clients work together exactly when they are on the same LINE: the same MAJOR, or, while MAJOR is 0
-- (initial development: anything may change, SemVer item 4), the same MAJOR.MINOR. Within a line they may differ freely: a
-- newer MINOR or PATCH has features and fixes the older lacks, and the older keeps working and sharing the ledger. They do NOT
-- have to be on the same version.
--
-- What must bump the line (MAJOR, or MINOR while 0.x): any change an older client on the same line could not live with. For a
-- shared ledger that means entries or rules: a new or changed event type or field meaning, a change to the ledger format, to
-- how standings follow from entries, or to the addon messages. (An older client rejects an event type it does not know, so
-- its standings would silently differ: that is why adding one is not a compatible change here.) tests/test_compat.lua fails
-- when that surface changes without a decision. A compatible change (a fix, UI, a new command, an optional message field that
-- older clients ignore) bumps MINOR or PATCH only.
--
-- A client that cannot tell (a development copy says "dev"; an unreadable version) is let through: the ledger's own checks
-- still refuse what it cannot read.
local _, SK = ...
local M = SK:NewModule("Version")

local function split(s, sep)
    local out = {}
    for part in (s .. sep):gmatch("(.-)" .. sep:gsub("%p", "%%%0")) do out[#out + 1] = part end
    return out
end

local function plainNumber(s) return s:match("^%d+$") and (s == "0" or s:sub(1, 1) ~= "0") end

-- "1.2.3-beta.1+84" -> { major = 1, minor = 2, patch = 3, pre = { "beta", 1 } | nil, build = "84" | nil }; nil if it is not
-- Semantic Versioning (leading zeros, empty parts and a four-part number are not).
function M.Parse(s)
    if type(s) ~= "string" then return nil end
    local a, b, c, rest = s:match("^(%d+)%.(%d+)%.(%d+)(.*)$")
    if not (a and plainNumber(a) and plainNumber(b) and plainNumber(c)) then return nil end
    local v = { major = tonumber(a), minor = tonumber(b), patch = tonumber(c) }
    local pre, after = rest:match("^%-([%w%.%-]+)(.*)$")
    if pre then
        v.pre = {}
        for _, id in ipairs(split(pre, ".")) do
            if id == "" or id:find("[^%w%-]") then return nil end
            if id:match("^%d+$") then
                if not plainNumber(id) then return nil end
                v.pre[#v.pre + 1] = tonumber(id)
            else
                v.pre[#v.pre + 1] = id
            end
        end
        rest = after
    end
    if rest ~= "" then
        local build = rest:match("^%+([%w%.%-]+)$")
        if not build then return nil end
        for _, id in ipairs(split(build, ".")) do if id == "" then return nil end end
        v.build = build
    end
    return v
end

local function parsed(v) return type(v) == "table" and v or M.Parse(v) end

local function cmp(x, y) return x < y and -1 or x > y and 1 or 0 end

-- Precedence (SemVer item 11): -1 if a is lower than b, 0 if equal, 1 if higher; nil if either is not a version. Build metadata
-- is ignored; a version with a pre-release is lower than the same version without.
function M.Compare(a, b)
    a, b = parsed(a), parsed(b)
    if not (a and b) then return nil end
    for _, k in ipairs { "major", "minor", "patch" } do
        if a[k] ~= b[k] then return cmp(a[k], b[k]) end
    end
    if not a.pre and not b.pre then return 0 end
    if not a.pre then return 1 end
    if not b.pre then return -1 end
    for i = 1, math.max(#a.pre, #b.pre) do
        local x, y = a.pre[i], b.pre[i]
        if x == nil then return -1 end -- a shorter set of identifiers is lower
        if y == nil then return 1 end
        if x ~= y then
            local nx, ny = type(x) == "number", type(y) == "number"
            if nx and ny then return cmp(x, y) end
            if nx then return -1 end -- numbers are lower than words
            if ny then return 1 end
            return cmp(x, y)
        end
    end
    return 0
end

-- The line a version is on, as text: "1" for 1.x.y, "0.3" for 0.3.x. nil if not a version.
function M.Line(v)
    v = parsed(v)
    if not v then return nil end
    return v.major > 0 and tostring(v.major) or ("0." .. v.minor)
end

-- Is line a before line b? (Lines are compared the way their versions would be.)
local function lineBefore(a, b)
    if a.major ~= b.major then return a.major < b.major end
    return a.major == 0 and a.minor < b.minor
end

-- How `theirs` stands to `mine`:
--   { known = false, compatible = true }                      one of them can't be read: let through
--   { known = true, compatible = true, order = -1 | 0 | 1 }   same line; order is theirs against mine (1 = theirs is newer)
--   { known = true, compatible = false, mustUpdate = "them" | "us", line = their line, ourLine = ... }
--                                                            different lines; the one on the older line must update
function M.Relation(mine, theirs)
    local a, b = parsed(mine), parsed(theirs)
    if not (a and b) then return { known = false, compatible = true } end
    local ours, their = M.Line(a), M.Line(b)
    if ours == their then return { known = true, compatible = true, order = M.Compare(b, a), line = their, ourLine = ours } end
    return { known = true, compatible = false, mustUpdate = lineBefore(b, a) and "them" or "us", line = their, ourLine = ours }
end
