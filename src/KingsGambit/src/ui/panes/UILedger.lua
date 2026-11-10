-- King's Gambit: the game's windows, the Ledger section (the record in words, with its detail) and the stored-ledger panel at the foot of Admin. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Tips, GuildBook
local P = SK:NewModule("UILedger", { "UITips", "GuildBook" }, function(d) Tips, GuildBook = d.UITips, d.GuildBook end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local button, setShown = h.button, h.setShown

-- ---- The Ledger section: the record in words -------------------------------------------------------------------------------------------------

local HIST_H = 20

local function stripColors(t) return (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end

-- An entry's sentence for the game: each person in their class color (the pieces GuildBook.Segments cut it into).
function M.ColoredText(e)
    if not e.segments then return stripColors(e.text) end
    local parts = {}
    for i, s in ipairs(e.segments) do
        if s.who then parts[i] = s.who.color and ("|cff" .. s.who.color .. s.who.name .. "|r") or s.who.name
        else parts[i] = stripColors(s.text) end
    end
    return table.concat(parts)
end

-- One entry on one line: when (muted) and what happened (a long sentence is cut off; the whole of it is in the tooltip).
function M.InitHistoryRow(row, e)
    row.entry = e
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then if M.ledgerSelected == e.id then row.hl:Show() else row.hl:Hide() end end
    if row.SetScript and not row.clickSet then
        row.clickSet = true
        -- a click selects the entry (its raw record is shown below); Ctrl-click tries its item on, as Ctrl-clicking an item link does
        row:SetScript("OnClick", function(self)
            if not self.entry then return end
            M.ledgerSelected = self.entry.id
            if IsControlKeyDown and IsControlKeyDown() and self.entry.item then M.TryOn(self.entry.item) end
            M:Refresh()
        end)
    end
    if not row.cells then
        row.when = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.when:SetPoint("LEFT", 4, 0); row.when:SetWidth(72); row.when:SetJustifyH("LEFT"); row.when:SetWordWrap(false)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.text:SetPoint("LEFT", 80, 0); row.text:SetWidth(310); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        row.cells = true
        if row.SetScript then
            row:SetScript("OnEnter", function(self)
                if GameTooltip and self.entry then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    -- an entry about an item shows the item (its own tooltip), with how to try it on; any other shows its sentence in full
                    if self.entry.item and GameTooltip.SetHyperlink and pcall(GameTooltip.SetHyperlink, GameTooltip, self.entry.item) then
                        GameTooltip:AddLine(" "); GameTooltip:AddLine("Ctrl-click to try it on.", 0.6, 0.6, 0.6)
                    else
                        GameTooltip:SetText(self.entry.text, 1, 1, 1, 1, true)
                    end
                    GameTooltip:Show()
                end
            end)
            row:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
        end
    end
    row.when:SetText(e.when or "")
    row.text:SetText(M.ColoredText(e))
end

function M:BuildHistory(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    local lbl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("TOPLEFT", 4, 0); lbl:SetText("Show:")
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, p, "WowStyle1DropdownTemplate")
    if okDrop and drop then
        drop:SetWidth(130)
        drop:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        drop:SetupMenu(function(_, root)
            for _, k in ipairs(GuildBook.KINDS) do
                root:CreateRadio(k.label, function() return M.histKind == k.id end, function() M.histKind = k.id; M:Refresh() end)
            end
        end)
        p.kindDrop = drop
        p.kindButton = drop
    else
        p.kindButton = button(p, "Everything", 120)
        p.kindButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        p.kindButton:SetScript("OnClick", function()
            local kinds = GuildBook.KINDS
            for i, k in ipairs(kinds) do
                if k.id == M.histKind then M.histKind = kinds[i % #kinds + 1].id; break end
            end
            M:Refresh()
        end)
    end
    Tips.Attach(p.kindButton, "historykind")
    local fl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fl:SetPoint("LEFT", p.kindButton, "RIGHT", 16, 0); fl:SetText("Find:")
    p.find = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.find:SetSize(120, 20); p.find:SetPoint("LEFT", fl, "RIGHT", 10, 0); p.find:SetAutoFocus(false)
    p.find:SetScript("OnTextChanged", function(self, user)
        if user then M.histText = self:GetText() or ""; M:Refresh() end
    end)
    Tips.Attach(p.find, "historyfind")

    -- The selected entry as the raw record, under the list.
    p.detailTitle = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.detailTitle:SetPoint("BOTTOMLEFT", 4, 112); p.detailTitle:SetText("Selected entry")
    p.tryOn = button(p, "Try it on", 80, 20)
    p.tryOn:SetPoint("BOTTOMRIGHT", -6, 108)
    p.tryOn:SetScript("OnClick", function() M.TryOn(p.tryOnItem) end)
    Tips.Attach(p.tryOn, "tryon")
    p.tryOn:Hide()
    -- An award you made can be undone right here, from the entry itself (the undo is a new entry; nothing is erased).
    p.undoBtn = button(p, "Undo this award", 110, 20)
    p.undoBtn:SetPoint("BOTTOMRIGHT", -92, 108)
    p.undoBtn:SetScript("OnClick", function()
        if p.undoId then M:Command("undo id " .. tostring(p.undoId) .. " yes") end
    end)
    Tips.Attach(p.undoBtn, "undoentry")
    p.undoBtn:Hide()
    p.detail =p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.detail:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 4, 108); p.detail:SetWidth(390); p.detail:SetHeight(104)
    p.detail:SetJustifyH("LEFT"); p.detail:SetJustifyV("TOP"); p.detail:SetWordWrap(true)
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then inset:SetPoint("TOPLEFT", -2, -28); inset:SetPoint("BOTTOMRIGHT", 2, 132) end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -32)
        box:SetPoint("BOTTOMRIGHT", -22, 136)
        bar:SetPoint("TOPLEFT", box, "TOPRIGHT", 4, -2)
        bar:SetPoint("BOTTOMLEFT", box, "BOTTOMRIGHT", 4, 2)
        local view = CreateScrollBoxListLinearView()
        view:SetElementExtent(HIST_H)
        view:SetElementInitializer("Button", M.InitHistoryRow)
        ScrollUtil.InitScrollBoxListWithScrollBar(box, bar, view)
        p.scrollBox = box
    end)
    if not okBox then
        local scroll = CreateFrame("ScrollFrame", nil, p)
        scroll:SetPoint("TOPLEFT", 4, -32); scroll:SetPoint("BOTTOMRIGHT", -26, 136)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(380, 1)
        scroll:SetScrollChild(p.child)
        p.lines = {}
    end
    p.countText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.countText:SetPoint("BOTTOMRIGHT", -6, 4)
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -50); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    return p
end

-- Show an item on this character in the game's dressing room (a link, or "item:ID"). Nothing is equipped or recorded.
function M.TryOn(item)
    if not item then return false end
    local fn = DressUpItemLink or DressUpLink
    if not fn then M.Say("This game can't open the dressing room from here."); return false end
    local ok = pcall(fn, item)
    if not ok and DressUpLink and fn ~= DressUpLink then ok = pcall(DressUpLink, item) end
    return ok
end

-- The selected entry's details as text: each field's name in gold, its value after it.
function M.DetailText(lines)
    local parts = {}
    for i, l in ipairs(lines) do
        if i > 9 then parts[#parts + 1] = "|cff999999...|r"; break end
        parts[i] = ("|cffffd100%s:|r %s"):format(l.label, (l.value:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))) end
    return table.concat(parts, "\n")
end

-- Fill the Ledger page from the ledger (newest first).
function M.RefreshHistory(p, ctx)
    local h = GuildBook.History(ctx, { kind = M.histKind, text = M.histText, limit = 300 })
    local label = "Everything"
    for _, k in ipairs(GuildBook.KINDS) do if k.id == M.histKind then label = k.label end end
    if p.kindDrop then
        if p.shownKind ~= M.histKind then p.shownKind = M.histKind; p.kindDrop:GenerateMenu() end
    else
        p.kindButton:SetText(label)
    end
    if p.scrollBox then
        local data = CreateDataProvider()
        for _, e in ipairs(h.entries) do data:Insert(e) end
        p.scrollBox:SetDataProvider(data, ScrollBoxConstants and ScrollBoxConstants.RetainScrollPosition)
    else
        for i, e in ipairs(h.entries) do
            local line = p.lines[i]
            if not line then
                line = CreateFrame("Button", nil, p.child)
                line:SetSize(380, HIST_H); line:SetPoint("TOPLEFT", 0, -(i - 1) * HIST_H)
                p.lines[i] = line
            end
            M.InitHistoryRow(line, e); line:Show()
        end
        for i = #h.entries + 1, #p.lines do p.lines[i]:Hide() end
        p.child:SetHeight(math.max(#h.entries * HIST_H, 1))
    end
    local detail, item, canUndo, selEv
    if M.ledgerSelected then detail, item, canUndo, selEv = GuildBook.Detail(ctx, M.ledgerSelected) end
    if not detail then M.ledgerSelected = nil end
    p.tryOnItem = item
    setShown(p.tryOn, item ~= nil)
    p.undoId = canUndo and selEv and selEv.id or nil
    if p.undoBtn then setShown(p.undoBtn, p.undoId ~= nil) end
    p.detail:SetText(detail and M.DetailText(detail) or "Click an entry to see exactly what was written: who wrote it, when, its id and every field.")
    p.countText:SetText(h.total > h.shown and ("Showing the newest %d of %d"):format(h.shown, h.total) or ("%d entries"):format(h.total))
    if h.empty then p.message:SetText(h.empty); p.message:Show() else p.message:Hide() end
end


-- The panel at the foot of the Admin section: the ledger stored on this computer for this guild, with a Retire (or Keep) button. Retiring asks first, in the game's
-- own confirmation dialog. (Only this guild's ledger is ever shown, and a removed one that is waiting to be kept; three rows are plenty.)
local LEDGER_ROWS = 3
function M.ConfirmRetire(row)
    local text = ("Retire %s?\n\nIts saved data is removed from this computer%s. Nothing in the ledger is erased and nobody else's copy is touched. If you are an officer the guild is told, and each member can restore it or let it expire."):format(
        row.title, row.open and " at your next login (it is the ledger in use now)" or " at once")
    if StaticPopupDialogs and StaticPopup_Show then
        StaticPopupDialogs["KINGSGAMBIT_RETIRE_LEDGER"] = StaticPopupDialogs["KINGSGAMBIT_RETIRE_LEDGER"] or {
            text = "%s", button1 = "Retire", button2 = "Cancel", timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
            OnAccept = function(_, data) if data then M:Command(("ledgers retire %d yes"):format(data)) end end,
        }
        local dialog = StaticPopup_Show("KINGSGAMBIT_RETIRE_LEDGER", text, nil, row.n)
        -- the game puts its dialogs at the top of the screen; a question about removing data belongs front and center
        if dialog and dialog.ClearAllPoints and UIParent then
            dialog:ClearAllPoints()
            dialog:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        end
        return true
    end
    return false -- no confirmation dialog here: nothing is retired
end

function M.BuildLedgers(page)
    local p = CreateFrame("Frame", nil, page)
    p:SetPoint("BOTTOMLEFT", 0, 0); p:SetPoint("BOTTOMRIGHT", 0, 0); p:SetHeight(190)
    local line = p:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 1, 1, 0.12); line:SetHeight(1)
    line:SetPoint("TOPLEFT", 0, 0); line:SetPoint("TOPRIGHT", 0, 0)
    local title = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 4, -10); title:SetText("This guild's ledger, stored on this computer")
    p.rows = {}
    for i = 1, LEDGER_ROWS do
        local row = CreateFrame("Frame", nil, p)
        row:SetSize(410, 44); row:SetPoint("TOPLEFT", 0, -32 - (i - 1) * 46)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.text:SetPoint("TOPLEFT", 4, -2); row.text:SetWidth(320); row.text:SetHeight(40)
        row.text:SetJustifyH("LEFT"); row.text:SetJustifyV("TOP"); row.text:SetWordWrap(true)
        row.button = button(row, "Retire", 70, 22)
        row.button:SetPoint("TOPRIGHT", -4, -8)
        Tips.Attach(row.button, "retireledger")
        row.button:SetScript("OnClick", function()
            local r = row.model
            if not r then return end
            if r.canKeep then M:Command(("ledgers keep %d"):format(r.n)) elseif r.canRetire then M.ConfirmRetire(r) end
        end)
        row:Hide()
        p.rows[i] = row
    end
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -40); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    page.ledgerPanel = p
    return p
end

function M.RefreshLedgers(page, ctx)
    local p = page.ledgerPanel
    if not p then return end
    local model = GuildBook.Ledgers(ctx)
    for i = 1, LEDGER_ROWS do
        local row, r = p.rows[i], model.rows[i]
        row.model = r
        if r then
            row.text:SetText(("|cffffd100%s|r\n%s%s%s"):format(r.title, r.detail, r.status and ("\n|cff9fd0ff" .. r.status .. "|r") or "", r.why and ("\n|cff999999" .. r.why .. "|r") or ""))
            row.button:SetText(r.canKeep and "Keep" or "Retire")
            if r.canKeep or r.canRetire then row.button:Show() else row.button:Hide() end
            row:Show()
        else
            row:Hide()
        end
    end
    local extra = #model.rows - LEDGER_ROWS
    if model.note then p.message:SetText(model.note); p.message:Show()
    elseif extra > 0 then p.message:SetText(("(%d more: use /gambit ledgers)"):format(extra)); p.message:SetPoint("TOPLEFT", 14, -34 - LEDGER_ROWS * 46); p.message:Show()
    else p.message:Hide() end
end

-- for the parts installed after this one
h.HIST_H = HIST_H
end
