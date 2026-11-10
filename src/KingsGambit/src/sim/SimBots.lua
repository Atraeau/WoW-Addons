-- King's Gambit: the practice raid, the simulated raiders: who is a bot, what each answers, how a drop reaches them, and how they act on a session. Keep this file Lua 5.1-safe.
-- Part of Sim (sim/Sim.lua): Sim calls Install, which adds these to the Sim class.
local _, SK = ...
local Loot
local P = SK:NewModule("SimBots", { "Loot" }, function(d) Loot = d.Loot end)

-- M, Sim: the table to add to; h: what Sim shares (and what the parts installed before this one exported).
function P.Install(M, Sim, h)
local short = h.short

function Sim:note(text) self.log[#self.log + 1] = { t = self.client:now(), text = text } end

function Sim:isBot(fullName)
    if fullName == self.learner then return self.autoLearner end
    return true
end

-- A raider's policy: keyed by their canonical name (First_Last), or by the plain name a scenario writes ("Aldric", "You").
function Sim:policyFor(fullName) return self.policies[fullName] or self.policies[short(fullName)] or {} end

local function wantedKind(policy, link)
    local b = policy.bid and policy.bid[link]
    if b == nil then b = policy.default or "pass" end
    if type(b) == "table" then return b[1], b end
    return b, nil
end

-- Start a loot session for these item links and wire the bots to it.
-- cfg overrides Loot defaults (bidSeconds, pickSeconds, ...).
-- seen (optional): for each link, when that loot became visible (held loot dropped earlier).
-- ids (optional): each link's item id (the simulator's links are plain names).
function Sim:drop(links, cfg, seen, ids)
    -- With specs required (the game's rule, practice's raid nights), the bots' specs are on record for the raid; the learner's is theirs to choose.
    if self.requireSpec then
        local c = {}
        for k, v in pairs(cfg or {}) do c[k] = v end
        if c.requireSpec == nil then c.requireSpec = true end
        cfg = c
        self:recordSpecs()
    end
    -- A simulation that plays as the game does (practice mode, the web page) asks for rankings, like the game's host.
    if self.rankingRequired then
        local c = {}
        for k, v in pairs(cfg or {}) do c[k] = v end
        if c.requireRanking == nil then c.requireRanking = true end
        -- whispered replies as in the game: one reply per burst, one message at a time
        if c.whisperSettle == nil then c.whisperSettle = 3 end
        if c.whisperGap == nil then c.whisperGap = 0.4 end
        if c.bidSecondsPerItem == nil then c.bidSecondsPerItem = 8 end
        cfg = c
    end
    local drops, items = {}, {}
    for i, link in ipairs(links) do
        -- A link that names a known raid item is taught to the game client like a real drop (slot, stats, the
        -- classes it names), so the class and proficiency rules apply to it. Other names are unknown items.
        local known = M.FindItem(link)
        if known then
            self:teach(known)
            ids = ids or {}
            ids[i] = ids[i] or known.id
        end
        drops[i] = { link = link }
        items[i] = { link = link, slot = i, seen = seen and seen[i] or nil, itemId = ids and ids[i] or nil }
    end
    self.client:dropLoot(drops)
    local session = Loot.NewSession(self.engine, cfg)
    local ok, why = session:start(items)
    if not ok then return false, why end -- (e.g. the loot method is not Master Looter: nothing is started)
    self.session = session
    if self.onSession then self.onSession(session) end -- (practice's raider-without-the-addon mode whispers its menu from here)
    self:wireBots()
    return true
end

function Sim:wireBots()
    local s, client = self.session, self.client
    -- Cancelling records nothing, and the loot is still on the boss: what was handed out goes back to held, to be handed out again.
    s:on("phase", function(p)
        if p.phase == "cancelled" and self.handedOut and #self.held == 0 then
            self.held, self.handedOut = self.handedOut, nil
        end
    end)
    s:on("done", function() self.handedOut = nil end)
    -- Bids trickle in over the first part of the timer, in a repeatable order.
    local window = math.max(2, math.min((s.cfg.bidSeconds or 30) - 4, 6)) -- (simulated raiders answer within a few seconds: nobody waits on a bot)
    for _, name in ipairs(s.eligibleList) do
        if self:isBot(name) then
            local policy = self:policyFor(name)
            -- When the session asks for rankings, a bot ranks the items it wants of each kind by its preference (its `pick` list), else by item number.
            local ranks = {}
            if s.cfg.requireRanking then
                local byKind = {}
                for _, it in ipairs(s.items) do
                    local kind = wantedKind(policy, it.link)
                    if kind ~= "pass" then byKind[kind] = byKind[kind] or {}; table.insert(byKind[kind], it) end
                end
                local prefs = type(policy.pick) == "table" and policy.pick or {}
                local function preference(it)
                    for i, link in ipairs(prefs) do if link == it.link then return i end end
                    return #prefs + 1
                end
                for _, list in pairs(byKind) do
                    table.sort(list, function(a, b)
                        local pa, pb = preference(a), preference(b)
                        if pa ~= pb then return pa < pb end
                        return a.id < b.id
                    end)
                    for i, it in ipairs(list) do ranks[it.id] = i end
                end
            end
            for _, it in ipairs(s.items) do
                client:after(1 + client:random() * window, function()
                    if s.phase ~= "bidding" then return end
                    local kind, extra = wantedKind(policy, it.link)
                    if ranks[it.id] and not (extra and extra.rank) then -- (a rank the scenario gives itself is the raider's own choice)
                        local e = {}
                        for k, v in pairs(extra or {}) do e[k] = v end
                        e.rank = ranks[it.id]
                        extra = e
                    end
                    s:bid(name, it.id, kind, extra)
                end)
            end
        end
    end
    s:on("turn", function(turn)
        if not self:isBot(turn.player) then return end
        local policy = self:policyFor(turn.player)
        client:after(1 + client:random() * 3, function()
            if s.turn ~= turn then return end
            if turn.type == "recipient" then
                -- a bot that bid to gift without saying who: it names someone who may have the item, else withdraws
                local named
                for _, n in ipairs(s.eligibleList) do
                    if not named and n ~= turn.player and not s.away[n] and select(1, Loot.MayHave(s:fitOf(turn.item), s.class[n])) then named = n end
                end
                if named then s:chooseRecipient(turn.player, named) else s:withdrawGift(turn.player) end
            elseif turn.type == "pick" then
                local pick
                if not policy.skip then
                    local prefs = type(policy.pick) == "table" and policy.pick or nil
                    if prefs then
                        for _, link in ipairs(prefs) do
                            for _, id in ipairs(turn.options) do
                                if s.items[id].link == link and not pick then pick = id end
                            end
                        end
                    end
                    pick = pick or turn.options[1]
                end
                if pick then s:pick(turn.player, pick) else s:skip(turn.player) end
            else
                if policy.claim then s:claimItem(turn.player, policy.claimTo and { to = policy.claimTo } or nil)
                else s:decline(turn.player) end
            end
        end)
    end)
end
end
