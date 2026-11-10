-- King's Gambit: the loot session, salvage and disenchant, the review, confirming (hand-out and recording), cancelling and the status for the windows. Keep this file Lua 5.1-safe.
-- Part of the Loot module (Loot.lua): Loot calls Install, which adds these methods to the Session class.
local _, SK = ...
local M = SK:NewModule("LootFinish")

-- Session: the class table to add methods to; h: what Loot.lua shares (and what the parts installed before this one exported).
function M.Install(Session, h)
local MayHave, norm = h.MayHave, h.norm

---------------------------------------------------------------- salvage and disenchant
-- Items nobody wanted go to the salvager (the lowest on the list), with no usability gate. They decide: claim it, or
-- decline and the disenchanter takes it. It is never offered to anyone else.
function Session:runSalvage()
    self.phase = "salvage"
    self.queue = {}
    for _, it in ipairs(self.items) do
        if it.status == "open" then self.queue[#self.queue + 1] = it.id end
    end
    self.qi = 0
    -- What is left after the draft (more unwanted items than picks) is plain suicide: each item is offered lowest-first on
    -- the live list. Claiming at the bottom costs no position, so whoever is lowest stays lowest and may take several
    -- items: they are lucky that nobody wanted them.
    self:emit("phase", { phase = "salvage" })
    self:nextSalvageItem()
end

function Session:nextSalvageItem()
    self.qi = self.qi + 1
    local id = self.queue[self.qi]
    if not id then return self:finish() end
    local salvager = self:salvagerFor(self.items[id])
    self.claim = { item = id, players = { salvager }, idx = 0 }
    self:offerNext()
end

-- An offer is settled (claimed, or everyone declined): back to the draft if it was offered during it, else the next
-- item of the end-of-draft salvage round.
function Session:afterSalvageItem()
    local c = self.claim
    if c and c.resume then
        self.claim = nil
        return self:continueDraft("main")
    end
    return self:nextSalvageItem()
end

function Session:offerNext()
    local c = self.claim
    c.idx = c.idx + 1
    local player = c.players[c.idx]
    if not player then
        self.items[c.item].status, self.items[c.item].tier = "de", "de"
        self.turn = nil
        return self:afterSalvageItem()
    end
    self:setTurn({ type = "claim", item = c.item, player = player },
        self.cfg.claimSeconds, function() self:decline(player) end)
end

-- extra.to (optional): hand the item to someone else, e.g. a bottom player proxying a
-- minor upgrade up to the player who can use it.
function Session:claimItem(player, extra)
    local t = self.turn
    if not (t and t.type == "claim") then return false, "noturn" end
    player = norm(self, player)
    if player ~= t.player then return false, "notyourturn" end
    local to
    if extra and extra.to then
        to = norm(self, extra.to)
        if not to or to == player then return false, "badtarget" end
        -- anyone may gift, but the one who receives it must be eligible for the item
        local ok, why = MayHave(self:fitOf(t.item), self.class[to])
        if not ok then return false, why .. "to" end
    end
    self.turn = nil
    self:award("salvage", player, t.item, to)
    self:afterSalvageItem()
    return true
end

function Session:decline(player)
    local t = self.turn
    if not (t and t.type == "claim") then return false, "noturn" end
    player = norm(self, player)
    if player ~= t.player then return false, "notyourturn" end
    self:offerNext()
    return true
end

function Session:finish()
    self:clearTimer()
    self.turn = nil
    local handler = self.deHandler
    for _, it in ipairs(self.items) do
        if it.status == "de" then
            self.pending[#self.pending + 1] = { type = "disenchant", list = self.cfg.listId, item = it, to = handler }
        end
    end
    -- Passes are not recorded (the ledger is about what happened to an item), with one exception: a gift won but never given to anyone ("undecided")
    -- is an outcome, counted as a pass by the Master Looter. A pass that says it was on an "upgrade" is NOT recorded: whether something is an upgrade is a
    -- judgment the addon can't make well, so no statistic is built on it. (Older ledgers' upgrade passes still read.)
    -- pairs() order is not stable, so collect and sort them before appending.
    local passes = {}
    for p, items in pairs(self.bids) do
        for itemId, b in pairs(items) do
            if b.kind == "pass" and b.passKind == "undecided" then
                passes[#passes + 1] = { type = "pass", list = self.cfg.listId, member = p,
                    item = self.items[itemId], kind = b.passKind }
            end
        end
    end
    table.sort(passes, function(x, y)
        if x.member ~= y.member then return x.member < y.member end
        return x.item.id < y.item.id
    end)
    for _, p in ipairs(passes) do self.pending[#self.pending + 1] = p end
    self.phase = "review"
    self:unwatchRoster()
    self:emit("phase", { phase = "review" })
end

---------------------------------------------------------------- confirm and distribute
-- Hand the items out and write the results to the ledger. Items from a loot window are given
-- first (GiveMasterLoot); the ledger entry is only written if that succeeded, so a failed
-- hand-out never leaves a phantom win. Returns true, failures (array of {item, stage, reason}).
function Session:confirm()
    if self.phase ~= "review" then return false, "notreview" end
    local engine, client = self.engine, self.client
    -- The right to write can end while a session runs (the raid expired, an officer revoked the Master Looter). Check
    -- before handing anything over: an item given out that cannot be recorded would be a phantom win. The session stays
    -- in review, so nothing is lost: once the right is back (an officer opens the raid again) confirm works.
    local mayWrite, whyNot = engine:MayWrite()
    if not mayWrite then return false, whyNot or "notauthorized" end
    local failures = {}
    local function fail(a, stage, reason) failures[#failures + 1] = { item = a.item, stage = stage, reason = reason } end

    -- The off-spec list first (created at the first session, in its random seed order; newcomers at the bottom), so
    -- the awards that follow find it.
    for _, e in ipairs(self.enrollments) do
        if not engine:Get(e.list) then engine:Write("CreateList", { name = "Off-spec", seen = self.seen }, e.list) end
        local ev, err = engine:Append(e.list, "AddMember", { member = e.member, class = self.class[e.member], seen = self.seen })
        if not ev then fail({ item = nil }, "ledger", err) end
    end
    for _, a in ipairs(self.pending) do
        if a.type == "award" and not a.to then
            fail(a, "recipient", "norecipient") -- a gift nobody has said who gets (cannot happen: the draft waits)
        elseif a.type == "award" then
            local ok, why = true, nil
            if a.item.slot then ok, why = client:give(a.item.slot, a.to) end
            if ok then
                -- the winner's spec for this raid goes on the entry (an extra field older clients ignore): "Fury Warrior won it" stays true after a respec
                local sp = self:specOf(a.member)
                local ev, err = engine:Append(a.list, "Award",
                    { member = a.member, item = a.item.link, to = (a.to ~= a.member) and a.to or nil, seen = a.item.seen, spec = sp and sp.spec or nil })
                if not ev then fail(a, "ledger", err) end
            else
                fail(a, "give", why)
            end
        elseif a.type == "disenchant" then
            local ok, why = true, nil
            if a.item.slot then ok, why = client:give(a.item.slot, a.to) end
            if ok then
                local ev, err = engine:Append(a.list, "Disenchant", { item = a.item.link, to = a.to, seen = a.item.seen })
                if not ev then fail(a, "ledger", err) end
            else
                fail(a, "give", why)
            end
        elseif a.type == "pass" then
            engine:Append(a.list, "Pass", { member = a.member, item = a.item.link, kind = a.kind, seen = a.item.seen })
        end
    end
    self.phase = "done"
    self:unwatchMethod()
    self:emit("done", { failures = failures })
    return true, failures
end

function Session:cancel(reason)
    if self.phase == "done" or self.phase == "cancelled" then return false end
    self:clearTimer()
    self.turn, self.pending = nil, {}
    self:unwatchRoster()
    self:unwatchMethod()
    self.phase = "cancelled"
    self:emit("phase", { phase = "cancelled", reason = reason })
    return true
end

-- Who wants a token, in list order, and how ready each says they are: { { player, kind, ready } }.
-- Shown to everyone as a hint (Tokens.lua); nil if the item is not a token.
function Session:readiness(itemId)
    local it = self.items[itemId]
    if not (it and it.token) then return nil end
    local out = {}
    for _, name in ipairs(self.order.main) do
        local b = self.bids[name] and self.bids[name][itemId]
        if b and b.kind ~= "pass" then out[#out + 1] = { player = name, kind = b.kind, ready = b.ready } end
    end
    return out
end

-- A snapshot for UIs and tests.
function Session:status()
    local answered, total = self:answerCount()
    return { phase = self.phase, turn = self.turn, items = self.items, pending = self.pending, enrollments = self.enrollments,
        answered = answered, eligible = total, deadline = self.deadline }
end
end
