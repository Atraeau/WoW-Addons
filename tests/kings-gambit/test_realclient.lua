-- RealClient translation tests, run against a stub WoW environment shaped like the
-- documented API (signatures from docs/api.json). This checks OUR translation logic only;
-- whether the real client behaves like the stub is what the in-game field test is for.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Client, RealClient, Hash = SK.modules.Client, SK.modules.RealClient, SK.modules.Hash

local SECRET = {} -- stands in for a Secret Value

local function newEnv(over)
    local E = { frames = {}, given = {}, chat = {}, printed = {}, restricted = false, lockdown = false }
    E.issecretvalue = function(v) return v == SECRET end
    E.GetTime = function() return 123.5 end
    E.GetServerTime = function() return 1760000000.0 end
    E.C_Timer = { NewTimer = function(_, fn) return { fn = fn, Cancel = function(s) s.cancelled = true end } end,
        NewTicker = function(_, fn) return { fn = fn, Cancel = function(s) s.cancelled = true end } end }
    E.GetNormalizedRealmName = function() return "Realm" end
    E.UnitFullName = function(unit) if unit == "player" then return "Raidlead", "" end end
    E.IsInRaid = function() return true end
    E.IsInGroup = function() return true end
    E.GetNumGroupMembers = function() return 3 end
    local raid = { { "Raidlead", 2, 1, 80, "Warrior", "WARRIOR", "Zone", true },
        { "Mirel", 1, 1, 80, "Priest", "PRIEST", "Zone", true },
        { "Brann-Other", 0, 2, 80, "Paladin", "PALADIN", "Zone", false } }
    E.GetRaidRosterInfo = function(i) return (table.unpack or unpack)(raid[i]) end
    E.Enum = {
        LootMethod = { Freeforall = 0, Master = 2, Group = 3, NeedBeforeGreed = 4, Personal = 5 },
        SendAddonMessageResult = { Success = 0, InvalidPrefix = 1, AddonMessageThrottle = 3, GeneralError = 9 },
        RegisterAddonMessagePrefixResult = { Success = 0, DuplicatePrefix = 1, InvalidPrefix = 2 },
        Base64Variant = { Standard = 0 },
    }
    E.lootMethodId = 2
    E.C_PartyInfo = { GetLootMethod = function() return E.lootMethodId, nil, 1 end }
    E.IsMasterLooter = function() return true end
    E.loot = { { link = "|cffa335ee|Hitem:1001::::|h[Gauntlets]|h|r", q = 4 }, { link = nil, q = 1 }, { link = "|Hitem:1002|h[Cloak]|h", q = 4 } }
    E.LOOT_SLOT_ITEM = 1
    E.GetNumLootItems = function() return #E.loot end
    E.GetLootSlotType = function(slot) return E.loot[slot].link and 1 or 2 end
    E.GetLootSlotLink = function(slot) return E.loot[slot] and E.loot[slot].link end
    E.GetLootSlotInfo = function(slot) return "icon", "name", 1, nil, E.loot[slot].q end
    local cands = { "Raidlead", "Mirel", "Brann-Other" }
    E.GetMasterLootCandidate = function(_, i) return cands[i] end
    E.GiveMasterLoot = function(slot, index) E.given[#E.given + 1] = { slot = slot, index = index } end
    E.C_ChatInfo = {
        RegisterAddonMessagePrefix = function() return E.prefixResult or 0 end,
        SendAddonMessage = function() return E.sendResult or 0 end,
        AreOutgoingAddonChatMessagesRestricted = function() return E.restricted end,
        InChatMessagingLockdown = function() return E.lockdown end,
        SendChatMessage = function(text, kind, lang, target) E.chat[#E.chat + 1] = { text = text, kind = kind, target = target } end,
    }
    E.C_EncodingUtil = {
        SerializeCBOR = function(v) return Hash.Canon(v) end, DeserializeCBOR = function(s) return Hash.Decode(s) end,
        EncodeBase64 = function(s) return s end, DecodeBase64 = function(s) return s end,
    }
    E.C_Item = { GetItemInfo = function(link)
        if tostring(link):find("1001") then
            return "Gauntlets", link, 4, 78, 60, "Armor", "Plate", 1, "INVTYPE_HAND", 0, 100, 4, 4, 1
        end
    end }
    E.CreateFrame = function()
        local f = { events = {} }
        function f:RegisterEvent(ev) if ev == "BAD_EVENT" then error("unknown event") end; f.events[ev] = true end
        function f:SetScript(_, fn) f.onEvent = fn end
        E.frames[#E.frames + 1] = f
        return f
    end
    E.print = function(t) E.printed[#E.printed + 1] = t end
    E.ERR_TRADE_COMPLETE = "Trade complete."
    E.GetTradePlayerItemLink = function(i) if i == 1 then return "|Hitem:1001|h[Gauntlets]|h" end end
    E.GetTradeTargetItemLink = function() return nil end
    if over then over(E) end
    return E
end

H.newWowEnv = newEnv -- shared with the addon boot test

local function newClient(over)
    local E = newEnv(over)
    return RealClient.New({ env = E }), E
end
local function fire(E, event, ...) E.frames[1].onEvent(E.frames[1], event, ...) end

H.section("RealClient")
test("conforms to the Client contract", function()
    local c = newClient()
    local missing = Client.Missing(c)
    eq(#missing, 0, "missing: " .. table.concat(missing, ","))
end)
test("time passes straight through; serverTime is an integer", function()
    local c = newClient()
    eq(c:now(), 123.5); eq(c:serverTime(), 1760000000)
    local t = c:after(1, function() end); c:cancel(t); assert(t.cancelled)
end)
test("me and normalize add the realm, with a spaced-realm fallback", function()
    local c = newClient()
    eq(c:me(), "Raidlead-Realm"); eq(c:normalize("Aldric"), "Aldric-Realm"); eq(c:normalize("Aldric-Other"), "Aldric-Other")
    local c2 = newClient(function(E) E.GetNormalizedRealmName = nil; E.GetRealmName = function() return "Some Realm" end end)
    eq(c2:normalize("Aldric"), "Aldric-SomeRealm")
end)
test("raid roster is translated (names, class token, ranks, online)", function()
    local c = newClient()
    local r = c:roster()
    eq(#r, 3); eq(r[1].name, "Raidlead-Realm"); eq(r[1].rank, 2); eq(r[2].class, "PRIEST"); eq(r[3].name, "Brann-Other")
    eq(r[3].online, false); eq(r[3].subgroup, 2)
    eq(c:rankOf("Mirel"), 1); eq(c:rankOf("Nobody"), nil)
    assert(c:inRaid() and c:inGroup())
end)
test("secret names are skipped, never touched", function()
    local c = newClient(function(E) local old = E.GetRaidRosterInfo; E.GetRaidRosterInfo = function(i)
        if i == 2 then return SECRET, 1, 1, 80, "Priest", "PRIEST", "Zone", true end; return old(i) end end)
    eq(#c:roster(), 2)
end)
test("party (non-raid) roster is built from unit tokens", function()
    local c = newClient(function(E)
        E.IsInRaid = function() return false end
        E.UnitExists = function(u) return u == "player" or u == "party1" end
        E.UnitFullName = function(u) if u == "player" then return "Raidlead", "" end; return "Mirel", "Other" end
        E.UnitClass = function(u) return "x", u == "player" and "WARRIOR" or "PRIEST" end
        E.UnitIsGroupLeader = function(u) return u == "player" end
        E.UnitIsConnected = function() return true end
    end)
    local r = c:roster()
    eq(#r, 2); eq(r[1].rank, 2); eq(r[2].name, "Mirel-Other"); eq(r[2].class, "PRIEST")
end)
test("lootMethod maps the enum to a lowercase name; isMasterLooter follows the client", function()
    local c, E = newClient()
    eq(c:lootMethod(), "master"); assert(c:isMasterLooter())
    E.lootMethodId = 4; eq(c:lootMethod(), "needbeforegreed"); assert(not c:isMasterLooter())
end)

test("masterLooter names the looter from the raid index, and is nil when not master looter", function()
    local c, E = newClient()
    eq(c:masterLooter(), "Raidlead-Realm", "stub: raid index 1 is Raidlead")
    E.lootMethodId = 3; eq(c:masterLooter(), nil)
    local party = newClient(function(X)
        X.IsInRaid = function() return false end
        X.C_PartyInfo = { GetLootMethod = function() return 2, 2, nil end }
        X.UnitFullName = function(u) if u == "party2" then return "Mirel", "Other" end; return "Raidlead", "" end
    end)
    eq(party:masterLooter(), "Mirel-Other")
    local me = newClient(function(X)
        X.IsInRaid = function() return false end
        X.C_PartyInfo = { GetLootMethod = function() return 2, 0, nil end }
    end)
    eq(me:masterLooter(), "Raidlead-Realm", "party id 0 is the player")
end)

H.section("RealClient: loot")
test("loot window: only item slots, parsed item ids, candidates normalized", function()
    local c, E = newClient()
    eq(#c:lootSlots(), 0, "closed window has no slots")
    local opened
    c:on("loot.opened", function(p) opened = p.slots end)
    fire(E, "LOOT_OPENED")
    eq(#opened, 2); eq(opened[1].slot, 1); eq(opened[1].itemId, 1001); eq(opened[2].slot, 3); eq(opened[2].quality, 4)
    eq(table.concat(c:candidates(1), ","), "Raidlead-Realm,Mirel-Realm,Brann-Other")
    local _, why = c:candidates(2); eq(why, "gone")
end)
test("give maps a name to the candidate index and reports failures", function()
    local c, E = newClient()
    local _, early = c:give(1, "Mirel"); eq(early, "gone", "window not open yet")
    fire(E, "LOOT_OPENED")
    assert(c:give(1, "Mirel")); eq(E.given[1].slot, 1); eq(E.given[1].index, 2)
    assert(c:give(3, "Brann-Other")); eq(E.given[2].index, 3)
    local _, a = c:give(1, "Nobody"); eq(a, "notcandidate")
    E.lootMethodId = 3
    local _, b = c:give(1, "Mirel"); eq(b, "notml")
    fire(E, "LOOT_CLOSED")
    E.lootMethodId = 2
    local _, d = c:give(1, "Mirel"); eq(d, "gone")
end)
test("slot cleared and closed are forwarded", function()
    local c, E = newClient()
    local seen = {}
    c:on("loot.slotCleared", function(p) seen[#seen + 1] = "s" .. p.slot end)
    c:on("loot.closed", function() seen[#seen + 1] = "closed" end)
    fire(E, "LOOT_SLOT_CLEARED", 3); fire(E, "LOOT_CLOSED")
    eq(table.concat(seen, ","), "s3,closed")
end)
test("itemInfo translates the long return list, and is nil when uncached", function()
    local c = newClient()
    local i = c:itemInfo("item:1001"); eq(i.name, "Gauntlets"); eq(i.ilvl, 78); eq(i.equipLoc, "INVTYPE_HAND"); eq(i.class, 4)
    eq(c:itemInfo("item:9"), nil); eq(c:itemInfo(SECRET), nil)
end)
test("GET_ITEM_INFO_RECEIVED becomes item.info", function()
    local c, E = newClient()
    local got
    c:on("item.info", function(p) got = p end)
    fire(E, "GET_ITEM_INFO_RECEIVED", 1001)
    eq(got.itemId, 1001)
end)

H.section("RealClient: communication")
test("registerPrefix accepts Success and DuplicatePrefix only", function()
    local c, E = newClient()
    assert(c:registerPrefix("KG")); E.prefixResult = 1; assert(c:registerPrefix("KG")); E.prefixResult = 2; assert(not c:registerPrefix("KG"))
end)
test("send translates the result enum and pre-checks limits", function()
    local c, E = newClient()
    assert(c:send("KG", "hi", "RAID"))
    E.sendResult = 3; local _, a = c:send("KG", "hi", "RAID"); eq(a, "addonmessagethrottle")
    E.sendResult = 1; local _, b = c:send("KG", "hi", "RAID"); eq(b, "noprefix")
    E.sendResult = 0
    local _, t = c:send("KG", string.rep("x", 256), "RAID"); eq(t, "toolong")
    local _, ch = c:send("KG", "x", "SAY"); eq(ch, "badchannel")
    local _, n = c:send("KG", "x", "WHISPER"); eq(n, "notarget")
end)
test("restriction: send fails with 'restricted' and the change is announced", function()
    local c, E = newClient()
    local events = {}
    c:on("comms.restrictionChanged", function(p) events[#events + 1] = p.restricted end)
    E.restricted = true
    local ok, why = c:send("KG", "hi", "RAID"); assert(not ok); eq(why, "restricted")
    fire(E, "ADDON_RESTRICTION_STATE_CHANGED", 1, 1)
    E.restricted = false; fire(E, "ADDON_RESTRICTION_STATE_CHANGED", 1, 0)
    eq(table.concat({ tostring(events[1]), tostring(events[2]) }, ","), "true,false")
    assert(c:send("KG", "hi", "RAID"))
end)
test("incoming addon messages and whispers are normalized; secret senders are dropped", function()
    local c, E = newClient()
    local got, w = {}, {}
    c:on("comms.received", function(p) got[#got + 1] = p end)
    c:on("whisper.received", function(p) w[#w + 1] = p end)
    fire(E, "CHAT_MSG_ADDON", "KG", "payload", "RAID", "Mirel", "Raidlead")
    fire(E, "CHAT_MSG_ADDON", "KG", "payload", "RAID", SECRET, "Raidlead")
    fire(E, "CHAT_MSG_WHISPER", "need", "Tavi")
    eq(#got, 1); eq(got[1].sender, "Mirel-Realm"); eq(got[1].channel, "RAID"); eq(got[1].payload, "payload")
    eq(#w, 1); eq(w[1].sender, "Tavi-Realm")
end)
test("whisper and announce use SendChatMessage, and report lockdown", function()
    local c, E = newClient()
    assert(c:whisper("Tavi", "need?")); assert(c:announce("go", "RAID_WARNING"))
    eq(E.chat[1].kind, "WHISPER"); eq(E.chat[1].target, "Tavi"); eq(E.chat[2].kind, "RAID_WARNING")
    E.lockdown = true
    local ok, why = c:whisper("Tavi", "x"); assert(not ok); eq(why, "restricted")
end)
test("serialize round-trips over CBOR+base64, falls back to canonical text, rejects junk", function()
    local c = newClient()
    local v = { a = { 1, 2 }, b = "x:y" }
    local s = c:serialize(v); eq(s:sub(1, 1), "c")
    eq(Hash.Canon(c:deserialize(s)), Hash.Canon(v))
    local c2 = newClient(function(E) E.C_EncodingUtil = nil end)
    local s2 = c2:serialize(v); eq(s2:sub(1, 1), "k")
    eq(Hash.Canon(c2:deserialize(s2)), Hash.Canon(v))
    eq(c:deserialize("garbage"), nil); eq(c:deserialize(""), nil); eq(c:deserialize(nil), nil)
end)

H.section("RealClient: events and trade")
test("encounter end, world entered and roster/loot-method events are forwarded", function()
    local c, E = newClient()
    local seen = {}
    c:on("encounter.ended", function(p) seen[#seen + 1] = p.name .. ":" .. tostring(p.success) end)
    c:on("world.entered", function() seen[#seen + 1] = "world" end)
    c:on("roster.changed", function() seen[#seen + 1] = "roster" end)
    c:on("lootMethod.changed", function(p) seen[#seen + 1] = p.method end)
    fire(E, "ENCOUNTER_END", 5, "Boss", 1, 5, 1, {}); fire(E, "ENCOUNTER_END", 5, "Boss", 1, 5, 0, {})
    fire(E, "PLAYER_ENTERING_WORLD", false, false); fire(E, "GROUP_ROSTER_UPDATE"); fire(E, "PARTY_LOOT_METHOD_CHANGED")
    eq(table.concat(seen, ","), "Boss:true,Boss:false,world,roster,master")
end)
test("a completed trade is reported with the items", function()
    local c, E = newClient(function(E) E.UnitFullName = function(u) if u == "NPC" then return "Aldric", "" end; return "Raidlead", "" end end)
    local closed, changed
    c:on("trade.closed", function(p) closed = p end)
    c:on("trade.changed", function(p) changed = p end)
    fire(E, "TRADE_SHOW"); fire(E, "TRADE_PLAYER_ITEM_CHANGED", 1)
    eq(changed.trade.partner, "Aldric-Realm"); eq(#changed.trade.give, 1); eq(c:trade().partner, "Aldric-Realm")
    fire(E, "UI_INFO_MESSAGE", 1, "Trade complete."); fire(E, "TRADE_CLOSED")
    assert(closed.completed); eq(closed.partner, "Aldric-Realm"); eq(#closed.gave, 1); eq(c:trade(), nil)
    fire(E, "TRADE_SHOW"); fire(E, "TRADE_CLOSED"); eq(closed.completed, false)
end)
test("the frame registers events and records any the client refuses", function()
    local c, E = newClient()
    assert(E.frames[1].events.LOOT_OPENED and E.frames[1].events.CHAT_MSG_ADDON)
    eq(#c.unregistered, 0)
end)
test("a handler error is logged, not thrown", function()
    local c, E = newClient(function(E) E.GetNumLootItems = function() error("boom") end end)
    fire(E, "LOOT_OPENED")
    eq(#c.logs, 1); assert(c.logs[1].text:find("boom"))
end)
test("storage hands back the SavedVariables tables", function()
    local c, E = newClient()
    local s = c:storage(); s.account.x = 1
    eq(E.KingsGambitDB.x, 1); assert(E.KingsGambitCharDB.ui)
end)
