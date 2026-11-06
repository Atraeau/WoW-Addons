-- King's Gambit: the Loot window, the small window for a live loot session. Keep this file Lua 5.1-safe.
-- It draws the table LootView builds (the same one the web simulator draws) with the game's frames, and runs a button's `act` as the command a player
-- could type, so every rule, message and ledger entry is the one the commands already have. It opens by itself when a session starts.
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local UILoot, LootView, Tips
local M = SK:NewModule("LootWindow", { "UILoot", "LootView", "UITips" }, function(d) UILoot, LootView, Tips = d.UILoot, d.LootView, d.UITips end)

local WIDTH = 440
local ROW = 50          -- one item: its link, then the answers or the result (which can run to three lines)
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
local function setup(b, vb, label)
    b.view = vb
    b:SetText(label)
    if b.SetEnabled then b:SetEnabled(vb.enabled) end
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

    local function text(font, w, justify)
        local s = f:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
        s:SetWidth(w or (WIDTH - 36)); s:SetJustifyH(justify or "LEFT"); s:SetWordWrap(true)
        return s
    end
    f.practiceText = text("GameFontNormalSmall")
    f.bar = CreateFrame("StatusBar", nil, f)
    f.bar:SetSize(WIDTH - 36, 8)
    f.bar:SetMinMaxValues(0, 1)
    if f.bar.SetStatusBarTexture then f.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar") end
    f.meta = text("GameFontHighlightSmall", 250)
    f.metaRight = text("GameFontHighlightSmall", 170, "RIGHT")
    f.banner = text("GameFontHighlight")
    f.turnText = text("GameFontNormal")

    f.rows = {}
    for i = 1, MAX do
        local row = { }
        row.text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetWidth(WIDTH - 36); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        -- Hover for the item's tooltip; shift-click puts the link in chat, as anywhere in the game.
        row.hit = CreateFrame("Button", nil, f)
        row.hit:SetSize(WIDTH - 36, 16)
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
        row.note = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.note:SetJustifyH("LEFT"); row.note:SetJustifyV("TOP"); row.note:SetWordWrap(true); row.note:SetHeight(32)
        row.buttons = {}
        for j = 1, 4 do
            local b = button(f, "", 70, 20)
            b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end)
            Tips.Attach(b, tooltipOf(b))
            row.buttons[j] = b
        end
        f.rows[i] = row
    end
    f.more = text("GameFontHighlightSmall")

    -- Your order, when you want several items of one kind: a title, a line per item with Up and Down, and Confirm.
    f.rankTitles, f.rankConfirms, f.rankRows = {}, {}, {}
    for i = 1, 3 do
        f.rankTitles[i] = text("GameFontNormalSmall")
        local c = button(f, "", 110, 22)
        c:SetScript("OnClick", function() if c.view and c.view.enabled then M.Run(c.view.act, f, ui) end end)
        Tips.Attach(c, tooltipOf(c))
        f.rankConfirms[i] = c
    end
    for i = 1, 12 do
        local r = {}
        r.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        r.text:SetWidth(250); r.text:SetJustifyH("LEFT"); r.text:SetWordWrap(false)
        r.up, r.down = button(f, "", 46, 20), button(f, "", 46, 20)
        for _, b in ipairs({ r.up, r.down }) do
            b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end)
            Tips.Attach(b, tooltipOf(b))
        end
        f.rankRows[i] = r
    end

    -- your turn
    f.turnButtons = {}
    for i = 1, 7 do
        local b = button(f, "", 66, 22)
        b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end)
        Tips.Attach(b, tooltipOf(b))
        f.turnButtons[i] = b
    end
    -- Who gets a gift: chosen from the group, never typed. (A box stays only as the fallback when the game has no dropdown.)
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, f, "WowStyle1DropdownTemplate")
    if okDrop and drop and drop.SetupMenu then
        drop:SetWidth(136)
        drop:SetDefaultText("Choose a player")
        drop:SetupMenu(function(_, root)
            local ctx = f.ctx
            if not ctx then return end
            local me = ctx.client:me()
            if root.SetScrollMode then root:SetScrollMode(260) end
            for _, m in ipairs(ctx.client:roster()) do
                if m.name ~= me then
                    root:CreateRadio((m.name:gsub("_", " ")), function() return f.recipientPick == m.name end, function() f.recipientPick = m.name end)
                end
            end
        end)
        f.drop = drop
    end
    f.recipient = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.recipient:SetSize(110, 20); f.recipient:SetAutoFocus(false)

    -- the Master Looter's strip (only the Master Looter's window has it) and the way in
    f.mlLabel = text("GameFontHighlightSmall", 120)
    f.mlLabel:SetText("Master Looter")
    f.mlButtons = {}
    for i = 1, 4 do
        local b = button(f, "", 96, 22)
        b:SetScript("OnClick", function() if b.view and b.view.enabled then M.Run(b.view.act, f, ui) end end)
        Tips.Attach(b, tooltipOf(b))
        f.mlButtons[i] = b
    end
    f.startButton = button(f, "Start from the loot window", 190, 22)
    f.startButton:SetScript("OnClick", function() ui:Command("loot") end)
    Tips.Attach(f.startButton, "start")

    -- practice only
    f.nextBoss = button(f, "Next boss", 160, 22)
    f.nextBoss:SetScript("OnClick", function() ui:PracticeKill() end)
    Tips.Attach(f.nextBoss, "kill")
    f.handOut = button(f, "Hand out the loot", 130, 22)
    f.handOut:SetScript("OnClick", function() ui:PracticeHandOut() end)
    Tips.Attach(f.handOut, "handout")
    f.wait = button(f, "Wait 10 s", 76, 22)
    f.wait:SetScript("OnClick", function() ui:PracticeWait(10) end)
    Tips.Attach(f.wait, "wait")

    f:SetScript("OnUpdate", function() ui:Tick() end)
    if UISpecialFrames then table.insert(UISpecialFrames, "KingsGambitLootWindow") end
    f:Hide()
    return f
end

function M.Run(act, f, ui)
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
    local m = UILoot.Model(ctx)
    m.practice = practice
    local v = LootView.Build(m)
    local layout, want = {}, {}
    local y = -30
    local function put(el, x, h, w)
        layout[#layout + 1] = { el, x, y }
        want[el] = true
        if h then y = y - h end
    end

    if practice then
        f.practiceText:SetText("|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r")
        put(f.practiceText, 16, 14)
    end

    if not v.visible then
        f.banner:SetText(practice and (v.night and v.night.nextBoss and ("No loot yet. Next boss: " .. v.night.nextBoss .. ((v.night.held or 0) > 0 and (".  Held loot: " .. v.night.held) or "")) or "No loot yet.")
            or "No loot session is running. A session starts when the Master Looter opens the loot window on a boss and starts it.")
        put(f.banner, 16, 40)
        if not practice then put(f.startButton, 16, 30) end
    else
        -- timer, and the line under it
        if v.timer then
            f.bar:SetValue(v.timer.fraction or 1)
            if f.bar.SetStatusBarColor then
                if v.timer.urgent then f.bar:SetStatusBarColor(1, 0.6, 0.1) else f.bar:SetStatusBarColor(0.9, 0.75, 0.2) end
            end
            put(f.bar, 18, 12)
        end
        f.meta:SetText(v.progress or v.subtitle or "")
        f.metaRight:SetText((v.timer and (v.timer.seconds .. "s") or "") .. ((v.timer and v.place) and "   " or "") .. (v.place and ("Your place: " .. v.place) or ""))
        layout[#layout + 1] = { f.meta, 16, y }; want[f.meta] = true
        layout[#layout + 1] = { f.metaRight, WIDTH - 16 - 170, y }; want[f.metaRight] = true
        y = y - 18

        -- what to do now: your turn, or what is happening
        if v.turn then
            local t = v.turn
            f.turnText:SetText(t.text .. (t.itemLink and ("  " .. UILoot.Display(t.itemLink, nil)) or ""))
            put(f.turnText, 16, 36)
            local x = 16
            local needDrop = t.kind == "recipient" or t.kind == "salvage"
            if needDrop then
                local el = f.drop or f.recipient
                layout[#layout + 1] = { el, f.drop and 12 or 20, y - (f.drop and 0 or 2) }; want[el] = true
                if f.drop then
                    local key = tostring(f.recipientPick)
                    if f.recipientShown ~= key then f.recipientShown = key; f.drop:GenerateMenu() end
                end
                x = 160
            end
            local n = 0
            for _, b in ipairs(t.buttons) do
                n = n + 1
                local tb = f.turnButtons[n]
                if tb then
                    local label = b.key == "pick" and ("Pick " .. (b.item or "")) or b.label
                    setup(tb, b, label)
                    tb:SetWidth(b.key == "claimgift" and 100 or 62)
                    if b.needsTarget then
                        local picked = f.drop and f.recipientPick or (f.recipient:GetText() or ""):match("%S")
                        if not picked and tb.SetEnabled then tb:SetEnabled(false); tb.view = setmetatable({ enabled = false, why = "Choose who gets it first." }, { __index = b }) end
                    end
                    layout[#layout + 1] = { tb, x, y }; want[tb] = true
                    x = x + tb:GetWidth() + 4
                end
            end
            y = y - 30
        elseif v.banner then
            f.banner:SetText(v.banner.segments and M.Rich(v.banner.segments) or v.banner.text)
            put(f.banner, 16, 34)
        end

        -- your order, where you want several items of one kind
        local pi, ri = 0, 0
        for _, panel in ipairs(v.rankings or {}) do
            pi = pi + 1
            local title = f.rankTitles[pi]
            if title then
                title:SetText(panel.title .. (panel.complete and "  |cff40ff40(set)|r" or ""))
                put(title, 16, 16)
                for pos, it in ipairs(panel.items) do
                    ri = ri + 1
                    local r = f.rankRows[ri]
                    if r then
                        r.text:SetText(("%d. %s"):format(pos, UILoot.Display(it.link, it.tip)))
                        setup(r.up, it.up, "Up"); setup(r.down, it.down, "Down")
                        layout[#layout + 1] = { r.text, 16, y }; want[r.text] = true
                        layout[#layout + 1] = { r.up, 276, y + 2 }; want[r.up] = true
                        layout[#layout + 1] = { r.down, 326, y + 2 }; want[r.down] = true
                        y = y - 22
                    end
                end
                local c = f.rankConfirms[pi]
                setup(c, panel.confirm, panel.confirm.label)
                layout[#layout + 1] = { c, 16, y }; want[c] = true
                y = y - 28
            end
        end

        -- the items
        for i = 1, MAX do
            local row, vr = f.rows[i], v.rows[i]
            if vr then
                row.id, row.tip = vr.id, vr.tip
                local label = ("%d. %s"):format(i, UILoot.Display(vr.link, vr.tip))
                if vr.state == "awarded" and vr.mineWon then label = label .. "   |cff40ff40(yours)|r" end
                row.text:SetText(label)
                layout[#layout + 1] = { row.text, 16, y }; layout[#layout + 1] = { row.hit, 16, y }
                want[row.text] = true; want[row.hit] = true
                local hasButtons = #vr.buttons > 0
                for j = 1, 4 do
                    local vb = vr.buttons[j]
                    local b = row.buttons[j]
                    if vb then
                        setup(b, vb, vb.selected and ("[" .. vb.label .. "]") or vb.label)
                        layout[#layout + 1] = { b, 16 + (j - 1) * 72, y - 17 }; want[b] = true
                    end
                end
                row.note:SetText(vr.warn and ("|cffffaa33" .. vr.warn .. "|r") or (vr.segments and M.Rich(vr.segments)) or vr.note or "")
                row.note:SetWidth(hasButtons and (WIDTH - 36 - 292) or (WIDTH - 36))
                layout[#layout + 1] = { row.note, hasButtons and (16 + 292) or 16, hasButtons and (y - 19) or (y - 17) }; want[row.note] = true
                y = y - ROW
            end
        end
        if (v.hidden or 0) > 0 then
            f.more:SetText(("(and %d more items: use the need/off/pass commands for them)"):format(v.hidden))
            put(f.more, 16, 16)
        end

        -- the Master Looter's strip
        if v.ml then
            y = y - 4
            layout[#layout + 1] = { f.mlLabel, 16, y }; want[f.mlLabel] = true
            y = y - 14
            for i, b in ipairs(v.ml.buttons) do
                local mb = f.mlButtons[i]
                setup(mb, b, b.label)
                layout[#layout + 1] = { mb, 16 + (i - 1) * 100, y }; want[mb] = true
            end
            y = y - 30
        end
    end

    if practice then
        y = y - 4
        layout[#layout + 1] = { f.nextBoss, 16, y }; want[f.nextBoss] = true
        f.nextBoss:SetText(m.night and m.night.nextBoss and ("Kill " .. m.night.nextBoss) or "No more bosses")
        local x = 16 + 164
        if m.night and (m.night.held or 0) > 0 then layout[#layout + 1] = { f.handOut, x, y }; want[f.handOut] = true; x = x + 134 end
        layout[#layout + 1] = { f.wait, x, y }; want[f.wait] = true
        y = y - 30
    elseif not v.visible then
        -- (the start button was placed above)
    elseif v.state == "result" or v.state == "cancelled" then
        y = y - 4
        layout[#layout + 1] = { f.startButton, 16, y }; want[f.startButton] = true
        y = y - 30
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
        f:SetHeight(math.max(90, -y + 16))
    end
    local everything = { f.practiceText, f.bar, f.meta, f.metaRight, f.banner, f.turnText, f.more, f.mlLabel, f.startButton, f.nextBoss, f.handOut, f.wait, f.recipient }
    if f.drop then everything[#everything + 1] = f.drop end
    for _, b in ipairs(f.turnButtons) do everything[#everything + 1] = b end
    for _, t in ipairs(f.rankTitles) do everything[#everything + 1] = t end
    for _, c in ipairs(f.rankConfirms) do everything[#everything + 1] = c end
    for _, r in ipairs(f.rankRows) do everything[#everything + 1] = r.text; everything[#everything + 1] = r.up; everything[#everything + 1] = r.down end
    for _, b in ipairs(f.mlButtons) do everything[#everything + 1] = b end
    for _, r in ipairs(f.rows) do
        everything[#everything + 1] = r.text; everything[#everything + 1] = r.hit; everything[#everything + 1] = r.note
        for _, b in ipairs(r.buttons) do everything[#everything + 1] = b end
    end
    for _, el in ipairs(everything) do setShown(el, want[el] == true) end
    return v
end

function M:OnInit() end
