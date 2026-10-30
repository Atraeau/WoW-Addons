-- King's Gambit: the loot session and draft engine (Phase 4).
-- Pure logic over an Engine and its Client: no WoW calls, no frames. A Session takes a
-- batch of items through bidding, the tiered priority draft, the salvage round and the
-- disenchant floor, then (after confirmation) hands the items out and records the results
-- in the ledger. Rules: docs/rationale.md.
--
--   bidding  -> main draft -> off-spec draft -> salvage -> disenchant -> review -> done
--
-- The draft works on scratch copies of the standings, so picks can be made live while
-- nothing is written to the ledger until confirm(). Winners drop to the bottom of the
-- scratch order exactly as the ledger will replay them.
local _, SK = ...
local Tokens, ItemFit
local M = SK:NewModule("Loot", { "ItemFit", "Tokens?" }, function(d) Tokens, ItemFit = d.Tokens, d.ItemFit end)

local DEFAULTS = {
    listId = "main",
    offListId = "off",
    bidSeconds = 30,     -- 0 = open-ended: the Master Looter calls resolveNow()
    pickSeconds = 20,    -- a draft turn that times out counts as a skip
    claimSeconds = 10,   -- a salvage offer that times out counts as a decline
    autoEnroll = true,   -- unlisted raiders are added to the bottom of the main list
    deHandler = nil,     -- who disenchants when nobody wants an item. Normally the raid's designated disenchanter (the
                         -- Master Looter chooses one per raid, in the ledger); a session cannot start without one
}

local Session = {}
Session.__index = Session

local function copy(t)
    local out = {}
    for i, v in ipairs(t) do out[i] = v end
    return out
end

local function indexOf(t, v)
    for i = 1, #t do
        if t[i] == v then return i end
    end
end

-- An unbiased random shuffle of `list` in place, from the client's random source (so it is repeatable in the simulator
-- and tests, and the result is what gets recorded).
function M.Shuffle(client, list)
    for i = #list, 2, -1 do
        local j = client:random(i)
        list[i], list[j] = list[j], list[i]
    end
    return list
end

local function moveToBottom(order, name)
    local i = indexOf(order, name)
    if i then table.remove(order, i); order[#order + 1] = name end
end

-- opts overrides DEFAULTS (see above).
function M.NewSession(engine, opts)
    local cfg = {}
    for k, v in pairs(DEFAULTS) do cfg[k] = v end
    for k, v in pairs(opts or {}) do cfg[k] = v end
    return setmetatable({
        engine = engine, client = engine.client, cfg = cfg, phase = "idle",
        items = {}, eligible = {}, eligibleList = {}, class = {}, away = {}, enrollments = {},
        bids = {}, pending = {}, order = {}, skipped = { main = {}, off = {} },
        handlers = {}, turn = nil, timer = nil, deadline = nil,
    }, Session)
end

---------------------------------------------------------------- events
-- Events: phase {phase}, bid {player, item, kind}, turn {turn}, pending {action}, done {failures}
function Session:on(event, fn)
    local list = self.handlers[event]
    if not list then list = {}; self.handlers[event] = list end
    local entry = { fn = fn, active = true }
    list[#list + 1] = entry
    return function() entry.active = false end
end

function Session:emit(event, payload)
    for _, e in ipairs(copy(self.handlers[event] or {})) do
        if e.active then e.fn(payload) end
    end
end

local function norm(self, name) return self.client:normalize(name) end

---------------------------------------------------------------- timers
function Session:clearTimer()
    if self.timer then self.client:cancel(self.timer); self.timer = nil end
end

function Session:unwatchRoster()
    if self.unwatch then self.unwatch(); self.unwatch = nil end
end

function Session:armTimer(sec, fn)
    self:clearTimer()
    if sec and sec > 0 then
        self.deadline = self.client:now() + sec
        self.timer = self.client:after(sec, function() self.timer = nil; fn() end)
    else
        self.deadline = nil
    end
end

---------------------------------------------------------------- start and bidding
-- items: array of { link, slot (loot slot, optional) }. Returns true, or false + reason.
function Session:start(items)
    if self.phase ~= "idle" then return false, "started" end
    local cfg = self.cfg
    local main = self.engine:Get(cfg.listId)
    if not main then return false, "nolist" end
    if #items == 0 then return false, "noitems" end
    -- Loot is not distributed until the Master Looter has said who disenchants what nobody wants.
    self.deHandler = cfg.deHandler or self.engine:RaidDisenchanter()
    if not self.deHandler then return false, "nodisenchanter" end

    -- When the loot became visible: each item may say (loot held for a later hand-out); default now. Events
    -- the session writes carry it as `seen`, so the ledger orders them by drop time, not hand-out time.
    local now = self.client:serverTime()
    self.seen = now
    for _, it in ipairs(items) do
        local s = tonumber(it.seen)
        if s and s <= now and s < self.seen then self.seen = s end
    end
    self:refreshRoster(true) -- (the very first time, an empty list is seeded in a random order)

    for i, it in ipairs(items) do
        if type(it.link) ~= "string" or it.link == "" then return false, "badlink" end
        local s = tonumber(it.seen)
        if not (s and s <= now) then s = now end
        self.items[i] = { id = i, link = it.link, slot = it.slot, status = "open", seen = s,
            itemId = tonumber(it.itemId) or ItemFit.ItemId(it.link),
            token = Tokens and Tokens.Find(it.link) or nil }
        self:fitOf(i)
    end
    self.order.main = copy(main.state.order)
    self.phase = "bidding"
    self:armTimer(cfg.bidSeconds, function() self:closeBidding() end)
    self.unwatch = self.client:on("roster.changed", function() self:rosterChanged() end)
    self:emit("phase", { phase = "bidding" })
    return true
end

-- Read the raid. Anyone online and on the list is eligible (a newcomer joins the bottom of the list when
-- autoEnroll is on), including someone who arrives after the session started. Anyone who has gone offline
-- or left is `away`: they stay on record but can't win, or hold the session up.
function Session:refreshRoster(seedIfEmpty)
    local cfg = self.cfg
    local main = self.engine:Get(cfg.listId)
    local here, newcomers = {}, {}
    for _, m in ipairs(self.client:roster()) do
        if m.online then
            here[m.name] = true
            self.class[m.name] = m.class
            if not self.eligible[m.name] then
                local mem = main.state.members[m.name]
                if mem and mem.active then
                    self.eligible[m.name] = true
                    self.eligibleList[#self.eligibleList + 1] = m.name
                elseif cfg.autoEnroll then
                    newcomers[#newcomers + 1] = m
                end
            end
        end
    end
    -- Raiders not yet on the list join at its bottom. The very first time (an empty list, at the first session) they
    -- are put in a random order instead: the roll that seeds the list, kept as the order the AddMember events are in.
    if seedIfEmpty and #main.state.order == 0 then M.Shuffle(self.client, newcomers) end
    for _, m in ipairs(newcomers) do
        self.engine:Append(cfg.listId, "AddMember", { member = m.name, class = m.class, seen = self.seen })
        local mem = main.state.members[m.name]
        if self.order.main and mem and mem.active then self.order.main[#self.order.main + 1] = m.name end
        if mem and mem.active then
            self.eligible[m.name] = true
            self.eligibleList[#self.eligibleList + 1] = m.name
        end
    end
    local away = {}
    for _, name in ipairs(self.eligibleList) do
        if not here[name] then away[name] = true end
    end
    self.away = away
end

-- Can this player be handed this item right now? They must still be in the raid, and for loot in a window,
-- the game must list them as a candidate for that slot (someone out of range is not).
function Session:canReceive(name, item)
    if self.away[name] then return false end
    if item.slot then
        local cands = self.client:candidates(item.slot)
        if cands then
            for _, c in ipairs(cands) do
                if c == name then return true end
            end
            return false
        end
    end
    return true
end

-- The raid changed while a session runs: admit newcomers, stop waiting for those who left, and move a draft
-- turn on if it was theirs.
function Session:rosterChanged()
    if self.phase == "idle" or self.phase == "review" or self.phase == "done" or self.phase == "cancelled" then return end
    self:refreshRoster()
    if self.phase == "bidding" then
        if self:allAnswered() then self:closeBidding() end
        return
    end
    local t = self.turn
    if t and self.away[t.player] then
        if t.type == "pick" then self:skip(t.player)
        elseif t.type == "recipient" then self:withdrawGift(t.player) -- gone before deciding: counts as a pass
        else self:decline(t.player) end
    end
end

-- May a player of `class` bid on an item (ItemFit's view of it) in the drafts? true, or false + "wrongclass" (not a
-- class the item or the guild's rule names) or "cantequip" (the class can't wear or wield it). Unknown items and
-- classes are let through.
function M.MayHave(fit, class)
    if not (fit and class) then return true end
    if fit.rule then
        if ItemFit.Allowed(fit, class) then return true end
        return false, "wrongclass"
    end
    local ok, why = ItemFit.CanUse(fit, class)
    if ok then return true end
    return false, why == "classes" and "wrongclass" or "cantequip"
end

-- What the session knows about item i (ItemFit's view: class restriction, stats), or nil while the game
-- hasn't cached it. Asked again until known: an uncached item restricts nobody.
function Session:fitOf(i)
    local it = self.items[i]
    if it and (not it.fit or it.fit.partial) then
        -- the guild's rule for this item, set ahead of time by an officer, decides who may bid
        local rule, suits = ItemFit.Rules(self.engine, it.itemId)
        it.fit = ItemFit.Describe(self.client, it.link, it.token, rule, suits) or it.fit
    end
    return it and it.fit
end

-- kind: need | off | gift | pass. extra: { to = recipient (gift), passKind = "upgrade" (pass),
-- rank = 1, 2, ... (ranked choice: when a player wants several items, which they want most; 1 = most),
-- ready = "ready" | "says" | "notready" (tokens only: can they redeem it? A hint; never enforced) }.
function Session:bid(player, itemId, kind, extra)
    extra = extra or {}
    if self.phase ~= "bidding" then return false, "closed" end
    player = norm(self, player)
    if not self.eligible[player] then self:refreshRoster() end -- someone who joined after the start
    if not self.eligible[player] or self.away[player] then return false, "ineligible" end
    if not self.items[itemId] then return false, "noitem" end
    if not (kind == "need" or kind == "off" or kind == "gift" or kind == "pass") then return false, "badkind" end
    -- A gift names who gets it, or leaves that open: if the bidder wins and still hasn't said, the draft waits for them
    -- (see the "recipient" turn) rather than guessing.
    local to
    if kind == "gift" and extra.to and extra.to ~= "" then
        to = norm(self, extra.to)
        if not to or to == player then return false, "badtarget" end
    end
    -- In the drafts, an item is only for the classes that may have it: those it names (or the guild's rule names),
    -- and, without a guild rule, only those who can equip it at all (armor type, weapon proficiency). The salvage round
    -- and the disenchanter are not restricted. Anyone may gift (win it and hand it on): what matters is who ends up
    -- with it, so the recipient must be one who may have it.
    if kind == "need" or kind == "off" then
        local ok, why = M.MayHave(self:fitOf(itemId), self.class[player])
        if not ok then return false, why end
    elseif kind == "gift" and to then
        local ok, why = M.MayHave(self:fitOf(itemId), self.class[to])
        if not ok then return false, why .. "to" end
    end
    self.bids[player] = self.bids[player] or {}
    local rank = tonumber(extra.rank)
    if rank and (rank < 1 or rank ~= math.floor(rank)) then return false, "badrank" end
    local ready
    if self.items[itemId].token and kind ~= "pass" and Tokens and Tokens.STATES[extra.ready] then ready = extra.ready end
    self.bids[player][itemId] = { kind = kind, to = to, passKind = extra.passKind, rank = rank, ready = ready }
    self:emit("bid", { player = player, item = itemId, kind = kind })
    if self:allAnswered() then self:closeBidding() end
    return true
end

---------------------------------------------------------------- whisper fallback
-- Players without the addon answer by whispering the Master Looter. Accepted forms (case does
-- not matter; several answers can be joined with commas or semicolons):
--   "need"  "off"  "pass"  "gift Name"            (when there is only one item)
--   "1 need"  "need 1"  "#2 pass"  "2: off"  "1 gift Name"   (item number, either side)
--   "pass"                                         (several items: passes on all of them)
--   "1 need ready"                                 (a token: I have what it takes to turn it in)
local WORDS = { need = "need", n = "need", greed = "off", off = "off", os = "off", offspec = "off",
    ["off-spec"] = "off", pass = "pass", p = "pass", gift = "gift", g = "gift" }

-- Returns an array of { item, kind, to, ready } (item may be nil = "all items", only for pass), or
-- nil + a reason ("empty", "unclear", "needitem", "needtarget").
function M.ParseWhisper(text, itemCount)
    if type(text) ~= "string" then return nil, "empty" end
    local answers = {}
    for part in text:lower():gmatch("[^,;]+") do
        local words = {}
        for w in part:gmatch("[^%s]+") do words[#words + 1] = w end
        if #words > 0 then
            local item, kind, to, ready
            for _, w in ipairs(words) do
                local num = w:match("^#?(%d+):?$")
                if num and not item then item = tonumber(num)
                elseif w == "ready" and not ready then ready = true
                elseif WORDS[w] and not kind then kind = WORDS[w]
                elseif kind == "gift" and not to and w:match("^[%a%-']+$") then to = w
                else return nil, "unclear" end
            end
            if not kind then return nil, "unclear" end
            if kind == "gift" and not to then return nil, "needtarget" end
            if not item then
                if itemCount == 1 then item = 1
                elseif kind == "pass" then item = nil -- all items
                else return nil, "needitem" end
            end
            answers[#answers + 1] = { item = item, kind = kind, to = to, ready = ready }
        end
    end
    if #answers == 0 then return nil, "empty" end
    return answers
end

local WHISPER_HELP = "Whisper me one answer per item, e.g. '1 need', '2 off', '1 pass', '1 gift Name'. 'pass' alone passes on everything."

local function whisperProblem(reason)
    if reason == "needitem" then return "Which item? Put its number first, e.g. '1 need'." end
    if reason == "needtarget" then return "Who should get it? e.g. '1 gift Name'." end
    return "I didn't understand that. " .. WHISPER_HELP
end

-- Handle a whispered answer from `sender`. Replies by whisper. Returns the applied answers
-- or nil + reason.
function Session:handleWhisper(sender, text)
    local answers, why = M.ParseWhisper(text, #self.items)
    if not answers then
        self.client:whisper(sender, whisperProblem(why))
        return nil, why
    end
    local applied, lines = {}, {}
    local nextRank = 1 -- items wanted are ranked in the order they were written
    for _, a in ipairs(answers) do
        local ids = {}
        if a.item then ids[1] = a.item else for _, it in ipairs(self.items) do ids[#ids + 1] = it.id end end
        for _, id in ipairs(ids) do
            local rank
            if a.kind ~= "pass" then rank, nextRank = nextRank, nextRank + 1 end
            local ok, err = self:bid(sender, id, a.kind, { to = a.to, rank = rank, ready = a.ready and "says" or nil })
            if ok then
                applied[#applied + 1] = { item = id, kind = a.kind, to = a.to }
                lines[#lines + 1] = ("%s on item %d"):format(a.kind, id)
            else
                if err == "cantequip" or err == "cantequipto" then
                    lines[#lines + 1] = ("item %d can't be worn or wielded by %s"):format(id, err == "cantequip" and "your class" or "theirs")
                elseif err == "wrongclass" or err == "wrongclassto" then
                    lines[#lines + 1] = ("item %d is only for %s"):format(id, ItemFit.ClassList(self:fitOf(id)) or "other classes")
                else
                    lines[#lines + 1] = ("could not record item %d (%s)"):format(id, tostring(err))
                end
            end
        end
    end
    self.client:whisper(sender, "Got it: " .. table.concat(lines, "; ") .. ".")
    return applied
end

-- Tell the raid what is up for grabs and how to answer without the addon. One announcement
-- per item keeps each line under the chat limit. Returns the lines sent.
function Session:announce(channel)
    local lines = { "Loot: whisper me to answer (for example '1 need', '1 off', '1 pass')." }
    for _, it in ipairs(self.items) do lines[#lines + 1] = ("%d) %s"):format(it.id, it.link) end
    for _, line in ipairs(lines) do self.client:announce(line, channel or "RAID") end
    return lines
end

function Session:allAnswered()
    for _, p in ipairs(self.eligibleList) do
        if not self.away[p] then
            for _, it in ipairs(self.items) do
                if not (self.bids[p] and self.bids[p][it.id]) then return false end
            end
        end
    end
    return true
end

-- Public view of who has answered what, for the Master Looter panel.
function Session:answerCount()
    local answered, total = 0, 0
    for _, p in ipairs(self.eligibleList) do
        if not self.away[p] then
            total = total + 1
            local all = true
            for _, it in ipairs(self.items) do
                if not (self.bids[p] and self.bids[p][it.id]) then all = false end
            end
            if all then answered = answered + 1 end
        end
    end
    return answered, total
end

function Session:extend(sec)
    if self.phase ~= "bidding" or not self.deadline then return false end
    local remaining = self.deadline - self.client:now()
    self:armTimer(math.max(remaining, 0) + sec, function() self:closeBidding() end)
    return true
end

function Session:resolveNow()
    if self.phase ~= "bidding" then return false end
    self:closeBidding()
    return true
end

function Session:closeBidding()
    if self.phase ~= "bidding" then return end
    self:clearTimer()
    self:runDraft("main")
end

---------------------------------------------------------------- the draft
local function wants(bid, tier)
    if not bid then return false end
    if tier == "main" then return bid.kind == "need" or bid.kind == "gift" end
    return bid.kind == "off"
end

-- Who would hold the item if `name` won it in `tier`: the gift target, or the winner.
function Session:recipient(name, itemId, tier)
    local bid = self.bids[name] and self.bids[name][itemId]
    return (tier == "main" and bid and bid.kind == "gift" and bid.to) or name
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
            M.Shuffle(self.client, newcomers)
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
    local isGift = (not toOverride) and bid and bid.kind == "gift" and tier == "main"
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
    return (M.MayHave(self:fitOf(itemId), self.class[norm(self, player)]))
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
    local ok, why2 = M.MayHave(self:fitOf(t.item), self.class[to])
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
    self:emit("phase", { phase = tier })
    self:continueDraft(tier)
end

function Session:continueDraft(tier)
    if self.turn and self.turn.type == "recipient" then return end
    while true do
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
    if tier == "main" then self:runDraft("off") else self:runSalvage() end
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

---------------------------------------------------------------- salvage and disenchant
-- Items nobody drafted are offered lowest position first, with no usability gate.
function Session:runSalvage()
    self.phase = "salvage"
    self.queue = {}
    for _, it in ipairs(self.items) do
        if it.status == "open" then self.queue[#self.queue + 1] = it.id end
    end
    self.qi = 0
    -- Who is offered first, lowest on the live list first. A player who claims an item goes to the back of this queue
    -- for the rest of the round, so the salvager rotates through a batch (it never depends on how loot was batched).
    self.offerQueue = {}
    for i = #self.order.main, 1, -1 do self.offerQueue[#self.offerQueue + 1] = self.order.main[i] end
    self:emit("phase", { phase = "salvage" })
    self:nextSalvageItem()
end

function Session:nextSalvageItem()
    self.qi = self.qi + 1
    local id = self.queue[self.qi]
    if not id then return self:finish() end
    local players = {}
    for _, p in ipairs(self.offerQueue) do
        if self.eligible[p] and self:canReceive(p, self.items[id]) then players[#players + 1] = p end
    end
    self.claim = { item = id, players = players, idx = 0 }
    self:offerNext()
end

function Session:offerNext()
    local c = self.claim
    c.idx = c.idx + 1
    local player = c.players[c.idx]
    if not player then
        self.items[c.item].status, self.items[c.item].tier = "de", "de"
        self.turn = nil
        return self:nextSalvageItem()
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
        local ok, why = M.MayHave(self:fitOf(t.item), self.class[to])
        if not ok then return false, why .. "to" end
    end
    self.turn = nil
    self:award("salvage", player, t.item, to)
    moveToBottom(self.offerQueue, player) -- to the back of the queue for the rest of this round
    self:nextSalvageItem()
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
    -- Explicit passes that carry a kind (e.g. "upgrade") are recorded for the transparency stats.
    -- pairs() order is not stable, so collect and sort them before appending.
    local passes = {}
    for p, items in pairs(self.bids) do
        for itemId, b in pairs(items) do
            if b.kind == "pass" and b.passKind then
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
                local ev, err = engine:Append(a.list, "Award",
                    { member = a.member, item = a.item.link, to = (a.to ~= a.member) and a.to or nil, seen = a.item.seen })
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
    self:emit("done", { failures = failures })
    return true, failures
end

function Session:cancel()
    if self.phase == "done" or self.phase == "cancelled" then return false end
    self:clearTimer()
    self.turn, self.pending = nil, {}
    self:unwatchRoster()
    self.phase = "cancelled"
    self:emit("phase", { phase = "cancelled" })
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
