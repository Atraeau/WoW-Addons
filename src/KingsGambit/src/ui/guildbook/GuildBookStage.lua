-- King's Gambit: the Guild book as tables, staged list changes: simulate, preview, stage a move or removal, and the commands they become. Keep this file Lua 5.1-safe.
-- Part of GuildBook (ui/GuildBook.lua): GuildBook merges what this module exports, so callers use GuildBook.<name>.
local _, SK = ...
local Identity
local M = SK:NewModule("GuildBookStage", { "Identity" }, function(d) Identity = d.Identity end)

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
