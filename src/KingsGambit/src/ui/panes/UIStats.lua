-- King's Gambit: the game's windows, the Stats section: who held which place for how long. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Tips, GuildBook
local P = SK:NewModule("UIStats", { "UITips", "GuildBook" }, function(d) Tips, GuildBook = d.UITips, d.GuildBook end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local HIST_H, classColor = h.HIST_H, h.classColor

-- ---- The Stats section: who held which place for how long ----------------------------------------------------------------------------

local STAT_X, STAT_W = { 4, 30, 148, 226, 262, 346 }, { 24, 116, 76, 32, 80, 64 }

function M.InitStatsRow(row, r)
    row.stat = r
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then if M.statsSelected == r.who then row.hl:Show() else row.hl:Hide() end end
    if row.SetScript and not row.clickSet then
        row.clickSet = true
        row:SetScript("OnClick", function(self) if self.stat then M.statsSelected = self.stat.who; M:Refresh() end end)
    end
    if not row.cells then
        row.cells = {}
        for c = 1, 6 do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            fs:SetPoint("LEFT", STAT_X[c], 0)
            fs:SetJustifyH("LEFT"); fs:SetWordWrap(false); fs:SetWidth(STAT_W[c])
            row.cells[c] = fs
        end
    end
    row.cells[1]:SetText(tostring(r.place))
    row.cells[2]:SetText(classColor(r.class) .. r.name .. "|r" .. (r.mine and "  (you)" or ""))
    row.cells[3]:SetText(r.heldText or "")
    row.cells[4]:SetText(tostring(r.wins))
    row.cells[5]:SetText(r.lastWinText or "")
    row.cells[6]:SetText(r.raidsText or "")
end

function M:BuildStats(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    p.listText = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    p.listText:SetPoint("TOPLEFT", 4, 0)
    p.summary = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.summary:SetPoint("TOPLEFT", 4, -20); p.summary:SetWidth(410); p.summary:SetHeight(40)
    p.summary:SetJustifyH("LEFT"); p.summary:SetJustifyV("TOP"); p.summary:SetWordWrap(true)
    -- The headings are buttons: click one to sort by it, again to reverse it.
    p.heads = {}
    for i, col in ipairs(GuildBook.STATS_COLUMNS) do
        local b = CreateFrame("Button", nil, p)
        b:SetSize(STAT_W[i] + (i < 6 and (STAT_X[i + 1] - STAT_X[i] - STAT_W[i]) or 0), 14)
        b:SetPoint("TOPLEFT", STAT_X[i] + 4, -63)
        local fs = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("LEFT", 0, 0); fs:SetText(col.label)
        b.text, b.col = fs, col
        b:SetScript("OnClick", function() M.statsSort = GuildBook.NextStatsSort(M.statsSort or GuildBook.StatsDefaultSort(), col.id); M:Refresh() end)
        Tips.Attach(b, "statssort")
        p.heads[i] = b
    end
    p.detailTitle = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.detailTitle:SetPoint("BOTTOMLEFT", 4, 112); p.detailTitle:SetText("Places held")
    p.detail = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.detail:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 4, 108); p.detail:SetWidth(410); p.detail:SetHeight(104)
    p.detail:SetJustifyH("LEFT"); p.detail:SetJustifyV("TOP"); p.detail:SetWordWrap(true)
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then inset:SetPoint("TOPLEFT", -2, -76); inset:SetPoint("BOTTOMRIGHT", 2, 132) end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -80)
        box:SetPoint("BOTTOMRIGHT", -22, 136)
        bar:SetPoint("TOPLEFT", box, "TOPRIGHT", 4, -2)
        bar:SetPoint("BOTTOMLEFT", box, "BOTTOMRIGHT", 4, 2)
        local view = CreateScrollBoxListLinearView()
        view:SetElementExtent(HIST_H)
        view:SetElementInitializer("Button", M.InitStatsRow)
        ScrollUtil.InitScrollBoxListWithScrollBar(box, bar, view)
        p.scrollBox = box
    end)
    if not okBox then
        local scroll = CreateFrame("ScrollFrame", nil, p)
        scroll:SetPoint("TOPLEFT", 4, -80); scroll:SetPoint("BOTTOMRIGHT", -26, 136)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(380, 1)
        scroll:SetScrollChild(p.child)
        p.lines = {}
    end
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -96); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    return p
end

function M.RefreshStats(p, ctx)
    local listId = M.list or ctx.engine:RaidList() or "main"
    local stats = GuildBook.Stats(ctx, listId)
    local me = ctx.client:me()
    for _, r in ipairs(stats.rows) do r.mine = r.who == me end
    p.listText:SetText(("List: %s"):format(listId))
    p.summary:SetText(table.concat(stats.summary, "\n"))
    -- sorted: the most active first until a heading is clicked; the heading sorted by shows which way
    local sort = M.statsSort or GuildBook.StatsDefaultSort()
    for _, b in ipairs(p.heads or {}) do
        b.text:SetText(b.col.label .. (sort.key == b.col.id and (sort.dir == "asc" and " ^" or " v") or ""))
    end
    stats.rows = GuildBook.SortStats(stats.rows, sort)
    if p.scrollBox then
        local data = CreateDataProvider()
        for _, r in ipairs(stats.rows) do data:Insert(r) end
        p.scrollBox:SetDataProvider(data, ScrollBoxConstants and ScrollBoxConstants.RetainScrollPosition)
    else
        for i, r in ipairs(stats.rows) do
            local line = p.lines[i]
            if not line then
                line = CreateFrame("Button", nil, p.child)
                line:SetSize(380, HIST_H); line:SetPoint("TOPLEFT", 0, -(i - 1) * HIST_H)
                p.lines[i] = line
            end
            M.InitStatsRow(line, r); line:Show()
        end
        for i = #stats.rows + 1, #p.lines do p.lines[i]:Hide() end
        p.child:SetHeight(math.max(#stats.rows * HIST_H, 1))
    end
    local who = M.statsSelected
    local known
    for _, r in ipairs(stats.rows) do if r.who == who then known = r end end
    if not known then M.statsSelected, who = nil, nil end
    if who then
        local lines = { ("|cffffd100%s|r: place %d of %d"):format(known.name, known.place, stats.total) }
        local a = stats.attendance.byPlayer[who]
        if stats.attendance.total > 0 then
            lines[#lines + 1] = ("Raids: %d of %d, in the raid %d%% of the time%s"):format(a and a.attended or 0, stats.attendance.total, a and a.percent or 0,
                (a and a.leftEarly > 0) and (", left early %d time%s"):format(a.leftEarly, a.leftEarly == 1 and "" or "s") or "")
        end
        for i, h in ipairs(GuildBook.PlaceHistory(stats, who)) do
            if #lines > 8 then lines[#lines + 1] = "|cff999999...|r"; break end
            lines[#lines + 1] = h.text
        end
        p.detail:SetText(table.concat(lines, "\n"))
    else
        p.detail:SetText("Click a player to see every place they have held, and for how long.")
    end
    if #stats.rows == 0 then p.message:SetText("Nobody is on this list yet."); p.message:Show() else p.message:Hide() end
end
end
