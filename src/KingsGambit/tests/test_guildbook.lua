-- The Guild book as tables (GuildBook): the record in words, filtered, newest first. The game's window and the web page draw exactly this.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Sim, Commands, GuildBook = SK.modules.Sim, SK.modules.Commands, SK.modules.GuildBook

local function raid()
    local sim = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10 })
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local cmd = Commands.New({ client = sim.client, engine = sim.engine, host = host })
    return sim, { client = sim.client, engine = sim.engine, commands = cmd, sim = sim, host = host }, cmd
end

H.section("Guild book")
test("the sections start with Lists and the Ledger, each explained", function()
    eq(GuildBook.SECTIONS[1].id, "lists"); eq(GuildBook.SECTIONS[2].id, "ledger"); eq(GuildBook.SECTIONS[2].label, "Ledger")
    for _, s in ipairs(GuildBook.SECTIONS) do assert(s.label and s.tip, "every section has a label and a tip") end
end)

test("ago reads in a person's words", function()
    eq(GuildBook.Ago(1000, 990), "just now")
    eq(GuildBook.Ago(1000 + 3600, 1000), "1 hour ago")
    eq(GuildBook.Ago(1000 + 3 * 86400, 1000), "3 days ago")
    eq(GuildBook.Ago(1000 + 14 * 86400, 1000), "2 weeks ago")
    eq(GuildBook.Ago(1000 + 90 * 86400, 1000), "3 months ago")
end)

test("a new ledger's history says nothing has happened, and a list change then shows first", function()
    local _, ctx, cmd = raid()
    local before = GuildBook.History(ctx, { text = "testing the history" })
    eq(before.total, 0); assert(before.empty:find("Nothing matches"), "no match is explained")
    cmd.handle("move Me 1 testing the history")
    local after = GuildBook.History(ctx, { text = "testing the history" })
    eq(after.total, 1)
    assert(after.entries[1].text:find("moved"), "the move is in the record, with its reason")
    eq(after.entries[1].kind, "list"); eq(after.entries[1].type, "MovePlayer")
    assert(after.entries[1].when ~= "", "each entry says when")
    for _, e in ipairs(GuildBook.History(ctx, {}).entries) do assert(not e.text:find(": %u%l+%u"), "no entry is left as a bare event name: " .. e.text) end
end)

test("the filters narrow by kind and by words, and say so when nothing matches", function()
    local _, ctx, cmd = raid()
    cmd.handle("move Me 1 first move")
    local rules = GuildBook.History(ctx, { kind = "rules" })
    for _, e in ipairs(rules.entries) do eq(e.kind, "rules") end
    local both = GuildBook.History(ctx, { kind = "rules", text = "first move" })
    eq(both.total, 0, "a list change is not a rule")
    local words = GuildBook.History(ctx, { text = "zzzz-no-such" })
    eq(words.total, 0); assert(words.empty:find("Nothing matches"), "filtered to nothing: told to clear the filter")
    local lists = GuildBook.History(ctx, { kind = "list" })
    assert(lists.total >= 1)
end)

test("a limit shows the newest few and still counts them all", function()
    local _, ctx, cmd = raid()
    cmd.handle("move Me 1 one"); cmd.handle("move Me 2 two"); cmd.handle("move Me 1 three")
    local h = GuildBook.History(ctx, { limit = 1 })
    eq(h.shown, 1); assert(h.total >= 2, "the total counts what was left out")
end)

test("every form belongs to exactly one section, and the sections' forms all exist", function()
    local UITools = SK.modules.UITools
    local owner = {}
    for _, s in ipairs(GuildBook.SECTIONS) do
        for _, id in ipairs(s.actions or {}) do
            assert(UITools.Find(id), "section " .. s.id .. " names a form that doesn't exist: " .. id)
            assert(not owner[id], id .. " is in two sections: " .. tostring(owner[id]) .. " and " .. s.id)
            owner[id] = s.id
        end
    end
    for _, g in ipairs(UITools.GROUPS) do
        for _, a in ipairs(g.actions) do
            -- (the old History form is the History section now)
            if a.id ~= "history" then assert(owner[a.id], "form " .. a.id .. " is in no section, so nobody could reach it") end
        end
    end
    eq(GuildBook.SectionOf("award").id, "awards"); eq(GuildBook.SectionOf("migrate").id, "admin")
    eq(GuildBook.SectionOf("raidopen").id, "raids"); assert(GuildBook.SectionOf("nope") == nil)
end)

test("the Admin section is kept apart, and a section's group keeps its order", function()
    local UITools = SK.modules.UITools
    eq(GuildBook.Section("admin").gap, true)
    local g = UITools.SectionGroup(GuildBook.Section("awards"))
    eq(g.id, "awards"); eq(g.actions[1].id, "award"); eq(#g.actions, 5)
end)

H.section("What disenchanting gave (DisenchantResult)")
local Standings = SK.modules.Standings

local function withDisenchant()
    local sim, ctx, cmd = raid()
    local de = sim:disenchanterName()
    local ev = assert(sim.engine:Append("main", "Disenchant", { item = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r", to = de }))
    return sim, ctx, cmd, de, ev
end

test("the result is recorded once, only for the player the item was given to, and moves nobody", function()
    local sim, _, _, de, ev = withDisenchant()
    local before = table.concat(sim.engine:Get("main").state.order, ",")
    local results = { { name = "Strange Dust", count = 3 } }
    local bad, why = sim.engine:Append("main", "DisenchantResult", { disenchant = ev.id, results = results })
    eq(bad, nil); eq(why, "notyours", "the Master Looter can't say what someone else got without being told by them")
    local ok = sim.engine:Append("main", "DisenchantResult", { disenchant = ev.id, results = results, requestedBy = de })
    assert(ok, "reported by the disenchanter, written by the Master Looter")
    eq(sim.engine:Get("main").state.disenchants[ev.id].result[1].name, "Strange Dust")
    eq(table.concat(sim.engine:Get("main").state.order, ","), before, "it moves nobody")
    local _, again = sim.engine:Append("main", "DisenchantResult", { disenchant = ev.id, results = results, requestedBy = de })
    eq(again, "alreadyrecorded")
end)

test("nonsense results and unknown disenchants are refused", function()
    local sim, _, _, de, ev = withDisenchant()
    local function try(d) local _, w = sim.engine:Append("main", "DisenchantResult", d); return w end
    eq(try({ disenchant = "nope", results = { { name = "X", count = 1 } }, requestedBy = de }), "nodisenchant")
    eq(try({ disenchant = ev.id, results = {}, requestedBy = de }), "badresults")
    eq(try({ disenchant = ev.id, results = { { name = "X", count = 0 } }, requestedBy = de }), "badresults")
    eq(try({ disenchant = ev.id, results = { { name = "", count = 1 } }, requestedBy = de }), "badresults")
end)

test("the disenchanted command reads results as typed or as links, and records them", function()
    local sim, ctx, cmd = raid()
    local c = cmd
    local r = c.parseResults("3 Strange Dust, Soul Dust x2, Lesser Magic Essence")
    eq(#r, 3); eq(r[1].count, 3); eq(r[1].name, "Strange Dust"); eq(r[2].count, 2); eq(r[2].name, "Soul Dust"); eq(r[3].count, 1)
    local links = c.parseResults("|cff1eff00|Hitem:10940::::::::|h[Strange Dust]|h|r x3")
    eq(links[1].item, 10940); eq(links[1].count, 3); eq(links[1].name, "Strange Dust")
    eq(c.parseResults("   "), nil)
    -- the Master Looter of this practice raid disenchants: the command writes it directly
    assert(sim:setDisenchanter(sim.learner))
    local ev = assert(sim.engine:Append("main", "Disenchant", { item = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r", to = sim.learner }))
    eq(#c.pendingDisenchants(), 1)
    cmd.handle("disenchanted 3 Strange Dust")
    eq(#c.pendingDisenchants(), 0, "recorded: nothing waiting any more")
    eq(sim.engine:Get("main").state.disenchants[ev.id].result[1].count, 3)
    ctx.client.printed = {}
    cmd.handle("disenchanted 1 Soul Dust")
    assert(table.concat(ctx.client.printed, "\n"):find("Nothing is waiting"), "nothing left to record is said plainly")
end)

test("History shows one line per disenchant: waiting, then what it gave", function()
    local sim, ctx, cmd, de = withDisenchant()
    local function lines()
        local h = GuildBook.History(ctx, { text = "Linen Cloth" })
        return h
    end
    local h = lines()
    eq(h.total, 1); assert(h.entries[1].text:find("to disenchant") and h.entries[1].text:find("waiting for the result"), h.entries[1].text)
    assert(sim.engine:Append("main", "DisenchantResult", { disenchant = h.entries[1].id, results = { { name = "Strange Dust", count = 3 } }, requestedBy = de }))
    h = lines()
    eq(h.total, 1, "the result updates the line, it is not a second one")
    assert(h.entries[1].text:find("disenchanted") and h.entries[1].text:find("3 Strange Dust"), h.entries[1].text)
    assert(not h.entries[1].text:find("waiting"))
end)

test("practice: a disenchanter reports a result a few seconds after being given the item", function()
    local sim, _, _, de, ev = withDisenchant()
    sim.engine:Append("main", "Disenchant", { item = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r", to = de })
    sim:advance(10)
    local n = 0
    for _, d in pairs(sim.engine:Get("main").state.disenchants) do if d.result then n = n + 1 end end
    assert(n >= 1, "the practice raid's disenchanter said what they got")
    eq(Standings.ResultText({ { name = "Strange Dust", count = 3 }, { name = "Soul Dust", count = 1 } }), "3 Strange Dust, 1 Soul Dust")
end)

test("the loot window a disenchant opens is recorded against the oldest item waiting, and any other loot is ignored", function()
    local sim, _, cmd = raid()
    assert(sim:setDisenchanter(sim.learner))
    -- nothing waiting: the loot of an ordinary disenchant is ignored without a word
    sim.client:emit("disenchant.loot", { slots = { { link = "|cff1eff00|Hitem:10940::::::::|h[Strange Dust]|h|r", itemId = 10940, quantity = 2 } } })
    local ev = assert(sim.engine:Append("main", "Disenchant", { item = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r", to = sim.learner }))
    sim.client:emit("disenchant.loot", { slots = { { link = "|cff1eff00|Hitem:10940::::::::|h[Strange Dust]|h|r", itemId = 10940, quantity = 2 } } })
    local r = sim.engine:Get("main").state.disenchants[ev.id].result
    assert(r and r[1].name == "Strange Dust" and r[1].count == 2 and r[1].item == 10940, "recorded from the game's loot window")
    assert(cmd.pendingDisenchants, "(the command object keeps the helpers)")
end)

H.section("Ledger: people in their class colors")
test("a sentence is cut into words and people, whole names only, never inside an item link", function()
    local people = {
        { name = "Aldric Stormwind", class = "WARRIOR", color = "c79c6e" },
        { name = "Aldric", class = "MAGE", color = "69ccf0" },
        { name = "Me", class = "PRIEST", color = "ffffff" },
    }
    local segs = GuildBook.Segments("Aldric Stormwind won |cffffffff|Hitem:1::::::::|h[Blade of Aldric]|h|r for Me, not Aldricson", people)
    local who, plain = {}, {}
    for _, s in ipairs(segs) do if s.who then who[#who + 1] = s.who.name else plain[#plain + 1] = s.text end end
    eq(table.concat(who, "|"), "Aldric Stormwind|Me", "the longer name wins over the shorter one inside it; the item's name and 'Aldricson' are not people")
    eq(segs[1].who.color, "c79c6e")
    eq(table.concat(plain), " won |cffffffff|Hitem:1::::::::|h[Blade of Aldric]|h|r for , not Aldricson", "the rest is kept exactly as written")
    eq(#GuildBook.Segments("nothing here", people), 1)
end)

test("each ledger entry carries its pieces, with a player's class from the list", function()
    local _, ctx, cmd = raid()
    cmd.handle("move Me 1 coloring")
    local h = GuildBook.History(ctx, { text = "coloring" })
    local found
    for _, s in ipairs(h.entries[1].segments) do if s.who and s.who.name == "Me" then found = s.who end end
    assert(found and found.class and found.color, "'Me' is a known player with a class color")
end)

test("an entry's detail is the raw record: kind, writer, time, id, list and every field", function()
    local sim, ctx, cmd = raid()
    cmd.handle("move Me 1 for the details")
    local h = GuildBook.History(ctx, { text = "for the details" })
    local d = GuildBook.Detail(ctx, h.entries[1].id)
    local by = {}
    for _, l in ipairs(d) do by[l.label] = l.value end
    assert(by.Entry:find("MovePlayer") and by.Entry:find("list change"), by.Entry)
    eq(by["Written by"], "Me"); assert(by.When:find("just now") or by.When:find("ago"), by.When)
    eq(by.List, "main"); assert(by.Id:find("#" .. h.entries[1].id, 1, true), by.Id)
    eq(by.reason, "for the details"); eq(by.member, "Me")
    eq(GuildBook.Detail(ctx, "no-such-entry"), nil)
    -- a list of results reads as words
    local de = sim:disenchanterName()
    local ev = assert(sim.engine:Append("main", "Disenchant", { item = "Linen Cloth", to = de }))
    local r = assert(sim.engine:Append("main", "DisenchantResult", { disenchant = ev.id, results = { { name = "Strange Dust", count = 3 } }, requestedBy = de }))
    for _, l in ipairs(GuildBook.Detail(ctx, r.id)) do by[l.label] = l.value end
    eq(by.results, "3 Strange Dust")
end)

H.section("Staged list changes")
test("staged moves and removals are simulated in order, so the preview is what will be written", function()
    local order0 = { "A", "B", "C", "D", "E" }
    local ops = {}
    assert(GuildBook.StageMove(ops, order0, "C", 1))
    eq(table.concat(GuildBook.Simulate(order0, ops), ""), "CABDE")
    assert(GuildBook.StageMove(ops, order0, "E", 2)); eq(#ops, 2)
    eq(table.concat(GuildBook.Simulate(order0, ops), ""), "CEABD", "the second move is made against the list the first left")
    GuildBook.StageRemove(ops, "A")
    eq(table.concat(GuildBook.Simulate(order0, ops), ""), "CEBD")
    -- re-staging a player replaces their move where it stood; staging the place they already hold clears it
    assert(GuildBook.StageMove(ops, order0, "C", 4)); eq(#ops, 3)
    eq(table.concat(GuildBook.Simulate(order0, ops), ""), "EBDC", "C now goes to 4, where it stood in the sequence, so E and the removal still follow it")
    eq(GuildBook.StageMove(ops, order0, "C", 3), false, "C already holds place 3 where its move stood: that clears it"); eq(#ops, 2)
    GuildBook.Unstage(ops, "A"); GuildBook.Unstage(ops, "E"); eq(#ops, 0)
    eq(GuildBook.StageMove(ops, order0, "B", 2), false, "staging the place they hold stages nothing"); eq(#ops, 0)
end)

test("the preview marks a moved player and drops a removed one; the pending line and commands say exactly what will be written", function()
    local rows = {}
    for i, n in ipairs { "A", "B", "C" } do rows[i] = { pos = i, who = n, name = n } end
    local ops = {}
    GuildBook.StageMove(ops, { "A", "B", "C" }, "C", 1)
    GuildBook.StageRemove(ops, "B")
    local p = GuildBook.Preview(rows, ops)
    eq(#p, 2); eq(p[1].who, "C"); eq(p[1].shown, 1); eq(p[1].pos, 3); assert(p[1].moving); eq(p[2].who, "A")
    eq(GuildBook.PendingText({}):find("No pending") ~= nil, true)
    eq(GuildBook.PendingText(ops), "2 pending changes: C to place 1; remove B")
    local cmds, why = GuildBook.Commands(ops, "  ")
    eq(cmds, nil); assert(why:find("reason"))
    cmds = GuildBook.Commands(ops, " fixing the list ")
    eq(cmds[1], "move C 1 fixing the list"); eq(cmds[2], "remove B fixing the list")
    eq(GuildBook.Preview(rows, {}), rows, "nothing staged: the rows as they are")
end)
