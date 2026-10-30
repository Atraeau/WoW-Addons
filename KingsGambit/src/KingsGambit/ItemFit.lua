-- King's Gambit: item fit. Which classes may take an item, and which specs it suits, worked out from the item
-- itself when it drops (design journal: "no dependence on per-raid data"; "item fit").
--
-- Two different things:
--   * RESTRICTION (a rule): an item that names its classes ("Classes: Priest, Mage" on the tooltip, or a token's
--     class group) may only be bid on by those classes, in the main and off-spec drafts. The backstop's salvager,
--     and the Master Looter or disenchanter who gets what nobody took, are not restricted. See Allowed.
--   * FIT (a suggestion, never a rule): how well the item's stats match each spec, from the baked-in priorities
--     below plus armor and weapon proficiency. It feeds hints (off by default), the "suits" line, and bots.
--
-- An item, as this module sees it (Describe builds it from the game):
--   { link, slot = equipLoc, class = item class id, subclass = id, stats = { [key] = value }, classes = { "PRIEST", ... } | nil }
-- Stat keys: str agi sta int spi armor defense dodge parry blockPct block hit crit ap rap dps
--            sp (damage and healing) heal (healing only) spellhit spellcrit mp5, and school damage:
--            fire frost shadow arcane nature holy. Percent stats are in percent (hit = 1 means +1%).
-- Keep this file Lua 5.1-safe (no bitwise operators).
local _, SK = ...
local M = SK:NewModule("ItemFit")

M.CLASSES = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
M.CLASS_BITS = { WARRIOR = 1, PALADIN = 2, HUNTER = 4, ROGUE = 8, PRIEST = 16, SHAMAN = 64, MAGE = 128, WARLOCK = 256, DRUID = 1024 }

-- Default stat priorities per spec: rough values of one point of each stat (one percent for percent stats),
-- as commonly valued by raiders. Suggestions, not truth: officers can override an item's fit (later), and
-- players decide for themselves. role: tank, melee, hunter, caster, healer.
local function w(t) return t end
local MELEE = w { str = 1, agi = 0.6, ap = 0.5, crit = 14, hit = 12, sta = 0.2, dps = 2.5 }
M.SPECS = {
    WARRIOR = {
        { name = "Arms", role = "melee", weights = MELEE },
        { name = "Fury", role = "melee", weights = w { str = 1, agi = 0.6, ap = 0.5, crit = 14, hit = 15, sta = 0.2, dps = 2.5 } },
        { name = "Protection", role = "tank", weights = w { sta = 1, defense = 1.3, dodge = 13, parry = 13, blockPct = 9, block = 0.4,
            armor = 0.01, str = 0.3, agi = 0.5, hit = 6, dps = 0.5 } },
    },
    PALADIN = {
        { name = "Holy", role = "healer", weights = w { heal = 1, sp = 1, int = 0.9, mp5 = 2.2, spellcrit = 9, spi = 0.2, sta = 0.1 } },
        { name = "Protection", role = "tank", weights = w { sta = 1, defense = 1.2, sp = 0.5, int = 0.3, blockPct = 8, block = 0.5,
            dodge = 10, parry = 10, armor = 0.01, str = 0.3 } },
        { name = "Retribution", role = "melee", weights = w { str = 1, crit = 14, hit = 12, ap = 0.5, agi = 0.5, int = 0.2, sp = 0.3,
            holy = 0.3, dps = 2.5 } },
    },
    HUNTER = {
        { name = "Beast Mastery", role = "hunter", weights = w { agi = 1, rap = 0.5, ap = 0.5, hit = 14, crit = 14, int = 0.3, sta = 0.2, dps = 1.5 } },
        { name = "Marksmanship", role = "hunter", weights = w { agi = 1, rap = 0.5, ap = 0.5, hit = 14, crit = 15, int = 0.3, sta = 0.2, dps = 1.5 } },
        { name = "Survival", role = "hunter", weights = w { agi = 1.2, rap = 0.5, ap = 0.5, hit = 14, crit = 14, int = 0.3, sta = 0.3, dps = 1.5 } },
    },
    ROGUE = {
        { name = "Assassination", role = "melee", weights = w { agi = 1, str = 0.5, ap = 0.5, hit = 15, crit = 15, sta = 0.2, dps = 2.5 } },
        { name = "Combat", role = "melee", weights = w { agi = 1, str = 0.5, ap = 0.5, hit = 15, crit = 14, sta = 0.2, dps = 2.5 } },
        { name = "Subtlety", role = "melee", weights = w { agi = 1, str = 0.5, ap = 0.5, hit = 14, crit = 14, sta = 0.2, dps = 2.5 } },
    },
    PRIEST = {
        { name = "Discipline", role = "healer", weights = w { heal = 1, sp = 1, int = 0.7, spi = 0.5, mp5 = 2.5, spellcrit = 6, sta = 0.1 } },
        { name = "Holy", role = "healer", weights = w { heal = 1, sp = 1, int = 0.6, spi = 0.6, mp5 = 2.5, spellcrit = 6, sta = 0.1 } },
        { name = "Shadow", role = "caster", weights = w { sp = 1, shadow = 1, spellhit = 12, spellcrit = 5, sta = 0.3, int = 0.3, spi = 0.2 } },
    },
    SHAMAN = {
        { name = "Elemental", role = "caster", weights = w { sp = 1, nature = 1, fire = 0.4, spellhit = 12, spellcrit = 10, int = 0.4, mp5 = 1 } },
        { name = "Enhancement", role = "melee", weights = w { str = 1, agi = 0.7, ap = 0.5, crit = 14, hit = 12, int = 0.2, dps = 2.5 } },
        { name = "Restoration", role = "healer", weights = w { heal = 1, sp = 1, mp5 = 2.5, int = 0.8, spellcrit = 8, sta = 0.1 } },
    },
    MAGE = {
        { name = "Arcane", role = "caster", weights = w { sp = 1, arcane = 1, frost = 0.5, spellhit = 12, spellcrit = 10, int = 0.5, sta = 0.2 } },
        { name = "Fire", role = "caster", weights = w { sp = 1, fire = 1, spellhit = 12, spellcrit = 11, int = 0.4, sta = 0.2 } },
        { name = "Frost", role = "caster", weights = w { sp = 1, frost = 1, spellhit = 12, spellcrit = 9, int = 0.4, sta = 0.2 } },
    },
    WARLOCK = {
        { name = "Affliction", role = "caster", weights = w { sp = 1, shadow = 1, spellhit = 12, spellcrit = 4, sta = 0.4, int = 0.3 } },
        { name = "Demonology", role = "caster", weights = w { sp = 1, shadow = 1, fire = 0.3, spellhit = 12, spellcrit = 6, sta = 0.5, int = 0.3 } },
        { name = "Destruction", role = "caster", weights = w { sp = 1, shadow = 1, fire = 0.6, spellhit = 12, spellcrit = 10, sta = 0.4, int = 0.3 } },
    },
    DRUID = {
        { name = "Balance", role = "caster", weights = w { sp = 1, arcane = 0.9, nature = 0.9, spellhit = 12, spellcrit = 10, int = 0.4 } },
        { name = "Feral (bear)", role = "tank", weights = w { sta = 1, armor = 0.05, agi = 0.8, defense = 1, dodge = 12, str = 0.4, hit = 6 } },
        { name = "Feral (cat)", role = "melee", weights = w { agi = 1, str = 1, ap = 0.5, crit = 14, hit = 12 } },
        { name = "Restoration", role = "healer", weights = w { heal = 1, sp = 1, int = 0.7, spi = 0.6, mp5 = 2.5, sta = 0.1 } },
    },
}

---------------------------------------------------------------- proficiency (what a class can equip at 60)
local ARMOR, WEAPON, MISC = 4, 2, 0
-- Armor subclasses: 1 cloth, 2 leather, 3 mail, 4 plate, 6 shield, 7 libram, 8 idol, 9 totem.
local ARMOR_RANK = { [1] = 1, [2] = 2, [3] = 3, [4] = 4 }
M.ARMOR_NAMES = { [1] = "cloth", [2] = "leather", [3] = "mail", [4] = "plate", [6] = "shield", [7] = "libram", [8] = "idol", [9] = "totem" }
local BEST_ARMOR = { WARRIOR = 4, PALADIN = 4, HUNTER = 3, SHAMAN = 3, ROGUE = 2, DRUID = 2, PRIEST = 1, MAGE = 1, WARLOCK = 1 }
local SPECIAL_ARMOR = { [6] = { WARRIOR = true, PALADIN = true, SHAMAN = true }, [7] = { PALADIN = true }, [8] = { DRUID = true },
    [9] = { SHAMAN = true } }
-- Weapon subclasses: 0 axe, 1 2h axe, 2 bow, 3 gun, 4 mace, 5 2h mace, 6 polearm, 7 sword, 8 2h sword, 10 staff,
-- 13 fist, 15 dagger, 16 thrown, 18 crossbow, 19 wand.
local function set(list) local s = {} for _, v in ipairs(list) do s[v] = true end return s end
local WEAPONS = {
    WARRIOR = set { 0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 15, 16, 18 },
    PALADIN = set { 0, 1, 4, 5, 6, 7, 8 },
    HUNTER = set { 0, 1, 2, 3, 6, 7, 8, 10, 13, 15, 16, 18 },
    ROGUE = set { 2, 3, 4, 7, 13, 15, 16, 18 },
    PRIEST = set { 4, 10, 15, 19 },
    SHAMAN = set { 0, 1, 4, 5, 10, 13, 15 },
    MAGE = set { 7, 10, 15, 19 },
    WARLOCK = set { 7, 10, 15, 19 },
    DRUID = set { 4, 5, 10, 13, 15 },
}
M.WEAPON_NAMES = { [0] = "axe", [1] = "two-handed axe", [2] = "bow", [3] = "gun", [4] = "mace", [5] = "two-handed mace",
    [6] = "polearm", [7] = "sword", [8] = "two-handed sword", [10] = "staff", [13] = "fist weapon", [15] = "dagger",
    [16] = "thrown weapon", [18] = "crossbow", [19] = "wand" }
-- Slots that are the same for everyone whatever their armor subclass says (cloaks are "cloth").
local ANY_ARMOR_SLOT = { INVTYPE_CLOAK = true, INVTYPE_NECK = true, INVTYPE_FINGER = true, INVTYPE_TRINKET = true,
    INVTYPE_HOLDABLE = true, INVTYPE_TABARD = true, INVTYPE_BODY = true }

---------------------------------------------------------------- building an item
-- The classes a class bitmask names (tokens use the game's masks; 0 or nil = every class).
function M.ClassesFromMask(mask)
    if not mask or mask == 0 then return nil end
    local out = {}
    for _, c in ipairs(M.CLASSES) do
        if math.floor(mask / M.CLASS_BITS[c]) % 2 == 1 then out[#out + 1] = c end
    end
    return out
end

-- The item as this module sees it, from the game (client:itemInfo and client:itemStats), or nil while the
-- game hasn't cached it yet (and no rule names its classes). token (optional): Tokens data, whose class group
-- restricts it. rule (optional): the guild's rule for the item (Engine:ItemRule), which decides who may bid,
-- over what the item itself says.
function M.Describe(client, link, token, rule)
    local info = client:itemInfo(link)
    local st = client:itemStats(link)
    if not info and not token and not rule then return nil end
    info = info or {}
    local item = { link = link, slot = info.equipLoc, class = info.class, subclass = info.subclass,
        stats = (st and st.stats) or {}, classes = st and st.classes, partial = not info.equipLoc and not token }
    if token then item.classes = M.ClassesFromMask(token.classes); item.token = true end
    if rule then item.classes, item.rule = rule.classes, rule end
    return item
end

-- The item id in a link ("|Hitem:19019:...") or a plain id, or nil.
function M.ItemId(link)
    if type(link) == "number" then return link end
    return type(link) == "string" and tonumber(link:match("item:(%d+)") or link:match("^%s*(%d+)%s*$")) or nil
end

---------------------------------------------------------------- the rule
-- May a player of `class` bid on `item` in the main or off-spec draft? Only an item that names its classes
-- restricts anyone; an unknown class (no roster data) is let through.
function M.Allowed(item, class)
    if not (item and item.classes) or not class then return true end
    for _, c in ipairs(item.classes) do if c == class then return true end end
    return false
end

---------------------------------------------------------------- fit (suggestions)
-- Can a player of `class` equip it at all? Returns true, or false + why ("classes", "armor", "weapon").
function M.CanUse(item, class)
    if not M.Allowed(item, class) then return false, "classes" end
    if item.class == ARMOR and not ANY_ARMOR_SLOT[item.slot] then
        local special = SPECIAL_ARMOR[item.subclass]
        if special then return special[class] == true or false, "armor" end
        local rank = ARMOR_RANK[item.subclass]
        if rank and rank > BEST_ARMOR[class] then return false, "armor" end
    elseif item.class == WEAPON and item.subclass ~= nil and WEAPONS[class] then
        if item.subclass ~= 20 and not WEAPONS[class][item.subclass] then return false, "weapon" end -- 20: fishing pole
    end
    return true
end

local function specOf(class, name)
    for _, s in ipairs(M.SPECS[class] or {}) do if s.name == name then return s end end
end
M.SpecOf = specOf

-- How much the item's stats are worth to a spec (0 if it has none the spec values). For tanks and physical
-- damage, armor of a lighter kind than the class wears in raids counts for less (a warrior can wear leather,
-- but rarely wants to); casters and healers of hybrid classes wear lighter armor all the time.
local ARMOR_MATTERS = { tank = true, melee = true, hunter = true }
function M.Score(item, spec, class)
    local total = 0
    for k, v in pairs(item.stats or {}) do total = total + v * (spec.weights[k] or 0) end
    if class and ARMOR_MATTERS[spec.role] and item.class == ARMOR and not ANY_ARMOR_SLOT[item.slot] then
        local rank = ARMOR_RANK[item.subclass]
        if rank and rank < BEST_ARMOR[class] then total = total * 0.6 end
    end
    return total
end

-- Every spec that can use the item, best first: { { class, spec, role, score } }.
function M.Ranked(item)
    local out = {}
    for _, class in ipairs(M.CLASSES) do
        if M.CanUse(item, class) then
            for _, s in ipairs(M.SPECS[class]) do
                out[#out + 1] = { class = class, spec = s.name, role = s.role, score = M.Score(item, s, class) }
            end
        end
    end
    table.sort(out, function(a, b)
        if a.score ~= b.score then return a.score > b.score end
        if a.class ~= b.class then return a.class < b.class end
        return a.spec < b.spec
    end)
    return out
end

M.GOOD, M.OK = 0.7, 0.35 -- share of the best spec's score

-- The specs the item suits best (score at least GOOD of the best), or {} if its stats say nothing (e.g. a
-- trinket with only a use effect: then nobody is suggested, and the raid judges for itself).
function M.Suits(item)
    local ranked = M.Ranked(item)
    local best = ranked[1] and ranked[1].score or 0
    local out = {}
    if best <= 0 then return out end
    for _, r in ipairs(ranked) do
        if r.score >= best * M.GOOD then out[#out + 1] = r end
    end
    return out
end

-- The fit for one player: { usable, why?, spec, score, rating = "good" | "ok" | "poor" | nil }. specName
-- (optional) is the player's spec; without it, the class's best spec for this item is used.
function M.ForPlayer(item, class, specName)
    local ok, why = M.CanUse(item, class)
    if not ok then return { usable = false, why = why } end
    local ranked = M.Ranked(item)
    local best = ranked[1] and ranked[1].score or 0
    local mine
    for _, r in ipairs(ranked) do
        if r.class == class and (r.spec == specName or not specName) and (not mine or r.score > mine.score) then mine = r end
    end
    if not mine then return { usable = true } end
    local rating
    if best > 0 then
        local share = mine.score / best
        rating = share >= M.GOOD and "good" or share >= M.OK and "ok" or "poor"
    end
    return { usable = true, spec = mine.spec, role = mine.role, score = mine.score, rating = rating }
end

-- Display helpers.
local CLASS_NAMES = { WARRIOR = "Warrior", PALADIN = "Paladin", HUNTER = "Hunter", ROGUE = "Rogue", PRIEST = "Priest",
    SHAMAN = "Shaman", MAGE = "Mage", WARLOCK = "Warlock", DRUID = "Druid" }
M.CLASS_NAMES = CLASS_NAMES

function M.ClassList(item)
    if not (item and item.classes) then return nil end
    local names = {}
    for i, c in ipairs(item.classes) do names[i] = CLASS_NAMES[c] or c end
    return table.concat(names, ", ")
end

-- "Holy Paladin, Restoration Shaman, ..." (at most `limit`, default 4).
function M.SuitsText(item, limit)
    local suits = M.Suits(item)
    if #suits == 0 then return nil end
    local parts = {}
    for i = 1, math.min(#suits, limit or 4) do parts[i] = suits[i].spec .. " " .. CLASS_NAMES[suits[i].class] end
    if #suits > (limit or 4) then parts[#parts + 1] = ("and %d more"):format(#suits - (limit or 4)) end
    return table.concat(parts, ", ")
end
