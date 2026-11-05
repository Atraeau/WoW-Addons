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
        if type(k) ~= "string" then return nil end
        if k == "IsShown" then return function() return self.shown ~= false end end
        if k == "Hide" then return function() self.shown = false end end
        if k == "Show" then return function() self.shown = true end end
        if k == "GetText" then return function() return "" end end
        return function(_, ...) return frame() end
    end })
end

test("the window builds and refreshes on every tab, in practice and out, without errors", function()
    local saved = { CreateFrame = _G.CreateFrame, UIParent = _G.UIParent, UISpecialFrames = _G.UISpecialFrames }
    _G.CreateFrame, _G.UIParent, _G.UISpecialFrames = function() return frame() end, frame(), {}
    local client = SK.modules.MockClient.New({ name = "Me" })
    local engine = SK.modules.Engine.New(client)
    local old = { client = SK.client, engine = SK.engine, commands = SK.commands, host = SK.host, player = SK.player }
    SK.client, SK.engine = client, engine
    SK.commands = Commands.New({ client = client, engine = engine })
    UI.window, UI.practice, UI.tab = nil, nil, "standings"
    local ok, err = pcall(function()
        assert(UI:Toggle(), "the window opens")
        UI:Refresh()
        UI:StartPractice()
        UI.tab = "loot"; UI:Refresh()
        UI:PracticeKill()
        UI:Refresh()
        UI:PracticeWait(10)
        UI:Command("pass 1")
        UI.tab = "standings"; UI:Refresh()
        UI:LeavePractice()
    end)
    _G.CreateFrame, _G.UIParent, _G.UISpecialFrames = saved.CreateFrame, saved.UIParent, saved.UISpecialFrames
    SK.client, SK.engine, SK.commands, SK.host, SK.player = old.client, old.engine, old.commands, old.host, old.player
    UI.window, UI.practice = nil, nil
    assert(ok, tostring(err))
end)

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
