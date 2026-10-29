-- King's Gambit: the Host contract (Phase 1.5).
-- The Host is the only way the engine touches the WoW API. This file lists what a Host
-- must provide so RealHost, MockHost and SimHost can be checked against the same contract.
-- Design: docs/kings-gambit/host-interface.md
local _, SK = ...
local M = SK:NewModule("Host")

-- Methods are called with a colon: host:now(), host:send(...).
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

-- Names a host is missing from the contract (empty list = conforms).
function M.Missing(host)
    local missing = {}
    for _, name in ipairs(M.METHODS) do
        if type(host[name]) ~= "function" then missing[#missing + 1] = name end
    end
    if type(host.caps) ~= "table" then missing[#missing + 1] = "caps" end
    if type(host.maxMessage) ~= "number" then missing[#missing + 1] = "maxMessage" end
    return missing
end
