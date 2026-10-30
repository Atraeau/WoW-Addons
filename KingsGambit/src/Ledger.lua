-- King's Gambit: the ledger, v2 (docs/ledger-v2-design.md). Pure Lua.
--
-- A ledger is a STORE of chains, one per writer. Each chain is append-only and hash-chained, and only its
-- writer appends to it, so it can't fork. The VIEW (standings, authority, conflicts) is a replay of every
-- chain, in two passes:
--   1. authority events (Genesis, SetGuildMaster, SetOfficers, Elevate, Revoke, RaidClose) in order of the time
--      they were written, giving who was guild master and officer when, and every raid's final window;
--   2. list events (and Declined, ItemClasses) merged in SORT-KEY order, each checked against that authority at the time it
--      was written.
-- The sort key is when the loot became visible: an event may carry data.seen (the loot window's time); its key
-- is max(seen or ts, the key of the writer's previous event). So a raid that hands loot out at a break is
-- ordered by when its loot dropped, not when it was handed out, and a writer's own events never swap places.
--
-- Event: { v, ledger, chain, seq, prev, ts, author, type, list?, data, id }
--   chain  = author .. "#" .. epoch (8 hex, chosen when the chain starts)
--   ledger = id of the ledger's Genesis event ("" on the Genesis event itself)
--   id     = Hash(prev .. "|" .. Canon{v, ledger, chain, seq, ts, author, type, list, data})
-- Keep this file Lua 5.1-safe and 32-bit-integer safe.
local _, SK = ...
local Hash, Standings
local M = SK:NewModule("Ledger", { "Hash", "Standings" }, function(d) Hash, Standings = d.Hash, d.Standings end)

M.GENESIS = "0000000000000000"
M.VERSION = 2
M.SEEN_WINDOW = 24 * 3600 -- `seen` may be at most this long before the event was written

-- Event types that are not about one list. AUTHORITY ones are replayed in pass 1.
local GLOBAL = { Genesis = true, SetGuildMaster = true, SetOfficers = true, Elevate = true, Revoke = true,
    RaidClose = true, SetDisenchanter = true, Declined = true, ItemClasses = true, ItemSuits = true }
local AUTHORITY = { Genesis = true, SetGuildMaster = true, SetOfficers = true, Elevate = true, Revoke = true,
    RaidClose = true, SetDisenchanter = true }
M.GLOBAL, M.AUTHORITY = GLOBAL, AUTHORITY

local function eventId(ev)
    return Hash.Sum(ev.prev .. "|" .. Hash.Canon({
        v = ev.v, ledger = ev.ledger, chain = ev.chain, seq = ev.seq, ts = ev.ts,
        author = ev.author, type = ev.type, list = ev.list, data = ev.data,
    }))
end
M.EventId = eventId

-- A valid `seen` time for an event, or nil.
local function seenOf(ev)
    local s = type(ev.data) == "table" and ev.data.seen
    if type(s) == "number" and s <= ev.ts and s >= ev.ts - M.SEEN_WINDOW then return s end
end
M.SeenOf = seenOf

-- The sort key of an event that follows `prevKey` in its chain.
local function keyAfter(prevKey, ev)
    local k = seenOf(ev) or ev.ts
    if prevKey and prevKey > k then k = prevKey end
    return k
end

-- Write order (pass 1, and every authority question): time, then chain, then position. Two events written
-- in the same second are still strictly ordered, the same way on every machine.
local function byTs(a, b)
    if a.ts ~= b.ts then return a.ts < b.ts end
    if a.chain ~= b.chain then return a.chain < b.chain end
    return a.seq < b.seq
end
M.ByWrite = byTs

-- A stand-in event for "the end of second t" (after every real event written in that second).
local function moment(t) return { ts = t, chain = "\255", seq = math.huge } end

-- Order by sort key (pass 2). k = key of a, kb = key of b.
local function byKey(ka, a, kb, b)
    if ka ~= kb then return ka < kb end
    if a.chain ~= b.chain then return a.chain < b.chain end
    return a.seq < b.seq
end
M.ByKey = byKey

---------------------------------------------------------------- the store
function M.NewStore()
    return { id = nil, genesisChain = nil, chains = {}, byId = {}, keyOf = {} }
end

-- The sort key `ev` would get if appended now (it must be the next event of its chain).
function M.KeyFor(store, ev)
    local chain = store.chains[ev.chain]
    return keyAfter(chain and chain.lastKey, ev)
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
    local key = keyAfter(chain.lastKey, ev)
    chain.events[ev.seq] = ev
    chain.head, chain.lastTs, chain.lastKey = ev.id, ev.ts, key
    store.byId[ev.id] = ev
    store.keyOf[ev.id] = key
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
    for _, ev in ipairs(chain.events) do
        store.byId[ev.id] = nil
        store.keyOf[ev.id] = nil
    end
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

-- Every event of every chain, in sort-key order (the order list events are replayed in).
function M.Merged(store)
    local all = {}
    for _, chain in pairs(store.chains) do
        for _, ev in ipairs(chain.events) do all[#all + 1] = ev end
    end
    local keys = store.keyOf
    table.sort(all, function(a, b) return byKey(keys[a.id], a, keys[b.id], b) end)
    return all
end

---------------------------------------------------------------- authority (pass 1)
local function isName(v) return type(v) == "string" and v ~= "" end

-- The authority state as pass 1 builds it. `history` records every change so pass 2 can ask
-- "who was an officer at time t?".
local function newAuth()
    return { gm = nil, officers = {}, raids = {}, history = {} }
end

local function snapshotOfficers(a)
    local copy = {}
    for k, v in pairs(a.officers) do copy[k] = v end
    return copy
end

local function record(a, ev)
    a.history[#a.history + 1] = { ev = ev, gm = a.gm, officers = snapshotOfficers(a) }
end

-- Guild master and officers in effect for event `e` (after every authority event written before it).
local function rolesAt(a, e)
    local gm, officers = nil, {}
    for _, h in ipairs(a.history) do
        if not byTs(h.ev, e) then break end
        gm, officers = h.gm, h.officers
    end
    return gm, officers
end

local function isOfficerNow(a, name) return name ~= nil and (name == a.gm or a.officers[name] == true) end

local function isOfficerAt(a, name, e)
    local gm, officers = rolesAt(a, e)
    return name ~= nil and (name == gm or officers[name] == true), gm
end

-- During pass 1 (events arrive in write order): has the raid already ended for this authority event?
local function raidOver(r, ev) return r.endEv ~= nil or ev.ts >= r.expires end

-- Is raid r active for event e (written after it opened, before it ended, and before it expired)?
local function activeFor(r, e)
    return byTs(r.startEv, e) and e.ts < r.expires and (r.endEv == nil or byTs(e, r.endEv))
end

-- Raids active for event e (using every raid's final window).
local function activeRaids(a, e)
    local out = {}
    for _, r in pairs(a.raids) do
        if activeFor(r, e) then out[#out + 1] = r end
    end
    table.sort(out, function(x, y) return x.id < y.id end)
    return out
end

-- May `author` write an ordinary (list or Declined) event `e`?
local function mayWrite(a, author, e)
    local t = e
    local officer, gm = isOfficerAt(a, author, t)
    if not gm then return nil, "noledger" end
    local active = activeRaids(a, t)
    for _, r in ipairs(active) do
        if r.ml == author then return true end
    end
    if officer then
        if #active == 0 then return true end
        return nil, "duringraid"
    end
    for _, r in pairs(a.raids) do
        if r.ml == author then return nil, "expired" end
    end
    return nil, "notauthorized"
end

-- Questions asked "as of the end of second t" (for the interface; replay asks per event).
M.ActiveRaids = function(view, t) return activeRaids(view.auth, moment(t)) end
M.IsOfficer = function(view, name) return isOfficerNow(view.auth, name) end
M.MayWrite = function(view, author, t) return mayWrite(view.auth, author, moment(t)) end

-- Authority events, applied in write-time order: each returns a commit function, or nil + reason.
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
    if not isOfficerNow(a, ev.author) then return nil, "notofficer" end
    if not (isName(d.raid) and isName(d.ml)) then return nil, "badraid" end
    if type(d.minutes) ~= "number" or d.minutes <= 0 or d.minutes > 24 * 60 then return nil, "badminutes" end
    local untilT = ev.ts + math.floor(d.minutes * 60)
    local r = a.raids[d.raid]
    if r then
        if raidOver(r, ev) then return nil, "raidended" end
        if r.ml ~= d.ml then return nil, "raidbusy" end
        return function() if untilT > r.expires then r.expires = untilT end end
    end
    return function()
        a.raids[d.raid] = { id = d.raid, ml = d.ml, start = ev.ts, startEv = ev, expires = untilT, by = ev.author }
    end
end

function auth.Revoke(a, ev, d)
    if not isOfficerNow(a, ev.author) then return nil, "notofficer" end
    local r = a.raids[d.raid]
    if not r or raidOver(r, ev) then return nil, "notactive" end
    return function() r.ended, r.endEv = ev.ts, ev end
end

function auth.RaidClose(a, ev, d)
    local r = a.raids[d.raid]
    if not r or raidOver(r, ev) then return nil, "notactive" end
    if ev.author ~= r.ml then return nil, "notml" end
    return function() r.ended, r.endEv = ev.ts, ev end
end

-- The raid's Master Looter designates who disenchants what nobody wants, for this raid. The latest choice stands;
-- the Master Looter may change it while the raid is active.
function auth.SetDisenchanter(a, ev, d)
    local r = a.raids[d.raid]
    if not r or raidOver(r, ev) then return nil, "notactive" end
    if ev.author ~= r.ml then return nil, "notml" end
    if not isName(d.name) then return nil, "badname" end
    return function() r.disenchanter, r.disenchanterEv = d.name, ev end
end

---------------------------------------------------------------- the view
function M.NewView()
    return {
        lists = {},        -- [listId] = Standings state
        auth = newAuth(),  -- final authority state, plus history for "as of time t" questions
        conflicts = {},    -- { id, chain, author, type, list, reason, ts }
        applied = {},      -- list events (and Declined) applied, in sort-key order
        authApplied = {},  -- authority events applied, in write-time order
        declined = {},     -- recorded declined adjustment requests
        itemRules = {},    -- [itemId] = { classes (nil = any class), by, ts, reason, id }: the guild's eligibility rules
        itemSuits = {},    -- [itemId] = { roles, by, ts, reason, id }: officers' overrides of who an item suits
        last = nil,        -- the last pass-2 event considered (applied or skipped), and its key
        lastKey = nil,
    }
end

-- A guild rule for who may bid on an item: { item = item id, classes = { "PRIEST", ... } (empty = any class), reason }.
local CLASS_TOKENS = { WARRIOR = true, PALADIN = true, HUNTER = true, ROGUE = true, PRIEST = true, SHAMAN = true, MAGE = true,
    WARLOCK = true, DRUID = true }
local function itemRule(d)
    if type(d.item) ~= "number" or d.item < 1 or d.item ~= math.floor(d.item) then return nil end
    if type(d.classes) ~= "table" or not isName(d.reason) then return nil end
    local seen = {}
    for _, c in ipairs(d.classes) do
        if not CLASS_TOKENS[c] or seen[c] then return nil end
        seen[c] = true
    end
    return true
end

-- An officer's override of the fit heuristic: { item, roles = { "healer", ... } (empty = back to the heuristic), reason }.
local ROLES = { tank = true, melee = true, hunter = true, caster = true, healer = true }
local function itemSuits(d)
    if type(d.item) ~= "number" or d.item < 1 or d.item ~= math.floor(d.item) then return nil end
    if type(d.roles) ~= "table" or not isName(d.reason) then return nil end
    local seen = {}
    for _, r in ipairs(d.roles) do
        if not ROLES[r] or seen[r] then return nil end
        seen[r] = true
    end
    return true
end

local function conflict(view, ev, why)
    view.conflicts[#view.conflicts + 1] = { id = ev.id, chain = ev.chain, author = ev.author, type = ev.type,
        list = ev.list, reason = why, ts = ev.ts }
end

-- Pass 1 step: one authority event, in write-time order.
local function applyAuthority(view, ev)
    local a = view.auth
    local commit, why
    if ev.type ~= "Genesis" and not a.gm then
        why = "noledger"
    else
        commit, why = auth[ev.type](a, ev, ev.data)
    end
    if not commit then conflict(view, ev, why); return nil, why end
    commit()
    record(a, ev)
    view.authApplied[#view.authApplied + 1] = ev
    view.lastAuth = ev
    return true
end

-- Pass 2 step: one list event (or Declined), in sort-key order. Returns true, or nil + reason, in which case
-- the event is recorded as a conflict and skipped (it stays in its chain).
function M.ApplyToView(view, ev, key)
    view.last, view.lastKey = ev, key
    local ok, why = mayWrite(view.auth, ev.author, ev)
    if ok and ev.data and ev.data.seen ~= nil and not seenOf(ev) then ok, why = nil, "badseen" end
    if ok then
        if ev.type == "Declined" then
            local d = ev.data
            if not (isName(d.requestedBy) and isName(d.request) and isName(d.declineReason)) then
                ok, why = nil, "baddecline"
            else
                view.declined[#view.declined + 1] = ev
            end
        elseif ev.type == "ItemClasses" then
            local d = ev.data
            if not itemRule(d) then
                ok, why = nil, "baditemrule"
            else
                local classes
                if #d.classes > 0 then
                    classes = {}
                    for i, c in ipairs(d.classes) do classes[i] = c end
                end
                view.itemRules[d.item] = { classes = classes, by = ev.author, ts = ev.ts, reason = d.reason, id = ev.id }
            end
        elseif ev.type == "ItemSuits" then
            local d = ev.data
            if not itemSuits(d) then
                ok, why = nil, "baditemsuits"
            elseif #d.roles == 0 then
                view.itemSuits[d.item] = nil
            else
                local roles = {}
                for i, r in ipairs(d.roles) do roles[i] = r end
                view.itemSuits[d.item] = { roles = roles, by = ev.author, ts = ev.ts, reason = d.reason, id = ev.id }
            end
        elseif not isName(ev.list) then
            ok, why = nil, "nolist"
        else
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
    conflict(view, ev, why)
    return nil, why
end

-- Replay the whole store into a fresh view. `extra` (optional) is one more event, not yet in the store,
-- appended to its chain for this replay only (used to check a write before making it).
function M.View(store, extra)
    local view = M.NewView()
    local all, keys = {}, {}
    for _, chain in pairs(store.chains) do
        for _, ev in ipairs(chain.events) do
            all[#all + 1] = ev
            keys[ev] = store.keyOf[ev.id]
        end
    end
    if extra then
        all[#all + 1] = extra
        keys[extra] = M.KeyFor(store, extra)
    end
    local authority, rest = {}, {}
    for _, ev in ipairs(all) do
        if AUTHORITY[ev.type] then authority[#authority + 1] = ev else rest[#rest + 1] = ev end
    end
    table.sort(authority, byTs)
    for _, ev in ipairs(authority) do applyAuthority(view, ev) end
    table.sort(rest, function(a, b) return byKey(keys[a], a, keys[b], b) end)
    for _, ev in ipairs(rest) do M.ApplyToView(view, ev, keys[ev]) end
    return view
end

-- Can `ev` (sorting after everything already applied, and not an authority event) be applied on top of
-- `view` directly, without a full replay?
function M.Appendable(view, store, ev)
    if AUTHORITY[ev.type] then return false end
    if not view.last then return true end
    return byKey(view.lastKey, view.last, M.KeyFor(store, ev), ev)
end

-- Did the replay accept event `id`? (true, or nil + the conflict reason)
function M.Accepted(view, id)
    for i = #view.conflicts, 1, -1 do
        if view.conflicts[i].id == id then return nil, view.conflicts[i].reason end
    end
    return true
end
