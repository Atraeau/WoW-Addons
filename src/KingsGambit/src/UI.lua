-- King's Gambit: the window. `/gambit` with nothing after it opens it (design journal: "/gambit opens a window").
-- Tabs: Standings, Loot (the running session: answer, draft, and the Master Looter's controls). More tabs follow (officers, guild master).
-- Keep this file Lua 5.1-safe. Every button runs the same command a player would type, so the rules, the messages and the ledger are
-- exactly the same as with commands.
--
-- Two halves, so most of it can be tested without the game:
--   M.Model(engine, client, listId, page)  pure: what the Standings tab shows (rows, paging, lists, the raid and its list)
--   M:Toggle() / M:Refresh()               the frames, built the first time they are needed (game only)
local _, SK = ...
local Identity, Sim, Commands, UILoot
local M = SK:NewModule("UI", { "Identity", "Sim?", "Commands?", "UILoot" }, function(d)
    Identity, Sim, Commands, UILoot = d.Identity, d.Sim, d.Commands, d.UILoot
end)

local ROWS = 14

-- What the window shows for one list. listId nil = the list the viewer's raid plays on, else main.
function M.Model(engine, client, listId, page)
    local lists = engine:Lists()
    local raidList, raid = engine:RaidList()
    local id = listId or raidList or "main"
    local model = { missing = 0, lists = lists, list = id, raid = raid, raidList = raidList, me = client:me(), rows = {}, page = 1, pages = 1, total = 0 }
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
    model.pages = math.max(1, math.ceil(#order / ROWS))
    model.page = math.min(math.max(page or 1, 1), model.pages)
    for i = (model.page - 1) * ROWS + 1, math.min(#order, model.page * ROWS) do
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

function M:StartPractice()
    if not (Sim and Commands) then return end
    local me = SK.client:me()
    local sim = Sim.NewMoltenCore({ learner = me, seed = 1, size = M.size })
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
    M.list, M.page = nil, 1
    M:Refresh()
end

function M:LeavePractice()
    M.practice = nil
    M.list, M.page = nil, 1
    M:Refresh()
end

-- Practice: the next boss dies and its loot goes up (the simulated raiders answer on their own), the held loot is handed out, time passes.
function M:PracticeKill()
    local p = M.practice
    if not p then return end
    local s = p.sim.session
    if s and s.phase ~= "done" and s.phase ~= "cancelled" then return SK:Print("Practice: finish handing out the current loot first.") end
    local boss, _, why = p.sim:killBoss(nil, false)
    if not boss then return SK:Print("Practice: there are no more bosses.") end
    if why then SK:Print("Practice: " .. tostring(why)) end
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

-- A button runs the same command a player would type; the answer is printed in chat as always.
function M:Command(text)
    M.Ctx().commands.handle(text)
    M:Refresh()
end

local function nextList(lists, current)
    for i, id in ipairs(lists) do
        if id == current then return lists[i % #lists + 1] end
    end
    return lists[1]
end

local TABS = { { "standings", "Standings" }, { "loot", "Loot" } }

local function setShown(frame, on) if on then frame:Show() else frame:Hide() end end

function M:Refresh()
    local w = self.window
    if not (w and w:IsShown()) then return end
    local ctx = M.Ctx()
    w.subtitle:SetText(M.practice and "|cffffaa00PRACTICE: a simulated raid. Nothing here is recorded or sent.|r" or "")
    w.practiceButton:SetText(M.practice and "Leave practice" or "Practice")
    w.sizeButton:SetText((M.practice and "Group: " or "Practice with: ") .. M.size)
    for _, t in ipairs(TABS) do
        w.tabButtons[t[1]]:SetEnabled(M.tab ~= t[1])
        setShown(w.pages[t[1]], M.tab == t[1])
    end
    if M.tab == "loot" then return UILoot.Refresh(w.pages.loot, ctx, M) end
    local p = w.pages.standings
    local model = M.Model(ctx.engine, ctx.client, self.list, self.page)
    self.list, self.page = model.list, model.page
    p.listButton:SetText(model.list)
    p.raidText:SetText(model.raid and ("Your raid plays on: " .. (model.raidList or "(no list chosen yet)")) or "No raid open for you")
    p.pageText:SetText(("Page %d of %d  (%d on the list)"):format(model.page, model.pages, model.total))
    for i = 1, ROWS do
        local row, r = p.rows[i], model.rows[i]
        if r then
            row:SetText(("%2d.  %s%s    wins %d"):format(r.pos, r.name, r.mine and "   <- you" or "", r.wins))
            row:Show()
        else
            row:Hide()
        end
    end
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
    p.listButton = button(p, "main", 120)
    p.listButton:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
    p.listButton:SetScript("OnClick", function()
        local e = M.Ctx().engine
        M.list = nextList(e:Lists(), M.list or e:RaidList() or "main"); M.page = 1; M:Refresh()
    end)
    p.raidText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.raidText:SetPoint("LEFT", p.listButton, "RIGHT", 10, 0)

    p.rows = {}
    for i = 1, ROWS do
        local f = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        f:SetPoint("TOPLEFT", 8, -34 - (i - 1) * 22)
        f:SetJustifyH("LEFT"); f:SetWidth(360); f:SetWordWrap(false)
        p.rows[i] = f
    end
    p.message = p:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.message:SetPoint("TOPLEFT", 8, -34); p.message:SetWidth(360); p.message:SetJustifyH("LEFT"); p.message:Hide()

    -- First run: the guild master founds the ledger (the same as `create main`; the ledger records who did it as the guild master).
    p.startButton = button(p, "Start the ledger", 160, 26)
    p.startButton:SetPoint("TOP", 0, -90)
    p.startButton:SetScript("OnClick", function() M:Command("create main Main"); M.list = "main"; M:Refresh() end)
    p.startButton:Hide()

    -- Fill the list from the group and the guild: the same as `addall`.
    p.addAllButton = button(p, "Add from your group and guild", 260, 24)
    p.addAllButton:SetPoint("BOTTOMLEFT", 4, 30)
    p.addAllButton:SetScript("OnClick", function() M:Command("addall") end)

    local prev, nxt = button(p, "<", 30), button(p, ">", 30)
    prev:SetPoint("BOTTOMLEFT", 4, 2); nxt:SetPoint("LEFT", prev, "RIGHT", 4, 0)
    p.pageText = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.pageText:SetPoint("LEFT", nxt, "RIGHT", 10, 0)
    prev:SetScript("OnClick", function() M.page = (M.page or 1) - 1; M:Refresh() end)
    nxt:SetScript("OnClick", function() M.page = (M.page or 1) + 1; M:Refresh() end)
    return p
end

function M:Build()
    -- BasicFrameTemplateWithInset gives a title bar and close button; fall back to a plain frame if this client lacks it.
    local ok, w = pcall(CreateFrame, "Frame", "KingsGambitWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not w then w = CreateFrame("Frame", "KingsGambitWindow", UIParent) end
    w:SetSize(420, 600)
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

    w.practiceButton = button(w, "Practice", 110)
    w.practiceButton:SetPoint("TOPLEFT", 16, -50)
    w.practiceButton:SetScript("OnClick", function()
        if M.practice then M:LeavePractice() else M:StartPractice() end
    end)
    -- How many players the simulated group has (a 5-player party up to a 40-player raid). Changing it restarts practice.
    w.sizeButton = button(w, "Group: 40", 170)
    w.sizeButton:SetPoint("LEFT", w.practiceButton, "RIGHT", 6, 0)
    w.sizeButton:SetScript("OnClick", function()
        for i, n in ipairs(M.SIZES) do
            if n == M.size then M.size = M.SIZES[i % #M.SIZES + 1]; break end
        end
        if M.practice then M:StartPractice() else M:Refresh() end
    end)

    w.tabButtons = {}
    for i, t in ipairs(TABS) do
        local b = button(w, t[2], 100, 24)
        b:SetPoint("TOPLEFT", 16 + (i - 1) * 104, -80)
        b:SetScript("OnClick", function() M.tab = t[1]; M:Refresh() end)
        w.tabButtons[t[1]] = b
    end
    local content = CreateFrame("Frame", nil, w)
    content:SetPoint("TOPLEFT", 16, -112)
    content:SetPoint("BOTTOMRIGHT", -16, 16)
    w.pages = { standings = M:BuildStandings(content), loot = UILoot.Build(content, M) }

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

function M:Toggle()
    if not (CreateFrame and UIParent) then return false end
    local w = self.window or self:Build()
    if w:IsShown() then w:Hide() else w:Show() end
    return true
end

-- Show the window on a tab (a loot session has started).
function M:Open(tab)
    if not (CreateFrame and UIParent) then return end
    local w = self.window or self:Build()
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
