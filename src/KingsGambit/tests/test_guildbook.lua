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
    eq(GuildBook.SECTIONS[1].id, "lists"); eq(GuildBook.SECTIONS[2].id, "thisraid"); eq(GuildBook.SECTIONS[3].id, "ledger"); eq(GuildBook.SECTIONS[3].label, "Ledger")
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

H.section("Ledger: trying an item on")
test("an entry about an item carries it (a link, or item:ID), a disenchant result carries the item it came from, a plain name carries nothing", function()
    local sim, ctx, cmd = raid()
    local link = "|cffa335ee|Hitem:16837::::::::|h[Earthfury Boots]|h|r"
    local ev = assert(sim.engine:Append("main", "Disenchant", { item = link, to = sim:disenchanterName() }))
    local r = assert(sim.engine:Append("main", "DisenchantResult", { disenchant = ev.id, results = { { name = "Strange Dust", count = 1 } }, requestedBy = sim:disenchanterName() }))
    local view = ctx.engine:View()
    eq(GuildBook.ItemOf(ev, view), link); eq(GuildBook.ItemOf(r, view), link, "the result belongs to the item that was disenchanted")
    eq(GuildBook.ItemOf({ type = "Award", data = { item = "item:1234" } }, view), "item:1234")
    eq(GuildBook.ItemOf({ type = "Award", data = { item = 5678 } }, view), "item:5678")
    eq(GuildBook.ItemOf({ type = "Award", data = { item = "Linen Cloth" } }, view), nil, "a plain name has nothing to look up")
    eq(GuildBook.ItemOf({ type = "MovePlayer", data = { member = "A" } }, view), nil)
    local h = GuildBook.History(ctx, { text = "Earthfury" })
    eq(h.entries[1].item, link, "the row carries it, so a click can try it on")
    local _, item = GuildBook.Detail(ctx, h.entries[1].id)
    eq(item, link, "and so does the detail panel")
end)

test("trying an item on opens the game's dressing room with it, and says so when the game can't", function()
    local UI = SK.modules.UI
    local saved, said = _G.DressUpItemLink, nil
    local got
    _G.DressUpItemLink = function(link) got = link; return true end
    assert(UI.TryOn("|cffa335ee|Hitem:16837::::::::|h[Earthfury Boots]|h|r")); assert(got:find("16837", 1, true))
    eq(UI.TryOn(nil), false)
    _G.DressUpItemLink = nil
    local savedSay, savedLink = UI.Say, _G.DressUpLink
    _G.DressUpLink = nil
    UI.Say = function(t) said = t end
    eq(UI.TryOn("item:1"), false); assert(said and said:find("dressing room"), tostring(said))
    UI.Say, _G.DressUpItemLink, _G.DressUpLink = savedSay, saved, savedLink
end)

H.section("Ledger: passes are kept but not shown by default")
test("passes stay in the record but are left out of 'what happened'; an undecided gift counts as what happened", function()
    local sim, ctx = raid()
    local link = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r"
    local who = sim.engine:Get("main").state.order[1]
    assert(sim.engine:Append("main", "Pass", { member = who, item = link, kind = "upgrade" }))
    assert(sim.engine:Append("main", "Pass", { member = who, item = link .. "x", kind = "undecided" }))
    assert(sim.engine:Append("main", "Award", { member = who, item = link .. "y" }))
    local function count(kind, text)
        local h = GuildBook.History(ctx, { kind = kind, text = text })
        return h.total
    end
    eq(count(nil, "passed on"), 1, "by default only the undecided gift, which is an outcome, shows")
    eq(count("happened", "upgrade"), 0)
    eq(count("passes", "passed on"), 1, "'Passes' shows the passes")
    eq(count("all", "passed on"), 2, "'Everything' shows both")
    eq(count("loot", "won"), 2, "the award and the undecided gift are both loot")
    eq(GuildBook.KindOf("Pass", { kind = "upgrade" }), "passes"); eq(GuildBook.KindOf("Pass", { kind = "undecided" }), "loot")
    eq(GuildBook.KINDS[1].id, "happened"); eq(GuildBook.KINDS[#GuildBook.KINDS].id, "all")
end)

H.section("Stats: who held which place, and for how long")
test("a player's places are replayed from the entries' own times, with how long each lasted", function()
    local sim, ctx = raid()
    local order = {}
    for i, n in ipairs(sim.engine:Get("main").state.order) do order[i] = n end
    local who, other = order[5], order[1]
    sim.client:advance(1000)
    assert(sim.engine:Append("main", "MovePlayer", { member = who, to = "top", reason = "test" }))
    sim.client:advance(3600)
    local stats = GuildBook.Stats(ctx, "main")
    eq(stats.rows[1].who, who); eq(stats.rows[1].place, 1)
    eq(stats.rows[1].heldText, "1 hour", "first for an hour")
    eq(stats.rows[2].who, other, "the one who was first is second now")
    local h = GuildBook.PlaceHistory(stats, who)
    eq(h[1].place, 1); assert(h[1].text:find("place 1 for 1 hour") and h[1].text:find("(now)", 1, true), h[1].text)
    eq(h[2].place, 5); assert(h[2].text:find("place 5 for"), h[2].text)
    assert(stats.summary[1]:find("is first, and has been for 1 hour"), stats.summary[1])
end)

test("wins, last win and who has waited longest without one", function()
    local sim, ctx = raid()
    local winner = sim.engine:Get("main").state.order[1]
    sim.client:advance(86400)
    assert(sim.engine:Append("main", "Award", { member = winner, item = "|cffffffff|Hitem:2589::::::::|h[Linen Cloth]|h|r" }))
    sim.client:advance(7200)
    local stats = GuildBook.Stats(ctx, "main")
    local row
    for _, r in ipairs(stats.rows) do if r.who == winner then row = r end end
    eq(row.wins, 1); eq(row.lastWinText, "2 hours ago"); eq(row.place, stats.total, "a win drops to the bottom")
    eq(row.heldText, "2 hours")
    local joined = table.concat(stats.summary, " ")
    assert(joined:find("Most wins: " .. row.name .. " (1)", 1, true), joined)
    assert(joined:find("Waiting longest without a win", 1, true), joined)
    eq(GuildBook.Span(30), "under a minute"); eq(GuildBook.Span(86400 * 3), "3 days"); eq(GuildBook.Span(3600), "1 hour")
end)

test("a player taken off the list keeps their earlier places in the record", function()
    local sim, ctx = raid()
    local who = sim.engine:Get("main").state.order[3]
    sim.client:advance(600)
    assert(sim.engine:Append("main", "RemoveMember", { member = who, reason = "left the guild" }))
    local stats = GuildBook.Stats(ctx, "main")
    for _, r in ipairs(stats.rows) do assert(r.who ~= who, "no longer in the table") end
    local h = GuildBook.PlaceHistory(stats, who)
    eq(#h, 1); assert(h[1].left and h[1].text:find("taken off the list"), h[1].text)
end)

H.section("Attendance: who was in the raid")
local function rosterNames(sim)
    local names = {}
    for _, m in ipairs(sim.client:roster()) do names[#names + 1] = m.name end
    return names
end

test("a raid officially starts at its first kill (a boss or trash): then everyone there is written down, in small entries, and the Ledger's default view leaves them out", function()
    local sim = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 40 })
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local ctx = { client = sim.client, engine = sim.engine, commands = Commands.New({ client = sim.client, engine = sim.engine, host = host }), sim = sim, host = host }
    eq(next(sim.engine:Present("sim")), nil, "nothing is written before the first boss has died")
    eq(sim.engine:View().attendance["sim"], nil)
    sim:killBoss(nil, false)
    local present = sim.engine:Present("sim")
    local n = 0
    for _ in pairs(present) do n = n + 1 end
    eq(n, #rosterNames(sim), "everyone in the group is in the raid")
    local entries = sim.engine:View().attendance["sim"]
    assert(#entries >= 2, "a big group takes several small entries")
    for _, ev in ipairs(entries) do assert(#(ev.data.joined or {}) + #(ev.data.left or {}) <= 12, "each entry stays small") end
    eq(GuildBook.History(ctx, { text = "were in the raid" }).total, 0, "not in What happened")
    assert(GuildBook.History(ctx, { kind = "attendance" }).total >= 2, "but under Attendance")
    assert(GuildBook.History(ctx, { kind = "all", text = "in the raid" }).total >= 2, "and Everything")
end)

test("someone who leaves mid-raid is written as having left, and their time in the raid shows in the stats", function()
    local sim, ctx = raid()
    local names = rosterNames(sim)
    local leaver = names[3]
    sim.client:advance(5000) -- (time spent gathering before the first kill doesn't count)
    sim:killBoss(nil, false)
    sim.client:advance(3600)
    local keep = {}
    for _, nm in ipairs(names) do if nm ~= leaver then keep[#keep + 1] = nm end end
    sim.client:setRaid(keep, { leader = sim:leaderName(), lootMethod = "master", masterLooter = sim.ml })
    sim.client:advance(10) -- (the change settles a few seconds before it is written)
    assert(not sim.engine:Present("sim")[leaver], "no longer in the raid")
    sim.client:advance(3600)
    local stats = GuildBook.Stats(ctx, sim.engine:RaidList() or "main")
    eq(stats.attendance.total, 1)
    local p = stats.attendance.byPlayer[leaver]
    assert(p and p.attended == 1 and p.leftEarly == 1, "attended, and left early")
    assert(p.percent >= 40 and p.percent <= 60, "in for about half the raid: " .. tostring(p.percent))
    local stayer = stats.attendance.byPlayer[keep[1]]
    assert(stayer.percent >= 95 and stayer.leftEarly == 0, "someone who stayed: " .. tostring(stayer.percent))
    for _, r in ipairs(stats.rows) do if r.who == leaver then eq(r.raidsText, "1/1") end end
    local lines = GuildBook.AttendanceLines(stats, leaver)
    assert(lines[1]:find("left early"), lines[1])
    local left = GuildBook.History(ctx, { kind = "attendance", text = "left the raid" })
    eq(left.total, 1)
end)

test("only the raid's Master Looter can say who was in it, and only for a raid that exists", function()
    local sim = raid()
    local ev, why = sim.engine:Write("Attendance", { raid = "no-such-raid", joined = { "Someone_Else" } })
    eq(ev, nil); eq(why, "badattendance")
    ev, why = sim.engine:Write("Attendance", { raid = "sim" })
    eq(ev, nil); eq(why, "badattendance", "an entry that says nobody joined or left says nothing")
    assert(sim.engine:Write("Attendance", { raid = "sim", joined = { "New_Raider" } }))
end)

test("a raid from before attendance was written is not counted, so nobody is marked absent from it", function()
    local sim, ctx = raid()
    local ml = sim.ml
    local att = GuildBook.Attendance(ctx, "main")
    assert(att.total >= 0)
    local stats = GuildBook.Stats(ctx, "main")
    for _, r in ipairs(stats.rows) do assert(r.raidsText == "-" or r.raidsText:find("/"), r.raidsText) end
    assert(ml)
end)

test("opening a loot window or a successful encounter also starts the raid, an unsuccessful one does not", function()
    local sim = raid()
    local function started() return sim.engine:View().attendance["sim"] ~= nil end
    sim.client:emit("encounter.ended", { id = 1, name = "Wipe", success = false })
    sim.client:advance(10)
    eq(started(), false, "a wipe isn't a kill")
    sim.client:emit("loot.opened", { slots = {} })
    eq(started(), false, "an empty loot window isn't either")
    sim.client:emit("loot.opened", { slots = { { slot = 1, link = "|Hitem:1|h[X]|h", quantity = 1 } } })
    eq(started(), true, "looting a corpse (trash or boss) starts the raid")
end)

test("a kill in the open world doesn't start the raid; the Master Looter starts it by hand (a world boss)", function()
    local sim, ctx, cmd = raid()
    local function started() return sim.engine:View().attendance["sim"] ~= nil end
    sim.client:setInInstance(false)
    sim.client:emit("loot.opened", { slots = { { slot = 1, link = "|Hitem:1|h[X]|h", quantity = 1 } } })
    sim.client:emit("encounter.ended", { id = 9, name = "Azuregos", success = true })
    sim.client:advance(10)
    eq(started(), false, "outside an instance nothing starts it by itself")
    -- the loot session of a world boss also leaves it alone
    eq(sim.attendance:enemyKilled(), 0)
    ctx.client.printed = {}
    cmd.raid = nil
    local c = Commands.New({ client = sim.client, engine = sim.engine, host = ctx.host, attendance = sim.attendance })
    c.handle("raid start")
    eq(started(), true, "'raid start' starts it, wherever it is")
    local first = table.concat(sim.client.printed, "\n")
    assert(first:find("The raid has started"), first)
    sim.client.printed = {}
    c.handle("raid start")
    assert(table.concat(sim.client.printed, "\n"):find("already started"), "a second start says so")
    sim.client:setInInstance(true)
end)

test("inside an instance the first kill starts it as before", function()
    local sim = raid()
    sim.client:setInInstance(true)
    sim.client:emit("loot.opened", { slots = { { slot = 1, link = "|Hitem:1|h[X]|h", quantity = 1 } } })
    assert(sim.engine:View().attendance["sim"] ~= nil)
end)

test("with the automatic start off, nothing starts the raid but the Master Looter saying so; the setting is remembered and can be read back", function()
    local sim, ctx = raid()
    local c = Commands.New({ client = sim.client, engine = sim.engine, host = ctx.host, attendance = sim.attendance })
    local function started() return sim.engine:View().attendance["sim"] ~= nil end
    eq(sim.attendance:auto(), true, "on by default")
    c.handle("raid autostart off")
    eq(sim.attendance:auto(), false)
    assert(sim.client:storage().char.attendanceAuto == false, "kept with the character's settings")
    sim.client:emit("loot.opened", { slots = { { slot = 1, link = "|Hitem:1|h[X]|h", quantity = 1 } } })
    sim:killBoss(nil, false)
    sim.client:advance(10)
    eq(started(), false, "a kill, a loot window and a loot session all leave it alone")
    sim.client.printed = {}
    c.handle("raid autostart")
    assert(table.concat(sim.client.printed, "\n"):find("only when you say so"), "an empty autostart says the setting")
    c.handle("raid start")
    eq(started(), true, "'raid start' still starts it")
    c.handle("raid autostart on")
    eq(sim.attendance:auto(), true)
    sim.client.printed = {}
    c.handle("raid autostart maybe")
    assert(table.concat(sim.client.printed, "\n"):find("raid autostart %[on|off%]"), table.concat(sim.client.printed, "\n"))
end)

test("the Raids panel says where the raid stands and what can be done about it", function()
    local sim, ctx = raid()
    ctx.attendance = sim.attendance
    local rs = GuildBook.RaidStart(ctx)
    eq(rs.running, true); eq(rs.started, false); eq(rs.canStart, true); eq(rs.auto, true)
    assert(rs.text:find("first enemy killed") and rs.text:find("by itself"), rs.text)
    sim.client:setInInstance(false)
    assert(GuildBook.RaidStart(ctx).text:find("Not in an instance"), GuildBook.RaidStart(ctx).text)
    sim.attendance:setAuto(false)
    rs = GuildBook.RaidStart(ctx)
    eq(rs.auto, false); assert(rs.text:find("Waiting for you"), rs.text); eq(rs.canStart, true)
    sim.attendance:start()
    rs = GuildBook.RaidStart(ctx)
    eq(rs.started, true); eq(rs.canStart, false, "already started")
    assert(rs.text:find("Started") and rs.text:find("in the raid now"), rs.text)
    sim.client:setInInstance(true); sim.attendance:setAuto(true)
    -- not running a raid, or no writer at all
    local other = GuildBook.RaidStart({ attendance = nil, client = sim.client })
    eq(other.available, false); eq(other.canStart, false)
end)

H.section("This raid: the open raid in numbers")
test("the open raid: not started, then how long it has run, what is held with its trade time, and what has been handed out", function()
    local sim, ctx = raid()
    local r = GuildBook.RaidNow(ctx)
    eq(r.running, true); eq(r.started, false); eq(r.mine, true); eq(r.handedOut, 0)
    assert(r.lines[2]:find("Not started yet"), r.lines[2])
    -- a boss dies and its loot is held (not handed out yet): the raid starts, two items are held, and their trade window runs two hours
    sim:killBoss(nil, true)
    sim.client:advance(1800)
    r = GuildBook.RaidNow(ctx)
    eq(r.started, true); eq(r.elapsed, 1800)
    assert(r.lines[2]:find("Started 30 minutes ago"), r.lines[2])
    assert(#r.held >= 1, "the held loot is counted")
    assert(r.lines[4]:find("Still to hand out: %d+ item"), r.lines[4])
    assert(r.nextExpiry and r.nextExpiry.seconds == 7200 - 1800, "trade time left: " .. tostring(r.nextExpiry and r.nextExpiry.seconds))
    assert(r.lines[5]:find("earliest trade window closes in 1 hour"), r.lines[5])
    local held = #r.held
    -- hand it all out: the awards count, and nothing is held
    sim.autoLearner = true
    assert(sim:handOut()); assert(sim:runUntil("review", 900)); assert(sim.session:confirm())
    r = GuildBook.RaidNow(ctx)
    assert(r.handedOut >= held, "everything held has been handed out: " .. r.handedOut .. " of " .. held)
    eq(r.awards + r.disenchants, r.handedOut)
    eq(#r.held, 0); assert(r.lines[4]:find("nothing held"), r.lines[4])
    -- the raid's part of the ledger starts when it started, and has the awards in it
    local h = GuildBook.History(ctx, r.filter)
    assert(h.total >= r.handedOut, "the raid's ledger has what was handed out")
    local before = GuildBook.History(ctx, { kind = "happened" }).total
    assert(h.total <= before)
end)

test("someone else's raid shows its length and what was handed out, but not what is held", function()
    local sim, ctx = raid()
    ctx.client = sim.client
    sim:killBoss(nil, false)
    local other = setmetatable({ me = function() return "Somebody_Else" end }, { __index = sim.client })
    local view = GuildBook.RaidNow({ engine = sim.engine, client = other, sim = nil })
    eq(view.mine, false); assert(view.lines[4]:find("only known to the Master Looter"), view.lines[4]); eq(view.held, nil)
    eq(GuildBook.RaidNow({ engine = sim.engine, client = sim.client }).mine, true)
end)

H.section("Practice: more than one raid")
test("a practice night runs raid after raid: open, kill, hand out, people come and go, end, days pass, the next opens", function()
    local sim, ctx = raid()
    local function handOutAll()
        sim.autoLearner = true
        assert(sim:handOut()); assert(sim:runUntil("review", 900)); assert(sim.session:confirm())
    end
    eq(sim:raidOpen(), true); eq(sim.raidNo, 1)
    -- raid 1: a boss dies (holding its loot), someone leaves, the loot is handed out
    sim:killBoss(nil, true)
    local leaver = assert(sim:leave())
    sim.client:advance(30)
    assert(not sim.engine:Present("sim")[leaver], "the addon wrote down that they left")
    -- the raid can't end with loot held or a session running
    eq(select(2, sim:endRaid()), "held")
    handOutAll()
    assert(sim:rejoin() == leaver, "the one who left is back")
    sim.client:advance(30)
    assert(sim.engine:Present("sim")[leaver], "and written as back")
    assert(sim:endRaid()); eq(sim:raidOpen(), false)
    local k, why = sim:killBoss()
    eq(k, nil); eq(why, "noraid", "no kills without an open raid")
    -- raid 2, days later
    local before = sim.client:serverTime()
    eq(sim:openRaid(), 2); eq(sim:raidOpen(), true); eq(sim.raidId, "sim2")
    assert(sim.client:serverTime() - before >= 3 * 86400, "days passed")
    eq(sim.bossIndex, 0, "the bosses are back")
    assert(sim:absentCount() >= 1, "a few raiders can't make it")
    eq(sim.engine:View().attendance["sim2"], nil, "the new raid hasn't started")
    sim:killBoss(nil, false)
    assert(sim.engine:View().attendance["sim2"], "its first kill starts it")
    assert(sim:runUntil("review", 900)); assert(sim.session:confirm())
    assert(sim:endRaid())
    -- the ledger now covers two raids: Stats counts both, and someone who missed the second shows 1 of 2
    local stats = GuildBook.Stats(ctx, "main")
    eq(stats.attendance.total, 2)
    local missed
    for name in pairs(sim.absent) do missed = name end
    eq(stats.attendance.byPlayer[missed] and stats.attendance.byPlayer[missed].attended, 1, "was in raid 1, not raid 2")
    for _, r in ipairs(stats.rows) do if r.who == missed then eq(r.raidsText, "1/2") end end
    eq(GuildBook.RaidNow(ctx).running, false, "no raid is open now")
end)

test("the practice window ends and opens raids, and has people leave and return", function()
    local UI = SK.modules.UI
    local sim = Sim.NewMoltenCore({ learner = "Me", seed = 1, size = 10 })
    UI.practice = { engine = sim.engine, client = sim.client, commands = Commands.New({ client = sim.client, engine = sim.engine, host = { on = function() end }, attendance = sim.attendance }),
        sim = sim, host = { on = function() end }, attendance = sim.attendance }
    local said = {}
    local oldSay = UI.Say
    local model = SK.modules.UILoot.Model(UI.practice)
    eq(model.night.raidOpen, true); eq(model.night.raidNo, 1)
    UI:PracticeLeave()
    assert(SK.modules.UILoot.Model(UI.practice).night.absent == 1)
    UI:PracticeRejoin()
    eq(SK.modules.UILoot.Model(UI.practice).night.absent, 0)
    UI:PracticeEndRaid()
    eq(SK.modules.UILoot.Model(UI.practice).night.raidOpen, false)
    UI:PracticeOpenRaid()
    local n = SK.modules.UILoot.Model(UI.practice).night
    eq(n.raidOpen, true); eq(n.raidNo, 2)
    UI.practice = nil
end)
