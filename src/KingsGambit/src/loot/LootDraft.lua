-- King's Gambit: the loot session, the drafts: the main, off-spec and gift rounds, picks and skips, and the gift winner's choices. Keep this file Lua 5.1-safe.
-- Part of the Loot module (Loot.lua): Loot calls Install, which adds these methods to the Session class.
local _, SK = ...
local M = SK:NewModule("LootDraft")

-- Session: the class table to add methods to; h: what Loot.lua shares (and what the parts installed before this one exported).
function M.Install(Session, h)
local MayHave, Shuffle, copy, indexOf, moveToBottom, norm = h.MayHave, h.Shuffle, h.copy, h.indexOf, h.moveToBottom, h.norm

---------------------------------------------------------------- the draft
local function wants(bid, tier)
    if not bid then return false end
    -- Three tiers, in this order: main (need), off-spec, then gifts. A gift is a proxy, not a want, so it never outranks
    -- anyone who wants the item (even the bottom player, whose gift costs nothing, can't override an off-spec bid).
    if tier == "main" then return bid.kind == "need" end
    if tier == "gift" then return bid.kind == "gift" end
    return bid.kind == "off"
end

-- Who would hold the item if `name` won it in `tier`: the gift target, or the winner.
function Session:recipient(name, itemId, tier)
    local bid = self.bids[name] and self.bids[name][itemId]
    return (tier == "gift" and bid and bid.kind == "gift" and bid.to) or name
end

function Session:hasBid(player, itemId, tier)
    return wants(self.bids[player] and self.bids[player][itemId], tier)
end

-- The first player in scratch order with a live bid, plus the open items they bid on.
function Session:topCandidate(tier)
    for _, name in ipairs(self.order[tier]) do
        if self.eligible[name] and not self.skipped[tier][name] then
            local opts = {}
            for _, it in ipairs(self.items) do
                if it.status == "open" and self:hasBid(name, it.id, tier)
                    and self:canReceive(self:recipient(name, it.id, tier), it) then
                    opts[#opts + 1] = it.id
                end
            end
            if #opts > 0 then return name, opts end
        end
    end
end

-- The off-spec list does not borrow the main list's order (that would hand the top of the main list an off-spec
-- advantage too). The first session creates it with every raider present in a random seed order (the one roll, kept in
-- the ledger as the order they are added in); after that, newcomers join at the bottom, as on the main list, and
-- nothing is rolled again.
function Session:buildOffOrder()
    local off = self.engine:Get(self.cfg.offListId)
    local order = off and copy(off.state.order) or {}
    local seen = {}
    for _, n in ipairs(order) do seen[n] = true end
    local newcomers = {}
    for _, name in ipairs(self.eligibleList) do
        if not seen[name] then newcomers[#newcomers + 1] = name end
    end
    if not off then
        -- the roll: a shuffle of everyone present, from the client's random source (a shuffle is unbiased)
        -- Independent of the main list: if the draw happens to be the main list's own order, draw again (a few tries).
        local mainOrder = table.concat(self.order.main, "\n")
        for _ = 1, 8 do
            Shuffle(self.client, newcomers)
            if #newcomers < 2 or table.concat(newcomers, "\n") ~= mainOrder then break end
        end
    end
    for _, name in ipairs(newcomers) do
        order[#order + 1] = name
        self.enrollments[#self.enrollments + 1] = { list = self.cfg.offListId, member = name, seeded = (not off) or nil }
    end
    self.order.off = order
end

function Session:award(tier, who, itemId, toOverride)
    local it = self.items[itemId]
    local bid = self.bids[who] and self.bids[who][itemId]
    local isGift = (not toOverride) and bid and bid.kind == "gift" and tier == "gift"
    local undecided = isGift and not bid.to
    local to = toOverride or (isGift and bid.to or who)
    if undecided then to = nil end
    it.status, it.winner, it.to, it.tier = "awarded", who, to, tier
    local list = (tier == "off") and self.cfg.offListId or self.cfg.listId
    local order = self.order[tier == "off" and "off" or "main"]
    local from = indexOf(order, who)
    local wasBottom = from == #order
    moveToBottom(order, who)
    local action = { type = "award", list = list, member = who, to = to, item = it, tier = tier, undecided = undecided or nil,
        fromIndex = from }
    self.pending[#self.pending + 1] = action
    self:emit("pending", action)
    -- Each pick in the main draft drops its winner to the bottom, which makes them the lowest player right now: the next
    -- unwanted item is offered to them (see offerLeftover). A gift still waiting for its recipient owes it once settled.
    if tier == "main" and not undecided then self.owedSalvage = true end
    if undecided then
        -- They won it as a gift but haven't said who gets it. Nothing is guessed and nothing times out: the draft
        -- waits for them. The turn is published, so the raid sees "X won it as a gift and is choosing who gets it".
        self:setTurn({ type = "recipient", tier = tier, player = who, item = itemId, wasBottom = wasBottom }, nil)
        self.undecided = action
    end
end

-- The player who won a gift without naming who gets it. Returns the turn, or nil + a reason.
local function recipientTurn(self, player)
    local t = self.turn
    if not (t and t.type == "recipient") then return nil, "noturn" end
    if norm(self, player) ~= t.player then return nil, "notyourturn" end
    return t
end

-- May `player` keep the gift they won? They must be eligible for the item, or be the salvager (the lowest on the
-- list when they won, who may take anything).
function Session:mayKeep(player, itemId)
    local t = self.turn
    if t and t.type == "recipient" and t.item == itemId and t.wasBottom then return true end
    return (MayHave(self:fitOf(itemId), self.class[norm(self, player)]))
end

local function resolveRecipient(self, t, to)
    local action = self.undecided
    action.to, action.undecided = to, nil
    self.items[t.item].to = to
    self.undecided, self.turn = nil, nil
    self:clearTimer()
    self:emit("recipient", { player = t.player, item = t.item, to = to })
    self:continueDraft(t.tier)
    return true
end

-- Choose who gets the gift they won. The recipient must be in the raid and eligible for the item.
function Session:chooseRecipient(player, to)
    local t, why = recipientTurn(self, player)
    if not t then return false, why end
    to = norm(self, to)
    if not to or not self.eligible[to] or self.away[to] then return false, "badtarget" end
    if to == t.player then return self:keepGift(player) end
    local ok, why2 = MayHave(self:fitOf(t.item), self.class[to])
    if not ok then return false, why2 .. "to" end
    if not self:canReceive(to, self.items[t.item]) then return false, "unreachable" end
    return resolveRecipient(self, t, to)
end

-- Keep it after all (only if eligible for it, or the salvager).
function Session:keepGift(player)
    local t, why = recipientTurn(self, player)
    if not t then return false, why end
    if not self:mayKeep(t.player, t.item) then return false, "cantkeep" end
    return resolveRecipient(self, t, t.player)
end

-- Undo a gift win that has no recipient: the win is withdrawn, the winner keeps their place on the list, it counts as
-- a pass for them, and the draft goes on without them for this item. passKind (optional) is recorded with the pass.
local function undoGift(self, t, passKind, forced)
    local action, it = self.undecided, self.items[t.item]
    for i, a in ipairs(self.pending) do
        if a == action then table.remove(self.pending, i); break end
    end
    local order = self.order[t.tier == "off" and "off" or "main"]
    local at = indexOf(order, t.player)
    if at then table.remove(order, at); table.insert(order, math.min(action.fromIndex or #order + 1, #order + 1), t.player) end
    it.status, it.winner, it.to, it.tier = "open", nil, nil, nil
    self.bids[t.player][t.item] = { kind = "pass", passKind = passKind }
    self.undecided, self.turn = nil, nil
    self:clearTimer()
    self:emit("recipient", { player = t.player, item = t.item, withdrawn = true, forced = forced or nil })
    self:continueDraft(t.tier)
    return true
end

-- Decide not to gift after all. (The page and commands ask for a confirmation first.)
function Session:withdrawGift(player)
    local t, why = recipientTurn(self, player)
    if not t then return false, why end
    return undoGift(self, t)
end

-- The Master Looter's override: the winner has not said who gets the gift (away, slow, or unwilling), so the Master
-- Looter downgrades it to a pass for that player. It is recorded as a pass of kind "undecided", so the history shows it.
-- Only the Master Looter's own client holds the session, so this is theirs to call.
function Session:overrideGift()
    local t = self.turn
    if not (t and t.type == "recipient") then return false, "noturn" end
    return undoGift(self, t, "undecided", true)
end

function Session:setTurn(turn, sec, onTimeout)
    self.turn = turn
    self:armTimer(sec, onTimeout)
    turn.deadline = self.deadline
    self:emit("turn", turn)
end

function Session:runDraft(tier)
    self.phase = tier
    if tier == "off" then self:buildOffOrder() end
    -- gifts are drafted in main-list order as it stands now (the winners so far are at the bottom); a gift costs its place
    if tier == "gift" then self.order.gift = self.order.main end
    self:emit("phase", { phase = tier })
    self:continueDraft(tier)
end

-- An item nobody bid on in any way (need, off-spec or gift), not yet offered.
function Session:nextLeftover()
    for _, it in ipairs(self.items) do
        if it.status == "open" and not it.offered then
            local wanted = false
            for _, row in pairs(self.bids) do
                local b = row[it.id]
                if b and (b.kind == "need" or b.kind == "off" or b.kind == "gift") then wanted = true end
            end
            if not wanted then return it end
        end
    end
end

-- As the draft executes, each pick owes the raid one unwanted item: it is offered lowest-first on the live list, which
-- is normally the player who just picked (winning drops you to the bottom). So the salvagers rotate in the order of
-- the draft. If they decline it goes up the list; if everyone declines it is disenchanted. Returns true if an offer is
-- now waiting on someone (the draft resumes when it is settled).
-- The salvager for an item: the lowest player on the live list who can be handed it. Only they are asked.
function Session:salvagerFor(item)
    for i = #self.order.main, 1, -1 do
        local p = self.order.main[i]
        if self.eligible[p] and self:canReceive(p, item) then return p end
    end
end

function Session:offerLeftover()
    local it = self:nextLeftover()
    if not it then return false end
    it.offered = true
    local salvager = self:salvagerFor(it)
    self.claim = { item = it.id, players = { salvager }, idx = 0, resume = true }
    self:offerNext()
    return self.turn ~= nil
end

function Session:continueDraft(tier)
    if self.turn and (self.turn.type == "recipient" or self.turn.type == "claim") then return end
    while true do
        if self.owedSalvage then
            self.owedSalvage = false
            if tier == "main" and self:offerLeftover() then return end
        end
        local who, opts = self:topCandidate(tier)
        if not who then break end
        local ranked = self:rankedChoice(who, opts)
        if #opts == 1 then
            self:award(tier, who, opts[1])
            if self.turn then return end -- a gift waiting for its recipient
        elseif ranked then
            self:award(tier, who, ranked) -- ranked choice: their most-wanted item still available
            if self.turn then return end
        else
            self:setTurn({ type = "pick", tier = tier, player = who, options = opts },
                self.cfg.pickSeconds, function() self:skip(who) end)
            return
        end
    end
    self.turn = nil
    self:clearTimer()
    -- main (need) -> off-spec -> gifts -> the salvage of what is left
    if tier == "main" then self:runDraft("off")
    elseif tier == "off" then self:runDraft("gift")
    else self:runSalvage() end
end

-- Ranked choice: if the player ranked every option, the one they ranked highest (lowest number; ties go
-- to the lower item number). Otherwise nil, and they pick live.
function Session:rankedChoice(who, opts)
    local best, bestRank
    for _, id in ipairs(opts) do
        local b = self.bids[who] and self.bids[who][id]
        if not (b and b.rank) then return nil end
        if not bestRank or b.rank < bestRank or (b.rank == bestRank and id < best) then best, bestRank = id, b.rank end
    end
    return best
end

-- The player whose turn it is picks one of the items they bid on.
function Session:pick(player, itemId)
    local t = self.turn
    if not (t and t.type == "pick") then return false, "noturn" end
    player = norm(self, player)
    if player ~= t.player then return false, "notyourturn" end
    if not indexOf(t.options, itemId) then return false, "badpick" end
    self.turn = nil
    self:award(t.tier, player, itemId)
    self:continueDraft(t.tier) -- (paused if the win was a gift still awaiting its recipient)
    return true
end

-- Passing on a turn is always free; it forfeits the rest of this tier for that player.
function Session:skip(player)
    local t = self.turn
    if not (t and t.type == "pick") then return false, "noturn" end
    player = norm(self, player)
    if player ~= t.player then return false, "notyourturn" end
    self.turn = nil
    self.skipped[t.tier][player] = true
    self:continueDraft(t.tier)
    return true
end
end
