-- King's Gambit: what the Guild book shows, as plain tables. Keep this file Lua 5.1-safe.
--
-- The Guild book is the larger, calmer window for the lists, the record of what happened, and the officers' tools (docs/ui-design.md, 5.2). Like the Loot
-- window, its screens are built here from the engine's state with no frames, so the game's window and the web simulator draw the same sections, the same
-- sentences and the same filters. Nothing here changes anything: a section's buttons run the same commands a player would type.
--
--   M.SECTIONS                            the navigation column, in order
--   M.History(ctx, filter)                the ledger as readable sentences, newest first, filtered
--   M.Ago(now, ts)                        "3 days ago"
local _, SK = ...
local M = SK:NewModule("GuildBook", {}, function() end)

-- The sections of the navigation column. A section with `actions` is a page of forms (UITools actions, by id): each runs the command a player would type.
-- `gap` puts a space above its button: the Ledger is the guild master's and maintenance corner, kept apart from the everyday sections.
-- Every action belongs to exactly one section (the old History form is the History section now).
M.SECTIONS = {
    { id = "lists", label = "Lists", tip = "The standings: who is first for what, and the officers' moves." },
    { id = "history", label = "History", tip = "Everything that happened to the lists, in words: who won what, who moved whom, and why." },
    { id = "awards", label = "Awards", tip = "Record a win the session missed, undo an award, note where an item went. Corrections are new entries; nothing is erased.",
        actions = { "award", "undo", "trade", "salvaged" } },
    { id = "raids", label = "Raids", tip = "Open and close a raid, choose its Master Looter, its list and its disenchanter.",
        actions = { "raidshow", "raidopen", "raidlist", "raidextend", "raidclose", "raidrevoke", "masterloot", "disenchanter", "policy" } },
    { id = "people", label = "People", tip = "Add, remove and move players; who the officers are; and your own spec.",
        actions = { "add", "remove", "move", "officers", "officersset", "spec", "hints" } },
    { id = "rules", label = "Rules", tip = "Which classes may bid on an item, who it suits, and requests to the Master Looter.",
        actions = { "eligibles", "eligible", "suits", "reqelig", "request", "requests", "accept", "decline" } },
    { id = "ledger", label = "Ledger", gap = true, tip = "Starting a list, the ledger's format and versions, syncing: the guild master's and maintenance steps.",
        actions = { "create", "listuse", "migratestatus", "migrate", "version", "sync", "check" } },
}

function M.Section(id)
    for _, s in ipairs(M.SECTIONS) do if s.id == id then return s end end
end

-- The section that holds a form (so a button elsewhere can open it).
function M.SectionOf(actionId)
    for _, s in ipairs(M.SECTIONS) do
        for _, a in ipairs(s.actions or {}) do if a == actionId then return s end end
    end
end

-- Which group of the record an entry belongs to, for the filter.
M.KINDS = {
    { id = "all", label = "Everything" },
    { id = "loot", label = "Loot" },
    { id = "list", label = "List changes" },
    { id = "rules", label = "Rules" },
    { id = "raid", label = "Raids" },
}
local KIND_OF = {
    Award = "loot", Revert = "loot", Salvage = "loot", Transfer = "loot", Pass = "loot",
    MovePlayer = "list", AddMember = "list", RemoveMember = "list",
    ItemSuits = "rules", ItemClasses = "rules",
    SetDisenchanter = "raid", SetRaidList = "raid", SetListPolicy = "raid", Declined = "raid",
}
function M.KindOf(eventType) return KIND_OF[eventType] or "list" end

-- How long ago, in a person's words (a day is the smallest step that reads well past a few hours).
function M.Ago(now, ts)
    if not (now and ts) then return "" end
    local s = now - ts
    if s < 60 then return "just now" end
    local function plural(n, unit) return ("%d %s%s ago"):format(n, unit, n == 1 and "" or "s") end
    if s < 3600 then return plural(math.floor(s / 60), "minute") end
    if s < 86400 then return plural(math.floor(s / 3600), "hour") end
    if s < 7 * 86400 then return plural(math.floor(s / 86400), "day") end
    if s < 60 * 86400 then return plural(math.floor(s / (7 * 86400)), "week") end
    return plural(math.floor(s / (30 * 86400)), "month")
end

-- The record: every change that belongs to a list, a rule or a raid, as a sentence, newest first.
--   ctx     { engine, client, commands }  (commands.describe turns one entry into words)
--   filter  { kind = "all"|"loot"|"list"|"rules"|"raid", text = "words to find in the sentence", limit = n, list = id }
-- Returns { entries = { { id, ts, when, kind, type, text } }, total = how many matched before the limit, shown = how many are in `entries`,
--           empty = a sentence for when there are none }.
function M.History(ctx, filter)
    filter = filter or {}
    local view = ctx.engine:View()
    local all = {}
    for _, ev in ipairs(view.applied) do
        if not filter.list or ev.list == filter.list or ev.type == "Declined" or ev.type == "ItemClasses" or ev.type == "ItemSuits" then all[#all + 1] = ev end
    end
    for _, ev in ipairs(view.authApplied or {}) do
        if ev.type == "SetDisenchanter" or ev.type == "SetRaidList" or ev.type == "SetListPolicy" then all[#all + 1] = ev end
    end
    local order = {}
    for i, ev in ipairs(all) do order[ev] = i end
    table.sort(all, function(x, y) if x.ts ~= y.ts then return x.ts > y.ts end return order[x] > order[y] end)

    local now = ctx.client:serverTime()
    local want = (filter.text and filter.text ~= "") and filter.text:lower() or nil
    local kind = filter.kind or "all"
    local out = { entries = {}, total = 0 }
    for _, ev in ipairs(all) do
        local k = M.KindOf(ev.type)
        if kind == "all" or kind == k then
            local text = ctx.commands.describe(ev)
            if not want or text:lower():find(want, 1, true) then
                out.total = out.total + 1
                if not filter.limit or #out.entries < filter.limit then
                    out.entries[#out.entries + 1] = { id = ev.id, ts = ev.ts, when = M.Ago(now, ev.ts), kind = k, type = ev.type, text = text }
                end
            end
        end
    end
    out.shown = #out.entries
    if out.total == 0 then
        out.empty = (#all == 0) and "Nothing has happened yet. Awards, moves and rule changes will appear here."
            or "Nothing matches. Clear the filter to see everything."
    end
    return out
end

function M:OnInit() end

return M
