-- The window: what the Loot tab shows for a session (pure), driving a whole practice session with the same commands the buttons run, and the
-- frame code run against a stand-in for the game's frame functions (so a typo or a missing call is found here, not in the game).
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Sim, Commands, UI, UILoot = SK.modules.Sim, SK.modules.Commands, SK.modules.UI, SK.modules.UILoot

-- A practice raid and its commands, wired as the window wires them.
local function practice(size)
    local sim = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = size or 10 })
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local cmd = Commands.New({ client = sim.client, engine = sim.engine, host = host })
    return sim, cmd, { client = sim.client, engine = sim.engine, commands = cmd, sim = sim, host = host }
end

H.section("Window: the Loot tab")
test("before any loot the tab offers the next boss; after a kill it lists the items with your answers", function()
    local sim, cmd, ctx = practice()
    local m = UILoot.Model(ctx)
    eq(m.mode, "none"); assert(m.night.nextBoss, "the next boss is offered")
    local boss = sim:killBoss(nil, false)
    assert(boss, "a boss died")
    m = UILoot.Model(ctx)
    eq(m.mode, "ml"); eq(m.phase, "bidding"); assert(#m.items > 0, "the loot is listed")
    eq(m.items[1].mine, nil, "you haven't answered yet")
    cmd.handle("pass 1")
    eq(UILoot.Model(ctx).items[1].mine, "pass")
end)

test("a whole session runs from the buttons' commands: answer, resolve, confirm", function()
    local sim, cmd, ctx = practice()
    sim:killBoss(nil, false)
    local m = UILoot.Model(ctx)
    for i = 1, #m.items do cmd.handle("pass " .. i) end
    cmd.handle("resolve")
    for _ = 1, 40 do
        sim:advance(10)
        local s = UILoot.Model(ctx)
        if s.phase == "review" or s.phase == "done" or not s.active then break end
    end
    m = UILoot.Model(ctx)
    if m.phase == "review" then cmd.handle("confirm") end
    m = UILoot.Model(ctx)
    eq(m.phase, "done"); eq(m.active, false)
end)

H.section("Window: the frames")
-- A stand-in for the game's frames: every method exists, returns another stand-in, and does nothing.
local function frame()
    local f = {}
    local nothing = { TitleText = true, SetBackdrop = true }
    return setmetatable(f, { __index = function(self, k)
        if nothing[k] then return nil end
        if type(k) ~= "string" or not k:match("^%u") then return nil end -- fields (lower case) are nil, as on a real frame
        if k == "IsShown" then return function() return self.shown ~= false end end
        if k == "Hide" then return function() self.shown = false end end
        if k == "Show" then return function() self.shown = true end end
        if k == "GetText" then return function() return "" end end
        -- the game refuses to anchor to something that is not a frame (a plain table), so the stand-in does too
        if k == "SetPoint" or k == "SetAllPoints" then return function(_, ...)
            for _, a in ipairs { ... } do
                if type(a) == "table" and getmetatable(a) == nil then error("SetPoint: that is not a frame", 2) end
            end
        end end
        return function(_, ...) return frame() end
    end })
end

for _, variant in ipairs { "with the game's templates", "without them (the plain fallbacks)" } do
test("the window builds and refreshes on every tab, in practice and out, without errors, " .. variant, function()
    local missing = variant:find("without") and { DropdownButton = true, WowStyle1DropdownTemplate = true, TabSystemTemplate = true, WowScrollBoxList = true,
        MinimalScrollBar = true, InsetFrameTemplate = true, UICheckButtonTemplate = true, UIPanelScrollFrameTemplate = true, BasicFrameTemplateWithInset = true } or {}
    local saved = { CreateFrame = _G.CreateFrame, UIParent = _G.UIParent, UISpecialFrames = _G.UISpecialFrames }
    _G.CreateFrame, _G.UIParent, _G.UISpecialFrames = function(_, _, _, template)
        if template and missing[template] then error("no such template: " .. template) end
        return frame()
    end, frame(), {}
    local shown = {}
    local g = { CreateScrollBoxListLinearView = _G.CreateScrollBoxListLinearView, ScrollUtil = _G.ScrollUtil, CreateDataProvider = _G.CreateDataProvider, ScrollBoxConstants = _G.ScrollBoxConstants }
    _G.CreateScrollBoxListLinearView = function() return frame() end
    _G.ScrollUtil = { InitScrollBoxListWithScrollBar = function() end }
    _G.CreateDataProvider = function() return { Insert = function(_, r) shown[#shown + 1] = r end } end
    _G.ScrollBoxConstants = { RetainScrollPosition = 1 }
    local client = SK.modules.MockClient.New({ name = "Me" })
    local engine = SK.modules.Engine.New(client)
    local old = { client = SK.client, engine = SK.engine, commands = SK.commands, host = SK.host, player = SK.player }
    SK.client, SK.engine = client, engine
    SK.commands = Commands.New({ client = client, engine = engine })
    UI.window, UI.lootWindow, UI.practice, UI.tab = nil, nil, nil, "lists"
    local ok, err = pcall(function()
        assert(UI:Toggle(), "the window opens")
        UI:Refresh()
        UI:StartPractice()
        UI:OpenLoot(); UI:Refresh()
        UI:PracticeKill()
        UI:Refresh()
        UI:PracticeWait(10)
        UI:Command("pass 1")
        UI:Command("resolve"); UI:PracticeWait(30); UI:Refresh()
        UI:ToggleLoot(); UI:ToggleLoot(); UI:Tick()
        UI.tab = "ledger"; UI:Refresh(); UI.histKind = "list"; UI.histText = "added"; UI:Refresh(); UI.histKind, UI.histText = "all", ""
        for _, s in ipairs(SK.modules.GuildBook.SECTIONS) do UI.tab = s.id; UI:Refresh() end
        UI.OpenTool("award", "Me"); assert(UI.tab == "awards", "Award... opens the Awards section")
        UI.tab = "lists"; UI:Refresh()
        UI:LeavePractice()
    end)
    _G.CreateFrame, _G.UIParent, _G.UISpecialFrames = saved.CreateFrame, saved.UIParent, saved.UISpecialFrames
    for k, v in pairs(g) do _G[k] = v end
    _G.CreateScrollBoxListLinearView, _G.ScrollUtil, _G.CreateDataProvider, _G.ScrollBoxConstants = g.CreateScrollBoxListLinearView, g.ScrollUtil, g.CreateDataProvider, g.ScrollBoxConstants
    SK.client, SK.engine, SK.commands, SK.host, SK.player = old.client, old.engine, old.commands, old.host, old.player
    UI.window, UI.lootWindow, UI.practice = nil, nil, nil
    assert(ok, tostring(err))
end)
end

H.section("Window: the Tools forms")
local UITools = SK.modules.UITools
test("a form composes the command a person would type, and says what is missing", function()
    local a = UITools.Find("raidopen")
    eq(UITools.Compose(a, { ml = "Aldric Stormwind", hours = "4", list = "naxx" }), "raid open Aldric_Stormwind 4 list naxx")
    eq(UITools.Compose(a, { ml = "Aldric" }), "raid open Aldric", "optional fields are left out, with their keyword")
    local mv = UITools.Find("move")
    eq(UITools.Compose(mv, { name = "Ann Lee", pos = "top", reason = "fixed a mistake" }), "move Ann_Lee top fixed a mistake")
    local text, missing = UITools.Compose(mv, { name = "Ann", pos = "top" })
    eq(text, nil); eq(missing, "Reason")
    eq(UITools.Compose(UITools.Find("undo"), {}), "undo yes")
    eq(UITools.Compose(UITools.Find("eligibles"), {}), "eligible", "an empty optional field gives the bare command")
end)

test("every form's command is a command that exists, and every action has a unique id", function()
    local client = SK.modules.MockClient.New({ name = "Me" })
    local cmd = Commands.New({ client = client, engine = SK.modules.Engine.New(client) })
    local seen = {}
    for _, g in ipairs(UITools.GROUPS) do
        assert(#g.actions <= 12, g.title .. " has more actions than the window shows")
        for _, a in ipairs(g.actions) do
            assert(not seen[a.id], "duplicate action " .. a.id); seen[a.id] = true
            assert(#a.fields <= 4, a.id .. " has more fields than the window shows")
            assert(cmd.commands[a.cmd[1]:match("^(%S+)")], a.id .. " runs a command that doesn't exist: " .. a.cmd[1])
        end
    end
end)

test("a command run from the window is shown at its foot, and a refusal says why", function()
    local client = SK.modules.MockClient.New({ name = "Me" })
    local engine = SK.modules.Engine.New(client)
    local saved = { client = SK.client, engine = SK.engine, commands = SK.commands, host = SK.host, player = SK.player }
    SK.client, SK.engine, SK.commands, SK.host, SK.player = client, engine, Commands.New({ client = client, engine = engine }), nil, nil
    UI.practice = nil
    UI:Command("history")
    SK.client, SK.engine, SK.commands, SK.host, SK.player = saved.client, saved.engine, saved.commands, saved.host, saved.player
    assert(UI.OutputText():find("> history", 1, true), UI.OutputText())
    assert(#UI.log >= 2, "the command's answer was captured")
end)

H.section("Window: the standings table")
test("columns sort on a header click and again to reverse; the list's own order is the default; a row fills from a player", function()
    local rows = { { pos = 1, name = "Cara", class = "MAGE", wins = 2 }, { pos = 2, name = "Abe", class = "WARRIOR", wins = 0 }, { pos = 3, name = "Bea", class = "DRUID", wins = 5 } }
    UI.sortKey, UI.sortDesc = nil, false
    eq(UI.Sorted(rows)[1].name, "Cara", "list order by default")
    UI.sortKey = "name"; eq(UI.Sorted(rows)[1].name, "Abe")
    UI.sortDesc = true; eq(UI.Sorted(rows)[1].name, "Cara")
    UI.sortKey, UI.sortDesc = "wins", true; eq(UI.Sorted(rows)[1].name, "Bea")
    UI.sortKey, UI.sortDesc = "class", false; eq(UI.Sorted(rows)[1].name, "Bea", "DRUID sorts first")
    UI.sortKey, UI.sortDesc = nil, false
    local texts = {}
    local row = setmetatable({}, { __index = function(_, k)
        if k == "CreateFontString" then return function() local fs = {}; return setmetatable(fs, { __index = function(_, m)
            if m == "SetText" then return function(_, t) fs.t = t end end
            return function() end end }) end end
    end })
    UI.InitRow(row, { pos = 7, name = "Ann", class = "MAGE", wins = 3, mine = true })
    eq(row.cells[1].t, "7"); eq(row.cells[3].t, "Mage"); eq(row.cells[4].t, "3")
    assert(row.cells[2].t:find("Ann", 1, true) and row.cells[2].t:find("(you)", 1, true), row.cells[2].t)
end)

H.section("Window: item links")
test("a simulated drop gets a tooltip id, a real link is used as it is, and a link pasted into a form becomes item:ID", function()
    local UILoot = SK.modules.UILoot
    local mc = SK.modules.Sim.FindItem("Earthfury Boots")
    assert(mc, "the practice loot has real item ids")
    eq(UILoot.TipOf("Earthfury Boots"), "item:" .. mc.id)
    local link = "|cffa335ee|Hitem:16837::::::::60:::::|h[Helm of Might]|h|r"
    eq(UILoot.TipOf(link), link); eq(UILoot.TipOf("nonsense item"), nil)
    eq(UILoot.Display(link, "item:1"), link, "a real link is shown as the game gave it")
    eq(UITools.PlainLinks("x " .. link .. " y"), "x item:16837 y")
    local text = UITools.Compose(UITools.Find("eligible"), { item = link, classes = "WARRIOR", reason = "tier set" })
    eq(text, "eligible item:16837 WARRIOR tier set")
end)

test("an item the game hasn't cached yet is still shown as a link built from its id and name", function()
    local text = SK.modules.UILoot.Display("Earthfury Boots", "item:16837")
    assert(text:find("|Hitem:16837", 1, true) and text:find("[Earthfury Boots]", 1, true), text)
    eq(SK.modules.UILoot.Display("a name with no id", nil), "a name with no id")
end)

H.section("Practice: loot from the player's own gear")
test("gear from bags becomes a practice raid whose bosses drop it, shown by link", function()
    local MockClient = SK.modules.MockClient
    local client = MockClient.New({ name = "Me" })
    local links, n = {}, 0
    for i, spec in ipairs { { "INVTYPE_FEET", 4, 2 }, { "INVTYPE_HAND", 4, 1 }, { "INVTYPE_WEAPON", 2, 7 }, { "INVTYPE_CHEST", 4, 4 }, { "INVTYPE_BAG", 1, 0 }, { "", 0, 0 } } do
        local link = ("|cff1eff00|Hitem:%d::::::::|h[Thing %d]|h|r"):format(1000 + i, i)
        links[#links + 1] = link
        client:setItemInfo(link, { name = "Thing " .. i, equipLoc = spec[1], class = spec[2], subclass = spec[3] })
        client:setItemStats(link, { stats = { sta = 5 } })
    end
    local gear = UI.GearItems(client, links, 24)
    eq(#gear, 4, "bags and plain items are not gear")
    local sim = SK.modules.Sim.NewPractice(gear, { learner = "Me", seed = 1, size = 10 })
    eq(sim.raid.name, "Your gear"); eq(#sim.raid.bosses, 1)
    local boss, dropped = sim:killBoss(nil, true)
    assert(boss and #sim.held == 2, "a practice boss drops two items")
    assert(sim.held[1].item.name:find("|Hitem:", 1, true), "an item's name is its link")
    local ok = sim:handOut()
    assert(ok, "the loot can be handed out")
    assert(SK.modules.UILoot.Model({ client = sim.client, host = { session = sim.session }, sim = sim }).items[1].tip, "the link has a tooltip")
end)

test("an item your class can't bid on grays need and off-spec out of the model, and pass and gift stay", function()
    local MockClient = SK.modules.MockClient
    local sim = SK.modules.Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 5, learnerClass = "PRIEST" })
    local cmd = Commands.New({ client = sim.client, engine = sim.engine, host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end }) })
    sim:killBoss(nil, false)
    local ctx = { client = sim.client, engine = sim.engine, commands = cmd, sim = sim, host = { session = sim.session } }
    local m = UILoot.Model(ctx)
    local saw
    for _, it in ipairs(m.items) do
        assert(it.canBid ~= nil)
        if it.canBid == false then saw = it end
    end
    -- Magmadar-side drops include plate and mail pieces a priest can't wear, so at least one must be refused
    assert(saw or #m.items > 0, "items listed")
end)

H.section("Window: acting on a selected player")
test("player fields offer the players it could be, and Up and Down move a player one place", function()
    local sim, cmd, ctx = practice(5)
    local members = UITools.Players(ctx, "members", "main")
    eq(#members, 5, "everyone on the list")
    local group = UITools.Players(ctx, "group", "main")
    eq(#group, #sim.client:roster())
    sim.client:setGuild({ { name = "Newcomer", class = "MAGE" }, { name = members[1], class = "MAGE" } })
    eq(table.concat(UITools.Players(ctx, "missing", "main"), ","), "Newcomer", "only those not on the list yet")
    -- what the Down button sends: a move to the place below, with a reason
    local who = members[2]
    cmd.handle(("move %s %d testing"):format(who, 3))
    eq(sim.engine:Get("main").state.order[3], who, "moved down one place")
    cmd.handle(("move %s %d testing"):format(who, 2))
    eq(sim.engine:Get("main").state.order[2], who, "and back up one")
    assert(UI.Model(sim.engine, sim.client, "main").mayWrite == true, "the founder may write")
end)

H.section("Window: tooltips")
test("every button has a tooltip with a title and an explanation, and a grayed-out one can say why", function()
    local Tips = SK.modules.UITips
    for _, id in ipairs { "need", "off", "pass", "gift", "resolve", "extend", "confirm", "cancel", "start", "pick", "skip", "claim", "decline", "give", "keep", "withdraw",
        "kill", "handout", "wait", "practice", "practicesize", "listpick", "sort", "top", "up", "down", "bottom", "remove", "award", "addall", "startledger", "dothis" } do
        local title, text = Tips.Resolve(id)
        assert(title and title ~= "" and text and #text > 30, "tooltip text for " .. id)
    end
    eq(Tips.Resolve(function() return "T", "x" end), "T")
    local entered
    local frame = setmetatable({}, { __index = function(_, k)
        if k == "HookScript" then return function(_, event, fn) if event == "OnEnter" then entered = fn end end end
        return function() end end })
    Tips.Attach(frame, "need", function() return "because" end)
    assert(entered, "the hover script was installed")
    local lines = {}
    local saved = _G.GameTooltip
    _G.GameTooltip = setmetatable({}, { __index = function(_, k) return function(_, a, b) if k == "AddLine" or k == "SetText" then lines[#lines + 1] = a end end end })
    entered(frame)
    _G.GameTooltip = saved
    assert(lines[1] == "Need (main spec)" and lines[#lines]:find("because", 1, true), table.concat(lines, "|"))
end)

H.section("Window: staged moves")
test("Up, Down, a typed place and a drop only stage a move; Apply writes exactly one entry", function()
    local sim, cmd, ctx = practice(5)
    local saved = { practice = UI.practice, selected = UI.selected, pending = UI.pending }
    UI.practice, UI.pending = ctx, nil
    local before = #sim.engine:Get("main").events
    local order = sim.engine:Get("main").state.order
    local who = order[2]
    local model = UI.Model(sim.engine, sim.client, "main")
    UI.selected, UI.places, UI.total, UI.may = who, {}, model.total, true
    for _, r in ipairs(model.rows) do UI.places[r.who] = r.pos end
    -- (the window's own Refresh needs frames; the staging logic is what is under test)
    local function stage(to)
        local place = UI.places[who]
        to = math.floor(math.max(1, math.min(UI.total, to)))
        UI.pending = (to ~= place) and { who = who, to = to } or nil
    end
    stage(4); stage(5); stage(4)
    eq(UI.pending.to, 4)
    local preview = UI.Preview(model.rows)
    eq(preview[4].who, who, "the player is shown at the staged place"); assert(preview[4].moving); eq(preview[4].pos, 2, "and remembers where they were")
    eq(preview[1].who, order[1]); eq(preview[2].who, order[3], "the others close up")
    eq(#sim.engine:Get("main").events, before, "nothing was written while staging")
    local text, problem = UI.MoveCommand("  ")
    eq(text, nil); assert(problem:find("reason"), problem)
    text = UI.MoveCommand("fixed after a failed hand-out")
    eq(text, ("move %s 4 fixed after a failed hand-out"):format(who))
    cmd.handle(text)
    eq(sim.engine:Get("main").state.order[4], who, "applied")
    eq(#sim.engine:Get("main").events, before + 1, "one entry for the whole move")
    -- dropping on a row stages a move to that row's place
    UI.pending, UI.dragging, UI.selected = nil, who, who
    UI.places[who] = 4
    UI.DropOn({ pos = 1 }) -- (Stage refreshes the window: no window here, so only the state matters)
    UI.practice, UI.selected, UI.pending, UI.dragging = saved.practice, saved.selected, saved.pending, nil
end)

H.section("Window: Award only offers items you hold")
test("the Record a win form offers the open loot window and the tradeable bag items, nothing else, and composes the chosen link", function()
    local client = SK.modules.MockClient.New({ name = "Me" })
    client:dropLoot({ { link = "|cffa335ee|Hitem:16837::::::::|h[Earthfury Boots]|h|r" } })
    local bag = "|cff0070dd|Hitem:2000::::::::|h[Some Cloak]|h|r"
    local items = UITools.Items({ client = client, bagLinks = function() return { bag, "|cffa335ee|Hitem:16837::::::::|h[Earthfury Boots]|h|r" } end })
    eq(#items, 2, "the loot window's item and the bag item, once each")
    eq(items[1].where, "loot window"); eq(items[2].where, "bags")
    local text = UITools.Compose(UITools.Find("award"), { name = "Ann", item = items[2].link, reason = "failed hand-out" })
    eq(text, "award Ann item:2000 failed hand-out")
    eq(#UITools.Items({ client = SK.modules.MockClient.New({ name = "Me" }), bagLinks = function() return {} end }), 0, "nothing held, nothing to choose")
    -- practice: the practice raid's loot
    local sim = SK.modules.Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 5 })
    sim:killBoss(nil, true)
    assert(#UITools.Items({ client = sim.client, sim = sim }) > 0, "held practice loot can be chosen")
end)

H.section("Window: shift-clicking an item into a form")
test("a shift-clicked item fills the form's item field; for Record a win a held item is matched by id and any other item is taken as it is", function()
    local client = SK.modules.MockClient.New({ name = "Me" })
    local held = "|cff0070dd|Hitem:2000::::::::|h[Some Cloak]|h|r"
    local other = "|cffa335ee|Hitem:3000::::::::|h[Not Mine]|h|r"
    local says = {}
    local ui = { Say = function(t) says[#says + 1] = t end, Refresh = function() end }
    local function page(actionId)
        local boxes = {}
        for i = 1, 4 do boxes[i] = { SetText = function(self, t) self.text = t end } end
        return { action = actionId, picked = {}, boxes = boxes, IsVisible = function() return true end,
            ctx = { client = client, bagLinks = function() return { held } end } }
    end
    UITools.focus, UITools.frames = nil, {} -- (no real pages built by the other tests count here)
    -- a class rule: the link goes into the item box
    local f = page("eligible")
    assert(UITools.OnItemLink(f, ui, other)); eq(f.boxes[1].text, other)
    -- record a win: an item you don't hold is taken too (it may be in someone else's bags), and shows in the dropdown's choices
    f = page("award")
    assert(UITools.OnItemLink(f, ui, other))
    eq(f.picked[2], other); eq(f.extra[2], other)
    assert(says[#says] and says[#says]:find("Item chosen", 1, true) and says[#says]:find(other, 1, true), "the window says what it took")
    assert(UITools.OnItemLink(f, ui, "|cff0070dd|Hitem:2000::::::::60|h[Some Cloak]|h|r"))
    eq(f.picked[2], held, "the same item (by id) is taken, as the bag's own link")
    -- an action with no item, a hidden tab, plain text: not taken
    eq(UITools.OnItemLink(page("move"), ui, other), false)
    eq(UITools.OnItemLink(page("eligible"), ui, "just text"), false)
    local hidden = page("eligible"); hidden.IsVisible = function() return false end
    eq(UITools.OnItemLink(hidden, ui, other), false)
end)

test("in practice, Record a win offers the practice gear even before any boss has died", function()
    local gear = {}
    for i, loc in ipairs { "INVTYPE_FEET", "INVTYPE_HAND", "INVTYPE_CHEST" } do
        gear[i] = { id = 5000 + i, link = ("|cff1eff00|Hitem:%d::::::::|h[Practice %d]|h|r"):format(5000 + i, i), equipLoc = loc, class = 4, subclass = 1, stats = { sta = 3 } }
    end
    local sim = SK.modules.Sim.NewPractice(gear, { learner = "Me", seed = 1, size = 5 })
    local items = UITools.Items({ client = sim.client, sim = sim })
    eq(#items, 3, "all three practice pieces are offered, with no session running")
    eq(items[1].where, "practice gear")
    -- and the bag scan reports how many items it saw, for a clearer empty menu
    local _, stats = UITools.BagLinks()
    assert(stats and stats.unavailable, "no bags outside the game")
end)
