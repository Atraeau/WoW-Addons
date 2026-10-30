-- King's Gambit: training scenarios (Phase 4.5). Data, not code paths: each scenario sets up a
-- raid, a drop and how the bots behave, says what the learner should notice, and states what
-- must be true afterward. The test suite runs every scenario against the real engine, so the
-- lessons can never drift from the rules. Keep this file Lua 5.1-safe.
local _, SK = ...
local M = SK:NewModule("Scenarios")

-- Top of the list first; You are last. Each has a class, because the loot rules go by class: the item has to be
-- one their class can wear or wield (and the gloves below are for warriors only).
local CLASSES = { Aldric = "WARRIOR", Brann = "WARRIOR", Cass = "DRUID", Dara = "WARRIOR", Eira = "DRUID", Fenn = "PRIEST" }
local NAMES = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn" }
local function raid(override)
    local out = {}
    for i, n in ipairs(NAMES) do out[i] = { name = n, class = (override and override[n]) or CLASSES[n] } end
    return out
end
local RAID = raid()

local function lastEvent(sim, listId, type_)
    local found
    for _, ev in ipairs(sim.engine:Get(listId).events) do
        if ev.type == type_ then found = ev end
    end
    return found
end

local function short(name) return name and (name:gsub("%-.*$", "")) end

M.list = {
    {
        id = "first-drop",
        title = "The first drop",
        lesson = "Lucifron drops the warrior Tier 1 gloves. Two players want them. The one higher on the list wins, and drops to the bottom. Everyone else keeps their place.",
        members = RAID,
        items = { "Gauntlets of Might" },
        policies = {
            Brann = { bid = { ["Gauntlets of Might"] = "need" } },
            Dara = { bid = { ["Gauntlets of Might"] = "need" } },
        },
        expect = function(sim)
            local order = sim:orderString()
            return order == "Aldric,Cass,Dara,Eira,Fenn,You,Brann", "order is " .. order
        end,
    },
    {
        id = "pick-a-priority",
        title = "Two items, one player who wants both",
        lesson = "Garr drops two items Aldric wants. When you want several, you rank them up front: Aldric ranked Brutality Blade first, so on his turn he gets it with no prompt and drops to the bottom. Brann, next in line, gets the helm.",
        members = RAID,
        items = { "Helm of Might", "Brutality Blade" },
        policies = {
            Aldric = { bid = { ["Helm of Might"] = { "need", rank = 2 }, ["Brutality Blade"] = { "need", rank = 1 } } },
            Brann = { bid = { ["Helm of Might"] = "need" } },
        },
        expect = function(sim)
            local items = sim.session.items
            if not (items[1].winner and items[2].winner) then return false, "an item was not awarded" end
            local ok = short(items[2].winner) == "Aldric" and short(items[1].winner) == "Brann"
            return ok, ("Blade went to %s, Helm to %s"):format(short(items[2].winner), short(items[1].winner))
        end,
    },
    {
        id = "minor-upgrade-proxy",
        title = "A small upgrade nobody will spend their rank on",
        lesson = "Baron Geddon drops a Quick Strike Ring. Aldric would use it, but it is not worth his place on the list, so everyone passes. The item is offered from the bottom up. You are at the bottom, so you claim it for free and gift it up to someone who can use it: Aldric, or any raider who would. Nothing is wasted, and nobody paid for scraps.",
        members = RAID,
        items = { "Quick Strike Ring" },
        policies = {},
        you = { claim = true, claimTo = "Aldric" },
        expect = function(sim)
            local award = lastEvent(sim, "main", "Award")
            if not award then
                if lastEvent(sim, "main", "Disenchant") then
                    return false, "nobody claimed the ring, so it was disenchanted. When it is offered to you, choose who to gift it to (Aldric, say) and press \"Claim and gift\" before the offer's timer runs out."
                end
                return false, "no award was recorded"
            end
            -- Any raider will do as the recipient (the engine has already checked they may have the ring): the lesson is
            -- that the salvager claims it at no cost and hands it up, and that nobody else's place changes.
            local to = short(award.data.to)
            if not award.data.to or award.data.to == award.data.member then
                return false, "you claimed the ring but kept it. To make the lesson work, gift it to a raider who can use it, such as Aldric."
            end
            local ok = short(award.data.member) == "You" and sim:orderString() == "Aldric,Brann,Cass,Dara,Eira,Fenn,You"
            return ok, ("claimed by You and gifted to %s; order %s"):format(to, sim:orderString())
        end,
    },
    {
        id = "gift-up",
        title = "Gifting an item to a friend",
        lesson = "Geddon drops a healer ring. Fenn does not need it, but Aldric would love it. Fenn bids to gift it: Fenn wins at Fenn's own place on the list, pays for it by dropping to the bottom, and hands the item to Aldric.",
        members = RAID,
        items = { "Seal of the Archmagus" },
        policies = {
            Fenn = { bid = { ["Seal of the Archmagus"] = { "gift", to = "Aldric" } } },
        },
        expect = function(sim)
            local award = lastEvent(sim, "main", "Award")
            if not award then return false, "no award" end
            local ok = short(award.data.member) == "Fenn" and short(award.data.to) == "Aldric"
                and sim:orderString() == "Aldric,Brann,Cass,Dara,Eira,You,Fenn"
            return ok, ("won by %s for %s; order %s"):format(short(award.data.member), short(award.data.to), sim:orderString())
        end,
    },
    {
        id = "off-spec",
        title = "Off-spec bids",
        lesson = "Gehennas drops leather healer legs. Nobody needs them for their main, but two druids, Cass and Eira, bid on them for an off-spec. Off-spec has its own list. It is created at the first session, with everyone present in a random order of its own (not the main list's order, so the top of the main list gets no off-spec advantage); that roll is recorded in the ledger, and after it nothing is rolled again. Whichever of Cass and Eira is ahead on that list wins. Winning costs them a place on the off-spec list only: the main list does not move.",
        members = RAID,
        items = { "Salamander Scale Pants" },
        policies = {
            Cass = { bid = { ["Salamander Scale Pants"] = "off" } },
            Eira = { bid = { ["Salamander Scale Pants"] = "off" } },
        },
        expect = function(sim)
            -- The seeded off-spec list is in the ledger as the order everyone was added. Of the two bidders, whoever is
            -- ahead wins and drops to the bottom of that list; the main list is untouched.
            local seeded = {}
            for _, ev in ipairs(sim.engine:Get("off").events) do
                if ev.type == "AddMember" then seeded[#seeded + 1] = short(ev.data.member) end
            end
            local winner
            for _, n in ipairs(seeded) do if (n == "Cass" or n == "Eira") and not winner then winner = n end end
            local want = {}
            for _, n in ipairs(seeded) do if n ~= winner then want[#want + 1] = n end end
            want[#want + 1] = winner
            local main, off = sim:orderString(), table.concat(sim.engine:Get("off").state.order, ","):gsub("%-Realm", "")
            local award = lastEvent(sim, "off", "Award")
            local ok = #seeded == 7 and award ~= nil and short(award.data.member) == winner
                and main == "Aldric,Brann,Cass,Dara,Eira,Fenn,You" and off == table.concat(want, ",")
            return ok, ("seeded off-spec order %s; %s won; main %s; off now %s"):format(table.concat(seeded, ","), tostring(winner), main, off)
        end,
    },
    {
        id = "nobody-wants-it",
        title = "Nobody wants it",
        lesson = "Shazzrah drops a wand the raid has already outgrown. Everyone passes, and everyone passes again when it is offered from the bottom up. Only then is it disenchanted, and the shards go to the guild bank. Usable loot gets every chance first.",
        members = RAID,
        items = { "Crimson Shocker" },
        policies = {},
        expect = function(sim)
            local de = lastEvent(sim, "main", "Disenchant")
            local ok = de ~= nil and sim:orderString() == "Aldric,Brann,Cass,Dara,Eira,Fenn,You"
            return ok, de and ("disenchanted by " .. short(de.data.to)) or "no Disenchant event"
        end,
    },
    {
        id = "fix-a-mistake",
        title = "Fixing a mistake",
        lesson = "Golemagg drops Staff of Dominance. Brann wins it, but you handed it out by mistake. Mistakes are fixed forward: the undo is itself a recorded event, so the history shows what happened and who fixed it. Nothing is erased.",
        members = raid({ Brann = "MAGE" }),
        items = { "Staff of Dominance" },
        policies = { Brann = { bid = { ["Staff of Dominance"] = "need" } } },
        -- What the learner still has to do before the lesson can be judged: the page shows this instead of a verdict.
        todo = function(sim)
            if not lastEvent(sim, "main", "Revert") then
                return "Brann won the staff and it has been handed out, but that was a mistake. Now fix it: press \"Undo last award\" above. The undo is written as its own event, so the history shows what happened."
            end
        end,
        after = function(sim)
            local award = lastEvent(sim, "main", "Award")
            assert(sim.engine:Append("main", "Revert", { target = award.id }))
        end,
        expect = function(sim)
            local reverted = lastEvent(sim, "main", "Revert") ~= nil
            return reverted and sim:orderString() == "Aldric,Brann,Cass,Dara,Eira,Fenn,You",
                "order is " .. sim:orderString() .. (reverted and ", with the undo recorded" or ", no undo recorded")
        end,
    },
    {
        id = "big-handout",
        title = "A big hand-out: ranked choice, then the salvagers rotate",
        lesson = "Ten items have piled up (held until a break). Watch three things happen, in this order.\n\n1. RANKING. Everyone ranked what they want, up front. Nobody is asked anything during the draft.\n\n2. THE DRAFT. It goes down the list. Each player in turn gets their highest-ranked item that is still there, and drops to the bottom. Aldric (first on the list) gets the gauntlets, his first choice. Brann takes the blade, Cass the boots, and Dara the helm, her first choice once the gauntlets are gone. Fenn takes the choker and Garo the robe. Eira and Hale only wanted things that were already taken, so they get nothing.\n\n3. THE SALVAGERS. Four items interest nobody. They are offered from the bottom of the list up, and whoever claims one goes to the back of the line for the next. So each leftover goes to a different salvager: Garo, Fenn, Dara and Cass, the last four winners, latest first. No single salvager takes everything, and it does not matter how the loot was batched.\n\nYou only have to pass on everything (the button under the items), press Start, then confirm.",
        members = {
            { name = "Aldric", class = "WARRIOR" }, { name = "Brann", class = "WARRIOR" }, { name = "Cass", class = "DRUID" },
            { name = "Dara", class = "WARRIOR" }, { name = "Eira", class = "DRUID" }, { name = "Fenn", class = "PRIEST" },
            { name = "Garo", class = "MAGE" }, { name = "Hale", class = "ROGUE" },
        },
        learnerClass = "WARLOCK",
        items = { "Gauntlets of Might", "Heavy Dark Iron Ring", "Helm of Might", "Brutality Blade", "Quick Strike Ring",
            "Choker of Enlightenment", "Cenarion Boots", "Wristguards of Stability", "Robe of Volatile Power", "Crimson Shocker" },
        policies = (function()
            local P = {}
            local function ranked(list)
                local bid = {}
                for rank, item in ipairs(list) do bid[item] = { "need", rank = rank } end
                return bid
            end
            -- ranked choice: their wishes in order. Everyone would claim a leftover offered to them.
            P.Aldric = { claim = true, bid = ranked { "Gauntlets of Might", "Helm of Might", "Brutality Blade" } }
            P.Brann = { claim = true, bid = ranked { "Brutality Blade", "Helm of Might" } }
            P.Cass = { claim = true, bid = ranked { "Cenarion Boots" } }
            P.Dara = { claim = true, bid = ranked { "Helm of Might", "Brutality Blade" } }
            P.Eira = { claim = true, bid = ranked { "Cenarion Boots" } }
            P.Fenn = { claim = true, bid = ranked { "Choker of Enlightenment", "Robe of Volatile Power" } }
            P.Garo = { claim = true, bid = ranked { "Choker of Enlightenment", "Robe of Volatile Power" } }
            P.Hale = { claim = true, bid = ranked { "Brutality Blade" } }
            return P
        end)(),
        you = { claim = false },
        expect = function(sim)
            -- awards in the order they were written, split by how each item was won (the draft, or the salvage round)
            local tierOf = {}
            for _, it in ipairs(sim.session.items) do tierOf[it.link] = it.tier end
            local main, salvage = {}, {}
            for _, ev in ipairs(sim.engine:Get("main").events) do
                if ev.type == "Award" then
                    local row = short(ev.data.member) .. ": " .. ev.data.item
                    if tierOf[ev.data.item] == "salvage" then salvage[#salvage + 1] = row else main[#main + 1] = row end
                end
            end
            local won = table.concat(main, "; ")
            local want = "Aldric: Gauntlets of Might; Brann: Brutality Blade; Cass: Cenarion Boots; Dara: Helm of Might; "
                .. "Fenn: Choker of Enlightenment; Garo: Robe of Volatile Power"
            local rotated = table.concat(salvage, "; ")
            local wantRotation = "Garo: Heavy Dark Iron Ring; Fenn: Quick Strike Ring; Dara: Wristguards of Stability; Cass: Crimson Shocker"
            return won == want and rotated == wantRotation,
                ("draft: %s | leftovers, each to a different salvager: %s"):format(won, rotated)
        end,
    },
}

function M.find(id)
    for _, sc in ipairs(M.list) do
        if sc.id == id then return sc end
    end
end
