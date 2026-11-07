-- King's Gambit: the ledgers stored on this account, and retiring them. Keep this file Lua 5.1-safe.
--
-- KingsGambitDB.worlds holds one stored ledger per world (the game's ruleset, the faction and the guild: RealClient:storage). Over time some go stale: a guild
-- that is gone, a character that moved, a ledger founded to try something. This module lists what is stored, retires a ledger (removes its saved data, here)
-- and keeps a small TOMBSTONE for it, KingsGambitDB.retired[ledgerId], so that:
--   * this machine never fetches that ledger again from someone who still has it (no nagging),
--   * an officer's retirement is told to the guild in the heartbeat (field x), where each of the others can restore it (Keep: it is told to everyone, and the
--     ledger is fetched again from whoever still has it) or simply let it expire: after EXPIRES it is removed on their machine too, at their next login.
-- A ledger is told apart by the id of its Genesis entry (a hash that includes who founded it and when), never by its name, so a ledger founded again later
-- for the same guild is a different ledger and does not meet the retired one. This is NOT part of the ledger: nothing is written to it, so a retirement is
-- about copies on machines and the ledger's own history stays as it was wherever it is kept.
--
-- Tombstone: { id, name, world (the key it was stored under), by (who retired it), t (when decided, server time), r = 1 retired | 0 restored,
--              mine = this machine decided it, due = when this machine removes it (nil once restored) }
local _, SK = ...
local M = SK:NewModule("Ledgers", {}, function() end)

M.EXPIRES = 30 * 86400      -- how long a ledger others retired stays here before it is removed
M.PRUNE = 60 * 86400        -- a restored tombstone is forgotten after this long
M.MAX_TOMBSTONES = 200
M.MAX_ANNOUNCED = 8

local function tombs(db)
    db.retired = db.retired or {}
    return db.retired
end

-- "mode15-Alliance-guild:blue parse" -> mode, faction, kind ("guild" or "solo"), who. A key it can't read comes back as kind "other".
function M.ParseKey(key)
    local mode, faction, kind, who = tostring(key):match("^mode(%d+)%-(%a+)%-(%a+):(.+)$")
    if not mode then return { key = key, kind = "other", who = tostring(key) } end
    return { key = key, mode = tonumber(mode), faction = faction, kind = kind, who = who }
end

-- What a stored world holds, read from the saved events: the ledger's id and name, and counts.
local function inspect(store)
    local info = { events = 0, lists = 0, lastTs = nil, id = nil, name = nil, mine = 0 }
    local chains = store and store.ledger and store.ledger.chains or {}
    for _, chain in pairs(chains) do
        for _, ev in ipairs(chain.events or {}) do
            info.events = info.events + 1
            if type(ev.ts) == "number" and (not info.lastTs or ev.ts > info.lastTs) then info.lastTs = ev.ts end
            if ev.type == "Genesis" then
                info.id = ev.id
                info.name = type(ev.data) == "table" and ev.data.name or nil
            elseif ev.type == "CreateList" then
                info.lists = info.lists + 1
            end
        end
    end
    for _ in pairs(store and store.mine or {}) do info.mine = info.mine + 1 end
    return info
end

-- With `onlyOpen` the rows are limited to the world being played in (the ruleset, the faction and the guild): a character never sees, lists, retires or
-- restores a ledger of another ruleset, faction or guild, though they sit in the same saved file.
-- Every stored ledger, then every retired one whose data is gone, as rows: { n, key, held (data is stored here), open (the one in use now), id, name,
-- mode, faction, kind, who, events, lists, lastTs, retired = tombstone or nil }. Held rows are sorted by key.
function M.Stored(db, openKey, onlyOpen)
    local keys = {}
    for key in pairs(db.worlds or {}) do
        if not onlyOpen or key == openKey then keys[#keys + 1] = key end
    end
    table.sort(keys)
    local rows, seen = {}, {}
    for _, key in ipairs(keys) do
        local row = M.ParseKey(key)
        local info = inspect(db.worlds[key])
        for k, v in pairs(info) do row[k] = v end
        row.held, row.open = true, key == openKey
        local t = row.id and tombs(db)[row.id]
        row.retired = (t and t.r == 1) and t or nil
        if row.id then seen[row.id] = true end
        rows[#rows + 1] = row
    end
    local gone = {}
    for id, t in pairs(tombs(db)) do
        if t.r == 1 and not seen[id] and (not onlyOpen or t.world == openKey) then gone[#gone + 1] = t end
    end
    table.sort(gone, function(a, b) return (a.t or 0) < (b.t or 0) end)
    for _, t in ipairs(gone) do
        local row = M.ParseKey(t.world or "")
        row.held, row.open, row.id, row.name, row.retired, row.events, row.lists = false, false, t.id, t.name, t, 0, 0
        rows[#rows + 1] = row
    end
    for i, r in ipairs(rows) do r.n = i end
    return rows
end

function M.IsRetired(db, id)
    local t = type(id) == "string" and tombs(db)[id]
    return t ~= nil and t ~= false and t.r == 1
end

-- May this character retire that ledger? A guild's ledger is retired only by an officer OF THAT GUILD, by pressing the button: the game's "Is Officer" permission
-- in the guild this character is in now, and the ledger must be that guild's (being an officer or the Guild Master of another guild gives nothing here). A
-- ledger with no guild (your own, when you are in none) is yours to retire. Returns true, or false and why.
function M.MayRetire(client, row)
    if row.kind ~= "guild" then return true end
    if client.world and row.key ~= client:world() then return false, "that isn't the ledger of the guild you are in" end
    if not client.isOfficer or client:isOfficer() ~= true then
        return false, ("only an officer of %s can retire its ledger (a rank with the \"Is Officer\" permission)"):format((tostring(row.who):gsub("(%a)([%w']*)", function(a, b) return a:upper() .. b end)))
    end
    return true
end

-- Retire the stored ledger `key`: remove its data (an empty world is simply removed) and keep a tombstone. The open ledger can't be swapped while it is in
-- use: it is marked and removed at the next login (`later`). Returns true, tombstone-or-nil, later; or false and why ("unknown").
function M.Retire(db, key, by, now, openKey)
    local store = db.worlds and db.worlds[key]
    if not store then return false, "unknown" end
    local info = inspect(store)
    local t
    if info.id then
        t = { id = info.id, name = info.name or "ledger", world = key, by = by, t = now, r = 1, mine = true, due = now }
        tombs(db)[info.id] = t
    end
    local later = key == openKey
    if not later then db.worlds[key] = nil end
    return true, t, later
end

-- Forget a retirement (restore): the ledger counts again and, if its data is gone, is fetched again from whoever still has it. Returns the tombstone, or nil.
function M.Keep(db, id, now)
    local t = tombs(db)[id]
    if not t or t.r ~= 1 then return nil end
    t.r, t.t, t.due, t.mine = 0, now, nil, true
    return t
end

-- Remove the stored ledgers that are due (and forget old restorations). Returns what was removed: { { key, name, by, t, mine } }.
function M.Sweep(db, now)
    local out = {}
    for key, store in pairs(db.worlds or {}) do
        local info = inspect(store)
        local t = info.id and tombs(db)[info.id]
        if t and t.r == 1 and t.due and t.due <= now then
            db.worlds[key] = nil
            out[#out + 1] = { key = key, name = info.name, by = t.by, t = t.t, mine = t.mine }
        end
    end
    for id, t in pairs(tombs(db)) do
        if t.r == 0 and (t.t or 0) + M.PRUNE < now then tombs(db)[id] = nil end
    end
    table.sort(out, function(a, b) return a.key < b.key end)
    return out
end

-- What this machine says about its retirements for `worldKey`, for the heartbeat: { [id] = { t, r, b, n } }, newest first, a few. Nil if none.
function M.Announce(db, worldKey)
    local list = {}
    for id, t in pairs(tombs(db)) do
        if t.world == worldKey then list[#list + 1] = t end
    end
    if #list == 0 then return nil end
    table.sort(list, function(a, b) return (a.t or 0) > (b.t or 0) end)
    local x = {}
    for i = 1, math.min(#list, M.MAX_ANNOUNCED) do
        local t = list[i]
        x[t.id] = { t = t.t, r = t.r, b = t.by, n = t.name, w = t.world }
    end
    return x
end

local function sane(id, e, now)
    return type(id) == "string" and #id > 0 and #id <= 32 and type(e) == "table" and type(e.t) == "number" and e.t <= now + 3600
        and (e.r == 0 or e.r == 1) and type(e.b) == "string" and #e.b <= 64
        and (e.n == nil or (type(e.n) == "string" and #e.n <= 60)) and (e.w == nil or (type(e.w) == "string" and #e.w <= 80))
end

-- An officer's heartbeat said these ledgers are retired (r = 1) or restored (r = 0). The caller has checked the sender is an officer. The newest decision
-- for a ledger wins. Returns what to tell the player: { { kind = "retired"|"restored", id, name, by, due, held, key } } (only for ledgers kept here).
function M.Hear(db, x, now, worldKey)
    local told = {}
    if type(x) ~= "table" then return told end
    for id, e in pairs(x) do
        -- only about this guild's own ledger: a notice naming another world (another guild's officer in the same raid, say) is not about us
        if sane(id, e, now) and (worldKey == nil or e.w == nil or e.w == worldKey) then
            local have = tombs(db)[id]
            local heldKey
            for key, store in pairs(db.worlds or {}) do
                if (worldKey == nil or key == worldKey) and inspect(store).id == id then heldKey = key end -- only the ledger of the world being played in
            end
            if not have or have.t < e.t then
                if e.r == 1 then
                    -- remember it even when we don't hold it, so it is never fetched from someone who still has it
                    local count = 0
                    for _ in pairs(tombs(db)) do count = count + 1 end
                    if have or heldKey or count < M.MAX_TOMBSTONES then
                        tombs(db)[id] = { id = id, name = e.n or "ledger", world = worldKey or e.w or (heldKey or ""), by = e.b, t = e.t, r = 1, mine = false, due = e.t + M.EXPIRES }
                        if heldKey then told[#told + 1] = { kind = "retired", id = id, name = e.n, by = e.b, due = e.t + M.EXPIRES, key = heldKey } end
                    end
                elseif have then
                    tombs(db)[id] = { id = id, name = have.name, world = have.world, by = e.b, t = e.t, r = 0, mine = false }
                    if have.r == 1 then told[#told + 1] = { kind = "restored", id = id, name = have.name, by = e.b, key = heldKey } end
                end
            end
        end
    end
    return told
end

-- A row as a player reads it: { title, detail, status }. `display` turns a stored name into "First Last" (optional); `day` formats a time (optional).
local function titleCase(s) return (tostring(s):gsub("(%a)([%w']*)", function(a, b) return a:upper() .. b end)) end
local function ago(now, ts)
    if not ts then return "never" end
    local d = math.floor((now - ts) / 86400)
    if d <= 0 then return "today" elseif d == 1 then return "yesterday" end
    return d .. " days ago"
end
function M.Describe(row, now, display, day)
    display = display or function(n) return (tostring(n):gsub("_", " ")) end
    day = day or function(ts) return (date or os.date)("%Y-%m-%d", ts) end
    local where = row.kind == "guild" and (titleCase(row.who) .. (row.faction and (" (" .. row.faction .. ")") or ""))
        or row.kind == "solo" and ("Alone: " .. display(row.who) .. (row.faction and (" (" .. row.faction .. ")") or ""))
        or tostring(row.who)
    local detail
    if row.held then
        detail = ("ledger \"%s\", %d entr%s, %d list%s, last entry %s"):format(tostring(row.name or "none yet"), row.events, row.events == 1 and "y" or "ies",
            row.lists, row.lists == 1 and "" or "s", ago(now, row.lastTs))
    else
        detail = ("ledger \"%s\": its data is removed from this machine"):format(tostring(row.name or "?"))
    end
    local status
    local t = row.retired
    if t then
        if not row.held then
            status = ("retired by %s on %s"):format(t.mine and "you" or display(t.by), day(t.t))
        elseif row.open then
            status = ("in use now; retired by %s: removed at your next login"):format(t.mine and "you" or display(t.by))
        else
            status = ("retired by %s; removed %s"):format(t.mine and "you" or display(t.by), t.due and t.due > now and ("on " .. day(t.due)) or "at your next login")
        end
    elseif row.open then
        status = "in use now"
    elseif row.held and row.events == 0 then
        status = "empty"
    end
    return { title = where, detail = detail, status = status }
end

return M
