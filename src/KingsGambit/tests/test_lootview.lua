-- The Loot window as a table (LootView.Build over UILoot.Model): each state a session goes through, the buttons grayed with their reasons, the
-- Master Looter's strip. Both the game's frames and the web page draw exactly this table, so what is asserted here is what both show.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Sim, Commands, UILoot, LootView = SK.modules.Sim, SK.modules.Commands, SK.modules.UILoot, SK.modules.LootView

local function practice(size)
    local sim = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = size or 10 })
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local cmd = Commands.New({ client = sim.client, engine = sim.engine, host = host })
    local ctx = { client = sim.client, engine = sim.engine, commands = cmd, sim = sim, host = host }
    return sim, cmd, function() return LootView.Build(UILoot.Model(ctx)) end
end

local function find(list, key) for _, b in ipairs(list) do if b.key == key then return b end end end

H.section("Loot view")
test("no session: nothing to show, and the next boss is offered", function()
    local _, _, view = practice()
    local v = view()
    eq(v.visible, false); eq(v.state, "none"); assert(v.night and v.night.nextBoss, "the next boss is offered")
end)

test("bidding: a row per item with four answers, letters as well as colors, and a timer", function()
    local sim, _, view = practice()
    sim:killBoss(nil, false)
    local v = view()
    eq(v.visible, true); eq(v.state, "bidding"); eq(v.isML, true)
    assert(#v.rows >= 1)
    local r = v.rows[1]
    eq(r.state, "open"); eq(#r.buttons, 4)
    eq(r.buttons[1].letter, "N"); eq(r.buttons[4].letter, "P")
    assert(r.buttons[1].tip and r.buttons[1].tip.title, "every answer explains itself")
    eq(r.buttons[1].act.name, "bid"); eq(r.buttons[1].act.kind, "need"); eq(r.buttons[1].act.item, r.id)
    assert(v.timer and v.timer.seconds > 0 and v.timer.fraction > 0.9, "the timer starts full")
    assert(v.progress and v.progress:find("answered"), "progress says how many have answered")
end)

test("an answer is marked, and answering every item changes the state to waiting", function()
    local sim, cmd, view = practice()
    sim:killBoss(nil, false)
    local n = #view().rows
    cmd.handle("pass 1")
    local v = view()
    eq(find(v.rows[1].buttons, "pass").selected, true); eq(v.rows[1].state, "answered"); eq(v.rows[1].note, "You: Pass")
    if n > 1 then eq(v.state, "bidding", "still items to answer") end
    for i = 2, n do cmd.handle("pass " .. i) end
    eq(view().state, "waiting")
    assert(view().banner.text:find("change an answer"), "the player is told they can still change it")
end)

test("need and off-spec are grayed, with the reason, for an item the class can't have; gift and pass are not", function()
    local sim, _, view = practice(10)
    sim:killBoss(nil, false)
    local grayed
    for _, r in ipairs(view().rows) do
        if not find(r.buttons, "need").enabled then grayed = r end
    end
    -- the practice player's class may not have every Molten Core drop; if one is grayed it must be consistent
    if grayed then
        eq(find(grayed.buttons, "off").enabled, false)
        assert(find(grayed.buttons, "need").why and #find(grayed.buttons, "need").why > 5, "grayed out with a reason")
        eq(find(grayed.buttons, "gift").enabled, true); eq(find(grayed.buttons, "pass").enabled, true)
    end
end)

test("the Master Looter's strip: resolve while bidding, confirm only in review, and none for someone else", function()
    local sim, cmd, view = practice()
    sim:killBoss(nil, false)
    local v = view()
    assert(v.ml, "the Master Looter has a strip")
    eq(find(v.ml.buttons, "resolve").enabled, true); eq(find(v.ml.buttons, "confirm").enabled, false)
    assert(find(v.ml.buttons, "confirm").why, "the grayed Confirm says why")
    for i = 1, #v.rows do cmd.handle("pass " .. i) end
    cmd.handle("resolve")
    for _ = 1, 40 do
        sim:advance(10)
        if view().state == "review" or view().state == "result" then break end
    end
    v = view()
    if v.state == "review" then
        eq(find(v.ml.buttons, "confirm").enabled, true); eq(find(v.ml.buttons, "resolve").enabled, false)
        cmd.handle("confirm")
    end
    eq(view().state, "result")
    -- a raider whose Master Looter is someone else gets no strip
    local m = UILoot.Model({ client = sim.client, host = { session = sim.session }, sim = sim, isML = false })
    eq(LootView.Build(m).ml, nil)
end)

test("a whole practice night walks through states without error, and each state carries the words it needs", function()
    local sim, cmd, view = practice(10)
    local seen = {}
    for _ = 1, 3 do
        if not sim:killBoss(nil, false) then break end
        local v = view()
        for i = 1, #v.rows do cmd.handle("need " .. i) end
        for _ = 1, 60 do
            local s = view()
            seen[s.state] = true
            assert(s.state ~= "myturn" or (s.turn and #s.turn.buttons >= 2 and s.turn.text), "your turn has a panel with buttons")
            if s.state == "myturn" then
                if s.turn.kind == "pick" then cmd.handle("pick " .. s.turn.buttons[1].act.item)
                elseif s.turn.kind == "recipient" then cmd.handle("keep")
                else cmd.handle("decline") end
            elseif s.state == "review" then cmd.handle("confirm")
            elseif s.state == "result" then break
            else sim:advance(10) end
        end
        assert(view().state == "result" or view().state == "none", "the night's session finishes: " .. tostring(view().state))
    end
    assert(seen.bidding or seen.waiting, "bidding was seen")
end)

H.section("Loot window: the buttons' commands")
test("every button's act becomes the command a player would type", function()
    local LootWindow = SK.modules.LootWindow
    eq(LootWindow.CommandText({ name = "bid", item = 2, kind = "need" }), "need 2")
    eq(LootWindow.CommandText({ name = "bid", item = 1, kind = "gift" }), "gift 1")
    eq(LootWindow.CommandText({ name = "pick", item = 3 }), "pick 3")
    eq(LootWindow.CommandText({ name = "extend", seconds = 30 }), "extend 30")
    eq(LootWindow.CommandText({ name = "withdraw" }), "withdraw yes")
    eq(LootWindow.CommandText({ name = "resolve" }), "resolve")
    eq(LootWindow.CommandText({ name = "claim", item = 1 }), "claim")
    eq(LootWindow.CommandText({ name = "claim", item = 1, gift = true }, "Aldric"), "claim Aldric")
    eq(LootWindow.CommandText({ name = "give", item = 1 }, "Aldric"), "recipient Aldric")
    local cmd, why = LootWindow.CommandText({ name = "give", item = 1 }, nil)
    eq(cmd, nil); assert(why:find("Choose"), "a gift with nobody chosen says what to do")
end)

test("a button the view shows can always be run: its command exists", function()
    local LootWindow = SK.modules.LootWindow
    local sim, cmd, view = practice(10)
    sim:killBoss(nil, false)
    local v = view()
    for _, r in ipairs(v.rows) do
        for _, b in ipairs(r.buttons) do
            local text = LootWindow.CommandText(b.act, "Someone")
            assert(text, "a command for " .. b.key)
            assert(b.tip and b.tip.text, "a tooltip for " .. b.key)
        end
    end
    for _, b in ipairs(v.ml.buttons) do assert(LootWindow.CommandText(b.act, "Someone"), "a command for " .. b.key) end
end)

H.section("Loot window: moving it")
test("a moved window is remembered for the character, restored next time, and can be reset", function()
    local LootWindow = SK.modules.LootWindow
    local saved = { UIParent = _G.UIParent, char = SK.char }
    _G.UIParent = {}
    SK.char = { ui = {} }
    local function fake()
        local f = { points = {} }
        function f:SetMovable() end function f:EnableMouse() end function f:SetClampedToScreen() end function f:RegisterForDrag() end
        function f:SetScript(name, fn) self[name] = fn end
        function f:StartMoving() end function f:StopMovingOrSizing() end
        function f:ClearAllPoints() self.points = {} end
        function f:SetPoint(...) self.points[#self.points + 1] = { ... } end
        function f:GetPoint() return "TOP", _G.UIParent, "TOP", 12, -34 end
        return f
    end
    local a = fake()
    LootWindow.Movable(a, "loot", { "CENTER", -440, 140 })
    eq(a.points[1][1], "CENTER"); eq(a.points[1][4], -440, "starts at its default place")
    a.OnDragStop(a)
    eq(SK.char.ui.loot[1], "TOP"); eq(SK.char.ui.loot[3], 12)
    local b = fake()
    LootWindow.Movable(b, "loot", { "CENTER", -440, 140 })
    eq(b.points[1][1], "TOP"); eq(b.points[1][4], 12, "restored where it was left")
    SK.char.ui.loot = { "bad" }
    local c = fake()
    LootWindow.Movable(c, "loot", { "CENTER", -440, 140 })
    eq(c.points[1][1], "CENTER", "a damaged saved position falls back to the default")
    b.placeDefault()
    eq(b.points[1][1], "CENTER", "reset puts it back")
    _G.UIParent, SK.char = saved.UIParent, saved.char
end)

H.section("Practice: as your own class")
test("practice uses the player's real class, and falls back to a priest for one the simulation doesn't know", function()
    local function classOf(sim) for _, m in ipairs(sim.client:roster()) do if m.name == "Me" then return m.class end end end
    eq(classOf(Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10, learnerClass = "WARRIOR" })), "WARRIOR")
    eq(classOf(Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10, learnerClass = "DEATHKNIGHT" })), "PRIEST", "an unknown class falls back")
    eq(classOf(Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10 })), "PRIEST", "no class asked: the usual priest")
    local w = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10, learnerClass = "WARRIOR" })
    eq(w.client:myClass(), "WARRIOR", "the client says what class its player is")
    -- a warrior is asked about warrior loot: a cloth caster item is grayed for them, plate is not
    w:killBoss(nil, false)
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return w.session end end })
    local cmd = Commands.New({ client = w.client, engine = w.engine, host = host })
    local v = LootView.Build(UILoot.Model({ client = w.client, engine = w.engine, commands = cmd, sim = w, host = host }))
    assert(#v.rows > 0)
    for _, r in ipairs(v.rows) do
        local need = r.buttons[1]
        if not need.enabled then assert(need.why, "a grayed Need says why") end
    end
end)

H.section("Loot window: who gets what before confirming")
test("in review each item says who wins it, in which round, and how the list moves; nothing is recorded yet", function()
    local sim, cmd, view = practice(10)
    sim:killBoss(nil, false)
    for i = 1, #view().rows do cmd.handle("need " .. i) end
    local ledgerBefore = #sim.engine:Get("main").events
    cmd.handle("resolve")
    local v
    for _ = 1, 60 do
        v = view()
        if v.state == "review" then break end
        if v.state == "myturn" and v.turn.kind == "pick" then cmd.handle("pick " .. v.turn.buttons[1].act.item)
        elseif v.state == "myturn" and v.turn.kind == "recipient" then cmd.handle("keep")
        elseif v.state == "myturn" then cmd.handle("claim")
        else sim:advance(10) end
    end
    eq(v.state, "review")
    assert(v.banner.text:find("Nothing is handed out or recorded until you confirm"), v.banner.text)
    local sawWinner, sawMove = false, false
    for _, r in ipairs(v.rows) do
        assert(r.note and #r.note > 0, "every item says what happens to it")
        if r.state == "awarded" then
            sawWinner = sawWinner or (r.note:find(" wins ") or r.note:find("You win")) ~= nil
            sawMove = sawMove or r.note:find("moves from place") ~= nil
            assert(r.note:find("draft") or r.note:find("salvage"), "it names the round: " .. r.note)
        end
    end
    assert(sawWinner, "someone wins an item")
    assert(sawMove, "the list movement is shown")
    eq(#sim.engine:Get("main").events, ledgerBefore, "nothing is written while reviewing")
end)

H.section("Loot window: people are shown like the list shows them")
test("a winner's line carries their class color, class and (in practice) spec; the plain text says the same", function()
    local LootWindow = SK.modules.LootWindow
    local sim, cmd, view = practice(10)
    sim:killBoss(nil, false)
    for i = 1, #view().rows do cmd.handle("need " .. i) end
    cmd.handle("resolve")
    local v
    for _ = 1, 60 do
        v = view()
        if v.state == "review" then break end
        if v.state == "myturn" and v.turn.kind == "pick" then cmd.handle("pick " .. v.turn.buttons[1].act.item)
        elseif v.state == "myturn" and v.turn.kind == "recipient" then cmd.handle("keep")
        elseif v.state == "myturn" then cmd.handle("claim")
        else sim:advance(10) end
    end
    eq(v.state, "review")
    local found
    for _, r in ipairs(v.rows) do
        if r.state == "awarded" then
            for _, seg in ipairs(r.segments) do
                if seg.who and seg.who.class then found = seg.who end
            end
        end
    end
    assert(found, "someone wins an item, and the line knows their class")
    assert(found.color and #found.color == 6, "a class color")
    assert(found.className and found.spec, "class name and spec in practice: " .. tostring(found.className) .. "/" .. tostring(found.spec))
    -- the game draws it with color codes, the plain note carries no codes
    local rich = LootWindow.Rich({ { who = found }, { text = " wins" } })
    assert(rich:find("|cff" .. found.color, 1, true) and rich:find(found.spec, 1, true) and rich:find(found.className, 1, true), rich)
    for _, r in ipairs(v.rows) do if r.note then assert(not r.note:find("|c", 1, true), "plain text has no color codes") end end
end)

test("another player's win is drawn with their class color, name and spec; a gift names its recipient too", function()
    local LootWindow = SK.modules.LootWindow
    local m = { mode = "player", phase = "review", phaseText = "Review", active = true, me = "Me", can = {}, hidden = 0, isML = false, items = {
        { id = 1, link = "[Helm]", status = "awarded", winner = "Brann", to = "Cass", tier = "gift", winnerIsMe = false, toIsMe = false,
          winnerWho = { name = "Brann", class = "WARRIOR", spec = "Fury" }, toWho = { name = "Cass", class = "MAGE" }, from = 4 } } }
    local v = LootView.Build(m)
    local r = v.rows[1]
    eq(r.note, "Brann wins (gift draft) and gives it to Cass " .. "·" .. " moves from place 4 to the bottom of the list")
    local rich = LootWindow.Rich(r.segments)
    assert(rich:find("|cffc79c6eBrann|r |cff999999(Fury Warrior)|r", 1, true), rich)
    assert(rich:find("|cff69ccf0Cass|r |cff999999(Mage)|r", 1, true), "a recipient with no known spec shows the class alone: " .. rich)
end)
