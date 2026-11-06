-- King's Gambit: what the Guild book shows, as plain tables. Keep this file Lua 5.1-safe.
--
-- The Guild book is the larger, calmer window for the lists, the record of what happened, and the officers' tools (docs/ui-design.md, 5.2). Like the Loot
-- window, its screens are built here from the engine's state with no frames, so the game's window and the web simulator draw the same sections, the same
-- sentences and the same filters. Nothing here changes anything: a section's buttons run the same commands a player would type.
--
--   M.SECTIONS                            the navigation column, in order
--   M.History(ctx, filter)                the ledger as readable sentences, newest first, filtered (the Ledger section)
--   M.Detail(ctx, id)                     one entry as the raw record: kind, writer, time, id, chain and every field it carries
--   M.Segments(text, people)              a sentence cut into plain words and people (a person carries their class color)
--   M.Ago(now, ts)                        "3 days ago"
local _, SK = ...
local LootView, Identity
local M = SK:NewModule("GuildBook", { "LootView", "Identity" }, function(d) LootView, Identity = d.LootView, d.Identity end)

-- The sections of the navigation column. A section with `actions` is a page of forms (UITools actions, by id): each runs the command a player would type.
-- `gap` puts a space above its button: Admin is the guild master's and maintenance corner, kept apart from the everyday sections.
-- Every action belongs to exactly one section (the old History form is the Ledger section now).
M.SECTIONS = {
    { id = "lists", label = "Lists", tip = "The standings: who is first for what, and the officers' moves." },
    { id = "ledger", label = "Ledger", tip = "The record of everything that happened to the lists, in words: who won what, who moved whom, and why. Nothing in it can be edited or erased." },
    { id = "awards", label = "Awards", tip = "Record a win the session missed, undo an award, note where an item went. Corrections are new entries; nothing is erased.",
        actions = { "award", "undo", "trade", "salvaged", "disenchanted" } },
    { id = "raids", label = "Raids", tip = "Open and close a raid, choose its Master Looter, its list and its disenchanter.",
        actions = { "raidshow", "raidopen", "raidlist", "raidextend", "raidclose", "raidrevoke", "masterloot", "disenchanter", "policy" } },
    { id = "people", label = "People", tip = "Add, remove and move players; who the officers are; and your own spec.",
        actions = { "add", "remove", "move", "officers", "officersset", "spec", "hints" } },
    { id = "rules", label = "Rules", tip = "Which classes may bid on an item, who it suits, and requests to the Master Looter.",
        actions = { "eligibles", "eligible", "suits", "reqelig", "request", "requests", "accept", "decline" } },
    { id = "admin", label = "Admin", gap = true, tip = "Starting a list, the record's format and versions, syncing: the guild master's and maintenance steps. (The record itself is the Ledger.)",
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
    Award = "loot", Disenchant = "loot", DisenchantResult = "loot", Revert = "loot", Salvage = "loot", Transfer = "loot", Pass = "loot",
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
-- Everyone the record can name, as the sentences write them (First Last), with their class: from every list's members and from the group and guild.
local function peopleOf(ctx)
    local byName = {}
    local function add(name, class)
        if not (name and class and LootView.CLASS_COLOR[class]) then return end
        local shown = Identity.Display(name)
        if shown ~= "" and not byName[shown] then byName[shown] = { name = shown, class = class, color = LootView.CLASS_COLOR[class] } end
    end
    for _, id in ipairs(ctx.engine:Lists()) do
        local chain = ctx.engine:Get(id)
        for name, m in pairs(chain and chain.state.members or {}) do add(name, m.class) end
    end
    for _, source in ipairs { ctx.client:roster(), ctx.client:guildRoster() } do
        for _, m in ipairs(source) do add(m.name, m.class) end
    end
    local list = {}
    for _, p in pairs(byName) do list[#list + 1] = p end
    table.sort(list, function(a, b) if #a.name ~= #b.name then return #a.name > #b.name end return a.name < b.name end) -- longest first
    return list
end

-- A sentence cut into pieces: plain words `{ text }` and people `{ who = { name, class, color } }` (a name as a whole word, never inside an item link).
function M.Segments(text, people)
    local masked = text:gsub("|H.-|h%[.-%]|h", function(span) return ("\1"):rep(#span) end)
    local hits = {}
    for _, p in ipairs(people or {}) do
        local from = 1
        while true do
            local s, e = masked:find(p.name, from, true)
            if not s then break end
            local before, after = masked:sub(s - 1, s - 1), masked:sub(e + 1, e + 1)
            if not before:match("[%w_]") and not after:match("[%w_]") then
                hits[#hits + 1] = { s = s, e = e, p = p }
                masked = masked:sub(1, s - 1) .. ("\1"):rep(e - s + 1) .. masked:sub(e + 1) -- taken: a shorter name inside it can't match again
            end
            from = e + 1
        end
    end
    table.sort(hits, function(a, b) return a.s < b.s end)
    local out, at = {}, 1
    for _, h in ipairs(hits) do
        if h.s > at then out[#out + 1] = { text = text:sub(at, h.s - 1) } end
        out[#out + 1] = { who = { name = h.p.name, class = h.p.class, color = h.p.color } }
        at = h.e + 1
    end
    if at <= #text then out[#out + 1] = { text = text:sub(at) } end
    return out
end

-- A field's value as plain text: a name or number as it is, a list of names joined, a list of { name, count } as "3 Strange Dust".
local function valueText(v)
    if type(v) ~= "table" then return tostring(v) end
    local parts = {}
    for i, x in ipairs(v) do
        if type(x) == "table" and x.name then parts[i] = ("%s %s"):format(tostring(x.count or 1), tostring(x.name))
        elseif type(x) == "table" then parts[i] = "{...}"
        else parts[i] = tostring(x) end
    end
    if #parts == 0 then
        local keys = {}
        for k in pairs(v) do keys[#keys + 1] = tostring(k) end
        table.sort(keys)
        return #keys == 0 and "(none)" or ("{" .. table.concat(keys, ", ") .. "}")
    end
    return table.concat(parts, ", ")
end

local KIND_LABEL = { loot = "loot", list = "list change", rules = "rules", raid = "raid" }

-- One entry as the raw record, for whoever wants to see exactly what was written: { label, value } lines. The entry is found by its id.
function M.Detail(ctx, id)
    local view = ctx.engine:View()
    local ev
    for _, source in ipairs { view.applied, view.authApplied or {} } do
        for _, e in ipairs(source) do if e.id == id then ev = e end end
    end
    if not ev then return nil end
    local lines = {}
    local function add(label, value) lines[#lines + 1] = { label = label, value = tostring(value) } end
    add("Entry", ("%s (%s)"):format(ev.type, KIND_LABEL[M.KindOf(ev.type)] or "other"))
    add("Written by", Identity.Display(ev.author))
    local stamp = ""
    local dateFn = rawget(_G, "date") or (os and os.date)
    if dateFn and ev.ts then
        local ok, text = pcall(dateFn, "%Y-%m-%d %H:%M:%S", ev.ts)
        if ok then stamp = text .. " " end
    end
    add("When", stamp .. "(" .. M.Ago(ctx.client:serverTime(), ev.ts) .. ")")
    if ev.list then add("List", ev.list) end
    add("Id", ("#%s, number %s of %s"):format(tostring(ev.id), tostring(ev.seq), tostring(ev.chain)))
    local keys = {}
    for k in pairs(ev.data or {}) do keys[#keys + 1] = k end
    table.sort(keys)
    for _, k in ipairs(keys) do add(k, valueText(ev.data[k])) end
    return lines
end

function M.History(ctx, filter)
    filter = filter or {}
    local people = peopleOf(ctx)
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

    -- What disenchanting gave is one line with the item: "given to X to disenchant (waiting)" until it is recorded, then "X disenchanted it and got ...".
    local results = {}
    for _, ev in ipairs(all) do
        if ev.type == "DisenchantResult" and type(ev.data) == "table" then results[ev.data.disenchant] = ev end
    end
    local now = ctx.client:serverTime()
    local want = (filter.text and filter.text ~= "") and filter.text:lower() or nil
    local kind = filter.kind or "all"
    local out = { entries = {}, total = 0 }
    for _, ev in ipairs(all) do
        local k = M.KindOf(ev.type)
        local shownEv, waiting = ev, false
        if ev.type == "Disenchant" then
            if results[ev.id] then shownEv = results[ev.id] else waiting = true end
        end
        if ev.type ~= "DisenchantResult" and (kind == "all" or kind == k) then
            local text = ctx.commands.describe(shownEv) .. (waiting and " (waiting for the result)" or "")
            ev = shownEv
            if not want or text:lower():find(want, 1, true) then
                out.total = out.total + 1
                if not filter.limit or #out.entries < filter.limit then
                    out.entries[#out.entries + 1] = { id = ev.id, ts = ev.ts, when = M.Ago(now, ev.ts), kind = k, type = ev.type, text = text,
                        segments = M.Segments(text, people) }
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

---------------------------------------------------------------- staged list changes
-- Changes to a list are STAGED first: a list of operations the table previews, applied together with one reason. `ops` is an array of
-- { kind = "move", who, to } (to = the place the player takes once they are taken out of the line) and { kind = "remove", who }. They are
-- applied in order, each against the list the earlier ones left, so what the preview shows (a simulation of exactly this) is what is written.

local function indexOf(list, name)
    for i, n in ipairs(list) do if n == name then return i end end
end

-- The order after the operations, and who was removed. Operations about a player no longer in the line are skipped.
function M.Simulate(order0, ops)
    local order, removed = {}, {}
    for i, n in ipairs(order0) do order[i] = n end
    for _, op in ipairs(ops or {}) do
        local at = indexOf(order, op.who)
        if at then
            table.remove(order, at)
            if op.kind == "move" then table.insert(order, math.min(math.max(op.to, 1), #order + 1), op.who)
            else removed[#removed + 1] = op.who end
        end
    end
    return order, removed
end

-- The table's rows as they would be: each at its new place (`shown`), a moved player marked (`moving`, still remembering `pos`), removed players gone.
function M.Preview(rows, ops)
    if not ops or #ops == 0 then return rows end
    local byWho, order0, moved = {}, {}, {}
    for i, r in ipairs(rows) do byWho[r.who] = r; order0[i] = r.who end
    for _, op in ipairs(ops) do if op.kind == "move" then moved[op.who] = true end end
    local out = {}
    for i, who in ipairs(M.Simulate(order0, ops)) do
        local c = {}
        for k, v in pairs(byWho[who]) do c[k] = v end
        c.shown, c.moving = i, moved[who] and true or nil
        out[i] = c
    end
    return out
end

local function without(ops, who, kind)
    local out = {}
    for _, op in ipairs(ops) do
        if not (op.who == who and (kind == nil or op.kind == kind)) then out[#out + 1] = op end
    end
    return out
end

-- Stage a move of `who` to a place (a place they already hold, as the earlier operations leave it, stages nothing and clears an earlier move of theirs).
-- A player's earlier staged move is replaced where it stood in the sequence. Changes `ops` in place; returns whether anything is staged for them.
function M.StageMove(ops, order0, who, to)
    local at
    for i, op in ipairs(ops) do if op.who == who and op.kind == "move" then at = i; break end end
    local before = {}
    for i, op in ipairs(ops) do if not at or i < at then before[#before + 1] = op end end
    local base = M.Simulate(order0, before)
    local place = indexOf(base, who)
    if not place then return false end
    to = math.floor(math.max(1, math.min(#base, tonumber(to) or place)))
    if to == place then
        if at then table.remove(ops, at) end
        return false
    end
    if at then ops[at] = { kind = "move", who = who, to = to } else ops[#ops + 1] = { kind = "move", who = who, to = to } end
    return true
end

-- Stage taking `who` off the list (a staged move of theirs is dropped: they are going).
function M.StageRemove(ops, who)
    local kept = without(ops, who)
    for i = #ops, 1, -1 do ops[i] = nil end
    for i, op in ipairs(kept) do ops[i] = op end
    ops[#ops + 1] = { kind = "remove", who = who }
end

-- Drop everything staged for `who`.
function M.Unstage(ops, who)
    local kept = without(ops, who)
    for i = #ops, 1, -1 do ops[i] = nil end
    for i, op in ipairs(kept) do ops[i] = op end
end

function M.Staged(ops, who)
    for _, op in ipairs(ops or {}) do if op.who == who then return op end end
end

-- One operation in words.
function M.OpText(op)
    local who = Identity.Display(op.who)
    if op.kind == "move" then return ("%s to place %d"):format(who, op.to) end
    return ("remove %s"):format(who)
end

-- The pending changes in words: "2 pending changes: Aldric Stormwind to place 1; remove Ilsa Greywater".
function M.PendingText(ops)
    if not ops or #ops == 0 then return "No pending changes. Move or remove players above, then apply them together." end
    local parts = {}
    for i, op in ipairs(ops) do parts[i] = M.OpText(op) end
    return ("%d pending change%s: %s"):format(#ops, #ops == 1 and "" or "s", table.concat(parts, "; "))
end

-- The commands that write the staged changes, in order, each with the one reason; or nil and what is missing.
function M.Commands(ops, reason)
    reason = (tostring(reason or ""):gsub("^%s+", ""):gsub("%s+$", ""))
    if not ops or #ops == 0 then return nil, "Nothing is staged: move or remove a player first." end
    if reason == "" then return nil, "A change needs a reason: it is part of the record. Type it in the Reason box." end
    local out = {}
    for i, op in ipairs(ops) do
        out[i] = op.kind == "move" and ("move %s %d %s"):format(op.who, op.to, reason) or ("remove %s %s"):format(op.who, reason)
    end
    return out
end

function M:OnInit() end

return M
