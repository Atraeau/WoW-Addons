-- King's Gambit audit library: verify and report on a saved ledger WITHOUT the game.
-- Loads the same engine modules the addon uses, reads a SavedVariables file (KingsGambit.lua),
-- re-verifies every hash and rule, and builds standings and history reports. Anyone in the guild can
-- run this to check the record independently. See tools/kg.lua for the command line.
local M = {}

local MODULES = { "Hash", "Standings", "Ledger" }

-- Load the engine modules from a repo checkout. root = repo root (default ".").
function M.loadEngine(root)
    root = root or "."
    local SK = { modules = {} }
    function SK:NewModule(n) local m = { name = n }; self.modules[n] = m; return m end
    for _, name in ipairs(MODULES) do
        local chunk = assert(loadfile(root .. "/src/KingsGambit/" .. name .. ".lua"))
        chunk("KingsGambit", SK)
    end
    return SK.modules
end

-- Read KingsGambitDB from a SavedVariables file (it is plain Lua assignments).
function M.loadSaved(path)
    local env = {}
    local chunk, err = loadfile(path, "t", env)
    if not chunk then return nil, err end
    local ok, runErr = pcall(chunk)
    if not ok then return nil, runErr end
    if type(env.KingsGambitDB) ~= "table" then return nil, "no KingsGambitDB table in " .. path end
    return env.KingsGambitDB
end

local function sortedListIds(db)
    local ids = {}
    for id in pairs(db.lists or {}) do ids[#ids + 1] = id end
    table.sort(ids)
    return ids
end

-- Fully verify every list. Returns an array of
--   { list, ok, events, head, reason, index }
-- and the number of events set aside by resolved forks.
function M.verify(db, mods)
    local out = {}
    for _, id in ipairs(sortedListIds(db)) do
        local rec = db.lists[id]
        local chain, reason, index = mods.Ledger.Load(id, rec.events or {})
        local r = { list = id, ok = chain ~= nil, events = #(rec.events or {}) }
        if chain then r.head = chain.head else r.reason, r.index = reason, index end
        out[#out + 1] = r
    end
    local orphans = 0
    for _, o in ipairs(db.orphans or {}) do orphans = orphans + #o.events end
    return out, orphans
end

local function short(name) return (tostring(name):gsub("%-.*$", "")) end
local function date(ts) return os.date("!%Y-%m-%d %H:%M", ts) end

-- Rebuild a list and return its standings rows, top first (or nil + reason).
function M.standings(db, mods, listId)
    local rec = db.lists and db.lists[listId]
    if not rec then return nil, "no such list: " .. tostring(listId) end
    local chain, reason, index = mods.Ledger.Load(listId, rec.events or {})
    if not chain then
        return nil, ("list '%s' does not verify (%s at event %s)"):format(listId, tostring(reason), tostring(index))
    end
    local rows = {}
    for pos, name in ipairs(chain.state.order) do
        local m = chain.state.members[name]
        local last = m.lastWinSeq and chain.events[m.lastWinSeq]
        rows[#rows + 1] = { position = pos, name = short(name), class = m.class, wins = m.wins, passes = m.passes,
            upgradePasses = m.upgradePasses, lastWinItem = last and last.data.item, lastWinAt = last and last.ts }
    end
    return rows, chain
end

function M.markdown(rows, title)
    local out = { "### " .. title, "", "| # | Player | Wins | Last win | Upgrade passes |", "|---|--------|------|----------|----------------|" }
    for _, r in ipairs(rows) do
        out[#out + 1] = ("| %d | %s | %d | %s | %d |"):format(r.position, r.name, r.wins,
            r.lastWinItem and (r.lastWinItem .. " (" .. date(r.lastWinAt) .. ")") or "-", r.upgradePasses)
    end
    return table.concat(out, "\n")
end

local function describe(ev)
    local d, t = ev.data, ev.type
    if t == "CreateList" then return "list created: " .. tostring(d.name)
    elseif t == "AddMember" then return short(d.member) .. " joined"
    elseif t == "RemoveMember" then return short(d.member) .. " left"
    elseif t == "Award" then
        return short(d.member) .. " won " .. tostring(d.item) .. (d.to and (" (given to " .. short(d.to) .. ")") or "")
    elseif t == "Pass" then return short(d.member) .. " passed on " .. tostring(d.item) .. (d.kind and (" (" .. d.kind .. ")") or "")
    elseif t == "Transfer" then return "an award was re-routed to " .. short(d.to)
    elseif t == "MovePlayer" then return short(d.member) .. " moved to " .. tostring(d.pos) .. " (" .. tostring(d.reason) .. ")"
    elseif t == "Revert" then return "an award was undone"
    elseif t == "Disenchant" then return tostring(d.item) .. " disenchanted by " .. short(d.to)
    elseif t == "Salvage" then return "an award was " .. tostring(d.action)
    end
    return t
end

-- The last `limit` events as readable lines (default 20).
function M.history(db, listId, limit)
    local rec = db.lists and db.lists[listId]
    if not rec then return nil, "no such list: " .. tostring(listId) end
    local events, lines = rec.events or {}, {}
    for i = math.max(1, #events - (limit or 20) + 1), #events do
        local ev = events[i]
        lines[#lines + 1] = ("#%d  %s  %s  %s"):format(ev.seq, date(ev.ts), short(ev.author), describe(ev))
    end
    return lines
end

-- A SavedVariables-style Lua source for a table (used by tests to create fixtures).
function M.dump(value, indent)
    indent = indent or ""
    if type(value) == "string" then return ("%q"):format(value)
    elseif type(value) ~= "table" then return tostring(value) end
    local keys = {}
    for k in pairs(value) do keys[#keys + 1] = k end
    table.sort(keys, function(a, b)
        if type(a) == type(b) then return a < b end
        return type(a) == "number"
    end)
    local out = {}
    for _, k in ipairs(keys) do
        local key = type(k) == "string" and ("[%q]"):format(k) or ("[" .. k .. "]")
        out[#out + 1] = indent .. "  " .. key .. " = " .. M.dump(value[k], indent .. "  ") .. ","
    end
    return "{\n" .. table.concat(out, "\n") .. "\n" .. indent .. "}"
end

return M
