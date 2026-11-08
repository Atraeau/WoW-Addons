-- King's Gambit: what the Loot window reads from a session (Model, pure and tested). Keep this file Lua 5.1-safe.
-- The buttons that answer it are in LootWindow, drawn from LootView; every button runs the same command a player would type, so the rules and the
-- ledger are exactly those of the commands. The Master Looter's own session and a player's view of someone else's are read from the same place the commands read.
local _, SK = ...
local Identity, Sim, Tips, ItemFit
local M = SK:NewModule("UILoot", { "Identity", "Sim?", "UITips", "ItemFit" }, function(d) Identity, Sim, Tips, ItemFit = d.Identity, d.Sim, d.UITips, d.ItemFit end)

M.MAX_ITEMS = 24

local PHASES = {
    bidding = "Bidding is open",
    main = "Main-spec draft",
    off = "Off-spec draft",
    gift = "Gift draft",
    salvage = "Salvage: items nobody wanted",
    review = "Review: confirm to hand the loot out",
    done = "Finished",
    cancelled = "Cancelled: nothing was recorded",
}
M.PHASES = PHASES

local function show(who) return who and Identity.Display(who) end

-- Does this game have an item with that id at all? (Its static item data, not the server's: true for any real item, cached or not.)
-- Without the function to ask, assume yes.
function M.KnownToGame(id)
    local instant = (C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
    if not instant then return true end
    local ok, known = pcall(instant, id)
    return ok and known ~= nil
end

-- What the game can show a tooltip for: a real item link as it came, or (in practice, where the simulated drops are named) "item:ID".
function M.TipOf(link)
    if type(link) ~= "string" then return nil end
    if link:find("|Hitem:", 1, true) or link:find("^item:") then return link end
    local it = Sim and Sim.FindItem and Sim.FindItem(link)
    if it and M.KnownToGame(it.id) then return "item:" .. it.id end
    return nil
end

-- The link to show: the game's own when it has the item cached, else (and the game is asked to load the item, so a moment later) a link made from the
-- id and the name, which looks and hovers like the real one.
function M.Display(link, tip)
    if link and link:find("|H", 1, true) then return link end
    local id = tip and tonumber(tip:match("^item:(%d+)"))
    if not id then return link or "?" end
    local get = (C_Item and C_Item.GetItemInfo) or GetItemInfo
    if get then
        local _, full = get(tip)
        if full then return full end
    end
    if C_Item and C_Item.RequestLoadItemDataByID then pcall(C_Item.RequestLoadItemDataByID, id) end
    return ("|cffa335ee|Hitem:%d::::::::::::|h[%s]|h|r"):format(id, link or ("item " .. id))
end

-- The session this machine can see: the one it runs as Master Looter, else the one it is answering.
local function sessionOf(ctx)
    local host = ctx.host and ctx.host.session
    if host and host.phase ~= "idle" then return host, "ml" end
    local p = ctx.player and ctx.player.session
    if p then return p, "player" end
end

-- ctx: { client, host, player, sim (practice only) }. Returns what the tab shows.
function M.Model(ctx)
    local me = ctx.client:me()
    local out = { mode = "none", items = {}, hidden = 0, me = me, can = {} }
    local s, mode = sessionOf(ctx)
    if ctx.sim then
        local sim = ctx.sim
        local nextBoss = sim.raid and sim.raid.bosses[sim.bossIndex + 1]
        local busy = sim.session and sim.session.phase ~= "done" and sim.session.phase ~= "cancelled"
        out.night = { nextBoss = nextBoss and nextBoss.name, killed = sim.bossIndex, held = #sim.held, raidOpen = sim:raidOpen(), raidNo = sim.raidNo or 1,
            absent = sim:absentCount(), busy = busy and true or false, canLeave = sim:raidOpen() and #sim.roster - sim:absentCount() > 6 }
    end
    -- A lesson (practice mode's tutorials): its text, whether it has started, and, when the hand-out is over, whether what was done matches it.
    if ctx.sim and ctx.sim.lesson then
        local sc = ctx.sim.lesson
        out.lesson = { id = sc.id, title = sc.title, text = sc.lesson, started = ctx.sim.lessonStarted and true or false, verdict = ctx.sim:verdict(),
            index = ctx.lessonIndex, count = ctx.lessonCount }
    end
    if not s then return out end
    out.mode, out.phase = mode, s.phase
    out.sessionKey = tostring(s)
    out.phaseText = PHASES[s.phase] or tostring(s.phase)
    local now = ctx.client:now()
    local deadline = (mode == "ml" and s.deadline) or (s.turn and s.turn.deadline) or s.deadline
    out.seconds = deadline and math.max(0, math.floor(deadline - now + 0.5)) or nil
    out.active = s.phase ~= "done" and s.phase ~= "cancelled"
    -- How long the timer started with (for a bar that drains): the bid time, or a pick's or a claim's.
    local cfg = s.cfg or {}
    if s.turn then out.total = s.turn.type == "claim" and cfg.claimSeconds or cfg.pickSeconds
    elseif s.phase == "bidding" then out.total = cfg.bidSeconds end
    if ctx.place then out.place = ctx.place() end
    -- The Master Looter's controls belong to the Master Looter. (The session is read from the same place either way; on the practice
    -- page a bot can hold the role while the player only answers, which ctx.isML = false says.)
    out.isML = mode == "ml" and ctx.isML ~= false
    -- Who a name is: their display name, class (from the group) and spec (only where the practice raid knows it; the game doesn't tell us others' specs).
    local classOf = {}
    for _, member in ipairs((ctx.client.roster and ctx.client:roster()) or {}) do classOf[member.name] = member.class end
    -- The spec on record for a player in this raid (the ledger's, from the host; a player's window is told it with the session).
    local function recordedSpec(full)
        if mode == "ml" then
            local sp = s.specOf and s:specOf(full)
            return sp and sp.spec
        end
        return s.specs and s.specs[full]
    end
    local function whoOf(full)
        if not full then return nil end
        local name = show(full)
        local info = { name = name, class = classOf[full] }
        local known = ctx.sim and ctx.sim.info and (ctx.sim.info[full] or ctx.sim.info[name])
        if known then info.class, info.spec = info.class or known.class, known.spec end
        info.spec = recordedSpec(full) or info.spec
        return info
    end
    -- Is a spec needed before this player may answer? Then the window asks (the choices are their class's specs; the talents' pick comes first).
    local needSpec = (mode == "ml" and (s.cfg or {}).requireSpec) or (mode == "player" and s.requireSpec)
    if needSpec then
        local myClass = ctx.client.myClass and ctx.client:myClass()
        local detected = ctx.client.mySpec and ctx.client:mySpec()
        local mine = recordedSpec(me)
        out.spec = { mine = mine, class = myClass, options = myClass and ItemFit.SpecNames(myClass) or {},
            detected = detected and ItemFit.FindSpec(myClass or "", detected) and ItemFit.FindSpec(myClass, detected).name or nil,
            auto = ctx.autoSpec and ctx.autoSpec() or false }
    end
    -- Who may be given an item (only those who can have it): the context's own list (the practice page), else the commands'.
    local targetsFn = ctx.targets or (ctx.commands and ctx.commands.giftTargets)
    local list = s.items or {}
    -- What the session will record, by item (the draft adds to it as it goes): where each winner was on the list, and who has not said who gets a gift.
    local pendingFor = {}
    for _, a in ipairs(s.pending or {}) do
        if a.type == "award" and a.item then pendingFor[a.item.id or 0] = a end
    end
    for i, it in ipairs(list) do
        if i > M.MAX_ITEMS then out.hidden = out.hidden + 1
        else
            local row = { id = it.id or i, link = it.link, tip = M.TipOf(it.link), status = it.status }
            if mode == "ml" then
                local b = s.bids[me] and s.bids[me][it.id]
                row.mine, row.mineTo, row.mineRank = b and b.kind, b and show(b.to), b and b.rank
                row.winner, row.to, row.tier = show(it.winner), show(it.to), it.tier
                row.winnerIsMe, row.toIsMe = it.winner ~= nil and it.winner == me, it.to ~= nil and it.to == me
                row.winnerWho, row.toWho = whoOf(it.winner), whoOf(it.to)
                local a = pendingFor[it.id or 0]
                if a then row.from, row.undecided = a.fromIndex, a.undecided end
                if it.status == "de" then row.deTo = show(s.deHandler) end
            else
                local b = s.mine and s.mine[it.id or i]
                row.mine, row.mineTo, row.mineRank = b and b.kind, b and show(b.to), b and b.rank
                for _, a in ipairs(s.results and s.results.awards or {}) do
                    if a.item == row.id then
                        row.status, row.winner, row.to, row.tier = "awarded", show(a.winner), show(a.to), a.tier
                        row.winnerIsMe, row.toIsMe = a.winner == me, a.to ~= nil and a.to == me
                        row.winnerWho, row.toWho = whoOf(a.winner), whoOf(a.to)
                    end
                end
            end
            row.giftTargets = targetsFn and targetsFn(row.id) or nil
            row.canBid, row.whyNot = true, nil
            if ctx.commands and ctx.commands.mayHave then
                local ok, whyNot = ctx.commands.mayHave(row.id)
                if ok == false then row.canBid, row.whyNot = false, whyNot end
            end
            -- with a spec on record, a Need has to suit it (a Fury Warrior's Need on a tanking item is an Off-spec)
            if row.canBid and out.spec and out.spec.mine and ctx.commands and ctx.commands.needOk then
                row.needOk = ctx.commands.needOk(row.id, out.spec.mine)
            end
            out.items[#out.items + 1] = row
        end
    end
    -- Everyone's answers, which are public: for each item, who said Need, Off-spec and Gift (in list order), how many passed and how many have not answered yet.
    -- The Master Looter reads them from the session; a player has them from the host's announcements.
    do
        local people = mode == "ml" and s.eligibleList or s.who or {}
        local board = (mode == "ml" and s.bids) or s.answers or {}
        out.board = {}
        for _, row in ipairs(out.items) do
            local entry = { id = row.id, link = row.link, need = {}, off = {}, gift = {}, pass = 0, waiting = 0, all = {} }
            for place, name in ipairs(people) do
                local b = board[name] and board[name][row.id]
                local kind = b and b.kind or "waiting"
                if not b then
                    if not (s.away and s.away[name]) then entry.waiting = entry.waiting + 1 else kind = "away" end
                elseif b.kind == "pass" then entry.pass = entry.pass + 1
                elseif type(entry[b.kind]) == "table" then table.insert(entry[b.kind], whoOf(name))
                end
                -- everyone, for the detail: their place on the list, what they said and (for a gift) who to
                entry.all[#entry.all + 1] = { who = whoOf(name), place = place, kind = kind, to = b and b.to and show(b.to) or nil }
            end
            out.board[#out.board + 1] = entry
        end
    end
    -- Where the player wants several items of one kind (needs, off-spec, gifts), the order they want them in: ranked ones first, in rank order, then the
    -- ones not yet ranked by item number. `complete` is true once every one has a rank.
    out.rankings = {}
    local groups = {}
    for _, row in ipairs(out.items) do
        if row.mine and row.mine ~= "pass" then
            groups[row.mine] = groups[row.mine] or {}
            table.insert(groups[row.mine], row)
        end
    end
    for _, kind in ipairs({ "need", "off", "gift" }) do
        local g = groups[kind]
        if g and #g >= 2 then
            table.sort(g, function(a, b)
                local ra, rb = a.mineRank or math.huge, b.mineRank or math.huge
                if ra ~= rb then return ra < rb end
                return a.id < b.id
            end)
            -- The order shown is the player's draft while they are rearranging (ctx.rankDraft[kind], a list of item ids kept by whatever draws the window),
            -- as long as it names exactly these items; the order the session holds is only what they last confirmed. Moving an item changes the draft, never
            -- the session: `dirty` says the draft differs from what is held, and the panel is not "set" until they confirm it themselves.
            local byId, committed = {}, {}
            for i, row in ipairs(g) do byId[row.id] = row; committed[i] = row.id end
            local shown, dirty = g, false
            local draft = ctx.rankDraft and ctx.rankDraft[kind]
            if type(draft) == "table" and #draft == #g then
                local valid, seen = true, {}
                for _, id in ipairs(draft) do
                    if not byId[id] or seen[id] then valid = false end
                    seen[id] = true
                end
                if valid then
                    shown = {}
                    for i, id in ipairs(draft) do
                        shown[i] = byId[id]
                        if id ~= committed[i] then dirty = true end
                    end
                end
            end
            local panel = { kind = kind, items = {}, complete = true, dirty = dirty }
            for i, row in ipairs(shown) do
                panel.items[i] = { id = row.id, link = row.link, tip = row.tip, rank = row.mineRank }
                if not row.mineRank then panel.complete = false end
            end
            if dirty then panel.complete = false end
            out.rankings[#out.rankings + 1] = panel
        end
    end
    if mode == "ml" then
        out.answered, out.eligible = s:answerCount()
        out.eligibleMe = s.eligible and s.eligible[me] and true or false
        out.pending = {}
        for _, a in ipairs(s.pending or {}) do
            if a.type == "award" then out.pending[#out.pending + 1] = ("%s: %s%s"):format(a.item.link or "?", show(a.member), a.to and (" (for " .. show(a.to) .. ")") or "")
            elseif a.type == "disenchant" then out.pending[#out.pending + 1] = ("%s: disenchanted by %s"):format(a.item.link or "?", show(a.to)) end
        end
        if out.isML then
            out.can.resolve = s.phase == "bidding"
            out.can.extend = s.phase == "bidding" or (s.turn ~= nil)
            out.can.confirm = s.phase == "review"
            out.can.cancel = out.active
        end
    end
    local t = s.turn
    if t and t.player == me then
        out.turn = { type = t.type, tier = t.tier, options = t.options, item = t.item }
        if t.type == "recipient" and s.mayKeep then out.turn.canKeep = s:mayKeep(me, t.item) and true or false end
        if t.type ~= "pick" and targetsFn then out.turn.targets = targetsFn(t.item) end
        local function linkOfItem(id) for _, it in ipairs(list) do if (it.id or 0) == id then return it.link end end end
        out.turn.itemLink = t.item and linkOfItem(t.item)
    elseif t then
        out.waitingFor = show(t.player)
        out.waitingWho = whoOf(t.player)
    end
    return out
end

function M:OnInit() end
