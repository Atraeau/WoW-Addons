-- King's Gambit: an engine owns its ledger state and talks to the WoW client only through a Client.
-- No module-level state: tests and training can run many engines in one process.
local _, SK = ...
local M = SK:NewModule("Engine")
local Ledger = SK.modules.Ledger

local Engine = {}
Engine.__index = Engine

-- Build an engine over a Client. Persisted lists are loaded and fully verified; a list that
-- fails verification is reported in engine.problems and left untouched in storage
-- (never silently repaired or discarded).
-- opts.syncVerifyLimit (default 2000): lists up to this many events are fully hash-verified right
-- away; longer ones are loaded fast and verified in the background (see Engine:verifyTick).
function M.New(client, opts)
    local acct = client:storage().account
    acct.schema = acct.schema or 1
    acct.lists = acct.lists or {}
    acct.config = acct.config or {}
    local c = setmetatable({ client = client, db = acct, chains = {}, problems = {}, hooks = {}, verifying = {},
        verifyLimit = (opts and opts.syncVerifyLimit) or 2000, verifyBatch = (opts and opts.verifyBatch) or 100 }, Engine)
    for listId, rec in pairs(acct.lists) do
        local events = rec.events or {}
        local lazy = #events > c.verifyLimit
        local chain, err, idx
        if lazy then chain, err, idx = Ledger.LoadFast(listId, events) else chain, err, idx = Ledger.Load(listId, events) end
        if chain then
            rec.events = chain.events -- keep the saved table and the live chain in step
            c.chains[listId] = chain
            if lazy then c.verifying[listId] = chain end
        else
            c.problems[listId] = { reason = err, index = idx }
            client:print(("list '%s' failed verification at event %s: %s"):format(listId, tostring(idx), tostring(err)))
        end
    end
    if next(c.verifying) then
        c.verifyTimer = client:every(0.05, function() c:verifyTick() end)
    end
    return c
end

-- Background hash verification of large lists, a slice per tick so login never stalls. A list that
-- fails is reported and taken out of use (its saved data is left untouched).
function Engine:verifyTick()
    for listId, chain in pairs(self.verifying) do
        local status, idx = Ledger.VerifyStep(chain, self.verifyBatch)
        if status == "done" then
            self.verifying[listId] = nil
            self:fire("verified", listId, nil)
        elseif status == "bad" then
            self.verifying[listId] = nil
            self.chains[listId] = nil
            self.problems[listId] = { reason = "badhash", index = idx }
            self.client:print(("list '%s' failed verification at event %d: badhash"):format(listId, idx))
            self:fire("corrupt", listId, nil)
        end
        break -- one list per tick keeps each tick small
    end
    if not next(self.verifying) and self.verifyTimer then
        self.client:cancel(self.verifyTimer)
        self.verifyTimer = nil
    end
end

function Engine:IsVerified(listId) return self.chains[listId] ~= nil and self.verifying[listId] == nil end

function Engine:Get(listId) return self.chains[listId] end

-- Subscribe to changes: fn(kind, listId, event). kind is "local" (this engine wrote it),
-- "remote" (accepted from a peer) or "replaced" (a fork was resolved; event is nil).
-- Returns an unsubscribe function.
function Engine:OnChange(fn)
    local entry = { fn = fn, active = true }
    self.hooks[#self.hooks + 1] = entry
    return function() entry.active = false end
end

function Engine:fire(kind, listId, ev)
    local snapshot = {}
    for i, h in ipairs(self.hooks) do snapshot[i] = h end
    for _, h in ipairs(snapshot) do
        if h.active then h.fn(kind, listId, ev) end
    end
end

-- Create a list (writes its CreateList genesis event) and persist it.
function Engine:CreateList(listId, name)
    if self.chains[listId] or self.problems[listId] then return nil, "exists" end
    local chain = Ledger.NewChain(listId)
    local ev, err = Ledger.Append(chain, "CreateList", { name = name }, self.client:me(), self.client:serverTime())
    if not ev then return nil, err end
    self.chains[listId] = chain
    self.db.lists[listId] = { events = chain.events }
    self:fire("local", listId, ev)
    return chain
end

-- Author an event on a list as this engine, stamped with the Client's clock.
function Engine:Append(listId, type_, data)
    local chain = self.chains[listId]
    if not chain then return nil, "nolist" end
    local ev, err = Ledger.Append(chain, type_, data, self.client:me(), self.client:serverTime())
    if ev then self:fire("local", listId, ev) end
    return ev, err
end

-- Accept an event authored elsewhere. Returns "appended" | "duplicate", or nil + reason
-- (see Ledger.Receive; also "unknownlist" for a list we have never seen that does not start
-- with its CreateList). A list is adopted when its genesis event arrives.
function Engine:Receive(listId, ev)
    if self.problems[listId] then return nil, "corrupt" end
    local chain = self.chains[listId]
    local adopt = false
    if not chain then
        if type(ev) ~= "table" or ev.seq ~= 1 or ev.type ~= "CreateList" then return nil, "unknownlist" end
        chain, adopt = Ledger.NewChain(listId), true
    end
    local status, err = Ledger.Receive(chain, ev)
    if status == "appended" then
        if adopt then
            self.chains[listId] = chain
            self.db.lists[listId] = { events = chain.events }
        end
        self:fire("remote", listId, ev)
    end
    return status, err
end

-- Fork resolution: swap in a verified replacement chain. The events this engine had on the
-- losing branch are kept in db.orphans so an officer can review and re-enter them.
function Engine:ReplaceChain(listId, newChain, orphans)
    self.chains[listId] = newChain
    self.db.lists[listId] = { events = newChain.events }
    if orphans and #orphans > 0 then
        self.db.orphans = self.db.orphans or {}
        self.db.orphans[#self.db.orphans + 1] = { list = listId, at = self.client:serverTime(), events = orphans }
    end
    self:fire("replaced", listId, nil)
end
