-- King's Gambit: append-only, hash-chained event log per list (Phase 1).
--
-- Event: { v, list, seq, prev, ts, author, type, data, id }
--   id = Hash(prev .. "|" .. Canon{v,list,seq,ts,author,type,data})
-- Each event commits to its predecessor, so the head id fingerprints the whole history.
-- Receive() is the only way events enter a chain (local Append builds then Receives),
-- so local and remote events pass identical validation. Idempotent by event id.
local _, SK = ...
local M = SK:NewModule("Ledger")
local Hash = SK.modules.Hash
local Standings = SK.modules.Standings

M.GENESIS = "0000000000000000"
M.VERSION = 1

local function eventId(ev)
    return Hash.Sum(ev.prev .. "|" .. Hash.Canon({
        v = ev.v, list = ev.list, seq = ev.seq, ts = ev.ts,
        author = ev.author, type = ev.type, data = ev.data,
    }))
end
M.EventId = eventId

function M.NewChain(listId)
    return { list = listId, events = {}, byId = {}, head = M.GENESIS, state = Standings.New() }
end

-- Validate and add an event. Returns "appended" | "duplicate", or nil + reason:
--   malformed, wronglist, badversion, badhash, gap (missing earlier events),
--   fork (same slot, different history), or a Standings rejection reason.
function M.Receive(chain, ev)
    if type(ev) ~= "table" or type(ev.id) ~= "string" or type(ev.seq) ~= "number"
        or type(ev.prev) ~= "string" or type(ev.data) ~= "table" then
        return nil, "malformed"
    end
    if chain.byId[ev.id] then return "duplicate" end
    if ev.list ~= chain.list then return nil, "wronglist" end
    if ev.v ~= M.VERSION then return nil, "badversion" end
    local okHash, id = pcall(eventId, ev)
    if not okHash or id ~= ev.id then return nil, "badhash" end
    local n = #chain.events
    if ev.seq > n + 1 then return nil, "gap" end
    if ev.seq <= n or ev.prev ~= chain.head then return nil, "fork" end
    local ok, err = Standings.Apply(chain.state, ev)
    if not ok then return nil, err end
    chain.events[ev.seq] = ev
    chain.byId[ev.id] = ev
    chain.head = ev.id
    return "appended"
end

-- Author a new event on top of the chain head.
function M.Append(chain, type_, data, author, ts)
    local ev = { v = M.VERSION, list = chain.list, seq = #chain.events + 1, prev = chain.head,
        ts = ts, author = author, type = type_, data = data or {} }
    local okHash, id = pcall(eventId, ev)
    if not okHash then return nil, "malformed" end
    ev.id = id
    local status, err = M.Receive(chain, ev)
    if status ~= "appended" then return nil, err end
    return ev
end

-- Rebuild a chain from stored events, verifying every hash and rule.
-- Returns chain, or nil + reason + index of the first bad event.
function M.Load(listId, events)
    local chain = M.NewChain(listId)
    for i, ev in ipairs(events) do
        local status, err = M.Receive(chain, ev)
        if status ~= "appended" then return nil, err or status, i end
    end
    return chain
end

