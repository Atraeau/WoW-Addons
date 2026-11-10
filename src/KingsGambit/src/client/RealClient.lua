-- King's Gambit: RealClient, the Client backed by the actual WoW API (Phase 1.6).
-- Translates WoW's quirks into our contract (see Client.lua and
-- docs/client-interface.md). All game access goes through `E` (default _G),
-- so the translation logic can be tested outside the game with a stub environment.
--
-- Signatures were checked against docs/api.json. Items marked FIELD in comments are
-- unverified assumptions to confirm in the dungeon field test.
-- Keep this file Lua 5.1-safe (no `//`, no bitwise operators).
local _, SK = ...
local Hash, Client, Identity, RealLoot, RealChat, RealTrade
-- Loot, chat and trade (their methods and the game events that drive them) are in RealLoot.lua, RealChat.lua and RealTrade.lua; New builds what they share.
local M = SK:NewModule("RealClient", { "Hash", "Client", "Identity", "RealLoot", "RealChat", "RealTrade" }, function(d)
    Hash, Client, Identity, RealLoot, RealChat, RealTrade = d.Hash, d.Client, d.Identity, d.RealLoot, d.RealChat, d.RealTrade
end)

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
    -- the game's spelling of an identity: as it gave it to us, else First-Last (the surname goes where a realm would: the game's own folders and chat
    -- names read "Coreander-Shoeberry")
    local function toGame(id)
        if type(id) ~= "string" then return id end
        return rawOf[id] or (id:gsub(Identity.SEP, seps[1] or "-"))
    end
    -- A unit's full name. UnitNameUnmodified is preferred and the answer with the most parts wins: ShouldDisplaySurname() suggests UnitName can leave
    -- the surname out depending on a player's own display settings, and an identity must not depend on that. FIELD: confirm in the game which of these
    -- carries the surname (the `/gambit check` self-check prints all three).
    -- CONFIRMED in the game (the self-check, 2026-11-04): all three return the FIRST name, then the SURNAME as the second value, where a realm would be:
    -- UnitNameUnmodified("player") = "Coreander", "Shoeberry". The surname is therefore taken from the second value (unless the first already has two names).
    local NAME_SOURCES = { "UnitNameUnmodified", "UnitFullName", "UnitName" }
    local function withSurname(name, surname)
        surname = safe(surname)
        if type(name) == "string" and type(surname) == "string" and surname ~= "" and #(Identity.Normalize(name, seps) or ""):gsub("[^" .. Identity.SEP .. "]", "") == 0 then
            return name .. "-" .. surname
        end
        return name
    end
    local function unitName(unit)
        local best, bestParts
        for _, fn in ipairs(NAME_SOURCES) do
            if E[fn] then
                local ok, name, surname = pcall(E[fn], unit)
                name = ok and safe(name)
                if type(name) == "string" and name ~= "" then
                    name = withSurname(name, surname)
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

-- The spec this character is, read from the talent points: the tree with the most points spent. Returns its name and role ("tank", "healer", "damage"),
-- or nil when the game won't say or no points are spent (the player then chooses). C_SpecializationInfo.GetSpecializationInfo(index) gives, per tree,
-- name (2nd), role (5th) and points spent (7th); the number of trees comes from the class.
function c:mySpec()
    local S = E.C_SpecializationInfo
    if type(S) ~= "table" or not S.GetSpecializationInfo then return nil end
    local ok, n = pcall(function()
        local classId = select(3, E.UnitClass("player"))
        return S.GetNumSpecializationsForClassID and classId and S.GetNumSpecializationsForClassID(classId) or 3
    end)
    n = (ok and tonumber(n)) or 3
    local bestName, bestRole, bestPoints = nil, nil, 0
    for i = 1, n do
        local good, _, name, _, _, role, _, points = pcall(S.GetSpecializationInfo, i, false, false)
        if good and type(name) == "string" and (tonumber(points) or 0) > bestPoints then bestName, bestRole, bestPoints = name, role, tonumber(points) end
    end
    return bestName, bestRole
end

function c:normalize(name) return normalize(name) end
    -- What the game says about names, raw, for the in-game self-check (`/gambit check`): it is how the real names get confirmed.
    local worldParts, worldKey -- (defined with the storage, below)
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
        local mode, faction = worldParts()
        out[#out + 1] = ("ledger belongs to %s (game mode %s, faction %s, guild %s)"):format(worldKey(), tostring(mode), tostring(faction), tostring(self:guildName()))
        return out
    end
    -- What the game says about addon messages, raw, for the self-check: whether outgoing ones are restricted (the API documents this as decided realm by
    -- realm), the restriction states, and what the game answers when a send is attempted on each channel, ignoring our own restricted() gate.
    function c:commsProbe()
        local out = {}
        local ci = E.C_ChatInfo or {}
        local function call(fn, ...)
            if not fn then return "(not available)" end
            local ok, a = pcall(fn, ...)
            return ok and tostring(safe(a)) or "error"
        end
        out[#out + 1] = "AreOutgoingAddonChatMessagesRestricted = " .. call(ci.AreOutgoingAddonChatMessagesRestricted)
        out[#out + 1] = "InChatMessagingLockdown = " .. call(ci.InChatMessagingLockdown)
        local ra = E.C_RestrictedActions
        local types = E.Enum and E.Enum.AddOnRestrictionType
        if ra and ra.GetAddOnRestrictionState and type(types) == "table" then
            local names = {}
            for name in pairs(types) do names[#names + 1] = name end
            table.sort(names)
            for _, name in ipairs(names) do
                out[#out + 1] = ("restriction %s = %s"):format(name, call(ra.GetAddOnRestrictionState, types[name]))
            end
        else
            out[#out + 1] = "restriction states: (not available)"
        end
        -- A raw attempt per channel: the answer the game gives, whatever it is (a refusal changes nothing).
        for _, ch in ipairs { "WHISPER", "PARTY", "GUILD" } do
            if ci.SendAddonMessage then
                local ok, res = pcall(ci.SendAddonMessage, "KGCHECK", "ping", ch, ch == "WHISPER" and toGame(self:me()) or nil)
                local label = ok and (enumName(E.Enum and E.Enum.SendAddonMessageResult, res) or tostring(safe(res))) or "error"
                out[#out + 1] = ("raw send on %s -> %s"):format(ch, tostring(label))
            end
        end
        return out
    end
    -- What the game says about the guild's ranks and what each may do, raw, for the self-check: it is how "an officer" is to be defined from the game's own
    -- rank permissions instead of a list kept here. Prints this character's rank, the game's own officer answer, and every rank's name and permission flags
    -- (a string of 1 and 0 in the game's order, or name=1 when the game names them).
    function c:guildProbe()
        local out = {}
        local ci = E.C_GuildInfo or {}
        local function call(fn, ...)
            if not fn then return "(not available)" end
            local r = { pcall(fn, ...) }
            if not r[1] then return "error" end
            local parts = {}
            for i = 2, #r do parts[#parts + 1] = tostring(safe(r[i])) end
            return table.concat(parts, ", ")
        end
        out[#out + 1] = "IsInGuild = " .. call(E.IsInGuild)
        out[#out + 1] = "GetGuildInfo(player) = " .. call(E.GetGuildInfo, "player") .. "  (guild, rank name, rank index)"
        out[#out + 1] = "C_GuildInfo.IsGuildOfficer = " .. call(ci.IsGuildOfficer)
        out[#out + 1] = "IsGuildLeader = " .. call(E.IsGuildLeader)
        local numFn = ci.GuildControlGetNumRanks or E.GuildControlGetNumRanks
        local n = tonumber(call(numFn)) or 0
        out[#out + 1] = "ranks = " .. tostring(n)
        local nameFn = ci.GuildControlGetRankName or E.GuildControlGetRankName
        local flagFn = ci.GuildControlGetRankFlags or E.GuildControlGetRankFlags
        for i = 1, math.min(n, 12) do
            local flags = "(not available)"
            if flagFn then
                local ok, t = pcall(flagFn, i)
                if not ok then flags = "error"
                elseif type(t) == "table" then
                    if #t > 0 then
                        local bits = {}
                        for k = 1, #t do bits[k] = t[k] and "1" or "0" end
                        flags = table.concat(bits)
                    else
                        local keys = {}
                        for k, v in pairs(t) do keys[#keys + 1] = tostring(k) .. "=" .. (v and "1" or "0") end
                        table.sort(keys)
                        flags = table.concat(keys, " ")
                    end
                else flags = tostring(t) end
            end
            out[#out + 1] = ("rank %d %q flags %s"):format(i, call(nameFn, i), flags)
        end
        return out
    end
    -- ---- officers, from the game's own rank permission ("Is Officer": among other things, access to the officer channels: flag 3 of a rank's permissions;
    -- the Guild Master's rank, index 0, always counts). Confirmed in the game: a member who isn't the Guild Master can read every rank's flags, and
    -- C_GuildInfo.IsGuildOfficer() is true for an officer.
    local OFFICER_FLAG = 3
    local rankCache
    local function guildRanks()
        local now = E.GetTime and E.GetTime() or 0
        if rankCache and now - rankCache.at < 30 then return rankCache end
        local cache = { at = now, byName = {}, officerRank = {} }
        local ci = E.C_GuildInfo or {}
        local nFn = ci.GuildControlGetNumRanks or E.GuildControlGetNumRanks
        local flagFn = ci.GuildControlGetRankFlags or E.GuildControlGetRankFlags
        local ranks = nFn and tonumber(select(2, pcall(nFn))) or 0
        for i = 1, ranks do
            local ok, flags = pcall(flagFn, i)
            cache.officerRank[i - 1] = (i == 1) or (ok and type(flags) == "table" and flags[OFFICER_FLAG] == true) or false
        end
        if E.IsInGuild and E.IsInGuild() and E.GetNumGuildMembers and E.GetGuildRosterInfo then
            for i = 1, (E.GetNumGuildMembers() or 0) do
                local name, _, rankIndex = E.GetGuildRosterInfo(i)
                name = fromGame(name)
                if name then cache.byName[name] = rankIndex end
            end
        end
        rankCache = cache
        return cache
    end
    -- Is this player (default: this character) an officer in the guild? true or false, nil when the game doesn't say. With no guild the ledger is one's own: true.
    function c:isOfficer(name)
        if not (E.IsInGuild and E.IsInGuild()) then return true end
        name = name and normalize(name) or nil
        if name == nil or name == self:me() then
            local ok, v = pcall((E.C_GuildInfo or {}).IsGuildOfficer or function() return nil end)
            if ok and v ~= nil then return v and true or false end
            if E.IsGuildLeader then local ok2, leader = pcall(E.IsGuildLeader); if ok2 and leader then return true end end
            return nil
        end
        local cache = guildRanks()
        local rank = cache.byName[name]
        if rank == nil then return nil end
        return cache.officerRank[rank] == true
    end
    -- The guild's officers, by name (those whose rank has the permission), for display.
    function c:officers()
        local cache = guildRanks()
        local out = {}
        for name, rank in pairs(cache.byName) do if cache.officerRank[rank] then out[#out + 1] = name end end
        table.sort(out)
        return out
    end
    function c:inGroup() return E.IsInGroup() and true or false end
    function c:inRaid() return E.IsInRaid() and true or false end
    -- Is this character inside an instance (a raid or a dungeon), as opposed to the open world? (IsInInstance: true plus the kind, "raid" or "party".)
    function c:inInstance()
        if not E.IsInInstance then return false end
        local ok, inside, kind = pcall(E.IsInInstance)
        return ok and inside and (kind == "raid" or kind == "party") and true or false
    end

    -- { name, class (file token), rank 0/1/2, online, subgroup }
    -- A name the roster gave without a surname (the game may leave it out for someone who shares yours, as it would a realm), completed from the unit it belongs to.
    local function complete(raw, unit)
        raw = safe(raw)
        if type(raw) ~= "string" or raw == "" or not unit then return raw end
        local id = Identity.Normalize(raw, seps)
        if id and id:find(Identity.SEP, 1, true) then return raw end
        local full = unitName(unit)
        local fullId = full and Identity.Normalize(full, seps)
        if fullId and Identity.First(fullId) and id and Identity.First(fullId):lower() == id:lower() then return full end
        return raw
    end

    function c:roster()
        local out = {}
        if E.IsInRaid() then
            for i = 1, E.GetNumGroupMembers() do
                local name, rank, subgroup, _, _, fileName, _, online = E.GetRaidRosterInfo(i)
                name = fromGame(complete(name, "raid" .. i))
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

    local function restricted()
        local ci = E.C_ChatInfo
        return (ci.AreOutgoingAddonChatMessagesRestricted and ci.AreOutgoingAddonChatMessagesRestricted()) and true or false
    end

    ---------------------------------------------------------------- environment and storage
    -- Which world a character plays in: the game's mode (its ruleset: a PvE or a PvP server, for one), its faction and its guild. A ledger belongs to one guild
    -- in one world, never to the whole account: an Alliance character on a PvE ruleset and a Horde one on a PvP ruleset, or two guilds, share nothing, though they
    -- share the SavedVariables file.
    -- FIELD: confirm what C_GameRules.GetCurrentGameModeRecordID returns for each of the rulesets (and that it is there at login).
    function worldParts()
        local mode, faction
        local rules = E.C_GameRules
        if rules and rules.GetCurrentGameModeRecordID then
            local ok, id = pcall(rules.GetCurrentGameModeRecordID)
            if ok and id ~= nil then mode = id end
        end
        if E.UnitFactionGroup then
            local ok, f = pcall(E.UnitFactionGroup, "player")
            if ok and type(f) == "string" and f ~= "" then faction = f end
        end
        return mode, faction
    end
    -- The guild this character belongs to, or nil (not in one, or its name hasn't loaded yet: see guildKnown).
    function c:guildName()
        if not (E.IsInGuild and E.IsInGuild()) then return nil end
        if not E.GetGuildInfo then return nil end
        local ok, name = pcall(E.GetGuildInfo, "player")
        name = ok and safe(name)
        if type(name) == "string" and name ~= "" then return name end
    end
    -- Is the guild settled: not in one, or its name has loaded? (It arrives a moment after login.)
    function c:guildKnown()
        if not (E.IsInGuild and E.IsInGuild()) then return true end
        return c:guildName() ~= nil
    end
    -- A ledger belongs to a GUILD (within a world): a character in no guild has a ledger of their own, so it never mixes with anyone else's.
    function worldKey()
        local mode, faction = worldParts()
        local guild = c:guildName()
        local scope = guild and ("guild:" .. guild:lower()) or ("solo:" .. tostring(c:me()))
        return ("mode%s-%s-%s"):format(tostring(mode or "?"), tostring(faction or "?"), scope)
    end
    function c:world() return worldKey() end

    -- `account` is this world's store (the ledger, who writes which chain, requests, orphans); `shared` is the whole account's (the self-check, settings).
    function c:storage()
        E.KingsGambitDB = E.KingsGambitDB or {}
        E.KingsGambitCharDB = E.KingsGambitCharDB or { ui = {} }
        local db = E.KingsGambitDB
        db.worlds = db.worlds or {}
        local key = worldKey()
        db.worlds[key] = db.worlds[key] or {}
        return { account = db.worlds[key], shared = db, char = E.KingsGambitCharDB, world = key }
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

    -- What the part files share. Each adds its own methods and handlers (and exports what a later one needs through h).
    local h = { E = E, bus = bus, safe = safe, seps = seps, normalize = normalize, fromGame = fromGame, toGame = toGame, unitName = unitName, complete = complete, handlers = handlers, enumName = enumName, CHANNELS = CHANNELS,
        }
    RealLoot.Install(c, h)
    RealChat.Install(c, h)
    RealTrade.Install(c, h)

    function handlers.GROUP_ROSTER_UPDATE() bus.emit("roster.changed") end
    function handlers.PARTY_LOOT_METHOD_CHANGED() bus.emit("lootMethod.changed", { method = c:lootMethod() }) end



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
