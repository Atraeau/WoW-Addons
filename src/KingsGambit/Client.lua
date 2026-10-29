-- King's Gambit: the Client contract (Phase 1.5).
-- The Client is the only way the engine touches the WoW API. This file lists what a Client
-- must provide so RealClient, MockClient and SimClient can be checked against the same contract.
-- Design: docs/kings-gambit/client-interface.md
local _, SK = ...
local M = SK:NewModule("Client")

-- Methods are called with a colon: client:now(), client:send(...).
M.METHODS = {
    -- time and randomness
    "now", "serverTime", "after", "every", "cancel", "random",
    -- identity and roster
    "me", "normalize", "inGroup", "inRaid", "roster", "rankOf", "guildRoster",
    -- loot
    "lootMethod", "isMasterLooter", "lootSlots", "candidates", "give", "itemInfo",
    -- communication
    "registerPrefix", "send", "pending", "whisper", "announce", "serialize", "deserialize",
    -- trade
    "trade", "tradeableUntil",
    -- environment and storage
    "storage", "playSound", "print", "log",
    -- events
    "on",
}

M.EVENTS = {
    "roster.changed", "lootMethod.changed",
    "loot.opened", "loot.slotCleared", "loot.closed",
    "comms.received", "whisper.received",
    "trade.changed", "trade.closed",
    "encounter.ended", "world.entered",
    "item.info",
}

local eventSet = {}
for _, e in ipairs(M.EVENTS) do eventSet[e] = true end

function M.IsEvent(name) return eventSet[name] == true end

-- Names a client is missing from the contract (empty list = conforms).
function M.Missing(client)
    local missing = {}
    for _, name in ipairs(M.METHODS) do
        if type(client[name]) ~= "function" then missing[#missing + 1] = name end
    end
    if type(client.caps) ~= "table" then missing[#missing + 1] = "caps" end
    if type(client.maxMessage) ~= "number" then missing[#missing + 1] = "maxMessage" end
    return missing
end
