-- King's Gambit: the game's windows, the Lists section: the standings rows, staging a move, dragging a player, applying the changes. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Tips, GuildBook
local P = SK:NewModule("UIStandings", { "UITips", "GuildBook" }, function(d) Tips, GuildBook = d.UITips, d.GuildBook end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local SORTS, button, nextList = h.SORTS, h.button, h.nextList

local ROW_H = 18
local COLS_X = { 4, 36, 190, 290 }

local function classColor(class)
    local c = RAID_CLASS_COLORS and class and RAID_CLASS_COLORS[class]
    if not c then return "|cffffffff" end
    return ("|cff%02x%02x%02x"):format(math.floor(c.r * 255 + 0.5), math.floor(c.g * 255 + 0.5), math.floor(c.b * 255 + 0.5))
end
local function className(class) return class and (class:sub(1, 1) .. class:sub(2):lower()) or "" end

-- Fill one row (a Button) with a player: made once, reused by the scroll box as it scrolls.
function M.InitRow(row, r)
    row.rowData = r
    if row.SetScript then row:SetScript("OnClick", function() M.selected = r.who; M:Refresh() end) end
    -- Drag a player onto another row to stage a move to that place (only for someone who may change the list).
    if row.RegisterForDrag then
        row:RegisterForDrag("LeftButton")
        row:SetScript("OnDragStart", function() if M.may then M.dragging = r.who; M.selected = r.who end end)
        row:SetScript("OnDragStop", function() M.DropOn(M.RowUnderCursor()) end)
    end
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then
        if r.moving then row.hl:SetColorTexture(0.3, 0.6, 1, 0.35) else row.hl:SetColorTexture(1, 0.82, 0, 0.2) end
        if M.selected == r.who or r.moving then row.hl:Show() else row.hl:Hide() end
    end
    if not row.cells then
        row.cells = {}
        for c = 1, 4 do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            fs:SetPoint("LEFT", COLS_X[c], 0)
            fs:SetJustifyH("LEFT"); fs:SetWordWrap(false)
            fs:SetWidth(c == 2 and 150 or (c == 3 and 96 or 40))
            row.cells[c] = fs
        end
    end
    row.cells[1]:SetText(tostring(r.shown or r.pos))
    row.cells[2]:SetText(classColor(r.class) .. r.name .. "|r" .. (r.mine and "  (you)" or "") .. (r.moving and ("  |cff66aaff(from " .. r.pos .. ")|r") or ""))
    row.cells[3]:SetText(classColor(r.class) .. className(r.class) .. "|r")
    row.cells[4]:SetText(tostring(r.wins))
end

-- Staged changes: nothing is written until they are applied (GuildBook has the model: a list of moves and removals, simulated for the preview).
M.staged = {}

-- The rows as they would be with the staged changes done (a moved player shown at their new place, marked as moving).
function M.Preview(rows) return GuildBook.Preview(rows, M.staged) end

-- Stage a move of the selected player to a place. A place they already hold clears an earlier staged move of theirs.
function M.Stage(to)
    local who = M.selected
    if not (who and M.places and M.places[who]) then return end
    GuildBook.StageMove(M.staged, M.baseOrder or {}, who, to)
    M:Refresh()
end

function M.StageRemove()
    local who = M.selected
    if not who then return end
    GuildBook.StageRemove(M.staged, who)
    M:Refresh()
end

function M.Discard() M.staged = {}; M:Refresh() end

-- Write the staged changes one after another, each with the one reason. If one is refused, the ones already written are no longer staged and the rest stay.
function M.ApplyStaged(reason)
    local cmds, problem = GuildBook.Commands(M.staged, reason)
    if not cmds then return M.Say(problem) end
    local ctx = M.Ctx()
    local done = 0
    for _, text in ipairs(cmds) do
        local before = #ctx.engine:View().applied
        M:Command(text)
        if #ctx.engine:View().applied <= before then
            for _ = 1, done do table.remove(M.staged, 1) end
            return M.Say(("Stopped after %d of %d: \"%s\" was not recorded (see above). The rest stay staged."):format(done, #cmds, text))
        end
        done = done + 1
    end
    M.staged = {}
    M.Say(("Applied %d change%s, each recorded with your reason."):format(done, done == 1 and "" or "s"))
    return true
end

-- The player's row under the mouse (a drag ended there), if any.
function M.RowUnderCursor()
    local f = GetMouseFoci and GetMouseFoci()
    if type(f) == "table" then f = f[1] end
    if not f and GetMouseFocus then f = GetMouseFocus() end
    while f do
        if f.rowData then return f.rowData end
        f = f.GetParent and f:GetParent() or nil
    end
end

-- Dropping the dragged player on a row stages a move to that row's place.
function M.DropOn(r)
    local who = M.dragging
    M.dragging = nil
    if who and r then
        M.selected = who
        M.Stage(r.shown or r.pos)
    end
end

-- The rows in the order chosen by a column header (the list's own order unless one was clicked).
function M.Sorted(rows)
    local key, desc = M.sortKey, M.sortDesc
    if not key or key == "pos" and not desc then return rows end
    local out = {}
    for i, r in ipairs(rows) do out[i] = r end
    table.sort(out, function(a, b)
        local x, y = a[key], b[key]
        if key == "name" or key == "class" then x, y = tostring(x or ""):lower(), tostring(y or ""):lower() end
        if x == y then return a.pos < b.pos end
        if desc then return x > y end
        return x < y
    end)
    return out
end

-- One line per player in the scrolling table.
function M.FillRows(p, rows)
    rows = M.Sorted(rows)
    if p.scrollBox then
        local data = CreateDataProvider()
        for _, r in ipairs(rows) do data:Insert(r) end
        p.scrollBox:SetDataProvider(data, ScrollBoxConstants and ScrollBoxConstants.RetainScrollPosition)
        return
    end
    for i, r in ipairs(rows) do
        local line = p.lines[i]
        if not line then
            line = CreateFrame("Button", nil, p.child)
            line:SetSize(340, ROW_H)
            line:SetPoint("TOPLEFT", 0, -(i - 1) * ROW_H)
            p.lines[i] = line
        end
        M.InitRow(line, r)
        line:Show()
    end
    for i = #rows + 1, #p.lines do p.lines[i]:Hide() end
    p.child:SetHeight(math.max(#rows * ROW_H, 1))
end


function M:BuildStandings(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    local lbl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("TOPLEFT", 4, 0); lbl:SetText("List:")
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, p, "WowStyle1DropdownTemplate")
    if okDrop and drop then
        drop:SetWidth(130)
        drop:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        drop:SetupMenu(function(_, root)
            local e = M.Ctx().engine
            local current = M.list or e:RaidList() or "main"
            for _, id in ipairs(e:Lists()) do
                root:CreateRadio(id, function() return current == id end, function() M.list = id; M:Refresh() end)
            end
        end)
        p.listDrop = drop
        Tips.Attach(drop, "listpick")
        p.listButton = drop -- (the dropdown shows the chosen list itself)
    else
        p.listButton = button(p, "main", 120)
        p.listButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        p.listButton:SetScript("OnClick", function()
            local e = M.Ctx().engine
            M.list = nextList(e:Lists(), M.list or e:RaidList() or "main"); M:Refresh()
        end)
    end
    p.raidText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.raidText:SetPoint("LEFT", p.listButton, "RIGHT", 10, 0)
    p.raidText:SetWidth(200); p.raidText:SetJustifyH("LEFT")

    -- A scrolling table like the game's own rosters: an inset panel, clickable column headers (click to sort, again to reverse), and the game's
    -- scroll box with its scroll bar. If this client's scroll box can't be built, the older scroll frame does the same job.
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then
        inset:SetPoint("TOPLEFT", -2, -26); inset:SetPoint("BOTTOMRIGHT", 2, 160)
    end
    p.headers = {}
    for i, c in ipairs(SORTS) do
        local h = CreateFrame("Button", nil, p)
        h:SetSize(i == 2 and 150 or 70, 16)
        h:SetPoint("TOPLEFT", COLS_X[i] + 6, -31)
        h.text = h:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        h.text:SetPoint("LEFT")
        h.text:SetText(c[2])
        h:SetScript("OnClick", function()
            if M.sortKey == c[1] then M.sortDesc = not M.sortDesc else M.sortKey, M.sortDesc = c[1], false end
            M:Refresh()
        end)
        Tips.Attach(h, "sort")
        p.headers[i] = h
    end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -50)
        box:SetPoint("BOTTOMRIGHT", -22, 164)
        bar:SetPoint("TOPLEFT", box, "TOPRIGHT", 4, -2)
        bar:SetPoint("BOTTOMLEFT", box, "BOTTOMRIGHT", 4, 2)
        local view = CreateScrollBoxListLinearView()
        view:SetElementExtent(ROW_H)
        view:SetElementInitializer("Button", M.InitRow)
        ScrollUtil.InitScrollBoxListWithScrollBar(box, bar, view)
        p.scrollBox, p.scrollBar = box, bar
    end)
    if not okBox then
        local ok, scroll = pcall(CreateFrame, "ScrollFrame", nil, p, "UIPanelScrollFrameTemplate")
        if not ok or not scroll then scroll = CreateFrame("ScrollFrame", nil, p) end
        scroll:SetPoint("TOPLEFT", 4, -50)
        scroll:SetPoint("BOTTOMRIGHT", -26, 164)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(340, 1)
        scroll:SetScrollChild(p.child)
        p.scroll, p.lines = scroll, {}
    end
    p.countText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.countText:SetPoint("BOTTOMRIGHT", -6, 6)
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -64); p.message:SetWidth(330); p.message:SetJustifyH("LEFT"); p.message:Hide()

    -- First run: the ledger owner founds the ledger (the same as `create main`; the ledger records who did it as the ledger owner).
    p.startButton = button(p, "Start the ledger", 160, 26)
    p.startButton:SetPoint("TOP", 0, -130)
    p.startButton:SetScript("OnClick", function() M:Command("create main Main"); M.list = "main"; M:Refresh() end)
    p.startButton:Hide()
    Tips.Attach(p.startButton, "startledger")

    -- Act on the player selected above. Changes are STAGED (a preview in the table); several can be stacked, and Apply all writes them one after another
    -- with one reason (the reason goes in the record with each).
    p.selText = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    p.selText:SetPoint("BOTTOMLEFT", 6, 134); p.selText:SetWidth(270); p.selText:SetJustifyH("LEFT"); p.selText:SetWordWrap(false)
    -- Someone who may not change the list (not an officer, and not the raid's Master Looter) still sees the buttons, grayed out, and this line saying why.
    p.hint = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.hint:SetPoint("BOTTOMLEFT", 6, 74); p.hint:SetWidth(410); p.hint:SetJustifyH("LEFT"); p.hint:SetWordWrap(false)
    p.hint:SetText("|cffff8040You can't change the list: only officers, and a raid's Master Looter, can. Ask via Rules (Request a list change).|r")
    p.actionButtons = {}
    local function stageBy(delta)
        local who = M.selected
        local place = who and M.places and M.places[who]
        if not place then return end
        M.Stage(place + delta)
    end
    -- Top, Up, Down, Bottom, Remove and the place box only stage (a preview); Apply all records them.
    local ACTIONS = {
        { "Top", function() M.Stage(1) end }, { "Up", function() stageBy(-1) end }, { "Down", function() stageBy(1) end },
        { "Bottom", function() M.Stage(M.total or 1) end },
        { "Remove", function() M.StageRemove() end },
        { "Award...", function() if M.selected then M.OpenTool("award", M.selected) end end },
    }
    for i, a in ipairs(ACTIONS) do
        local b = button(p, a[1], 56, 22)
        b:SetPoint("BOTTOMLEFT", 6 + (i - 1) * 60, 104)
        b:SetScript("OnClick", a[2])
        Tips.Attach(b, ({ "top", "up", "down", "bottom", "remove", "award" })[i], function()
            if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
            if not M.selected then return "Select a player in the list first." end
        end)
        p.actionButtons[i] = b
    end
    -- Where to: a place number (or drag a player onto a row).
    local pl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    pl:SetPoint("BOTTOMLEFT", 284, 138); pl:SetText("To place:")
    p.placeBox = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.placeBox:SetSize(30, 20); p.placeBox:SetPoint("BOTTOMLEFT", 340, 132); p.placeBox:SetAutoFocus(false); p.placeBox:SetMaxLetters(3)
    p.setPlace = button(p, "Set", 40, 22)
    p.setPlace:SetPoint("BOTTOMLEFT", 376, 131)
    p.setPlace:SetScript("OnClick", function()
        local n = tonumber(p.placeBox:GetText())
        if n then M.Stage(n); p.placeBox:SetText("") end
    end)
    -- The pending changes, then the one reason and the buttons that write or drop them.
    p.pending = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.pending:SetPoint("BOTTOMLEFT", 6, 74); p.pending:SetWidth(410); p.pending:SetHeight(26); p.pending:SetJustifyH("LEFT"); p.pending:SetJustifyV("TOP")
    if p.pending.SetMaxLines then p.pending:SetMaxLines(2) end
    local rl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    rl:SetPoint("BOTTOMLEFT", 6, 52); rl:SetText("Reason:")
    p.reason = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.reason:SetSize(190, 20); p.reason:SetPoint("BOTTOMLEFT", 56, 48); p.reason:SetAutoFocus(false)
    p.apply = button(p, "Apply all", 76, 22)
    p.apply:SetPoint("BOTTOMLEFT", 262, 47)
    p.apply:SetScript("OnClick", function()
        if M.ApplyStaged(p.reason:GetText()) then p.reason:SetText("") end
    end)
    p.cancelMove = button(p, "Discard", 70, 22)
    p.cancelMove:SetPoint("BOTTOMLEFT", 342, 47)
    p.cancelMove:SetScript("OnClick", function() M.Discard() end)
    local why = function()
        if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
    end
    Tips.Attach(p.placeBox, "place"); Tips.Attach(p.setPlace, "place", why)
    Tips.Attach(p.apply, "apply", function() return why() or (#M.staged == 0 and "Nothing is staged: move or remove a player first.") or nil end)
    Tips.Attach(p.cancelMove, "cancelmove", why)

    -- Fill the list from the group and the guild: the same as `addall`.
    p.addAllButton = button(p, "Add from your group and guild", 240, 22)
    p.addAllButton:SetPoint("BOTTOMLEFT", 4, 1)
    p.addAllButton:SetScript("OnClick", function() M:Command("addall") end)
    Tips.Attach(p.addAllButton, "addall", function()
        if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
    end)

    return p
end

-- for the parts installed after this one
h.classColor = classColor
end
