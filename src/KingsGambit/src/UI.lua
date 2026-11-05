-- King's Gambit: the window. `/gambit` with nothing after it opens it (design journal: "/gambit opens a window").
-- Stage 1: the standings, and a way to switch lists. Later stages add the bid popup and the officer actions.
-- Keep this file Lua 5.1-safe. The window only READS the engine here; every change still goes through the same engine calls the commands use.
--
-- Two halves, so most of it can be tested without the game:
--   M.Model(engine, client, listId, page)  pure: what the window shows (rows, paging, lists, the raid and its list)
--   M:Toggle() / M:Refresh()               the frames, built the first time they are needed (game only)
local _, SK = ...
local Identity
local M = SK:NewModule("UI", { "Identity" }, function(d) Identity = d.Identity end)

local ROWS = 15

-- What the window shows for one list. listId nil = the list the viewer's raid plays on, else main.
function M.Model(engine, client, listId, page)
    local lists = engine:Lists()
    local raidList, raid = engine:RaidList()
    local id = listId or raidList or "main"
    local model = { lists = lists, list = id, raid = raid, raidList = raidList, me = client:me(), rows = {}, page = 1, pages = 1, total = 0 }
    local chain = engine:Get(id)
    if not chain then return model end
    local order = chain.state.order
    model.total = #order
    model.pages = math.max(1, math.ceil(#order / ROWS))
    model.page = math.min(math.max(page or 1, 1), model.pages)
    for i = (model.page - 1) * ROWS + 1, math.min(#order, model.page * ROWS) do
        local who = order[i]
        local m = chain.state.members[who]
        model.rows[#model.rows + 1] = { pos = i, name = Identity.Display(who), who = who, wins = m.wins or 0,
            class = m.class, mine = who == model.me }
    end
    return model
end

local function nextList(lists, current)
    for i, id in ipairs(lists) do
        if id == current then return lists[i % #lists + 1] end
    end
    return lists[1]
end

function M:Refresh()
    local w = self.window
    if not (w and w:IsShown()) then return end
    local engine, client = SK.engine, SK.client
    local model = M.Model(engine, client, self.list, self.page)
    self.list, self.page = model.list, model.page
    w.listButton:SetText(model.list)
    local sub = model.raid and ("Your raid plays on: " .. (model.raidList or "(no list chosen yet)")) or "No raid open for you"
    w.subtitle:SetText(sub)
    w.pageText:SetText(("Page %d of %d  (%d on the list)"):format(model.page, model.pages, model.total))
    for i = 1, ROWS do
        local row, r = w.rows[i], model.rows[i]
        if r then
            row:SetText(("%2d.  %s%s    wins %d"):format(r.pos, r.name, r.mine and "   <- you" or "", r.wins))
            row:Show()
        else
            row:Hide()
        end
    end
    w.startButton:SetShown(#model.lists == 0)
    local hasList = #model.lists > 0
    w.addBox:SetShown(hasList); w.addButton:SetShown(hasList); w.groupButton:SetShown(hasList)
    if model.total == 0 then
        w.message:SetText(#model.lists == 0 and "No lists yet. The guild master starts the ledger with the button below."
            or "Nobody is on this list yet. Add players below.")
        w.message:Show()
    else
        w.message:Hide()
    end
end

local function button(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
end

function M:Build()
    -- BasicFrameTemplateWithInset gives a title bar and close button; fall back to a plain frame if this client lacks it.
    local ok, w = pcall(CreateFrame, "Frame", "KingsGambitWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not w then w = CreateFrame("Frame", "KingsGambitWindow", UIParent) end
    w:SetSize(380, 470)
    w:SetPoint("CENTER")
    w:SetFrameStrata("DIALOG")
    w:SetMovable(true); w:EnableMouse(true)
    w:RegisterForDrag("LeftButton")
    w:SetScript("OnDragStart", w.StartMoving)
    w:SetScript("OnDragStop", w.StopMovingOrSizing)
    if w.TitleText then w.TitleText:SetText("King's Gambit") end
    if w.SetBackdrop and not w.TitleText then
        w:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32, insets = { left = 8, right = 8, top = 8, bottom = 8 } })
    end
    if not w.TitleText then
        local t = w:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        t:SetPoint("TOP", 0, -14); t:SetText("King's Gambit")
        local close = button(w, "Close", 70); close:SetPoint("TOPRIGHT", -10, -10)
        close:SetScript("OnClick", function() w:Hide() end)
    end

    w.subtitle = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.subtitle:SetPoint("TOPLEFT", 16, -34)

    local lbl = w:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("TOPLEFT", 16, -58); lbl:SetText("List:")
    w.listButton = button(w, "main", 140)
    w.listButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
    w.listButton:SetScript("OnClick", function()
        M.list = nextList(SK.engine:Lists(), M.list or SK.engine:RaidList() or "main"); M.page = 1; M:Refresh()
    end)

    w.rows = {}
    for i = 1, ROWS do
        local f = w:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        f:SetPoint("TOPLEFT", 20, -90 - (i - 1) * 22)
        f:SetJustifyH("LEFT"); f:SetWidth(340); f:SetWordWrap(false)
        w.rows[i] = f
    end
    w.message = w:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    w.message:SetPoint("TOPLEFT", 20, -90); w.message:SetWidth(340); w.message:SetJustifyH("LEFT"); w.message:Hide()

    -- First run: the guild master founds the ledger (the same as `create main`; the ledger records who did it as the guild master).
    w.startButton = button(w, "Start the ledger", 160, 26)
    w.startButton:SetPoint("TOP", 0, -130)
    w.startButton:SetScript("OnClick", function()
        SK.commands.handle("create main Main")
        M.list = "main"; M:Refresh()
    end)
    w.startButton:Hide()

    -- Adding players: by name, or everyone in your group who isn't on the list yet (the same as `add <name>`, one at a time).
    w.addBox = CreateFrame("EditBox", nil, w, "InputBoxTemplate")
    w.addBox:SetSize(130, 22); w.addBox:SetPoint("BOTTOMLEFT", 22, 50); w.addBox:SetAutoFocus(false)
    w.addButton = button(w, "Add", 50)
    w.addButton:SetPoint("LEFT", w.addBox, "RIGHT", 6, 0)
    local function addName()
        local n = (w.addBox:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", "_")
        if n ~= "" then SK.commands.handle("add " .. n); w.addBox:SetText(""); M:Refresh() end
    end
    w.addButton:SetScript("OnClick", addName)
    w.addBox:SetScript("OnEnterPressed", addName)
    w.groupButton = button(w, "Add my group", 110)
    w.groupButton:SetPoint("LEFT", w.addButton, "RIGHT", 10, 0)
    w.groupButton:SetScript("OnClick", function()
        local chain = SK.engine:Get(M.list or SK.engine:RaidList() or "main")
        for _, m in ipairs(SK.client:roster()) do
            if not (chain and chain.state.members[m.name]) then SK.commands.handle("add " .. m.name) end
        end
        M:Refresh()
    end)

    local prev, nxt, refresh = button(w, "<", 30), button(w, ">", 30), button(w, "Refresh", 70)
    prev:SetPoint("BOTTOMLEFT", 16, 14); nxt:SetPoint("LEFT", prev, "RIGHT", 4, 0)
    refresh:SetPoint("BOTTOMRIGHT", -16, 14)
    w.pageText = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.pageText:SetPoint("LEFT", nxt, "RIGHT", 10, 0)
    prev:SetScript("OnClick", function() M.page = (M.page or 1) - 1; M:Refresh() end)
    nxt:SetScript("OnClick", function() M.page = (M.page or 1) + 1; M:Refresh() end)
    refresh:SetScript("OnClick", function() M:Refresh() end)

    -- Keep it current while it is open: the ledger changes as other players' updates arrive.
    local elapsed = 0
    w:SetScript("OnUpdate", function(_, dt)
        elapsed = elapsed + dt
        if elapsed > 1 then elapsed = 0; M:Refresh() end
    end)
    w:SetScript("OnShow", function() M:Refresh() end)
    -- Escape closes it.
    if UISpecialFrames then table.insert(UISpecialFrames, "KingsGambitWindow") end
    w:Hide()
    self.window = w
    return w
end

function M:Toggle()
    if not (CreateFrame and UIParent) then return false end
    local w = self.window or self:Build()
    if w:IsShown() then w:Hide() else w:Show() end
    return true
end

function M:OnInit() end
