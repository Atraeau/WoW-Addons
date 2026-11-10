-- King's Gambit: RealClient (the Client for the actual game), addon messages and whispers: prefixes, sending, the chat filter, and their events. Keep this file Lua 5.1-safe.
-- RealClient.New builds the shared pieces (see client/RealClient.lua) and calls Install here, which adds these to the client `c`.
local _, SK = ...
local Hash
local M = SK:NewModule("RealChat", { "Hash" }, function(d) Hash = d.Hash end)

-- c: the client being built; h: the helpers RealClient.New shares (and what the earlier files exported).
function M.Install(c, h)
    local E, bus, safe, fromGame, toGame, handlers, enumName, CHANNELS = h.E, h.bus, h.safe, h.fromGame, h.toGame, h.handlers, h.enumName, h.CHANNELS

    ---------------------------------------------------------------- communication
    function c:registerPrefix(prefix)
        local result = E.C_ChatInfo.RegisterAddonMessagePrefix(prefix)
        local name = enumName(E.Enum and E.Enum.RegisterAddonMessagePrefixResult, result)
        return result == nil or name == "Success" or name == "DuplicatePrefix" or result == true
    end


    function c:send(prefix, payload, channel, target)
        if not self.caps.comms then return false, "nocomms" end
        if type(payload) ~= "string" then return false, "badpayload" end
        if #payload > self.maxMessage then return false, "toolong" end
        if not CHANNELS[channel] then return false, "badchannel" end
        if channel == "WHISPER" and not target then return false, "notarget" end
        -- The game's own answer decides, not the restriction flag: on Forever AreOutgoingAddonChatMessagesRestricted() is true yet the game takes the
        -- message (the self-check's raw sends: WHISPER and GUILD "Success"), and Gargul and BigWigs likewise just send and read the result. During a boss
        -- fight or similar the game answers AddOnMessageLockdown, which is "restricted": queued and retried by the sync layer.
        local result = E.C_ChatInfo.SendAddonMessage(prefix, payload, channel, channel == "WHISPER" and toGame(target) or target)
        local name = enumName(E.Enum and E.Enum.SendAddonMessageResult, result)
        if result == true or result == nil or name == "Success" then return true end
        local reason = (name or tostring(result)):lower()
        if reason == "invalidprefix" then reason = "noprefix" end
        if reason == "addonmessagelockdown" then reason = "restricted" end
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

-- Keep whispers with some players out of the chat window while a loot session answers them (the addon reads and replies; the Master Looter sees a count at
-- the end instead). `isMuted(name)` says who; nil stops it. Both directions: what they send, and our replies to them.
function c:muteWhispers(isMuted)
    c.muted = isMuted
    if c.muteInstalled then return end
    local add = E.ChatFrame_AddMessageEventFilter or _G.ChatFrame_AddMessageEventFilter
    if type(add) ~= "function" then return end
    local function filter(_, _, msg, sender, ...)
        if c.muted and sender and c.muted(fromGame(sender)) then return true end
        return false, msg, sender, ...
    end
    pcall(add, "CHAT_MSG_WHISPER", filter)
    pcall(add, "CHAT_MSG_WHISPER_INFORM", filter)
    c.muteInstalled = true
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
end
