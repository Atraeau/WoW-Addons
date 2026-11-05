-- King's Gambit: the Loot tab of the window. Keep this file Lua 5.1-safe.
-- What a loot session looks like to this player (Model, pure and tested), and the buttons that answer it. Every button runs the same command
-- a player would type (need 1, pass 2, pick 1, resolve...), so the rules, the messages and the ledger are exactly the same as with commands;
-- the Master Looter's own session and a player's view of someone else's are both read from the same place the commands read.
local _, SK = ...
local Identity, Sim
local M = SK:NewModule("UILoot", { "Identity", "Sim?" }, function(d) Identity, Sim = d.Identity, d.Sim end)

M.MAX_ITEMS = 8

local PHASES = {
    bidding = "Bidding is open: answer for each item",
    main = "Main-spec draft",
    off = "Off-spec draft",
    gift = "Gift draft",
    salvage = "Salvage: items nobody wanted",
    review = "Review: the Master Looter confirms to hand the loot out",
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
    local list = s.items or {}
    for i, it in ipairs(list) do
        if i > M.MAX_ITEMS then out.hidden = out.hidden + 1
        else
            local row = { id = it.id or i, link = it.link, tip = M.TipOf(it.link), status = it.status }
            if mode == "ml" then
                local b = s.bids[me] and s.bids[me][it.id]
                row.mine, row.mineTo = b and b.kind, b and show(b.to)
                row.winner, row.to, row.tier = show(it.winner), show(it.to), it.tier
            else
                local b = s.mine and s.mine[it.id or i]
                row.mine, row.mineTo = b and b.kind, b and show(b.to)
                for _, a in ipairs(s.results and s.results.awards or {}) do
                    if a.item == row.id then row.status, row.winner, row.to, row.tier = "awarded", show(a.winner), show(a.to), a.tier end
                end
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
        out.can.resolve = s.phase == "bidding"
        out.can.extend = s.phase == "bidding" or (s.turn ~= nil)
        out.can.confirm = s.phase == "review"
        out.can.cancel = out.active
    end
    local t = s.turn
    if t and t.player == me then
        out.turn = { type = t.type, tier = t.tier, options = t.options, item = t.item }
        local function linkOfItem(id) for _, it in ipairs(list) do if (it.id or 0) == id then return it.link end end end
        out.turn.itemLink = t.item and linkOfItem(t.item)
    elseif t then
        out.waitingFor = show(t.player)
    end
    return out
end

---------------------------------------------------------------- the frames
local function button(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
end

local ANSWERS = { { "need", "Need", "need" }, { "off", "Off-spec", "off" }, { "pass", "Pass", "pass" }, { "gift", "Gift", "gift" } }

-- ui: the window module (it supplies the context and a Refresh). Returns the content frame.
function M.Build(parent, ui)
    local f = CreateFrame("Frame", nil, parent)
    f:SetAllPoints()

    f.status = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.status:SetPoint("TOPLEFT", 4, 0); f.status:SetWidth(370); f.status:SetJustifyH("LEFT")
    f.note = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.note:SetPoint("TOPLEFT", 4, -20); f.note:SetWidth(370); f.note:SetJustifyH("LEFT"); f.note:SetWordWrap(true)

    f.rows = {}
    for i = 1, M.MAX_ITEMS do
        local row = { }
        local y = -48 - (i - 1) * 38
        row.text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetPoint("TOPLEFT", 4, y); row.text:SetWidth(370); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        -- Hover for the item's tooltip; shift-click puts the link in chat, control-click tries it on, as anywhere in the game.
        row.hit = CreateFrame("Button", nil, f)
        row.hit:SetSize(370, 16)
        row.hit:SetPoint("TOPLEFT", 4, y)
        row.hit:SetScript("OnEnter", function(self)
            if row.tip and GameTooltip then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(row.tip)
                GameTooltip:Show()
            end
        end)
        row.hit:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
        row.hit:SetScript("OnClick", function()
            if not row.tip then return end
            local get = (C_Item and C_Item.GetItemInfo) or GetItemInfo
            local full = get and select(2, get(row.tip)) or row.tip
            if HandleModifiedItemClick then HandleModifiedItemClick(full) end
        end)
        row.buttons = {}
        for j, a in ipairs(ANSWERS) do
            local b = button(f, a[2], 66, 20)
            b:SetPoint("TOPLEFT", 4 + (j - 1) * 70, y - 15)
            b:SetScript("OnClick", function() ui:Command(("%s %d"):format(a[1], row.id or i)) end)
            row.buttons[j] = b
        end
        f.rows[i] = row
    end
    f.more = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.more:SetPoint("TOPLEFT", 4, -48 - M.MAX_ITEMS * 38)

    -- your turn
    f.turn = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.turn:SetPoint("BOTTOMLEFT", 4, 92); f.turn:SetWidth(370); f.turn:SetJustifyH("LEFT")
    f.turnButtons = {}
    for i = 1, 6 do
        local b = button(f, "", 70, 22)
        b:SetPoint("BOTTOMLEFT", 4 + (i - 1) * 74, 66)
        f.turnButtons[i] = b
    end
    f.recipient = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.recipient:SetSize(110, 20); f.recipient:SetPoint("BOTTOMLEFT", 12, 66); f.recipient:SetAutoFocus(false)

    -- the Master Looter's controls
    f.mlButtons = {}
    local ml = { { "Resolve now", "resolve" }, { "+30 s", "extend 30" }, { "Confirm", "confirm" }, { "Cancel", "cancel" } }
    for i, m in ipairs(ml) do
        local b = button(f, m[1], 86, 22)
        b:SetPoint("BOTTOMLEFT", 4 + (i - 1) * 90, 38)
        b:SetScript("OnClick", function() ui:Command(m[2]) end)
        f.mlButtons[m[2]] = b
    end
    f.startButton = button(f, "Start from the loot window", 180, 22)
    f.startButton:SetPoint("BOTTOMLEFT", 4, 38)
    f.startButton:SetScript("OnClick", function() ui:Command("loot") end)

    -- practice only
    f.nextBoss = button(f, "Next boss", 140, 22)
    f.nextBoss:SetPoint("BOTTOMLEFT", 4, 8)
    f.nextBoss:SetScript("OnClick", function() ui:PracticeKill() end)
    f.handOut = button(f, "Hand out the loot", 130, 22)
    f.handOut:SetPoint("LEFT", f.nextBoss, "RIGHT", 6, 0)
    f.handOut:SetScript("OnClick", function() ui:PracticeHandOut() end)
    f.wait = button(f, "Wait 10 s", 76, 22)
    f.wait:SetPoint("LEFT", f.handOut, "RIGHT", 6, 0)
    f.wait:SetScript("OnClick", function() ui:PracticeWait(10) end)
    return f
end

local function setShown(frame, on) if on then frame:Show() else frame:Hide() end end

function M.Refresh(f, ctx, ui)
    local m = M.Model(ctx)
    local practice = ctx.sim ~= nil
    -- status
    if m.mode == "none" then
        f.status:SetText(practice and "No loot yet. Kill the next boss." or "No loot session is running.")
        f.note:SetText(practice and (m.night and m.night.nextBoss) and ("Next boss: " .. m.night.nextBoss .. ((m.night.held > 0) and (".  Held loot: " .. m.night.held) or "")) or
            "A session starts when the Master Looter opens the loot window on a boss and starts it.")
    else
        f.status:SetText(m.phaseText .. (m.seconds and m.active and (("   (%ds)"):format(m.seconds)) or ""))
        local bits = {}
        if m.answered then bits[#bits + 1] = ("%d of %d answered"):format(m.answered, m.eligible) end
        if m.mode == "ml" and m.eligibleMe == false and m.active then bits[#bits + 1] = "you are not in this session's roster" end
        if m.waitingFor then bits[#bits + 1] = "waiting for " .. m.waitingFor end
        if m.pending and #m.pending > 0 and m.phase == "review" then bits[#bits + 1] = #m.pending .. " result(s) to confirm" end
        f.note:SetText(table.concat(bits, "   "))
    end
    -- items
    for i = 1, M.MAX_ITEMS do
        local row, it = f.rows[i], m.items[i]
        if it then
            row.id = it.id
            row.tip = it.tip
            local label = ("%d. %s"):format(i, M.Display(it.link, it.tip))
            if it.status == "awarded" then label = label .. ("   -> %s%s"):format(it.winner or "?", it.to and (" (for " .. it.to .. ")") or "")
            elseif it.status == "de" then label = label .. "   -> disenchanted" end
            row.text:SetText(label); row.text:Show(); row.hit:Show()
            local open = m.active and (it.status == nil or it.status == "open") and m.phase == "bidding"
            for j, a in ipairs(ANSWERS) do
                row.buttons[j]:SetText((it.mine == a[3]) and ("[" .. a[2] .. "]") or a[2])
                setShown(row.buttons[j], open)
            end
        else
            row.text:Hide(); row.hit:Hide()
            for _, b in ipairs(row.buttons) do b:Hide() end
        end
    end
    f.more:SetText(m.hidden > 0 and (("(and %d more items: use the need/off/pass commands for them)"):format(m.hidden)) or "")
    -- your turn
    for _, b in ipairs(f.turnButtons) do b:Hide() end
    f.recipient:Hide()
    local t = m.turn
    if not t then
        f.turn:SetText("")
    elseif t.type == "pick" then
        f.turn:SetText("Your turn: pick the item you want (" .. t.tier .. " draft), or skip.")
        local n = 0
        for _, id in ipairs(t.options or {}) do
            n = n + 1
            if n <= 5 then
                local b = f.turnButtons[n]
                b:SetText("Item " .. id); b:SetScript("OnClick", function() ui:Command("pick " .. id) end); b:Show()
            end
        end
        local b = f.turnButtons[6]
        b:SetText("Skip"); b:SetScript("OnClick", function() ui:Command("skip") end); b:Show()
    elseif t.type == "claim" then
        f.turn:SetText("Salvage: do you want " .. (t.itemLink or "this item") .. "? (declining sends it to the disenchanter)")
        local b1, b2 = f.turnButtons[1], f.turnButtons[2]
        b1:SetText("Claim"); b1:SetScript("OnClick", function() ui:Command("claim") end); b1:Show()
        b2:SetText("Decline"); b2:SetScript("OnClick", function() ui:Command("decline") end); b2:Show()
    elseif t.type == "recipient" then
        f.turn:SetText("You won " .. (t.itemLink or "a gift") .. ". Who gets it? Type a name, keep it, or withdraw (counts as a pass).")
        f.recipient:Show()
        local b1, b2, b3 = f.turnButtons[2], f.turnButtons[3], f.turnButtons[4]
        b1:SetText("Give"); b1:SetScript("OnClick", function()
            local n = (f.recipient:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", "_")
            if n ~= "" then ui:Command("recipient " .. n); f.recipient:SetText("") end
        end); b1:Show()
        b2:SetText("Keep"); b2:SetScript("OnClick", function() ui:Command("keep") end); b2:Show()
        b3:SetText("Withdraw"); b3:SetScript("OnClick", function() ui:Command("withdraw yes") end); b3:Show()
    end
    -- the Master Looter's controls, and the way in
    local ml = m.mode == "ml"
    for cmd, b in pairs(f.mlButtons) do
        setShown(b, ml and m.active)
    end
    if ml then
        f.mlButtons.resolve:SetEnabled(m.can.resolve); f.mlButtons["extend 30"]:SetEnabled(m.can.extend)
        f.mlButtons.confirm:SetEnabled(m.can.confirm); f.mlButtons.cancel:SetEnabled(m.can.cancel)
    end
    setShown(f.startButton, not practice and not (ml and m.active) and m.mode ~= "player")
    setShown(f.nextBoss, practice); setShown(f.handOut, practice and m.night and m.night.held > 0); setShown(f.wait, practice)
    f.nextBoss:SetText(m.night and m.night.nextBoss and ("Kill " .. m.night.nextBoss) or "No more bosses")
end

function M:OnInit() end
