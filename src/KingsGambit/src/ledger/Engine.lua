-- King's Gambit: an engine owns the ledger (a store of per-writer chains plus its replayed view) and talks
-- to the WoW client only through a Client. No module-level state: tests and training can run many engines
-- in one process. Design: docs/ledger-v2-design.md
local _, SK = ...
local Ledger, Migrations
local M = SK:NewModule("Engine", { "Ledger", "Migrations" }, function(d) Ledger, Migrations = d.Ledger, d.Migrations end)

local Engine = {}
Engine.__index = Engine

local HEX = "0123456789abcdef"

-- opts.syncVerifyLimit (default 2000): chains up to this many events are hash-verified at load; longer
-- ones are verified in the background (see verifyTick). opts.verifyBatch: events per background tick.
-- opts.rules: what this build understands (Migrations.lua); the released addon reads and writes format 2 only.
function M.New(client, opts)
    local acct = client:storage().account
    acct.schema = 2
    acct.ledger = acct.ledger or { chains = {} }
    acct.ledger.chains = acct.ledger.chains or {}
    acct.mine = acct.mine or {}
    acct.config = acct.config or {}
    local rules = (opts and opts.rules) or Migrations.Default
    assert(Migrations.Check(rules))
    local e = setmetatable({ client = client, db = acct, hooks = {}, problems = {}, rules = rules,
        verifyBatch = (opts and opts.verifyBatch) or 100 }, Engine)
    local store, problems, lazy = Ledger.LoadStore(acct.ledger, (opts and opts.syncVerifyLimit) or 2000, rules)
    e.store, e.verifying = store, lazy
    -- a chain with entries in a newer format is `ahead`: shown as far as this build can read it, never written back (the saved data keeps the rest)
    e.ahead = {}
    for cid, p in pairs(problems) do
        if p.ahead then e.ahead[cid] = { format = p.format, index = p.index }; problems[cid] = nil end
    end
    e.problems = problems
    for cid, chain in pairs(store.chains) do
        if not e.ahead[cid] then acct.ledger.chains[cid] = { events = chain.events } end
    end
    for cid, p in pairs(problems) do
        client:print(("chain '%s' failed verification at event %s: %s (left untouched in saved data)"):format(cid, tostring(p.index), tostring(p.reason)))
    end
    if next(e.ahead) then
        local formats = {}
        for _, a in pairs(e.ahead) do formats[#formats + 1] = tostring(a.format or "?") end
        client:print(("King's Gambit: this ledger has entries in a newer format (%s) than this version can read (it reads %s). You are seeing it as of the last entry this version can read, and writing is paused. Nothing was lost: update King's Gambit."):format(
            table.concat(formats, ", "), table.concat(Migrations.Readable(rules), ", ")))
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
-- The format the ledger is in now (what a new entry is written in), and whether this client has refused to write because it can't reproduce
-- a migration (see Ledger.VerifyMigrations): { reason, migration, to, expected, got } or nil.
function Engine:Format() return self.view.auth.format end
-- The chains whose saved entries include a format this build can't read: { [chainId] = { format, index } }. Empty when everything loaded.
function Engine:Ahead() return self.ahead end
-- The ledger formats this build can read, lowest first (advertised in heartbeats so the ledger owner can see who is ready).
function Engine:Readable() return Migrations.Readable(self.rules) end
function Engine:Frozen() return self.view.frozen end
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

-- An officer's override of who an item suits (by item id), or nil: { roles, by, ts, reason }.
function Engine:ItemSuits(itemId) return self.view.itemSuits[tonumber(itemId)] end

function Engine:IsVerified() return next(self.verifying) == nil end

function Engine:ActiveRaids(t) return Ledger.ActiveRaids(self.view, t or self.client:serverTime()) end
-- Who disenchants for the raid this character is Master Looter of (designated by them, in the ledger), or nil.
-- Who is in a raid, as the Master Looter's attendance entries say (a set of names).
function Engine:Present(raid) return Ledger.Present(self.view, raid) end

-- The spec recorded for a member in a raid, or nil (see Ledger.lua, auth.SetSpec).
function Engine:SpecOf(raid, member) return Ledger.SpecOf(self.view, raid, member) end

function Engine:RaidDisenchanter()
    local me = self.client:me()
    for _, r in ipairs(self:ActiveRaids()) do
        if r.ml == me then return r.disenchanter, r end
    end
end
-- The list the raid this character is Master Looter of plays on, then that raid; nil, raid when the guild requires a list of its own per
-- raid and none has been named yet; nil, nil when this character is not running a raid.
function Engine:RaidList()
    local me = self.client:me()
    for _, r in ipairs(self:ActiveRaids()) do
        if r.ml == me then
            if r.listEv then return r.list, r end
            if not r.dedicated then return Ledger.MAIN, r end
            return nil, r
        end
    end
end
-- The list a raid plays on, whoever is asking: its named list, `main` if none was named and the guild doesn't require one, else nil.
function Engine:ListOfRaid(r)
    if r.listEv then return r.list end
    if not r.dedicated then return Ledger.MAIN end
end
-- How the guild picks a raid's list: "choose" (main unless an officer names another) or "perraid" (every raid names a list of its own).
function Engine:ListPolicy() return self.view.auth.policy end
-- The off-spec list that goes with a list.
function Engine:OffListOf(listId) return Ledger.OffList(listId) end
-- Is this player an officer? The GAME says (a rank permission of the guild: "Is Officer"), for this character just now, or for another from the guild
-- roster; nil from the game means it doesn't know, which counts as no. A client without that (an old one) falls back to not being disregarded.
function Engine:IsOfficer(name)
    if self.client.isOfficer then return self.client:isOfficer(name) == true and not self.view.auth.disregarded[name or self.client:me()] end
    return Ledger.IsOfficer(self.view, name or self.client:me())
end

-- These entries need an officer even for the Master Looter of a raid; everything else the Master Looter of this character's own open raid may write.
local OFFICER_ONLY = { Genesis = true, Elevate = true, SetRaidList = true, Revoke = true, Disregard = true, SetListPolicy = true,
    SetOfficers = true, SetGuildMaster = true, Migrate = true }

-- Just-in-time authorization for writing an entry of this kind: an officer by the game right now, or (for the kinds that allow it) the Master Looter of a
-- raid this character runs. Returns true, or nil + "notofficer". This is the only check of rank; other clients accept what arrives.
function Engine:Allowed(type_)
    if not self.client.isOfficer or self.client:isOfficer() == true then return true end
    local me = self.client:me()
    if not OFFICER_ONLY[type_] then
        for _, r in ipairs(self:ActiveRaids()) do if r.ml == me then return true end end
    end
    -- someone whose raid has ended is told so, rather than that they aren't an officer
    for _, r in pairs(self.view.auth.raids) do if r.ml == me and not OFFICER_ONLY[type_] then return nil, "expired" end end
    return nil, "notofficer"
end

function Engine:MayWrite(name, t)
    name = name or self.client:me()
    if name == self.client:me() then
        local allowed, why = self:Allowed("List")
        if not allowed then return nil, why end
    end
    return Ledger.MayWrite(self.view, name, t or self.client:serverTime())
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
    if self.ahead[cid] then return end -- the saved chain has entries this build can't read: never overwrite it with the readable part
    local chain = self.store.chains[cid]
    if chain then self.db.ledger.chains[cid] = { events = chain.events } end
end

-- Write one event on this character's chain. It is checked against the current view first and only
-- written if it would be accepted. Returns the event, or nil + reason.
-- `format` (optional) is the format to write in, for the entry that starts a new one (Migrate); otherwise the ledger's current format.
function Engine:Write(type_, data, list, format)
    if type_ ~= "Genesis" and not self.store.id then return nil, "noledger" end
    if self.view.frozen then return nil, "frozen" end
    if next(self.ahead) then return nil, "ahead" end -- see Ledger.LoadStore: writing now would build on a truncated view
    local allowed, notAllowed = self:Allowed(type_)
    if not allowed then return nil, notAllowed end
    local fmt = format or self.view.auth.format
    if fmt ~= self.rules.current then
        -- the code builds entries in its newest shape; the ledger may still be in an older format: write that one
        local down, why = Migrations.Down(self.rules, { v = self.rules.current, type = type_, list = list, data = data }, fmt)
        if not down then return nil, why or "unrepresentable" end
        type_, data, list = down.type, down.data, down.list
    end
    local cid = self:MyChain()
    local ev, err = Ledger.Build(self.store, cid, self.client:me(), type_, data, self:nextTs(cid), list, fmt)
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

-- Move the ledger to the next format (the ledger owner does this once per migration, when the guild is ready). The entry names exactly
-- how many events of each chain are before the change, and the digest of the standings they produce, as THIS client reads them. Returns
-- the event, or nil + reason: "frozen", "badmigrate" (not the next format), "cantwrite" (this build doesn't work in that format), or
-- what the ledger says ("notguildmaster").
function Engine:Migrate(to, reason)
    if self.view.frozen then return nil, "frozen" end
    if type(to) ~= "number" or to ~= self.view.auth.format + 1 then return nil, "badmigrate" end
    if self.rules.current < to then return nil, "cantwrite" end
    local cut = {}
    for cid, chain in pairs(self.store.chains) do cut[cid] = #chain.events end
    local digest = Ledger.CutDigest(self.store, cut)
    return self:Write("Migrate", { from = to - 1, to = to, cut = cut, digest = digest, reason = reason }, nil, to)
end

-- Start a new ledger (the ledger owner does this once). Returns the Genesis event.
function Engine:Genesis(name)
    if self.store.id then return nil, "exists" end
    return self:Write("Genesis", { name = name })
end

-- List helpers.
-- The first list created on a machine with no ledger founds the ledger (Genesis) first: in the game
-- that is the ledger owner, who is the only one allowed to (see Commands).
function Engine:CreateList(listId, name)
    if not self.store.id then
        -- the ledger is the guild's: it takes the guild's name when the game says it
        local guild = self.client.guildName and self.client:guildName()
        local g, gerr = self:Genesis(guild or "Guild ledger")
        if not g then return nil, gerr end
    end
    if self.view.lists[listId] then return nil, "exists" end
    local ev, err = self:Write("CreateList", { name = name or listId }, listId)
    if not ev then return nil, err end
    return self:Get(listId)
end

-- Make sure list `listId` exists: if not, create it and seed it with the order of `main` (so "who has waited longest" carries over; wins and
-- passes start level). The raid's Master Looter does this when the first session starts, so an officer opening a raid never has to write to a
-- list while another raid is running. Returns the list, or nil + reason.
function Engine:EnsureList(listId, name)
    local have = self:Get(listId)
    if have then return have end
    local made, err = self:CreateList(listId, name or listId)
    if not made then return nil, err end
    local main = self:Get(Ledger.MAIN)
    if main then
        for _, who in ipairs(main.state.order) do
            local ok, why = self:Append(listId, "AddMember", { member = who, class = main.state.members[who].class })
            if not ok then return nil, why end
        end
    end
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
