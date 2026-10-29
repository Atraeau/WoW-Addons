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
function M.New(client)
    local acct = client:storage().account
    acct.schema = acct.schema or 1
    acct.lists = acct.lists or {}
    acct.config = acct.config or {}
    local c = setmetatable({ client = client, db = acct, chains = {}, problems = {} }, Engine)
    for listId, rec in pairs(acct.lists) do
        local chain, err, idx = Ledger.Load(listId, rec.events or {})
        if chain then
            rec.events = chain.events -- keep the saved table and the live chain in step
            c.chains[listId] = chain
        else
            c.problems[listId] = { reason = err, index = idx }
            client:print(("list '%s' failed verification at event %s: %s"):format(listId, tostring(idx), tostring(err)))
        end
    end
    return c
end

function Engine:Get(listId) return self.chains[listId] end

-- Create a list (writes its CreateList genesis event) and persist it.
function Engine:CreateList(listId, name)
    if self.chains[listId] or self.problems[listId] then return nil, "exists" end
    local chain = Ledger.NewChain(listId)
    local ev, err = Ledger.Append(chain, "CreateList", { name = name }, self.client:me(), self.client:serverTime())
    if not ev then return nil, err end
    self.chains[listId] = chain
    self.db.lists[listId] = { events = chain.events }
    return chain
end

-- Author an event on a list as this engine, stamped with the Client's clock.
function Engine:Append(listId, type_, data)
    local chain = self.chains[listId]
    if not chain then return nil, "nolist" end
    return Ledger.Append(chain, type_, data, self.client:me(), self.client:serverTime())
end
