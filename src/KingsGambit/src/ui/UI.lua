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
local Identity, Sim, Commands, UILoot, UITools, Tips, LootWindow, GuildBook, Scenarios, Skin
local installParts -- defined at the end of the file: most of the window's code is in ui/panes/ (one file per pane)
local M = SK:NewModule("UI", { "Identity", "Sim?", "Commands?", "UILoot", "UITools", "UITips", "LootWindow", "GuildBook", "Scenarios?", "UISkin?",
    "UIPractice", "UIStandings", "UILedger", "UIRaidPanes", "UIStats", "UIWelcome" }, function(d)
    Identity, Sim, Commands, UILoot, UITools, Tips, LootWindow, GuildBook, Scenarios, Skin = d.Identity, d.Sim, d.Commands, d.UILoot, d.UITools, d.UITips, d.LootWindow, d.GuildBook, d.Scenarios, d.UISkin
    installParts(d)
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
    return { engine = SK.engine, client = SK.client, commands = SK.commands, host = SK.host, player = SK.player, bagLinks = UITools.BagLinks, attendance = SK.attendance,
        autoSpec = M.AutoSpec }
end

-- The practice lessons are the web page's tutorials (Scenarios), played in the game: M.lesson is the one chosen (nil: a raid night on your own gear).
function M.Lessons() return (Scenarios and Scenarios.list) or {} end
function M.LessonIndex(id)
    for i, sc in ipairs(M.Lessons()) do if sc.id == id then return i end end
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

-- Is this character in the middle of a real raid? Returns why, or nil. Practice is off then: it would hide the real loot window and the real list, and what
-- is practised could be mistaken for what is real.
function M.RealRaidBusy()
    local client, engine = SK.client, SK.engine
    if not client then return nil end
    if client:inRaid() then return "you are in a raid group" end
    local host, player = SK.host, SK.player
    if host and host.session and host.session.phase ~= "done" and host.session.phase ~= "cancelled" then return "a loot session is running" end
    if player and player.session then return "a loot session is running" end
    if engine then
        local me = client:me()
        for _, r in ipairs(engine:ActiveRaids()) do
            if r.ml == me then return "your raid is open (end it first: raid close)" end
        end
    end
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
    -- (a lesson's clock waits until it is started: read it first)
    if M.practice and not (M.practice.sim.lesson and not M.practice.sim.lessonStarted) then M.practice.sim:advance(1) end
    M:Refresh()
end

function M:Refresh()
    local lw = self.lootWindow
    if lw and lw:IsShown() then LootWindow.Refresh(lw, M.Ctx(), M) end
    local w = self.window
    if not (w and w:IsShown()) then return end
    local ctx = M.Ctx()
    local guild = (not M.practice) and ctx.client.guildName and ctx.client:guildName()
    w.subtitle:SetText(M.practice and "|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r"
        or (guild and ("|cffaaaaaaLedger of the guild |r" .. guild) or "|cffaaaaaaYour own ledger (you are not in a guild)|r"))
    for _, s in ipairs(GuildBook.SECTIONS) do
        if w.nav and w.nav[s.id] then LootWindow.Mark(w.nav[s.id], M.tab == s.id) end
    end
    if w.practiceCheck then w.practiceCheck:SetChecked(M.practice ~= nil) end
    if w.practiceButton then w.practiceButton:SetText(M.practice and "Leave practice" or "Practice mode") end
    -- The group size and the lesson only mean something inside practice mode (a lesson has a raid of its own).
    setShown(w.sizeButton, M.practice ~= nil and not M.lesson)
    setShown(w.lessonButton, M.practice ~= nil)
    if w.whisperButton then
        setShown(w.whisperButton, M.practice ~= nil)
        w.whisperButton:SetText((M.practice and M.practice.whisperMode) and "Play with the addon" or "Play without the addon")
    end
    if w.lessonButton then
        if w.lessonButton.GenerateMenu then
            if w.shownLesson ~= (M.lesson or "") then w.shownLesson = M.lesson or ""; w.lessonButton:GenerateMenu() end
        else
            local i = M.lesson and M.LessonIndex(M.lesson)
            w.lessonButton:SetText(i and ("Lesson " .. i) or "Raid night")
        end
    end
    if w.sizeButton.GenerateMenu then
        if w.shownSize ~= M.size then w.shownSize = M.size; w.sizeButton:GenerateMenu() end
    else
        w.sizeButton:SetText("Practice group: " .. M.size)
    end
    for _, s in ipairs(GuildBook.SECTIONS) do setShown(w.pages[s.id], M.tab == s.id) end
    w.output:SetText(M.OutputText())
    local section = GuildBook.Section(M.tab)
    if section and section.actions then
        UITools.Refresh(w.pages[M.tab], ctx, M)
        if M.tab == "raids" then M.RefreshRaidStart(w.pages.raids, ctx) end
        if M.tab == "admin" then M.RefreshLedgers(w.pages.admin, ctx) end
        return
    end
    if M.tab == "welcome" then return M.RefreshWelcome(w.pages.welcome) end
    if M.tab == "ledger" then return M.RefreshHistory(w.pages.ledger, ctx) end
    if M.tab == "stats" then return M.RefreshStats(w.pages.stats, ctx) end
    if M.tab == "thisraid" then return M.RefreshThisRaid(w.pages.thisraid, ctx) end
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
            or "No lists yet. The ledger owner starts the ledger with the button below.")
        p.message:Show()
    else
        p.message:Hide()
    end
end

local function button(parent, text, w, h)
    if Skin then return Skin.Button(parent, text, w, h) end
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
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

    -- Which practice: a raid night on your own gear (the default), or one of the lessons from the web page (a set raid, a set drop, what should happen).
    local okLesson, lessonDrop = pcall(CreateFrame, "DropdownButton", nil, w, "WowStyle1DropdownTemplate")
    if okLesson and lessonDrop then
        lessonDrop:SetWidth(150)
        lessonDrop:SetPoint("TOPLEFT", 306, -48)
        lessonDrop:SetupMenu(function(_, root)
            root:CreateRadio("Raid night (your gear)", function() return M.lesson == nil end, function() M:ChooseLesson(nil) end)
            for i, sc in ipairs(M.Lessons()) do
                root:CreateRadio(("%d. %s"):format(i, sc.title), function() return M.lesson == sc.id end, function() M:ChooseLesson(sc.id) end)
            end
        end)
        w.lessonButton = lessonDrop
    else
        w.lessonButton = button(w, "Raid night", 150)
        w.lessonButton:SetPoint("TOPLEFT", 306, -48)
        w.lessonButton:SetScript("OnClick", function()
            local list = M.Lessons()
            local i = M.lesson and M.LessonIndex(M.lesson) or 0
            M:ChooseLesson(list[i + 1] and list[i + 1].id or nil)
        end)
    end
    Tips.Attach(w.lessonButton, "practicelesson")

    -- Practice as a raider who has no addon: whispers instead of buttons.
    w.whisperButton = button(w, "Play without the addon", 200)
    w.whisperButton:SetPoint("TOPLEFT", 16, -78)
    w.whisperButton:SetScript("OnClick", function() M:SetWhisperMode(not (M.practice and M.practice.whisperMode)) end)
    Tips.Attach(w.whisperButton, "whispermode")

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
    w.pages = { lists = M:BuildStandings(content), ledger = M:BuildHistory(content), stats = M:BuildStats(content), thisraid = M:BuildThisRaid(content), welcome = M:BuildWelcome(content) }
    for _, s in ipairs(GuildBook.SECTIONS) do
        if s.actions then
            w.pages[s.id] = UITools.Build(content, M, s)
            if s.id == "raids" then M.BuildRaidStart(w.pages.raids) end
            if s.id == "admin" then M.BuildLedgers(w.pages.admin) end
        end
    end
    -- Output: what the last command said (a refusal says why), so nobody has to watch the chat window.
    w.output = w:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    w.output:SetPoint("BOTTOMLEFT", 144, 34); w.output:SetWidth(420); w.output:SetHeight(50)
    w.output:SetJustifyH("LEFT"); w.output:SetJustifyV("TOP"); w.output:SetWordWrap(true)

    -- Keep it current while it is open: the ledger changes as other players' updates arrive, and a practice raid's clock runs.
    w:SetScript("OnUpdate", function() M:Tick() end)
    w:SetScript("OnShow", function() M:Refresh() end)
    w:SetScript("OnHide", function() GuildBook.RememberTab(SK.char, M.tab) end) -- (the section it was on, for next time)
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
    if w:IsShown() then w:Hide()
    else
        -- /gambit opens on Welcome while that is on, else on the section it was closed on
        M.tab = GuildBook.StartTab(SK.client and SK.client.storage and SK.client:storage().shared, SK.char)
        w:Show()
    end
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
    -- A real session or a real raid group while practising ends practice: the window must show the real thing, never the rehearsal.
    local function endPractice(why)
        if M.practice then say("Practice ended: " .. why .. "."); M:LeavePractice() end
    end
    local function opener() endPractice("a real loot session has started"); M:Open("loot") end
    if SK.player and SK.player.on then SK.player.on("session", opener) end
    if SK.host and SK.host.on then
        SK.host.on("phase", function(p) if p == "bidding" or (type(p) == "table" and p.phase == "bidding") then opener() end end)
    end
    if SK.client and SK.client.on then
        SK.client:on("roster.changed", function() if M.practice and SK.client:inRaid() then endPractice("you joined a raid") end end)
    end
end

-- Add the panes' functions to M (once every module is loaded: see Registry.lua), handing them the helpers they share. The order is the order of the
-- panes' needs: UILedger before the panes that use its row height, UIStandings before the Stats pane.
function installParts(d)
    local h = { SORTS = SORTS, button = button, nextList = nextList, say = say, setShown = setShown }
    d.UIPractice.Install(M, h)
    d.UIStandings.Install(M, h)
    d.UILedger.Install(M, h)
    d.UIRaidPanes.Install(M, h)
    d.UIStats.Install(M, h)
    d.UIWelcome.Install(M, h)
end
