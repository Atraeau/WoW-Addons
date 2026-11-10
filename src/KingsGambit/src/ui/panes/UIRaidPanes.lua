-- King's Gambit: the game's windows, the This raid section and the Raids section's start-time panel. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Tips, GuildBook
local P = SK:NewModule("UIRaidPanes", { "UITips", "GuildBook" }, function(d) Tips, GuildBook = d.UITips, d.GuildBook end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local HIST_H, button = h.HIST_H, h.button

-- ---- The This raid section: the open raid in numbers, and its part of the ledger ------------------------------------------------

function M:BuildThisRaid(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    p.summary = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.summary:SetPoint("TOPLEFT", 4, 0); p.summary:SetWidth(410); p.summary:SetHeight(100)
    p.summary:SetJustifyH("LEFT"); p.summary:SetJustifyV("TOP"); p.summary:SetWordWrap(true)
    local head = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    head:SetPoint("TOPLEFT", 4, -110); head:SetText("What has happened in this raid")
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then inset:SetPoint("TOPLEFT", -2, -124); inset:SetPoint("BOTTOMRIGHT", 2, 22) end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -128)
        box:SetPoint("BOTTOMRIGHT", -22, 26)
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
        scroll:SetPoint("TOPLEFT", 4, -128); scroll:SetPoint("BOTTOMRIGHT", -26, 26)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(380, 1)
        scroll:SetScrollChild(p.child)
        p.lines = {}
    end
    p.countText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.countText:SetPoint("BOTTOMRIGHT", -6, 4)
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -146); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    return p
end

function M.RefreshThisRaid(p, ctx)
    local raid = GuildBook.RaidNow(ctx)
    p.summary:SetText(table.concat(raid.lines, "\n"))
    local h = raid.running and GuildBook.History(ctx, raid.filter) or { entries = {}, total = 0, shown = 0 }
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
    p.countText:SetText(raid.running and (h.total > h.shown and ("Showing the newest %d of %d"):format(h.shown, h.total) or ("%d entries"):format(h.total)) or "")
    if raid.running and h.total == 0 then p.message:SetText("Nothing has happened in this raid yet."); p.message:Show() else p.message:Hide() end
end

-- ---- The Raids section's panel: when the raid starts -------------------------------------------------------------------------------

-- At the foot of the Raids page: where this raid stands, whether it starts by itself, and a button to start it now.
function M.BuildRaidStart(page)
    local p = CreateFrame("Frame", nil, page)
    p:SetPoint("BOTTOMLEFT", 0, 0); p:SetPoint("BOTTOMRIGHT", 0, 0); p:SetHeight(104)
    local line = p:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 1, 1, 0.12); line:SetHeight(1)
    line:SetPoint("TOPLEFT", 0, 0); line:SetPoint("TOPRIGHT", 0, 0)
    local title = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 4, -12); title:SetText("When the raid starts")
    p.status = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.status:SetPoint("TOPLEFT", 4, -34); p.status:SetWidth(410); p.status:SetHeight(28)
    p.status:SetJustifyH("LEFT"); p.status:SetJustifyV("TOP"); p.status:SetWordWrap(true)
    local label = "Start by itself at the first enemy killed in an instance"
    local okc, check = pcall(CreateFrame, "CheckButton", nil, p, "UICheckButtonTemplate")
    if okc and check then
        check:SetPoint("TOPLEFT", 0, -66)
        check:SetScript("OnClick", function(self) M:Command("raid autostart " .. (self:GetChecked() and "on" or "off")) end)
        local text = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        text:SetPoint("LEFT", check, "RIGHT", 2, 1); text:SetWidth(240); text:SetJustifyH("LEFT"); text:SetText(label)
        p.check = check
    else
        p.check = button(p, "Start by itself: on", 150)
        p.check:SetPoint("TOPLEFT", 4, -68)
        p.check:SetScript("OnClick", function() M:Command("raid autostart " .. (p.autoNow and "off" or "on")) end)
        p.checkIsButton = true
    end
    Tips.Attach(p.check, "raidautostart")
    p.start = button(p, "Start the raid now", 140)
    p.start:SetPoint("TOPRIGHT", -2, -66)
    p.start:SetScript("OnClick", function() M:Command("raid start") end)
    Tips.Attach(p.start, "raidstartnow")
    page.startPanel = p
    return p
end

function M.RefreshRaidStart(page, ctx)
    local p = page.startPanel
    if not p then return end
    local rs = GuildBook.RaidStart(ctx)
    p.autoNow = rs.auto
    p.status:SetText(rs.text)
    if p.checkIsButton then p.check:SetText("Start by itself: " .. (rs.auto and "on" or "off")) elseif p.check.SetChecked then p.check:SetChecked(rs.auto) end
    if p.check.SetEnabled then p.check:SetEnabled(rs.available and rs.running) end
    p.start:SetEnabled(rs.canStart)
end
end
