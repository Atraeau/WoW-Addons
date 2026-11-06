-- King's Gambit: what the Loot window reads from a session (Model, pure and tested). Keep this file Lua 5.1-safe.
-- The buttons that answer it are in LootWindow, drawn from LootView; every button runs the same command a player would type, so the rules and the
-- ledger are exactly those of the commands. The Master Looter's own session and a player's view of someone else's are read from the same place the commands read.
local _, SK = ...
local Identity, Sim, Tips
local M = SK:NewModule("UILoot", { "Identity", "Sim?", "UITips" }, function(d) Identity, Sim, Tips = d.Identity, d.Sim, d.UITips end)

M.MAX_ITEMS = 8

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
        out.night = { nextBoss = nextBoss and nextBoss.name, killed = sim.bossIndex, held = #sim.held }
    end
    if not s then return out end
    out.mode, out.phase = mode, s.phase
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
                row.mine, row.mineTo = b and b.kind, b and show(b.to)
                row.winner, row.to, row.tier = show(it.winner), show(it.to), it.tier
                row.winnerIsMe, row.toIsMe = it.winner ~= nil and it.winner == me, it.to ~= nil and it.to == me
                local a = pendingFor[it.id or 0]
                if a then row.from, row.undecided = a.fromIndex, a.undecided end
                if it.status == "de" then row.deTo = show(s.deHandler) end
            else
                local b = s.mine and s.mine[it.id or i]
                row.mine, row.mineTo = b and b.kind, b and show(b.to)
                for _, a in ipairs(s.results and s.results.awards or {}) do
                    if a.item == row.id then
                        row.status, row.winner, row.to, row.tier = "awarded", show(a.winner), show(a.to), a.tier
                        row.winnerIsMe, row.toIsMe = a.winner == me, a.to ~= nil and a.to == me
                    end
                end
            end
            row.giftTargets = ctx.targets and ctx.targets(row.id) or nil
            row.canBid, row.whyNot = true, nil
            if ctx.commands and ctx.commands.mayHave then
                local ok, whyNot = ctx.commands.mayHave(row.id)
                if ok == false then row.canBid, row.whyNot = false, whyNot end
            end
            out.items[#out.items + 1] = row
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
        if t.type ~= "pick" and ctx.targets then out.turn.targets = ctx.targets(t.item) end
        local function linkOfItem(id) for _, it in ipairs(list) do if (it.id or 0) == id then return it.link end end end
        out.turn.itemLink = t.item and linkOfItem(t.item)
    elseif t then
        out.waitingFor = show(t.player)
    end
    return out
end

function M:OnInit() end
