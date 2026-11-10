-- King's Gambit: training scenarios, a big hand-out, the lucky salvager and the regret trade after a big hand-out. Keep this file Lua 5.1-safe.
-- Part of Scenarios (Scenarios.lua), which collects every part's lessons, puts them in teaching order and finds one by id.
local _, SK = ...
local M = SK:NewModule("ScenarioHandout")

-- h: what every lesson shares (Scenarios.lua): the practice raid, a way to find an event, a short name.
function M.Lessons(h)
    local lastEvent, short = h.lastEvent, h.short
    local lessons = {
    {
        id = "big-handout",
        title = "A big hand-out: ranked choice, then the salvagers rotate",
        lesson = "Ten items have piled up (held until a break). Watch three things happen, in this order.\n\n1. RANKING. Everyone ranked what they want, up front. Nobody is asked anything during the draft.\n\n2. THE DRAFT. It goes down the list. Each player in turn gets their highest-ranked item that is still there, and drops to the bottom. Aldric (first on the list) gets the gauntlets, his first choice. Brann takes the blade, Cass the boots, and Dara the helm, her first choice once the gauntlets are gone. Fenn takes the choker and Garo the robe. Eira and Hale only wanted things that were already taken, so they get nothing.\n\n3. THE SALVAGERS. Four items interest nobody. They are salvaged as the draft goes: every pick drops its winner to the bottom, so the next unwanted item is offered to the player who just picked. Aldric picked first, so he is the first salvager (Heavy Dark Iron Ring); Brann picked second, so he is the second (Quick Strike Ring); then Cass (Wristguards) and Dara (Crimson Shocker). The salvagers rotate in the order of the draft: no single salvager takes everything, and it does not matter how the loot was batched.\n\nYou only have to pass on everything (the button under the items), press Start, then confirm.",
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
            local wantRotation = "Aldric: Heavy Dark Iron Ring; Brann: Quick Strike Ring; Cass: Wristguards of Stability; Dara: Crimson Shocker"
            return won == want and rotated == wantRotation,
                ("draft: %s | leftovers, each to a different salvager: %s"):format(won, rotated)
        end,
    },
    {
        id = "lucky-salvager",
        title = "Nobody wants most of it: the lucky salvager",
        lesson = "Six items drop. Only two are wanted: Aldric wants the gauntlets, Brann the blade. The other four interest nobody. Watch where they go.\n\n1. AS THE DRAFT GOES. Aldric picks first and drops to the bottom, so the first unwanted item (the Heavy Dark Iron Ring) is offered to him. Claiming at the bottom costs him nothing: he has no further to fall. Then Brann picks, drops to the bottom, and is offered the next unwanted item (the Quick Strike Ring).\n\n2. WHAT IS LEFT AFTER THE DRAFT. Two items remain (Wristguards of Stability and the Crimson Shocker) and there are no picks left to hand them out with. They go to the salvager, the lowest player, who is Brann. He claims them too, and he is still at the bottom afterward, because nothing he did cost him a place. He got lucky that so few people wanted so much.\n\nNobody else's place moved at all. You only have to pass on everything, press Start, then confirm.",
        members = {
            { name = "Aldric", class = "WARRIOR" }, { name = "Brann", class = "WARRIOR" }, { name = "Cass", class = "DRUID" },
            { name = "Dara", class = "WARRIOR" }, { name = "Eira", class = "DRUID" }, { name = "Fenn", class = "PRIEST" },
        },
        learnerClass = "WARLOCK",
        items = { "Gauntlets of Might", "Heavy Dark Iron Ring", "Brutality Blade", "Quick Strike Ring",
            "Wristguards of Stability", "Crimson Shocker" },
        policies = {
            Aldric = { claim = true, bid = { ["Gauntlets of Might"] = "need" } },
            Brann = { claim = true, bid = { ["Brutality Blade"] = "need" } },
            Cass = { claim = true }, Dara = { claim = true }, Eira = { claim = true }, Fenn = { claim = true },
        },
        you = { claim = false },
        expect = function(sim)
            local rows = {}
            for _, ev in ipairs(sim.engine:Get("main").events) do
                if ev.type == "Award" then rows[#rows + 1] = short(ev.data.member) .. ": " .. ev.data.item end
            end
            local got = table.concat(rows, "; ")
            local want = "Aldric: Gauntlets of Might; Aldric: Heavy Dark Iron Ring; Brann: Brutality Blade; Brann: Quick Strike Ring; "
                .. "Brann: Wristguards of Stability; Brann: Crimson Shocker"
            local order = sim:orderString()
            return got == want and order == "Cass,Dara,Eira,Fenn,You,Aldric,Brann",
                ("%s | list now %s"):format(got, order)
        end,
    },
    }


-- The regret-trade after a big hand-out: the hardest case for the standings. The first pickers are also the
-- salvagers, so the winner of the item that went to someone else has also won a leftover since (their place is already
-- the bottom), and the real recipient may be someone who got nothing at all.
    do
    local base
    for _, sc in ipairs(lessons) do if sc.id == "big-handout" then base = sc end end
    local WANT = "Eira,You,Aldric,Brann,Cass,Dara,Fenn,Garo,Hale"
    local function blade(sim)
        for _, ev in ipairs(sim.engine:Get("main").events) do
            if ev.type == "Award" and ev.data.item == "Brutality Blade" and short(ev.data.member) == "Brann" then return ev end
        end
    end
    lessons[#lessons + 1] = {
        id = "regret-after-draft",
        title = "The item went to someone else, after a big hand-out",
        lesson = "The same ten items as the big hand-out, and the same draft: pass on everything, press Start, confirm. Afterward Brann tells you: \"I traded the Brutality Blade to Hale at the door.\" Hale ranked it first too, and lost it only because Brann is higher on the list. Fix the list, in the Corrections card.\n\nThis is harder than the single drop. Brann won the blade, and also the Quick Strike Ring (he picked second, so he was the second salvager), and the draft went on after him. Choose Hale in \"It went to\" on Brann's Brutality Blade and press Regret-trade. Notice what does and doesn't change:\n\n1. Brann does not move. He also won the ring after the blade, and that already dropped him to the bottom when his turn came, so he stands in the same place with or without the blade. He just loses that win (and keeps the ring).\n2. Hale, who got nothing in the draft, pays now: he drops to the bottom, as if he had won the blade.\n3. Nobody else moves, and nobody has to hand anything back: the draft is not replayed.\n\n(\"It was a gift\" is for a deliberate gift: nobody would move, which would be unfair to Hale's wait.)",
        members = base.members, learnerClass = base.learnerClass, items = base.items, policies = base.policies, you = base.you,
        todo = function(sim)
            local last = lastEvent(sim, "main", "Award")
            if last and short(last.data.member) == "Hale" and last.data.item == "Brutality Blade" and sim:orderString() == WANT then return nil end
            if lastEvent(sim, "main", "Transfer") then
                return "A gift only records where the blade went; nobody moves, so Brann keeps a win he did not have and Hale pays nothing. Hale wanted it and lost only on rank: this was a regret-trade. Fix it: use Regret-trade on Brann's Brutality Blade (Corrections card)."
            end
            if lastEvent(sim, "main", "Revert") then
                return "You undid a win, so that player is restored. Now Hale has the blade and should pay for it: record it with \"Record a win the session didn't\" (Hale, the blade), or undo that and use Regret-trade on Brann's Brutality Blade, which does both in one step."
            end
            return "The hand-out is done, but Brann traded the blade to Hale. Fix the list: in the Corrections card, find Brann's Brutality Blade (not the ring), choose Hale in \"It went to\" and press Regret-trade."
        end,
        after = function(sim)
            local award = assert(blade(sim))
            assert(sim.engine:Append("main", "Award", { member = "Hale", item = award.data.item, replaces = award.id, reason = "traded at the door" }))
        end,
        expect = function(sim)
            local last = lastEvent(sim, "main", "Award")
            local ok = sim:orderString() == WANT and last ~= nil and short(last.data.member) == "Hale" and last.data.item == "Brutality Blade"
            local how = last and last.data.replaces and "in one step (a regret-trade)" or "in two steps (undo, then award)"
            return ok, ("order is %s; Hale paid for the blade, Brann kept his place (the ring was his later win), %s"):format(sim:orderString(), how)
        end,
    }
    end
    return lessons
end
