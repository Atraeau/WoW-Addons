-- King's Gambit audit library: verify and report on a saved ledger WITHOUT the game.
-- Loads the same engine modules the addon uses, reads a SavedVariables file (KingsGambit.lua),
-- re-verifies every hash and rule, and builds standings and history reports. Anyone in the guild can
-- run this to check the record independently. See tools/kg.lua for the command line.
local M = {}

local MODULES = { "Hash", "Standings", "Ledger" }

-- Load the engine modules from a repo checkout. root = repo root (default ".").
function M.loadEngine(root)
    root = root or "."
    local SK = {}
    for _, name in ipairs({ "Registry", table.unpack(MODULES) }) do
        local chunk = assert(loadfile(root .. "/src/KingsGambit/" .. name .. ".lua"))
        chunk("KingsGambit", SK)
    end
    SK:Resolve()
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

-- Load and fully verify every writer's chain (hashes, links, times), then replay them merged.
-- Returns the store, the view and the problems ({ [chainId] = { reason, index } }).
function M.load(db, mods)
    local store, problems = mods.Ledger.LoadStore(db.ledger or { chains = {} })
    return store, mods.Ledger.View(store), problems
end

-- Returns an array of { chain, ok, events, head, reason, index } (one per saved chain), the ledger view,
-- the fingerprint, and the number of events kept aside after a resolved chain fork.
function M.verify(db, mods)
    local store, view, problems = M.load(db, mods)
    local ids = {}
    for cid in pairs((db.ledger and db.ledger.chains) or {}) do ids[#ids + 1] = cid end
    table.sort(ids)
    local out = {}
    for _, cid in ipairs(ids) do
        local saved = db.ledger.chains[cid].events or {}
        local r = { chain = cid, ok = problems[cid] == nil, events = #saved }
        if r.ok then
            r.head = store.chains[cid] and store.chains[cid].head or "-"
        else
            r.reason, r.index = problems[cid].reason, problems[cid].index
        end
        out[#out + 1] = r
    end
    local orphans = 0
    for _, o in ipairs(db.orphans or {}) do orphans = orphans + #o.events end
    return out, view, mods.Ledger.Fingerprint(store), orphans
end

local function short(name) return (tostring(name):gsub("%-.*$", "")) end
local function date(ts) return os.date("!%Y-%m-%d %H:%M", ts) end

-- The standings of one list, top first (or nil + reason if any chain fails to verify).
function M.standings(db, mods, listId)
    local _, view, problems = M.load(db, mods)
    local bad = next(problems)
    if bad then
        return nil, ("the ledger does not verify (chain %s: %s at event %s)"):format(bad, tostring(problems[bad].reason), tostring(problems[bad].index))
    end
    local st = view.lists[listId]
    if not st then return nil, "no such list: " .. tostring(listId) end
    local rows = {}
    for pos, name in ipairs(st.order) do
        local m = st.members[name]
        local last = m.lastWinId and st.awards[m.lastWinId]
        rows[#rows + 1] = { position = pos, name = short(name), class = m.class, wins = m.wins, passes = m.passes,
            upgradePasses = m.upgradePasses, lastWinItem = last and last.item, lastWinAt = last and last.ts }
    end
    return rows, st
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
    elseif t == "Elevate" then return short(d.ml) .. " became Master Looter for raid " .. tostring(d.raid) .. " (" .. tostring(d.minutes) .. " min)"
    end
    return t
end

-- The last `limit` applied events of a list as readable lines (default 20), in merge order.
function M.history(db, listId, limit, mods)
    local _, view = M.load(db, mods)
    if not view.lists[listId] then return nil, "no such list: " .. tostring(listId) end
    local events, lines = {}, {}
    for _, ev in ipairs(view.applied) do
        if ev.list == listId then events[#events + 1] = ev end
    end
    for i = math.max(1, #events - (limit or 20) + 1), #events do
        local ev = events[i]
        lines[#lines + 1] = ("%s  %s  %s"):format(date(ev.ts), short(ev.author), describe(ev))
    end
    return lines
end

-- Events that were skipped in replay, with the reason (e.g. written during a raid by someone else).
function M.conflicts(db, mods)
    local _, view = M.load(db, mods)
    local lines = {}
    for _, c in ipairs(view.conflicts) do
        lines[#lines + 1] = ("%s  %s  %s%s skipped: %s"):format(date(c.ts), short(c.author), c.type,
            c.list and (" on " .. c.list) or "", c.reason)
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
