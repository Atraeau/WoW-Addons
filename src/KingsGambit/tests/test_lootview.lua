-- The Loot window as a table (LootView.Build over UILoot.Model): each state a session goes through, the buttons greyed with their reasons, the
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

test("bidding: a row per item with four answers, letters as well as colours, and a timer", function()
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

test("need and off-spec are greyed, with the reason, for an item the class can't have; gift and pass are not", function()
    local sim, _, view = practice(10)
    sim:killBoss(nil, false)
    local greyed
    for _, r in ipairs(view().rows) do
        if not find(r.buttons, "need").enabled then greyed = r end
    end
    -- the practice player's class may not have every Molten Core drop; if one is greyed it must be consistent
    if greyed then
        eq(find(greyed.buttons, "off").enabled, false)
        assert(find(greyed.buttons, "need").why and #find(greyed.buttons, "need").why > 5, "greyed out with a reason")
        eq(find(greyed.buttons, "gift").enabled, true); eq(find(greyed.buttons, "pass").enabled, true)
    end
end)

test("the Master Looter's strip: resolve while bidding, confirm only in review, and none for someone else", function()
    local sim, cmd, view = practice()
    sim:killBoss(nil, false)
    local v = view()
    assert(v.ml, "the Master Looter has a strip")
    eq(find(v.ml.buttons, "resolve").enabled, true); eq(find(v.ml.buttons, "confirm").enabled, false)
    assert(find(v.ml.buttons, "confirm").why, "the greyed Confirm says why")
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
