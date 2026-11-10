-- King's Gambit: the Loot window, the small window for a live loot session. Keep this file Lua 5.1-safe.
-- It draws the table LootView builds (the same one the web simulator draws) with the game's frames, and runs a button's `act` as the command a player
-- could type, so every rule, message and ledger entry is the one the commands already have. It opens by itself when a session starts.
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local UILoot, LootView, Tips, Skin
local installParts -- defined at the end of the file: what the window does once built is in lootwindow/LootWindowLive.lua
local M = SK:NewModule("LootWindow", { "UILoot", "LootView", "UITips", "UISkin?", "LootWindowLive" }, function(d)
    UILoot, LootView, Tips, Skin = d.UILoot, d.LootView, d.UITips, d.UISkin
    installParts(d)
end)

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
    if Skin then return Skin.Button(parent, text, w, h) end
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
        if not Skin then for _, t in ipairs(bevel(b) or {}) do t:Show() end end -- (the skin shows the chosen one by its gold face and edge instead)
    else
        if b.SetButtonState then b:SetButtonState("NORMAL", false) end
        for _, t in ipairs(b.bevel or {}) do t:Hide() end
    end
    b.marked = on
    if Skin then Skin.Mark(b, on) end
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
local INL_W, INL_GAP = 56, 4              -- the four choices on a row's own line (dense list)
local NAME_W = CW - 4 * INL_W - 3 * INL_GAP - 8
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

    -- Keyboard, while the pointer is over this window and nothing is being typed: N, O, G, P answer the selected item (Need, Off-spec, Gift, Pass); Up/Down
    -- or Tab, move between items. Every other key goes on to the game as usual.
    if f.EnableKeyboard then
        f:EnableKeyboard(true)
        if f.SetPropagateKeyboardInput then f:SetPropagateKeyboardInput(true) end
        f:SetScript("OnKeyDown", function(self, key)
            local handled = M.Key(self, ui, key)
            if self.SetPropagateKeyboardInput then self:SetPropagateKeyboardInput(not handled) end
        end)
    end

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

-- Add the other file's functions to M (once every module is loaded: see Registry.lua), handing them the layout constants and helpers they share.
function installParts(d)
    local h = { BTN4 = BTN4, BTN_H = BTN_H, CW = CW, GAP = GAP, HINT_H = HINT_H, INL_GAP = INL_GAP, INL_W = INL_W, MAX = MAX, NAME_W = NAME_W, PAD = PAD, SCROLL_H = SCROLL_H,
        setShown = setShown, setup = setup, textH = textH }
    d.LootWindowLive.Install(M, h)
end
