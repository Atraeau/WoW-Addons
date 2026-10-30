-- King's Gambit: the loot session and draft engine (Phase 4).
-- Pure logic over an Engine and its Client: no WoW calls, no frames. A Session takes a
-- batch of items through bidding, the tiered priority draft, the backstop and the
-- disenchant floor, then (after confirmation) hands the items out and records the results
-- in the ledger. Rules: docs/kings-gambit/rationale.md.
--
--   bidding  -> main draft -> off-spec draft -> backstop -> disenchant -> review -> done
--
-- The draft works on scratch copies of the standings, so picks can be made live while
-- nothing is written to the ledger until confirm(). Winners drop to the bottom of the
-- scratch order exactly as the ledger will replay them.
local _, SK = ...
local M = SK:NewModule("Loot")

local DEFAULTS = {
    listId = "main",
    offListId = "off",
    bidSeconds = 30,     -- 0 = open-ended: the Master Looter calls resolveNow()
    pickSeconds = 20,    -- a draft turn that times out counts as a skip
    claimSeconds = 10,   -- a backstop offer that times out counts as a decline
    autoEnroll = true,   -- unlisted raiders are added to the bottom of the main list
    deHandler = nil,     -- who disenchants when nobody wants an item (default: this client)
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
        items = {}, eligible = {}, eligibleList = {}, class = {},
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

    -- When the loot became visible: each item may say (loot held for a later hand-out); default now. Events
    -- the session writes carry it as `seen`, so the ledger orders them by drop time, not hand-out time.
    local now = self.client:serverTime()
    self.seen = now
    for _, it in ipairs(items) do
        local s = tonumber(it.seen)
        if s and s <= now and s < self.seen then self.seen = s end
    end
    for _, m in ipairs(self.client:roster()) do
        if m.online then
            self.class[m.name] = m.class
            local mem = main.state.members[m.name]
            if not (mem and mem.active) and cfg.autoEnroll then
                self.engine:Append(cfg.listId, "AddMember", { member = m.name, class = m.class, seen = self.seen })
                mem = main.state.members[m.name]
            end
            if mem and mem.active then
                self.eligible[m.name] = true
                self.eligibleList[#self.eligibleList + 1] = m.name
            end
        end
    end

    for i, it in ipairs(items) do
        if type(it.link) ~= "string" or it.link == "" then return false, "badlink" end
        local s = tonumber(it.seen)
        if not (s and s <= now) then s = now end
        local Tokens = SK.modules.Tokens
        self.items[i] = { id = i, link = it.link, slot = it.slot, status = "open", seen = s,
            token = Tokens and Tokens.Find(it.link) or nil }
    end
    self.order.main = copy(main.state.order)
    self.phase = "bidding"
    self:armTimer(cfg.bidSeconds, function() self:closeBidding() end)
    self:emit("phase", { phase = "bidding" })
    return true
end

-- kind: need | off | gift | pass. extra: { to = recipient (gift), passKind = "upgrade" (pass),
-- rank = 1, 2, ... (ranked choice: when a player wants several items, which they want most; 1 = most),
-- ready = "ready" | "says" | "notready" (tokens only: can they redeem it? A hint; never enforced) }.
function Session:bid(player, itemId, kind, extra)
    extra = extra or {}
    if self.phase ~= "bidding" then return false, "closed" end
    player = norm(self, player)
    if not self.eligible[player] then return false, "ineligible" end
    if not self.items[itemId] then return false, "noitem" end
    if not (kind == "need" or kind == "off" or kind == "gift" or kind == "pass") then return false, "badkind" end
    local to
    if kind == "gift" then
        to = norm(self, extra.to)
        if not to or to == player then return false, "badtarget" end
    end
    self.bids[player] = self.bids[player] or {}
    local rank = tonumber(extra.rank)
    if rank and (rank < 1 or rank ~= math.floor(rank)) then return false, "badrank" end
    local ready
    if self.items[itemId].token and kind ~= "pass" and SK.modules.Tokens.STATES[extra.ready] then ready = extra.ready end
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
                lines[#lines + 1] = ("could not record item %d (%s)"):format(id, tostring(err))
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
        for _, it in ipairs(self.items) do
            if not (self.bids[p] and self.bids[p][it.id]) then return false end
        end
    end
    return true
end

-- Public view of who has answered what, for the Master Looter panel.
function Session:answerCount()
    local answered = 0
    for _, p in ipairs(self.eligibleList) do
        local all = true
        for _, it in ipairs(self.items) do
            if not (self.bids[p] and self.bids[p][it.id]) then all = false end
        end
        if all then answered = answered + 1 end
    end
    return answered, #self.eligibleList
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

function Session:hasBid(player, itemId, tier)
    return wants(self.bids[player] and self.bids[player][itemId], tier)
end

-- The first player in scratch order with a live bid, plus the open items they bid on.
function Session:topCandidate(tier)
    for _, name in ipairs(self.order[tier]) do
        if self.eligible[name] and not self.skipped[tier][name] then
            local opts = {}
            for _, it in ipairs(self.items) do
                if it.status == "open" and self:hasBid(name, it.id, tier) then opts[#opts + 1] = it.id end
            end
            if #opts > 0 then return name, opts end
        end
    end
end

-- Lazy enrollment: off-spec bidders not yet on the off list join at its bottom.
function Session:buildOffOrder()
    local off = self.engine:Get(self.cfg.offListId)
    local order = off and copy(off.state.order) or {}
    local seen = {}
    for _, n in ipairs(order) do seen[n] = true end
    for _, name in ipairs(self.order.main) do
        if self.eligible[name] and not seen[name] then
            for _, it in ipairs(self.items) do
                if it.status == "open" and self:hasBid(name, it.id, "off") then
                    order[#order + 1] = name
                    seen[name] = true
                    self.pending[#self.pending + 1] = { type = "enroll", list = self.cfg.offListId, member = name }
                    break
                end
            end
        end
    end
    self.order.off = order
end

function Session:award(tier, who, itemId, toOverride)
    local it = self.items[itemId]
    local bid = self.bids[who] and self.bids[who][itemId]
    local to = toOverride or ((bid and bid.kind == "gift" and tier == "main") and bid.to or who)
    it.status, it.winner, it.to, it.tier = "awarded", who, to, tier
    local list = (tier == "off") and self.cfg.offListId or self.cfg.listId
    moveToBottom(self.order[tier == "off" and "off" or "main"], who)
    local action = { type = "award", list = list, member = who, to = to, item = it, tier = tier }
    self.pending[#self.pending + 1] = action
    self:emit("pending", action)
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
    while true do
        local who, opts = self:topCandidate(tier)
        if not who then break end
        local ranked = self:rankedChoice(who, opts)
        if #opts == 1 then
            self:award(tier, who, opts[1])
        elseif ranked then
            self:award(tier, who, ranked) -- ranked choice: their most-wanted item still available
        else
            self:setTurn({ type = "pick", tier = tier, player = who, options = opts },
                self.cfg.pickSeconds, function() self:skip(who) end)
            return
        end
    end
    self.turn = nil
    self:clearTimer()
    if tier == "main" then self:runDraft("off") else self:runBackstop() end
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
    self:continueDraft(t.tier)
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

---------------------------------------------------------------- backstop and disenchant
-- Items nobody drafted are offered lowest position first, with no usability gate.
function Session:runBackstop()
    self.phase = "backstop"
    self.queue = {}
    for _, it in ipairs(self.items) do
        if it.status == "open" then self.queue[#self.queue + 1] = it.id end
    end
    self.qi = 0
    self:emit("phase", { phase = "backstop" })
    self:nextBackstopItem()
end

function Session:nextBackstopItem()
    self.qi = self.qi + 1
    local id = self.queue[self.qi]
    if not id then return self:finish() end
    local players = {}
    for i = #self.order.main, 1, -1 do
        if self.eligible[self.order.main[i]] then players[#players + 1] = self.order.main[i] end
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
        return self:nextBackstopItem()
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
    end
    self.turn = nil
    self:award("backstop", player, t.item, to)
    self:nextBackstopItem()
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
    local handler = self.cfg.deHandler or self.client:me()
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

    for _, a in ipairs(self.pending) do
        if a.type == "enroll" then
            if not engine:Get(a.list) then engine:Write("CreateList", { name = "Off-spec", seen = self.seen }, a.list) end
            local ev, err = engine:Append(a.list, "AddMember", { member = a.member, class = self.class[a.member], seen = self.seen })
            if not ev then fail(a, "ledger", err) end
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
    return { phase = self.phase, turn = self.turn, items = self.items, pending = self.pending,
        answered = answered, eligible = total, deadline = self.deadline }
end
