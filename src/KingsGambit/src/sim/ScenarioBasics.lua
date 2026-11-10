-- King's Gambit: training scenarios, the first lessons: one item and one winner, the priority pick, a proxy, a gift and an off-spec bid. Keep this file Lua 5.1-safe.
-- Part of Scenarios (Scenarios.lua), which collects every part's lessons, puts them in teaching order and finds one by id.
local _, SK = ...
local M = SK:NewModule("ScenarioBasics")

-- h: what every lesson shares (Scenarios.lua): the practice raid, a way to find an event, a short name.
function M.Lessons(h)
    local RAID, lastEvent, short = h.RAID, h.lastEvent, h.short
    local lessons = {
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
        lesson = "Baron Geddon drops a Quick Strike Ring. Aldric would use it, but it is not worth his place on the list, so everyone passes. The item goes to the salvager, the player at the bottom of the list. That is you, so you decide: you claim it for free and gift it up to someone who can use it: Aldric, or any raider who would. Nothing is wasted, and nobody paid for scraps.",
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
            local main, off = sim:orderString(), table.concat(sim.engine:Get("off").state.order, ",")
            local award = lastEvent(sim, "off", "Award")
            local ok = #seeded == 7 and award ~= nil and short(award.data.member) == winner
                and main == "Aldric,Brann,Cass,Dara,Eira,Fenn,You" and off == table.concat(want, ",")
            return ok, ("seeded off-spec order %s; %s won; main %s; off now %s"):format(table.concat(seeded, ","), tostring(winner), main, off)
        end,
    },
    }
    return lessons
end
