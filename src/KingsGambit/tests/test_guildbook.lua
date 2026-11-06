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
    eq(g.id, "awards"); eq(g.actions[1].id, "award"); eq(#g.actions, 4)
end)
