-- King's Gambit: guild-wide ledger sync (Phase 3).
-- Gossip over addon messages: live events are pushed as they are written, a small heartbeat
-- (list sizes and head hashes) lets anyone notice they are behind or diverged, and range
-- requests fetch what is missing. Everything is idempotent (events are content-addressed by
-- their hash), so duplicates, reordering and lost messages are all safe.
--
-- Messages (serialized tables, split into <=255-byte frames):
--   H  heartbeat   { t="H", lists = { [id] = { n = count, h = headId } } }
--   R  request     { t="R", list, from }                 -> reply E starting at seq `from`
--   D  probe       { t="D", list, cp = { {seq,id}... } } -> reply E from the last shared checkpoint
--   E  events      { t="E", list, n = sender's total, events = { ... } }
--
-- Forks (two histories that diverge) are resolved by one deterministic rule everyone applies
-- the same way: the LONGER chain wins; on a tie the earlier fork event wins, then the lower
-- id. The loser's events are kept in db.orphans for an officer to review and re-enter.
-- Phase 3 trusts any well-formed chain (the trusted-officer model); who may WRITE is enforced
-- where events are authored.
local _, SK = ...
local M = SK:NewModule("Sync")
local Ledger = SK.modules.Ledger

M.PREFIX = "KGAMBIT"

local DEFAULTS = {
    heartbeat = 30,          -- seconds between heartbeats
    firstHeartbeat = 1,      -- first heartbeat after start (plus jitter)
    firstJitter = 2,
    maxBatch = 20,           -- events per E message (at most)
    maxBytes = 1200,         -- serialized size cap per E message (~5 frames), so one lost frame costs little
    burst = 6,               -- frames sent per pump
    pumpEvery = 0.25,
    requestCooldown = 8,     -- do not repeat the same request sooner than this
    partialTimeout = 30,     -- drop half-received messages after this long
    forkTimeout = 60,
}

local Sync = {}
Sync.__index = Sync

function M.New(engine, opts)
    local cfg = {}
    for k, v in pairs(DEFAULTS) do cfg[k] = v end
    for k, v in pairs(opts or {}) do cfg[k] = v end
    return setmetatable({
        engine = engine, client = engine.client, cfg = cfg,
        outbox = {}, partial = {}, nextMsgId = 1, lastRequest = {}, forkBuf = {}, custom = {},
        handlers = {}, unsub = {}, timers = {}, blocked = nil, running = false,
        stats = { rejected = 0, droppedFrames = 0, forksResolved = 0 },
    }, Sync)
end

---------------------------------------------------------------- events
-- Events: forkResolved { list, at, winner = "ours"|"theirs", orphaned }
function Sync:on(event, fn)
    local list = self.handlers[event]
    if not list then list = {}; self.handlers[event] = list end
    local entry = { fn = fn, active = true }
    list[#list + 1] = entry
    return function() entry.active = false end
end

function Sync:emit(event, payload)
    local snapshot = {}
    for i, e in ipairs(self.handlers[event] or {}) do snapshot[i] = e end
    for _, e in ipairs(snapshot) do
        if e.active then e.fn(payload) end
    end
end

---------------------------------------------------------------- lifecycle
function Sync:start()
    if self.running then return end
    self.running = true
    local c, cfg = self.client, self.cfg
    c:registerPrefix(M.PREFIX)
    self.unsub[#self.unsub + 1] = c:on("comms.received", function(p) self:onComms(p) end)
    self.unsub[#self.unsub + 1] = c:on("comms.restrictionChanged", function(p)
        if not p.restricted then self.blocked = nil; self:pump() end
    end)
    self.unsub[#self.unsub + 1] = self.engine:OnChange(function(kind, listId, ev) self:onChange(kind, listId, ev) end)
    self.timers[#self.timers + 1] = c:every(cfg.pumpEvery, function() self:pump() end)
    self.timers[#self.timers + 1] = c:every(cfg.heartbeat, function() self:heartbeat() end)
    self.timers[#self.timers + 1] = c:after(cfg.firstHeartbeat + c:random() * cfg.firstJitter, function() self:heartbeat() end)
end

function Sync:stop()
    self.running = false
    for _, off in ipairs(self.unsub) do off() end
    for _, t in ipairs(self.timers) do self.client:cancel(t) end
    self.unsub, self.timers = {}, {}
end

function Sync:status()
    return { pending = #self.outbox, blocked = self.blocked, rejected = self.stats.rejected,
        forksResolved = self.stats.forksResolved, resolvingForks = next(self.forkBuf) ~= nil }
end

---------------------------------------------------------------- sending
-- Serialize, split into frames, queue, and try to send right away.
-- Frame = 4 hex message id + 3-digit part + 3-digit part count + data.
function Sync:post(msg, channel, target)
    local payload = self.client:serialize(msg)
    local id = ("%04x"):format(self.nextMsgId % 65536)
    self.nextMsgId = self.nextMsgId + 1
    local room = self.client.maxMessage - 10
    local n = math.max(1, math.ceil(#payload / room))
    if n > 999 then self.stats.droppedFrames = self.stats.droppedFrames + n; return end
    for i = 1, n do
        local frame = ("%s%03d%03d"):format(id, i, n) .. payload:sub((i - 1) * room + 1, i * room)
        self.outbox[#self.outbox + 1] = { channel = channel, target = target, frame = frame }
    end
    self:pump()
end

-- Send queued frames, a few at a time. Restricted or throttled sends stay queued and retry.
function Sync:pump()
    local sent = 0
    while #self.outbox > 0 and sent < self.cfg.burst do
        local m = self.outbox[1]
        local ok, why = self.client:send(M.PREFIX, m.frame, m.channel, m.target)
        if ok then
            table.remove(self.outbox, 1)
            sent = sent + 1
            self.blocked = nil
        elseif why == "restricted" or (why and tostring(why):find("throttle")) then
            self.blocked = why
            return
        else
            table.remove(self.outbox, 1)
            self.stats.droppedFrames = self.stats.droppedFrames + 1
            self.client:log("warn", "sync dropped a frame: " .. tostring(why))
        end
    end
end

local function liveChannels(self)
    return { self.client:inRaid() and "RAID" or "GUILD" }
end

function Sync:heartbeat()
    local lists = {}
    for id, chain in pairs(self.engine.chains) do
        lists[id] = { n = #chain.events, h = chain.head }
    end
    self:post({ t = "H", lists = lists }, "GUILD")
    if self.client:inRaid() then self:post({ t = "H", lists = lists }, "RAID") end
    -- housekeeping
    local now = self.client:now()
    for key, buf in pairs(self.partial) do
        if now - buf.at > self.cfg.partialTimeout then self.partial[key] = nil end
    end
    for id, fb in pairs(self.forkBuf) do
        if now - fb.at > self.cfg.forkTimeout then self.forkBuf[id] = nil end
    end
end

-- Push our own new events to everyone; after a fork swap, tell the group our new head.
function Sync:onChange(kind, listId, ev)
    if kind == "local" then
        local chain = self.engine:Get(listId)
        for _, ch in ipairs(liveChannels(self)) do
            self:post({ t = "E", list = listId, n = #chain.events, events = { ev } }, ch)
        end
    elseif kind == "replaced" then
        self:heartbeat()
    end
end

function Sync:request(listId, from, sender, force)
    local key = sender .. "|" .. listId .. "|" .. from
    local now = self.client:now()
    if not force and self.lastRequest[key] and now - self.lastRequest[key] < self.cfg.requestCooldown then return end
    self.lastRequest[key] = now
    self:post({ t = "R", list = listId, from = from }, "WHISPER", sender)
end

-- Checkpoints to find where two histories split: positions 1, 2, 4, 8, ... from the start and
-- n, n-1, n-2, n-4, ... from the tip (forks are usually recent). Matching is prefix-closed, so
-- the responder just takes the highest checkpoint that matches.
local function skeleton(chain)
    local n, seen, seqs = #chain.events, {}, {}
    local function add(s)
        if s >= 1 and s <= n and not seen[s] then seen[s] = true; seqs[#seqs + 1] = s end
    end
    local s = 1
    while s <= n do add(s); s = s * 2 end
    add(n)
    s = 1
    while s < n do add(n - s); s = s * 2 end
    table.sort(seqs)
    local cp = {}
    for i, q in ipairs(seqs) do cp[i] = { q, chain.events[q].id } end
    return cp
end

function Sync:probe(listId, sender)
    local chain = self.engine:Get(listId)
    if not chain then return end
    local key = sender .. "|" .. listId .. "|probe"
    local now = self.client:now()
    if self.lastRequest[key] and now - self.lastRequest[key] < self.cfg.requestCooldown then return end
    self.lastRequest[key] = now
    self:post({ t = "D", list = listId, cp = skeleton(chain) }, "WHISPER", sender)
end

function Sync:sendEvents(listId, from, sender)
    local chain = self.engine:Get(listId)
    if not chain or type(from) ~= "number" or from < 1 then return end
    local evs, last = {}, math.min(#chain.events, from + self.cfg.maxBatch - 1)
    for seq = from, last do
        evs[#evs + 1] = chain.events[seq]
        if #evs > 1 and #self.client:serialize(evs) > self.cfg.maxBytes then
            evs[#evs] = nil -- always send at least one event; stop before the message gets too big
            break
        end
    end
    if #evs == 0 then return end
    self:post({ t = "E", list = listId, n = #chain.events, events = evs }, "WHISPER", sender)
end

---------------------------------------------------------------- receiving
function Sync:onComms(p)
    if p.prefix ~= M.PREFIX or p.sender == self.client:me() then return end
    local f = p.payload
    if type(f) ~= "string" or #f < 10 then return end
    local id, i, n = f:sub(1, 4), tonumber(f:sub(5, 7)), tonumber(f:sub(8, 10))
    if not (i and n and i >= 1 and i <= n) then return end
    local key = p.sender .. id
    local buf = self.partial[key]
    if not buf or buf.n ~= n then
        buf = { n = n, got = 0, parts = {}, at = self.client:now() }
        self.partial[key] = buf
    end
    if not buf.parts[i] then buf.parts[i] = f:sub(11); buf.got = buf.got + 1 end
    if buf.got < n then return end
    self.partial[key] = nil
    local msg = self.client:deserialize(table.concat(buf.parts))
    if type(msg) ~= "table" then return end
    local ok, err = pcall(self.handle, self, msg, p.sender)
    if not ok then self.client:log("error", "sync handler: " .. tostring(err)) end
end

-- Other modules (the loot session protocol) plug their own message types in here: fn(msg, sender).
-- Built-in types are the single letters H, R, D and E; plugins should use longer names.
function Sync:register(t, fn)
    assert(#t > 1, "plugin message types must be longer than one character")
    self.custom[t] = fn
end

-- Send a message through the same chunking and queue as the ledger traffic.
function Sync:send(msg, channel, target) self:post(msg, channel, target) end

function Sync:handle(msg, sender)
    local t = msg.t
    if t == "H" then self:onHeartbeat(msg, sender)
    elseif t == "R" then self:sendEvents(msg.list, msg.from, sender)
    elseif t == "D" then self:onProbe(msg, sender)
    elseif t == "E" then self:onEvents(msg, sender)
    elseif self.custom[t] then self.custom[t](msg, sender) end
end

function Sync:onHeartbeat(msg, sender)
    if type(msg.lists) ~= "table" then return end
    for listId, peer in pairs(msg.lists) do
        if type(listId) == "string" and type(peer) == "table" and type(peer.n) == "number" and type(peer.h) == "string"
            and not self.engine.problems[listId] then
            local chain = self.engine:Get(listId)
            local n = chain and #chain.events or 0
            if peer.n > n then
                self:request(listId, n + 1, sender)
            elseif peer.n > 0 and chain.events[peer.n].id ~= peer.h then
                self:probe(listId, sender) -- same or longer than theirs, but a different history
            end
        end
    end
end

function Sync:onProbe(msg, sender)
    local chain = self.engine:Get(msg.list)
    if not chain or type(msg.cp) ~= "table" then return end
    local shared = 0
    for _, pair in ipairs(msg.cp) do
        local seq, id = pair[1], pair[2]
        local mine = type(seq) == "number" and chain.events[seq]
        if mine and mine.id == id and seq > shared then shared = seq end
    end
    self:sendEvents(msg.list, shared + 1, sender)
end

function Sync:onEvents(msg, sender)
    local listId, evs = msg.list, msg.events
    if type(listId) ~= "string" or type(evs) ~= "table" then return end
    local fb = self.forkBuf[listId]
    if fb and fb.sender == sender then return self:forkAppend(listId, evs, msg.n) end

    for idx, ev in ipairs(evs) do
        local status, err = self.engine:Receive(listId, ev)
        if not status then
            if err == "gap" or err == "unknownlist" then
                local chain = self.engine:Get(listId)
                self:request(listId, (chain and #chain.events or 0) + 1, sender)
            elseif err == "fork" then
                self:beginFork(listId, evs, idx, msg.n, sender)
            else
                self.stats.rejected = self.stats.rejected + 1
                self.client:log("warn", ("sync rejected an event on '%s': %s"):format(listId, tostring(err)))
            end
            return
        end
    end
    -- Keep walking forward from the last event we were sent (not from our own tip: after a
    -- probe the batch may be all events we already have, and we must reach the split point).
    local last = evs[#evs]
    if type(msg.n) == "number" and type(last) == "table" and type(last.seq) == "number" and last.seq < msg.n then
        self:request(listId, last.seq + 1, sender, true)
    end
end

---------------------------------------------------------------- forks
function Sync:beginFork(listId, evs, idx, total, sender)
    local chain = self.engine:Get(listId)
    local first = evs[idx]
    local k, n = first.seq, #chain.events
    local prevId = (k == 1) and Ledger.GENESIS or (chain.events[k - 1] and chain.events[k - 1].id)
    if k > n + 1 or first.prev ~= prevId then
        return self:probe(listId, sender) -- the histories split earlier than this batch shows
    end
    local seg = {}
    for i = idx, #evs do
        local ev = evs[i]
        if ev.seq ~= k + #seg or (#seg > 0 and ev.prev ~= seg[#seg].id) then break end
        seg[#seg + 1] = ev
    end
    self.forkBuf[listId] = { sender = sender, k = k, events = seg, total = total or seg[#seg].seq, at = self.client:now() }
    self:forkProgress(listId)
end

function Sync:forkAppend(listId, evs, total)
    local fb = self.forkBuf[listId]
    if type(total) == "number" then fb.total = total end
    for _, ev in ipairs(evs) do
        local last = fb.events[#fb.events]
        if ev.seq == last.seq + 1 and ev.prev == last.id then
            fb.events[#fb.events + 1] = ev
        elseif ev.seq > last.seq + 1 or (ev.seq == last.seq + 1 and ev.prev ~= last.id) then
            self.forkBuf[listId] = nil -- their branch changed under us; start over from a probe
            return self:probe(listId, fb.sender)
        end
    end
    self:forkProgress(listId)
end

function Sync:forkProgress(listId)
    local fb = self.forkBuf[listId]
    local last = fb.events[#fb.events].seq
    if last < fb.total then
        return self:request(listId, last + 1, fb.sender, true)
    end
    self:decideFork(listId)
end

function Sync:decideFork(listId)
    local fb = self.forkBuf[listId]
    self.forkBuf[listId] = nil
    local chain = self.engine:Get(listId)
    local n, k = #chain.events, fb.k
    local mine, theirs = chain.events[k], fb.events[1]
    local theirsWins
    if fb.total ~= n then
        theirsWins = fb.total > n
    elseif mine then
        theirsWins = theirs.ts < mine.ts or (theirs.ts == mine.ts and theirs.id < mine.id)
    else
        theirsWins = true
    end
    if not theirsWins then
        self:emit("forkResolved", { list = listId, at = k, winner = "ours", orphaned = 0 })
        return
    end
    local merged = {}
    for seq = 1, k - 1 do merged[seq] = chain.events[seq] end
    for _, ev in ipairs(fb.events) do merged[#merged + 1] = ev end
    local newChain, err = Ledger.Load(listId, merged)
    if not newChain then
        self.stats.rejected = self.stats.rejected + 1
        self.client:log("warn", ("sync refused a fork on '%s': %s"):format(listId, tostring(err)))
        return
    end
    local orphans = {}
    for seq = k, n do orphans[#orphans + 1] = chain.events[seq] end
    self.engine:ReplaceChain(listId, newChain, orphans)
    self.stats.forksResolved = self.stats.forksResolved + 1
    self:emit("forkResolved", { list = listId, at = k, winner = "theirs", orphaned = #orphans })
end
