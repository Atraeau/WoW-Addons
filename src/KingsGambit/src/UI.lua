-- King's Gambit: the Guild book. `/gambit` with nothing after it opens it (design journal: "/gambit opens a window").
-- A navigation column on the left (Lists, Ledger, Awards, Raids, People, Rules, Admin: GuildBook.SECTIONS) and the section on the right (docs/ui-design.md, 5.2). A live loot session
-- has its own small window (LootWindow).
-- Keep this file Lua 5.1-safe. Every button runs the same command a player would type, so the rules, the messages and the ledger are
-- exactly the same as with commands.
--
-- Two halves, so most of it can be tested without the game:
--   M.Model(engine, client, listId)        pure: what the Lists section shows (every row, the lists, the raid and its list)
--   M:Toggle() / M:Refresh()               the frames, built the first time they are needed (game only)
local _, SK = ...
local Identity, Sim, Commands, UILoot, UITools, Tips, LootWindow, GuildBook
local M = SK:NewModule("UI", { "Identity", "Sim?", "Commands?", "UILoot", "UITools", "UITips", "LootWindow", "GuildBook" }, function(d)
    Identity, Sim, Commands, UILoot, UITools, Tips, LootWindow, GuildBook = d.Identity, d.Sim, d.Commands, d.UILoot, d.UITools, d.UITips, d.LootWindow, d.GuildBook
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
    return { engine = SK.engine, client = SK.client, commands = SK.commands, host = SK.host, player = SK.player, bagLinks = UITools.BagLinks }
end

M.SIZES = { 5, 10, 20, 40 }
M.size = 40
M.tab = "lists"
M.histKind, M.histText = "happened", ""

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
    -- You practise as your own class (a warrior is asked about warrior loot, not a priest's); a class the simulation doesn't know falls back to a priest.
    local class = SK.client.myClass and SK.client:myClass() or nil
    -- Loot: the gear in your bags and on your character, which the game really has (Molten Core's items aren't in this game yet). Molten Core's
    -- loot table is the fallback when there are too few pieces to make a raid of.
    local gear = M.GearItems(SK.client, M.GearLinks(), 24)
    local sim
    if #gear >= 3 then
        sim = Sim.NewPractice(gear, { learner = me, seed = 1, size = M.size, learnerClass = class })
        say(("Practice: the loot is %d pieces of gear from your bags and equipment, so it has real tooltips."):format(#gear))
    else
        sim = Sim.NewMoltenCore({ learner = me, seed = 1, size = M.size, learnerClass = class })
        say("Practice: you carry fewer than 3 pieces of gear, so the loot is Molten Core's (those items may not exist in this game yet, so no tooltips).")
    end
    sim.rankingRequired = true -- as in the game: someone who wants several items ranks them
    -- A simulated guild: the raid's players, and others who are not in the group (some offline).
    local guild = {}
    for _, m in ipairs(sim.client:roster()) do guild[#guild + 1] = { name = m.name, class = m.class } end
    local classes = { "WARRIOR", "MAGE", "ROGUE", "PRIEST", "HUNTER", "WARLOCK", "DRUID", "PALADIN", "SHAMAN" }
    for i, n in ipairs { "Oswin_Harrowgate", "Perrin_Dunholm", "Rook_Underhill", "Sabine_Valeheart", "Tamsin_Brightfield", "Ulric_Stormcrow", "Vesna_Ashmoor",
        "Wick_Thistledown", "Yorick_Greymantle", "Zora_Emberfall", "Alder_Quickwater", "Bexley_Holloway" } do
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
    M:OpenLoot()
end
function M:PracticeHandOut()
    local p = M.practice
    if p then p.sim:handOut(); M:OpenLoot() end
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

-- Lines for the output area: the newest few, each trimmed of the game's color codes.
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

local SORTS = { { "pos", "#" }, { "name", "Name" }, { "class", "Class" }, { "wins", "Wins" } }

local function setShown(frame, on) if on then frame:Show() else frame:Hide() end end

-- The Loot window: opened by a session starting, by /gambit window, and by the button on the main window.
function M:OpenLoot()
    if not (CreateFrame and UIParent) then return end
    if not self.lootWindow then
        local ok, f = pcall(LootWindow.Build, M)
        if not ok then error(f, 0) end
        self.lootWindow = f
    end
    self.lootWindow:Show()
    if self.lootWindow.Raise then self.lootWindow:Raise() end -- above the main window when it opens
    M:Refresh()
end

-- Put both windows back where they start, and forget where they were moved to.
function M:ResetWindows()
    local store = SK.char and SK.char.ui
    if store then store.main, store.loot = nil, nil end
    for _, f in ipairs({ self.window, self.lootWindow }) do
        if f and f.placeDefault then f.placeDefault() end
    end
end

function M:ToggleLoot()
    if self.lootWindow and self.lootWindow:IsShown() then self.lootWindow:Hide() else self:OpenLoot() end
end

-- Once a second, from whichever window is open: a practice raid's clock runs, and what is drawn is brought up to date (the ledger changes as other
-- players' updates arrive, a session's timer runs down).
function M:Tick()
    local now = GetTime and GetTime() or 0
    if now - (M.lastTick or 0) < 1 then return end
    M.lastTick = now
    if M.practice then M.practice.sim:advance(1) end
    M:Refresh()
end

function M:Refresh()
    local lw = self.lootWindow
    if lw and lw:IsShown() then LootWindow.Refresh(lw, M.Ctx(), M) end
    local w = self.window
    if not (w and w:IsShown()) then return end
    local ctx = M.Ctx()
    w.subtitle:SetText(M.practice and "|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r" or "")
    for _, s in ipairs(GuildBook.SECTIONS) do
        if w.nav and w.nav[s.id] then LootWindow.Mark(w.nav[s.id], M.tab == s.id) end
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
    for _, s in ipairs(GuildBook.SECTIONS) do setShown(w.pages[s.id], M.tab == s.id) end
    w.output:SetText(M.OutputText())
    local section = GuildBook.Section(M.tab)
    if section and section.actions then return UITools.Refresh(w.pages[M.tab], ctx, M) end
    if M.tab == "ledger" then return M.RefreshHistory(w.pages.ledger, ctx) end
    if M.tab == "stats" then return M.RefreshStats(w.pages.stats, ctx) end
    local p = w.pages.lists
    local model = M.Model(ctx.engine, ctx.client, self.list)
    self.list = model.list
    if not p.listDrop then p.listButton:SetText(model.list) end
    p.raidText:SetText(model.raid and ("Your raid plays on: " .. (model.raidList or "(no list chosen yet)")) or "No raid open for you")
    p.countText:SetText(("%d on the list"):format(model.total))
    for i, c in ipairs(SORTS) do
        p.headers[i].text:SetText(c[2] .. ((M.sortKey == c[1]) and (M.sortDesc and "  v" or "  ^") or ""))
    end
    if p.listDrop and p.shownList ~= model.list then p.shownList = model.list; p.listDrop:GenerateMenu() end
    -- the staged changes, kept to players still on the list; the table shows the list as it would be, and the places let Up and Down work out where to move someone
    local onList = {}
    M.baseOrder = {}
    for i, r in ipairs(model.rows) do onList[r.who] = r; M.baseOrder[i] = r.who end
    for i = #M.staged, 1, -1 do if not onList[M.staged[i].who] then table.remove(M.staged, i) end end
    local preview = M.Preview(model.rows)
    M.places = {}
    for _, r in ipairs(preview) do M.places[r.who] = r.shown or r.pos end
    local selectedRow = onList[M.selected]
    if not selectedRow then M.selected = nil end
    M.total = #preview
    M.FillRows(p, preview)
    local op = selectedRow and GuildBook.Staged(M.staged, selectedRow.who)
    p.selText:SetText(selectedRow and (op and ("Staged: " .. GuildBook.OpText(op))
        or ("Selected: " .. selectedRow.name .. "  (place " .. (M.places[selectedRow.who] or selectedRow.pos) .. " of " .. M.total .. ")"))
        or "Click a player in the list to act on them.")
    -- everyone sees the controls; only someone who may write can use them
    local may = model.mayWrite
    M.may = may
    setShown(p.hint, not may)
    setShown(p.pending, may)
    p.pending:SetText(GuildBook.PendingText(M.staged))
    if p.reason.SetEnabled then p.reason:SetEnabled(may) end
    for _, b in ipairs(p.actionButtons) do b:SetEnabled(may and selectedRow ~= nil) end
    p.apply:SetEnabled(may and #M.staged > 0); p.cancelMove:SetEnabled(may and #M.staged > 0)
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

local function classColor(class)
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
    row.cells[2]:SetText(classColor(r.class) .. r.name .. "|r" .. (r.mine and "  (you)" or "") .. (r.moving and ("  |cff66aaff(from " .. r.pos .. ")|r") or ""))
    row.cells[3]:SetText(className(r.class))
    row.cells[4]:SetText(tostring(r.wins))
end

-- Staged changes: nothing is written until they are applied (GuildBook has the model: a list of moves and removals, simulated for the preview).
M.staged = {}

-- The rows as they would be with the staged changes done (a moved player shown at their new place, marked as moving).
function M.Preview(rows) return GuildBook.Preview(rows, M.staged) end

-- Stage a move of the selected player to a place. A place they already hold clears an earlier staged move of theirs.
function M.Stage(to)
    local who = M.selected
    if not (who and M.places and M.places[who]) then return end
    GuildBook.StageMove(M.staged, M.baseOrder or {}, who, to)
    M:Refresh()
end

function M.StageRemove()
    local who = M.selected
    if not who then return end
    GuildBook.StageRemove(M.staged, who)
    M:Refresh()
end

function M.Discard() M.staged = {}; M:Refresh() end

-- Write the staged changes one after another, each with the one reason. If one is refused, the ones already written are no longer staged and the rest stay.
function M.ApplyStaged(reason)
    local cmds, problem = GuildBook.Commands(M.staged, reason)
    if not cmds then return M.Say(problem) end
    local ctx = M.Ctx()
    local done = 0
    for _, text in ipairs(cmds) do
        local before = #ctx.engine:View().applied
        M:Command(text)
        if #ctx.engine:View().applied <= before then
            for _ = 1, done do table.remove(M.staged, 1) end
            return M.Say(("Stopped after %d of %d: \"%s\" was not recorded (see above). The rest stay staged."):format(done, #cmds, text))
        end
        done = done + 1
    end
    M.staged = {}
    M.Say(("Applied %d change%s, each recorded with your reason."):format(done, done == 1 and "" or "s"))
    return true
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

-- ---- The Ledger section: the record in words -------------------------------------------------------------------------------------------------

local HIST_H = 20

local function stripColors(t) return (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end

-- An entry's sentence for the game: each person in their class color (the pieces GuildBook.Segments cut it into).
function M.ColoredText(e)
    if not e.segments then return stripColors(e.text) end
    local parts = {}
    for i, s in ipairs(e.segments) do
        if s.who then parts[i] = s.who.color and ("|cff" .. s.who.color .. s.who.name .. "|r") or s.who.name
        else parts[i] = stripColors(s.text) end
    end
    return table.concat(parts)
end

-- One entry on one line: when (muted) and what happened (a long sentence is cut off; the whole of it is in the tooltip).
function M.InitHistoryRow(row, e)
    row.entry = e
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then if M.ledgerSelected == e.id then row.hl:Show() else row.hl:Hide() end end
    if row.SetScript and not row.clickSet then
        row.clickSet = true
        -- a click selects the entry (its raw record is shown below); Ctrl-click tries its item on, as Ctrl-clicking an item link does
        row:SetScript("OnClick", function(self)
            if not self.entry then return end
            M.ledgerSelected = self.entry.id
            if IsControlKeyDown and IsControlKeyDown() and self.entry.item then M.TryOn(self.entry.item) end
            M:Refresh()
        end)
    end
    if not row.cells then
        row.when = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.when:SetPoint("LEFT", 4, 0); row.when:SetWidth(72); row.when:SetJustifyH("LEFT"); row.when:SetWordWrap(false)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.text:SetPoint("LEFT", 80, 0); row.text:SetWidth(310); row.text:SetJustifyH("LEFT"); row.text:SetWordWrap(false)
        row.cells = true
        if row.SetScript then
            row:SetScript("OnEnter", function(self)
                if GameTooltip and self.entry then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    -- an entry about an item shows the item (its own tooltip), with how to try it on; any other shows its sentence in full
                    if self.entry.item and GameTooltip.SetHyperlink and pcall(GameTooltip.SetHyperlink, GameTooltip, self.entry.item) then
                        GameTooltip:AddLine(" "); GameTooltip:AddLine("Ctrl-click to try it on.", 0.6, 0.6, 0.6)
                    else
                        GameTooltip:SetText(self.entry.text, 1, 1, 1, 1, true)
                    end
                    GameTooltip:Show()
                end
            end)
            row:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
        end
    end
    row.when:SetText(e.when or "")
    row.text:SetText(M.ColoredText(e))
end

function M:BuildHistory(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    local lbl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("TOPLEFT", 4, 0); lbl:SetText("Show:")
    local okDrop, drop = pcall(CreateFrame, "DropdownButton", nil, p, "WowStyle1DropdownTemplate")
    if okDrop and drop then
        drop:SetWidth(130)
        drop:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        drop:SetupMenu(function(_, root)
            for _, k in ipairs(GuildBook.KINDS) do
                root:CreateRadio(k.label, function() return M.histKind == k.id end, function() M.histKind = k.id; M:Refresh() end)
            end
        end)
        p.kindDrop = drop
        p.kindButton = drop
    else
        p.kindButton = button(p, "Everything", 120)
        p.kindButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        p.kindButton:SetScript("OnClick", function()
            local kinds = GuildBook.KINDS
            for i, k in ipairs(kinds) do
                if k.id == M.histKind then M.histKind = kinds[i % #kinds + 1].id; break end
            end
            M:Refresh()
        end)
    end
    Tips.Attach(p.kindButton, "historykind")
    local fl = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fl:SetPoint("LEFT", p.kindButton, "RIGHT", 16, 0); fl:SetText("Find:")
    p.find = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.find:SetSize(120, 20); p.find:SetPoint("LEFT", fl, "RIGHT", 10, 0); p.find:SetAutoFocus(false)
    p.find:SetScript("OnTextChanged", function(self, user)
        if user then M.histText = self:GetText() or ""; M:Refresh() end
    end)
    Tips.Attach(p.find, "historyfind")

    -- The selected entry as the raw record, under the list.
    p.detailTitle = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.detailTitle:SetPoint("BOTTOMLEFT", 4, 112); p.detailTitle:SetText("Selected entry")
    p.tryOn = button(p, "Try it on", 80, 20)
    p.tryOn:SetPoint("BOTTOMRIGHT", -6, 108)
    p.tryOn:SetScript("OnClick", function() M.TryOn(p.tryOnItem) end)
    Tips.Attach(p.tryOn, "tryon")
    p.tryOn:Hide()
    p.detail = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.detail:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 4, 108); p.detail:SetWidth(390); p.detail:SetHeight(104)
    p.detail:SetJustifyH("LEFT"); p.detail:SetJustifyV("TOP"); p.detail:SetWordWrap(true)
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then inset:SetPoint("TOPLEFT", -2, -28); inset:SetPoint("BOTTOMRIGHT", 2, 132) end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -32)
        box:SetPoint("BOTTOMRIGHT", -22, 136)
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
        scroll:SetPoint("TOPLEFT", 4, -32); scroll:SetPoint("BOTTOMRIGHT", -26, 136)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(380, 1)
        scroll:SetScrollChild(p.child)
        p.lines = {}
    end
    p.countText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.countText:SetPoint("BOTTOMRIGHT", -6, 4)
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -50); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    return p
end

-- Show an item on this character in the game's dressing room (a link, or "item:ID"). Nothing is equipped or recorded.
function M.TryOn(item)
    if not item then return false end
    local fn = DressUpItemLink or DressUpLink
    if not fn then M.Say("This game can't open the dressing room from here."); return false end
    local ok = pcall(fn, item)
    if not ok and DressUpLink and fn ~= DressUpLink then ok = pcall(DressUpLink, item) end
    return ok
end

-- The selected entry's details as text: each field's name in gold, its value after it.
function M.DetailText(lines)
    local parts = {}
    for i, l in ipairs(lines) do
        if i > 9 then parts[#parts + 1] = "|cff999999...|r"; break end
        parts[i] = ("|cffffd100%s:|r %s"):format(l.label, (l.value:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))) end
    return table.concat(parts, "\n")
end

-- Fill the Ledger page from the ledger (newest first).
function M.RefreshHistory(p, ctx)
    local h = GuildBook.History(ctx, { kind = M.histKind, text = M.histText, limit = 300 })
    local label = "Everything"
    for _, k in ipairs(GuildBook.KINDS) do if k.id == M.histKind then label = k.label end end
    if p.kindDrop then
        if p.shownKind ~= M.histKind then p.shownKind = M.histKind; p.kindDrop:GenerateMenu() end
    else
        p.kindButton:SetText(label)
    end
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
    local detail, item
    if M.ledgerSelected then detail, item = GuildBook.Detail(ctx, M.ledgerSelected) end
    if not detail then M.ledgerSelected = nil end
    p.tryOnItem = item
    setShown(p.tryOn, item ~= nil)
    p.detail:SetText(detail and M.DetailText(detail) or "Click an entry to see exactly what was written: who wrote it, when, its id and every field.")
    p.countText:SetText(h.total > h.shown and ("Showing the newest %d of %d"):format(h.shown, h.total) or ("%d entries"):format(h.total))
    if h.empty then p.message:SetText(h.empty); p.message:Show() else p.message:Hide() end
end

-- ---- The Stats section: who held which place for how long ----------------------------------------------------------------------------

local STAT_X, STAT_W = { 4, 30, 148, 226, 262, 346 }, { 24, 116, 76, 32, 80, 64 }

function M.InitStatsRow(row, r)
    row.stat = r
    if not row.hl and row.CreateTexture then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints()
        row.hl:SetColorTexture(1, 0.82, 0, 0.2)
    end
    if row.hl then if M.statsSelected == r.who then row.hl:Show() else row.hl:Hide() end end
    if row.SetScript and not row.clickSet then
        row.clickSet = true
        row:SetScript("OnClick", function(self) if self.stat then M.statsSelected = self.stat.who; M:Refresh() end end)
    end
    if not row.cells then
        row.cells = {}
        for c = 1, 6 do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            fs:SetPoint("LEFT", STAT_X[c], 0)
            fs:SetJustifyH("LEFT"); fs:SetWordWrap(false); fs:SetWidth(STAT_W[c])
            row.cells[c] = fs
        end
    end
    row.cells[1]:SetText(tostring(r.place))
    row.cells[2]:SetText(classColor(r.class) .. r.name .. "|r" .. (r.mine and "  (you)" or ""))
    row.cells[3]:SetText(r.heldText or "")
    row.cells[4]:SetText(tostring(r.wins))
    row.cells[5]:SetText(r.lastWinText or "")
    row.cells[6]:SetText(r.raidsText or "")
end

function M:BuildStats(parent)
    local p = CreateFrame("Frame", nil, parent)
    p:SetAllPoints()
    p.listText = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    p.listText:SetPoint("TOPLEFT", 4, 0)
    p.summary = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.summary:SetPoint("TOPLEFT", 4, -20); p.summary:SetWidth(410); p.summary:SetHeight(40)
    p.summary:SetJustifyH("LEFT"); p.summary:SetJustifyV("TOP"); p.summary:SetWordWrap(true)
    local heads = { "#", "Player", "At this place", "Wins", "Last win", "Raids" }
    for i, h in ipairs(heads) do
        local fs = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("TOPLEFT", STAT_X[i] + 4, -64); fs:SetText(h)
    end
    p.detailTitle = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.detailTitle:SetPoint("BOTTOMLEFT", 4, 112); p.detailTitle:SetText("Places held")
    p.detail = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.detail:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 4, 108); p.detail:SetWidth(410); p.detail:SetHeight(104)
    p.detail:SetJustifyH("LEFT"); p.detail:SetJustifyV("TOP"); p.detail:SetWordWrap(true)
    local okInset, inset = pcall(CreateFrame, "Frame", nil, p, "InsetFrameTemplate")
    if okInset and inset then inset:SetPoint("TOPLEFT", -2, -76); inset:SetPoint("BOTTOMRIGHT", 2, 132) end
    local okBox = pcall(function()
        local box = CreateFrame("Frame", nil, p, "WowScrollBoxList")
        local bar = CreateFrame("EventFrame", nil, p, "MinimalScrollBar")
        box:SetPoint("TOPLEFT", 4, -80)
        box:SetPoint("BOTTOMRIGHT", -22, 136)
        bar:SetPoint("TOPLEFT", box, "TOPRIGHT", 4, -2)
        bar:SetPoint("BOTTOMLEFT", box, "BOTTOMRIGHT", 4, 2)
        local view = CreateScrollBoxListLinearView()
        view:SetElementExtent(HIST_H)
        view:SetElementInitializer("Button", M.InitStatsRow)
        ScrollUtil.InitScrollBoxListWithScrollBar(box, bar, view)
        p.scrollBox = box
    end)
    if not okBox then
        local scroll = CreateFrame("ScrollFrame", nil, p)
        scroll:SetPoint("TOPLEFT", 4, -80); scroll:SetPoint("BOTTOMRIGHT", -26, 136)
        p.child = CreateFrame("Frame", nil, scroll)
        p.child:SetSize(380, 1)
        scroll:SetScrollChild(p.child)
        p.lines = {}
    end
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 14, -96); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()
    return p
end

function M.RefreshStats(p, ctx)
    local listId = M.list or ctx.engine:RaidList() or "main"
    local stats = GuildBook.Stats(ctx, listId)
    local me = ctx.client:me()
    for _, r in ipairs(stats.rows) do r.mine = r.who == me end
    p.listText:SetText(("List: %s"):format(listId))
    p.summary:SetText(table.concat(stats.summary, "\n"))
    if p.scrollBox then
        local data = CreateDataProvider()
        for _, r in ipairs(stats.rows) do data:Insert(r) end
        p.scrollBox:SetDataProvider(data, ScrollBoxConstants and ScrollBoxConstants.RetainScrollPosition)
    else
        for i, r in ipairs(stats.rows) do
            local line = p.lines[i]
            if not line then
                line = CreateFrame("Button", nil, p.child)
                line:SetSize(380, HIST_H); line:SetPoint("TOPLEFT", 0, -(i - 1) * HIST_H)
                p.lines[i] = line
            end
            M.InitStatsRow(line, r); line:Show()
        end
        for i = #stats.rows + 1, #p.lines do p.lines[i]:Hide() end
        p.child:SetHeight(math.max(#stats.rows * HIST_H, 1))
    end
    local who = M.statsSelected
    local known
    for _, r in ipairs(stats.rows) do if r.who == who then known = r end end
    if not known then M.statsSelected, who = nil, nil end
    if who then
        local lines = { ("|cffffd100%s|r: place %d of %d"):format(known.name, known.place, stats.total) }
        local a = stats.attendance.byPlayer[who]
        if stats.attendance.total > 0 then
            lines[#lines + 1] = ("Raids: %d of %d, in the raid %d%% of the time%s"):format(a and a.attended or 0, stats.attendance.total, a and a.percent or 0,
                (a and a.leftEarly > 0) and (", left early %d time%s"):format(a.leftEarly, a.leftEarly == 1 and "" or "s") or "")
        end
        for i, h in ipairs(GuildBook.PlaceHistory(stats, who)) do
            if #lines > 8 then lines[#lines + 1] = "|cff999999...|r"; break end
            lines[#lines + 1] = h.text
        end
        p.detail:SetText(table.concat(lines, "\n"))
    else
        p.detail:SetText("Click a player to see every place they have held, and for how long.")
    end
    if #stats.rows == 0 then p.message:SetText("Nobody is on this list yet."); p.message:Show() else p.message:Hide() end
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
        inset:SetPoint("TOPLEFT", -2, -26); inset:SetPoint("BOTTOMRIGHT", 2, 160)
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
        box:SetPoint("BOTTOMRIGHT", -22, 164)
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
        scroll:SetPoint("BOTTOMRIGHT", -26, 164)
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

    -- Act on the player selected above. Changes are STAGED (a preview in the table); several can be stacked, and Apply all writes them one after another
    -- with one reason (the reason goes in the record with each).
    p.selText = p:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    p.selText:SetPoint("BOTTOMLEFT", 6, 134); p.selText:SetWidth(270); p.selText:SetJustifyH("LEFT"); p.selText:SetWordWrap(false)
    -- Someone who may not change the list (not an officer, and not the raid's Master Looter) still sees the buttons, grayed out, and this line saying why.
    p.hint = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.hint:SetPoint("BOTTOMLEFT", 6, 74); p.hint:SetWidth(410); p.hint:SetJustifyH("LEFT"); p.hint:SetWordWrap(false)
    p.hint:SetText("|cffff8040You can't change the list: only officers, and a raid's Master Looter, can. Ask via Rules (Request a list change).|r")
    p.actionButtons = {}
    local function stageBy(delta)
        local who = M.selected
        local place = who and M.places and M.places[who]
        if not place then return end
        M.Stage(place + delta)
    end
    -- Top, Up, Down, Bottom, Remove and the place box only stage (a preview); Apply all records them.
    local ACTIONS = {
        { "Top", function() M.Stage(1) end }, { "Up", function() stageBy(-1) end }, { "Down", function() stageBy(1) end },
        { "Bottom", function() M.Stage(M.total or 1) end },
        { "Remove", function() M.StageRemove() end },
        { "Award...", function() if M.selected then M.OpenTool("award", M.selected) end end },
    }
    for i, a in ipairs(ACTIONS) do
        local b = button(p, a[1], 56, 22)
        b:SetPoint("BOTTOMLEFT", 6 + (i - 1) * 60, 104)
        b:SetScript("OnClick", a[2])
        Tips.Attach(b, ({ "top", "up", "down", "bottom", "remove", "award" })[i], function()
            if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
            if not M.selected then return "Select a player in the list first." end
        end)
        p.actionButtons[i] = b
    end
    -- Where to: a place number (or drag a player onto a row).
    local pl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    pl:SetPoint("BOTTOMLEFT", 284, 138); pl:SetText("To place:")
    p.placeBox = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.placeBox:SetSize(30, 20); p.placeBox:SetPoint("BOTTOMLEFT", 340, 132); p.placeBox:SetAutoFocus(false); p.placeBox:SetMaxLetters(3)
    p.setPlace = button(p, "Set", 40, 22)
    p.setPlace:SetPoint("BOTTOMLEFT", 376, 131)
    p.setPlace:SetScript("OnClick", function()
        local n = tonumber(p.placeBox:GetText())
        if n then M.Stage(n); p.placeBox:SetText("") end
    end)
    -- The pending changes, then the one reason and the buttons that write or drop them.
    p.pending = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.pending:SetPoint("BOTTOMLEFT", 6, 74); p.pending:SetWidth(410); p.pending:SetHeight(26); p.pending:SetJustifyH("LEFT"); p.pending:SetJustifyV("TOP")
    if p.pending.SetMaxLines then p.pending:SetMaxLines(2) end
    local rl = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    rl:SetPoint("BOTTOMLEFT", 6, 52); rl:SetText("Reason:")
    p.barLabel = rl
    p.reason = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    p.reason:SetSize(190, 20); p.reason:SetPoint("BOTTOMLEFT", 56, 48); p.reason:SetAutoFocus(false)
    p.apply = button(p, "Apply all", 76, 22)
    p.apply:SetPoint("BOTTOMLEFT", 262, 47)
    p.apply:SetScript("OnClick", function()
        if M.ApplyStaged(p.reason:GetText()) then p.reason:SetText("") end
    end)
    p.cancelMove = button(p, "Discard", 70, 22)
    p.cancelMove:SetPoint("BOTTOMLEFT", 342, 47)
    p.cancelMove:SetScript("OnClick", function() M.Discard() end)
    local why = function()
        if M.may == false then return "You can't use this: only officers, and a raid's Master Looter, can change the list." end
    end
    Tips.Attach(p.placeBox, "place"); Tips.Attach(p.setPlace, "place", why)
    Tips.Attach(p.apply, "apply", function() return why() or (#M.staged == 0 and "Nothing is staged: move or remove a player first.") or nil end)
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
    w:SetSize(580, 640)
    w:SetFrameStrata("DIALOG")
    LootWindow.Movable(w, "main", { "CENTER", 0, 0 })
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

    -- The Loot window opens by itself when a session starts; this brings it back, or shows it between sessions.
    w.lootButton = button(w, "Loot window", 96)
    w.lootButton:SetPoint("TOPRIGHT", -16, -48)
    w.lootButton:SetScript("OnClick", function() M:ToggleLoot() end)
    Tips.Attach(w.lootButton, "lootwindow")

    -- The navigation column: one pushed-in button per section, as the game's own micro-menu shows what is open. A thin line separates it from the section.
    w.nav = {}
    local navY = -112
    for i, s in ipairs(GuildBook.SECTIONS) do
        local b = button(w, s.label, 108, 28)
        navY = navY - (s.gap and 16 or 0)
        b:SetPoint("TOPLEFT", 16, navY)
        navY = navY - 36
        b:SetScript("OnClick", function() M.tab = s.id; M:Refresh() end)
        Tips.Attach(b, "nav" .. s.id)
        w.nav[s.id] = b
    end
    local line = w:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 1, 1, 0.12)
    line:SetWidth(1)
    line:SetPoint("TOPLEFT", 132, -112); line:SetPoint("BOTTOMLEFT", 132, 92)
    local content = CreateFrame("Frame", nil, w)
    content:SetPoint("TOPLEFT", 144, -112)
    content:SetPoint("BOTTOMRIGHT", -16, 92)
    w.pages = { lists = M:BuildStandings(content), ledger = M:BuildHistory(content), stats = M:BuildStats(content) }
    for _, s in ipairs(GuildBook.SECTIONS) do
        if s.actions then w.pages[s.id] = UITools.Build(content, M, s) end
    end
    -- Output: what the last command said (a refusal says why), so nobody has to watch the chat window.
    w.output = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.output:SetPoint("BOTTOMLEFT", 144, 18); w.output:SetWidth(420); w.output:SetHeight(66)
    w.output:SetJustifyH("LEFT"); w.output:SetJustifyV("TOP"); w.output:SetWordWrap(true)

    -- Keep it current while it is open: the ledger changes as other players' updates arrive, and a practice raid's clock runs.
    w:SetScript("OnUpdate", function() M:Tick() end)
    w:SetScript("OnShow", function() M:Refresh() end)
    -- Escape closes it.
    if UISpecialFrames then table.insert(UISpecialFrames, "KingsGambitWindow") end
    w:Hide()
    self.window = w
    return w
end

-- Build the window once; if it fails part-way the half-built frame is hidden and the error is passed on.
-- Open a form in the section that holds it (Awards, Raids, ...) with the selected player filled in.
function M.OpenTool(actionId, who)
    local w = M:Window()
    local section = GuildBook.SectionOf(actionId)
    if not section then return end
    M.tab = section.id
    UITools.Goto(w.pages[section.id], M, actionId, who)
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
    if tab == "loot" then return self:OpenLoot() end
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
