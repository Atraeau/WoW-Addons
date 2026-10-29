-- King's Gambit: deterministic replay of ledger events into standings (Phase 1).
-- Pure Lua. order[1] is the TOP of the list (first to win); winners drop to the bottom.
--
-- Apply validates BEFORE it mutates, so a rejected event never changes state.
local _, SK = ...
local M = SK:NewModule("Standings")
local Hash = SK.modules.Hash

function M.New()
    return {
        created = false,
        name = nil,
        order = {},   -- member names, top first
        members = {}, -- [name] = { class, active, wins, passes, upgradePasses, lastWinSeq, lastWinTs, joinedSeq }
        awards = {},  -- [eventId] = { member, to, item, reverted }
        undo = {},    -- stack of reversible Awards (cleared by anything that shifts positions)
        count = 0,    -- events applied
    }
end

local function isName(v) return type(v) == "string" and v ~= "" end

local function indexOf(order, name)
    for i = 1, #order do
        if order[i] == name then return i end
    end
end

-- Resolve a position spec to a final 1-based index in 1..maxPos (nil = bottom).
local function resolvePos(pos, maxPos)
    if pos == nil or pos == "bottom" then return maxPos end
    if pos == "top" then return 1 end
    if type(pos) == "number" and pos == math.floor(pos) and pos >= 1 and pos <= maxPos then return pos end
end

local handlers = {}

function handlers.CreateList(s, ev, d)
    if not isName(d.name) then return nil, "badname" end
    s.created, s.name = true, d.name
    return true
end

function handlers.AddMember(s, ev, d)
    if not isName(d.member) then return nil, "badmember" end
    local m = s.members[d.member]
    if m and m.active then return nil, "alreadymember" end
    local idx = resolvePos(d.pos, #s.order + 1)
    if not idx then return nil, "badpos" end
    if idx <= #s.order then s.undo = {} end -- inserting above others shifts their positions
    table.insert(s.order, idx, d.member)
    if m then
        m.active = true
        m.class = d.class or m.class
    else
        s.members[d.member] = { class = d.class, active = true, wins = 0, passes = 0, upgradePasses = 0, joinedSeq = ev.seq }
    end
    return true
end

function handlers.RemoveMember(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    table.remove(s.order, indexOf(s.order, d.member))
    m.active = false
    s.undo = {}
    return true
end

-- A win: the winner drops to the bottom. `to` (optional) is who actually receives the item (gifting).
function handlers.Award(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.item) then return nil, "baditem" end
    if d.to ~= nil and not isName(d.to) then return nil, "badrecipient" end
    local idx = indexOf(s.order, d.member)
    table.remove(s.order, idx)
    s.order[#s.order + 1] = d.member
    s.undo[#s.undo + 1] = { id = ev.id, member = d.member, idx = idx,
        wins = m.wins, lastWinSeq = m.lastWinSeq, lastWinTs = m.lastWinTs }
    m.wins, m.lastWinSeq, m.lastWinTs = m.wins + 1, ev.seq, ev.ts
    s.awards[ev.id] = { member = d.member, to = d.to or d.member, item = d.item }
    return true
end

-- A pass changes no position; it only feeds the transparency stats.
function handlers.Pass(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.item) then return nil, "baditem" end
    m.passes = m.passes + 1
    if d.kind == "upgrade" then m.upgradePasses = m.upgradePasses + 1 end
    return true
end

-- Re-route where an awarded item went (post-award gift target correction). No position change.
function handlers.Transfer(s, ev, d)
    local a = s.awards[d.award]
    if not a or a.reverted then return nil, "noaward" end
    if not isName(d.to) then return nil, "badrecipient" end
    a.to = d.to
    return true
end

-- Officer correction: place a member at an explicit position. A reason is mandatory.
function handlers.MovePlayer(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.reason) then return nil, "noreason" end
    local idx = resolvePos(d.pos, #s.order)
    if not idx then return nil, "badpos" end
    table.remove(s.order, indexOf(s.order, d.member))
    table.insert(s.order, idx, d.member)
    s.undo = {}
    return true
end

-- Exact undo of the most recent Award (only while nothing has shifted positions since).
function handlers.Revert(s, ev, d)
    local top = s.undo[#s.undo]
    if not top or top.id ~= d.target then return nil, "notrevertible" end
    local m = s.members[top.member]
    table.remove(s.order, indexOf(s.order, top.member))
    table.insert(s.order, top.idx, top.member)
    m.wins, m.lastWinSeq, m.lastWinTs = top.wins, top.lastWinSeq, top.lastWinTs
    s.awards[top.id].reverted = true
    s.undo[#s.undo] = nil
    return true
end

-- Validate and apply one event. Returns true, or nil + reason (state untouched).
function M.Apply(s, ev)
    if ev.seq ~= s.count + 1 then return nil, "badseq" end
    if type(ev.ts) ~= "number" then return nil, "badts" end
    if not isName(ev.author) then return nil, "badauthor" end
    if type(ev.data) ~= "table" then return nil, "baddata" end
    local h = handlers[ev.type]
    if not h then return nil, "unknowntype" end
    if ev.type == "CreateList" then
        if s.created then return nil, "alreadycreated" end
    elseif not s.created then
        return nil, "nolist"
    end
    local ok, err = h(s, ev, ev.data)
    if not ok then return nil, err end
    s.count = s.count + 1
    return true
end

-- Rebuild standings from an event array. On failure: nil, reason, index of the bad event.
function M.Replay(events)
    local s = M.New()
    for i, ev in ipairs(events) do
        local ok, err = M.Apply(s, ev)
        if not ok then return nil, err, i end
    end
    return s
end

function M.Position(s, name) return indexOf(s.order, name) end

-- Fingerprint of the current ordering (compare standings independent of history).
function M.Digest(s) return Hash.Sum(Hash.Canon(s.order)) end
