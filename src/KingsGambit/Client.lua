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
    "lootMethod", "isMasterLooter", "masterLooter", "lootSlots", "candidates", "give", "itemInfo",
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
    "item.info", "comms.restrictionChanged",
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

-- Shared event dispatch for every Client implementation (Mock, Real, Sim).
-- on() returns an unsubscribe function; unknown event names are errors.
function M.NewBus()
    local handlers = {}
    local bus = {}
    function bus.on(event, fn)
        assert(M.IsEvent(event), "unknown client event: " .. tostring(event))
        local list = handlers[event]
        if not list then list = {}; handlers[event] = list end
        local entry = { fn = fn, active = true }
        list[#list + 1] = entry
        return function() entry.active = false end
    end
    function bus.emit(event, payload)
        assert(M.IsEvent(event), "unknown client event: " .. tostring(event))
        local list = handlers[event]
        if not list then return end
        local snapshot = {}
        for i, e in ipairs(list) do snapshot[i] = e end
        for _, e in ipairs(snapshot) do
            if e.active then e.fn(payload) end
        end
    end
    function bus.clear() handlers = {} end
    return bus
end
