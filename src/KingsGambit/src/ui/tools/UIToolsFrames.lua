-- King's Gambit: the forms behind the buttons, the frames: building a section's forms, filling a form from a linked item, going to a form and refreshing. Keep this file Lua 5.1-safe.
-- Part of UITools (ui/UITools.lua): UITools calls Install, which adds these to the module's table.
local _, SK = ...
local Tips
local P = SK:NewModule("UIToolsFrames", { "UITips" }, function(d) Tips = d.UITips end)

-- M: the table to add to; h: what UITools shares (and what the parts installed before this one exported).
function P.Install(M, h)
local isPick, newButton, shown = h.isPick, h.newButton, h.shown

---------------------------------------------------------------- the frames
local MAX_FIELDS = 4

local function groupById(f, id) for _, g in ipairs(f.groups or M.GROUPS) do if g.id == id then return g end end end

-- The actions of a Guild book section, in the order it lists them, as one group (ids that no longer exist are skipped).
function M.SectionGroup(section)
    local g = { id = section.id, title = section.label, actions = {} }
    for _, id in ipairs(section.actions or {}) do
        local a = M.Find(id)
        if a then g.actions[#g.actions + 1] = a end
    end
    return g
end

-- A dropdown the game's way (radio buttons in a menu), or nil if this client doesn't have it.
local function dropdown(parent, width)
    local ok, d = pcall(CreateFrame, "DropdownButton", nil, parent, "WowStyle1DropdownTemplate")
    if ok and d and d.SetupMenu then d:SetWidth(width); return d end
end

local function sameItem(a, b)
    return a == b or (a:match("item:(%d+)") ~= nil and a:match("item:(%d+)") == b:match("item:(%d+)"))
end

-- An item link was shift-clicked somewhere. If the Tools form for an action with an item is open, the item goes into that field (a typed box
-- that has the cursor takes it first); where the item must be one you hold, it is only taken if you do. Returns true if the form took it.
function M.OnItemLink(f, ui, link)
    if type(link) ~= "string" or not link:find("|Hitem:", 1, true) then return false end
    if M.focus and M.focus.Insert then M.focus:Insert(link); return true end
    if M.TakeLink(f, ui, link) then return true end
    -- (there is a form page per Guild book section: when the one given isn't the one on screen, the one that is takes the item)
    for _, page in ipairs(M.frames or {}) do
        if page ~= f and M.TakeLink(page, ui, link) then return true end
    end
    return false
end

-- Put a link into one page's open form, if that page is on screen and its form has a place for it.
function M.TakeLink(f, ui, link)
    if not (f and f.IsVisible and f:IsVisible()) then return false end
    local action = f.action and M.Find(f.action)
    if not action then return false end
    for i, fld in ipairs(action.fields) do
        if fld.source == "items" then
            for _, it in ipairs(M.Items(f.ctx)) do
                if sameItem(it.link, link) then
                    f.picked[i] = it.link
                    if ui.Say then ui.Say("Item chosen: " .. it.link) else ui:Refresh() end
                    return true
                end
            end
            -- not one you hold: it may be in someone else's bags (a win to correct after a hand-out), so it is taken as it is
            f.picked[i] = link
            f.extra = f.extra or {}
            f.extra[i] = link
            if ui.Say then ui.Say("Item chosen: " .. link) else ui:Refresh() end
            return true
        elseif fld.link then
            f.boxes[i]:SetText(link)
            if ui.Say then ui.Say("Item chosen: " .. link) end
            return true
        end
    end
    return false
end

local function chooseAction(f, ui, a)
    f.action = a and a.id or nil
    f.picked, f.extra = {}, {}
    for _, box in ipairs(f.boxes) do box:SetText("") end
    if a and f.ctx and ui.selected then
        for j, fld in ipairs(a.fields) do
            if fld.name and (fld.source or "members") == "members" then
                for _, name in ipairs(M.Players(f.ctx, "members", ui.list)) do if name == ui.selected then f.picked[j] = name end end
                break
            end
        end
    end
    if a then for j, fld in ipairs(a.fields) do if fld.default then f.boxes[j]:SetText(fld.default) end end end
    f.problem:SetText("")
    ui:Refresh()
end

-- A page of forms. With a Guild book section, only that section's actions (and no Area choice, since there is just the one area); with none, every group.
function M.Build(parent, ui, section)
    local f = CreateFrame("Frame", nil, parent)
    -- Shift-clicking an item (in the bags, the loot window, a chat link) fills the open form's item field.
    M.frame, M.ui = f, ui
    M.frames = M.frames or {}
    M.frames[#M.frames + 1] = f
    f.groups = section and { M.SectionGroup(section) } or M.GROUPS
    local single = section ~= nil
    local up = single and 34 or 0 -- (the form moves up by the Area row it does not have)
    if hooksecurefunc and not M.hooked then
        M.hooked = true
        local function took(link)
            if M.OnItemLink(M.frame, M.ui, link) then
                -- the game also opened the chat box with the link in it: put that away, if it holds nothing but the link
                local get = (ChatFrameUtil and ChatFrameUtil.GetActiveWindow) or ChatEdit_GetActiveWindow
                local box = get and get()
                local deactivate = (ChatFrameUtil and ChatFrameUtil.DeactivateChat) or ChatEdit_DeactivateChat
                if box and box.GetText and box:GetText() == link and deactivate then
                    box:SetText(""); pcall(deactivate, box)
                end
            end
        end
        -- Every shift-click of an item (a chat link, the bags, the loot window) ends in the game's insert-link function. In this client it is
        -- ChatFrameUtil.InsertLink (ChatEdit_InsertLink is only a saved copy of it, which the game's own code doesn't call), so that is hooked, and
        -- the game's modified-click handler as a second way in. Both may fire for one click; taking the same link twice changes nothing.
        if ChatFrameUtil and ChatFrameUtil.InsertLink then pcall(hooksecurefunc, ChatFrameUtil, "InsertLink", took)
        elseif ChatEdit_InsertLink then pcall(hooksecurefunc, "ChatEdit_InsertLink", took) end
        if HandleModifiedItemClick then
            pcall(hooksecurefunc, "HandleModifiedItemClick", function(link)
                if IsModifiedClick and IsModifiedClick("CHATLINK") then took(link) end
            end)
        end
    end
    f:SetAllPoints()
    f.group, f.action = f.groups[1].id, nil

    -- Two choices, one under the other: the area (Raid, List, ...), then what to do in it. The form for that action fills the rest of the tab.
    local l1 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    l1:SetPoint("TOPLEFT", 4, -6); l1:SetText("Area:")
    local l2 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    l2:SetPoint("TOPLEFT", 4, -40 + up); l2:SetText("Action:")
    if single then l1:Hide() end

    f.groupDrop = single and {} or dropdown(f, 250)
    f.actionDrop = dropdown(f, 250)
    if single then
        -- (no Area choice: a stand-in that does nothing, so the code below treats this like the two-dropdown case)
        f.groupDrop = setmetatable({}, { __index = function() return function() end end })
    end
    if f.groupDrop and f.actionDrop then
        if not single then
            f.groupDrop:SetPoint("TOPLEFT", 70, -2)
            f.groupDrop:SetupMenu(function(_, root)
                for _, g in ipairs(f.groups) do
                    root:CreateRadio(g.title, function() return f.group == g.id end, function() f.group = g.id; chooseAction(f, ui, nil) end)
                end
            end)
        end
        f.actionDrop:SetPoint("TOPLEFT", 70, -36 + up)
        f.actionDrop:SetDefaultText("Choose an action")
        f.actionDrop:SetupMenu(function(_, root)
            local g = groupById(f, f.group)
            for _, a in ipairs(g and g.actions or {}) do
                root:CreateRadio(a.label, function() return f.action == a.id end, function() chooseAction(f, ui, a) end)
            end
        end)
    else
        -- Without the game's dropdowns: two buttons that step through the choices.
        f.groupDrop, f.actionDrop = nil, nil
        f.groupStep = newButton(f)
        f.groupStep:SetSize(250, 24); f.groupStep:SetPoint("TOPLEFT", 70, -2)
        if single then f.groupStep:Hide() end
        f.groupStep:SetScript("OnClick", function()
            for i, g in ipairs(f.groups) do
                if g.id == f.group then f.group = f.groups[i % #f.groups + 1].id; break end
            end
            chooseAction(f, ui, nil)
        end)
        f.actionStep = newButton(f)
        f.actionStep:SetSize(250, 24); f.actionStep:SetPoint("TOPLEFT", 70, -36 + up)
        f.actionStep:SetScript("OnClick", function()
            local g = groupById(f, f.group)
            local nextAction = g.actions[1]
            for i, a in ipairs(g.actions) do
                if a.id == f.action then nextAction = g.actions[i % #g.actions + 1]; break end
            end
            chooseAction(f, ui, nextAction)
        end)
    end

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    f.title:SetPoint("TOPLEFT", 4, -82 + up)
    f.help = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.help:SetPoint("TOPLEFT", 4, -108 + up); f.help:SetWidth(372); f.help:SetJustifyH("LEFT"); f.help:SetJustifyV("TOP"); f.help:SetWordWrap(true)
    f.labels, f.boxes = {}, {}
    for i = 1, MAX_FIELDS do
        local y = -172 + up - (i - 1) * 32
        f.labels[i] = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        f.labels[i]:SetPoint("TOPLEFT", 4, y); f.labels[i]:SetWidth(150); f.labels[i]:SetJustifyH("LEFT")
        local box = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        box:SetSize(200, 20); box:SetPoint("TOPLEFT", 164, y + 4); box:SetAutoFocus(false)
        box:SetScript("OnEditFocusGained", function(self) M.focus = self end)
        box:SetScript("OnEditFocusLost", function(self) if M.focus == self then M.focus = nil end end)
        f.boxes[i] = box
    end
    -- A player field is a dropdown of the players it could be (typing stays as the fallback).
    f.drops, f.picked = {}, {}
    for i = 1, MAX_FIELDS do
        local d = dropdown(f, 206)
        if d then
            d:SetPoint("TOPLEFT", 158, -172 + up - (i - 1) * 32 + 6)
            d:SetDefaultText("Choose a player")
            d:SetupMenu(function(_, root)
                local action = f.action and M.Find(f.action)
                local fld = action and action.fields[i]
                if not (fld and f.ctx) then return end
                if root.SetScrollMode then root:SetScrollMode(260) end
                if fld.source == "items" then
                    local items, stats = M.Items(f.ctx)
                    -- an item shift-clicked into this field that isn't held is listed too, so the choice shows
                    local extra = f.extra and f.extra[i]
                    if extra then
                        local dup = false
                        for _, it in ipairs(items) do if sameItem(it.link, extra) then dup = true end end
                        if not dup then table.insert(items, 1, { link = extra, where = "shift-clicked" }) end
                    end
                    if #items == 0 and root.CreateTitle then
                        local why = "Nothing to choose: carry the item (tradeable), or open its loot window."
                        if stats and not stats.unavailable then
                            why = why .. ("  (Your bags: %d items, %d soulbound, %d tradeable.)"):format(stats.seen, stats.bound, stats.tradeable)
                        end
                        root:CreateTitle(why)
                    end
                    for _, it in ipairs(items) do
                        root:CreateRadio(it.link .. "  |cff999999(" .. it.where .. ")|r", function() return f.picked[i] == it.link end, function() f.picked[i] = it.link end)
                    end
                    return
                end
                if fld.optional then
                    root:CreateRadio("(nobody)", function() return f.picked[i] == nil end, function() f.picked[i] = nil end)
                end
                for _, name in ipairs(M.Players(f.ctx, fld.source, f.listId)) do
                    root:CreateRadio(shown(name), function() return f.picked[i] == name end, function() f.picked[i] = name end)
                end
            end)
            f.drops[i] = d
        end
    end
    -- A "Common" menu of usual reasons beside each Reason box (the game's dropdown only; without it the box is just typed in).
    f.reasonDrops = {}
    for i = 1, MAX_FIELDS do
        local d = dropdown(f, 84)
        if d then
            d:SetPoint("TOPLEFT", 296, -172 + up - (i - 1) * 32 + 6)
            d:SetDefaultText("Common")
            d:SetupMenu(function(_, root)
                for _, reason in ipairs(M.REASONS) do
                    root:CreateButton(reason, function() f.boxes[i]:SetText(reason) end)
                end
            end)
            d:Hide()
            f.reasonDrops[i] = d
        end
    end
    f.run = newButton(f)
    f.run:SetSize(100, 24); f.run:SetText("Do it")
    Tips.Attach(f.run, "dothis")
    f.up = up
    f.run:SetPoint("TOPLEFT", 4, -172 + up - MAX_FIELDS * 32 - 6)
    f.problem = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.problem:SetPoint("LEFT", f.run, "RIGHT", 10, 0)
    f.run:SetScript("OnClick", function()
        local action = f.action and M.Find(f.action)
        if not action then return end
        local values = {}
        for i, fld in ipairs(action.fields) do
            if isPick(fld) and f.drops[i] then values[fld.key] = f.picked[i] else values[fld.key] = f.boxes[i]:GetText() end
        end
        local text, missing = M.Compose(action, values)
        if not text then f.problem:SetText("Needed: " .. tostring(missing)); return end
        f.problem:SetText("")
        ui:Command(text)
    end)
    return f
end

-- Open a form directly (Standings' Award button): the area, the action, and the player already chosen.
function M.Goto(f, ui, actionId, who)
    local action, group = M.Find(actionId)
    if not action then return end
    f.group = group.id
    chooseAction(f, ui, action)
    if who then
        for j, fld in ipairs(action.fields) do if fld.name then f.picked[j] = who; break end end
    end
end

function M.Refresh(f, ctx, ui)
    f.ctx, f.listId = ctx, ui.list
    local group = groupById(f, f.group)
    local action = f.action and M.Find(f.action)
    if f.groupDrop then
        if f.shown ~= f.group .. "/" .. tostring(f.action) then
            f.shown = f.group .. "/" .. tostring(f.action)
            f.groupDrop:GenerateMenu(); f.actionDrop:GenerateMenu()
            for _, d in pairs(f.drops) do d:GenerateMenu() end
        end
    else
        if not f.groups[2] then f.groupStep:Hide() else f.groupStep:SetText("Area: " .. group.title .. "  (click for the next)") end
        f.actionStep:SetText(action and action.label or "Choose an action (click)")
    end
    if not action then
        f.title:SetText(group.title)
        local names = {}
        for i, a in ipairs(group.actions) do names[i] = a.label end
        f.help:SetText((f.groups[2] and "Choose an action above." or ("Choose an action above: " .. table.concat(names, ", ") .. ".")) ..
            " Each one runs the matching command, so who may do it is decided exactly as it is for the command; if you can't, the output at the foot of the window says why.")
        for i = 1, MAX_FIELDS do
            f.labels[i]:Hide(); f.boxes[i]:Hide()
            if f.drops[i] then f.drops[i]:Hide() end
            if f.reasonDrops[i] then f.reasonDrops[i]:Hide() end
        end
        f.run:Hide()
        return
    end
    f.title:SetText(action.label)
    f.help:SetText(action.help)
    for i = 1, MAX_FIELDS do
        local fld = action.fields[i]
        if fld then
            f.labels[i]:SetText(fld.label .. (fld.optional and " (optional)" or "")); f.labels[i]:Show()
            if isPick(fld) and f.drops[i] then
                f.boxes[i]:Hide(); f.drops[i]:Show()
                f.drops[i]:SetDefaultText(fld.source == "items" and "Choose an item you hold" or "Choose a player")
                -- keep the shown choice in step with what is picked (the menu is rebuilt when the action or the pick changes)
                local key = tostring(f.picked[i])
                if f.drops[i].shownPick ~= key then f.drops[i].shownPick = key; f.drops[i]:GenerateMenu() end
            else
                f.boxes[i]:Show(); if f.drops[i] then f.drops[i]:Hide() end
            end
            -- a Reason box is a little narrower to make room for the Common menu
            local withMenu = fld.key == "reason" and f.reasonDrops[i] ~= nil
            f.boxes[i]:SetWidth(withMenu and 124 or 200)
            if f.reasonDrops[i] then if withMenu then f.reasonDrops[i]:Show() else f.reasonDrops[i]:Hide() end end
        else
            f.labels[i]:Hide(); f.boxes[i]:Hide(); if f.drops[i] then f.drops[i]:Hide() end
            if f.reasonDrops[i] then f.reasonDrops[i]:Hide() end
        end
    end
    -- "Do it" sits right under the last field (not at the foot of the form's room), so a form with few fields never reaches into a panel below it
    local y = math.min(-150 + (f.up or 0), -172 + (f.up or 0) - #action.fields * 32 - 6)
    f.run:ClearAllPoints(); f.run:SetPoint("TOPLEFT", 4, y)
    f.run:Show()
end
end
