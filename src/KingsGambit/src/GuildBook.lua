-- King's Gambit: what the Guild book shows, as plain tables. Keep this file Lua 5.1-safe.
--
-- The Guild book is the larger, calmer window for the lists, the record of what happened, and the officers' tools (docs/ui-design.md, 5.2). Like the Loot
-- window, its screens are built here from the engine's state with no frames, so the game's window and the web simulator draw the same sections, the same
-- sentences and the same filters. Nothing here changes anything: a section's buttons run the same commands a player would type.
--
--   M.SECTIONS                            the navigation column, in order
--   M.History(ctx, filter)                the ledger as readable sentences, newest first, filtered (the Ledger section)
--   M.Detail(ctx, id)                     one entry as the raw record: kind, writer, time, id, chain and every field it carries
--   M.Stats(ctx, listId)                  who held which place for how long, wins and last win, by replaying the list with timestamps
--   M.Segments(text, people)              a sentence cut into plain words and people (a person carries their class color)
--   M.Ago(now, ts)                        "3 days ago"
local _, SK = ...
local LootView, Identity, Standings, Migrations
local M = SK:NewModule("GuildBook", { "LootView", "Identity", "Standings", "Migrations" },
    function(d) LootView, Identity, Standings, Migrations = d.LootView, d.Identity, d.Standings, d.Migrations end)

-- The sections of the navigation column. A section with `actions` is a page of forms (UITools actions, by id): each runs the command a player would type.
-- `gap` puts a space above its button: Admin is the guild master's and maintenance corner, kept apart from the everyday sections.
-- Every action belongs to exactly one section (the old History form is the Ledger section now).
M.SECTIONS = {
    { id = "lists", label = "Lists", tip = "The standings: who is first for what, and the officers' moves." },
    { id = "ledger", label = "Ledger", tip = "The record of everything that happened to the lists, in words: who won what, who moved whom, and why. Nothing in it can be edited or erased." },
    { id = "stats", label = "Stats", tip = "Who is at which place and for how long, who has won and when, from the record." },
    { id = "awards", label = "Awards", tip = "Record a win the session missed, undo an award, note where an item went. Corrections are new entries; nothing is erased.",
        actions = { "award", "undo", "trade", "salvaged", "disenchanted" } },
    { id = "raids", label = "Raids", tip = "Open and close a raid, choose its Master Looter, its list and its disenchanter.",
        actions = { "raidshow", "raidopen", "raidlist", "raidextend", "raidstart", "raidautostart", "raidclose", "raidrevoke", "masterloot", "disenchanter", "policy" } },
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
-- "happened" (the default) is what happened to items, lists, rules and raids: it leaves out passes, which are the most common entries by far and say what
-- could have happened, not what did, and attendance (who was in a raid), which has its own place in Stats (both stay in the record, under their own
-- filter and "Everything").
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
    return lines, item
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

---------------------------------------------------------------- stats: what the record already knows
-- A length of time in words: "3 days", "2 hours", "45 minutes", "under a minute".
function M.Span(seconds)
    seconds = math.max(0, seconds or 0)
    local function plural(n, unit) return ("%d %s%s"):format(n, unit, n == 1 and "" or "s") end
    if seconds < 60 then return "under a minute" end
    if seconds < 3600 then return plural(math.floor(seconds / 60), "minute") end
    if seconds < 86400 then return plural(math.floor(seconds / 3600), "hour") end
    return plural(math.floor(seconds / 86400), "day")
end

local statsCache = setmetatable({}, { __mode = "k" })

-- Replay one list from the record, remembering for every player each place they held and from when to when. Cached until the ledger changes.
local function replay(ctx, listId)
    local engine = ctx.engine
    local key = tostring(engine:Fingerprint()) .. "|" .. tostring(listId)
    local cached = statsCache[engine]
    if cached and cached.key == key then return cached.value end
    local s = Standings.New()
    local cur, hist, joined = {}, {}, {}
    local function close(who, ts, left)
        local c = cur[who]
        hist[who] = hist[who] or {}
        hist[who][#hist[who] + 1] = { place = c.place, from = c.from, to = ts, left = left or nil }
        cur[who] = nil
    end
    local function sync(ts)
        local present = {}
        for i, who in ipairs(s.order) do
            present[who] = true
            local c = cur[who]
            if not c then
                cur[who] = { place = i, from = ts }
                joined[who] = joined[who] or ts
            elseif c.place ~= i then
                close(who, ts)
                cur[who] = { place = i, from = ts }
            end
        end
        local gone = {}
        for who in pairs(cur) do if not present[who] then gone[#gone + 1] = who end end
        table.sort(gone)
        for _, who in ipairs(gone) do close(who, ts, true) end
    end
    for _, ev in ipairs(engine:View().applied) do
        if ev.list == listId then
            local up = Migrations.Up(engine.rules, ev)
            if up and Standings.Apply(s, up, engine.rules.handlers) then sync(ev.ts) end
        end
    end
    local value = { state = s, cur = cur, hist = hist, joined = joined }
    statsCache[engine] = { key = key, value = value }
    return value
end

-- The list as a table of stats, in order: place, how long they have held it, wins, when they last won; a sentence or two about the whole list; and each
-- player's earlier places (`M.PlaceHistory`). Times are from the entries' own timestamps, so they are the same for everyone with the same ledger.
function M.Stats(ctx, listId)
    local now = ctx.client:serverTime()
    local r = replay(ctx, listId)
    local att = M.Attendance(ctx, listId)
    local out = { list = listId, rows = {}, total = #r.state.order, summary = {}, now = now, attendance = att }
    local mostWins, waiting
    for i, who in ipairs(r.state.order) do
        local m, c = r.state.members[who], r.cur[who]
        local row = { who = who, name = Identity.Display(who), class = m.class, place = i, since = c and c.from, wins = m.wins or 0, lastWin = m.lastWinTs,
            joined = r.joined[who] }
        row.heldText = c and M.Span(now - c.from) or ""
        row.lastWinText = m.lastWinTs and (M.Ago(now, m.lastWinTs)) or "never"
        local a = att.byPlayer[who]
        row.raids, row.raidsText = a and a.attended or 0, att.total == 0 and "-" or ("%d/%d"):format(a and a.attended or 0, att.total)
        out.rows[i] = row
        if row.wins > 0 and (not mostWins or row.wins > mostWins.wins) then mostWins = row end
        if row.wins == 0 and row.joined and (not waiting or row.joined < waiting.joined) then waiting = row end
    end
    local first = out.rows[1]
    if first then out.summary[#out.summary + 1] = ("%s is first, and has been for %s."):format(first.name, first.heldText) end
    if mostWins then out.summary[#out.summary + 1] = ("Most wins: %s (%d)."):format(mostWins.name, mostWins.wins) end
    if waiting and waiting.joined then
        out.summary[#out.summary + 1] = ("Waiting longest without a win: %s, on the list for %s."):format(waiting.name, M.Span(now - waiting.joined))
    end
    if #out.rows == 0 then out.summary[1] = "Nobody is on this list yet." end
    out.hist, out.cur = r.hist, r.cur
    return out
end

-- One player's places, newest first: { place, from, to (nil while they still hold it), left, text }.
function M.PlaceHistory(stats, who)
    local out = {}
    local c = stats.cur[who]
    if c then out[1] = { place = c.place, from = c.from, text = ("place %d for %s (now)"):format(c.place, M.Span(stats.now - c.from)) } end
    local hist = stats.hist[who] or {}
    for i = #hist, 1, -1 do
        local h = hist[i]
        out[#out + 1] = { place = h.place, from = h.from, to = h.to, left = h.left,
            text = ("place %d for %s, until %s%s"):format(h.place, M.Span(h.to - h.from), M.Ago(stats.now, h.to), h.left and " (taken off the list)" or "") }
    end
    return out
end

---------------------------------------------------------------- attendance: who was in which raid, and for how long
-- Every raid on this list that has attendance entries, with how long each player was in it: { total = raids, raids = { { id, start, finish, length,
-- present = { [who] = seconds }, leftEarly = { [who] = true } } }, byPlayer = { [who] = { attended, seconds, length, percent, leftEarly } } }.
-- A raid with no attendance entries (one from before they were written) isn't counted, so nobody is marked absent from it. A player who was there at
-- some point attended; leaving before the raid ended is "left early".
function M.Attendance(ctx, listId)
    local engine = ctx.engine
    local view = engine:View()
    local now = ctx.client:serverTime()
    local out = { total = 0, raids = {}, byPlayer = {} }
    local ids = {}
    for id, r in pairs(view.auth.raids) do
        if engine:ListOfRaid(r) == listId and view.attendance[id] then ids[#ids + 1] = id end
    end
    table.sort(ids, function(a, b) return view.auth.raids[a].start < view.auth.raids[b].start end)
    for _, id in ipairs(ids) do
        local r = view.auth.raids[id]
        local finish = r.ended or math.min(r.expires, now)
        -- the raid officially starts at its first kill: the time of its first attendance entry, not when it was opened
        local start = view.attendance[id][1].ts
        local raid = { id = id, start = start, finish = finish, length = math.max(finish - start, 1), present = {}, leftEarly = {} }
        local since = {}
        local function close(who, ts)
            if since[who] then raid.present[who] = (raid.present[who] or 0) + math.max(0, math.min(ts, finish) - since[who]); since[who] = nil end
        end
        for _, ev in ipairs(view.attendance[id]) do
            for _, who in ipairs(ev.data.joined or {}) do if not since[who] then since[who] = math.min(ev.ts, finish); raid.present[who] = raid.present[who] or 0 end end
            for _, who in ipairs(ev.data.left or {}) do close(who, ev.ts) end
        end
        local stillThere = {}
        for who in pairs(since) do stillThere[who] = true end
        for who in pairs(stillThere) do close(who, finish) end
        for who in pairs(raid.present) do if not stillThere[who] then raid.leftEarly[who] = true end end
        out.total = out.total + 1
        out.raids[#out.raids + 1] = raid
        for who, secs in pairs(raid.present) do
            local p = out.byPlayer[who]
            if not p then p = { attended = 0, seconds = 0, length = 0, leftEarly = 0 }; out.byPlayer[who] = p end
            p.attended, p.seconds = p.attended + 1, p.seconds + secs
            if raid.leftEarly[who] then p.leftEarly = p.leftEarly + 1 end
        end
    end
    local lengthAll = 0
    for _, raid in ipairs(out.raids) do lengthAll = lengthAll + raid.length end
    for _, p in pairs(out.byPlayer) do
        p.length = lengthAll
        p.percent = lengthAll > 0 and math.floor(100 * p.seconds / lengthAll + 0.5) or 0
    end
    return out
end

-- One player's raids, newest first, in words.
function M.AttendanceLines(stats, who)
    local att, out = stats.attendance, {}
    for i = #att.raids, 1, -1 do
        local raid = att.raids[i]
        local secs = raid.present[who]
        local when = M.Ago(stats.now, raid.start)
        if secs then
            out[#out + 1] = ("Raid %s: in for %s of %s%s"):format(when, M.Span(secs), M.Span(raid.length), raid.leftEarly[who] and ", left early" or "")
        else
            out[#out + 1] = ("Raid %s: not there"):format(when)
        end
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
