-- King's Gambit: the Guild book as tables, what the record already knows: stats per player, sorting, place history, and attendance. Keep this file Lua 5.1-safe.
-- Part of GuildBook (ui/GuildBook.lua): GuildBook merges what this module exports, so callers use GuildBook.<name>.
local _, SK = ...
local Identity, Standings, Migrations, GuildBookHistory
local M = SK:NewModule("GuildBookStats", { "Identity", "Standings", "Migrations", "GuildBookHistory" }, function(d) Identity, Standings, Migrations, GuildBookHistory = d.Identity, d.Standings, d.Migrations, d.GuildBookHistory end)

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
        row.heldSeconds = c and (now - c.from) or nil
        row.lastWinText = m.lastWinTs and (GuildBookHistory.Ago(now, m.lastWinTs)) or "never"
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

-- The Stats table's columns, and how it is sorted. Opened, it shows the most active first (most wins, then the latest win, then the most raids); clicking a heading
-- sorts by it (a name A to Z, a count with the most at the top, the places from first), and clicking the same heading again reverses it.
M.STATS_COLUMNS = {
    { id = "place", label = "#", first = "asc" },
    { id = "player", label = "Player", first = "asc" },
    { id = "held", label = "At this place", first = "desc" },
    { id = "wins", label = "Wins", first = "desc" },
    { id = "lastwin", label = "Last win", first = "desc" },
    { id = "raids", label = "Raids", first = "desc" },
}
function M.StatsDefaultSort() return { key = "activity", dir = "desc" } end

-- What a click on a heading does: the same heading flips the direction; another starts the way that column reads first.
function M.NextStatsSort(current, key)
    if current and current.key == key then return { key = key, dir = current.dir == "asc" and "desc" or "asc" } end
    for _, c in ipairs(M.STATS_COLUMNS) do
        if c.id == key then return { key = key, dir = c.first } end
    end
    return M.StatsDefaultSort()
end

-- The rows in the order asked for (a new table; the rows are the same). Ties always fall back to the most active, then the list's own order, so the order is the same everywhere.
function M.SortStats(rows, sort)
    sort = sort or M.StatsDefaultSort()
    local function value(r, key)
        if key == "place" then return r.place
        elseif key == "player" then return (r.name or ""):lower()
        elseif key == "held" then return r.heldSeconds or -1
        elseif key == "wins" then return r.wins or 0
        elseif key == "lastwin" then return r.lastWin or 0
        elseif key == "raids" then return r.raids or 0 end
    end
    local out = {}
    for i, r in ipairs(rows) do out[i] = r end
    local sign = sort.dir == "asc" and 1 or -1
    table.sort(out, function(a, b)
        if sort.key ~= "activity" then
            local va, vb = value(a, sort.key), value(b, sort.key)
            if va ~= vb then return (va < vb) == (sign == 1) end
        end
        -- the most active: wins, then the latest win, then raids attended; then the list's own order
        local wa, wb = a.wins or 0, b.wins or 0
        if wa ~= wb then return wa > wb end
        local la, lb = a.lastWin or 0, b.lastWin or 0
        if la ~= lb then return la > lb end
        local ra, rb = a.raids or 0, b.raids or 0
        if ra ~= rb then return ra > rb end
        return a.place < b.place
    end)
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
            text = ("place %d for %s, until %s%s"):format(h.place, M.Span(h.to - h.from), GuildBookHistory.Ago(stats.now, h.to), h.left and " (taken off the list)" or "") }
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
