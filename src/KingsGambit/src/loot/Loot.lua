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
local installParts -- defined at the end of the file: the Session methods live in LootWhispers.lua, LootDraft.lua and LootFinish.lua
local M = SK:NewModule("Loot", { "ItemFit", "Tokens?", "LootWhispers", "LootDraft", "LootFinish" }, function(d)
    Tokens, ItemFit = d.Tokens, d.ItemFit
    installParts(d)
end)

local DEFAULTS = {
    listId = nil,        -- the list the raid plays on: normally the one its raid named (the engine knows), else main
    offListId = nil,     -- ... and its off-spec list (derived from it)
    bidSeconds = 30,     -- 0 = open-ended: the Master Looter calls resolveNow()
    bidSecondsPerItem = 0, -- more items, more time: each item after the first adds this many seconds (up to bidSecondsMax). 0 = a flat bidSeconds. The Master Looter can always end early. The game's host and the practice raid use 8.
    bidSecondsMax = 300,
    pickSeconds = 20,    -- a draft turn that times out counts as a skip
    claimSeconds = 10,   -- a salvage offer that times out counts as a decline
    requireRanking = false, -- a player who wants two or more items of one kind (needs, off-spec, gifts) must rank them before they count as
                         -- having answered, so bidding can't close early on them. Off here so a bare session behaves as before; the game's
                         -- host (LootNet) and the practice raid turn it on.
    requireSpec = false, -- a player must have a spec on record for the raid (see Ledger.lua, SetSpec) before they may bid; a Need must suit that spec. Off in a
                         -- bare session; the game's host and the practice raid turn it on.
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
        bids = {}, pending = {}, order = {}, skipped = { main = {}, off = {}, gift = {} },
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

function Session:unwatchMethod()
    if self.unwatchLoot then self.unwatchLoot(); self.unwatchLoot = nil end
end

-- The raid leader changed the loot method, or the Master Looter, while a session was running: it can no longer hand
-- anything out, so it is cancelled. Nothing was written to the ledger before confirm, so only the answers are lost.
function Session:lootMethodChanged()
    if self.phase == "idle" or self.phase == "done" or self.phase == "cancelled" then return end
    if self.client:lootMethod() ~= "master" or self.client:masterLooter() ~= self.client:me() then
        self:cancel("lootmethod")
    end
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
    if not cfg.listId then
        local named, raid = self.engine:RaidList()
        if raid and not named then return false, "nolistchosen" end
        cfg.listId = named or "main"
    end
    cfg.offListId = cfg.offListId or self.engine:OffListOf(cfg.listId)
    if cfg.listId ~= "main" and not self.engine:Get(cfg.listId) then self.engine:EnsureList(cfg.listId) end
    local main = self.engine:Get(cfg.listId)
    if not main then return false, "nolist" end
    if #items == 0 then return false, "noitems" end
    -- Loot is not handed out until the raid leader has set the loot method to Master Looter and named a Master Looter,
    -- and only that Master Looter runs a session. (The game decides who may change the loot method: the leader.)
    if self.client:lootMethod() ~= "master" then return false, "notmasterloot" end
    if self.client:masterLooter() ~= self.client:me() then return false, "notml" end
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
    -- Many items need more time to read and answer: the time grows with the number of items (the Master Looter can end it early).
    if (cfg.bidSeconds or 0) > 0 and (cfg.bidSecondsPerItem or 0) > 0 and #self.items > 1 then
        cfg.bidSeconds = math.min(math.max(cfg.bidSecondsMax or 300, cfg.bidSeconds), cfg.bidSeconds + cfg.bidSecondsPerItem * (#self.items - 1))
    end
    self:armTimer(cfg.bidSeconds, function() self:closeBidding() end)
    self.unwatch = self.client:on("roster.changed", function() self:rosterChanged() end)
    self.unwatchLoot = self.client:on("lootMethod.changed", function() self:lootMethodChanged() end)
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
-- class the item or the guild's rule names), "cantequip" (the class can't wear or wield it) or "nostats" (it can, but
-- the item's stats do nothing for any of the class's specs). Unknown items and classes are let through, and a guild
-- rule decides on its own.
function M.MayHave(fit, class)
    if not (fit and class) then return true end
    if fit.rule then
        if ItemFit.Allowed(fit, class) then return true end
        return false, "wrongclass"
    end
    local ok, why = ItemFit.CanUse(fit, class)
    if not ok then return false, why == "classes" and "wrongclass" or "cantequip" end
    if not ItemFit.Worthwhile(fit, class) then return false, "nostats" end
    return true
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
-- The raid this session is for (the one its Master Looter runs), and a player's spec on record for it.
function Session:raidId()
    local me = self.client:me()
    for _, r in ipairs(self.engine:ActiveRaids()) do if r.ml == me then return r.id end end
end
function Session:specOf(player)
    local id = self:raidId()
    return id and self.engine:SpecOf(id, norm(self, player)) or nil
end

-- Record a player's spec for the raid: the first one stands for the whole raid (an officer corrects a mistake). Returns true, or false + why.
function Session:setSpec(player, name)
    player = norm(self, player)
    local class = self.class[player]
    local spec = ItemFit.FindSpec(class, name)
    if not spec then return false, "badspec" end
    local id = self:raidId()
    if not id then return false, "noraid" end
    if self.engine:SpecOf(id, player) then return false, "specset" end
    local ev, err = self.engine:Write("SetSpec", { raid = id, member = player, spec = spec.name, role = spec.role, class = class })
    if not ev then return false, err or "refused" end
    self:emit("spec", { player = player, spec = spec.name })
    return true
end

function Session:bid(player, itemId, kind, extra)
    extra = extra or {}
    if self.phase ~= "bidding" then return false, "closed" end
    player = norm(self, player)
    if not self.eligible[player] then self:refreshRoster() end -- someone who joined after the start
    if not self.eligible[player] or self.away[player] then return false, "ineligible" end
    if not self.items[itemId] then return false, "noitem" end
    if not (kind == "need" or kind == "off" or kind == "gift" or kind == "pass") then return false, "badkind" end
    -- With a spec required: no spec on record, no answer but a pass; and a Need has to suit the spec (otherwise it is an Off-spec)
    if self.cfg.requireSpec and kind ~= "pass" then
        local sp = self:specOf(player)
        if not sp then return false, "needspec" end
        if kind == "need" then
            local ok, why = ItemFit.NeedOk(self:fitOf(itemId), self.class[player], sp.spec)
            if not ok then return false, why end
        end
    end
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



-- Tell the raid what is up for grabs and how to answer without the addon. One announcement
-- per item keeps each line under the chat limit. Returns the lines sent.
function Session:announce(channel)
    local lines = { "Loot: whisper me to answer (for example '1 need', '1 off', '1 pass')." }
    for _, it in ipairs(self.items) do lines[#lines + 1] = ("%d) %s"):format(it.id, it.link) end
    for _, line in ipairs(lines) do self.client:announce(line, channel or "RAID") end
    return lines
end

-- Has this player left two or more answers of one kind (needs, off-spec, gifts) without a rank? Then which they want most is not settled:
-- with `requireRanking` they don't count as having answered yet.
function Session:rankingMissing(p)
    local count, unranked = {}, {}
    for _, b in pairs(self.bids[p] or {}) do
        if b.kind ~= "pass" then
            count[b.kind] = (count[b.kind] or 0) + 1
            if not b.rank then unranked[b.kind] = true end
        end
    end
    for kind, n in pairs(count) do
        if n >= 2 and unranked[kind] then return true end
    end
    return false
end

function Session:allAnswered()
    for _, p in ipairs(self.eligibleList) do
        if not self.away[p] then
            for _, it in ipairs(self.items) do
                if not (self.bids[p] and self.bids[p][it.id]) then return false end
            end
            if self.cfg.requireRanking and self:rankingMissing(p) then return false end
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
            if all and self.cfg.requireRanking and self:rankingMissing(p) then all = false end
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

-- Add the other files' methods to the Session class (once every module is loaded: see Registry.lua), handing them the helpers they share.
function installParts(d)
    local h = { copy = copy, indexOf = indexOf, moveToBottom = moveToBottom, norm = norm, MayHave = M.MayHave, Shuffle = M.Shuffle }
    d.LootWhispers.Install(Session, h)
    d.LootDraft.Install(Session, h)
    d.LootFinish.Install(Session, h)
    M.ParseWhisper = d.LootWhispers.ParseWhisper
end
