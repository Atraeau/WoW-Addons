-- King's Gambit: RealClient (the Client for the actual game), the loot window, loot method and candidates, item information, and the loot events. Keep this file Lua 5.1-safe.
-- RealClient.New builds the shared pieces (see client/RealClient.lua) and calls Install here, which adds these to the client `c`.
local _, SK = ...
local Identity
local M = SK:NewModule("RealLoot", { "Identity" }, function(d) Identity = d.Identity end)

-- c: the client being built; h: the helpers RealClient.New shares (and what the earlier files exported).
function M.Install(c, h)
    local E, bus, safe, seps, normalize, fromGame, toGame, unitName, complete, handlers, enumName = h.E, h.bus, h.safe, h.seps, h.normalize, h.fromGame, h.toGame, h.unitName, h.complete, h.handlers, h.enumName

    ---------------------------------------------------------------- loot
    -- (the game spells its enum "Masterlooter", which the addon calls "master"; seen in the game's own /gambit check)
    local LOOT_NAMES = { masterlooter = "master" }
    -- Returns "master", "group", "freeforall", "needbeforegreed", "personal", ...
    function c:lootMethod()
        if E.C_PartyInfo and E.C_PartyInfo.GetLootMethod then
            local method = E.C_PartyInfo.GetLootMethod()
            local name = enumName(E.Enum and E.Enum.LootMethod, method)
            if name then return LOOT_NAMES[name:lower()] or name:lower() end
            if type(method) == "string" then return LOOT_NAMES[method:lower()] or method:lower() end
        elseif E.GetLootMethod then
            local method = E.GetLootMethod()
            if type(method) == "string" then return LOOT_NAMES[method:lower()] or method:lower() end
        end
        return "group"
    end

    -- Change the loot method (only the leader can: the game refuses anyone else). For "master", `looter` names the Master
    -- Looter (default: this player). Returns true, or false + a reason: notleader, badmethod, unavailable, failed.
    -- FIELD: confirm the lootMaster argument takes the game's own spelling of the name (we send back exactly what the game gave us).
    function c:setLootMethod(method, looter)
        if self:leader() ~= self:me() then return false, "notleader" end
        local enumValue
        if E.Enum and E.Enum.LootMethod then
            for k, v in pairs(E.Enum.LootMethod) do
                if k:lower() == method or LOOT_NAMES[k:lower()] == method then enumValue = v end
            end
        end
        if enumValue == nil then return false, "badmethod" end
        local api = E.C_PartyInfo
        if not (api and api.SetLootMethod) then return false, "unavailable" end
        if api.IsLootMethodAvailable and not api.IsLootMethodAvailable(enumValue) then return false, "unavailable" end
        local ok
        if method == "master" then
            ok = api.SetLootMethod(enumValue, toGame(normalize(looter) or self:me()))
        else
            ok = api.SetLootMethod(enumValue)
        end
        if not ok then return false, "failed" end
        return true
    end

    -- FIELD: confirm IsMasterLooter() semantics; fall back to C_PartyInfo ids.
    function c:isMasterLooter()
        if self:lootMethod() ~= "master" then return false end
        if E.IsMasterLooter then return E.IsMasterLooter() and true or false end
        local _, partyId, raidId = E.C_PartyInfo.GetLootMethod()
        if E.IsInRaid() then return raidId ~= nil and E.UnitIsUnit("raid" .. raidId, "player") end
        return partyId == 0
    end

    -- The Master Looter's name: C_PartyInfo.GetLootMethod gives a raid index or a party slot.
    -- FIELD: confirm the id semantics (0 = the player in party; raid index into the roster).
    function c:masterLooter()
        if self:lootMethod() ~= "master" then return nil end
        if not (E.C_PartyInfo and E.C_PartyInfo.GetLootMethod) then return nil end
        local _, partyId, raidId = E.C_PartyInfo.GetLootMethod()
        if E.IsInRaid() and raidId then
            local name = E.GetRaidRosterInfo(raidId)
            return fromGame(complete(name, "raid" .. raidId))
        elseif partyId == 0 then
            return self:me()
        elseif partyId then
            return fromGame(unitName("party" .. partyId))
        end
    end

    -- What the game says about the loot method and the Master Looter, raw and as the addon reads it, with a verdict on whether they agree. Read-only.
    -- `/gambit check` prints it: set Master Looter in the party, run it, and the lines show whether the addon finds the looter on its own.
    function c:lootProbe()
        local out = {}
        local function raw(fn, ...)
            if not fn then return "(not available)" end
            local r = { pcall(fn, ...) }
            if not r[1] then return "error: " .. tostring(r[2]) end
            local parts = {}
            for i = 2, #r do parts[#parts + 1] = tostring(safe(r[i])) end
            return #parts > 0 and table.concat(parts, ", ") or "(nothing)"
        end
        local api = E.C_PartyInfo or {}
        out[#out + 1] = "C_PartyInfo.GetLootMethod = " .. raw(api.GetLootMethod) .. "  (method, party id, raid id)"
        out[#out + 1] = "GetLootMethod (older call) = " .. raw(E.GetLootMethod) .. "  (method, party id, raid id)"
        out[#out + 1] = "IsMasterLooter = " .. raw(E.IsMasterLooter)
        out[#out + 1] = "IsInRaid / IsInGroup = " .. raw(E.IsInRaid) .. " / " .. raw(E.IsInGroup)
        local method, ml, mine = self:lootMethod(), self:masterLooter(), self:isMasterLooter()
        out[#out + 1] = ("the addon reads: method = %s, Master Looter = %s, am I the Master Looter = %s"):format(tostring(method), tostring(ml), tostring(mine))
        if method ~= "master" then
            out[#out + 1] = "verdict: the loot method is not Master Looter (set it in the party, then run this again)"
        elseif not ml then
            out[#out + 1] = "verdict: FAIL, Master Looter is set but the addon could not find who it is"
        elseif (ml == self:me()) ~= mine then
            out[#out + 1] = ("verdict: FAIL, the two ways of asking disagree (name says %s, IsMasterLooter says %s)"):format(tostring(ml == self:me()), tostring(mine))
        else
            out[#out + 1] = "verdict: ok, " .. (mine and "you are the Master Looter" or (tostring(ml) .. " is the Master Looter"))
        end
        return out
    end

    local lootOpen = false

    local function readSlots()
        local out = {}
        local isItem = E.LOOT_SLOT_ITEM or 1
        for slot = 1, (E.GetNumLootItems() or 0) do
            if not E.GetLootSlotType or E.GetLootSlotType(slot) == isItem then
                local link = safe(E.GetLootSlotLink(slot))
                if link then
                    local _, _, quantity, _, quality = E.GetLootSlotInfo(slot)
                    out[#out + 1] = { slot = slot, link = link, quality = quality or 1, quantity = quantity or 1,
                        itemId = tonumber(link:match("item:(%d+)")) }
                end
            end
        end
        return out
    end

    function c:lootSlots() return lootOpen and readSlots() or {} end

    -- Candidate index -> name; GiveMasterLoot takes the index.
    local function candidateList(slot)
        local out = {}
        for i = 1, 40 do
            local name = E.GetMasterLootCandidate(slot, i)
            if name then
                -- (a candidate comes with no surname when the game leaves it out: the group member with that first name, if only one, is who it is)
                local id = Identity.Normalize(safe(name) or "", seps)
                if id and not id:find(Identity.SEP, 1, true) then
                    local found, count
                    count = 0
                    for _, m in ipairs(c:roster()) do
                        if Identity.First(m.name) and Identity.First(m.name):lower() == id:lower() then found, count = m.name, count + 1 end
                    end
                    if count == 1 then name = toGame(found) end
                end
                out[#out + 1] = { index = i, name = fromGame(name) }
            end
        end
        return out
    end

    function c:candidates(slot)
        if not lootOpen or not safe(E.GetLootSlotLink(slot)) then return nil, "gone" end
        local out = {}
        for _, cand in ipairs(candidateList(slot)) do
            if cand.name then out[#out + 1] = cand.name end
        end
        return out
    end

    function c:give(slot, name)
        if not self:isMasterLooter() then return false, "notml" end
        if not lootOpen or not safe(E.GetLootSlotLink(slot)) then return false, "gone" end
        name = normalize(name)
        for _, cand in ipairs(candidateList(slot)) do
            if cand.name == name then
                E.GiveMasterLoot(slot, cand.index)
                return true
            end
        end
        return false, "notcandidate"
    end

    function c:itemInfo(link)
        link = safe(link)
        if not link then return nil end
        local fn = (E.C_Item and E.C_Item.GetItemInfo) or E.GetItemInfo
        local name, itemLink, quality, ilvl, _, itemType, itemSubType, _, equipLoc, _, _, classId, subclassId, bindType = fn(link)
        if not name then return nil end
        return { name = name, link = itemLink, quality = quality, ilvl = ilvl, equipLoc = equipLoc,
            bindType = bindType, class = classId, subclass = subclassId, itemType = itemType, itemSubType = itemSubType }
    end

    -- An item's stats and class restriction, as ItemFit reads them: { stats = { key = value }, classes = {...} | nil },
    -- or nil until the game has the item. Base stats come from GetItemStats; equip effects and "Classes:" from the
    -- tooltip text (English patterns for the effects; the classes line uses the client's own format string).
    local STAT_KEYS = {
        ITEM_MOD_STRENGTH_SHORT = "str", ITEM_MOD_AGILITY_SHORT = "agi", ITEM_MOD_STAMINA_SHORT = "sta",
        ITEM_MOD_INTELLECT_SHORT = "int", ITEM_MOD_SPIRIT_SHORT = "spi", RESISTANCE0_NAME = "armor",
        ITEM_MOD_ATTACK_POWER_SHORT = "ap", ITEM_MOD_RANGED_ATTACK_POWER_SHORT = "rap", ITEM_MOD_SPELL_POWER_SHORT = "sp",
        ITEM_MOD_SPELL_HEALING_DONE_SHORT = "heal", ITEM_MOD_MANA_REGENERATION_SHORT = "mp5", ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "dps",
        ITEM_MOD_BLOCK_VALUE_SHORT = "block", ITEM_MOD_DEFENSE_SKILL_RATING_SHORT = "defense",
    }
    local EQUIP = {
        { "Increases damage and healing done by magical spells and effects by up to (%d+)", "sp" },
        { "Increases healing done by spells and effects by up to (%d+)", "heal" },
        { "Increases damage done by (%a+) spells and effects by up to (%d+)", "school" },
        { "Improves your chance to hit with spells by (%d+)%%", "spellhit" },
        { "Improves your chance to hit by (%d+)%%", "hit" },
        { "Improves your chance to get a critical strike with spells by (%d+)%%", "spellcrit" },
        { "Improves your chance to get a critical strike by (%d+)%%", "crit" },
        { "Restores (%d+) mana per 5 sec", "mp5" },
        { "%+(%d+) ranged Attack Power", "rap" },
        { "Increases attack power by (%d+) in Cat", "feralap" },
        { "%+(%d+) Attack Power", "ap" },
        { "Increased Defense %+(%d+)", "defense" },
        { "Increases your chance to dodge an attack by (%d+)%%", "dodge" },
        { "Increases your chance to parry an attack by (%d+)%%", "parry" },
        { "Increases your chance to block attacks with a shield by (%d+)%%", "blockPct" },
        { "Increases the block value of your shield by (%d+)", "block" },
    }
    local function classPattern()
        local fmt = E.ITEM_CLASSES_ALLOWED or "Classes: %s"
        local escaped = fmt:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "%%%1")
        return "^" .. escaped:gsub("%%s", "(.+)") .. "$"
    end
    local function classToken(name)
        for _, t in ipairs({ E.LOCALIZED_CLASS_NAMES_MALE, E.LOCALIZED_CLASS_NAMES_FEMALE }) do
            for token, n in pairs(t or {}) do if n == name then return token end end
        end
        local upper = name:upper()
        return upper
    end
    function c:itemStats(link)
        link = safe(link)
        if not link then return nil end
        local stats = {}
        local getStats = (E.C_Item and E.C_Item.GetItemStats) or E.GetItemStats
        if getStats then
            local ok, raw = pcall(getStats, link)
            if ok and type(raw) == "table" then
                for k, v in pairs(raw) do if STAT_KEYS[k] and tonumber(v) then stats[STAT_KEYS[k]] = tonumber(v) end end
            end
        end
        local tip = E.C_TooltipInfo and E.C_TooltipInfo.GetHyperlink
        if not tip then return { stats = stats } end
        local ok, data = pcall(tip, link)
        if not (ok and type(data) == "table" and type(data.lines) == "table") then return nil end
        local classes
        local pattern = classPattern()
        for _, line in ipairs(data.lines) do
            local text = safe(line.leftText)
            if type(text) == "string" then
                local list = text:match(pattern)
                if list then
                    classes = {}
                    for name in list:gmatch("[^,]+") do classes[#classes + 1] = classToken((name:gsub("^%s+", ""):gsub("%s+$", ""))) end
                end
                for _, e in ipairs(EQUIP) do
                    local a, b = text:match(e[1])
                    if e[2] == "school" and a and b then
                        local key = a:lower()
                        if stats[key] == nil then stats[key] = tonumber(b) end
                    elseif a and stats[e[2]] == nil then
                        stats[e[2]] = tonumber(a)
                        -- in 1.12 "+X Attack Power" raises melee and ranged attack power alike
                        if e[2] == "ap" and stats.rap == nil then stats.rap = tonumber(a) end
                        break
                    end
                end
            end
        end
        return { stats = stats, classes = classes }
    end

    -- How many of an item (id, name or link) this player has; includeBank uses the game's bank cache.
    function c:itemCount(what, includeBank)
        local fn = (E.C_Item and E.C_Item.GetItemCount) or E.GetItemCount
        if not fn or what == nil then return 0 end
        local ok, n = pcall(fn, what, includeBank and true or false)
        return (ok and tonumber(n)) or 0
    end

    -- This player's standing with a faction: 1 (Hated) .. 8 (Exalted), or nil if unknown.
    function c:reputation(factionId)
        local fn = E.C_Reputation and E.C_Reputation.GetFactionDataByID
        if not fn or not factionId then return nil end
        local ok, data = pcall(fn, factionId)
        return ok and type(data) == "table" and tonumber(data.reaction) or nil
    end


    -- Disenchanting: the cast, then the loot window it opens. FIELD: confirm the spell id (13262) and that the result arrives as a loot window.
    local disenchantCastAt
    function handlers.UNIT_SPELLCAST_SUCCEEDED(unit, _, spellId)
        if unit == "player" and spellId == 13262 then disenchantCastAt = (E.GetTime and E.GetTime()) or 0 end
    end

    function handlers.LOOT_OPENED()
        lootOpen = true
        local slots = readSlots()
        bus.emit("loot.opened", { slots = slots })
        if disenchantCastAt and ((E.GetTime and E.GetTime()) or 0) - disenchantCastAt < 10 then
            disenchantCastAt = nil
            bus.emit("disenchant.loot", { slots = slots })
        end
    end
    function handlers.LOOT_SLOT_CLEARED(slot) bus.emit("loot.slotCleared", { slot = slot }) end
    function handlers.LOOT_CLOSED()
        lootOpen = false
        bus.emit("loot.closed")
    end
end
