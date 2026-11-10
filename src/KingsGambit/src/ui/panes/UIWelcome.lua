-- King's Gambit: the game's windows, the Welcome section: the addon explained in short pages. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Tips, LootWindow, GuildBook
local P = SK:NewModule("UIWelcome", { "UITips", "LootWindow", "GuildBook" }, function(d) Tips, LootWindow, GuildBook = d.UITips, d.LootWindow, d.GuildBook end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local button = h.button

-- The Welcome section: the addon explained in four short pages (GuildBook.WELCOME_PAGES), one screenful each, with a row of buttons to move between them.
-- Each block gets its own text so the page has a hierarchy: a large gold title, gold headings with room above them, a callout with a bar at its left, and
-- bullets and numbers with a hanging indent and a little air between them; a list item's lead words are white and the rest softer, so it can be skimmed.
local WELCOME_W = 372
local SOFT = "|cffc9c9c9"

local function welcomeHeight(fs, text, width)
    local h = fs.GetStringHeight and fs:GetStringHeight()
    if type(h) == "number" and h > 0 then return h end
    return math.ceil(#text / (width / 6.2)) * 13 -- (a guess where the game can't measure)
end

function M:BuildWelcome(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    -- the page buttons, across the top
    p.pageButtons = {}
    local x = 0
    for _, page in ipairs(GuildBook.WELCOME_PAGES) do
        local b = button(p, page.label, 92, 22)
        b:SetPoint("TOPLEFT", x, 0)
        x = x + 96
        b:SetScript("OnClick", function() M.welcomePage = page.id; M:Refresh() end)
        p.pageButtons[page.id] = b
    end
    local ok, scroll = pcall(CreateFrame, "ScrollFrame", nil, p, "UIPanelScrollFrameTemplate")
    if not (ok and scroll) then scroll = CreateFrame("ScrollFrame", nil, p) end
    scroll:SetPoint("TOPLEFT", 0, -30); scroll:SetPoint("BOTTOMRIGHT", -26, 0)
    -- the first-run setting, at the very bottom of the window (below the command output), shown only with this page: on until it is turned off here
    local footer = CreateFrame("Frame", nil, p)
    local win = parent.GetParent and parent:GetParent() or parent
    footer:SetHeight(26); footer:SetWidth(260)
    footer:SetPoint("BOTTOM", win, "BOTTOM", 0, 4)
    p.footer = footer
    local label = "Show the welcome page first"
    local function toggle(on) GuildBook.SetWelcomeFirst(SK.client and SK.client.storage and SK.client:storage().shared, on); M:Refresh() end
    local okc, check = pcall(CreateFrame, "CheckButton", nil, footer, "UICheckButtonTemplate")
    if okc and check then
        check:SetPoint("LEFT", footer, "LEFT", 0, 0)
        check:SetScript("OnClick", function(self) toggle(self:GetChecked() and true or false) end)
        local text = footer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        text:SetPoint("LEFT", check, "RIGHT", 2, 1); text:SetText(label)
        local tw = text:GetStringWidth()
        if type(tw) == "number" and tw > 0 then footer:SetWidth(check:GetWidth() + 2 + tw) end -- (so the pair is centered as a whole)
        p.firstCheck = check
    else
        p.firstCheck = button(footer, label, 220)
        p.firstCheck:SetPoint("LEFT", footer, "LEFT", 2, -2)
        p.firstCheck:SetScript("OnClick", function() toggle(not p.firstOn) end)
        p.firstIsButton = true
    end
    Tips.Attach(p.firstCheck, "welcomefirst")
    local child = CreateFrame("Frame", nil, scroll)
    child:SetSize(WELCOME_W + 8, 1)
    scroll:SetScrollChild(child)
    p.scroll, p.child, p.pool, p.bars = scroll, child, {}, {}
    return p
end

-- Draw one page: every block under the one before it.
function M.RenderWelcome(p, pageId)
    local page
    for _, pg in ipairs(GuildBook.WELCOME_PAGES) do if pg.id == pageId then page = pg end end
    page = page or GuildBook.WELCOME_PAGES[1]
    local used, usedBars, y = 0, 0, 6
    local function put(font, text, x, width)
        used = used + 1
        local fs = p.pool[used]
        if not fs then fs = p.child:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); p.pool[used] = fs end
        if fs.SetFontObject then fs:SetFontObject(font) end
        fs:ClearAllPoints()
        fs:SetPoint("TOPLEFT", p.child, "TOPLEFT", x, -y)
        fs:SetWidth(width); fs:SetJustifyH("LEFT"); fs:SetJustifyV("TOP"); fs:SetWordWrap(true)
        fs:SetText(text)
        fs:Show()
        return fs
    end
    local function lead(item)
        if type(item) == "string" then return SOFT .. item .. "|r" end
        return "|cffffffff" .. item.lead .. "|r" .. (item.text ~= "" and (" " .. SOFT .. item.text .. "|r") or "")
    end
    for _, b in ipairs(page.blocks) do
        if b.kind == "title" then
            local fs = put("GameFontNormalLarge", b.text, 4, WELCOME_W)
            y = y + welcomeHeight(fs, b.text, WELCOME_W) + 8
        elseif b.kind == "heading" then
            y = y + 12
            local fs = put("GameFontNormal", b.text, 4, WELCOME_W)
            y = y + welcomeHeight(fs, b.text, WELCOME_W) + 6
        elseif b.kind == "text" then
            local fs = put("GameFontHighlight", SOFT .. b.text .. "|r", 4, WELCOME_W)
            y = y + welcomeHeight(fs, b.text, WELCOME_W) + 8
        elseif b.kind == "callout" then
            local fs = put("GameFontHighlight", b.text, 16, WELCOME_W - 12)
            local h = welcomeHeight(fs, b.text, WELCOME_W - 12)
            usedBars = usedBars + 1
            local bar = p.bars[usedBars]
            if not bar then bar = p.child:CreateTexture(nil, "ARTWORK"); p.bars[usedBars] = bar end
            bar:SetColorTexture(1, 0.82, 0, 0.9)
            bar:ClearAllPoints()
            bar:SetPoint("TOPLEFT", p.child, "TOPLEFT", 4, -y); bar:SetSize(3, h)
            bar:Show()
            y = y + h + 10
        else
            for i, item in ipairs(b.items) do
                local glyph = b.kind == "numbered" and (i .. ".") or "•"
                local indent = b.kind == "numbered" and 26 or 18
                put("GameFontNormal", glyph, 4, indent - 4)
                local fs = put("GameFontHighlight", lead(item), indent, WELCOME_W - indent + 4)
                y = y + welcomeHeight(fs, GuildBook.ItemText(item), WELCOME_W - indent + 4) + 5
            end
            y = y + 3
        end
    end
    for i = used + 1, #p.pool do p.pool[i]:Hide() end
    for i = usedBars + 1, #p.bars do p.bars[i]:Hide() end
    p.child:SetHeight(y + 16)
    if p.scroll.SetVerticalScroll then p.scroll:SetVerticalScroll(0) end
    p.shown = page.id
    for id, b in pairs(p.pageButtons) do LootWindow.Mark(b, id == page.id) end
end

function M.RefreshWelcome(p)
    local id = M.welcomePage or GuildBook.WELCOME_PAGES[1].id
    if p.shown ~= id then M.RenderWelcome(p, id) end
    p.firstOn = GuildBook.WelcomeFirst(SK.client and SK.client.storage and SK.client:storage().shared)
    if p.firstIsButton then p.firstCheck:SetText("Welcome page first: " .. (p.firstOn and "on" or "off"))
    elseif p.firstCheck.SetChecked then p.firstCheck:SetChecked(p.firstOn) end
end
end
