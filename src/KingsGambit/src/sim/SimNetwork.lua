-- King's Gambit: SimNetwork, a simulated addon-message network joining several MockClients
-- (Phase 3). One shared clock drives every attached client, so multi-player runs are
-- deterministic. It can add latency and jitter, drop and duplicate messages, and partition
-- the group. Used by the sync tests now and by training sessions later.
-- Keep this file Lua 5.1-safe (no `//`, no bitwise operators).
local _, SK = ...
local M = SK:NewModule("SimNetwork")

local PM_MOD = 2147483647

-- opts: seed, latency (seconds, default 0.1), jitter (extra random seconds, default 0),
--       dropRate, duplicateRate (0..1, default 0).
function M.New(opts)
    opts = opts or {}
    local seed = ((opts.seed or 1) % PM_MOD) + 0.0
    if seed == 0 then seed = 1 end
    local function rnd()
        seed = (seed * 16807) % PM_MOD
        return seed / PM_MOD
    end

    local net = {
        time = 0, quantum = opts.quantum or 0.05, latency = opts.latency or 0.1, jitter = opts.jitter or 0,
        dropRate = opts.dropRate or 0, duplicateRate = opts.duplicateRate or 0,
        nodes = {}, order = {}, queue = {}, nextSeq = 1, groups = nil,
        stats = { sent = 0, delivered = 0, dropped = 0, duplicated = 0, blocked = 0 },
    }

    -- name must equal the client's me(). o: { guild = true, raid = true } channel membership.
    -- Attaching a name again (a player who reloaded) replaces its node; it is still stepped once per tick.
    function net:attach(client, o)
        o = o or {}
        local name = client:me()
        local node = { name = name, client = client, guild = o.guild ~= false, raid = o.raid ~= false,
            offset = client:now() - self.time }
        if not self.nodes[name] then self.order[#self.order + 1] = name end
        self.nodes[name] = node
        client.onSend = function(_, msg) self:route(node, msg) end
        return node
    end

    -- groups: array of arrays of names. Nodes can only talk within their own group.
    function net:partition(groups)
        self.groups = {}
        for gi, g in ipairs(groups) do
            for _, name in ipairs(g) do self.groups[name] = gi end
        end
    end

    function net:heal() self.groups = nil end

    function net:reachable(a, b)
        if not self.groups then return true end
        return self.groups[a] ~= nil and self.groups[a] == self.groups[b]
    end

    function net:enqueue(to, msg, due)
        self.queue[#self.queue + 1] = { due = due, seq = self.nextSeq, to = to, msg = msg }
        self.nextSeq = self.nextSeq + 1
    end

    function net:route(from, msg)
        if msg.kind ~= "addon" then return end
        for _, name in ipairs(self.order) do
            local node = self.nodes[name]
            local wanted
            if node == from then wanted = false
            elseif msg.channel == "WHISPER" then wanted = (node.name == msg.target)
            elseif msg.channel == "GUILD" then wanted = node.guild
            else wanted = node.raid end -- RAID and PARTY
            if wanted then
                self.stats.sent = self.stats.sent + 1
                if rnd() < self.dropRate then
                    self.stats.dropped = self.stats.dropped + 1
                else
                    -- stamped with the sender's own clock, so a timer firing mid-step is exact
                    local sentAt = from.client:now() - from.offset
                    local due = sentAt + self.latency + rnd() * self.jitter
                    self:enqueue(node, msg, due)
                    if rnd() < self.duplicateRate then
                        self.stats.duplicated = self.stats.duplicated + 1
                        self:enqueue(node, msg, due + 0.05 + rnd() * self.latency)
                    end
                end
            end
        end
    end

    local function stepClients(self, dt)
        if dt <= 0 then return end
        for _, name in ipairs(self.order) do self.nodes[name].client:advance(dt) end
    end

    local function earliest(self)
        local best, bi
        for i, item in ipairs(self.queue) do
            if not best or item.due < best.due or (item.due == best.due and item.seq < best.seq) then best, bi = item, i end
        end
        return best, bi
    end

    -- Move the shared clock forward in small steps, advancing every client and delivering
    -- messages as they come due.
    function net:advance(sec)
        local target = self.time + sec
        while true do
            local best, bi = earliest(self)
            if best and best.due <= self.time then
                table.remove(self.queue, bi)
                if self:reachable(best.msg.from, best.to.name) then
                    self.stats.delivered = self.stats.delivered + 1
                    best.to.client:receive(best.msg.prefix, best.msg.payload, best.msg.channel, best.msg.from)
                else
                    self.stats.blocked = self.stats.blocked + 1
                end
            else
                if self.time >= target then break end
                local nextT = target
                if best and best.due < nextT then nextT = best.due end
                if nextT > self.time + self.quantum then nextT = self.time + self.quantum end
                stepClients(self, nextT - self.time)
                self.time = nextT
            end
        end
    end

    function net:inFlight() return #self.queue end

    return net
end
