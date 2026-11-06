-- King's Gambit: RealClient, the Client backed by the actual WoW API (Phase 1.6).
-- Translates WoW's quirks into our contract (see Client.lua and
-- docs/client-interface.md). All game access goes through `E` (default _G),
-- so the translation logic can be tested outside the game with a stub environment.
--
-- Signatures were checked against docs/api.json. Items marked FIELD in comments are
-- unverified assumptions to confirm in the dungeon field test.
-- Keep this file Lua 5.1-safe (no `//`, no bitwise operators).
local _, SK = ...
local Hash, Client, Identity
local M = SK:NewModule("RealClient", { "Hash", "Client", "Identity" }, function(d) Hash, Client, Identity = d.Hash, d.Client, d.Identity end)

local CHANNELS = { RAID = true, PARTY = true, GUILD = true, WHISPER = true }

local function enumName(tbl, value)
    if type(tbl) == "table" then
        for k, v in pairs(tbl) do
            if v == value then return k end
        end
    end
end

-- opts.env: the environment table to use instead of _G (tests).
function M.New(opts)
    local E = (opts and opts.env) or _G
    local bus = Client.NewBus()

    -- Secret Values: refuse to touch values the client has hidden from addons.
    local function safe(v)
        if v ~= nil and E.issecretvalue and E.issecretvalue(v) then return nil end
        return v
    end

    ---------------------------------------------------------------- who a character is (see Identity.lua)
    -- There are no realms: a character is its first and last name. Every name that comes from the game is turned into the canonical identity here, once,
    -- and every name sent back is turned into the game's own spelling. Nothing else in the addon knows how the game writes a name.
    local seps = {}   -- the separator strings the game puts between first and last name, learned from the game (Identity.LearnSeparator)
    local rawOf = {}  -- canonical identity -> the game's own spelling of it, for sending names back
    local function learn(raw)
        local api = E.C_NameUtil and E.C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator
        if not api then return end
        local ok, linked = pcall(api, raw)
        if not ok then return end
        local sep = Identity.LearnSeparator(raw, linked)
        if not sep then return end
        for _, known in ipairs(seps) do if known == sep then return end end
        seps[#seps + 1] = sep
    end
    -- a name as a person types it, or as an old record spells it: no memory of how the game wrote it
    local function normalize(name)
        name = safe(name)
        if type(name) ~= "string" or name == "" then return nil end
        return Identity.Normalize(name, seps)
    end
    -- a name the GAME gave us: remember its spelling so we can send it back exactly
    local function fromGame(raw)
        raw = safe(raw)
        if type(raw) ~= "string" or raw == "" then return nil end
        learn(raw)
        local id = Identity.Normalize(raw, seps)
        if id and rawOf[id] == nil then rawOf[id] = raw end
        return id
    end
    -- the game's spelling of an identity: as it gave it to us, else the display form with the learned separator
    local function toGame(id)
        if type(id) ~= "string" then return id end
        return rawOf[id] or (id:gsub(Identity.SEP, seps[1] or " "))
    end
    -- A unit's full name. UnitNameUnmodified is preferred and the answer with the most parts wins: ShouldDisplaySurname() suggests UnitName can leave
    -- the surname out depending on a player's own display settings, and an identity must not depend on that. FIELD: confirm in the game which of these
    -- carries the surname (the `/gambit check` self-check prints all three).
    local NAME_SOURCES = { "UnitNameUnmodified", "UnitFullName", "UnitName" }
    local function unitName(unit)
        local best, bestParts
        for _, fn in ipairs(NAME_SOURCES) do
            if E[fn] then
                local ok, name = pcall(E[fn], unit)
                name = ok and safe(name)
                if type(name) == "string" and name ~= "" then
                    learn(name)
                    local n = #(Identity.Normalize(name, seps) or ""):gsub("[^" .. Identity.SEP .. "]", "") + 1
                    if not best or n > bestParts then best, bestParts = name, n end
                end
            end
        end
        return best
    end

    local c = {
        caps = { masterLoot = true, trade = true, comms = E.C_ChatInfo ~= nil, guild = true },
        maxMessage = 255,
        logs = {},
    }

    ---------------------------------------------------------------- time and randomness
    function c:now() return E.GetTime() end
    function c:serverTime() return math.floor(E.GetServerTime()) end

    function c:after(sec, fn) return E.C_Timer.NewTimer(sec, fn) end
    function c:every(sec, fn) return E.C_Timer.NewTicker(sec, fn) end
    function c:cancel(handle)
        if handle and handle.Cancel then handle:Cancel() end
    end

    function c:random(n)
        if n then return math.random(n) end
        return math.random()
    end

    ---------------------------------------------------------------- identity and roster
    -- The version in the addon's TOC (the release build stamps "<version>.<build number>" there), or "dev" if there is none.
    function c:addonVersion()
        local get = (E.C_AddOns and E.C_AddOns.GetAddOnMetadata) or E.GetAddOnMetadata
        local v = get and safe(get("KingsGambit", "Version"))
        return (type(v) == "string" and v ~= "") and v or "dev"
    end

    function c:me() return fromGame(unitName("player")) end
    -- This character's class as the game's file name ("WARRIOR"), or nil if the game doesn't say.
    function c:myClass()
        local ok, _, file = pcall(E.UnitClass, "player")
        return ok and file or nil
    end

    function c:normalize(name) return normalize(name) end
    -- What the game says about names, raw, for the in-game self-check (`/gambit check`): it is how the real names get confirmed.
    function c:nameProbe()
        local out = {}
        for _, fn in ipairs(NAME_SOURCES) do
            if E[fn] then
                local ok, a, b = pcall(E[fn], "player")
                out[#out + 1] = fn .. " = " .. (ok and (("%q, %q"):format(tostring(safe(a)), tostring(safe(b)))) or "error")
            else
                out[#out + 1] = fn .. " = (not available)"
            end
        end
        local name = unitName("player")
        out[#out + 1] = "ShouldDisplaySurname = " .. tostring(E.ShouldDisplaySurname and E.ShouldDisplaySurname())
        if name and E.C_NameUtil and E.C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator then
            local ok, linked = pcall(E.C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator, name)
            local hex = {}
            for i = 1, #name do hex[#hex + 1] = ("%02x"):format(name:byte(i)) end
            out[#out + 1] = ("chosen full name %q (bytes %s) -> link form %q"):format(name, table.concat(hex, " "), tostring(ok and linked))
            out[#out + 1] = "learned separator(s): " .. (#seps > 0 and ("%q"):format(table.concat(seps, " | ")) or "none")
        end
        out[#out + 1] = "identity = " .. tostring(self:me())
        return out
    end
    function c:inGroup() return E.IsInGroup() and true or false end
    function c:inRaid() return E.IsInRaid() and true or false end

    -- { name, class (file token), rank 0/1/2, online, subgroup }
    function c:roster()
        local out = {}
        if E.IsInRaid() then
            for i = 1, E.GetNumGroupMembers() do
                local name, rank, subgroup, _, _, fileName, _, online = E.GetRaidRosterInfo(i)
                name = fromGame(name)
                if name then
                    out[#out + 1] = { name = name, class = fileName, rank = rank or 0,
                        online = online and true or false, subgroup = subgroup or 1 }
                end
            end
        elseif E.IsInGroup() then
            local units = { "player", "party1", "party2", "party3", "party4" }
            for _, unit in ipairs(units) do
                if E.UnitExists(unit) then
                    local name = fromGame(unitName(unit))
                    if name then
                        local _, fileName = E.UnitClass(unit)
                        out[#out + 1] = { name = name, class = fileName,
                            rank = E.UnitIsGroupLeader(unit) and 2 or 0,
                            online = E.UnitIsConnected(unit) and true or false, subgroup = 1 }
                    end
                end
            end
        end
        return out
    end

    function c:rankOf(name)
        name = normalize(name)
        for _, m in ipairs(self:roster()) do
            if m.name == name then return m.rank end
        end
    end

    -- The raid (or dungeon group) leader: there is always one in a group. nil when not in a group.
    function c:leader()
        for _, m in ipairs(self:roster()) do
            if m.rank == 2 then return m.name end
        end
    end

    function c:guildRoster()
        local out = {}
        if not (E.IsInGuild and E.IsInGuild()) then return out end
        for i = 1, E.GetNumGuildMembers() do
            local name, _, _, _, _, _, _, _, online, _, fileName = E.GetGuildRosterInfo(i)
            name = fromGame(name)
            if name then out[#out + 1] = { name = name, class = fileName, online = online and true or false } end
        end
        return out
    end

    ---------------------------------------------------------------- loot
    -- Returns "master", "group", "freeforall", "needbeforegreed", "personal", ...
    function c:lootMethod()
        if E.C_PartyInfo and E.C_PartyInfo.GetLootMethod then
            local method = E.C_PartyInfo.GetLootMethod()
            local name = enumName(E.Enum and E.Enum.LootMethod, method)
            if name then return name:lower() end
            if type(method) == "string" then return method:lower() end
        elseif E.GetLootMethod then
            local method = E.GetLootMethod()
            if type(method) == "string" then return method:lower() end
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
                if k:lower() == method then enumValue = v end
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
            return fromGame(name)
        elseif partyId == 0 then
            return self:me()
        elseif partyId then
            return fromGame(unitName("party" .. partyId))
        end
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

    ---------------------------------------------------------------- communication
    function c:registerPrefix(prefix)
        local result = E.C_ChatInfo.RegisterAddonMessagePrefix(prefix)
        local name = enumName(E.Enum and E.Enum.RegisterAddonMessagePrefixResult, result)
        return result == nil or name == "Success" or name == "DuplicatePrefix" or result == true
    end

    local function restricted()
        local ci = E.C_ChatInfo
        return (ci.AreOutgoingAddonChatMessagesRestricted and ci.AreOutgoingAddonChatMessagesRestricted()) and true or false
    end

    function c:send(prefix, payload, channel, target)
        if not self.caps.comms then return false, "nocomms" end
        if type(payload) ~= "string" then return false, "badpayload" end
        if #payload > self.maxMessage then return false, "toolong" end
        if not CHANNELS[channel] then return false, "badchannel" end
        if channel == "WHISPER" and not target then return false, "notarget" end
        if restricted() then return false, "restricted" end
        local result = E.C_ChatInfo.SendAddonMessage(prefix, payload, channel, channel == "WHISPER" and toGame(target) or target)
        local name = enumName(E.Enum and E.Enum.SendAddonMessageResult, result)
        if result == true or result == nil or name == "Success" then return true end
        local reason = (name or tostring(result)):lower()
        if reason == "invalidprefix" then reason = "noprefix" end
        return false, reason
    end

    -- Pacing lives in the sync layer; the client reports throttling as a send failure.
    function c:pending() return 0 end

    function c:whisper(name, text)
        if E.C_ChatInfo.InChatMessagingLockdown and E.C_ChatInfo.InChatMessagingLockdown() then
            return false, "restricted"
        end
        E.C_ChatInfo.SendChatMessage(text, "WHISPER", nil, toGame(name))
        return true
    end

    function c:announce(text, channel)
        if E.C_ChatInfo.InChatMessagingLockdown and E.C_ChatInfo.InChatMessagingLockdown() then
            return false, "restricted"
        end
        E.C_ChatInfo.SendChatMessage(text, channel or "RAID")
        return true
    end

    -- "c" = CBOR + base64 (preferred); "k" = canonical text (only if C_EncodingUtil is missing).
    function c:serialize(t)
        local eu = E.C_EncodingUtil
        if eu and eu.SerializeCBOR and eu.EncodeBase64 then
            local base64 = E.Enum and E.Enum.Base64Variant
            return "c" .. eu.EncodeBase64(eu.SerializeCBOR(t), base64 and base64.Standard or 0)
        end
        return "k" .. Hash.Canon(t)
    end

    function c:deserialize(str)
        if type(str) ~= "string" or #str < 1 then return nil end
        local tag, body = str:sub(1, 1), str:sub(2)
        if tag == "k" then return Hash.Decode(body) end
        if tag == "c" then
            local eu = E.C_EncodingUtil
            if not (eu and eu.DeserializeCBOR and eu.DecodeBase64) then return nil end
            local base64 = E.Enum and E.Enum.Base64Variant
            local ok, value = pcall(function()
                return eu.DeserializeCBOR(eu.DecodeBase64(body, base64 and base64.Standard or 0))
            end)
            if ok and type(value) == "table" then return value end
        end
        return nil
    end

    ---------------------------------------------------------------- trade
    local tradeActive, tradePartner, tradeCompleted = false, nil, false

    local function tradeLinks(fn)
        local out = {}
        for i = 1, 6 do
            local link = fn and safe(fn(i))
            if link then out[#out + 1] = link end
        end
        return out
    end

    local function snapshotTrade()
        local give = (E.C_TradeInfo and E.C_TradeInfo.GetTradePlayerItemLink) or E.GetTradePlayerItemLink
        local get = (E.C_TradeInfo and E.C_TradeInfo.GetTradeTargetItemLink) or E.GetTradeTargetItemLink
        return { partner = tradePartner, give = tradeLinks(give), get = tradeLinks(get), accepted = false }
    end

    function c:trade()
        if not tradeActive then return nil end
        return snapshotTrade()
    end

    -- FIELD: needs a tooltip scan ("You may trade this item ... within the next X"); not yet implemented.
    function c:tradeableUntil(_) return nil end

    ---------------------------------------------------------------- environment and storage
    function c:storage()
        E.KingsGambitDB = E.KingsGambitDB or {}
        E.KingsGambitCharDB = E.KingsGambitCharDB or { ui = {} }
        return { account = E.KingsGambitDB, char = E.KingsGambitCharDB }
    end

    function c:playSound(kind)
        local kit = E.SOUNDKIT
        local id = kit and (kind == "alert" and kit.RAID_WARNING or kit.IG_MAINMENU_OPTION_CHECKBOX_ON)
        if id and E.PlaySound then E.PlaySound(id) end
    end

    function c:print(text) E.print("|cff66ccffGambit|r " .. tostring(text)) end

    function c:log(level, text)
        local logs = self.logs
        logs[#logs + 1] = { level = level, text = text }
        if #logs > 200 then table.remove(logs, 1) end
    end

    function c:on(event, fn) return bus.on(event, fn) end

    ---------------------------------------------------------------- raw WoW events -> ours
    local handlers = {}

    function handlers.GROUP_ROSTER_UPDATE() bus.emit("roster.changed") end
    function handlers.PARTY_LOOT_METHOD_CHANGED() bus.emit("lootMethod.changed", { method = c:lootMethod() }) end

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

    function handlers.CHAT_MSG_ADDON(prefix, text, channel, sender)
        sender, text = safe(sender), safe(text)
        if not (sender and text) then return end
        bus.emit("comms.received", { prefix = prefix, payload = text, channel = channel, sender = fromGame(sender) })
    end

    function handlers.CHAT_MSG_WHISPER(text, sender)
        sender, text = safe(sender), safe(text)
        if not (sender and text) then return end
        bus.emit("whisper.received", { sender = fromGame(sender), text = text })
    end

    function handlers.ENCOUNTER_END(id, name, _, _, success)
        bus.emit("encounter.ended", { id = id, name = name, success = (success == 1 or success == true) })
    end

    function handlers.PLAYER_ENTERING_WORLD() bus.emit("world.entered") end

    function handlers.GET_ITEM_INFO_RECEIVED(itemId)
        local info = c:itemInfo(itemId)
        bus.emit("item.info", { itemId = itemId, link = info and info.link })
    end

    function handlers.ADDON_RESTRICTION_STATE_CHANGED()
        bus.emit("comms.restrictionChanged", { restricted = restricted() })
    end

    -- FIELD: confirm trade event order and that UI_INFO_MESSAGE reports completion.
    function handlers.TRADE_SHOW()
        tradeActive, tradeCompleted = true, false
        tradePartner = fromGame(unitName("NPC"))
    end
    function handlers.TRADE_ACCEPT_UPDATE() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.TRADE_PLAYER_ITEM_CHANGED() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.TRADE_TARGET_ITEM_CHANGED() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.UI_INFO_MESSAGE(_, message)
        if tradeActive and message ~= nil and message == E.ERR_TRADE_COMPLETE then tradeCompleted = true end
    end
    function handlers.TRADE_CLOSED()
        local snap = tradeActive and snapshotTrade() or { partner = tradePartner, give = {}, get = {} }
        tradeActive = false
        bus.emit("trade.closed", { completed = tradeCompleted, partner = snap.partner, gave = snap.give, got = snap.get })
        tradeCompleted = false
    end

    -- Wire the frame. Handlers see the raw WoW arguments; errors in one never block the rest.
    local frame = E.CreateFrame("Frame")
    c.unregistered = {} -- raw events this client refused to register (FIELD: check after a run)
    for event in pairs(handlers) do
        if not pcall(frame.RegisterEvent, frame, event) then c.unregistered[#c.unregistered + 1] = event end
    end
    frame:SetScript("OnEvent", function(_, event, ...)
        local h = handlers[event]
        if h then
            local ok, err = pcall(h, ...)
            if not ok then c:log("error", event .. ": " .. tostring(err)) end
        end
    end)
    c.frame = frame

    -- Dispatch a raw event by hand (tests and field tooling).
    function c:fireRaw(event, ...)
        local h = handlers[event]
        if h then h(...) end
    end

    return c
end
