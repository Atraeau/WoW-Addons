-- King's Gambit: the Tools tab of the window: a form for every command that needs a name, a reason or a choice, grouped by who uses it.
-- Keep this file Lua 5.1-safe. A form only COMPOSES the command a person would have typed (Compose, pure and tested) and runs it, so a form can
-- never do what the command could not, and the commands' own checks and messages apply unchanged.
local _, SK = ...
local Tips
local M = SK:NewModule("UITools", { "UITips" }, function(d) Tips = d.UITips end)

-- Field: key, label, optional (may be left empty), default, name (a character: spaces become the First_Last form).
-- cmd: pieces joined by spaces. "@key" is the field's text; a { ... } piece is dropped when its fields are empty.
local function F(key, label, opts)
    local f = { key = key, label = label }
    for k, v in pairs(opts or {}) do f[k] = v end
    return f
end

M.GROUPS = {
    { id = "raid", title = "Raid", actions = {
        { id = "raidopen", label = "Open a raid", help = "Officers. The Master Looter writes the raid's awards. Name a list to play on it (required if the guild master set one list per raid).",
            fields = { F("ml", "Master Looter", { name = true, optional = true, source = "group" }), F("hours", "Hours", { optional = true, default = "4" }), F("list", "List", { optional = true }) },
            cmd = { "raid open", "@ml", "@hours", { "list", "@list" } } },
        { id = "raidlist", label = "Name the raid's list", help = "Officers. Once named, a raid never changes list.", fields = { F("id", "List") }, cmd = { "raid list", "@id" } },
        { id = "raidshow", label = "Open raids", help = "Who is Master Looter of the raids that are open, and on which list.", fields = {}, cmd = { "raid" } },
        { id = "raidextend", label = "Extend a raid", help = "Give a running raid more time (24 hours at most).", fields = { F("hours", "Hours", { optional = true, default = "2" }) }, cmd = { "raid extend", "@hours" } },
        { id = "raidrevoke", label = "Revoke a raid", help = "Take the Master Looter's right to write away at once. It is in the record.", fields = { F("name", "Raid or Master Looter", { optional = true, name = true, source = "group" }) }, cmd = { "raid revoke", "@name" } },
        { id = "raidclose", label = "Close my raid", help = "Master Looter: end your raid.", fields = {}, cmd = { "raid close" } },
        { id = "masterloot", label = "Set Master Looter", help = "Raid leader: set the loot method to Master Looter (the game's own setting).", fields = { F("name", "Looter (default you)", { optional = true, name = true, source = "group" }) }, cmd = { "masterloot", "@name" } },
        { id = "disenchanter", label = "Disenchanter", help = "Master Looter: who disenchants what nobody wants. Required before loot is handed out. Empty shows who it is.", fields = { F("name", "Name", { optional = true, name = true, source = "group" }) }, cmd = { "disenchanter", "@name" } },
    } },
    { id = "list", title = "List", actions = {
        { id = "listuse", label = "Work on a list", help = "Which list add, move, award and undo change (empty = your raid's list, else main).", fields = { F("id", "List", { optional = true }) }, cmd = { "list use", "@id" } },
        { id = "create", label = "Create a list", help = "A list's id: lower-case letters, digits and _ (up to 24).", fields = { F("id", "List id"), F("name", "Title", { optional = true }) }, cmd = { "create", "@id", "@name" } },
        { id = "add", label = "Add a player", help = "Add one player (the Standings tab adds everyone in your group and guild at once).", fields = { F("name", "Player", { name = true, source = "missing" }), F("pos", "top, bottom or a place", { optional = true }) }, cmd = { "add", "@name", "@pos" } },
        { id = "remove", label = "Remove a player", help = "Take a player off the list. They can be put back at the same place.", fields = { F("name", "Player", { name = true }), F("reason", "Reason", { optional = true }) }, cmd = { "remove", "@name", "@reason" } },
        { id = "move", label = "Move a player", help = "A reason is required: it is part of the record.", fields = { F("name", "Player", { name = true }), F("pos", "top, bottom or a place"), F("reason", "Reason") }, cmd = { "move", "@name", "@pos", "@reason" } },
        { id = "award", label = "Record a win", help = "A win the session didn't record (a failed hand-out, a corrected winner). The item is chosen from what you actually hold: tradeable items in your bags, and the open loot window.", fields = { F("name", "Winner", { name = true }), F("item", "Item you hold", { source = "items" }), F("reason", "Reason") }, cmd = { "award", "@name", "@item", "@reason" } },
        { id = "undo", label = "Undo the last award", help = "Reverses your latest award. It asks first; this button confirms.", fields = {}, cmd = { "undo yes" } },
        { id = "trade", label = "Item went elsewhere", help = "Master Looter: the item went to someone else. The winner is restored, the other player moves to the bottom.", fields = { F("name", "Winner", { name = true }), F("to", "Who has it", { name = true }), F("reason", "Reason") }, cmd = { "trade", "@name", "@to", "@reason" } },
        { id = "salvaged", label = "Note a salvager", help = "For the record only: what a salvager did with their item.", fields = { F("name", "Salvager", { name = true }), F("what", "keep, gift, sell, disenchant or bank") }, cmd = { "salvaged", "@name", "@what" } },
    } },
    { id = "rules", title = "Rules and requests", actions = {
        { id = "eligible", label = "Class rule for an item", help = "Officers. Which classes may bid on an item before it drops (a token, a set piece). 'any' removes the restriction.", fields = { F("item", "Item (link or id)"), F("classes", "Classes, or any"), F("reason", "Reason") }, cmd = { "eligible", "@item", "@classes", "@reason" } },
        { id = "eligibles", label = "Show class rules", help = "The rule for one item, or every rule.", fields = { F("item", "Item (empty = all)", { optional = true }) }, cmd = { "eligible", "@item" } },
        { id = "suits", label = "Who an item suits", help = "Officers. Override the addon's stat check: tank, melee, hunter, caster, healer, or auto.", fields = { F("item", "Item (link or id)"), F("roles", "Roles, or auto"), F("reason", "Reason") }, cmd = { "suits", "@item", "@roles", "@reason" } },
        { id = "reqelig", label = "Request: let my class bid", help = "Ask for your class to be allowed to bid on an item, from now on.", fields = { F("item", "Item (link or id)"), F("reason", "Reason") }, cmd = { "request eligible", "@item", "@reason" } },
        { id = "request", label = "Request a list change", help = "Ask the Master Looter during a raid. Kind: move, undo, remove, add, award, trade or gift; then its details as the command takes them.", fields = { F("kind", "Kind"), F("details", "Details (player, place, reason...)") }, cmd = { "request", "@kind", "@details" } },
        { id = "requests", label = "Waiting requests", help = "Waiting requests and recent decisions.", fields = {}, cmd = { "requests" } },
        { id = "accept", label = "Accept a request", help = "Master Looter.", fields = { F("n", "Request number") }, cmd = { "accept", "@n" } },
        { id = "decline", label = "Decline a request", help = "Master Looter. A reason is required.", fields = { F("n", "Request number"), F("reason", "Reason") }, cmd = { "decline", "@n", "@reason" } },
        { id = "history", label = "History", help = "The last changes to the list, with who, why and at whose request.", fields = { F("n", "How many", { optional = true, default = "10" }) }, cmd = { "history", "@n" } },
    } },
    { id = "admin", title = "Guild master and me", actions = {
        { id = "officers", label = "Officers", help = "Show the guild master and the officers.", fields = {}, cmd = { "officers" } },
        { id = "officersset", label = "Set the officers", help = "Guild master. Replaces the whole list: give every name you want, separated by spaces or commas (First Last as First_Last).", fields = { F("names", "Names", { optional = true }) }, cmd = { "officers set", "@names" } },
        { id = "policy", label = "One list per raid?", help = "Guild master. choose (the default): the officer may name a list. perraid: every raid must have a list of its own. Empty shows it.", fields = { F("mode", "choose or perraid", { optional = true }) }, cmd = { "raid policy", "@mode" } },
        { id = "migratestatus", label = "Ledger format", help = "The ledger's format, and which players can already read the next one.", fields = {}, cmd = { "migrate status" } },
        { id = "migrate", label = "Move to the next format", help = "Guild master. Permanent. Only when 'Ledger format' shows everyone is ready.", fields = { F("format", "Next format number"), F("reason", "Reason") }, cmd = { "migrate", "@format", "@reason" } },
        { id = "version", label = "Versions", help = "This addon's version, and what every other player runs.", fields = {}, cmd = { "version" } },
        { id = "sync", label = "Sync status", help = "How the ledger is syncing with other players.", fields = {}, cmd = { "sync" } },
        { id = "check", label = "Check the game client", help = "Probe the game's API (results are saved for the developer).", fields = {}, cmd = { "check" } },
        { id = "spec", label = "My specs", help = "Your main (and off) spec, for fit hints.", fields = { F("main", "Main spec"), F("off", "Off-spec", { optional = true }) }, cmd = { "spec", "@main", "@off" } },
        { id = "hints", label = "Fit hints", help = "Show how items fit you while you bid.", fields = { F("mode", "on or off") }, cmd = { "hints", "@mode" } },
    } },
}

local function trim(s) return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", "")) end

-- An item link in a form field becomes "item:ID".
function M.PlainLinks(text)
    return (tostring(text or ""):gsub("|c%x%x%x%x%x%x%x%x|Hitem:(%d+)[^|]*|h%[.-%]|h|r", "item:%1"):gsub("|Hitem:(%d+)[^|]*|h%[.-%]|h", "item:%1"))
end

-- The command text for an action and the values typed, or nil and what is missing.
function M.Compose(action, values)
    values = values or {}
    local v, fields = {}, {}
    for _, f in ipairs(action.fields) do
        fields[f.key] = f
        local text = trim(M.PlainLinks(values[f.key]))
        if f.name then text = text:gsub("%s+", "_") end
        v[f.key] = text
        if text == "" and not f.optional then return nil, f.label end
    end
    local out = {}
    for _, piece in ipairs(action.cmd) do
        if type(piece) == "table" then
            local words, empty = {}, false
            for _, p in ipairs(piece) do
                local key = p:match("^@(.+)$")
                if key then
                    if v[key] == "" then empty = true else words[#words + 1] = v[key] end
                else
                    words[#words + 1] = p
                end
            end
            if not empty then out[#out + 1] = table.concat(words, " ") end
        else
            local key = piece:match("^@(.+)$")
            if key then
                if v[key] ~= "" then out[#out + 1] = v[key] end
            else
                out[#out + 1] = piece
            end
        end
    end
    return table.concat(out, " ")
end

-- The players a field can be: "members" (on the list), "group" (in your party or raid, else the list's members), "missing" (in the group or
-- guild but not on the list yet). Canonical names, in list order for members.
function M.Players(ctx, source, listId)
    local out, seen = {}, {}
    local function add(name) if name and not seen[name] then seen[name] = true; out[#out + 1] = name end end
    local engine, client = ctx.engine, ctx.client
    local chain = engine:Get(listId or engine:RaidList() or "main")
    local onList = chain and chain.state.members or {}
    if source == "group" then
        for _, m in ipairs(client:roster()) do add(m.name) end
    elseif source == "missing" then
        for _, list in ipairs { client:roster(), client:guildRoster() } do
            for _, m in ipairs(list) do if m.name and not onList[m.name] then add(m.name) end end
        end
        return out
    end
    if #out == 0 and chain then for _, name in ipairs(chain.state.order) do add(name) end end
    return out
end

local function shown(name) return (tostring(name):gsub("_", " ")) end

-- Something to choose from rather than type: a player, or an item you hold.
local function isPick(fld) return fld.name or fld.source == "items" end

-- The tradeable items in the bags: not soulbound, or soulbound with the loot-trade window still open (the tooltip says so). Game only.
function M.BagLinks()
    local out = {}
    local C = C_Container
    if not (C and C.GetContainerNumSlots and C.GetContainerItemInfo) then return out end
    local pattern = BIND_TRADE_TIME_REMAINING and ("^" .. BIND_TRADE_TIME_REMAINING:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "%%%1"):gsub("%%%%s", ".+") .. "$")
    local function tradeWindow(bag, slot)
        if not (pattern and C_TooltipInfo and C_TooltipInfo.GetBagItem) then return false end
        local ok, data = pcall(C_TooltipInfo.GetBagItem, bag, slot)
        if not (ok and data and data.lines) then return false end
        for _, line in ipairs(data.lines) do
            if type(line.leftText) == "string" and line.leftText:find(pattern) then return true end
        end
        return false
    end
    for bag = 0, 5 do
        for slot = 1, (C.GetContainerNumSlots(bag) or 0) do
            local info = C.GetContainerItemInfo(bag, slot)
            if info and info.hyperlink and (not info.isBound or tradeWindow(bag, slot)) then out[#out + 1] = info.hyperlink end
        end
    end
    return out
end

-- The items a record of a win could be for: what is in the open loot window, and the tradeable items in the bags (in practice, the practice
-- raid's loot). An item you don't hold can't be chosen. Each: { link, where }.
function M.Items(ctx)
    local out, seen = {}, {}
    local function add(link, where)
        if type(link) ~= "string" then return end
        local key = link:match("item:(%d+)") or link
        if seen[key] then return end
        seen[key] = true
        out[#out + 1] = { link = link, where = where }
    end
    for _, slot in ipairs(ctx.client:lootSlots() or {}) do add(slot.link, "loot window") end
    if ctx.sim then
        local session = ctx.sim.session
        for _, it in ipairs(session and session.items or {}) do add(it.link, "practice loot") end
        for _, h in ipairs(ctx.sim.held or {}) do add(h.item and h.item.name, "held practice loot") end
    elseif ctx.bagLinks then
        for _, link in ipairs(ctx.bagLinks()) do add(link, "bags") end
    end
    return out
end

function M.Find(id)
    for _, g in ipairs(M.GROUPS) do
        for _, a in ipairs(g.actions) do if a.id == id then return a, g end end
    end
end

---------------------------------------------------------------- the frames
local MAX_FIELDS = 4

local function groupById(id) for _, g in ipairs(M.GROUPS) do if g.id == id then return g end end end

-- A dropdown the game's way (radio buttons in a menu), or nil if this client doesn't have it.
local function dropdown(parent, width)
    local ok, d = pcall(CreateFrame, "DropdownButton", nil, parent, "WowStyle1DropdownTemplate")
    if ok and d and d.SetupMenu then d:SetWidth(width); return d end
end

local function chooseAction(f, ui, a)
    f.action = a and a.id or nil
    f.picked = {}
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

function M.Build(parent, ui)
    local f = CreateFrame("Frame", nil, parent)
    -- Shift-clicking an item (in the bags, the loot window, a chat link) while a form box has the cursor puts the link in that box.
    if hooksecurefunc and not M.hooked then
        M.hooked = true
        local function insert(link) if M.focus and type(link) == "string" then M.focus:Insert(link) end end
        pcall(hooksecurefunc, "ChatEdit_InsertLink", insert)
    end
    f:SetAllPoints()
    f.group, f.action = M.GROUPS[1].id, nil

    -- Two choices, one under the other: the area (Raid, List, ...), then what to do in it. The form for that action fills the rest of the tab.
    local l1 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    l1:SetPoint("TOPLEFT", 4, -6); l1:SetText("Area:")
    local l2 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    l2:SetPoint("TOPLEFT", 4, -40); l2:SetText("Action:")

    f.groupDrop = dropdown(f, 250)
    f.actionDrop = dropdown(f, 250)
    if f.groupDrop and f.actionDrop then
        f.groupDrop:SetPoint("TOPLEFT", 70, -2)
        f.actionDrop:SetPoint("TOPLEFT", 70, -36)
        f.groupDrop:SetupMenu(function(_, root)
            for _, g in ipairs(M.GROUPS) do
                root:CreateRadio(g.title, function() return f.group == g.id end, function() f.group = g.id; chooseAction(f, ui, nil) end)
            end
        end)
        f.actionDrop:SetDefaultText("Choose an action")
        f.actionDrop:SetupMenu(function(_, root)
            local g = groupById(f.group)
            for _, a in ipairs(g and g.actions or {}) do
                root:CreateRadio(a.label, function() return f.action == a.id end, function() chooseAction(f, ui, a) end)
            end
        end)
    else
        -- Without the game's dropdowns: two buttons that step through the choices.
        f.groupDrop, f.actionDrop = nil, nil
        f.groupStep = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        f.groupStep:SetSize(250, 24); f.groupStep:SetPoint("TOPLEFT", 70, -2)
        f.groupStep:SetScript("OnClick", function()
            for i, g in ipairs(M.GROUPS) do
                if g.id == f.group then f.group = M.GROUPS[i % #M.GROUPS + 1].id; break end
            end
            chooseAction(f, ui, nil)
        end)
        f.actionStep = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        f.actionStep:SetSize(250, 24); f.actionStep:SetPoint("TOPLEFT", 70, -36)
        f.actionStep:SetScript("OnClick", function()
            local g = groupById(f.group)
            local nextAction = g.actions[1]
            for i, a in ipairs(g.actions) do
                if a.id == f.action then nextAction = g.actions[i % #g.actions + 1]; break end
            end
            chooseAction(f, ui, nextAction)
        end)
    end

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    f.title:SetPoint("TOPLEFT", 4, -82)
    f.help = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.help:SetPoint("TOPLEFT", 4, -108); f.help:SetWidth(372); f.help:SetJustifyH("LEFT"); f.help:SetJustifyV("TOP"); f.help:SetWordWrap(true)
    f.labels, f.boxes = {}, {}
    for i = 1, MAX_FIELDS do
        local y = -172 - (i - 1) * 32
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
            d:SetPoint("TOPLEFT", 158, -172 - (i - 1) * 32 + 6)
            d:SetDefaultText("Choose a player")
            d:SetupMenu(function(_, root)
                local action = f.action and M.Find(f.action)
                local fld = action and action.fields[i]
                if not (fld and f.ctx) then return end
                if root.SetScrollMode then root:SetScrollMode(260) end
                if fld.source == "items" then
                    local items = M.Items(f.ctx)
                    if #items == 0 and root.CreateTitle then root:CreateTitle("Nothing to choose: carry the item (tradeable), or open its loot window") end
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
    f.run = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.run:SetSize(100, 24); f.run:SetText("Do it")
    Tips.Attach(f.run, "dothis")
    f.run:SetPoint("TOPLEFT", 4, -172 - MAX_FIELDS * 32 - 6)
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
    local group = groupById(f.group)
    local action = f.action and M.Find(f.action)
    if f.groupDrop then
        if f.shown ~= f.group .. "/" .. tostring(f.action) then
            f.shown = f.group .. "/" .. tostring(f.action)
            f.groupDrop:GenerateMenu(); f.actionDrop:GenerateMenu()
            for _, d in pairs(f.drops) do d:GenerateMenu() end
        end
    else
        f.groupStep:SetText("Area: " .. group.title .. "  (click for the next)")
        f.actionStep:SetText(action and action.label or "Choose an action (click)")
    end
    if not action then
        f.title:SetText(group.title)
        f.help:SetText("Choose an action above. Each one runs the matching command, so who may do it is decided exactly as it is for the command; if you can't, the output at the foot of the window says why.")
        for i = 1, MAX_FIELDS do f.labels[i]:Hide(); f.boxes[i]:Hide(); if f.drops[i] then f.drops[i]:Hide() end end
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
        else
            f.labels[i]:Hide(); f.boxes[i]:Hide(); if f.drops[i] then f.drops[i]:Hide() end
        end
    end
    f.run:Show()
end

function M:OnInit() end
