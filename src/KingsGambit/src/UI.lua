-- King's Gambit: the window. `/gambit` with nothing after it opens it (design journal: "/gambit opens a window").
-- Tabs: Standings, Loot (the running session: answer, draft, and the Master Looter's controls). More tabs follow (officers, guild master).
-- Keep this file Lua 5.1-safe. Every button runs the same command a player would type, so the rules, the messages and the ledger are
-- exactly the same as with commands.
--
-- Two halves, so most of it can be tested without the game:
--   M.Model(engine, client, listId)        pure: what the Standings tab shows (every row, the lists, the raid and its list)
--   M:Toggle() / M:Refresh()               the frames, built the first time they are needed (game only)
local _, SK = ...
local Identity, Sim, Commands, UILoot, UITools, Tips
local M = SK:NewModule("UI", { "Identity", "Sim?", "Commands?", "UILoot", "UITools", "UITips" }, function(d)
    Identity, Sim, Commands, UILoot, UITools, Tips = d.Identity, d.Sim, d.Commands, d.UILoot, d.UITools, d.UITips
end)

local function say(text)
    if SK.Print then SK:Print(text) else print(text) end
end

-- What the window shows for one list (every row; the window scrolls). listId nil = the list the viewer's raid plays on, else main.
function M.Model(engine, client, listId)
    local lists = engine:Lists()
    local raidList, raid = engine:RaidList()
    local id = listId or raidList or "main"
    local mayWrite = engine.MayWrite and engine:MayWrite() and true or false
    local model = { mayWrite = mayWrite, missing = 0, lists = lists, list = id, raid = raid, raidList = raidList, me = client:me(), rows = {}, total = 0 }
    local chain = engine:Get(id)
    if not chain then return model end
    local order = chain.state.order
    model.total = #order
    local seen = {}
    for _, source in ipairs { client:roster(), client:guildRoster() } do
        for _, m in ipairs(source) do
            if m.name and not seen[m.name] and not chain.state.members[m.name] then seen[m.name] = true; model.missing = model.missing + 1 end
        end
    end
    for i = 1, #order do
        local who = order[i]
        local m = chain.state.members[who]
        model.rows[#model.rows + 1] = { pos = i, name = Identity.Display(who), who = who, wins = m.wins or 0,
            class = m.class, mine = who == model.me }
    end
    return model
end

-- The engine, client and commands the window works on: the real ones, or (in practice mode) a simulated raid's, which is a separate
-- in-memory ledger: nothing in it is saved, sent to anyone, or mixed with the real one.
function M.Ctx()
    if M.practice then return M.practice end
    return { engine = SK.engine, client = SK.client, commands = SK.commands, host = SK.host, player = SK.player }
end

M.SIZES = { 5, 10, 20, 40 }
M.size = 40
M.tab = "standings"

-- The gear this character has on or carries: item links, each item once (game only).
function M.GearLinks()
    local links, seen = {}, {}
    local function add(link)
        local id = type(link) == "string" and tonumber(link:match("item:(%d+)"))
        if id and not seen[id] then seen[id] = true; links[#links + 1] = link end
    end
    if GetInventoryItemLink then for slot = 1, 19 do add(GetInventoryItemLink("player", slot)) end end
    local C = C_Container
    if C and C.GetContainerNumSlots and C.GetContainerItemLink then
        for bag = 0, 5 do
            for slot = 1, (C.GetContainerNumSlots(bag) or 0) do add(C.GetContainerItemLink(bag, slot)) end
        end
    end
    return links
end

local NOT_GEAR = { INVTYPE_BAG = true, INVTYPE_QUIVER = true, INVTYPE_AMMO = true, INVTYPE_NON_EQUIP_IGNORE = true, INVTYPE_TABARD = true, INVTYPE_BODY = true }
-- Of those links, the ones that are wearable gear, as the practice raid wants them (needs the game to know each item: a cached one).
function M.GearItems(client, links, max)
    local out = {}
    for _, link in ipairs(links) do
        local info = client:itemInfo(link)
        local id = tonumber(link:match("item:(%d+)"))
        if info and id and info.equipLoc and info.equipLoc ~= "" and not NOT_GEAR[info.equipLoc] and (info.class == 2 or info.class == 4) then
            local st = client:itemStats(link)
            out[#out + 1] = { id = id, link = link, equipLoc = info.equipLoc, class = info.class, subclass = info.subclass, stats = st and st.stats or {} }
            if max and #out >= max then break end
        end
    end
    return out
end

function M:StartPractice()
    if not (Sim and Commands) then return end
    local me = SK.client:me()
    -- Loot: the gear in your bags and on your character, which the game really has (Molten Core's items aren't in this game yet). Molten Core's
    -- loot table is the fallback when there are too few pieces to make a raid of.
    local gear = M.GearItems(SK.client, M.GearLinks(), 24)
    local sim
    if #gear >= 3 then
        sim = Sim.NewPractice(gear, { learner = me, seed = 1, size = M.size })
        say(("Practice: the loot is %d pieces of gear from your bags and equipment, so it has real tooltips."):format(#gear))
    else
        sim = Sim.NewMoltenCore({ learner = me, seed = 1, size = M.size })
        say("Practice: you carry fewer than 3 pieces of gear, so the loot is Molten Core's (those items may not exist in this game yet, so no tooltips).")
    end
    -- A simulated guild: the raid's players, and others who are not in the group (some offline).
    local guild = {}
    for _, m in ipairs(sim.client:roster()) do guild[#guild + 1] = { name = m.name, class = m.class } end
    local classes = { "WARRIOR", "MAGE", "ROGUE", "PRIEST", "HUNTER", "WARLOCK", "DRUID", "PALADIN" }
    for i, n in ipairs { "Oswin", "Perrin", "Rook", "Sabine", "Tamsin", "Ulric", "Vesna", "Wick", "Yorick", "Zora", "Alder", "Bexley" } do
        guild[#guild + 1] = { name = n, class = classes[(i - 1) % #classes + 1], online = i % 3 ~= 0 }
    end
    sim.client:setGuild(guild)
    sim.client.print = function(_, text) print("|cffffaa00Practice|r", text) end
    -- The commands find the running loot session through `host.session`: here it is whatever the simulation is running.
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local commands = Commands.New({ client = sim.client, engine = sim.engine, host = host })
    M.practice = { engine = sim.engine, client = sim.client, commands = commands, sim = sim, host = host }
    -- The practice loot uses real item ids; say how many this game knows (the rest show as plain names, with no tooltip).
    local total, unknown = 0, 0
    for id in pairs(sim.raid and sim.raid.items or {}) do
        total = total + 1
        if not UILoot.KnownToGame(id) then unknown = unknown + 1 end
    end
    if unknown > 0 and not (sim.raid and sim.raid.name == "Your gear") then
        say(("Practice: %d of the %d %s items aren't in this game's item data yet, so they show as plain names without a tooltip."):format(unknown, total, sim.raid.name or "raid"))
    end
    M.list = nil
    M:Refresh()
end

function M:LeavePractice()
    M.practice = nil
    M.list = nil
    M:Refresh()
end

-- Practice: the next boss dies and its loot goes up (the simulated raiders answer on their own), the held loot is handed out, time passes.
function M:PracticeKill()
    local p = M.practice
    if not p then return end
    local s = p.sim.session
    if s and s.phase ~= "done" and s.phase ~= "cancelled" then return say("Practice: finish handing out the current loot first.") end
    local boss, _, why = p.sim:killBoss(nil, false)
    if not boss then return say("Practice: there are no more bosses.") end
    if why then say("Practice: " .. tostring(why)) end
    M.tab = "loot"; M:Refresh()
end
function M:PracticeHandOut()
    local p = M.practice
    if p then p.sim:handOut(); M.tab = "loot"; M:Refresh() end
end
function M:PracticeWait(sec)
    local p = M.practice
    if p then p.sim:advance(sec); M:Refresh() end
end

-- What the commands have said lately, shown at the foot of the window (they still print in chat as well).
M.log = {}
local function remember(text)
    M.log[#M.log + 1] = tostring(text)
    while #M.log > 5 do table.remove(M.log, 1) end
end

-- A button runs the same command a player would type; the answer is shown at the foot of the window and printed in chat as always.
function M:Command(text)
    local ctx = M.Ctx()
    local client = ctx.client
    local original = client.print
    M.log = { "> " .. text }
    client.print = function(self, line) remember(line); return original(self, line) end
    local ok, err = pcall(ctx.commands.handle, text)
    client.print = original
    if not ok then remember("error: " .. tostring(err)) end
    M:Refresh()
end

-- Lines for the output area: the newest few, each trimmed of the game's colour codes.
function M.OutputText()
    local lines = {}
    for i, l in ipairs(M.log) do lines[i] = (l:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
    return table.concat(lines, "\n")
end

function M.Say(text) remember(text); M:Refresh() end

local function nextList(lists, current)
    for i, id in ipairs(lists) do
        if id == current then return lists[i % #lists + 1] end
    end
    return lists[1]
end

local TABS = { { "standings", "Standings" }, { "loot", "Loot" }, { "tools", "Tools" } }
local SORTS = { { "pos", "#" }, { "name", "Name" }, { "class", "Class" }, { "wins", "Wins" } }

local function setShown(frame, on) if on then frame:Show() else frame:Hide() end end

function M:Refresh()
    local w = self.window
    if not (w and w:IsShown()) then return end
    local ctx = M.Ctx()
    w.subtitle:SetText(M.practice and "|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r" or "")
    if w.tabSystem then
        for i, t in ipairs(TABS) do if t[1] == M.tab then w.tabSystem:SetTabVisuallySelected(i) end end
    end
    if w.practiceCheck then w.practiceCheck:SetChecked(M.practice ~= nil) end
    if w.practiceButton then w.practiceButton:SetText(M.practice and "Leave practice" or "Practice mode") end
    -- The group size only means something inside practice mode.
    setShown(w.sizeButton, M.practice ~= nil)
    if w.sizeButton.GenerateMenu then
        if w.shownSize ~= M.size then w.shownSize = M.size; w.sizeButton:GenerateMenu() end
    else
        w.sizeButton:SetText("Practice group: " .. M.size)
    end
    for _, t in ipairs(TABS) do
        if w.tabButtons[t[1]] then w.tabButtons[t[1]]:SetEnabled(M.tab ~= t[1]) end
        setShown(w.pages[t[1]], M.tab == t[1])
    end
    w.output:SetText(M.OutputText())
    if M.tab == "loot" then return UILoot.Refresh(w.pages.loot, ctx, M) end
    if M.tab == "tools" then return UITools.Refresh(w.pages.tools, ctx, M) end
    local p = w.pages.standings
    local model = M.Model(ctx.engine, ctx.client, self.list)
    self.list = model.list
    if not p.listDrop then p.listButton:SetText(model.list) end
    p.raidText:SetText(model.raid and ("Your raid plays on: " .. (model.raidList or "(no list chosen yet)")) or "No raid open for you")
    p.countText:SetText(("%d on the list"):format(model.total))
    for i, c in ipairs(SORTS) do
        p.headers[i].text:SetText(c[2] .. ((M.sortKey == c[1]) and (M.sortDesc and "  v" or "  ^") or ""))
    end
    if p.listDrop and p.shownList ~= model.list then p.shownList = model.list; p.listDrop:GenerateMenu() end
    -- the player selected, if they are on this list; the places let Up and Down work out where to move them
    M.places = {}
    local selectedRow
    for _, r in ipairs(model.rows) do
        M.places[r.who] = r.pos
        if r.who == M.selected then selectedRow = r end
    end
    if not selectedRow then M.selected = nil end
    M.total = model.total
    if M.pending and (not selectedRow or M.pending.who ~= selectedRow.who) then M.pending = nil end
    M.FillRows(p, M.Preview(model.rows))
    local staged = M.pending
    p.selText:SetText(selectedRow and (staged and ("Moving " .. selectedRow.name .. " from place " .. selectedRow.pos .. " to " .. staged.to .. ": press Apply move")
        or ("Selected: " .. selectedRow.name .. "  (place " .. selectedRow.pos .. " of " .. model.total .. ")"))
        or "Click a player in the list to act on them.")
    -- everyone sees the controls; only someone who may write can use them
    local may = model.mayWrite
    M.may = may
    setShown(p.hint, not may)
    if p.reason.SetEnabled then p.reason:SetEnabled(may) end
    for _, b in ipairs(p.actionButtons) do b:SetEnabled(may and selectedRow ~= nil) end
    p.apply:SetEnabled(may and staged ~= nil); p.cancelMove:SetEnabled(may and staged ~= nil)
    p.setPlace:SetEnabled(may and selectedRow ~= nil)
    if p.placeBox.SetEnabled then p.placeBox:SetEnabled(may and selectedRow ~= nil) end
    local hasList = #model.lists > 0
    setShown(p.startButton, not hasList)
    setShown(p.addAllButton, hasList and model.missing > 0)
    p.addAllButton:SetText(("Add %d from your group and guild"):format(model.missing))
    if model.total == 0 then
        p.message:SetText(hasList and "Nobody is on this list yet. Players in your group and guild can be added with the button below."
            or "No lists yet. The guild master starts the ledger with the button below.")
        p.message:Show()
    else
        p.message:Hide()
    end
end

local ROW_H = 18
local COLS_X = { 4, 36, 190, 290 }

local function classColour(class)
    local c = RAID_CLASS_COLORS and class and RAID_CLASS_COLORS[class]
    if not c then return "|cffffffff" end
    return ("|cff%02x%02x%02x"):format(math.floor(c.r * 255 + 0.5), math.floor(c.g * 255 + 0.5), math.floor(c.b * 255 + 0.5))
end
local function className(class) return class and (class:sub(1, 1) .. class:sub(2):lower()) or "" end

-- Fill one row (a Button) with a player: made once, reused by the scroll box as it scrolls.
function M.InitRow(row, r)
    row.rowData = r
    if row.SetScript then row:SetScript("OnClick", function() M.selected = r.who; M:Refresh() end) end
    -- Drag a player onto another row to stage a move to that place (only for someone who may change the list).
    if row.RegisterForDrag then
        row:RegisterForDrag("LeftButton")
        row:SetScript("OnDragStart", function() if M.may then M.dragging = r.who; M.selected = r.who end end)
        row:SetScript("OnDragStop", function() M.DropOn(M.RowUnderCursor()) end)
    end
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then
        if r.moving then row.hl:SetColorTexture(0.3, 0.6, 1, 0.35) else row.hl:SetColorTexture(1, 0.82, 0, 0.2) end
        if M.selected == r.who or r.moving then row.hl:Show() else row.hl:Hide() end
    end
    if not row.cells then
        row.cells = {}
        for c = 1, 4 do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            fs:SetPoint("LEFT", COLS_X[c], 0)
            fs:SetJustifyH("LEFT"); fs:SetWordWrap(false)
            fs:SetWidth(c == 2 and 150 or (c == 3 and 96 or 40))
            row.cells[c] = fs
        end
    end
    row.cells[1]:SetText(tostring(r.shown or r.pos))
    row.cells[2]:SetText(classColour(r.class) .. r.name .. "|r" .. (r.mine and "  (you)" or "") .. (r.moving and ("  |cff66aaff(from " .. r.pos .. ")|r") or ""))
    row.cells[3]:SetText(className(r.class))
    row.cells[4]:SetText(tostring(r.wins))
end

-- A staged move: the selected player and the place they would take. Nothing is written to the ledger until it is applied.
M.pending = nil

-- The rows as they would be with the staged move done (the player shown at their new place, marked as moving).
function M.Preview(rows)
    local pend = M.pending
    if not pend then return rows end
    local rest, mover = {}, nil
    for _, r in ipairs(rows) do
        if r.who == pend.who then mover = r else rest[#rest + 1] = r end
    end
    if not mover then return rows end
    local copy = {}
    for k, v in pairs(mover) do copy[k] = v end
    copy.moving = true
    table.insert(rest, math.min(math.max(pend.to, 1), #rest + 1), copy)
    local out = {}
    for i, r in ipairs(rest) do
        local c = {}
        for k, v in pairs(r) do c[k] = v end
        c.shown = i
        out[i] = c
    end
    return out
end

-- Stage a move of the selected player to a place (it is only a preview). A place they already hold clears it.
function M.Stage(to)
    local who = M.selected
    local place = who and M.places and M.places[who]
    if not place then return end
    to = math.floor(math.max(1, math.min(M.total or place, tonumber(to) or place)))
    if to == place then M.pending = nil else M.pending = { who = who, to = to } end
    M:Refresh()
end

-- The command for the staged move, or nil and what is wrong.
function M.MoveCommand(reason)
    local pend = M.pending
    if not pend then return nil, "There is no staged move: pick a place for the selected player first." end
    reason = (tostring(reason or ""):gsub("^%s+", ""):gsub("%s+$", ""))
    if reason == "" then return nil, "A move needs a reason: it is part of the record. Type it in the Reason box." end
    return ("move %s %d %s"):format(pend.who, pend.to, reason)
end

-- The player's row under the mouse (a drag ended there), if any.
function M.RowUnderCursor()
    local f = GetMouseFoci and GetMouseFoci()
    if type(f) == "table" then f = f[1] end
    if not f and GetMouseFocus then f = GetMouseFocus() end
    while f do
        if f.rowData then return f.rowData end
        f = f.GetParent and f:GetParent() or nil
    end
end

-- Dropping the dragged player on a row stages a move to that row's place.
function M.DropOn(r)
    local who = M.dragging
    M.dragging = nil
    if who and r then
        M.selected = who
        M.Stage(r.shown or r.pos)
    end
end

-- The rows in the order chosen by a column header (the list's own order unless one was clicked).
function M.Sorted(rows)
    local key, desc = M.sortKey, M.sortDesc
    if not key or key == "pos" and not desc then return rows end
    local out = {}
    for i, r in ipairs(rows) do out[i] = r end
    table.sort(out, function(a, b)
        local x, y = a[key], b[key]
        if key == "name" or key == "class" then x, y = tostring(x or ""):lower(), tostring(y or ""):lower() end
        if x == y then return a.pos < b.pos end
        if desc then return x > y end
        return x < y
    end)
    return out
end

-- One line per player in the scrolling table.
function M.FillRows(p, rows)
    rows = M.Sorted(rows)
    if p.scrollBox then
        local data = CreateDataProvider()
        for _, r in ipairs(rows) do data:Insert(r) end
        p.scrollBox:SetDataProvider(data, ScrollBoxConstants and ScrollBoxConstants.RetainScrollPosition)
        return
    end
    for i, r in ipairs(rows) do
        local line = p.lines[i]
        if not line then
            line = CreateFrame("Button", nil, p.child)
            line:SetSize(340, ROW_H)
            line:SetPoint("TOPLEFT", 0, -(i - 1) * ROW_H)
            p.lines[i] = line
        end
        M.InitRow(line, r)
        line:Show()
    end
    for i = #rows + 1, #p.lines do p.lines[i]:Hide() end
    p.child:SetHeight(math.max(#rows * ROW_H, 1))
end

local function button(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
end

function M:BuildStandings(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    local lbl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("TOPLEFT", 4, 0); lbl:SetText("List:")
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, p, "WowStyle1DropdownTemplate")
    if okDrop and drop then
        drop:SetWidth(130)
        drop:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        drop:SetupMenu(function(_, root)
            local e = M.Ctx().engine
            local current = M.list or e:RaidList() or "main"
            for _, id in ipairs(e:Lists()) do
                root:CreateRadio(id, function() return current == id end, function() M.list = id; M:Refresh() end)
            end
        end)
        p.listDrop = drop
        Tips.Attach(drop, "listpick")
        p.listButton = drop -- (the dropdown shows the chosen list itself)
    else
        p.listButton = button(p, "main", 120)
        p.listButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        p.listButton:SetScript("OnClick", function()
            local e = M.Ctx().engine
            M.list = nextList(e:Lists(), M.list or e:RaidList() or "main"); M:Refresh()
        end)
    end
    p.raidText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.raidText:SetPoint("LEFT", p.listButton, "RIGHT", 10, 0)
    p.raidText:SetWidth(200); p.raidText:SetJustifyH("LEFT")

    -- A scrolling table like the game's own rosters: an inset panel, clickable column headers (click to sort, again to reverse), and the game's
    -- scroll box with its scroll bar. If this client's scroll box can't be built, the older scroll frame does the same job.
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then
        inset:SetPoint("TOPLEFT", -2, -26); inset:SetPoint("BOTTOMRIGHT", 2, 142)
    end
    p.headers = {}
    for i, c in ipairs(SORTS) do
        local h = CreateFrame("Button", nil, p)
        h:SetSize(i == 2 and 150 or 70, 16)
        h:SetPoint("TOPLEFT", COLS_X[i] + 6, -31)
        h.text = h:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        h.text:SetPoint("LEFT")
        h.text:SetText(c[2])
        h:SetScript("OnClick", function()
            if M.sortKey == c[1] then M.sortDesc = not M.sortDesc else M.sortKey, M.sortDesc = c[1], false end
            M:Refresh()
        end)
        Tips.Attach(h, "sort")
        p.headers[i] = h
    end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -50)
        box:SetPoint("BOTTOMRIGHT", -22, 146)
        bar:SetPoint("TOPLEFT", box, "TOPRIGHT", 4, -2)
        bar:SetPoint("BOTTOMLEFT", box, "BOTTOMRIGHT", 4, 2)
        local view = CreateScrollBoxListLinearView()
        view:SetElementExtent(ROW_H)
        view:SetElementInitializer("Button", M.InitRow)
        ScrollUtil.InitScrollBoxListWithScrollBar(box, bar, view)
        p.scrollBox, p.scrollBar = box, bar
    end)
    if not okBox then
        local ok, scroll = pcall(CreateFrame, "ScrollFrame", nil, p, "UIPanelScrollFrameTemplate")
        if not ok or not scroll then scroll = CreateFrame("ScrollFrame", nil, p) end
        scroll:SetPoint("TOPLEFT", 4, -50)
        scroll:SetPoint("BOTTOMRIGHT", -26, 146)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(340, 1)
        scroll:SetScrollChild(p.child)
        p.scroll, p.lines = scroll, {}
    end
    p.countText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.countText:SetPoint("BOTTOMRIGHT", -6, 6)
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -64); p.message:SetWidth(330); p.message:SetJustifyH("LEFT"); p.message:Hide()

    -- First run: the guild master founds the ledger (the same as `create main`; the ledger records who did it as the guild master).
    p.startButton = button(p, "Start the ledger", 160, 26)
    p.startButton:SetPoint("TOP", 0, -130)
    p.startButton:SetScript("OnClick", function() M:Command("create main Main"); M.list = "main"; M:Refresh() end)
    p.startButton:Hide()
    Tips.Attach(p.startButton, "startledger")

    -- Act on the player selected above: a reason (required for a move: it goes in the record), then where to move them, remove them, or record a win.
    p.selText = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    p.selText:SetPoint("BOTTOMLEFT", 6, 104); p.selText:SetWidth(360); p.selText:SetJustifyH("LEFT"); p.selText:SetWordWrap(false)
    local rl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    rl:SetPoint("BOTTOMLEFT", 6, 82); rl:SetText("Reason:")
    p.barLabel = rl
    -- Someone who may not change the list (not an officer, and not the raid's Master Looter) still sees the buttons, greyed out, and this line saying why.
    p.hint = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.hint:SetPoint("BOTTOMLEFT", 6, 126); p.hint:SetWidth(360); p.hint:SetJustifyH("LEFT"); p.hint:SetWordWrap(false)
    p.hint:SetText("|cffff8040You can't change the list: only officers, and a raid's Master Looter, can. Ask via Tools.|r")
    p.reason = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.reason:SetSize(290, 20); p.reason:SetPoint("BOTTOMLEFT", 56, 78); p.reason:SetAutoFocus(false)
    p.actionButtons = {}
    local function trim(t) return (tostring(t or ""):gsub("^%s+", ""):gsub("%s+$", "")) end
    local function stageBy(delta)
        local who = M.selected
        local place = who and M.places and M.places[who]
        if not place then return end
        M.Stage(((M.pending and M.pending.who == who) and M.pending.to or place) + delta)
    end
    -- Up, Down, Top, Bottom and the place box only stage a move (a preview); Apply move records it as one entry.
    local ACTIONS = {
        { "Top", function() M.Stage(1) end }, { "Up", function() stageBy(-1) end }, { "Down", function() stageBy(1) end },
        { "Bottom", function() M.Stage(M.total or 1) end },
        { "Remove", function()
            local who = M.selected; if not who then return end
            local reason = trim(p.reason:GetText())
            M:Command(("remove %s%s"):format(who, reason ~= "" and (" " .. reason) or ""))
        end },
        { "Award...", function() if M.selected then M.OpenTool("award", M.selected) end end },
    }
    for i, a in ipairs(ACTIONS) do
        local b = button(p, a[1], 56, 22)
        b:SetPoint("BOTTOMLEFT", 6 + (i - 1) * 60, 52)
        b:SetScript("OnClick", a[2])
        Tips.Attach(b, ({ "top", "up", "down", "bottom", "remove", "award" })[i], function()
            if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
            if not M.selected then return "Select a player in the list first." end
        end)
        p.actionButtons[i] = b
    end
    -- Where to: a place number (or drag a player onto a row), then apply or cancel.
    local pl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    pl:SetPoint("BOTTOMLEFT", 6, 31); pl:SetText("To place:")
    p.placeBox = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.placeBox:SetSize(34, 20); p.placeBox:SetPoint("BOTTOMLEFT", 62, 26); p.placeBox:SetAutoFocus(false); p.placeBox:SetMaxLetters(3)
    p.setPlace = button(p, "Set", 40, 22)
    p.setPlace:SetPoint("BOTTOMLEFT", 102, 25)
    p.setPlace:SetScript("OnClick", function()
        local n = tonumber(p.placeBox:GetText())
        if n then M.Stage(n); p.placeBox:SetText("") end
    end)
    p.apply = button(p, "Apply move", 96, 22)
    p.apply:SetPoint("BOTTOMLEFT", 150, 25)
    p.apply:SetScript("OnClick", function()
        local text, problem = M.MoveCommand(p.reason:GetText())
        if not text then return M.Say(problem) end
        M.pending = nil
        M:Command(text)
    end)
    p.cancelMove = button(p, "Cancel", 60, 22)
    p.cancelMove:SetPoint("BOTTOMLEFT", 250, 25)
    p.cancelMove:SetScript("OnClick", function() M.pending = nil; M:Refresh() end)
    local why = function()
        if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
    end
    Tips.Attach(p.placeBox, "place"); Tips.Attach(p.setPlace, "place", why)
    Tips.Attach(p.apply, "apply", function() return why() or (not M.pending and "Nothing is staged: choose a place first.") or nil end)
    Tips.Attach(p.cancelMove, "cancelmove", why)

    -- Fill the list from the group and the guild: the same as `addall`.
    p.addAllButton = button(p, "Add from your group and guild", 240, 22)
    p.addAllButton:SetPoint("BOTTOMLEFT", 4, 1)
    p.addAllButton:SetScript("OnClick", function() M:Command("addall") end)
    Tips.Attach(p.addAllButton, "addall", function()
        if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
    end)

    return p
end

function M:Build()
    -- BasicFrameTemplateWithInset gives a title bar and close button; fall back to a plain frame if this client lacks it.
    local ok, w = pcall(CreateFrame, "Frame", "KingsGambitWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not w then w = CreateFrame("Frame", "KingsGambitWindow", UIParent) end
    M.building = w -- (hidden again if building the rest fails, so a half-built window is never left on screen)
    w:SetSize(420, 640)
    w:SetPoint("CENTER")
    w:SetFrameStrata("DIALOG")
    w:SetMovable(true); w:EnableMouse(true)
    w:RegisterForDrag("LeftButton")
    w:SetScript("OnDragStart", w.StartMoving)
    w:SetScript("OnDragStop", w.StopMovingOrSizing)
    if w.TitleText then w.TitleText:SetText("King's Gambit") end
    if w.SetBackdrop and not w.TitleText then
        w:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32, insets = { left = 8, right = 8, top = 8, bottom = 8 } })
    end
    if not w.TitleText then
        local t = w:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        t:SetPoint("TOP", 0, -14); t:SetText("King's Gambit")
        local close = button(w, "Close", 70); close:SetPoint("TOPRIGHT", -10, -10)
        close:SetScript("OnClick", function() w:Hide() end)
    end

    w.subtitle = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.subtitle:SetPoint("TOPLEFT", 16, -32)

    -- Practice mode is a checkbox, like the game's own "show offline members": ticked, everything here runs on a simulated raid and guild.
    local function togglePractice(on) if on then M:StartPractice() else M:LeavePractice() end end
    local okc, check = pcall(CreateFrame, "CheckButton", nil, w, "UICheckButtonTemplate")
    if okc and check then
        check:SetPoint("TOPLEFT", 12, -46)
        check:SetScript("OnClick", function(self) togglePractice(self:GetChecked() and true or false) end)
        w.practiceCheck = check
        Tips.Attach(check, "practice")
        local label = w:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("LEFT", check, "RIGHT", 2, 1); label:SetText("Practice mode")
    else
        w.practiceButton = button(w, "Practice mode", 120)
        w.practiceButton:SetPoint("TOPLEFT", 16, -50)
        w.practiceButton:SetScript("OnClick", function() togglePractice(not M.practice) end)
        Tips.Attach(w.practiceButton, "practice")
    end
    -- How many players the simulated group has (a 5-player party up to a 40-player raid). Changing it restarts practice.
    local okSize, sizeDrop = pcall(CreateFrame, "DropdownButton", nil, w, "WowStyle1DropdownTemplate")
    if okSize and sizeDrop then
        sizeDrop:SetWidth(150)
        sizeDrop:SetPoint("TOPLEFT", 150, -48)
        sizeDrop:SetupMenu(function(_, root)
            for _, n in ipairs(M.SIZES) do
                root:CreateRadio(("Group of %d"):format(n), function() return M.size == n end, function() M.size = n; if M.practice then M:StartPractice() end end)
            end
        end)
        w.sizeButton = sizeDrop
        Tips.Attach(sizeDrop, "practicesize")
    else
        w.sizeButton = button(w, "Practice group: 40", 170)
        w.sizeButton:SetPoint("TOPLEFT", 150, -48)
        w.sizeButton:SetScript("OnClick", function()
            for i, n in ipairs(M.SIZES) do
                if n == M.size then M.size = M.SIZES[i % #M.SIZES + 1]; break end
            end
            if M.practice then M:StartPractice() end
        end)
    end

    -- Tabs hang along the bottom edge of the window, as the game's own windows have them; plain buttons along the top if the tab system isn't there.
    w.tabButtons = {}
    local okTabs, tabs = pcall(CreateFrame, "Frame", nil, w, "TabSystemTemplate")
    if okTabs and tabs and tabs.AddTab then
        tabs:SetPoint("TOPLEFT", w, "BOTTOMLEFT", 12, 2)
        tabs:SetTabSelectedCallback(function(id) M.tab = TABS[id][1]; M:Refresh() end)
        for _, t in ipairs(TABS) do tabs:AddTab(t[2]) end
        w.tabSystem = tabs
    else
        for i, t in ipairs(TABS) do
            local b = button(w, t[2], 100, 24)
            b:SetPoint("TOPLEFT", 16 + (i - 1) * 104, -80)
            b:SetScript("OnClick", function() M.tab = t[1]; M:Refresh() end)
            w.tabButtons[t[1]] = b
        end
    end
    local content = CreateFrame("Frame", nil, w)
    content:SetPoint("TOPLEFT", 16, -112)
    content:SetPoint("BOTTOMRIGHT", -16, 92)
    w.pages = { standings = M:BuildStandings(content), loot = UILoot.Build(content, M), tools = UITools.Build(content, M) }
    -- Output: what the last command said (a refusal says why), so nobody has to watch the chat window.
    w.output = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.output:SetPoint("BOTTOMLEFT", 20, 18); w.output:SetWidth(380); w.output:SetHeight(66)
    w.output:SetJustifyH("LEFT"); w.output:SetJustifyV("TOP"); w.output:SetWordWrap(true)

    -- Keep it current while it is open: the ledger changes as other players' updates arrive, and a practice raid's clock runs.
    local elapsed = 0
    w:SetScript("OnUpdate", function(_, dt)
        elapsed = elapsed + dt
        if elapsed > 1 then
            elapsed = 0
            if M.practice then M.practice.sim:advance(1) end
            M:Refresh()
        end
    end)
    w:SetScript("OnShow", function() M:Refresh() end)
    -- Escape closes it.
    if UISpecialFrames then table.insert(UISpecialFrames, "KingsGambitWindow") end
    w:Hide()
    self.window = w
    return w
end

-- Build the window once; if it fails part-way the half-built frame is hidden and the error is passed on.
-- Open a form in the Tools tab with the selected player filled in.
function M.OpenTool(actionId, who)
    local w = M:Window()
    M.tab = "tools"
    UITools.Goto(w.pages.tools, M, actionId, who)
    M:Refresh()
end

function M:Window()
    if self.window then return self.window end
    local ok, w = pcall(self.Build, self)
    if not ok then
        if M.building then M.building:Hide() end
        error(w, 0)
    end
    return w
end

function M:Toggle()
    if not (CreateFrame and UIParent) then return false end
    local w = self:Window()
    if w:IsShown() then w:Hide() else w:Show() end
    return true
end

-- Show the window on a tab (a loot session has started).
function M:Open(tab)
    if not (CreateFrame and UIParent) then return end
    local w = self:Window()
    if tab then M.tab = tab end
    w:Show(); M:Refresh()
end

function M:OnInit()
    -- A loot session reaches this player (or starts on this machine): open the window on it.
    local function opener() M:Open("loot") end
    if SK.player and SK.player.on then SK.player.on("session", opener) end
    if SK.host and SK.host.on then
        SK.host.on("phase", function(p) if p == "bidding" or (type(p) == "table" and p.phase == "bidding") then opener() end end)
    end
end
