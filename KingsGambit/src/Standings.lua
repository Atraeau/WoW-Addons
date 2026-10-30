-- King's Gambit: the rules of one list (ledger v2). Pure Lua.
-- order[1] is the TOP of the list (first to win); winners drop to the bottom.
--
-- Every operation either moves one player to an end of the list, inserts one, or removes one. None of
-- them changes the relative order of the OTHER players, which is what lets events from parallel raids
-- (disjoint players) be merged in any order. Positions are therefore never stored as numbers: a move
-- names an anchor ("above Name") or an end ("top", "bottom").
--
-- Apply validates BEFORE it mutates, so a rejected event never changes state.
local _, SK = ...
local Hash
local M = SK:NewModule("Standings", { "Hash" }, function(d) Hash = d.Hash end)

function M.New()
    return {
        created = false,
        name = nil,
        order = {},   -- member names, top first
        members = {}, -- [name] = { class, active, wins, passes, upgradePasses, lastWinId, lastWinTs }
        awards = {},  -- [eventId] = { member, to, item, ts, reverted, salvage }
        undo = {},    -- [chainId] = stack of that writer's undoable awards
        count = 0,    -- events applied
    }
end

local function isName(v) return type(v) == "string" and v ~= "" end

local function indexOf(order, name)
    for i = 1, #order do
        if order[i] == name then return i end
    end
end
M.IndexOf = indexOf

-- Where to put a player: d.to = "top" | "bottom" (default bottom), or d.above = an active member.
-- Returns the insertion index in `order` (which must not contain the player), or nil + reason.
local function placement(s, order, d, default)
    if d.above ~= nil then
        if not isName(d.above) then return nil, "badanchor" end
        local i = indexOf(order, d.above)
        if not i then return nil, "badanchor" end
        return i
    end
    local to = d.to or default
    if to == "top" then return 1 end
    if to == "bottom" then return #order + 1 end
    return nil, "badpos"
end

-- A position as a person types it ("top", "bottom" or a number) as an anchor: { to = "top"|"bottom" } or
-- { above = whoever holds that place now, not counting `moving` }. Numbers are never stored, because their
-- meaning would shift as other raids' events arrive. Returns the anchor, or nil + reason ("badpos").
function M.Anchor(s, pos, moving)
    if pos == "top" or pos == "bottom" then return { to = pos } end
    local n = tonumber(pos)
    if not (n and s) or n < 1 or n ~= math.floor(n) then return nil, "badpos" end
    local others = {}
    for _, member in ipairs(s.order) do
        if member ~= moving then others[#others + 1] = member end
    end
    if n > #others then return { to = "bottom" } end
    return { above = others[n] }
end

local handlers = {}

function handlers.CreateList(s, ev, d)
    if s.created then return nil, "alreadycreated" end
    if not isName(d.name) then return nil, "badname" end
    return function() s.created, s.name = true, d.name end
end

function handlers.AddMember(s, ev, d)
    if not isName(d.member) then return nil, "badmember" end
    local m = s.members[d.member]
    if m and m.active then return nil, "alreadymember" end
    local idx, why = placement(s, s.order, d, "bottom")
    if not idx then return nil, why end
    return function()
        table.insert(s.order, idx, d.member)
        if m then
            m.active = true
            m.class = d.class or m.class
        else
            s.members[d.member] = { class = d.class, active = true, wins = 0, passes = 0, upgradePasses = 0 }
        end
    end
end

function handlers.RemoveMember(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    return function()
        table.remove(s.order, indexOf(s.order, d.member))
        m.active = false
        s.undo[ev.chain] = nil
    end
end

local planRevert

-- A win: the winner drops to the bottom. `to` (optional) is who actually receives the item (gifting).
-- `replaces` (optional) is a regret-trade: the item was recorded as won by someone else (that award, one of this writer's
-- own, is undone and they go back up) and `member` is who really has it, who pays as if they had won the bid. Both
-- happen or neither does.
function handlers.Award(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.item) then return nil, "baditem" end
    if d.to ~= nil and not isName(d.to) then return nil, "badrecipient" end
    local undo
    if d.replaces ~= nil then
        local old = s.awards[d.replaces]
        if old and old.member == d.member then return nil, "samewinner" end
        local why
        undo, why = planRevert(s, ev, d.replaces)
        if not undo then return nil, why end
    end
    return function()
        if undo then undo() end
        local idx = indexOf(s.order, d.member)
        local below = {}
        for i = idx + 1, #s.order do below[#below + 1] = s.order[i] end
        table.remove(s.order, idx)
        s.order[#s.order + 1] = d.member
        local stack = s.undo[ev.chain]
        if not stack then stack = {}; s.undo[ev.chain] = stack end
        stack[#stack + 1] = { id = ev.id, member = d.member, below = below,
            wins = m.wins, lastWinId = m.lastWinId, lastWinTs = m.lastWinTs }
        m.wins, m.lastWinId, m.lastWinTs = m.wins + 1, ev.id, ev.ts
        s.awards[ev.id] = { member = d.member, to = d.to or d.member, item = d.item, ts = ev.ts }
    end
end

-- A pass changes no position; it only feeds the transparency stats.
function handlers.Pass(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.item) then return nil, "baditem" end
    return function()
        m.passes = m.passes + 1
        if d.kind == "upgrade" then m.upgradePasses = m.upgradePasses + 1 end
    end
end

-- Re-route where an awarded item went (post-award gift target correction). No position change.
function handlers.Transfer(s, ev, d)
    local a = s.awards[d.award]
    if not a or a.reverted then return nil, "noaward" end
    if not isName(d.to) then return nil, "badrecipient" end
    return function() a.to = d.to end
end

-- Nobody wanted the item: it went to the disenchanter (and from there to the guild bank).
function handlers.Disenchant(s, ev, d)
    if not isName(d.item) then return nil, "baditem" end
    if not isName(d.to) then return nil, "badrecipient" end
    return function() end
end

local SALVAGE_ACTIONS = { keep = true, gift = true, sell = true, disenchant = true, bank = true }

-- What the player who claimed a salvage item did with it. Recorded for transparency only.
function handlers.Salvage(s, ev, d)
    local a = s.awards[d.award]
    if not a or a.reverted then return nil, "noaward" end
    if not SALVAGE_ACTIONS[d.action] then return nil, "badaction" end
    return function() a.salvage = d.action end
end

-- A correction: move a member to the top, the bottom, or just above another member. A reason is required.
function handlers.MovePlayer(s, ev, d)
    local m = s.members[d.member]
    if not (isName(d.member) and m and m.active) then return nil, "notmember" end
    if not isName(d.reason) then return nil, "noreason" end
    if d.above == d.member then return nil, "badanchor" end
    local rest = {}
    for _, n in ipairs(s.order) do
        if n ~= d.member then rest[#rest + 1] = n end
    end
    local idx, why = placement(s, rest, d, nil)
    if not idx then return nil, why end
    return function()
        table.insert(rest, idx, d.member)
        s.order = rest
        s.undo[ev.chain] = nil
    end
end

-- Undo this writer's most recent award: the winner goes back directly above the highest-placed of the
-- players who were below them when they won. That restores the winner's order relative to everyone,
-- whatever other writers did in between (their moves never change anyone else's relative order).
--
-- It can also undo an EARLIER award of the same writer without touching the awards made since (a big hand-out
-- shouldn't have to be taken apart to fix its first item). The list then ends up as if that award had never been made:
-- the winner goes just above the highest-placed of those who were below them when they won, or have won since (those
-- sit at the bottom now and would be below them anyway). Awards made after this one remember "who was below me", so
-- they forget this winner where the winner was above them to begin with. If the same player won something later, that
-- later win has to be undone first, or their place would be wrong ("laterwin").
function planRevert(s, ev, target)
    local stack = s.undo[ev.chain]
    local k
    for i = #(stack or {}), 1, -1 do
        if stack[i].id == target then k = i; break end
    end
    if not k then return nil, "notrevertible" end
    local top = stack[k]
    local m = s.members[top.member]
    if not (m and m.active) then return nil, "notmember" end
    for j = k + 1, #stack do
        if stack[j].member == top.member then return nil, "laterwin" end
    end
    return function()
        local wasBelow, since = {}, {}
        for _, name in ipairs(top.below) do wasBelow[name] = true end
        for j = k + 1, #stack do since[#since + 1] = stack[j].member end
        table.remove(s.order, indexOf(s.order, top.member))
        local at = #s.order + 1
        local function consider(name)
            local i = indexOf(s.order, name)
            if i and i < at then at = i end
        end
        for _, name in ipairs(top.below) do consider(name) end
        for _, name in ipairs(since) do consider(name) end
        table.insert(s.order, at, top.member)
        if k == #stack then
            m.wins, m.lastWinId, m.lastWinTs = top.wins, top.lastWinId, top.lastWinTs
        else
            m.wins = m.wins - 1
            if m.lastWinId == top.id then m.lastWinId, m.lastWinTs = top.lastWinId, top.lastWinTs end
            -- A later winner who was below this one to begin with: this winner was never below them.
            for j = k + 1, #stack do
                local later = stack[j]
                if wasBelow[later.member] then
                    local kept = {}
                    for _, name in ipairs(later.below) do
                        if name ~= top.member then kept[#kept + 1] = name end
                    end
                    later.below = kept
                end
            end
        end
        s.awards[top.id].reverted = true
        table.remove(stack, k)
    end
end

function handlers.Revert(s, ev, d) return planRevert(s, ev, d.target) end

M.TYPES = {}
for k in pairs(handlers) do M.TYPES[k] = true end

-- Validate and apply one list event. Returns true, or nil + reason (state untouched).
function M.Apply(s, ev)
    if type(ev.data) ~= "table" then return nil, "baddata" end
    local h = handlers[ev.type]
    if not h then return nil, "unknowntype" end
    if ev.type ~= "CreateList" and not s.created then return nil, "nolist" end
    local commit, err = h(s, ev, ev.data)
    if not commit then return nil, err end
    commit()
    s.count = s.count + 1
    return true
end

function M.Position(s, name) return indexOf(s.order, name) end

-- Fingerprint of the current ordering (compare standings independent of history).
function M.Digest(s) return Hash.Sum(Hash.Canon(s.order)) end
