-- King's Gambit: the Loot window, the small window for a live loot session. Keep this file Lua 5.1-safe.
-- It draws the table LootView builds (the same one the web simulator draws) with the game's frames, and runs a button's `act` as the command a player
-- could type, so every rule, message and ledger entry is the one the commands already have. It opens by itself when a session starts.
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local UILoot, LootView, Tips
local M = SK:NewModule("LootWindow", { "UILoot", "LootView", "UITips" }, function(d) UILoot, LootView, Tips = d.UILoot, d.LootView, d.UITips end)

local WIDTH = 440
local MAX = 8          -- the most items drawn (UILoot.MAX_ITEMS); more are mentioned

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
            local detail = ((w.spec and (w.spec .. " ") or "") .. (w.className or "")):gsub("%s+$", "")
            out[#out + 1] = detail ~= "" and (name .. " |cff999999(" .. detail .. ")|r") or name
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
local BEVEL_INSET = 3
local function bevel(b)
    if b.bevel then return b.bevel end
    if not b.CreateTexture then return nil end
    local I = BEVEL_INSET
    local list = {}
    local function layer(r, g, bl, a)
        local t = b:CreateTexture(nil, "OVERLAY")
        if t.SetColorTexture then t:SetColorTexture(r, g, bl, a) end
        list[#list + 1] = t
        return t
    end
    -- An inset reads as pressed in when the light falls from above-left: the top and left inner edges are in shadow, fading inward, and the bottom and right inner
    -- edges catch the light. So the shading is mirrored, not one dark top: a shadow that fades over a few pixels along the top and left, and a light that fades
    -- over a few along the bottom and right, each with its crisp outermost line; under it a body only a little darker than the button.
    local body = layer(0, 0, 0, 0.20)
    body:SetPoint("TOPLEFT", b, "TOPLEFT", I, -I); body:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -I, I)
    for i, a in ipairs { 0.38, 0.22, 0.10, 0.04 } do -- shadow, top
        local t = layer(0, 0, 0, a); t:SetHeight(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I, -(I + i - 1)); t:SetPoint("TOPRIGHT", b, "TOPRIGHT", -I, -(I + i - 1))
    end
    for i, a in ipairs { 0.26, 0.12, 0.04 } do -- shadow, left
        local t = layer(0, 0, 0, a); t:SetWidth(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I + i - 1, -I); t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", I + i - 1, I)
    end
    -- (the light is a soft warm tint of the red button, not white, and has no crisp bright line: a white line along the bottom looked like an underline)
    for i, a in ipairs { 0.16, 0.09, 0.04 } do -- light, bottom
        local t = layer(1, 0.82, 0.78, a); t:SetHeight(1)
        t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", I, I + i - 1); t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -I, I + i - 1)
    end
    for i, a in ipairs { 0.12, 0.06, 0.03 } do -- light, right
        local t = layer(1, 0.82, 0.78, a); t:SetWidth(1)
        t:SetPoint("TOPRIGHT", b, "TOPRIGHT", -(I + i - 1), -I); t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -(I + i - 1), I)
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
local PAD, GAP = 16, 8
local CW = WIDTH - 2 * PAD          -- the content width (408)
local BTN_H = 22
local BTN4 = (CW - 3 * GAP) / 4     -- four equal buttons across the content width (96)

-- The height a (wrapped) line of text takes, never less than `min` (the game gives the real number; a stand-in gives none).
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
    local function onClick(b) b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end); Tips.Attach(b, tooltipOf(b)) end

    f.practiceText = text("GameFontNormalSmall")
    f.bar = CreateFrame("StatusBar", nil, f)
    f.bar:SetSize(CW, 8)
    f.bar:SetMinMaxValues(0, 1)
    if f.bar.SetStatusBarTexture then f.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar") end
    f.meta = text("GameFontHighlightSmall", CW - 170, "LEFT", false)
    f.metaRight = text("GameFontHighlightSmall", 170, "RIGHT", false)
    f.banner = text("GameFontHighlight")
    f.turnText = text("GameFontNormal")
    f.more = text("GameFontHighlightSmall")

    -- thin dividers between the groups (the turn, your order, the items, the Master Looter, practice)
    f.dividers = {}
    for i = 1, 5 do
        local d = f:CreateTexture(nil, "ARTWORK")
        d:SetSize(CW, 1)
        if d.SetColorTexture then d:SetColorTexture(1, 1, 1, 0.15) end
        f.dividers[i] = d
    end

    f.rows = {}
    for i = 1, MAX do
        local row = { }
        row.text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetWidth(CW); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        -- Hover for the item's tooltip; shift-click puts the link in chat, as anywhere in the game.
        row.hit = CreateFrame("Button", nil, f)
        row.hit:SetSize(CW, 16)
        row.hit:SetScript("OnEnter", function(self)
            if row.tip and GameTooltip then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink(row.tip); GameTooltip:Show()
            end
        end)
        row.hit:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
        row.hit:SetScript("OnClick", function()
            if not row.tip then return end
            local get = (C_Item and C_Item.GetItemInfo) or GetItemInfo
            local full = get and select(2, get(row.tip)) or row.tip
            if HandleModifiedItemClick then HandleModifiedItemClick(full) end
        end)
        row.note = text("GameFontHighlightSmall", CW, "LEFT", true)      -- a result, or why a choice is unavailable, under the item
        row.buttons = {}
        for j = 1, 4 do
            local b = button(f, "", BTN4, BTN_H)
            onClick(b)
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
    Tips.Attach(f.startButton, "start")

    -- practice only
    f.practiceLabel = text("GameFontNormalSmall", CW, "LEFT", false)
    f.practiceLabel:SetText("Practice")
    f.nextBoss = button(f, "Next boss", 168, BTN_H)
    f.nextBoss:SetScript("OnClick", function() ui:PracticeKill() end)
    Tips.Attach(f.nextBoss, "kill")
    f.handOut = button(f, "Hand out the loot", 120, BTN_H)
    f.handOut:SetScript("OnClick", function() ui:PracticeHandOut() end)
    Tips.Attach(f.handOut, "handout")
    f.raidButton = button(f, "End the raid", 168, BTN_H)
    f.raidButton:SetScript("OnClick", function() if f.raidIsOpen then ui:PracticeEndRaid() else ui:PracticeOpenRaid() end end)
    Tips.Attach(f.raidButton, "raidtoggle")
    f.leaveButton = button(f, "Someone leaves", 120, BTN_H)
    f.leaveButton:SetScript("OnClick", function() ui:PracticeLeave() end)
    Tips.Attach(f.leaveButton, "leaveraid")
    f.rejoinButton = button(f, "Someone returns", 104, BTN_H)
    f.rejoinButton:SetScript("OnClick", function() ui:PracticeRejoin() end)
    Tips.Attach(f.rejoinButton, "rejoinraid")
    f.wait = button(f, "Wait 10 s", 80, BTN_H)
    f.wait:SetScript("OnClick", function() ui:PracticeWait(10) end)
    Tips.Attach(f.wait, "wait")

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
    local cmd, problem = M.CommandText(act, f.recipientPick)
    if not cmd then return ui.Say(problem or "That isn't available.") end
    if act.name == "give" or (act.name == "claim" and act.gift) then f.recipientPick = nil end
    ui:Command(cmd)
end

-- Draw the view. `want` is every frame this state shows; frames are shown or hidden only when that changes (hiding and re-showing every second
-- would close an open dropdown), and they are moved only when the layout changes.
function M.Refresh(f, ctx, ui)
    f.ctx = ctx
    local practice = ctx.sim ~= nil
    ctx.rankDraft = f.rankDraft -- the order being rearranged, not yet confirmed
    local m = UILoot.Model(ctx)
    m.practice = practice
    local v = LootView.Build(m)
    if not v.rankings or #v.rankings == 0 then f.rankDraft = nil end -- nothing to rank (a new round, a finished session): no draft is carried over
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

    if not v.visible then
        f.banner:SetText(practice and (v.night and v.night.nextBoss and ("No loot yet. Next boss: " .. v.night.nextBoss .. ((v.night.held or 0) > 0 and (".  Held loot: " .. v.night.held) or "")) or "No loot yet.")
            or "No loot session is running. A session starts when the Master Looter opens the loot window on a boss and starts it.")
        place(f.banner, PAD); y = y - textH(f.banner, 14) - GAP
        if not practice then place(f.startButton, PAD); y = y - BTN_H - GAP end
    else
        -- the clock and the count: a bar, then progress on the left and time and your place on the right
        if v.timer then
            f.bar:SetValue(v.timer.fraction or 1)
            if f.bar.SetStatusBarColor then
                if v.timer.urgent then f.bar:SetStatusBarColor(1, 0.6, 0.1) else f.bar:SetStatusBarColor(0.9, 0.75, 0.2) end
            end
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
        if #v.rows > 0 then divider() end
        for i = 1, MAX do
            local row, vr = f.rows[i], v.rows[i]
            if vr then
                row.id, row.tip = vr.id, vr.tip
                local label = ("%d. %s"):format(i, UILoot.Display(vr.link, vr.tip))
                row.text:SetText(label)
                place(row.text, PAD); place(row.hit, PAD)
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
                y = y - 6 - 4
            end
        end
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

    if practice then
        divider()
        place(f.practiceLabel, PAD); y = y - 14 - 4
        place(f.nextBoss, PAD)
        local night = m.night or {}
        f.nextBoss:SetText(not night.raidOpen and "No raid is open" or (night.nextBoss and ("Kill " .. night.nextBoss) or "No more bosses"))
        if f.nextBoss.SetEnabled then f.nextBoss:SetEnabled(night.raidOpen and night.nextBoss ~= nil and not night.busy) end
        local x = PAD + 168 + GAP
        if (night.held or 0) > 0 then layout[#layout + 1] = { f.handOut, x, y }; want[f.handOut] = true; x = x + 120 + GAP end
        layout[#layout + 1] = { f.wait, x, y }; want[f.wait] = true
        y = y - BTN_H - GAP
        -- the raid itself: end it (then open the next one, days later), and people leaving and coming back
        f.raidIsOpen = night.raidOpen
        local label = night.raidOpen and ("End raid " .. tostring(night.raidNo or 1)) or "Open the next raid"
        f.raidButton:SetText(label)
        if f.raidButton.SetEnabled then f.raidButton:SetEnabled(not (night.raidOpen and (night.busy or (night.held or 0) > 0))) end
        layout[#layout + 1] = { f.raidButton, PAD, y }; want[f.raidButton] = true
        x = PAD + 168 + GAP
        if night.canLeave then layout[#layout + 1] = { f.leaveButton, x, y }; want[f.leaveButton] = true; x = x + 120 + GAP end
        if (night.absent or 0) > 0 and night.raidOpen then layout[#layout + 1] = { f.rejoinButton, x, y }; want[f.rejoinButton] = true end
        y = y - BTN_H - GAP
    elseif v.visible and (v.state == "result" or v.state == "cancelled") then
        place(f.startButton, PAD); y = y - BTN_H - GAP
    end

    -- apply: show what this state shows, hide the rest, and move things only when the layout changed
    local sig = {}
    for _, l in ipairs(layout) do sig[#sig + 1] = tostring(l[1]) .. "@" .. l[2] .. "," .. l[3] end
    local signature = table.concat(sig, ";")
    if signature ~= f.signature then
        f.signature = signature
        for _, l in ipairs(layout) do
            l[1]:ClearAllPoints()
            l[1]:SetPoint("TOPLEFT", f, "TOPLEFT", l[2], l[3])
        end
        f:SetHeight(math.max(90, -y + PAD - GAP))
    end
    local everything = { f.practiceText, f.practiceLabel, f.bar, f.meta, f.metaRight, f.banner, f.turnText, f.more, f.mlLabel, f.startButton, f.nextBoss, f.handOut, f.wait, f.raidButton, f.leaveButton, f.rejoinButton, f.recipient }
    if f.drop then everything[#everything + 1] = f.drop end
    for _, d in ipairs(f.dividers) do everything[#everything + 1] = d end
    for _, b in ipairs(f.turnButtons) do everything[#everything + 1] = b end
    for _, t in ipairs(f.rankTitles) do everything[#everything + 1] = t end
    for _, c in ipairs(f.rankConfirms) do everything[#everything + 1] = c end
    for _, r in ipairs(f.rankRows) do everything[#everything + 1] = r.text; everything[#everything + 1] = r.up; everything[#everything + 1] = r.down end
    for _, b in ipairs(f.mlButtons) do everything[#everything + 1] = b end
    for _, r in ipairs(f.rows) do
        everything[#everything + 1] = r.text; everything[#everything + 1] = r.hit
        everything[#everything + 1] = r.note
        for _, b in ipairs(r.buttons) do everything[#everything + 1] = b end
    end
    -- A button that is not drawn this time (a new round, a finished session) is cleared, so what was chosen last round never shows on it.
    for _, r in ipairs(f.rows) do
        for _, b in ipairs(r.buttons) do
            if not want[b] then M.Mark(b, false) end
        end
    end
    for _, el in ipairs(everything) do setShown(el, want[el] == true) end
    return v
end

function M:OnInit() end
