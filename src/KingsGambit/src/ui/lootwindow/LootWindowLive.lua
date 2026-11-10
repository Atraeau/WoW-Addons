-- King's Gambit: the Loot window, what the window does once it is built: running a button, refreshing the side window, keys and the full refresh. Keep this file Lua 5.1-safe.
-- Part of LootWindow (ui/LootWindow.lua): LootWindow calls Install, which adds these to the module's table.
local _, SK = ...
local UILoot, LootView
local P = SK:NewModule("LootWindowLive", { "UILoot", "LootView" }, function(d) UILoot, LootView = d.UILoot, d.LootView end)

-- M: the table to add to; h: what LootWindow shares (and what the parts installed before this one exported).
function P.Install(M, h)
local BTN4, BTN_H, CW, GAP, HINT_H, INL_GAP, INL_W, MAX, NAME_W, PAD, SCROLL_H, setShown, setup, textH = h.BTN4, h.BTN_H, h.CW, h.GAP, h.HINT_H, h.INL_GAP, h.INL_W, h.MAX, h.NAME_W, h.PAD, h.SCROLL_H, h.setShown, h.setup, h.textH

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

-- A key pressed over the window: answer or move. Returns true when it was used (so the game does not also act on it).
local ANSWER_KEY = { N = "need", O = "off", G = "gift", P = "pass" }
function M.Key(f, ui, key)
    local rows = f.keyRows
    if not rows or #rows == 0 or not f.IsShown or not f:IsShown() then return false end
    if f.IsMouseOver and not f:IsMouseOver() then return false end
    if GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus() then return false end -- typing somewhere
    if IsModifierKeyDown and IsModifierKeyDown() then return false end
    local at = 0
    for i, r in ipairs(rows) do if r.id == ui.bidItem then at = i end end
    local kind = ANSWER_KEY[key]
    if kind then
        local r = rows[at > 0 and at or 1]
        for _, vb in ipairs(r.buttons) do
            if vb.key == kind and vb.enabled then M.Run(vb.act, f, ui); return true end
        end
        return true -- (that choice isn't on offer for this item: the key is still ours)
    end
    local step = (key == "DOWN" or key == "TAB") and 1 or (key == "UP") and -1 or nil
    if step then
        local to = at == 0 and 1 or (((at - 1 + step) % #rows) + 1)
        ui.bidFollow = false
        ui.bidItem = rows[to].id
        if ui.Refresh then ui:Refresh() end
        return true
    end
    return false
end

function M.Refresh(f, ctx, ui)
    f.ctx = ctx
    local practice = ctx.sim ~= nil
    ctx.rankDraft = f.rankDraft -- the order being rearranged, not yet confirmed
    local m = UILoot.Model(ctx)
    m.practice = practice
    local v = LootView.Build(m)
    f.keyRows = {}
    for _, vr in ipairs(v.rows or {}) do if #vr.buttons > 0 then f.keyRows[#f.keyRows + 1] = { id = vr.id, buttons = vr.buttons } end end
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
    -- Only your own choice moves the panel (and a new session's start): other players' answers never do. The flag is spent once it has been used.
    if ui.bidFollow and #v.rows > 0 then
        if nextOpen and ui.bidItem ~= nextOpen then
            ui.bidItem = nextOpen
        end
        ui.bidFollow = false
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
        local mineDone, mineAll = 0, 0
        for _, vr in ipairs(v.rows or {}) do
            if vr.state == "answered" then mineDone, mineAll = mineDone + 1, mineAll + 1 elseif vr.state == "open" then mineAll = mineAll + 1 end
        end
        if mineAll > 0 then
            -- what is left for you, first: gold while there is something to decide, green when you are done
            local color = mineDone == mineAll and "|cff40ff40" or "|cffffd100"
            f.meta:SetText(("%sYour items: %d of %d|r   %s"):format(color, mineDone, mineAll, v.progress and ("Raid: " .. v.progress) or ""))
        else
            f.meta:SetText(v.progress or v.subtitle or "")
        end
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
                -- What is left to decide stands out: an item you have answered shows a check and what you said, in gray; one still to answer is marked in gold.
                local said
                for _, vb in ipairs(vr.buttons) do if vb.selected then said = vb.label or vb.letter end end
                if said then
                    label = "|TInterface\\Buttons\\UI-CheckBox-Check:14:14|t |cff8a8a8a" .. label:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") .. "|r"
                elseif #vr.buttons > 0 then
                    label = "|cffffd100>|r " .. label
                end
                row.text:SetText(label)
                local hasButtons = #vr.buttons > 0
                local top = y
                if vr.id == ui.bidItem then selTop = top end
                if hasButtons then
                    -- dense: the name on the left and the four choices on the same line, right-aligned
                    row.text:SetWidth(NAME_W); row.hit:SetSize(NAME_W, 16)
                    layout[#layout + 1] = { row.text, PAD, y - 5 }; want[row.text] = true
                    layout[#layout + 1] = { row.hit, PAD, y - 4 }; want[row.hit] = true
                    for j = 1, 4 do
                        local vb, b = vr.buttons[j], row.buttons[j]
                        if vb then
                            setup(b, vb, vb.label)
                            b:SetSize(INL_W, BTN_H)
                            layout[#layout + 1] = { b, PAD + CW - 4 * INL_W - 3 * INL_GAP + (j - 1) * (INL_W + INL_GAP), y }; want[b] = true
                        end
                    end
                    y = y - BTN_H
                    if vr.warn then
                        row.note:SetText("|cffffaa33" .. vr.warn .. "|r")
                        y = y - 4; place(row.note, PAD); y = y - textH(row.note, 12)
                    end
                else
                    row.text:SetWidth(CW); row.hit:SetSize(CW, 16)
                    place(row.text, PAD); place(row.hit, PAD)
                    y = y - 18 - 4
                    row.note:SetText((vr.segments and M.Rich(vr.segments)) or vr.note or "")
                    place(row.note, PAD); y = y - textH(row.note, 12)
                end
                local bidItem
                if v.bids and v.bids.live then for _, it in ipairs(v.bids.items) do if it.id == vr.id then bidItem = it end end end
                if bidItem then
                    row.bid:SetText(M.Rich(bidItem.segments)); y = y - 2; place(row.bid, PAD); y = y - textH(row.bid, 12)
                else row.bid:SetText("") end
                y = y - 3 - 3
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
            end
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
end
