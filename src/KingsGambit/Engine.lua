-- King's Gambit: an engine owns the ledger (a store of per-writer chains plus its replayed view) and talks
-- to the WoW client only through a Client. No module-level state: tests and training can run many engines
-- in one process. Design: docs/kings-gambit/ledger-v2-design.md
local _, SK = ...
local Ledger
local M = SK:NewModule("Engine", { "Ledger" }, function(d) Ledger = d.Ledger end)

local Engine = {}
Engine.__index = Engine

local HEX = "0123456789abcdef"

-- opts.syncVerifyLimit (default 2000): chains up to this many events are hash-verified at load; longer
-- ones are verified in the background (see verifyTick). opts.verifyBatch: events per background tick.
function M.New(client, opts)
    local acct = client:storage().account
    acct.schema = 2
    acct.ledger = acct.ledger or { chains = {} }
    acct.ledger.chains = acct.ledger.chains or {}
    acct.mine = acct.mine or {}
    acct.config = acct.config or {}
    local e = setmetatable({ client = client, db = acct, hooks = {}, problems = {},
        verifyBatch = (opts and opts.verifyBatch) or 100 }, Engine)
    local store, problems, lazy = Ledger.LoadStore(acct.ledger, (opts and opts.syncVerifyLimit) or 2000)
    e.store, e.problems, e.verifying = store, problems, lazy
    for cid, chain in pairs(store.chains) do acct.ledger.chains[cid] = { events = chain.events } end
    for cid, p in pairs(problems) do
        client:print(("chain '%s' failed verification at event %s: %s (left untouched in saved data)"):format(cid, tostring(p.index), tostring(p.reason)))
    end
    e:rebuild()
    if next(lazy) then e.verifyTimer = client:every(0.05, function() e:verifyTick() end) end
    return e
end

---------------------------------------------------------------- hooks
-- fn(kind, chainId, event). kind: "local" (we wrote it), "remote" (accepted from a peer), "replaced" (a
-- chain was repaired after a fork), "verified", "corrupt". Returns an unsubscribe function.
function Engine:OnChange(fn)
    local entry = { fn = fn, active = true }
    self.hooks[#self.hooks + 1] = entry
    return function() entry.active = false end
end

function Engine:fire(kind, cid, ev)
    local snapshot = {}
    for i, h in ipairs(self.hooks) do snapshot[i] = h end
    for _, h in ipairs(snapshot) do
        if h.active then h.fn(kind, cid, ev) end
    end
end

---------------------------------------------------------------- reading
function Engine:rebuild()
    self.view = Ledger.View(self.store)
    self.fingerprint = Ledger.Fingerprint(self.store)
end

function Engine:Fingerprint() return self.fingerprint end
function Engine:LedgerId() return self.store.id end
function Engine:View() return self.view end
function Engine:Conflicts() return self.view.conflicts end

-- A list as callers see it: { name, state (Standings), events (applied, merge order), head (fingerprint) }.
function Engine:Get(listId)
    local s = self.view.lists[listId]
    if not s then return nil end
    local events = {}
    for _, ev in ipairs(self.view.applied) do
        if ev.list == listId then events[#events + 1] = ev end
    end
    return { id = listId, name = s.name, state = s, events = events, head = self.fingerprint }
end

-- All list ids, sorted.
function Engine:Lists()
    local out = {}
    for id in pairs(self.view.lists) do out[#out + 1] = id end
    table.sort(out)
    return out
end

-- The guild's rule for who may bid on an item (by item id), or nil: { classes (nil = any), by, ts, reason }.
function Engine:ItemRule(itemId) return self.view.itemRules[tonumber(itemId)] end

-- Every item rule, as { [itemId] = rule }.
function Engine:ItemRules() return self.view.itemRules end

function Engine:IsVerified() return next(self.verifying) == nil end

function Engine:ActiveRaids(t) return Ledger.ActiveRaids(self.view, t or self.client:serverTime()) end
function Engine:IsOfficer(name) return Ledger.IsOfficer(self.view, name or self.client:me()) end
function Engine:MayWrite(name, t)
    return Ledger.MayWrite(self.view, name or self.client:me(), t or self.client:serverTime())
end

---------------------------------------------------------------- writing
-- This character's chain id (created on first use, with a random epoch).
function Engine:MyChain()
    local me = self.client:me()
    local cid = self.db.mine[me]
    if not cid then
        local epoch = {}
        for i = 1, 8 do
            local d = self.client:random(16)
            epoch[i] = HEX:sub(d, d)
        end
        cid = me .. "#" .. table.concat(epoch)
        self.db.mine[me] = cid
    end
    return cid
end

-- A write time that never goes backwards in this chain and, for an event without `seen`, sorts after
-- everything already applied (so it can be applied in place). Events with an earlier `seen` (loot handed out
-- after it dropped) sort earlier on purpose and are checked with a full replay instead.
function Engine:nextTs(cid)
    local ts = self.client:serverTime()
    local mine = self.store.chains[cid]
    if mine and mine.lastTs and mine.lastTs > ts then ts = mine.lastTs end
    local last, lastKey = self.view.last, self.view.lastKey
    if last then
        if lastKey > ts then ts = lastKey end
        if lastKey == ts and last.chain > cid then ts = ts + 1 end
    end
    -- and after the latest authority event in write order, so e.g. a Master Looter's first award is
    -- always written after the Elevate that allows it
    local la = self.view.lastAuth
    if la then
        if la.ts > ts then ts = la.ts end
        if la.ts == ts and la.chain > cid then ts = ts + 1 end
    end
    return ts
end

function Engine:persist(cid)
    local chain = self.store.chains[cid]
    if chain then self.db.ledger.chains[cid] = { events = chain.events } end
end

-- Write one event on this character's chain. It is checked against the current view first and only
-- written if it would be accepted. Returns the event, or nil + reason.
function Engine:Write(type_, data, list)
    if type_ ~= "Genesis" and not self.store.id then return nil, "noledger" end
    local cid = self:MyChain()
    local ev, err = Ledger.Build(self.store, cid, self.client:me(), type_, data, self:nextTs(cid), list)
    if not ev then return nil, err end
    local view = self.view
    local fresh
    if Ledger.Appendable(view, self.store, ev) then
        local lastBefore, lastKeyBefore, nConf = view.last, view.lastKey, #view.conflicts
        local ok, why = Ledger.ApplyToView(view, ev, Ledger.KeyFor(self.store, ev))
        if not ok then
            view.conflicts[nConf + 1] = nil
            view.last, view.lastKey = lastBefore, lastKeyBefore
            return nil, why
        end
    else
        -- sorts before events already applied, or changes authority: check it with a full replay
        fresh = Ledger.View(self.store, ev)
        local ok, why = Ledger.Accepted(fresh, ev.id)
        if not ok then return nil, why end
    end
    local status, rerr = Ledger.Receive(self.store, ev)
    if status ~= "appended" then
        self:rebuild() -- should not happen: undo the optimistic apply
        return nil, rerr
    end
    if fresh then self.view = fresh end
    self:persist(cid)
    self.fingerprint = Ledger.Fingerprint(self.store)
    self:fire("local", cid, ev)
    return ev
end

-- Start a new ledger (the guild master does this once). Returns the Genesis event.
function Engine:Genesis(name)
    if self.store.id then return nil, "exists" end
    return self:Write("Genesis", { name = name })
end

-- List helpers.
-- The first list created on a machine with no ledger founds the ledger (Genesis) first: in the game
-- that is the guild master, who is the only one allowed to (see Commands).
function Engine:CreateList(listId, name)
    if not self.store.id then
        local g, gerr = self:Genesis("Guild ledger")
        if not g then return nil, gerr end
    end
    if self.view.lists[listId] then return nil, "exists" end
    local ev, err = self:Write("CreateList", { name = name or listId }, listId)
    if not ev then return nil, err end
    return self:Get(listId)
end

function Engine:Append(listId, type_, data)
    if not self.view.lists[listId] and type_ ~= "CreateList" then return nil, "nolist" end
    return self:Write(type_, data, listId)
end

---------------------------------------------------------------- receiving
-- Accept an event written elsewhere. Returns "appended" | "duplicate", or nil + reason (see Ledger.Receive).
function Engine:Receive(ev)
    if type(ev) == "table" and type(ev.chain) == "string" and self.problems[ev.chain] then return nil, "corrupt" end
    local status, err = Ledger.Receive(self.store, ev)
    if status ~= "appended" then return status, err end
    self:persist(ev.chain)
    local key, view = self.store.keyOf[ev.id], self.view
    if not Ledger.AUTHORITY[ev.type] and (not view.last or Ledger.ByKey(view.lastKey, view.last, key, ev)) then
        Ledger.ApplyToView(view, ev, key)
        self.fingerprint = Ledger.Fingerprint(self.store)
    else
        self:rebuild() -- a late event, or a change of authority: replay
    end
    self:fire("remote", ev.chain, ev)
    return status
end

-- Repair a chain that forked (its writer wrote two different events at the same position, e.g. from two
-- machines): keep events 1..k-1, then `branch`. The replaced events are kept in db.orphans for review.
-- Returns true, or nil + reason (nothing changes).
function Engine:ReplaceChainSuffix(cid, k, branch)
    local old = self.store.chains[cid]
    if not old then return nil, "nochain" end
    local oldEvents = {}
    for i, ev in ipairs(old.events) do oldEvents[i] = ev end
    Ledger.DropChain(self.store, cid)
    local function restore()
        Ledger.DropChain(self.store, cid)
        for _, ev in ipairs(oldEvents) do Ledger.Receive(self.store, ev) end
        self:persist(cid)
    end
    for i = 1, k - 1 do Ledger.Receive(self.store, oldEvents[i]) end
    for _, ev in ipairs(branch) do
        local status, err = Ledger.Receive(self.store, ev)
        if status ~= "appended" then restore(); return nil, err end
    end
    local orphans = {}
    for i = k, #oldEvents do orphans[#orphans + 1] = oldEvents[i] end
    if #orphans > 0 then
        self.db.orphans = self.db.orphans or {}
        self.db.orphans[#self.db.orphans + 1] = { chain = cid, at = self.client:serverTime(), events = orphans }
    end
    self:persist(cid)
    self:rebuild()
    self:fire("replaced", cid, nil)
    return true
end

---------------------------------------------------------------- background verification
function Engine:verifyTick()
    for cid, chain in pairs(self.verifying) do
        local status, idx = Ledger.VerifyStep(chain, self.verifyBatch)
        if status == "done" then
            self.verifying[cid] = nil
            self:fire("verified", cid, nil)
        elseif status == "bad" then
            self.verifying[cid] = nil
            Ledger.DropChain(self.store, cid)
            self.problems[cid] = { reason = "badhash", index = idx }
            self.client:print(("chain '%s' failed verification at event %d: badhash"):format(cid, idx))
            self:rebuild()
            self:fire("corrupt", cid, nil)
        end
        break -- one chain per tick keeps each tick small
    end
    if not next(self.verifying) and self.verifyTimer then
        self.client:cancel(self.verifyTimer)
        self.verifyTimer = nil
    end
end
