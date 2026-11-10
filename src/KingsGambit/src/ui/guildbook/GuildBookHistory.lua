-- King's Gambit: the Guild book as tables, the record in words: kinds, filters, the history list, an entry's detail, and the stored-ledger rows. Keep this file Lua 5.1-safe.
-- Part of GuildBook (ui/GuildBook.lua): GuildBook merges what this module exports, so callers use GuildBook.<name>.
local _, SK = ...
local LootView, Identity, Ledgers
local M = SK:NewModule("GuildBookHistory", { "LootView", "Identity", "Ledgers" }, function(d) LootView, Identity, Ledgers = d.LootView, d.Identity, d.Ledgers end)

-- The stored ledgers as rows for the panel at the foot of the Admin section: { rows = { { n, key, title, detail, status, held, open, retired, canRetire, canKeep } }, note }.
-- Retiring removes the saved data from this computer only (Ledgers.lua); the page asks first and then runs `ledgers retire <n> yes`.
function M.Ledgers(ctx)
    local client = ctx.client
    local db = client.storage and client:storage().shared
    if not db then return { rows = {}, note = "This client doesn't keep stored ledgers (practice mode, for one)." } end
    local now = client:serverTime()
    local out = { rows = {} }
    for _, r in ipairs(Ledgers.Stored(db, client.world and client:world() or nil, client.world ~= nil)) do
        local d = Ledgers.Describe(r, now, Identity.Display)
        local may, whyNot = Ledgers.MayRetire(client, r)
        out.rows[#out.rows + 1] = { n = r.n, key = r.key, id = r.id, title = d.title, detail = d.detail, status = d.status, held = r.held, open = r.open,
            retired = r.retired ~= nil, canRetire = r.held and r.retired == nil and may, why = (r.held and r.retired == nil and not may) and whyNot or nil,
            canKeep = r.retired ~= nil and r.id ~= nil }
    end
    if #out.rows == 0 then out.note = "No ledgers are stored on this computer." end
    return out
end


M.KINDS = {
    { id = "happened", label = "What happened" },
    { id = "loot", label = "Loot" },
    { id = "list", label = "List changes" },
    { id = "rules", label = "Rules" },
    { id = "raid", label = "Raids" },
    { id = "passes", label = "Passes" },
    { id = "attendance", label = "Attendance" },
    { id = "all", label = "Everything" },
}
local KIND_OF = {
    Award = "loot", Disenchant = "loot", DisenchantResult = "loot", Revert = "loot", Salvage = "loot", Transfer = "loot",
    MovePlayer = "list", AddMember = "list", RemoveMember = "list",
    ItemSuits = "rules", ItemClasses = "rules",
    SetDisenchanter = "raid", SetRaidList = "raid", SetListPolicy = "raid", Declined = "raid", Attendance = "attendance",
}
-- Which group an entry belongs to. A pass is its own group, except one that records an outcome: a gift won but not given to anyone ("undecided") is what
-- happened to the item.
function M.KindOf(eventType, data)
    if eventType == "Pass" then return (type(data) == "table" and data.kind == "undecided") and "loot" or "passes" end
    return KIND_OF[eventType] or "list"
end

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
--   filter  { kind = "happened"|"loot"|"list"|"rules"|"raid"|"passes"|"all", text = "words to find in the sentence", limit = n, list = id }
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

local KIND_LABEL = { loot = "loot", list = "list change", rules = "rules", raid = "raid", passes = "pass", attendance = "attendance" }

-- The item an entry is about, as something the game can show or dress a character in: an item link, or "item:ID" (an id with nothing else), or nil
-- (a plain name has nothing to look up). What disenchanting gave belongs to the item that was disenchanted.
function M.ItemOf(ev, view)
    local d = type(ev) == "table" and ev.data or nil
    if not d then return nil end
    local item = d.item
    if ev.type == "DisenchantResult" and view then
        for _, e in ipairs(view.applied) do if e.id == d.disenchant then item = e.data and e.data.item end end
    end
    if type(item) == "number" then return "item:" .. item end
    if type(item) ~= "string" then return nil end
    local link = item:match("|c%x+|Hitem:.-|h%[.-%]|h|r") or item:match("|Hitem:.-|h%[.-%]|h")
    if link then return link end
    local id = item:match("^item:(%d+)")
    return id and ("item:" .. id) or nil
end

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
    local item = M.ItemOf(ev, view)
    add("Entry", ("%s (%s)"):format(ev.type, KIND_LABEL[M.KindOf(ev.type, ev.data)] or "other"))
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
    -- Can the reader undo this very entry? (an award they made, still on their undo stack)
    local canUndo = false
    if ev.type == "Award" and ev.list then
        local chain = ctx.engine:Get(ev.list)
        local stack = chain and chain.state.undo and chain.state.undo[ctx.engine:MyChain()]
        for _, e in ipairs(stack or {}) do if e.id == ev.id then canUndo = true end end
    end
    return lines, item, canUndo, ev
end

function M.History(ctx, filter)
    filter = filter or {}
    local people = peopleOf(ctx)
    local view = ctx.engine:View()
    local all = {}
    for _, ev in ipairs(view.applied) do
        local onList = (not filter.list and not filter.lists) or ev.list == filter.list or (filter.lists and filter.lists[ev.list])
        if (onList or ev.type == "Declined" or ev.type == "ItemClasses" or ev.type == "ItemSuits") and (not filter.since or ev.ts >= filter.since) then all[#all + 1] = ev end
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
    local kind = filter.kind or "happened"
    local out = { entries = {}, total = 0 }
    for _, ev in ipairs(all) do
        local k = M.KindOf(ev.type, ev.data)
        local shownEv, waiting = ev, false
        if ev.type == "Disenchant" then
            if results[ev.id] then shownEv = results[ev.id] else waiting = true end
        end
        if ev.type ~= "DisenchantResult" and (kind == "all" or kind == k or (kind == "happened" and k ~= "passes" and k ~= "attendance")) then
            local text = ctx.commands.describe(shownEv) .. (waiting and " (waiting for the result)" or "")
            ev = shownEv
            if not want or text:lower():find(want, 1, true) then
                out.total = out.total + 1
                if not filter.limit or #out.entries < filter.limit then
                    out.entries[#out.entries + 1] = { id = ev.id, ts = ev.ts, when = M.Ago(now, ev.ts), kind = k, type = ev.type, text = text,
                        segments = M.Segments(text, people), item = M.ItemOf(ev, view) }
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
