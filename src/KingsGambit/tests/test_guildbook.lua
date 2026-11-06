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
test("the sections are Lists, History and Tools, each explained", function()
    eq(GuildBook.SECTIONS[1].id, "lists"); eq(GuildBook.SECTIONS[2].id, "history")
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
