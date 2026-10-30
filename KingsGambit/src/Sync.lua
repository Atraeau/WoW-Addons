-- King's Gambit: ledger sync over addon messages (ledger v2: one chain per writer).
-- Live events are pushed as they are written (guild channel, and raid channel when in a raid). A heartbeat
-- lists every chain a peer has (count and head) so anyone can notice what they are missing and ask for it.
-- Everything is idempotent (events are content-addressed), so duplicates, reordering and lost messages are
-- safe. A chain only forks if its writer wrote from two machines with stale data; that rare case is resolved
-- deterministically (longer branch wins, ties to the lower id) and the losing events are kept for review.
--
-- Messages (serialized tables, split into <=255-byte frames):
--   H  heartbeat  { t="H", l = ledger id or "", g = genesis chain or "", c = { [chain] = { n, h } } }
--   R  request    { t="R", c = chain, from = seq }      -> reply E starting at `from`
--   E  events     { t="E", c = chain, n = sender's count, events = { ... } }
-- Other modules plug in their own message types with Sync:register (two or more letters).
local _, SK = ...
local Hash
local M = SK:NewModule("Sync", { "Hash" }, function(d) Hash = d.Hash end)

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
    retryAfter = 3,          -- re-send a request that made no progress after this long
    maxRetries = 8,
}

local Sync = {}
Sync.__index = Sync

function M.New(engine, opts)
    local cfg = {}
    for k, v in pairs(DEFAULTS) do cfg[k] = v end
    for k, v in pairs(opts or {}) do cfg[k] = v end
    return setmetatable({
        engine = engine, client = engine.client, cfg = cfg,
        outbox = {}, partial = {}, nextMsgId = 1, lastRequest = {}, forkBuf = {}, custom = {}, waiting = {},
        handlers = {}, unsub = {}, timers = {}, blocked = nil, running = false,
        stats = { rejected = 0, droppedFrames = 0, forksResolved = 0, otherLedger = 0 },
    }, Sync)
end

---------------------------------------------------------------- events
-- Events: forkResolved { chain, at, winner = "ours"|"theirs", orphaned }
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
    self.unsub[#self.unsub + 1] = self.engine:OnChange(function(kind, cid, ev) self:onChange(kind, cid, ev) end)
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

function Sync:register(t, fn)
    assert(#t > 1, "plugin message types must be longer than one character")
    self.custom[t] = fn
end

function Sync:send(msg, channel, target) self:post(msg, channel, target) end

---------------------------------------------------------------- sending
-- Serialize, split into frames, queue, and try to send right away.
-- Frame = 4 hex message id + 3-digit part + 3-digit part count + data.
-- The message id is derived from the content, so when the same reply is sent again (a retried request)
-- its frames carry the same id and the receiver combines them with frames kept from earlier attempts:
-- on a lossy link every retry makes progress instead of starting over.
function Sync:post(msg, channel, target)
    local payload = self.client:serialize(msg)
    local id = Hash.Sum(payload):sub(1, 4)
    local room = self.client.maxMessage - 10
    local n = math.max(1, math.ceil(#payload / room))
    if n > 999 then self.stats.droppedFrames = self.stats.droppedFrames + n; return end
    for i = 1, n do
        local frame = ("%s%03d%03d"):format(id, i, n) .. payload:sub((i - 1) * room + 1, i * room)
        self.outbox[#self.outbox + 1] = { channel = channel, target = target, frame = frame }
    end
    self:pump()
end

-- Re-send requests that have made no progress (their reply was probably lost). Because message ids are
-- content-derived, each retry's reply adds to the frames already received.
function Sync:retryRequests()
    local now = self.client:now()
    for cid, w in pairs(self.waiting) do
        local chain = self.engine.store.chains[cid]
        local have = chain and #chain.events or 0
        if have >= w.from then
            self.waiting[cid] = nil
        elseif now - w.at >= self.cfg.retryAfter then
            if w.tries >= self.cfg.maxRetries then
                self.waiting[cid] = nil -- give up; the next heartbeat starts over
            else
                w.tries, w.at = w.tries + 1, now
                self:post({ t = "R", c = cid, from = w.from }, "WHISPER", w.sender)
            end
        end
    end
end

-- Send queued frames, a few at a time. Restricted or throttled sends stay queued and retry.
function Sync:pump()
    self:retryRequests()
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

local function broadcast(self, msg)
    self:post(msg, "GUILD")
    if self.client:inRaid() then self:post(msg, "RAID") end
end

function Sync:heartbeat()
    local store = self.engine.store
    local c = {}
    for cid, chain in pairs(store.chains) do c[cid] = { n = #chain.events, h = chain.head } end
    broadcast(self, { t = "H", l = store.id or "", g = store.genesisChain or "", c = c })
    local now = self.client:now()
    for key, buf in pairs(self.partial) do
        if now - buf.at > self.cfg.partialTimeout then self.partial[key] = nil end
    end
    for cid, fb in pairs(self.forkBuf) do
        if now - fb.at > self.cfg.forkTimeout then self.forkBuf[cid] = nil end
    end
end

-- Push our own new events to everyone at once (guild and raid), so a parallel raid sees them right away.
function Sync:onChange(kind, cid, ev)
    if kind == "local" then
        broadcast(self, { t = "E", c = cid, n = #self.engine.store.chains[cid].events, events = { ev } })
    elseif kind == "replaced" then
        self:heartbeat()
    end
end

function Sync:request(cid, from, sender, force)
    local key = sender .. "|" .. cid .. "|" .. from
    local now = self.client:now()
    if not force and self.lastRequest[key] and now - self.lastRequest[key] < self.cfg.requestCooldown then return end
    self.lastRequest[key] = now
    self.waiting[cid] = { from = from, sender = sender, at = now, tries = 0 }
    self:post({ t = "R", c = cid, from = from }, "WHISPER", sender)
end

function Sync:sendEvents(cid, from, sender)
    local chain = type(cid) == "string" and self.engine.store.chains[cid]
    if not chain or type(from) ~= "number" or from < 1 then return end
    local evs, last = {}, math.min(#chain.events, from + self.cfg.maxBatch - 1)
    for seq = from, last do
        evs[#evs + 1] = chain.events[seq]
        if #evs > 1 and #self.client:serialize(evs) > self.cfg.maxBytes then
            evs[#evs] = nil
            break
        end
    end
    if #evs == 0 then return end
    self:post({ t = "E", c = cid, n = #chain.events, events = evs }, "WHISPER", sender)
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

function Sync:handle(msg, sender)
    local t = msg.t
    if t == "H" then self:onHeartbeat(msg, sender)
    elseif t == "R" then self:sendEvents(msg.c, msg.from, sender)
    elseif t == "E" then self:onEvents(msg, sender)
    elseif self.custom[t] then self.custom[t](msg, sender) end
end

function Sync:onHeartbeat(msg, sender)
    if type(msg.c) ~= "table" then return end
    local store = self.engine.store
    if type(msg.l) == "string" and msg.l ~= "" and store.id and msg.l ~= store.id then
        self.stats.otherLedger = self.stats.otherLedger + 1 -- a different ledger (another guild, training)
        return
    end
    if not store.id then
        if type(msg.g) == "string" and msg.g ~= "" then self:request(msg.g, 1, sender) end -- learn the ledger first
        return
    end
    for cid, peer in pairs(msg.c) do
        if type(cid) == "string" and type(peer) == "table" and type(peer.n) == "number" and type(peer.h) == "string"
            and not self.engine.problems[cid] then
            local chain = store.chains[cid]
            local n = chain and #chain.events or 0
            if peer.n > n then
                self:request(cid, n + 1, sender)
            elseif peer.n > 0 and chain.events[peer.n].id ~= peer.h then
                self:request(cid, 1, sender) -- the same chain with two histories: fetch theirs to compare
            end
        end
    end
end

function Sync:onEvents(msg, sender)
    local cid, evs = msg.c, msg.events
    if type(cid) ~= "string" or type(evs) ~= "table" then return end
    local fb = self.forkBuf[cid]
    if fb and fb.sender == sender then return self:forkAppend(cid, evs, msg.n) end

    for idx, ev in ipairs(evs) do
        local status, err = self.engine:Receive(ev)
        if not status then
            if err == "gap" then
                local chain = self.engine.store.chains[cid]
                self:request(cid, (chain and #chain.events or 0) + 1, sender)
            elseif err == "fork" then
                self:beginFork(cid, evs, idx, msg.n, sender)
            elseif err ~= "noledger" then -- noledger: the heartbeat names the genesis chain to fetch first
                self.stats.rejected = self.stats.rejected + 1
                self.client:log("warn", ("sync rejected an event on '%s': %s"):format(cid, tostring(err)))
            end
            return
        end
    end
    local last = evs[#evs]
    if type(msg.n) == "number" and type(last) == "table" and type(last.seq) == "number" and last.seq < msg.n then
        self:request(cid, last.seq + 1, sender, true)
    end
end

---------------------------------------------------------------- the rare chain fork
function Sync:beginFork(cid, evs, idx, total, sender)
    local chain = self.engine.store.chains[cid]
    local first = evs[idx]
    if not chain or type(first) ~= "table" or type(first.seq) ~= "number" then return end
    local k = first.seq
    local prevId = (k == 1) and "0000000000000000" or (chain.events[k - 1] and chain.events[k - 1].id)
    if k > #chain.events + 1 or first.prev ~= prevId then
        return self:request(cid, 1, sender, true) -- split earlier than this batch shows: start from the top
    end
    local seg = {}
    for i = idx, #evs do
        local ev = evs[i]
        if ev.seq ~= k + #seg or (#seg > 0 and ev.prev ~= seg[#seg].id) then break end
        seg[#seg + 1] = ev
    end
    self.forkBuf[cid] = { sender = sender, k = k, events = seg, total = total or seg[#seg].seq, at = self.client:now() }
    self:forkProgress(cid)
end

function Sync:forkAppend(cid, evs, total)
    local fb = self.forkBuf[cid]
    if type(total) == "number" then fb.total = total end
    for _, ev in ipairs(evs) do
        local last = fb.events[#fb.events]
        if ev.seq == last.seq + 1 and ev.prev == last.id then
            fb.events[#fb.events + 1] = ev
        elseif ev.seq > last.seq + 1 or (ev.seq == last.seq + 1 and ev.prev ~= last.id) then
            self.forkBuf[cid] = nil
            return self:request(cid, 1, fb.sender, true)
        end
    end
    self:forkProgress(cid)
end

function Sync:forkProgress(cid)
    local fb = self.forkBuf[cid]
    local last = fb.events[#fb.events].seq
    if last < fb.total then return self:request(cid, last + 1, fb.sender, true) end
    self:decideFork(cid)
end

function Sync:decideFork(cid)
    local fb = self.forkBuf[cid]
    self.forkBuf[cid] = nil
    local chain = self.engine.store.chains[cid]
    if not chain then return end
    local n, k = #chain.events, fb.k
    local mine, theirs = chain.events[k], fb.events[1]
    local theirsWins
    if fb.total ~= n then theirsWins = fb.total > n
    elseif mine then theirsWins = theirs.id < mine.id
    else theirsWins = true end
    if not theirsWins then
        self:emit("forkResolved", { chain = cid, at = k, winner = "ours", orphaned = 0 })
        return
    end
    local orphaned = n - k + 1
    local ok, err = self.engine:ReplaceChainSuffix(cid, k, fb.events)
    if not ok then
        self.stats.rejected = self.stats.rejected + 1
        self.client:log("warn", ("sync refused a fork on '%s': %s"):format(cid, tostring(err)))
        return
    end
    self.stats.forksResolved = self.stats.forksResolved + 1
    self:emit("forkResolved", { chain = cid, at = k, winner = "theirs", orphaned = orphaned })
end
