-- King's Gambit: who a character IS. Pure Lua. Keep this file Lua 5.1-safe.
--
-- A character is identified by FIRST and LAST name. There are no realms in WoW: Forever, so the pair is the identity (the guild leader: the union
-- of the two is unique), and it takes the place `Name-Realm` had. Everything in the ledger and the addon holds this one canonical string, never
-- the game's own text, so the rest of the code never has to know how the game spells a name:
--
--   canonical   "First_Last"   the two names joined by "_". No spaces (commands split on spaces), no hyphen (it used to mean a realm).
--   display     "First Last"   what a person reads and types.
--
-- The game's own full-name string has a SURNAME SEPARATOR between the two names, and the exported API describes it only as "the character surname
-- separator" (C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator). We do not hard-code what it is. The client learns it from the game itself by
-- comparing a name with that function's result (LearnSeparator), and Normalize splits on it, on whitespace, on "-" and on "_".
--
-- ASSUMPTIONS TO CONFIRM IN THE LIVE GAME (they are all in the real client, RealClient.lua, and the in-game `/gambit check` prints the raw values):
--   * which API returns the full name with the surname intact (UnitNameUnmodified is preferred: ShouldDisplaySurname() suggests UnitName can leave the
--     surname out depending on a player's settings, which would make one character look like two);
--   * that the second return value ("server") is empty, since there are no realms.
-- Names are never parsed anywhere else in the addon.
local _, SK = ...
local M = SK:NewModule("Identity")

M.SEP = "_"

-- Split a raw name into its parts: on whitespace, "-", "_" and any extra separator strings the game uses (see LearnSeparator).
local function parts(raw, extra)
    if type(raw) ~= "string" then return {} end
    for _, sep in ipairs(extra or {}) do
        if sep ~= "" then
            local from = 1
            while true do
                local a, b = raw:find(sep, from, true)
                if not a then break end
                raw = raw:sub(1, a - 1) .. " " .. raw:sub(b + 1)
                from = a + 1
            end
        end
    end
    local out = {}
    for token in raw:gmatch("[^%s%-_]+") do out[#out + 1] = token end
    return out
end

-- The canonical identity for a name as the game, a person or an old record spells it, or nil if there is nothing in it.
-- extra (optional): a list of separator strings learned from the game.
function M.Normalize(raw, extra)
    local p = parts(raw, extra)
    if #p == 0 then return nil end
    return table.concat(p, M.SEP)
end

-- "First Last": what a person reads. Single names (development and tests) are shown as they are.
function M.Display(id)
    if type(id) ~= "string" then return id end
    return (id:gsub(M.SEP, " "))
end

-- The first name, and the last name (nil when there is only one name).
function M.First(id) return type(id) == "string" and id:match("^([^" .. M.SEP .. "]+)") or nil end
function M.Last(id) return type(id) == "string" and id:match("^[^" .. M.SEP .. "]+" .. M.SEP .. "(.+)$") or nil end

-- A key for comparing or looking up names without regard to capitals (a person typing "aldric stormwind").
function M.Key(id) return type(id) == "string" and id:lower() or nil end

function M.Equal(a, b) return a ~= nil and b ~= nil and M.Key(a) == M.Key(b) end

-- Is it a canonical identity (no spaces, hyphens or empty parts)?
function M.Valid(id)
    return type(id) == "string" and id ~= "" and not id:find("[%s%-]") and not id:find("^" .. M.SEP) and not id:find(M.SEP .. "$")
        and not id:find(M.SEP .. M.SEP, 1, true)
end

-- Learn the game's surname separator. `full` is a full name as the game spells it, `linked` is what
-- C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator(full) returns: they differ exactly at the separator. Returns the separator in `full`
-- and the one it was replaced with, or nil if the name has no surname separator.
function M.LearnSeparator(full, linked)
    if type(full) ~= "string" or type(linked) ~= "string" or full == linked then return nil end
    local p = 0
    while p < #full and p < #linked and full:byte(p + 1) == linked:byte(p + 1) do p = p + 1 end
    local q = 0
    while q < #full - p and q < #linked - p and full:byte(#full - q) == linked:byte(#linked - q) do q = q + 1 end
    local sep, link = full:sub(p + 1, #full - q), linked:sub(p + 1, #linked - q)
    if sep == "" then return nil end
    return sep, link
end

-- Find the command-line words that name `known` characters and join each pair into one word, so `gift Aldric Stormwind Brann Ironforge` works without
-- quotes. `line` is the raw text, `known` a set of canonical identities. Quoted names ("Aldric Stormwind") are joined first. Only the first
-- few words are looked at (names come first in a command; a free-text reason after them is left alone).
function M.JoinNames(line, known)
    line = line:gsub('"([^"]+)"', function(q) return (M.Normalize(q) or q) end)
    local keys = {}
    for id in pairs(known or {}) do keys[M.Key(id)] = true end
    local words, out, i = {}, {}, 1
    for w in line:gmatch("%S+") do words[#words + 1] = w end
    while i <= #words do
        local joined = i <= 5 and words[i + 1] and M.Normalize(words[i] .. " " .. words[i + 1])
        if joined and keys[M.Key(joined)] then
            out[#out + 1] = joined; i = i + 2
        else
            out[#out + 1] = words[i]; i = i + 1
        end
    end
    return table.concat(out, " ")
end
