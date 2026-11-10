-- Who a character is: first and last name (src/ledger/Identity.lua). There are no realms in WoW: Forever.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Identity, MockClient, Engine, Commands = SK.modules.Identity, SK.modules.MockClient, SK.modules.Engine, SK.modules.Commands

H.section("Identity: first and last name")
test("every way of writing a name becomes one canonical identity, and displays as First Last", function()
    eq(Identity.Normalize("Aldric Stormwind"), "Aldric_Stormwind"); eq(Identity.Normalize("Aldric_Stormwind"), "Aldric_Stormwind")
    eq(Identity.Normalize("  Aldric \t Stormwind  "), "Aldric_Stormwind"); eq(Identity.Normalize("Aldric-Stormwind"), "Aldric_Stormwind")
    eq(Identity.Normalize("Aldric"), "Aldric", "a single name stands for itself"); eq(Identity.Normalize(""), nil); eq(Identity.Normalize("  - _ "), nil); eq(Identity.Normalize(nil), nil)
    eq(Identity.Normalize("Zo\195\171 Mal\195\168s"), "Zo\195\171_Mal\195\168s", "accented letters are left alone")
    eq(Identity.Display("Aldric_Stormwind"), "Aldric Stormwind"); eq(Identity.Display("Aldric"), "Aldric"); eq(Identity.Display(nil), nil)
    eq(Identity.First("Aldric_Stormwind"), "Aldric"); eq(Identity.Last("Aldric_Stormwind"), "Stormwind"); eq(Identity.Last("Aldric"), nil)
    eq(Identity.Key("Aldric_STORMWIND"), "aldric_stormwind"); assert(Identity.Equal("Aldric_Stormwind", "aldric_stormwind")); assert(not Identity.Equal("Aldric_Stormwind", "Aldric_Ironforge"))
    assert(Identity.Valid("Aldric_Stormwind") and Identity.Valid("Aldric"))
    for _, bad in ipairs { "", "Aldric Stormwind", "Aldric-Stormwind", "_Aldric", "Aldric_", "Aldric__Stormwind" } do assert(not Identity.Valid(bad), "not canonical: '" .. bad .. "'") end
end)

test("two characters who share a first name are two identities (the pair is what is unique)", function()
    assert(Identity.Normalize("Aldric Stormwind") ~= Identity.Normalize("Aldric Ironforge"))
    local ids = {}
    for _, n in ipairs { "Aldric Stormwind", "Aldric Ironforge", "Brann Stormwind" } do ids[Identity.Normalize(n)] = true end
    local n = 0 for _ in pairs(ids) do n = n + 1 end
    eq(n, 3)
end)

test("the game's surname separator is learned by comparing a name with its link form, whatever the separator is", function()
    local sep, link = Identity.LearnSeparator("Aldric\194\183Stormwind", "Aldric~Stormwind")
    eq(sep, "\194\183"); eq(link, "~")
    eq(Identity.LearnSeparator("Aldric Stormwind", "Aldric_Stormwind"), " ")
    eq(Identity.LearnSeparator("Aldric", "Aldric"), nil, "no surname separator: nothing to learn")
    eq(Identity.LearnSeparator(nil, "x"), nil)
    eq(Identity.Normalize("Aldric\194\183Stormwind", { "\194\183" }), "Aldric_Stormwind", "split on the learned separator")
    eq(Identity.Normalize("Aldric\226\128\167Stormwind", { "\226\128\167" }), "Aldric_Stormwind", "even a separator we never imagined")
end)

test("words that make a known name are joined, quoted names too, and free text after the names is left alone", function()
    local known = { Aldric_Stormwind = true, Brann_Ironforge = true, Cass = true }
    eq(Identity.JoinNames("gift Aldric Stormwind Brann Ironforge a gift", known), "gift Aldric_Stormwind Brann_Ironforge a gift")
    eq(Identity.JoinNames('trade "Aldric Stormwind" Cass he traded it', known), "trade Aldric_Stormwind Cass he traded it")
    eq(Identity.JoinNames("trade aldric stormwind cass", known), "trade aldric_stormwind cass", "capitals don't matter")
    eq(Identity.JoinNames("undo Cass", known), "undo Cass"); eq(Identity.JoinNames("", known), "")
    eq(Identity.JoinNames("award Cass a sword for Aldric Stormwind", known), "award Cass a sword for Aldric Stormwind", "past the names: a reason is not rewritten")
end)

H.section("Identity: in the text interface")
test("a command names a character with a first and last name, quoted, joined or with an underscore, and history reads First Last", function()
    local client = MockClient.New({ name = "Aldric Stormwind", seed = 3 })
    client:setRaid({ "Aldric Stormwind", "Brann Ironforge", "Cass Dawn" }, { leader = "Aldric Stormwind" })
    local engine = Engine.New(client)
    local cmd = Commands.New({ client = client, engine = engine })
    local function say(line) client.printed = {}; cmd.handle(line); return table.concat(client.printed, "\n") end
    say("create main The List")
    for _, who in ipairs { "Aldric Stormwind", "Brann Ironforge", "Cass Dawn" } do say("add " .. who) end
    local order = table.concat(engine:Get("main").state.order, ",")
    eq(order, "Aldric_Stormwind,Brann_Ironforge,Cass_Dawn")
    local out = say("standings")
    assert(out:find("Aldric Stormwind", 1, true) and out:find("Brann Ironforge", 1, true), out)
    say("move Brann Ironforge top fixing a mistake"); eq(table.concat(engine:Get("main").state.order, ","), "Brann_Ironforge,Aldric_Stormwind,Cass_Dawn")
    say('move "Cass Dawn" top again'); eq(table.concat(engine:Get("main").state.order, ","), "Cass_Dawn,Brann_Ironforge,Aldric_Stormwind")
    say("move Aldric_Stormwind top underscore form"); eq(engine:Get("main").state.order[1], "Aldric_Stormwind")
    local history = say("history 3")
    assert(history:find("Cass Dawn", 1, true) or history:find("Aldric Stormwind", 1, true), history)
    assert(not history:find("_", 1, true), "history never shows the underscore form: " .. history)
end)
