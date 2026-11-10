-- King's Gambit: training scenarios, items nobody wants, fixing a mistake and a regret trade. Keep this file Lua 5.1-safe.
-- Part of Scenarios (Scenarios.lua), which collects every part's lessons, puts them in teaching order and finds one by id.
local _, SK = ...
local M = SK:NewModule("ScenarioDraft")

-- h: what every lesson shares (Scenarios.lua): the practice raid, a way to find an event, a short name.
function M.Lessons(h)
    local RAID, raid, lastEvent, short = h.RAID, h.raid, h.lastEvent, h.short
    local lessons = {
    {
        id = "nobody-wants-it",
        title = "Nobody wants it",
        lesson = "Shazzrah drops a wand the raid has already outgrown, and everyone passes. An item nobody wants goes to the salvager: the player at the bottom of the list, who is you here. The salvager decides. They can claim it (keep it, or gift it to someone who can use it), or decline, and then the disenchanter takes it and the shards go to the guild bank. Nobody else is asked: there is no second round of offers up the list. Here, decline it.",
        members = RAID,
        items = { "Crimson Shocker" },
        policies = {},
        expect = function(sim)
            local de = lastEvent(sim, "main", "Disenchant")
            local ok = de ~= nil and sim:orderString() == "Aldric,Brann,Cass,Dara,Eira,Fenn,You"
            if not de then
                return false, "you claimed the wand, so the disenchanter never got it. In this lesson nobody wants it: as the salvager, decline it and it goes to the disenchanter."
            end
            return ok, "declined by the salvager, so it went to the disenchanter, " .. short(de.data.to) .. ". Nobody else was asked."
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
                return "Brann won the staff and it has been handed out, but that was a mistake. Now fix it: in the game, open the Ledger tab, click Brann's award, and press \"Undo this award\" (on the page: press \"Undo this\" in the Corrections card). The undo is written as its own event, so the history shows what happened."
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
        id = "regret-trade",
        title = "The item went to someone else",
        lesson = "Lucifron drops the warrior Tier 1 gloves. Brann and Dara both need them, and Brann is higher on the list, so he wins and the gloves are handed to him. Then Brann says: \"I'd rather Dara had them. I traded them to her at the door.\" The item is now with Dara, but the list still says Brann won.\n\nThis is a regret-trade, not a gift: Dara wanted the gloves and was beaten only by rank. So the list should end as if Dara had won them: Brann is restored to his place (he did not really win), and Dara pays and drops to the bottom. In the Corrections card below, choose Dara in \"It went to\" and press Regret-trade. (\"It was a gift\" is for when the winner deliberately gives it away: it records where the item went and moves nobody, which would be unfair here.)",
        members = RAID,
        items = { "Gauntlets of Might" },
        policies = {
            Brann = { bid = { ["Gauntlets of Might"] = "need" } },
            Dara = { bid = { ["Gauntlets of Might"] = "need" } },
        },
        todo = function(sim)
            local last = lastEvent(sim, "main", "Award")
            -- judged on where things stand, so a wrong try that was then put right leaves nothing to do
            if last and short(last.data.member) == "Dara" and sim:orderString() == "Aldric,Brann,Cass,Eira,Fenn,You,Dara" then return nil end
            if lastEvent(sim, "main", "Transfer") then
                return "A gift only records where the item went; nobody moves, so Brann keeps the win and Dara pays nothing. Dara wanted these gloves, so this was a regret-trade: Brann is restored and Dara drops to the bottom. Fix it: use Regret-trade on Brann's award (Corrections card)."
            end
            if not (last and last.data.replaces) and not lastEvent(sim, "main", "Revert") then
                return "Brann won the gloves and they were handed to him, but he traded them to Dara. Fix the list: in the Corrections card, choose Dara in \"It went to\" and press Regret-trade."
            end
            if lastEvent(sim, "main", "Revert") and not (last and short(last.data.member) == "Dara" and sim:orderString():find("Dara$")) then
                return "You undid Brann's win, so he is restored. Now Dara has the gloves and should pay for them: record it with \"Record a win the session didn't\" (Dara, the gloves), or undo that and use Regret-trade, which does both in one step."
            end
        end,
        after = function(sim)
            local award = lastEvent(sim, "main", "Award")
            assert(sim.engine:Append("main", "Award", { member = "Dara", item = award.data.item, replaces = award.id, reason = "traded at the door" }))
        end,
        expect = function(sim)
            local want = "Aldric,Brann,Cass,Eira,Fenn,You,Dara"
            local last = lastEvent(sim, "main", "Award")
            local ok = sim:orderString() == want and last ~= nil and short(last.data.member) == "Dara"
            local how = last and last.data.replaces and "in one step (a regret-trade)" or "in two steps (undo, then award)"
            return ok, ("order is %s; Brann restored, Dara paid %s"):format(sim:orderString(), how)
        end,
    },
    }
    return lessons
end
