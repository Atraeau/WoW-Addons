-- Pull raid item facts (Molten Core, Ahn'Qiraj) and the AQ turn-in quests out of the CMaNGOS classic world database.
-- Source: https://github.com/cmangos/classic-db  (Full_DB/ClassicDB_1_12_1_*.sql.gz, GPL-3.0).
-- The dump itself is never committed; only the facts this script extracts are.
--
--   lua scripts/extract-cmangos.lua <ClassicDB.sql> [simulator/data/cmangos.json]
--
-- What it takes: every quest that asks for an item dropped in AQ20 or AQ40 (the token turn-ins,
-- and the Head of Ossirian), those quests' other requirements (materials, reputation, prior
-- quests), and the items involved (drops of Molten Core, AQ20 and AQ40, materials, rewards) with their
-- stats and equip spells, plus each item as ItemFit sees it (`fit`: slot, class, subclass, stats).
local dumpPath, outPath = arg[1], arg[2] or "simulator/data/cmangos.json"
assert(dumpPath, "usage: lua scripts/extract-cmangos.lua <ClassicDB.sql> [out.json]")

local function readAll(path)
    local f = assert(io.open(path, "rb")); local s = f:read("a"); f:close(); return s
end

-- Item ids dropped in either raid, from our own Wowhead-sourced drop tables.
local drops = {}
for _, raw in ipairs({ "simulator/data/mc-raw.json", "simulator/data/aq40-raw.json", "simulator/data/aq20-raw.json" }) do
    -- Only the boss tables: the turn-in lists after them hold quest ids in the same shape.
    local bosses = readAll(raw):match('"bosses":(.-)\n %]')
    for id in bosses:gmatch("%[(%d+),\"") do drops[tonumber(id)] = true end
end

-- ---- SQL reading -------------------------------------------------------------------------------

-- Column names of each table, from its CREATE TABLE block.
local columns, inCreate = {}, nil
-- Rows of one INSERT line: a list of value lists. Strings keep their text; NULL becomes nil.
local function parseValues(line, from)
    local rows, row, i, n = {}, nil, from, #line
    while i <= n do
        local c = line:sub(i, i)
        if c == "(" then row = {}; i = i + 1
        elseif c == ")" then rows[#rows + 1] = row; row = nil; i = i + 1
        elseif c == "'" then
            local buf, j = {}, i + 1
            while true do
                local k = line:find("[\\']", j)
                buf[#buf + 1] = line:sub(j, k - 1)
                if line:sub(k, k) == "\\" then buf[#buf + 1] = line:sub(k + 1, k + 1); j = k + 2
                else j = k + 1; break end
            end
            row[#row + 1] = table.concat(buf); i = j
        elseif c == "," or c == " " or c == ";" or c == "\n" or c == "\r" then i = i + 1
        else
            local tok = line:match("^[^,)]+", i)
            row[#row + 1] = (tok == "NULL") and false or tonumber(tok) or tok
            i = i + #tok
        end
    end
    return rows
end

local wanted = { quest_template = true, item_template = true, spell_template = true }
local tables = { quest_template = {}, item_template = {}, spell_template = {} }

for line in io.lines(dumpPath) do
    local created = line:match("^CREATE TABLE `([%w_]+)`")
    if created then inCreate = created; columns[created] = {}
    elseif inCreate then
        local col = line:match("^%s*`([%w_]+)`")
        if col then columns[inCreate][#columns[inCreate] + 1] = col
        elseif line:match("^%)") then inCreate = nil end
    else
        local into, rest = line:match("^INSERT INTO `([%w_]+)` VALUES()")
        if into and wanted[into] then
            local cols = columns[into]
            for _, values in ipairs(parseValues(line, rest)) do
                local r = {}
                for k, name in ipairs(cols) do r[name] = values[k] end
                tables[into][#tables[into] + 1] = r
            end
        end
    end
end

-- ---- Selection ---------------------------------------------------------------------------------

local itemsById, spellsById = {}, {}
for _, r in ipairs(tables.item_template) do itemsById[r.entry] = r end
for _, r in ipairs(tables.spell_template) do spellsById[r.Id] = r end

-- Reputation points at which each standing starts.
local STANDINGS = { { 42000, "Exalted" }, { 21000, "Revered" }, { 9000, "Honored" }, { 3000, "Friendly" }, { 0, "Neutral" } }
local function standing(points)
    for _, s in ipairs(STANDINGS) do if points >= s[1] then return s[2] end end
    return "Unfriendly"
end

-- An item as ItemFit sees it (see src/ItemFit.lua for the stat keys).
local EQUIP_LOC = { [1] = "INVTYPE_HEAD", [2] = "INVTYPE_NECK", [3] = "INVTYPE_SHOULDER", [4] = "INVTYPE_BODY",
    [5] = "INVTYPE_CHEST", [6] = "INVTYPE_WAIST", [7] = "INVTYPE_LEGS", [8] = "INVTYPE_FEET", [9] = "INVTYPE_WRIST",
    [10] = "INVTYPE_HAND", [11] = "INVTYPE_FINGER", [12] = "INVTYPE_TRINKET", [13] = "INVTYPE_WEAPON", [14] = "INVTYPE_SHIELD",
    [15] = "INVTYPE_RANGED", [16] = "INVTYPE_CLOAK", [17] = "INVTYPE_2HWEAPON", [19] = "INVTYPE_TABARD", [20] = "INVTYPE_ROBE",
    [21] = "INVTYPE_WEAPONMAINHAND", [22] = "INVTYPE_WEAPONOFFHAND", [23] = "INVTYPE_HOLDABLE", [25] = "INVTYPE_THROWN",
    [26] = "INVTYPE_RANGEDRIGHT", [28] = "INVTYPE_RELIC" }
local STAT = { [3] = "agi", [4] = "str", [5] = "int", [6] = "spi", [7] = "sta" }
local SCHOOL = { [2] = "holy", [4] = "fire", [8] = "nature", [16] = "frost", [32] = "shadow", [64] = "arcane" }
-- Aura types of on-equip spells (EffectApplyAuraName, with Effect 6 = apply aura).
local AURA = { [52] = "crit", [54] = "hit", [55] = "spellhit", [57] = "spellcrit", [71] = "spellcrit", [99] = "ap",
    [124] = "rap", [49] = "dodge", [47] = "parry", [51] = "blockPct", [158] = "block" }
local function fitOf(r)
    local stats = {}
    local function add(k, v) if v and v ~= 0 then stats[k] = (stats[k] or 0) + v end end
    for k = 1, 10 do add(STAT[r["stat_type" .. k]] or "_", r["stat_value" .. k]) end
    stats._ = nil
    add("armor", r.armor)
    if (r.block or 0) > 0 then add("block", r.block) end
    if (r.dmg_max1 or 0) > 0 and (r.delay or 0) > 0 then
        stats.dps = math.floor(((r.dmg_min1 + r.dmg_max1) / 2) / (r.delay / 1000) * 10 + 0.5) / 10
    end
    local damage, healing = 0, 0
    -- What a spell gives, times `share`: equip effects count fully; a use effect (trigger 0) or a chance on hit
    -- (trigger 2) counts for USE_SHARE, a rough uptime. A spell that triggers another (aura 42, "chance on hit:
    -- ...", or effect 64) is followed one step.
    local USE_SHARE = 0.3
    local function give(s, share, depth)
        if not s or depth > 2 then return end
        for e = 1, 3 do
            local effect, aura = s["Effect" .. e], s["EffectApplyAuraName" .. e]
            local amount, misc = ((s["EffectBasePoints" .. e] or 0) + 1) * share, s["EffectMiscValue" .. e] or 0
            if effect == 6 then
                if aura == 13 then
                    if misc >= 126 then damage = damage + amount
                    else for bit, school in pairs(SCHOOL) do if math.floor(misc / bit) % 2 == 1 then add(school, amount) end end end
                elseif aura == 135 then healing = healing + amount
                elseif aura == 85 and misc == 0 then add("mp5", amount)
                elseif aura == 30 and misc == 95 then add("defense", amount)
                elseif aura == 42 then give(spellsById[s["EffectTriggerSpell" .. e]], depth == 0 and USE_SHARE or share, depth + 1)
                elseif aura == 99 and (s.Stances or 0) ~= 0 then add("feralap", amount) -- attack power in Cat/Bear form only
                elseif AURA[aura] then add(AURA[aura], amount) end
            elseif effect == 64 then
                give(spellsById[s["EffectTriggerSpell" .. e]], share, depth + 1)
            end
        end
    end
    for k = 1, 5 do
        local trigger = r["spelltrigger_" .. k]
        local s = spellsById[r["spellid_" .. k]]
        if trigger == 1 then give(s, 1, 0)
        elseif trigger == 0 or trigger == 2 then give(s, USE_SHARE, 1) end
    end
    for k, v in pairs(stats) do if k ~= "dps" then stats[k] = math.floor(v * 10 + 0.5) / 10 end end
    -- "+damage and healing" carries both auras with the same amount: that is sp. What is left over is
    -- healing only (heal) or damage only (counted as sp too).
    local both = math.min(damage, healing)
    add("sp", math.floor((both + (damage - both)) * 10 + 0.5) / 10); add("heal", math.floor((healing - both) * 10 + 0.5) / 10)
    return { slot = EQUIP_LOC[r.InventoryType], class = r.class, subclass = r.subclass, stats = stats }
end

-- What a drop turns into, for items that are only a step on the way (tokens, quest items, crafting reagents):
-- the rewards of the quests that ask for it (following a quest chain to its first rewards), and the items made
-- from it. The fit heuristic judges such an item by what it becomes.
local questsById = {}
for _, q in ipairs(tables.quest_template) do questsById[q.entry] = q end
local nextOf = {}
for _, q in ipairs(tables.quest_template) do
    if (q.PrevQuestId or 0) > 0 then nextOf[q.PrevQuestId] = nextOf[q.PrevQuestId] or q.entry end
end
local function rewardsOf(q, depth)
    local out = {}
    for k = 1, 6 do local id = q["RewChoiceItemId" .. k]; if id and id > 0 then out[#out + 1] = id end end
    for k = 1, 4 do local id = q["RewItemId" .. k]; if id and id > 0 then out[#out + 1] = id end end
    if #out == 0 and depth < 6 then
        local nxt = (q.NextQuestInChain or 0) > 0 and q.NextQuestInChain or nextOf[q.entry]
        if nxt and questsById[nxt] then return rewardsOf(questsById[nxt], depth + 1) end
    end
    return out
end
local turnsInto = {}
local function into(drop, id)
    if id == drop then return end
    turnsInto[drop] = turnsInto[drop] or {}
    for _, x in ipairs(turnsInto[drop]) do if x == id then return end end
    table.insert(turnsInto[drop], id)
end
for _, q in ipairs(tables.quest_template) do
    for k = 1, 4 do
        local need = q["ReqItemId" .. k]
        if drops[need] then for _, id in ipairs(rewardsOf(q, 0)) do into(need, id) end end
    end
end
for _, s in ipairs(tables.spell_template) do
    if s.Effect1 == 24 and (s.EffectItemType1 or 0) > 0 then -- create item, from reagents
        for k = 1, 8 do
            if drops[s["Reagent" .. k]] then into(s["Reagent" .. k], s.EffectItemType1) end
        end
    end
end
for _, list in pairs(turnsInto) do table.sort(list) end

local quests, needItems = {}, {}
for _, q in ipairs(tables.quest_template) do
    local asks = false
    for k = 1, 4 do if drops[q["ReqItemId" .. k]] then asks = true end end
    if asks then
        local needs, rewards = {}, {}
        for k = 1, 4 do
            local id, n = q["ReqItemId" .. k], q["ReqItemCount" .. k]
            if id and id > 0 then needs[#needs + 1] = { id, n }; needItems[id] = true end
        end
        for k = 1, 6 do
            local id = q["RewChoiceItemId" .. k]
            if id and id > 0 then rewards[#rewards + 1] = id; needItems[id] = true end
        end
        for k = 1, 4 do
            local id = q["RewItemId" .. k]
            if id and id > 0 then rewards[#rewards + 1] = id; needItems[id] = true end
        end
        local rep
        if (q.RequiredMinRepFaction or 0) > 0 then
            rep = { factionId = q.RequiredMinRepFaction, standing = standing(q.RequiredMinRepValue or 0),
                points = q.RequiredMinRepValue }
        end
        quests[#quests + 1] = {
            id = q.entry, title = q.Title, classes = q.RequiredClasses, needs = needs, rewards = rewards,
            reputation = rep, money = (q.RewOrReqMoney or 0) < 0 and -q.RewOrReqMoney or nil,
            prev = (q.PrevQuestId or 0) ~= 0 and q.PrevQuestId or nil,
        }
    end
end
table.sort(quests, function(a, b) return a.id < b.id end)
for id in pairs(drops) do needItems[id] = true end
for _, list in pairs(turnsInto) do for _, id in ipairs(list) do needItems[id] = true end end

local spellNeeded, items = {}, {}
for id in pairs(needItems) do
    local r = itemsById[id]
    if r then
        local stats, spells = {}, {}
        for k = 1, 10 do
            local t, v = r["stat_type" .. k], r["stat_value" .. k]
            if t and t > 0 and v and v ~= 0 then stats[#stats + 1] = { t, v } end
        end
        for k = 1, 5 do
            local s, trig = r["spellid_" .. k], r["spelltrigger_" .. k]
            if s and s > 0 then spells[#spells + 1] = { s, trig }; spellNeeded[s] = true end
        end
        local res = {}
        for _, name in ipairs({ "holy_res", "fire_res", "nature_res", "frost_res", "shadow_res", "arcane_res" }) do
            if (r[name] or 0) ~= 0 then res[name:gsub("_res", "")] = r[name] end
        end
        items[#items + 1] = {
            id = id, name = r.name, quality = r.Quality, class = r.class, subclass = r.subclass,
            inventoryType = r.InventoryType, allowableClass = r.AllowableClass, itemLevel = r.ItemLevel,
            requiredLevel = r.RequiredLevel, armor = r.armor, block = r.block, stats = stats,
            spells = spells, resist = next(res) and res or nil,
            dmg = (r.dmg_max1 or 0) > 0 and { r.dmg_min1, r.dmg_max1, r.delay } or nil,
            startQuest = (r.startquest or 0) > 0 and r.startquest or nil,
            fit = fitOf(r),
        }
        items[#items].fit.into = turnsInto[id]
    end
end
table.sort(items, function(a, b) return a.id < b.id end)

local spells = {}
for id in pairs(spellNeeded) do
    local s = spellsById[id]
    if s then
        local effects = {}
        for k = 1, 3 do
            if (s["Effect" .. k] or 0) > 0 then
                effects[#effects + 1] = { effect = s["Effect" .. k], aura = s["EffectApplyAuraName" .. k],
                    amount = (s["EffectBasePoints" .. k] or 0) + 1, misc = s["EffectMiscValue" .. k] }
            end
        end
        spells[#spells + 1] = { id = id, name = s.SpellName, effects = effects }
    end
end
table.sort(spells, function(a, b) return a.id < b.id end)

-- ---- JSON out (keys sorted, so the file is stable between runs) ---------------------------------

local function encode(v, indent)
    local t = type(v)
    if t == "number" then return (math.type(v) == "integer" or v ~= math.floor(v)) and tostring(v) or string.format("%d", v)
    elseif t == "string" then
        return '"' .. v:gsub('[%c"\\]', function(c)
            return ({ ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t" })[c]
                or string.format("\\u%04x", c:byte())
        end) .. '"'
    elseif t == "boolean" then return tostring(v)
    elseif v == nil then return "null" end
    if #v > 0 or next(v) == nil then
        local flat = true
        for _, x in ipairs(v) do if type(x) == "table" then flat = false end end
        local parts = {}
        for _, x in ipairs(v) do parts[#parts + 1] = encode(x, indent .. " ") end
        if flat then return "[" .. table.concat(parts, ",") .. "]" end
        return "[\n" .. indent .. " " .. table.concat(parts, ",\n" .. indent .. " ") .. "\n" .. indent .. "]"
    end
    local keys = {}
    for k in pairs(v) do keys[#keys + 1] = k end
    table.sort(keys)
    local parts = {}
    for _, k in ipairs(keys) do parts[#parts + 1] = encode(k, indent) .. ":" .. encode(v[k], indent .. " ") end
    return "{" .. table.concat(parts, ",") .. "}"
end

local out = assert(io.open(outPath, "wb"))
out:write(encode({
    source = "CMaNGOS classic-db (github.com/cmangos/classic-db, " .. dumpPath:match("[^/\\]+$")
        .. ", GPL-3.0): emulator world database for 1.12. Quests that ask for an item dropped in AQ20 or AQ40, "
        .. "and the items involved (with every Molten Core, AQ20 and AQ40 drop). stats are {stat type, value}; spells are "
        .. "{spell id, trigger} (1 = on equip); fit is the item as ItemFit sees it (slot, class, subclass, stats).",
    quests = quests, items = items, spells = spells,
}, ""))
out:write("\n")
out:close()
print(("%d quests, %d items, %d spells -> %s"):format(#quests, #items, #spells, outPath))
