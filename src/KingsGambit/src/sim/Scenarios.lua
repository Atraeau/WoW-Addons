-- King's Gambit: training scenarios (Phase 4.5). Data, not code paths: each scenario sets up a
-- raid, a drop and how the bots behave, says what the learner should notice, and states what
-- must be true afterward. The test suite runs every scenario against the real engine, so the
-- lessons can never drift from the rules. Keep this file Lua 5.1-safe.
local _, SK = ...
local Identity
local collect -- defined below: the lessons are gathered once every module is loaded (see Registry.lua)
-- The lessons themselves are in ScenarioBasics.lua, ScenarioDraft.lua and ScenarioHandout.lua; this file is what they share, their order, and find().
local M = SK:NewModule("Scenarios", { "Identity", "ScenarioBasics", "ScenarioDraft", "ScenarioHandout" }, function(d)
    Identity = d.Identity
    collect({ d.ScenarioBasics, d.ScenarioDraft, d.ScenarioHandout })
end)

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

local function short(name) return name and Identity.Display(name) end

M.list = {}

-- Teaching order: one item and one winner first, then several items and ranking, then the off-spec list, then what
-- happens to items nobody wants (disenchant, salvage, gifting), then fixing a mistake, and last the big hand-outs.
-- (The raid nights come after all of these, on the page.)
local ORDER = { "first-drop", "pick-a-priority", "off-spec", "nobody-wants-it", "minor-upgrade-proxy", "gift-up",
    "fix-a-mistake", "regret-trade", "lucky-salvager", "big-handout", "regret-after-draft" }

function collect(parts)
    local helpers = { RAID = RAID, raid = raid, lastEvent = lastEvent, short = short }
    for _, part in ipairs(parts) do
        for _, lesson in ipairs(part.Lessons(helpers)) do M.list[#M.list + 1] = lesson end
    end
    local rank = {}
    for i, id in ipairs(ORDER) do rank[id] = i end
    table.sort(M.list, function(a, b) return (rank[a.id] or 99) < (rank[b.id] or 99) end)
end

function M.find(id)
    for _, sc in ipairs(M.list) do
        if sc.id == id then return sc end
    end
end
