-- King's Gambit: the ledger, v2 (docs/kings-gambit/ledger-v2-design.md). Pure Lua.
--
-- A ledger is a STORE of chains, one per writer. Each chain is append-only and hash-chained, and only its
-- writer appends to it, so it can't fork. The VIEW (standings, authority, conflicts) is the replay of every
-- chain's events merged in one deterministic order: time, then chain id, then position in the chain.
--
-- Event: { v, ledger, chain, seq, prev, ts, author, type, list?, data, id }
--   chain  = author .. "#" .. epoch (8 hex, chosen when the chain starts)
--   ledger = id of the ledger's Genesis event ("" on the Genesis event itself)
--   id     = Hash(prev .. "|" .. Canon{v, ledger, chain, seq, ts, author, type, list, data})
-- Keep this file Lua 5.1-safe and 32-bit-integer safe.
local _, SK = ...
local M = SK:NewModule("Ledger")
local Hash = SK.modules.Hash
local Standings = SK.modules.Standings

M.GENESIS = "0000000000000000"
M.VERSION = 2

-- Event types that are not about one list.
local GLOBAL = { Genesis = true, SetGuildMaster = true, SetOfficers = true, Elevate = true, Revoke = true,
    RaidClose = true, Declined = true }
M.GLOBAL = GLOBAL

local function eventId(ev)
    return Hash.Sum(ev.prev .. "|" .. Hash.Canon({
        v = ev.v, ledger = ev.ledger, chain = ev.chain, seq = ev.seq, ts = ev.ts,
        author = ev.author, type = ev.type, list = ev.list, data = ev.data,
    }))
end
M.EventId = eventId

-- Merge order: true if event a comes before event b.
local function before(a, b)
    if a.ts ~= b.ts then return a.ts < b.ts end
    if a.chain ~= b.chain then return a.chain < b.chain end
    return a.seq < b.seq
end
M.Before = before

---------------------------------------------------------------- the store
function M.NewStore()
    return { id = nil, genesisChain = nil, chains = {}, byId = {} }
end

-- Validate and add an event to its chain. Returns "appended" | "duplicate", or nil + reason:
--   malformed, badversion, badchain, badhash, wrongledger, noledger, badgenesis, gap, fork, timetravel
-- trustHash skips recomputing the hash (lazy loading of large saved chains; see VerifyStep).
function M.Receive(store, ev, trustHash)
    if type(ev) ~= "table" or type(ev.id) ~= "string" or type(ev.seq) ~= "number" or type(ev.prev) ~= "string"
        or type(ev.data) ~= "table" or type(ev.chain) ~= "string" or type(ev.author) ~= "string"
        or type(ev.ts) ~= "number" or type(ev.type) ~= "string" or type(ev.ledger) ~= "string" then
        return nil, "malformed"
    end
    if store.byId[ev.id] then return "duplicate" end
    if ev.v ~= M.VERSION then return nil, "badversion" end
    if ev.chain:sub(1, #ev.author + 1) ~= ev.author .. "#" or #ev.chain ~= #ev.author + 9 then return nil, "badchain" end
    if not trustHash then
        local okHash, id = pcall(eventId, ev)
        if not okHash or id ~= ev.id then return nil, "badhash" end
    end

    if ev.type == "Genesis" then
        if ev.seq ~= 1 or ev.ledger ~= "" then return nil, "badgenesis" end
        if store.id and store.id ~= ev.id then return nil, "wrongledger" end
    else
        if not store.id then return nil, "noledger" end
        if ev.ledger ~= store.id then return nil, "wrongledger" end
    end

    local chain = store.chains[ev.chain]
    local n = chain and #chain.events or 0
    if ev.seq > n + 1 then return nil, "gap" end
    if ev.seq <= n or ev.prev ~= (chain and chain.head or M.GENESIS) then return nil, "fork" end
    if chain and chain.lastTs and ev.ts < chain.lastTs then return nil, "timetravel" end

    if not chain then
        chain = { id = ev.chain, author = ev.author, events = {}, head = M.GENESIS }
        store.chains[ev.chain] = chain
    end
    chain.events[ev.seq] = ev
    chain.head, chain.lastTs = ev.id, ev.ts
    store.byId[ev.id] = ev
    if ev.type == "Genesis" then store.id, store.genesisChain = ev.id, ev.chain end
    return "appended"
end

-- Build an event at the tip of `chainId` (not yet received).
function M.Build(store, chainId, author, type_, data, ts, list)
    local chain = store.chains[chainId]
    local ev = { v = M.VERSION, ledger = (type_ == "Genesis") and "" or (store.id or ""), chain = chainId,
        seq = chain and (#chain.events + 1) or 1, prev = chain and chain.head or M.GENESIS,
        ts = ts, author = author, type = type_, list = list, data = data or {} }
    local okHash, id = pcall(eventId, ev)
    if not okHash then return nil, "malformed" end
    ev.id = id
    return ev
end

function M.DropChain(store, cid)
    local chain = store.chains[cid]
    if not chain then return end
    for _, ev in ipairs(chain.events) do store.byId[ev.id] = nil end
    store.chains[cid] = nil
    if store.genesisChain == cid then store.id, store.genesisChain = nil, nil end
end

-- Load saved chains, verifying links, times and (for chains up to verifyLimit events) hashes. The Genesis
-- chain goes first. saved = { chains = { [chainId] = { events = {...} } } }.
-- Returns store, problems ({ [chainId] = {reason, index} }), lazy ({ [chainId] = chain } still to hash-check).
function M.LoadStore(saved, verifyLimit)
    local store, problems, lazy = M.NewStore(), {}, {}
    local chains = (saved and saved.chains) or {}
    local function isGenesis(cid)
        local e = chains[cid].events and chains[cid].events[1]
        return type(e) == "table" and e.type == "Genesis"
    end
    local ids = {}
    for cid in pairs(chains) do ids[#ids + 1] = cid end
    table.sort(ids, function(a, b)
        local ga, gb = isGenesis(a), isGenesis(b)
        if ga ~= gb then return ga end
        return a < b
    end)
    for _, cid in ipairs(ids) do
        local events = chains[cid].events or {}
        local fast = verifyLimit ~= nil and #events > verifyLimit
        for i, ev in ipairs(events) do
            local status, err = M.Receive(store, ev, fast)
            if status == "appended" and ev.chain ~= cid then status, err = nil, "badchain" end
            if status ~= "appended" then
                problems[cid] = { reason = err or status, index = i }
                M.DropChain(store, cid)
                break
            end
        end
        if fast and not problems[cid] and store.chains[cid] then
            store.chains[cid].verified = 0
            lazy[cid] = store.chains[cid]
        end
    end
    return store, problems, lazy
end

-- Recompute the hashes of the next `count` unverified events of a lazily loaded chain.
-- Returns "more", "done", or "bad" plus the index of the first bad event.
function M.VerifyStep(chain, count)
    local from = (chain.verified or #chain.events) + 1
    local to = math.min(from + count - 1, #chain.events)
    for i = from, to do
        local ev = chain.events[i]
        local ok, id = pcall(eventId, ev)
        if not ok or id ~= ev.id then return "bad", i end
    end
    chain.verified = to
    return (to >= #chain.events) and "done" or "more"
end

-- One fingerprint for the whole ledger: equal fingerprints mean identical histories.
function M.Fingerprint(store)
    local ids = {}
    for cid in pairs(store.chains) do ids[#ids + 1] = cid end
    table.sort(ids)
    local list = {}
    for i, cid in ipairs(ids) do list[i] = { cid, #store.chains[cid].events, store.chains[cid].head } end
    return Hash.Sum(Hash.Canon(list))
end

-- Every event of every chain, in merge order.
function M.Merged(store)
    local all = {}
    for _, chain in pairs(store.chains) do
        for _, ev in ipairs(chain.events) do all[#all + 1] = ev end
    end
    table.sort(all, before)
    return all
end

---------------------------------------------------------------- the view (replay + authority)
function M.NewView()
    return {
        lists = {},      -- [listId] = Standings state
        auth = { gm = nil, officers = {}, raids = {} },
        conflicts = {},  -- { id, chain, author, type, list, reason, ts }
        applied = {},    -- events applied, in merge order
        declined = {},   -- recorded declined adjustment requests
        last = nil,      -- the last event considered (applied or skipped)
    }
end

local function isName(v) return type(v) == "string" and v ~= "" end
local function isOfficer(a, name) return name ~= nil and (name == a.gm or a.officers[name] == true) end

-- Raids active at time t. raid = { id, ml, start, expires, ended, by }
local function activeRaids(a, t)
    local out = {}
    for _, r in pairs(a.raids) do
        if r.start <= t and t < r.expires and (not r.ended or t < r.ended) then out[#out + 1] = r end
    end
    table.sort(out, function(x, y) return x.id < y.id end)
    return out
end

-- May `author` write an ordinary (list or Declined) event at time t?
local function mayWrite(a, author, t)
    local active = activeRaids(a, t)
    for _, r in ipairs(active) do
        if r.ml == author then return true end
    end
    if isOfficer(a, author) then
        if #active == 0 then return true end
        return nil, "duringraid"
    end
    for _, r in pairs(a.raids) do
        if r.ml == author then return nil, "expired" end
    end
    return nil, "notauthorized"
end

M.ActiveRaids = function(view, t) return activeRaids(view.auth, t) end
M.IsOfficer = function(view, name) return isOfficer(view.auth, name) end
M.MayWrite = function(view, author, t) return mayWrite(view.auth, author, t) end

local function raidOver(r, t) return (r.ended and r.ended <= t) or t >= r.expires end

-- Authority events: each returns a commit function, or nil + reason.
local auth = {}

function auth.Genesis(a, ev, d)
    if a.gm then return nil, "alreadygenesis" end
    if not isName(d.name) then return nil, "badname" end
    return function() a.gm = ev.author end
end

function auth.SetGuildMaster(a, ev, d)
    if ev.author ~= a.gm then return nil, "notguildmaster" end
    if not isName(d.name) then return nil, "badname" end
    return function() a.gm = d.name end
end

function auth.SetOfficers(a, ev, d)
    if ev.author ~= a.gm then return nil, "notguildmaster" end
    if type(d.names) ~= "table" then return nil, "badnames" end
    for _, n in ipairs(d.names) do
        if not isName(n) then return nil, "badnames" end
    end
    return function()
        a.officers = {}
        for _, n in ipairs(d.names) do a.officers[n] = true end
    end
end

function auth.Elevate(a, ev, d)
    if not isOfficer(a, ev.author) then return nil, "notofficer" end
    if not (isName(d.raid) and isName(d.ml)) then return nil, "badraid" end
    if type(d.minutes) ~= "number" or d.minutes <= 0 or d.minutes > 24 * 60 then return nil, "badminutes" end
    local untilT = ev.ts + math.floor(d.minutes * 60)
    local r = a.raids[d.raid]
    if r then
        if raidOver(r, ev.ts) then return nil, "raidended" end
        if r.ml ~= d.ml then return nil, "raidbusy" end
        return function() if untilT > r.expires then r.expires = untilT end end
    end
    return function() a.raids[d.raid] = { id = d.raid, ml = d.ml, start = ev.ts, expires = untilT, by = ev.author } end
end

function auth.Revoke(a, ev, d)
    if not isOfficer(a, ev.author) then return nil, "notofficer" end
    local r = a.raids[d.raid]
    if not r or raidOver(r, ev.ts) then return nil, "notactive" end
    return function() r.ended = ev.ts end
end

function auth.RaidClose(a, ev, d)
    local r = a.raids[d.raid]
    if not r or raidOver(r, ev.ts) then return nil, "notactive" end
    if ev.author ~= r.ml then return nil, "notml" end
    return function() r.ended = ev.ts end
end

-- A declined adjustment request: no effect on standings; recorded for transparency.
function auth.Declined(a, ev, d)
    local ok, why = mayWrite(a, ev.author, ev.ts)
    if not ok then return nil, why end
    if not (isName(d.requestedBy) and isName(d.request) and isName(d.declineReason)) then return nil, "baddecline" end
    return function() end
end

-- Apply one event to a view. Events must arrive in merge order. Returns true, or nil + reason, in which
-- case the event is recorded as a conflict and skipped (it stays in its chain).
function M.ApplyToView(view, ev)
    view.last = ev
    local ok, why
    if GLOBAL[ev.type] then
        local commit
        if ev.type ~= "Genesis" and not view.auth.gm then
            why = "noledger"
        else
            commit, why = auth[ev.type](view.auth, ev, ev.data)
        end
        if commit then
            commit()
            if ev.type == "Declined" then view.declined[#view.declined + 1] = ev end
            ok = true
        end
    elseif not view.auth.gm then
        why = "noledger"
    elseif not isName(ev.list) then
        why = "nolist"
    else
        ok, why = mayWrite(view.auth, ev.author, ev.ts)
        if ok then
            local s = view.lists[ev.list]
            local fresh = false
            if not s then
                if ev.type == "CreateList" then s, fresh = Standings.New(), true else ok, why = nil, "nolist" end
            end
            if ok then
                ok, why = Standings.Apply(s, ev)
                if ok and fresh then view.lists[ev.list] = s end
            end
        end
    end
    if ok then
        view.applied[#view.applied + 1] = ev
        return true
    end
    view.conflicts[#view.conflicts + 1] = { id = ev.id, chain = ev.chain, author = ev.author, type = ev.type,
        list = ev.list, reason = why, ts = ev.ts }
    return nil, why
end

-- Replay the whole store into a fresh view.
function M.View(store)
    local view = M.NewView()
    for _, ev in ipairs(M.Merged(store)) do M.ApplyToView(view, ev) end
    return view
end

-- Would `ev` be accepted if appended after everything in the store? Uses a throwaway replay, so nothing
-- changes. Returns true, or nil + reason.
function M.Check(store, ev)
    local probe = M.View(store)
    if probe.last and not before(probe.last, ev) then return nil, "outoforder" end
    return M.ApplyToView(probe, ev)
end
