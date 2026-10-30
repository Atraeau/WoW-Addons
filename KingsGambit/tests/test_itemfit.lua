-- Item fit: who may bid on an item (a rule: its own "Classes:" line, a token's class group, or the guild's rule set
-- ahead of time), and which specs it suits (baked-in suggestions, never a rule).
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local ItemFit, MockClient, Engine, Loot, Commands = SK.modules.ItemFit, SK.modules.MockClient, SK.modules.Engine,
    SK.modules.Loot, SK.modules.Commands
local Sync, SimNetwork = SK.modules.Sync, SK.modules.SimNetwork

-- Items as a raider would recognise them (stats rounded; ItemFit's keys).
local ARMOR, WEAPON = 4, 2
local ITEMS = {
    plateDps = { slot = "INVTYPE_CHEST", class = ARMOR, subclass = 4, stats = { str = 25, sta = 15, crit = 1, hit = 1, armor = 700 } },
    plateTank = { slot = "INVTYPE_LEGS", class = ARMOR, subclass = 4, stats = { sta = 30, defense = 12, dodge = 1, armor = 750 } },
    clothCaster = { slot = "INVTYPE_HEAD", class = ARMOR, subclass = 1, stats = { int = 15, sta = 12, sp = 30, spellhit = 1 } },
    clothHealer = { slot = "INVTYPE_HEAD", class = ARMOR, subclass = 1, stats = { int = 20, spi = 12, heal = 60, mp5 = 5 } },
    mailHealer = { slot = "INVTYPE_SHOULDER", class = ARMOR, subclass = 3, stats = { int = 14, sta = 10, heal = 40, mp5 = 6 } },
    leatherAgi = { slot = "INVTYPE_HAND", class = ARMOR, subclass = 2, stats = { agi = 20, sta = 10, hit = 1 } },
    frostCloth = { slot = "INVTYPE_WAIST", class = ARMOR, subclass = 1, stats = { int = 10, frost = 30, spellcrit = 1 } },
    dagger = { slot = "INVTYPE_WEAPON", class = WEAPON, subclass = 15, stats = { agi = 8, hit = 1, dps = 50 } },
    staff = { slot = "INVTYPE_2HWEAPON", class = WEAPON, subclass = 10, stats = { int = 25, sp = 50, dps = 55 } },
    shield = { slot = "INVTYPE_SHIELD", class = ARMOR, subclass = 6, stats = { sta = 15, block = 30, armor = 2500 } },
    libram = { slot = "INVTYPE_RELIC", class = ARMOR, subclass = 7, stats = {} },
    cloak = { slot = "INVTYPE_CLOAK", class = ARMOR, subclass = 1, stats = { agi = 12, sta = 8 } },
    trinket = { slot = "INVTYPE_TRINKET", class = ARMOR, subclass = 0, stats = {} },
}

local function suited(item)
    local out = {}
    for _, s in ipairs(ItemFit.Suits(item)) do out[s.spec .. " " .. s.class] = true end
    return out
end

H.section("Item fit: suggestions from stats")
test("plate with strength suits the plate melee specs; a priest can't wear it", function()
    local s = suited(ITEMS.plateDps)
    assert(s["Fury WARRIOR"] and s["Arms WARRIOR"] and s["Retribution PALADIN"], "melee plate")
    assert(not s["Protection WARRIOR"], "not a tank piece")
    eq(ItemFit.ForPlayer(ITEMS.plateDps, "PRIEST").usable, false)
    eq(select(2, ItemFit.CanUse(ITEMS.plateDps, "PRIEST")), "armor")
end)
test("defense plate suits the tanks", function()
    local s = suited(ITEMS.plateTank)
    assert(s["Protection WARRIOR"] and s["Protection PALADIN"], "tanks")
    assert(not s["Fury WARRIOR"])
end)
test("spell damage suits the casters; healing suits the healers", function()
    local caster, healer = suited(ITEMS.clothCaster), suited(ITEMS.clothHealer)
    assert(caster["Fire MAGE"] and caster["Shadow PRIEST"] and caster["Affliction WARLOCK"] and caster["Balance DRUID"], "casters")
    assert(not caster["Holy PRIEST"] or healer["Holy PRIEST"], "healing gear beats damage gear for healers")
    assert(healer["Holy PRIEST"] and healer["Restoration DRUID"] and healer["Holy PALADIN"] and healer["Restoration SHAMAN"], "healers")
    assert(not healer["Fire MAGE"], "a mage doesn't want healing")
    eq(ItemFit.ForPlayer(ITEMS.clothHealer, "PRIEST", "Shadow").rating ~= "good", true, "not for a shadow priest")
end)
test("school damage goes to that school: frost to frost mages first", function()
    local ranked = ItemFit.Ranked(ITEMS.frostCloth)
    eq(ranked[1].spec .. " " .. ranked[1].class, "Frost MAGE")
    eq(ItemFit.ForPlayer(ITEMS.frostCloth, "WARLOCK").rating ~= "good", true)
end)
test("mail healing gear: the shaman's first, wearable by a paladin, worthless to a hunter", function()
    eq(ItemFit.Ranked(ITEMS.mailHealer)[1].class, "SHAMAN")
    eq(ItemFit.ForPlayer(ITEMS.mailHealer, "PALADIN", "Holy").usable, true)
    eq(ItemFit.ForPlayer(ITEMS.mailHealer, "HUNTER").rating, "poor")
    eq(ItemFit.ForPlayer(ITEMS.mailHealer, "MAGE").usable, false, "mages wear cloth")
end)
test("agility leather suits rogues and cats; a warrior can wear it but values it less", function()
    local s = suited(ITEMS.leatherAgi)
    assert(s["Combat ROGUE"] and s["Feral (cat) DRUID"], "leather agility")
    local war = ItemFit.ForPlayer(ITEMS.leatherAgi, "WARRIOR")
    eq(war.usable, true); assert(war.rating ~= "good", "below plate")
end)
test("weapon and relic proficiency: no daggers for paladins, no staves for rogues, librams for paladins only", function()
    eq(ItemFit.CanUse(ITEMS.dagger, "PALADIN"), false); eq(ItemFit.CanUse(ITEMS.dagger, "ROGUE"), true)
    eq(ItemFit.CanUse(ITEMS.staff, "ROGUE"), false); eq(ItemFit.CanUse(ITEMS.staff, "PRIEST"), true)
    eq(ItemFit.CanUse(ITEMS.shield, "SHAMAN"), true); eq(ItemFit.CanUse(ITEMS.shield, "DRUID"), false)
    eq(ItemFit.CanUse(ITEMS.libram, "PALADIN"), true); eq(ItemFit.CanUse(ITEMS.libram, "SHAMAN"), false)
    eq(ItemFit.CanUse(ITEMS.cloak, "WARRIOR"), true, "a cloak is 'cloth' but everyone wears one")
end)
test("an item whose stats say nothing suggests nobody: the raid judges it", function()
    eq(#ItemFit.Suits(ITEMS.trinket), 0); eq(ItemFit.ForPlayer(ITEMS.trinket, "MAGE").rating, nil)
    eq(ItemFit.SuitsText(ITEMS.trinket), nil)
end)
test("every class has specs with a role, and class masks read back", function()
    for _, c in ipairs(ItemFit.CLASSES) do
        assert(#ItemFit.SPECS[c] >= 3, c)
        for _, s in ipairs(ItemFit.SPECS[c]) do assert(s.role and next(s.weights), c .. " " .. s.name) end
    end
    eq(table.concat(ItemFit.ClassesFromMask(1474), ","), "PALADIN,SHAMAN,MAGE,WARLOCK,DRUID", "the Bindings of Dominance group")
    eq(ItemFit.ClassesFromMask(0), nil)
end)

H.section("Item fit: reading the item from the game")
test("RealClient reads stats, equip effects and the Classes line from the tooltip", function()
    local E = H.newWowEnv(function(E)
        E.ITEM_CLASSES_ALLOWED = "Classes: %s"
        E.LOCALIZED_CLASS_NAMES_MALE = { PRIEST = "Priest", MAGE = "Mage", WARLOCK = "Warlock" }
        E.C_Item = { GetItemStats = function() return { ITEM_MOD_INTELLECT_SHORT = 18, ITEM_MOD_STAMINA_SHORT = 12, RESISTANCE0_NAME = 80 } end }
        E.C_TooltipInfo = { GetHyperlink = function() return { lines = {
            { leftText = "Robe of the Void" }, { leftText = "Classes: Priest, Mage, Warlock" },
            { leftText = "Equip: Increases damage and healing done by magical spells and effects by up to 33." },
            { leftText = "Equip: Improves your chance to hit with spells by 1%." },
            { leftText = "Equip: Increases damage done by Shadow spells and effects by up to 14." },
            { leftText = "Equip: Restores 4 mana per 5 sec." },
        } } end }
    end)
    local c = SK.modules.RealClient.New({ env = E })
    local st = c:itemStats("|Hitem:19000|h[Robe]|h")
    eq(st.stats.int, 18); eq(st.stats.sta, 12); eq(st.stats.armor, 80); eq(st.stats.sp, 33)
    eq(st.stats.spellhit, 1); eq(st.stats.shadow, 14); eq(st.stats.mp5, 4)
    eq(table.concat(st.classes, ","), "PRIEST,MAGE,WARLOCK")
end)
test("an item the game hasn't cached yet restricts nobody, until it is known", function()
    local client = MockClient.New({ name = "ML", realm = "Realm" })
    client:setItemInfo("item:5", { name = "Robe", equipLoc = "INVTYPE_CHEST", class = ARMOR, subclass = 1 }, { delayed = true })
    client:setItemStats("item:5", { stats = {}, classes = { "PRIEST" } })
    eq(ItemFit.Describe(client, "item:5"), nil)
    client:cacheItem("item:5")
    eq(ItemFit.Describe(client, "item:5").classes[1], "PRIEST")
end)

-- A Master Looter's session over a raid of known classes.
local ROSTER = { { name = "Wara", class = "WARRIOR" }, { name = "Pria", class = "PRIEST" }, { name = "Maga", class = "MAGE" },
    { name = "ML", class = "PALADIN" } }
local function session(itemStats, rule)
    local client = MockClient.New({ name = "ML", realm = "Realm" })
    client:setRaid(ROSTER, { leader = "ML", lootMethod = "master", masterLooter = "ML" })
    client:setItemInfo("item:7", { name = "Robe", equipLoc = "INVTYPE_CHEST", class = ARMOR, subclass = 1 })
    client:setItemStats("item:7", itemStats)
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    for _, m in ipairs(ROSTER) do engine:Append("main", "AddMember", { member = m.name .. "-Realm", class = m.class }) end
    if rule then assert(engine:Write("ItemClasses", rule)) end
    local s = Loot.NewSession(engine, { bidSeconds = 0 })
    assert(s:start({ { link = "item:7" } }))
    return s, engine, client
end

H.section("Item fit: the class rule in a loot session")
test("an item that names its classes takes need and off-spec bids from those classes only", function()
    local s = session({ stats = { int = 10 }, classes = { "PRIEST", "MAGE" } })
    eq(select(2, s:bid("Wara", 1, "need")), "wrongclass"); eq(select(2, s:bid("Wara", 1, "off")), "wrongclass")
    assert(s:bid("Pria", 1, "need")); assert(s:bid("Maga", 1, "off")); assert(s:bid("Wara", 1, "pass"), "anyone may pass")
end)
test("gifting doesn't get around it, in either direction", function()
    local s = session({ stats = {}, classes = { "PRIEST", "MAGE" } })
    eq(select(2, s:bid("Wara", 1, "gift", { to = "Pria" })), "wrongclass", "a warrior can't win it to hand on")
    eq(select(2, s:bid("Pria", 1, "gift", { to = "Wara" })), "wrongclassto", "nor give it to a warrior")
    assert(s:bid("Pria", 1, "gift", { to = "Maga" }))
end)
test("the salvager is not restricted: if no priest or mage takes it, the backstop offers it to anyone", function()
    local s = session({ stats = {}, classes = { "PRIEST", "MAGE" } })
    for _, n in ipairs { "Wara", "Pria", "Maga", "ML" } do assert(s:bid(n, 1, "pass")) end
    s:resolveNow()
    eq(s.phase, "backstop"); eq(s.turn.type, "claim"); eq(s.turn.player, "ML-Realm", "lowest first")
    assert(s:decline("ML")); eq(s.turn.player, "Maga-Realm"); assert(s:decline("Maga")); assert(s:decline("Pria"))
    eq(s.turn.player, "Wara-Realm", "a warrior may salvage a priest's robe")
    assert(s:claimItem("Wara"))
end)
test("nobody takes it: it goes to the disenchanter, whatever their class", function()
    local s = session({ stats = {}, classes = { "PRIEST" } })
    for _, n in ipairs { "Wara", "Pria", "Maga", "ML" } do assert(s:bid(n, 1, "pass")) end
    s:resolveNow()
    for _ = 1, 4 do s:decline(s.turn.player) end
    eq(s.items[1].status, "de"); eq(s.pending[1].type, "disenchant"); eq(s.pending[1].to, "ML-Realm", "the paladin Master Looter")
end)
test("a raider who whispers a bid for another class's item is told who it is for", function()
    local s, _, client = session({ stats = {}, classes = { "PRIEST", "MAGE" } })
    s:handleWhisper("Wara", "need")
    local last = client.sent[#client.sent]
    eq(last.kind, "whisper"); assert(last.text:find("item 1 is only for Priest, Mage"), last.text)
end)

H.section("Item fit: the guild's rules, set before the item drops")
test("an officer's rule decides who may bid, over what the item itself says", function()
    local s = session({ stats = {}, classes = { "PRIEST" } },
        { item = 7, classes = { "WARRIOR", "MAGE" }, reason = "the guild gives this robe to mages; warriors for the set bonus" })
    eq(select(2, s:bid("Pria", 1, "need")), "wrongclass"); assert(s:bid("Wara", 1, "need")); assert(s:bid("Maga", 1, "need"))
    local any = session({ stats = {}, classes = { "PRIEST" } }, { item = 7, classes = {}, reason = "open to everyone" })
    assert(any:bid("Wara", 1, "need"), "'any' lifts the restriction")
end)
test("a rule restricts even an item that names no classes, and works before the game has cached it", function()
    local s = session({ stats = {} }, { item = 7, classes = { "MAGE" }, reason = "caster trinket" })
    eq(select(2, s:bid("Pria", 1, "need")), "wrongclass")
    local client = MockClient.New({ name = "ML", realm = "Realm" })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    assert(engine:Write("ItemClasses", { item = 9, classes = { "MAGE" }, reason = "x" }))
    eq(ItemFit.Describe(client, "item:9", nil, engine:ItemRule(9)).classes[1], "MAGE")
end)
test("a rule that isn't valid is refused by the ledger", function()
    local client = MockClient.New({ name = "GM", realm = "Realm" })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    eq(select(2, engine:Write("ItemClasses", { item = 7, classes = { "DEATHKNIGHT" }, reason = "x" })), "baditemrule")
    eq(select(2, engine:Write("ItemClasses", { item = 7, classes = { "MAGE", "MAGE" }, reason = "x" })), "baditemrule")
    eq(select(2, engine:Write("ItemClasses", { item = 7, classes = { "MAGE" } })), "baditemrule", "a reason is required")
    eq(select(2, engine:Write("ItemClasses", { item = "x", classes = {}, reason = "x" })), "baditemrule")
end)

-- The guild master, an officer and a raider, with addons, over the simulated network.
local function guild()
    local net = SimNetwork.New({ latency = 0.1, seed = 5 })
    local w = { net = net }
    for i, n in ipairs { "GM", "Off", "Maga" } do
        local client = MockClient.New({ name = n, realm = "Realm", seed = i * 7 })
        client:setRaid({ { name = "GM", class = "WARRIOR" }, { name = "Off", class = "PRIEST" }, { name = "Maga", class = "MAGE" } },
            { leader = "GM", lootMethod = "master", masterLooter = "GM" })
        local engine = Engine.New(client)
        local sync = Sync.New(engine, { heartbeat = 10, firstHeartbeat = 1, firstJitter = 1 })
        net:attach(client); sync:start()
        w[n] = { client = client, engine = engine, cmd = Commands.New({ client = client, engine = engine, sync = sync }) }
    end
    w.GM.cmd.handle("create main"); w.GM.cmd.handle("officers set Off")
    net:advance(15)
    return w
end
local function text(nd) return table.concat(nd.client.printed, "\n") end

test("eligible: an officer sets a rule by command, every peer has it, and history shows it", function()
    local w = guild()
    w.Off.cmd.handle("eligible |cffff8000|Hitem:19019::::::::60:::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r warrior,rogue,hunter melee weapon, tanks first")
    assert(text(w.Off):find("Recorded%. Thunderfury, Blessed Blade of the Windseeker: Warrior, Rogue, Hunter"), text(w.Off))
    w.net:advance(3)
    eq(table.concat(w.Maga.engine:ItemRule(19019).classes, ","), "WARRIOR,ROGUE,HUNTER")
    w.Maga.client.printed = {}; w.Maga.cmd.handle("eligible 19019")
    assert(text(w.Maga):find("Set by Off: melee weapon, tanks first"), text(w.Maga))
    w.Maga.client.printed = {}; w.Maga.cmd.handle("history")
    assert(text(w.Maga):find("Off set who may bid on Thunderfury, Blessed Blade of the Windseeker: Warrior, Rogue, Hunter"), text(w.Maga))
    w.Maga.client.printed = {}; w.Maga.cmd.handle("eligible 19019 mage I want it")
    assert(text(w.Maga):find("Not recorded"), text(w.Maga))
end)
test("eligible: during a raid only its Master Looter sets rules; mistakes in the command are explained", function()
    local w = guild()
    w.Off.cmd.handle("raid open GM 2"); w.net:advance(3)
    w.Off.client.printed = {}; w.Off.cmd.handle("eligible 123 mage,priest caster cloak")
    assert(text(w.Off):find("A raid is running"), text(w.Off))
    w.GM.cmd.handle("eligible 123 mage,priest caster cloak"); assert(text(w.GM):find("Recorded"), text(w.GM))
    w.GM.client.printed = {}; w.GM.cmd.handle("eligible 123 deathknight x"); assert(text(w.GM):find("Unknown class 'deathknight'"), text(w.GM))
    w.GM.client.printed = {}; w.GM.cmd.handle("eligible 123 mage"); assert(text(w.GM):find("a reason is required"), text(w.GM))
end)
test("a player sees who an item is for; with hints on, who it suits and how it fits them", function()
    local client = MockClient.New({ name = "Pria", realm = "Realm" })
    client:setRaid({ { name = "Pria", class = "PRIEST" } }, {})
    client:setItemInfo("item:7", { name = "Robe", equipLoc = "INVTYPE_HEAD", class = ARMOR, subclass = 1 })
    client:setItemStats("item:7", { stats = ITEMS.clothHealer.stats, classes = { "PRIEST", "DRUID" } })
    local engine = Engine.New(client)
    local cmd = Commands.New({ client = client, engine = engine })
    eq(cmd.itemNote("item:7"), "  [for: Priest, Druid]", "hints are off by default")
    cmd.handle("hints on"); cmd.handle("spec holy shadow")
    local note = cmd.itemNote("item:7")
    assert(note:find("suits: ") and note:find("Priest"), note)
    assert(note:find("your fit: good %(Holy%)"), note); assert(note:find("off%-spec: "), note)
end)
