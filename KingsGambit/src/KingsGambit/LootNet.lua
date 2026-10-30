-- King's Gambit: the live loot session protocol (Phase 4).
-- The Master Looter's addon runs the Loot session (see Loot.lua). Everyone else's addon talks to it
-- over addon messages carried by Sync: it announces the items, takes bids and draft actions, tells
-- everyone whose turn it is, and publishes the answers (public by design) and the results.
--
-- Host (Master Looter) <-> Players, message types (all `t` values are two letters):
--   LS  session start   host -> RAID     { sid, items = { {id, link} }, bid, left, who = { names } }
--   LB  bid             player -> host   { sid, item, kind, to?, passKind?, rank?, ready? }
--   LK  acknowledgement host -> player   { sid, ok, why?, item?, action? }
--   LP  phase           host -> RAID     { sid, phase }
--   LT  turn            host -> RAID     { sid, turn = { type, player, options?, item?, tier? }, left }
--   LX  action          player -> host   { sid, action = pick|skip|claim|decline, item?, to? }
--   LY  public answers  host -> RAID     { sid, a = { { player, item, kind, to?, ready? } } }  (batched)
--   LR  results         host -> RAID     { sid, awards = { {item, winner, to, tier} }, de = { {item, to} }, failed }
--
-- While a session runs the host repeats its state every few seconds (LS, LP, LT and all LY answers), so
-- a player who joined late, reloaded, or missed the start catches up; repeats change nothing for
-- players who already have the session.
--
-- Only the Master Looter's messages are believed (players check the sender against the client's
-- masterLooter()); the host only accepts bids and actions through the Loot session's own rules.
local _, SK = ...
local Loot
local M = SK:NewModule("LootNet", { "Loot" }, function(d) Loot = d.Loot end)

local function newEmitter()
    local handlers = {}
    local e = {}
    function e.on(event, fn)
        local list = handlers[event]
        if not list then list = {}; handlers[event] = list end
        local entry = { fn = fn, active = true }
        list[#list + 1] = entry
        return function() entry.active = false end
    end
    function e.emit(event, payload)
        local snapshot = {}
        for i, x in ipairs(handlers[event] or {}) do snapshot[i] = x end
        for _, x in ipairs(snapshot) do
            if x.active then x.fn(payload) end
        end
    end
    return e
end

local function remaining(client, deadline)
    if not deadline then return nil end
    return math.max(0, deadline - client:now())
end

---------------------------------------------------------------- host side
-- sync: the host's Sync; engine: the host's Engine.
function M.NewHost(sync, engine)
    local client = engine.client
    local h = { sync = sync, engine = engine, client = client, session = nil, sid = nil, counter = 0,
        answers = {}, flushing = false, ev = newEmitter(), beaconSeconds = 10 }
    h.on = h.ev.on

    local function send(msg, channel, target) sync:send(msg, channel or "RAID", target) end

    local function ack(sender, extra)
        extra.t, extra.sid = "LK", h.sid
        send(extra, "WHISPER", sender)
    end

    local function flush()
        h.flushing = false
        if #h.answers == 0 or not h.sid then return end
        local batch = h.answers
        h.answers = {}
        send({ t = "LY", sid = h.sid, a = batch })
    end

    local function results(session)
        local out = { t = "LR", sid = h.sid, awards = {}, de = {}, failed = 0 }
        for _, a in ipairs(session.pending) do
            if a.type == "award" then
                out.awards[#out.awards + 1] = { item = a.item.id, winner = a.member, to = a.to, tier = a.tier }
            elseif a.type == "disenchant" then
                out.de[#out.de + 1] = { item = a.item.id, to = a.to }
            end
        end
        return out
    end

    local function running()
        local s = h.session
        return s and s.phase ~= "done" and s.phase ~= "cancelled"
    end

    local function stateBeacon()
        if not running() then
            if h.beaconTimer then client:cancel(h.beaconTimer); h.beaconTimer = nil end
            return
        end
        local s = h.session
        local list, who = {}, {}
        for i, it in ipairs(s.items) do list[i] = { id = it.id, link = it.link } end
        for _, name in ipairs(s.eligibleList) do who[#who + 1] = name end
        send({ t = "LS", sid = h.sid, items = list, bid = s.cfg.bidSeconds, left = remaining(client, s.deadline), who = who })
        send({ t = "LP", sid = h.sid, phase = s.phase })
        if s.turn then
            send({ t = "LT", sid = h.sid, left = remaining(client, s.deadline),
                turn = { type = s.turn.type, player = s.turn.player, options = s.turn.options, item = s.turn.item, tier = s.turn.tier } })
        end
        local all = {}
        for player, row in pairs(s.bids) do
            for item, b in pairs(row) do all[#all + 1] = { player = player, item = item, kind = b.kind, to = b.to, ready = b.ready } end
        end
        table.sort(all, function(a, b) if a.player ~= b.player then return a.player < b.player end return a.item < b.item end)
        if #all > 0 then send({ t = "LY", sid = h.sid, a = all }) end
    end

    function h:start(items, cfg)
        local old = self.session
        if old and old.phase ~= "done" and old.phase ~= "cancelled" then return false, "busy" end
        local session = Loot.NewSession(self.engine, cfg)
        local ok, why = session:start(items)
        if not ok then return false, why end
        self.counter = self.counter + 1
        self.session = session
        self.sid = ("%s#%d#%d"):format(client:me(), client:serverTime(), self.counter)
        self.answers = {}

        session:on("phase", function(p)
            send({ t = "LP", sid = h.sid, phase = p.phase })
            h.ev.emit("phase", p)
        end)
        session:on("turn", function(turn)
            send({ t = "LT", sid = h.sid, left = remaining(client, session.deadline),
                turn = { type = turn.type, player = turn.player, options = turn.options, item = turn.item, tier = turn.tier } })
            h.ev.emit("turn", turn)
        end)
        session:on("bid", function(b)
            local bid = session.bids[b.player][b.item]
            h.answers[#h.answers + 1] = { player = b.player, item = b.item, kind = b.kind, to = bid.to, ready = bid.ready }
            if not h.flushing then
                h.flushing = true
                client:after(1, flush)
            end
            h.ev.emit("bid", b)
        end)
        session:on("done", function(d)
            flush()
            local r = results(session)
            r.failed = #d.failures
            send(r)
            h.ev.emit("done", d)
        end)

        local list, who = {}, {}
        for i, it in ipairs(session.items) do list[i] = { id = it.id, link = it.link } end
        for _, name in ipairs(session.eligibleList) do who[#who + 1] = name end
        send({ t = "LS", sid = self.sid, items = list, bid = session.cfg.bidSeconds, left = remaining(client, session.deadline), who = who })
        if self.beaconTimer then client:cancel(self.beaconTimer) end
        self.beaconTimer = client:every(h.beaconSeconds, stateBeacon)
        return true
    end

    sync:register("LB", function(msg, sender)
        if not (h.session and msg.sid == h.sid) then return ack(sender, { ok = false, why = "nosession", item = msg.item }) end
        local ok, why = h.session:bid(sender, msg.item, msg.kind,
            { to = msg.to, passKind = msg.passKind, rank = msg.rank, ready = msg.ready })
        ack(sender, { ok = ok and true or false, why = why, item = msg.item })
    end)

    sync:register("LX", function(msg, sender)
        local s = h.session
        if not (s and msg.sid == h.sid) then return ack(sender, { ok = false, why = "nosession", action = msg.action }) end
        local ok, why
        if msg.action == "pick" then ok, why = s:pick(sender, msg.item)
        elseif msg.action == "skip" then ok, why = s:skip(sender)
        elseif msg.action == "claim" then ok, why = s:claimItem(sender, msg.to and { to = msg.to } or nil)
        elseif msg.action == "decline" then ok, why = s:decline(sender)
        else ok, why = false, "badaction" end
        ack(sender, { ok = ok and true or false, why = why, action = msg.action })
    end)

    -- Players without the addon answer by whisper.
    h.unsubWhisper = client:on("whisper.received", function(p)
        if h.session and h.session.phase == "bidding" then h.session:handleWhisper(p.sender, p.text) end
    end)

    return h
end

---------------------------------------------------------------- player side
-- Events: session {session}, phase {phase}, turn {turn}, answers {}, result {results}, ack {ok, why, ...}
function M.NewPlayer(sync)
    local client = sync.client
    local p = { sync = sync, client = client, session = nil, ev = newEmitter() }
    p.on = p.ev.on

    local function fromHost(msg, sender)
        local s = p.session
        return s and msg.sid == s.sid and sender == s.host
    end

    sync:register("LS", function(msg, sender)
        local ml = client:masterLooter()
        if not ml or sender ~= ml then return end -- only the Master Looter can open a session
        if type(msg.sid) ~= "string" or type(msg.items) ~= "table" then return end
        if p.session and p.session.sid == msg.sid then return end -- a repeat of the announcement
        p.session = { sid = msg.sid, host = sender, items = msg.items, phase = "bidding", turn = nil, results = nil,
            answers = {}, mine = {}, who = msg.who or {}, deadline = msg.left and (client:now() + msg.left) or nil }
        p.ev.emit("session", p.session)
    end)

    sync:register("LP", function(msg, sender)
        if not fromHost(msg, sender) then return end
        p.session.phase = msg.phase
        if msg.phase ~= "main" and msg.phase ~= "off" and msg.phase ~= "backstop" then p.session.turn = nil end
        p.ev.emit("phase", msg.phase)
    end)

    sync:register("LT", function(msg, sender)
        if not fromHost(msg, sender) or type(msg.turn) ~= "table" then return end
        p.session.turn = msg.turn
        p.session.turn.deadline = msg.left and (client:now() + msg.left) or nil
        p.ev.emit("turn", p.session.turn)
    end)

    sync:register("LY", function(msg, sender)
        if not fromHost(msg, sender) or type(msg.a) ~= "table" then return end
        for _, a in ipairs(msg.a) do
            local row = p.session.answers[a.player]
            if not row then row = {}; p.session.answers[a.player] = row end
            row[a.item] = { kind = a.kind, to = a.to, ready = a.ready }
        end
        p.ev.emit("answers")
    end)

    sync:register("LR", function(msg, sender)
        if not fromHost(msg, sender) then return end
        p.session.results = { awards = msg.awards or {}, de = msg.de or {}, failed = msg.failed or 0 }
        p.session.phase, p.session.turn = "done", nil
        p.ev.emit("result", p.session.results)
    end)

    sync:register("LK", function(msg, sender)
        if not fromHost(msg, sender) then return end
        if msg.item and msg.ok and p.session.pendingBid and p.session.pendingBid[msg.item] then
            p.session.mine[msg.item] = p.session.pendingBid[msg.item]
        end
        p.ev.emit("ack", { ok = msg.ok, why = msg.why, item = msg.item, action = msg.action })
    end)

    local function toHost(msg)
        local s = p.session
        if not s then return false, "nosession" end
        msg.sid = s.sid
        sync:send(msg, "WHISPER", s.host)
        return true
    end

    -- kind: need | off | gift | pass. For a gift, `to` is the recipient. extra (optional): { rank, ready }
    -- (see Loot's Session:bid). For a token, `ready` is this player's readiness (Tokens.Mine).
    function p:bid(item, kind, to, passKind, extra)
        local s = self.session
        if not s then return false, "nosession" end
        extra = extra or {}
        s.pendingBid = s.pendingBid or {}
        s.pendingBid[item] = { kind = kind, to = to, ready = extra.ready }
        return toHost({ t = "LB", item = item, kind = kind, to = to, passKind = passKind, rank = extra.rank, ready = extra.ready })
    end
    function p:pick(item) return toHost({ t = "LX", action = "pick", item = item }) end
    function p:skip() return toHost({ t = "LX", action = "skip" }) end
    function p:claim(to) return toHost({ t = "LX", action = "claim", to = to }) end
    function p:decline() return toHost({ t = "LX", action = "decline" }) end

    -- Is it this player's turn, and for what?
    function p:myTurn()
        local t = self.session and self.session.turn
        if t and t.player == client:me() then return t end
    end

    return p
end
