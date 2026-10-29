-- King's Gambit: a client owns its ledger state and talks to the world only through a Host.
-- No module-level state: tests and training can run many clients in one process.
local _, SK = ...
local M = SK:NewModule("Client")
local Ledger = SK.modules.Ledger

local Client = {}
Client.__index = Client

-- Build a client over a Host. Persisted lists are loaded and fully verified; a list that
-- fails verification is reported in client.problems and left untouched in storage
-- (never silently repaired or discarded).
function M.New(host)
    local acct = host:storage().account
    acct.schema = acct.schema or 1
    acct.lists = acct.lists or {}
    acct.config = acct.config or {}
    local c = setmetatable({ host = host, db = acct, chains = {}, problems = {} }, Client)
    for listId, rec in pairs(acct.lists) do
        local chain, err, idx = Ledger.Load(listId, rec.events or {})
        if chain then
            rec.events = chain.events -- keep the saved table and the live chain in step
            c.chains[listId] = chain
        else
            c.problems[listId] = { reason = err, index = idx }
            host:print(("list '%s' failed verification at event %s: %s"):format(listId, tostring(idx), tostring(err)))
        end
    end
    return c
end

function Client:Get(listId) return self.chains[listId] end

-- Create a list (writes its CreateList genesis event) and persist it.
function Client:CreateList(listId, name)
    if self.chains[listId] or self.problems[listId] then return nil, "exists" end
    local chain = Ledger.NewChain(listId)
    local ev, err = Ledger.Append(chain, "CreateList", { name = name }, self.host:me(), self.host:serverTime())
    if not ev then return nil, err end
    self.chains[listId] = chain
    self.db.lists[listId] = { events = chain.events }
    return chain
end

-- Author an event on a list as this client, stamped with the Host's clock.
function Client:Append(listId, type_, data)
    local chain = self.chains[listId]
    if not chain then return nil, "nolist" end
    return Ledger.Append(chain, type_, data, self.host:me(), self.host:serverTime())
end
