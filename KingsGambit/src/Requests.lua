-- King's Gambit: adjustment requests, the dispute path (design: docs/ledger-v2-design.md, section 4).
-- During a raid only that raid's Master Looter writes to the ledger. Anyone else who thinks the list should change
-- (an officer fixing a mistake, a raider disputing a result) sends the Master Looter a REQUEST, with a reason. The
-- Master Looter accepts or declines it, and both outcomes go in the ledger:
--   accepted: the change itself, written by the Master Looter, carrying requestedBy, rid and the reason;
--   declined: a Declined event { request, requestedBy, declineReason, rid }, which changes no standing.
-- The outcome reaches the requester (and everyone) through the ledger, as any event does, so a lost whisper can't
-- lose a decision. The requester's name is the whisper's sender as the game reports it, so it can't be forged.
--
-- Messages (Sync plugin types):
--   QR  request   requester -> Master Looter (WHISPER)  { rid, kind, member?, pos?, item?, to?, reason }
--   QK  received  Master Looter -> requester (WHISPER)  { rid, ok, num?, why? }
-- A request is re-sent until it is acknowledged (the Master Looter ignores repeats), then waits for its outcome.
--
-- Kinds (all on the main list):
--   move     member, pos          move a player (top, bottom or a place number)
--   undo     member               undo that player's most recent award (only if it is the Master Looter's latest)
--   add      member, pos?         add a player (default: bottom)
--   remove   member               take a player off the list
--   award    member, item, to?    record a win that wasn't recorded (e.g. a hand-over that failed)
--   gift     member, to           the item that player last won actually went to someone else (no position change)
local _, SK = ...
local Standings
local M = SK:NewModule("Requests", { "Standings" }, function(d) Standings = d.Standings end)

M.LIST = "main"
M.MAX_REASON = 200
M.MAX_PENDING_PER_PLAYER = 3
M.RETRY_SECONDS, M.MAX_TRIES = 4, 5

local function isName(v) return type(v) == "string" and v ~= "" end
local function short(n) return n and (n:gsub("%-.*$", "")) end

local POSITIONS = { top = true, bottom = true }
local function isPos(p) return POSITIONS[p] or (tonumber(p) ~= nil and tonumber(p) >= 1 and tonumber(p) % 1 == 0) end

-- What each kind needs. Returns true, or nil + reason.
local NEEDS = {
    move = function(r) return isName(r.member) and isPos(r.pos) end,
    undo = function(r) return isName(r.member) end,
    add = function(r) return isName(r.member) and (r.pos == nil or isPos(r.pos)) end,
    remove = function(r) return isName(r.member) end,
    award = function(r) return isName(r.member) and isName(r.item) and (r.to == nil or isName(r.to)) end,
    gift = function(r) return isName(r.member) and isName(r.to) end,
}
M.KINDS = {}
for k in pairs(NEEDS) do M.KINDS[k] = true end

function M.Validate(r)
    if type(r) ~= "table" or not NEEDS[r.kind] then return nil, "badkind" end
    if not isName(r.reason) then return nil, "noreason" end
    if #r.reason > M.MAX_REASON then return nil, "longreason" end
    if not NEEDS[r.kind](r) then return nil, "badrequest" end
    return true
end

-- The request in words (also what a Declined event records as `request`).
function M.Describe(r)
    local who = short(r.member) or "?"
    local where = r.pos == "top" and "the top" or r.pos == "bottom" and "the bottom" or r.pos and ("place " .. r.pos)
    if r.kind == "move" then return ("move %s to %s"):format(who, where)
    elseif r.kind == "undo" then return ("undo %s's last award"):format(who)
    elseif r.kind == "add" then return ("add %s%s"):format(who, where and (" at " .. where) or "")
    elseif r.kind == "remove" then return ("remove %s from the list"):format(who)
    elseif r.kind == "award" then return ("record that %s won %s%s"):format(who, r.item, r.to and (" for " .. short(r.to)) or "")
    elseif r.kind == "gift" then return ("%s's last item went to %s"):format(who, short(r.to)) end
    return r.kind
end

-- The most recent award to `member` that hasn't been undone, as { id, ... }, or nil.
local function lastAward(state, member)
    local best
    for id, a in pairs(state.awards) do
        if a.member == member and not a.reverted and (not best or a.ts > best.ts or (a.ts == best.ts and id > best.id)) then
            best = { id = id, ts = a.ts, item = a.item }
        end
    end
    return best
end

-- The ledger event that carries out request `r`, for the Master Looter whose chain is `chainId`.
-- Returns type, data, or nil + reason.
function M.EventFor(state, r, chainId)
    if not state then return nil, "nolist" end
    local d = { member = r.member, requestedBy = r.by, rid = r.rid, reason = r.reason }
    if r.kind == "move" or r.kind == "add" then
        if r.pos then
            local anchor, why = Standings.Anchor(state, r.pos, r.member)
            if not anchor then return nil, why end
            for k, v in pairs(anchor) do d[k] = v end
        end
        return r.kind == "move" and "MovePlayer" or "AddMember", d
    elseif r.kind == "remove" then
        return "RemoveMember", d
    elseif r.kind == "award" then
        d.item, d.to = r.item, r.to
        return "Award", d
    elseif r.kind == "undo" or r.kind == "gift" then
        local a = lastAward(state, r.member)
        if not a then return nil, "noaward" end
        if r.kind == "gift" then
            return "Transfer", { award = a.id, to = r.to, member = r.member, requestedBy = r.by, rid = r.rid, reason = r.reason }
        end
        local stack = state.undo[chainId]
        local top = stack and stack[#stack]
        if not (top and top.id == a.id) then return nil, "notrevertible" end
        return "Revert", { target = a.id, member = r.member, requestedBy = r.by, rid = r.rid, reason = r.reason }
    end
    return nil, "badkind"
end

---------------------------------------------------------------- the live side
local function newEmitter()
    local handlers = {}
    return {
        on = function(event, fn)
            local list = handlers[event] or {}
            handlers[event] = list
            local entry = { fn = fn, active = true }
            list[#list + 1] = entry
            return function() entry.active = false end
        end,
        emit = function(event, payload)
            local snapshot = {}
            for i, x in ipairs(handlers[event] or {}) do snapshot[i] = x end
            for _, x in ipairs(snapshot) do if x.active then x.fn(payload) end end
        end,
    }
end

-- Events: request {req} (Master Looter: a new one), received {req} (requester: acknowledged), refused {req, why},
-- unanswered {req}, decided {req?, ev, accepted, by} (anyone: an event carrying a request's outcome arrived).
function M.New(sync, engine)
    local client = engine.client
    local em = newEmitter()
    local q = { sync = sync, engine = engine, client = client, on = em.on, sent = {}, counter = 0 }
    engine.db.requests = engine.db.requests or {}

    -- This character's queue as a Master Looter (kept in saved data, so a /reload loses nothing).
    local function queue()
        local me = client:me()
        local mine = engine.db.requests[me]
        if not mine then mine = { num = 0, pending = {} }; engine.db.requests[me] = mine end
        return mine
    end

    -- The Master Looter to send to: `target` if named, else the one running this player's group's raid,
    -- else the only raid running. Returns the name, or nil + reason.
    function q:masterLooterFor(target, t)
        local raids = engine:ActiveRaids(t)
        if #raids == 0 then return nil, "noraid" end
        if target then
            for _, r in ipairs(raids) do if r.ml == target then return r.ml end end
            return nil, "notml"
        end
        local mine = client:masterLooter()
        for _, r in ipairs(raids) do if r.ml == mine then return r.ml end end
        if #raids == 1 then return raids[1].ml end
        return nil, "whichraid"
    end

    ---------------------------------------------------------------- requester
    -- Send a request. r = { kind, member, pos?, item?, to?, reason }; target (optional) = a Master Looter's name.
    -- Returns the request (with rid and ml), or nil + reason.
    function q:send(r, target)
        local ok, why = M.Validate(r)
        if not ok then return nil, why end
        local ml, mlWhy = self:masterLooterFor(target)
        if not ml then return nil, mlWhy end
        if ml == client:me() then return nil, "self" end
        self.counter = self.counter + 1
        r.rid = ("%s:%d:%d"):format(client:me(), client:serverTime(), self.counter)
        r.by, r.ml, r.tries, r.state = client:me(), ml, 0, "sending"
        self.sent[r.rid] = r
        local function try()
            if r.state ~= "sending" then return end
            if r.tries >= M.MAX_TRIES then r.state = "unanswered"; em.emit("unanswered", { req = r }); return end
            r.tries = r.tries + 1
            sync:send({ t = "QR", rid = r.rid, kind = r.kind, member = r.member, pos = r.pos, item = r.item, to = r.to,
                reason = r.reason }, "WHISPER", ml)
            client:after(M.RETRY_SECONDS, try)
        end
        try()
        return r
    end

    sync:register("QK", function(msg, sender)
        local r = type(msg.rid) == "string" and q.sent[msg.rid]
        if not r or sender ~= r.ml or r.state ~= "sending" then return end
        if msg.ok then
            r.state, r.num = "waiting", msg.num
            em.emit("received", { req = r })
        else
            r.state, r.why = "refused", msg.why
            em.emit("refused", { req = r, why = msg.why })
        end
    end)

    -- Outcomes arrive as ledger events (written here or by a peer).
    engine:OnChange(function(kind, _, ev)
        if (kind ~= "local" and kind ~= "remote") or type(ev) ~= "table" or type(ev.data) ~= "table" then return end
        local rid = ev.data.rid
        if not isName(rid) then return end
        local r = q.sent[rid]
        if r then r.state = (ev.type == "Declined") and "declined" or "accepted" end
        em.emit("decided", { req = r, ev = ev, accepted = ev.type ~= "Declined", by = ev.author,
            mine = r ~= nil, why = ev.data.declineReason })
    end)

    ---------------------------------------------------------------- Master Looter
    local function ack(to, extra)
        extra.t = "QK"
        sync:send(extra, "WHISPER", to)
    end

    -- Am I the Master Looter of a raid that is running now?
    local function runningMine()
        for _, r in ipairs(engine:ActiveRaids()) do if r.ml == client:me() then return r end end
    end

    sync:register("QR", function(msg, sender)
        if type(msg.rid) ~= "string" or msg.rid:sub(1, #sender + 1) ~= sender .. ":" then return end
        local mine = queue()
        for _, p in ipairs(mine.pending) do
            if p.rid == msg.rid then return ack(sender, { rid = msg.rid, ok = true, num = p.num }) end -- a repeat
        end
        if not runningMine() then return ack(sender, { rid = msg.rid, ok = false, why = "notml" }) end
        local r = { rid = msg.rid, by = sender, kind = msg.kind, member = msg.member, pos = msg.pos, item = msg.item,
            to = msg.to, reason = msg.reason }
        local ok, why = M.Validate(r)
        if not ok then return ack(sender, { rid = msg.rid, ok = false, why = why }) end
        local n = 0
        for _, p in ipairs(mine.pending) do if p.by == sender then n = n + 1 end end
        if n >= M.MAX_PENDING_PER_PLAYER then return ack(sender, { rid = msg.rid, ok = false, why = "toomany" }) end
        mine.num = mine.num + 1
        r.num, r.at = mine.num, client:serverTime()
        mine.pending[#mine.pending + 1] = r
        ack(sender, { rid = r.rid, ok = true, num = r.num })
        em.emit("request", { req = r })
    end)

    function q:pending() return queue().pending end

    local function take(num)
        local mine = queue()
        for i, p in ipairs(mine.pending) do
            if p.num == num then return p, i, mine end
        end
    end

    -- Accept request `num`: write the change. Returns the event, or nil + reason (the request stays pending).
    function q:accept(num)
        local r, i, mine = take(num)
        if not r then return nil, "norequest" end
        local list = engine:Get(M.LIST)
        local type_, data = M.EventFor(list and list.state, r, engine:MyChain())
        if not type_ then return nil, data end
        local ev, why = engine:Append(M.LIST, type_, data)
        if not ev then return nil, why end
        table.remove(mine.pending, i)
        return ev
    end

    -- Decline request `num`, with a reason (required: it goes in the record). Returns the event, or nil + reason.
    function q:decline(num, reason)
        if not isName(reason) then return nil, "noreason" end
        local r, i, mine = take(num)
        if not r then return nil, "norequest" end
        local ev, why = engine:Write("Declined", { request = M.Describe(r), requestedBy = r.by, declineReason = reason,
            rid = r.rid, kind = r.kind, member = r.member })
        if not ev then return nil, why end
        table.remove(mine.pending, i)
        return ev
    end

    return q
end
