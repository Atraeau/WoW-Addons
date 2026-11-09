-- King's Gambit: the Loot window, the small window for a live loot session. Keep this file Lua 5.1-safe.
-- It draws the table LootView builds (the same one the web simulator draws) with the game's frames, and runs a button's `act` as the command a player
-- could type, so every rule, message and ledger entry is the one the commands already have. It opens by itself when a session starts.
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local UILoot, LootView, Tips
local M = SK:NewModule("LootWindow", { "UILoot", "LootView", "UITips" }, function(d) UILoot, LootView, Tips = d.UILoot, d.LootView, d.UITips end)

local WIDTH = 464   -- 408 of content, 28 each side; the item list's scroll bar sits in the right margin
local MAX = 24         -- the most items drawn (UILoot.MAX_ITEMS); more are mentioned
local HINT_H = 62      -- the strip at the foot that says what a button does
local SCROLL_H = 330   -- the item list scrolls past this height

-- What a button's `act` types. Returns the command, or nil and what to tell the player.
function M.CommandText(act, target)
    local n = act.name
    if n == "bid" then return ("%s %d"):format(act.kind, act.item)
    elseif n == "pick" then return "pick " .. act.item
    elseif n == "skip" or n == "keep" or n == "decline" or n == "resolve" or n == "confirm" or n == "cancel" then return n
    elseif n == "extend" then return "extend " .. (act.seconds or 30)
    elseif n == "rank" then
        local ids = {}
        for i, id in ipairs(act.order or {}) do ids[i] = tostring(id) end
        return "rank " .. table.concat(ids, " ")
    elseif n == "withdraw" then return "withdraw yes"
    elseif n == "give" then
        if not target or target == "" then return nil, "Choose who gets it from the dropdown first." end
        return "recipient " .. target
    elseif n == "claim" then
        if act.gift then
            if not target or target == "" then return nil, "Choose who to gift it to from the dropdown first." end
            return "claim " .. target
        end
        return "claim"
    end
end

-- A line of pieces (LootView's `segments`) as the game's colored text: a person's name in their class color, then their spec and class in gray, as the
-- standings list shows them.
function M.Rich(segments)
    local out = {}
    for _, seg in ipairs(segments or {}) do
        if seg.text then out[#out + 1] = seg.text
        elseif seg.who then
            local w = seg.who
            local name = w.color and ("|cff" .. w.color .. w.name .. "|r") or w.name
            local detail = w.short and "" or ((w.spec and (w.spec .. " ") or "") .. (w.className or "")):gsub("%s+$", "")
            out[#out + 1] = detail ~= "" and (name .. " |cff" .. (w.color or "999999") .. "(" .. detail .. ")|r") or name
        end
    end
    return table.concat(out)
end

local function button(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
end

local function setShown(frame, on)
    local now = frame.IsShown and frame:IsShown()
    if on and not now then frame:Show() elseif not on and now then frame:Hide() end
end

-- A button drawn from a view button: its label, its grayed-out state, and a tooltip that also says why it is grayed.
-- Show a button as the player's current choice: a push-button toggle that stays pushed in, the way the game's own interface does it (its micro-menu
-- buttons stay pressed while their window is open, as do the Damage Meter's and Edit Mode's: SetButtonState("PUSHED", true)). The game's pressed art is faint
-- on its red buttons, so the pushed-in look is reinforced with an inset bevel drawn on top: a slightly darker body, a shadow fading inward along the top and left
-- edges and a light fading inward along the bottom and right (mirrored, so it isn't just a button that is darker at the top), which reads as "pressed in" at a glance and, being shading, does not rely on a change of hue. The label is left exactly as it is: the
-- text and its color are never changed. Un-marking puts the button back completely (released, the bevel gone), so nothing of a previous round is left on a
-- button that is reused for the next one.
local BEVEL_INSET = 5 -- (inside the button's own border: the border is never shaded, only the face)
local function bevel(b)
    if b.bevel then return b.bevel end
    if not b.CreateTexture then return nil end
    local I = BEVEL_INSET
    local list = {}
    local function layer(a)
        -- (ARTWORK, above the button's own art and below its label, which is drawn in OVERLAY: the shading darkens the face and never the text)
        local t = b:CreateTexture(nil, "ARTWORK", nil, 7)
        if t.SetColorTexture then t:SetColorTexture(0, 0, 0, a) end
        list[#list + 1] = t
        return t
    end
    -- The face of a held-down button is a little darker, with a shadow fading inward from its top and left edges, as a real inset is lit from above-left. The
    -- button's border keeps its own shade (the game's mouse-down look is the bright one; this one is deliberately different). No light edges: they read as an outline.
    local body = layer(0.50) -- (clearly darker: the face of a held-down button is a deep, muted red, its label dimmed with it)
    body:SetPoint("TOPLEFT", b, "TOPLEFT", I, -I); body:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -I, I)
    for i, a in ipairs { 0.30, 0.16, 0.07 } do -- shadow, top
        local t = layer(a); t:SetHeight(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I, -(I + i - 1)); t:SetPoint("TOPRIGHT", b, "TOPRIGHT", -I, -(I + i - 1))
    end
    for i, a in ipairs { 0.20, 0.10 } do -- shadow, left
        local t = layer(a); t:SetWidth(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I + i - 1, -I); t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", I + i - 1, I)
    end
    b.bevel = list
    return b.bevel
end

function M.Mark(b, on)
    on = on and true or false
    if not on and not b.marked then return end -- never marked: nothing to undo
    if on then
        if b.SetButtonState then b:SetButtonState("PUSHED", true) end -- (true: stays pressed until code releases it)
        for _, t in ipairs(bevel(b) or {}) do t:Show() end
    else
        if b.SetButtonState then b:SetButtonState("NORMAL", false) end
        for _, t in ipairs(b.bevel or {}) do t:Hide() end
    end
    b.marked = on
end

local function setup(b, vb, label)
    b.view = vb
    b:SetText(label)
    if b.SetEnabled then b:SetEnabled(vb.enabled) end
    M.Mark(b, vb.selected)
end

local function tooltipOf(b)
    return function()
        local t = b.view and b.view.tip
        if t then return t.title, t.text end
    end, function()
        local vb = b.view
        if vb and not vb.enabled and vb.why then return "Unavailable: " .. vb.why end
    end
end

-- A window the player can move: drag it by its title bar or anywhere that isn't a button. Where they leave it is remembered for this character
-- (KingsGambitCharDB.ui[key]), it can't be dragged off the screen, and `/gambit window reset` puts both windows back. `default` = { point, x, y }.
function M.Movable(f, key, default)
    f:SetMovable(true); f:EnableMouse(true)
    if f.SetToplevel then f:SetToplevel(true) end -- clicking a window raises it above others at its level
    if f.SetClampedToScreen then f:SetClampedToScreen(true) end
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relPoint, x, y = self:GetPoint()
        local store = SK.char and SK.char.ui
        if store and type(point) == "string" then store[key] = { point, relPoint, x, y } end
    end)
    f.placeDefault = function()
        f:ClearAllPoints()
        f:SetPoint(default[1], UIParent, default[1], default[2], default[3])
    end
    local saved = SK.char and SK.char.ui and SK.char.ui[key]
    if type(saved) == "table" and type(saved[1]) == "string" and tonumber(saved[3]) and tonumber(saved[4]) then
        f:ClearAllPoints()
        f:SetPoint(saved[1], UIParent, saved[2] or saved[1], saved[3], saved[4])
    else
        f.placeDefault()
    end
end

---------------------------------------------------------------- layout
-- One grid for the whole window, so everything lines up: a 16 pixel margin all round, an 8 pixel unit of spacing, one content width, and widths that divide it
-- (four equal buttons across a row, four across the Master Looter's strip). Heights follow the text (a wrapped line is measured, not guessed), so nothing
-- collides when a message runs to two or three lines. Related things are grouped under thin dividers; an item is its name on its own line, then the choices across the full
-- width, and the chosen one is shown by the button itself (held pushed in), never echoed in words.
local PAD, GAP = 28, 8
local CW = 408                      -- the content width
local BTN_H = 22
local BTN4 = (CW - 3 * GAP) / 4     -- four equal buttons across the content width (96)

-- The height a (wrapped) line of text takes, never less than `min` (the game gives the real number; a stand-in gives none).
-- The lessons were written for the web page; in the game their "Corrections card" is the Awards section.
function M.GameText(t)
    t = tostring(t or "")
    t = t:gsub("the Corrections card below", "the Awards section"):gsub("the Corrections card", "the Awards section"):gsub("The Corrections card", "The Awards section")
    return t
end

local function textH(fs, min)
    local h = fs.GetStringHeight and fs:GetStringHeight()
    if type(h) ~= "number" then h = min end
    return math.max(min, math.ceil(h))
end

function M.Build(ui)
    local ok, f = pcall(CreateFrame, "Frame", "KingsGambitLootWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not f then f = CreateFrame("Frame", "KingsGambitLootWindow", UIParent) end
    f:SetSize(WIDTH, 120)
    f:SetFrameStrata("DIALOG") -- the same layer as the main window: the game opens dropdown menus in this one, so a higher layer would hide them
    M.Movable(f, "loot", { "CENTER", -440, 140 }) -- by default left of the main window (centered, 420 wide)
    if f.TitleText then f.TitleText:SetText("King's Gambit: loot") end
    if not f.TitleText then
        local t = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        t:SetPoint("TOP", 0, -10); t:SetText("King's Gambit: loot")
        local close = button(f, "Close", 60); close:SetPoint("TOPRIGHT", -8, -8)
        close:SetScript("OnClick", function() f:Hide() end)
    end

    local function text(font, w, justify, wrap)
        local s = f:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
        s:SetWidth(w or CW); s:SetJustifyH(justify or "LEFT"); s:SetWordWrap(wrap ~= false)
        return s
    end
    -- what a button says (its tip) shows in the strip at the foot of this window, not in a tooltip, so it can never cover the list beside it
    f.hint = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.hint:SetWidth(CW); f.hint:SetHeight(HINT_H); f.hint:SetJustifyH("LEFT"); f.hint:SetJustifyV("TOP"); f.hint:SetWordWrap(true)
    local function sink(title, body)
        if not title then f.hint:SetText("") else f.hint:SetText("|cffffd100" .. title .. "|r\n|cffcccccc" .. (body or "") .. "|r") end
    end
    local function attach(fr, tip, extra) Tips.Attach(fr, tip, extra, sink) end
    -- Your spec for this raid (it decides what is a main-spec Need, so it is asked for before your first answer and then holds for the whole raid):
    -- one button per spec of your class, the talents' pick marked, and a switch to take that pick every time
    f.specLabel = text("GameFontNormalSmall")
    f.specButtons = {}
    for i = 1, 4 do
        local b = button(f, "", 96, BTN_H)
        b:SetScript("OnClick", function(self) if self.specName then ui:ChooseSpec(self.specName) end end)
        attach(b, "specpick")
        f.specButtons[i] = b
    end
    f.specAuto = button(f, "", 168, BTN_H)
    f.specAuto:SetScript("OnClick", function() ui:ToggleAutoSpec() end)
    attach(f.specAuto, "specauto")
    local function onClick(b) b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end); attach(b, tooltipOf(b)) end

    f.practiceText = text("GameFontNormalSmall")
    -- The countdown bar is drawn from two plain colored textures (a track and a fill as wide as the time left), not a StatusBar: it needs no
    -- texture file or template, so it looks the same in every client, and it drains from the right as the time runs out.
    f.bar = CreateFrame("Frame", nil, f)
    f.bar:SetSize(CW, 8)
    f.bar.track = f.bar:CreateTexture(nil, "BACKGROUND")
    f.bar.track:SetAllPoints(f.bar)
    f.bar.track:SetColorTexture(1, 1, 1, 0.10)
    f.bar.fill = f.bar:CreateTexture(nil, "ARTWORK")
    f.bar.fill:SetPoint("TOPLEFT", f.bar, "TOPLEFT", 0, 0)
    f.bar.fill:SetPoint("BOTTOMLEFT", f.bar, "BOTTOMLEFT", 0, 0)
    f.bar.fill:SetWidth(CW)
    f.meta = text("GameFontHighlightSmall", CW - 170, "LEFT", false)
    f.metaRight = text("GameFontHighlightSmall", 170, "RIGHT", false)
    f.banner = text("GameFontHighlight")
    f.turnText = text("GameFontNormal")
    f.more = text("GameFontHighlightSmall")
    -- a lesson (practice mode's tutorials) has a window of its own, left of this one, so the bidding here looks exactly as it does in a real raid:
    -- the title, the text (it scrolls), how it went, and Start / Try again / Next
    local okLw, lw = pcall(CreateFrame, "Frame", nil, f, "BasicFrameTemplateWithInset")
    if not okLw or not lw then lw = CreateFrame("Frame", nil, f) end
    lw:SetSize(340, 430)
    lw:SetPoint("TOPRIGHT", f, "TOPLEFT", -4, 0)
    if lw.TitleText then lw.TitleText:SetText("Practice lesson") end
    f.lessonWin = lw
    f.lessonTitle = lw:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.lessonTitle:SetPoint("TOPLEFT", 14, -32); f.lessonTitle:SetWidth(298); f.lessonTitle:SetJustifyH("LEFT"); f.lessonTitle:SetWordWrap(true)
    local okLs, lsc = pcall(CreateFrame, "ScrollFrame", nil, lw, "UIPanelScrollFrameTemplate")
    if not (okLs and lsc) then lsc = CreateFrame("ScrollFrame", nil, lw) end
    lsc:SetPoint("TOPLEFT", 10, -70); lsc:SetPoint("BOTTOMRIGHT", -30, 118)
    lw.child = CreateFrame("Frame", nil, lsc)
    lw.child:SetSize(296, 1)
    lsc:SetScrollChild(lw.child)
    lw.scroll = lsc
    f.lessonText = lw.child:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.lessonText:SetPoint("TOPLEFT", 4, 0); f.lessonText:SetWidth(288); f.lessonText:SetJustifyH("LEFT"); f.lessonText:SetWordWrap(true)
    f.lessonVerdict = lw:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.lessonVerdict:SetPoint("BOTTOMLEFT", 14, 46); f.lessonVerdict:SetWidth(298); f.lessonVerdict:SetHeight(64); f.lessonVerdict:SetJustifyH("LEFT"); f.lessonVerdict:SetJustifyV("BOTTOM"); f.lessonVerdict:SetWordWrap(true)
    f.lessonStart = button(lw, "Start the lesson", 168, BTN_H)
    f.lessonStart:SetScript("OnClick", function() ui:LessonStart() end)
    attach(f.lessonStart, "lessonstart")
    f.lessonAgain = button(lw, "Try again", 120, BTN_H)
    f.lessonAgain:SetScript("OnClick", function() ui:LessonAgain() end)
    attach(f.lessonAgain, "lessonagain")
    f.lessonNext = button(lw, "Next lesson", 120, BTN_H)
    f.lessonNext:SetScript("OnClick", function() ui:LessonNext() end)
    attach(f.lessonNext, "lessonnext")
    lw:Hide()

    -- thin dividers between the groups (the turn, your order, the items, the Master Looter, practice)
    f.dividers = {}
    for i = 1, 7 do
        local d = f:CreateTexture(nil, "ARTWORK")
        d:SetSize(CW, 1)
        if d.SetColorTexture then d:SetColorTexture(1, 1, 1, 0.15) end
        f.dividers[i] = d
    end

    -- the items live in a scrolling list, so any number of them fit (the window stops growing at SCROLL_H)
    local okScroll0, scroll0 = pcall(CreateFrame, "ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
    if not (okScroll0 and scroll0) then scroll0 = CreateFrame("ScrollFrame", nil, f) end
    f.scroll = scroll0
    f.list = CreateFrame("Frame", nil, scroll0)
    f.list:SetSize(PAD + CW + 4, 1)
    scroll0:SetScrollChild(f.list)
    if scroll0.EnableMouseWheel then scroll0:EnableMouseWheel(true) end
    local list = f.list

    f.rows = {}
    for i = 1, MAX do
        local row = { }
        row.text = list:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetWidth(CW); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        -- Hover for the item's tooltip; shift-click puts the link in chat, as anywhere in the game.
        row.hit = CreateFrame("Button", nil, list)
        row.hit:SetSize(CW, 16)
        row.hit:SetScript("OnEnter", function(self)
            if row.tip and GameTooltip then
                GameTooltip:SetOwner(self, (f.side and f.side.IsShown and f.side:IsShown()) and "ANCHOR_LEFT" or "ANCHOR_RIGHT"); GameTooltip:SetHyperlink(row.tip); GameTooltip:Show()
            end
        end)
        row.hit:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
        row.hit:SetScript("OnClick", function()
            if not row.tip then return end
            local get = (C_Item and C_Item.GetItemInfo) or GetItemInfo
            local full = get and select(2, get(row.tip)) or row.tip
            if HandleModifiedItemClick and HandleModifiedItemClick(full) then return end -- (shift-click: the link goes to chat)
            if row.id and ui.SelectBidItem then ui:SelectBidItem(row.id) end
        end)
        -- Click an item to select it: a gray band behind it, and the side panel lists every player's answer on it (one item at a time)
        row.bg = list:CreateTexture(nil, "BACKGROUND")
        if row.bg.SetColorTexture then row.bg:SetColorTexture(1, 1, 1, 0.12) end
        row.sel = CreateFrame("Button", nil, list)
        row.sel:SetScript("OnClick", function() if row.id then ui:SelectBidItem(row.id) end end)
        attach(row.sel, "bidspick")
        local lvl = row.sel.GetFrameLevel and row.sel:GetFrameLevel()
        if type(lvl) == "number" and row.hit.SetFrameLevel then row.hit:SetFrameLevel(lvl + 1) end -- (the name stays above the band, for its item tooltip)
        row.note = list:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); row.note:SetWidth(CW); row.note:SetJustifyH("LEFT"); row.note:SetWordWrap(true)
        row.bid = list:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); row.bid:SetWidth(CW); row.bid:SetJustifyH("LEFT"); row.bid:SetWordWrap(true)      -- a result, or why a choice is unavailable, under the item
        row.buttons = {}
        for j = 1, 4 do
            local b = button(list, "", BTN4, BTN_H)
            onClick(b)
            local bl = row.sel.GetFrameLevel and row.sel:GetFrameLevel()
            if type(bl) == "number" and b.SetFrameLevel then b:SetFrameLevel(bl + 2) end
            row.buttons[j] = b
        end
        f.rows[i] = row
    end

    -- Your order, when you want several items of one kind: a heading with Confirm on its right, then a line per item with Up and Down on its right.
    f.rankTitles, f.rankConfirms, f.rankRows = {}, {}, {}
    for i = 1, 3 do
        f.rankTitles[i] = text("GameFontNormalSmall", CW - 118, "LEFT", false)
        local c = button(f, "", 110, BTN_H)
        onClick(c)
        f.rankConfirms[i] = c
    end
    for i = 1, 12 do
        local r = {}
        r.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        r.text:SetWidth(CW - 110); r.text:SetJustifyH("LEFT"); r.text:SetWordWrap(false)
        r.up, r.down = button(f, "", 48, 20), button(f, "", 48, 20)
        onClick(r.up); onClick(r.down)
        f.rankRows[i] = r
    end

    -- your turn
    f.turnButtons = {}
    for i = 1, 7 do
        local b = button(f, "", 64, BTN_H)
        onClick(b)
        f.turnButtons[i] = b
    end
    -- Who gets a gift: chosen from the group, never typed. (A box stays only as the fallback when the game has no dropdown.)
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, f, "WowStyle1DropdownTemplate")
    if okDrop and drop and drop.SetupMenu then
        drop:SetWidth(140)
        drop:SetDefaultText("Choose a player")
        drop:SetupMenu(function(_, root)
            if root.SetScrollMode then root:SetScrollMode(260) end
            -- only players who can have the item (LootView's turn.targets), so a gift to someone who can't is not on offer
            for _, name in ipairs(f.giftTargets or {}) do
                root:CreateRadio((name:gsub("_", " ")), function() return f.recipientPick == name end, function() f.recipientPick = name end)
            end
        end)
        f.drop = drop
    end
    f.recipient = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.recipient:SetSize(110, 20); f.recipient:SetAutoFocus(false)

    -- the Master Looter's strip (only the Master Looter's window has it) and the way in
    f.mlLabel = text("GameFontNormalSmall", CW, "LEFT", false)
    f.mlLabel:SetText("Master Looter")
    f.mlButtons = {}
    for i = 1, 4 do
        local b = button(f, "", BTN4, BTN_H)
        onClick(b)
        f.mlButtons[i] = b
    end
    f.startButton = button(f, "Start from the loot window", 190, BTN_H)
    f.startButton:SetScript("OnClick", function() ui:Command("loot") end)
    attach(f.startButton, "start")

    -- practice only
    f.practiceLabel = text("GameFontNormalSmall", CW, "LEFT", false)
    f.practiceLabel:SetText("Practice")
    f.nextBoss = button(f, "Next boss", 168, BTN_H)
    f.nextBoss:SetScript("OnClick", function() ui:PracticeKill() end)
    attach(f.nextBoss, "kill")
    f.handOut = button(f, "Hand out the loot", 120, BTN_H)
    f.handOut:SetScript("OnClick", function() ui:PracticeHandOut() end)
    attach(f.handOut, "handout")
    f.raidButton = button(f, "End the raid", 150, BTN_H)
    f.raidButton:SetScript("OnClick", function() if f.raidIsOpen then ui:PracticeEndRaid() else ui:PracticeOpenRaid() end end)
    attach(f.raidButton, "raidtoggle")
    f.leaveButton = button(f, "Someone leaves", 116, BTN_H)
    f.leaveButton:SetScript("OnClick", function() ui:PracticeLeave() end)
    attach(f.leaveButton, "leaveraid")
    f.rejoinButton = button(f, "Someone returns", 126, BTN_H)
    f.rejoinButton:SetScript("OnClick", function() ui:PracticeRejoin() end)
    attach(f.rejoinButton, "rejoinraid")
    -- the side panel: everyone's answer on the one item that is selected, in a list that scrolls
    local okSide, side = pcall(CreateFrame, "Frame", nil, f, "BasicFrameTemplateWithInset")
    if not okSide or not side then side = CreateFrame("Frame", nil, f) end
    side:SetWidth(330)
    side:SetPoint("TOPLEFT", f, "TOPRIGHT", 4, 0)
    side.title = side:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    side.title:SetPoint("TOPLEFT", 12, -30); side.title:SetWidth(290); side.title:SetJustifyH("LEFT"); side.title:SetWordWrap(false)
    local okScroll, scroll = pcall(CreateFrame, "ScrollFrame", nil, side, "UIPanelScrollFrameTemplate")
    if not (okScroll and scroll) then scroll = CreateFrame("ScrollFrame", nil, side) end
    scroll:SetPoint("TOPLEFT", 10, -52); scroll:SetPoint("BOTTOMRIGHT", -30, 10)
    side.child = CreateFrame("Frame", nil, scroll)
    side.child:SetSize(286, 1)
    scroll:SetScrollChild(side.child)
    side.lines = {}
    if type(side.CloseButton) == "table" then side.CloseButton:SetScript("OnClick", function() ui.bidItem = nil; ui:Refresh() end) end
    side:Hide()
    f.side = side
    f.wait = button(f, "Wait 10 s", 80, BTN_H)
    f.wait:SetScript("OnClick", function() ui:PracticeWait(10) end)
    attach(f.wait, "wait")

    f:SetScript("OnUpdate", function() ui:Tick() end)
    if UISpecialFrames then table.insert(UISpecialFrames, "KingsGambitLootWindow") end
    f:Hide()
    return f
end

function M.Run(act, f, ui)
    -- Moving an item in your order only rearranges what you see; the session hears nothing until you press Confirm.
    if act.name == "rankmove" then
        f.rankDraft = f.rankDraft or {}
        f.rankDraft[act.kind] = act.order
        return ui:Refresh()
    end
    if act.name == "rank" and f.rankDraft then f.rankDraft[act.kind] = nil end -- confirmed: the session now holds it
    -- answering an item selects it, so the answers on that item are in view as you decide
    if act.name == "bid" and act.item then ui.bidItem, ui.bidFollow = act.item, true end
    local cmd, problem = M.CommandText(act, f.recipientPick)
    if not cmd then return ui.Say(problem or "That isn't available.") end
    if act.name == "give" or (act.name == "claim" and act.gift) then f.recipientPick = nil end
    ui:Command(cmd)
end

-- Draw the view. `want` is every frame this state shows; frames are shown or hidden only when that changes (hiding and re-showing every second
-- would close an open dropdown), and they are moved only when the layout changes.
-- The side panel: everyone's answer on the ticked item (only while the list of bids is shown and the item is still up), one row a player, scrolling.
function M.RefreshSide(f, v, ui)
    local side = f.side
    if not side then return end
    local picked
    if v.bids then
        for _, it in ipairs(v.bids.items) do if it.id == ui.bidItem then picked = it end end
    end
    if not picked then
        setShown(side, false)
        return
    end
    side.title:SetText("Everyone on " .. UILoot.Display(picked.link, nil))
    for i, p in ipairs(picked.people) do
        local fs = side.lines[i]
        if not fs then
            fs = side.child:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            fs:SetPoint("TOPLEFT", 0, -(i - 1) * 14)
            fs:SetWidth(284); fs:SetJustifyH("LEFT"); fs:SetWordWrap(false)
            side.lines[i] = fs
        end
        fs:SetText(M.Rich(p.segments)); fs:Show()
    end
    for i = #picked.people + 1, #side.lines do side.lines[i]:Hide() end
    side.child:SetHeight(math.max(#picked.people * 14, 1))
    local h = f.GetHeight and f:GetHeight()
    side:SetHeight(type(h) == "number" and math.max(h, 240) or 240)
    setShown(side, true)
end

function M.Refresh(f, ctx, ui)
    f.ctx = ctx
    local practice = ctx.sim ~= nil
    ctx.rankDraft = f.rankDraft -- the order being rearranged, not yet confirmed
    local m = UILoot.Model(ctx)
    m.practice = practice
    local v = LootView.Build(m)
    if not v.rankings or #v.rankings == 0 then f.rankDraft = nil end -- nothing to rank (a new round, a finished session): no draft is carried over
    if v.sessionKey ~= ui.bidSession then ui.bidSession, ui.bidItem, ui.bidFollow = v.sessionKey, nil, true end -- (a new session: nothing is ticked, and the panel follows you down the list)
    -- With "Auto-detect" on, the talents' spec is taken the first time you would be asked in a session
    if v.spec and not v.spec.mine and v.spec.auto and v.spec.detected and f.autoSpecFor ~= v.sessionKey then
        f.autoSpecFor = v.sessionKey
        ui:ChooseSpec(v.spec.detected)
    end
    -- The list keeps its order. While following, the panel moves down to the next item still to answer (after the one you are on, wrapping to the first), and stays
    -- where it is once everything is answered; click any item to look back at it.
    local order = {}
    for i = 1, #v.rows do order[i] = i end
    local function isOpen(vr)
        if #vr.buttons == 0 then return false end
        for _, vb in ipairs(vr.buttons) do if vb.selected then return false end end
        return true
    end
    local cur = 0
    for i, vr in ipairs(v.rows) do if vr.id == ui.bidItem then cur = i end end
    local nextOpen
    for k = 1, #v.rows do
        local i = ((cur - 1 + k) % #v.rows) + 1
        if isOpen(v.rows[i]) then nextOpen = v.rows[i].id; break end
    end
    if ui.bidFollow and nextOpen and ui.bidItem ~= nextOpen then
        ui.bidItem = nextOpen
        f.scrollToSelected = true
    end
    local layout, want = {}, {}
    local y = -32 -- just under the title bar

    local function place(el, x) layout[#layout + 1] = { el, x, y }; want[el] = true end
    local dividers = 0
    local function divider()
        dividers = dividers + 1
        local d = f.dividers[dividers]
        if not d then return end
        y = y - 4
        place(d, PAD)
        y = y - 1 - GAP
    end

    if practice then
        f.practiceText:SetText("|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r")
        place(f.practiceText, PAD); y = y - 14 - 4
    end
    local lesson = m.lesson
    if lesson then
        f.lessonTitle:SetText((lesson.index and lesson.count) and ("Lesson %d of %d: %s"):format(lesson.index, lesson.count, lesson.title) or lesson.title)
        local lt = M.GameText(lesson.text)
        if f.lessonShown ~= lesson.title then
            f.lessonShown = lesson.title
            if f.lessonWin.scroll.SetVerticalScroll then f.lessonWin.scroll:SetVerticalScroll(0) end
        end
        f.lessonText:SetText(lt)
        f.lessonWin.child:SetHeight(textH(f.lessonText, 12) + 8)
        local verdict = lesson.verdict
        if verdict then
            local head = verdict.pending and "|cffffd100Not finished yet:|r " or (verdict.ok and "|cff40ff40Matches the lesson:|r " or "|cffff6040Different from the lesson:|r ")
            f.lessonVerdict:SetText(head .. M.GameText(verdict.message or ""))
        else f.lessonVerdict:SetText("") end
        local x = 14
        local function put(b, on, w) setShown(b, on); if on then b:ClearAllPoints(); b:SetPoint("BOTTOMLEFT", f.lessonWin, "BOTTOMLEFT", x, 14); x = x + w + GAP end end
        put(f.lessonStart, not lesson.started, 168)
        put(f.lessonAgain, lesson.started, 120)
        put(f.lessonNext, (lesson.index or 0) < (lesson.count or 0), 120)
    end
    setShown(f.lessonWin, lesson ~= nil)

    if not v.visible then
        f.banner:SetText(lesson and (lesson.started and "No loot is up." or "Read the lesson, then press Start the lesson. Bids and timers begin when you do.")
            or practice and (v.night and v.night.nextBoss and ("No loot yet. Next boss: " .. v.night.nextBoss .. ((v.night.held or 0) > 0 and (".  Held loot: " .. v.night.held) or "")) or "No loot yet.")
            or "No loot session is running. A session starts when the Master Looter opens the loot window on a boss and starts it.")
        place(f.banner, PAD); y = y - textH(f.banner, 14) - GAP
        if not practice then place(f.startButton, PAD); y = y - BTN_H - GAP end
    else
        -- your spec: asked for until it is on record, then a line saying what it is (it holds for the whole raid)
        local sp = v.spec
        if sp and not sp.mine then
            f.specLabel:SetText("|cffffd100Which spec are you for this raid?|r  It holds until the raid ends" .. (sp.detected and ("  (your talents say " .. sp.detected .. ")") or "") .. ".")
            place(f.specLabel, PAD); y = y - textH(f.specLabel, 12) - 4
            local x = PAD
            for i = 1, 4 do
                local b, name = f.specButtons[i], sp.options[i]
                if name then
                    b.specName = name
                    b:SetText(name)
                    layout[#layout + 1] = { b, x, y }; want[b] = true
                    M.Mark(b, sp.detected == name)
                    x = x + 96 + 6
                end
            end
            y = y - BTN_H - 4
            f.specAuto:SetText(sp.auto and "Auto-detect: on" or "Auto-detect: off")
            layout[#layout + 1] = { f.specAuto, PAD, y }; want[f.specAuto] = true
            y = y - BTN_H - GAP
            divider()
        elseif sp then
            f.specLabel:SetText("Your spec this raid: |cffffffff" .. sp.mine .. "|r")
            place(f.specLabel, PAD); y = y - 12 - GAP
        end

        -- the clock and the count: a bar, then progress on the left and time and your place on the right
        if v.timer then
            local fraction = math.max(0, math.min(1, v.timer.fraction or 1))
            f.bar.fill:SetWidth(math.max(1, CW * fraction))
            if v.timer.urgent then f.bar.fill:SetColorTexture(1, 0.45, 0.1, 0.95) else f.bar.fill:SetColorTexture(0.9, 0.75, 0.2, 0.95) end
            place(f.bar, PAD); y = y - 8 - 4
        end
        f.meta:SetText(v.progress or v.subtitle or "")
        f.metaRight:SetText((v.timer and (v.timer.seconds .. "s") or "") .. ((v.timer and v.place) and "   " or "") .. (v.place and ("Your place: " .. v.place) or ""))
        place(f.meta, PAD); place(f.metaRight, PAD + CW - 170); y = y - 14 - GAP

        -- what to do now: your turn, or what is happening
        if v.turn then
            local t = v.turn
            f.turnText:SetText(t.text .. (t.itemLink and ("  " .. UILoot.Display(t.itemLink, nil)) or ""))
            place(f.turnText, PAD); y = y - textH(f.turnText, 14) - 6
            local x = PAD
            local needDrop = (t.kind == "recipient" or t.kind == "salvage") and not t.noTargets
            if needDrop then
                -- the choices are those who can have this item; drop a choice that is no longer on offer, and rebuild the menu when the list changes
                local names = t.targets or {}
                local listKey = table.concat(names, ",")
                local stillThere = false
                for _, n in ipairs(names) do if n == f.recipientPick then stillThere = true end end
                if not stillThere then f.recipientPick = nil end
                f.giftTargets = names
                if f.targetsShown ~= listKey then f.targetsShown = listKey; f.recipientShown = nil end
                local el = f.drop or f.recipient
                layout[#layout + 1] = { el, f.drop and (PAD - 4) or PAD + 4, y - (f.drop and 0 or 2) }; want[el] = true
                if f.drop then
                    local key = tostring(f.recipientPick)
                    if f.recipientShown ~= key then f.recipientShown = key; f.drop:GenerateMenu() end
                end
                x = PAD + 148
            end
            local n = 0
            for _, b in ipairs(t.buttons) do
                n = n + 1
                local tb = f.turnButtons[n]
                if tb then
                    local label = b.key == "pick" and ("Pick " .. (b.item or "")) or b.label
                    setup(tb, b, label)
                    tb:SetWidth(b.key == "claimgift" and 104 or 64)
                    if b.needsTarget then
                        local picked = f.drop and f.recipientPick or (f.recipient:GetText() or ""):match("%S")
                        if not picked and tb.SetEnabled then tb:SetEnabled(false); tb.view = setmetatable({ enabled = false, why = "Choose who gets it first." }, { __index = b }) end
                    end
                    layout[#layout + 1] = { tb, x, y }; want[tb] = true
                    x = x + tb:GetWidth() + GAP
                end
            end
            y = y - BTN_H - GAP
        elseif v.banner then
            f.banner:SetText(v.banner.segments and M.Rich(v.banner.segments) or v.banner.text)
            place(f.banner, PAD); y = y - textH(f.banner, 14) - GAP
        end

        -- your order, where you want several items of one kind
        if v.rankings and #v.rankings > 0 then
            divider()
            local pi, ri = 0, 0
            for _, panel in ipairs(v.rankings) do
                pi = pi + 1
                local title, c = f.rankTitles[pi], f.rankConfirms[pi]
                if title and c then
                    title:SetText(panel.title .. (panel.complete and "  |cff40ff40(set)|r" or ""))
                    setup(c, panel.confirm, panel.confirm.label)
                    layout[#layout + 1] = { title, PAD, y - 4 }; want[title] = true
                    layout[#layout + 1] = { c, PAD + CW - 110, y }; want[c] = true
                    y = y - BTN_H - 4
                    for pos, it in ipairs(panel.items) do
                        ri = ri + 1
                        local r = f.rankRows[ri]
                        if r then
                            r.text:SetText(("%d. %s"):format(pos, UILoot.Display(it.link, it.tip)))
                            setup(r.up, it.up, "Up"); setup(r.down, it.down, "Down")
                            layout[#layout + 1] = { r.text, PAD, y - 2 }; want[r.text] = true
                            layout[#layout + 1] = { r.up, PAD + CW - 104, y }; want[r.up] = true
                            layout[#layout + 1] = { r.down, PAD + CW - 48, y }; want[r.down] = true
                            y = y - 24
                        end
                    end
                    y = y - GAP
                end
            end
        end

        -- the items: the name and, right-aligned on the same line, what you answered; then the choices across the full width
        local showPick = v.bids ~= nil
        if #v.rows > 0 then divider() end
        local listFrom, outerY = #layout + 1, y
        local selTop
        y = 0 -- (inside the scrolling list, y counts down from its top)
        for i = 1, MAX do
            local ri = order[i]
            local row, vr = f.rows[i], ri and v.rows[ri]
            if vr then
                row.id, row.tip = vr.id, vr.tip
                local label = ("%d. %s"):format(ri, UILoot.Display(vr.link, vr.tip))
                row.text:SetText(label)
                place(row.text, PAD); place(row.hit, PAD)
                local top = y
                if vr.id == ui.bidItem then selTop = top end
                y = y - 18 - 4
                local hasButtons = #vr.buttons > 0
                if hasButtons then
                    for j = 1, 4 do
                        local vb, b = vr.buttons[j], row.buttons[j]
                        if vb then
                            setup(b, vb, vb.label)
                            layout[#layout + 1] = { b, PAD + (j - 1) * (BTN4 + GAP), y }; want[b] = true
                        end
                    end
                    y = y - BTN_H
                    if vr.warn then
                        row.note:SetText("|cffffaa33" .. vr.warn .. "|r")
                        y = y - 4; place(row.note, PAD); y = y - textH(row.note, 12)
                    end
                else
                    row.note:SetText((vr.segments and M.Rich(vr.segments)) or vr.note or "")
                    place(row.note, PAD); y = y - textH(row.note, 12)
                end
                local bidItem
                if v.bids and v.bids.live then for _, it in ipairs(v.bids.items) do if it.id == vr.id then bidItem = it end end end
                if bidItem then
                    row.bid:SetText(M.Rich(bidItem.segments)); y = y - 2; place(row.bid, PAD); y = y - textH(row.bid, 12)
                else row.bid:SetText("") end
                y = y - 6 - 4
                if showPick then
                    -- the selectable block: from just above the name to just under the last line, 4 px wider than the text on each side
                    local h = top - y
                    layout[#layout + 1] = { row.bg, PAD - 4, top + 3 }; layout[#layout + 1] = { row.sel, PAD - 4, top + 3 }
                    want[row.sel] = true; want[row.bg] = ui.bidItem == vr.id
                    row.bg:SetSize(CW + 8, h); row.sel:SetSize(CW + 8, h)
                end
            end
        end
        for i = listFrom, #layout do layout[i][4] = f.list end
        if #v.rows > 0 then
            local content = math.max(1, -y)
            local view = math.min(content, SCROLL_H)
            f.scroll:SetSize(PAD + CW + 4, view); f.list:SetSize(PAD + CW + 4, content)
            if content <= view and f.scroll.SetVerticalScroll then f.scroll:SetVerticalScroll(0)
            elseif f.scrollToSelected and selTop and f.scroll.SetVerticalScroll then
                -- the item the panel moved to is brought into view
                local at = f.scroll.GetVerticalScroll and f.scroll:GetVerticalScroll() or 0
                if type(at) ~= "number" then at = 0 end
                local want0 = -selTop
                if want0 < at or want0 + 90 > at + view then f.scroll:SetVerticalScroll(math.max(0, math.min(want0 - 6, content - view))) end
            end
            f.scrollToSelected = nil
            layout[#layout + 1] = { f.scroll, 0, outerY }; want[f.scroll] = true; want[f.list] = true
            y = outerY - view - GAP
        else y = outerY end
        if (v.hidden or 0) > 0 then
            f.more:SetText(("(and %d more items: use the need/off/pass commands for them)"):format(v.hidden))
            place(f.more, PAD); y = y - 14 - GAP
        end

        -- the Master Looter's strip
        if v.ml then
            divider()
            place(f.mlLabel, PAD); y = y - 14 - 4
            for i, b in ipairs(v.ml.buttons) do
                local mb = f.mlButtons[i]
                setup(mb, b, b.label)
                layout[#layout + 1] = { mb, PAD + (i - 1) * (BTN4 + GAP), y }; want[mb] = true
            end
            y = y - BTN_H - GAP
        end
    end

    if lesson then
        -- (the lesson's own window carries its verdict and buttons)
    elseif practice then
        divider()
        place(f.practiceLabel, PAD); y = y - 14 - 4
        place(f.nextBoss, PAD)
        local night = m.night or {}
        f.nextBoss:SetText(not night.raidOpen and "No raid is open" or (night.nextBoss and ("Kill " .. night.nextBoss) or "No more bosses"))
        if f.nextBoss.SetEnabled then f.nextBoss:SetEnabled(night.raidOpen and night.nextBoss ~= nil and not night.busy) end
        local x = PAD + 168 + GAP
        if (night.held or 0) > 0 then layout[#layout + 1] = { f.handOut, x, y }; want[f.handOut] = true; x = x + 120 + GAP end
        if night.busy then layout[#layout + 1] = { f.wait, x, y }; want[f.wait] = true end -- (time only matters while loot is being handed out)
        y = y - BTN_H - GAP
        -- the raid itself: end it (then open the next one, days later), and people leaving and coming back
        f.raidIsOpen = night.raidOpen
        local label = night.raidOpen and ("End raid " .. tostring(night.raidNo or 1)) or "Open the next raid"
        f.raidButton:SetText(label)
        if f.raidButton.SetEnabled then f.raidButton:SetEnabled(not (night.raidOpen and (night.busy or (night.held or 0) > 0))) end
        layout[#layout + 1] = { f.raidButton, PAD, y }; want[f.raidButton] = true
        x = PAD + 150 + GAP
        if night.canLeave then layout[#layout + 1] = { f.leaveButton, x, y }; want[f.leaveButton] = true; x = x + 116 + GAP end
        if (night.absent or 0) > 0 and night.raidOpen then layout[#layout + 1] = { f.rejoinButton, x, y }; want[f.rejoinButton] = true end
        y = y - BTN_H - GAP
    elseif v.visible and (v.state == "result" or v.state == "cancelled") then
        place(f.startButton, PAD); y = y - BTN_H - GAP
    end

    divider()
    place(f.hint, PAD); y = y - HINT_H

    -- apply: show what this state shows, hide the rest, and move things only when the layout changed
    local sig = {}
    for _, l in ipairs(layout) do sig[#sig + 1] = tostring(l[1]) .. "@" .. l[2] .. "," .. l[3] end
    local signature = table.concat(sig, ";")
    if signature ~= f.signature then
        f.signature = signature
        for _, l in ipairs(layout) do
            l[1]:ClearAllPoints()
            l[1]:SetPoint("TOPLEFT", l[4] or f, "TOPLEFT", l[2], l[3])
        end
        f:SetHeight(math.max(90, -y + PAD - GAP))
    end
    local everything = { f.hint, f.specLabel, f.specAuto, f.specButtons[1], f.specButtons[2], f.specButtons[3], f.specButtons[4], f.practiceText, f.practiceLabel, f.bar, f.meta, f.metaRight, f.banner, f.turnText, f.more, f.mlLabel, f.startButton, f.nextBoss, f.handOut, f.wait, f.raidButton, f.leaveButton, f.rejoinButton, f.recipient }
    if f.drop then everything[#everything + 1] = f.drop end
    for _, d in ipairs(f.dividers) do everything[#everything + 1] = d end
    everything[#everything + 1] = f.scroll; everything[#everything + 1] = f.list
    for _, b in ipairs(f.turnButtons) do everything[#everything + 1] = b end
    for _, t in ipairs(f.rankTitles) do everything[#everything + 1] = t end
    for _, c in ipairs(f.rankConfirms) do everything[#everything + 1] = c end
    for _, r in ipairs(f.rankRows) do everything[#everything + 1] = r.text; everything[#everything + 1] = r.up; everything[#everything + 1] = r.down end
    for _, b in ipairs(f.mlButtons) do everything[#everything + 1] = b end
    for _, r in ipairs(f.rows) do
        everything[#everything + 1] = r.bg; everything[#everything + 1] = r.sel
        everything[#everything + 1] = r.text; everything[#everything + 1] = r.hit
        everything[#everything + 1] = r.note; everything[#everything + 1] = r.bid
        for _, b in ipairs(r.buttons) do everything[#everything + 1] = b end
    end
    -- A button that is not drawn this time (a new round, a finished session) is cleared, so what was chosen last round never shows on it.
    for _, r in ipairs(f.rows) do
        for _, b in ipairs(r.buttons) do
            if not want[b] then M.Mark(b, false) end
        end
    end
    for _, el in ipairs(everything) do setShown(el, want[el] == true) end
    M.RefreshSide(f, v, ui)
    return v
end

function M:OnInit() end
