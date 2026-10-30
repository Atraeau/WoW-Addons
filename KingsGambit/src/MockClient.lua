-- King's Gambit: MockClient, a headless fake of the WoW API (Phase 1.5).
-- Runs under plain Lua and inside the game. Time, randomness, raid, loot, comms and
-- trades are all scripted by the test (or training scenario) through the control
-- methods below. Keep this file Lua 5.1-safe (no `//`, no bitwise operators).
-- Design: docs/client-interface.md
local _, SK = ...
local Hash, Client
local M = SK:NewModule("MockClient", { "Hash", "Client" }, function(d) Hash, Client = d.Hash, d.Client end)

local CHANNELS = { RAID = true, PARTY = true, GUILD = true, WHISPER = true }
local PM_MOD = 2147483647 -- Park-Miller: state * 16807 stays below 2^53, so it is exact

local function copyList(t)
    local out = {}
    for i, v in ipairs(t) do
        if type(v) == "table" then
            local c = {}
            for k, x in pairs(v) do c[k] = x end
            out[i] = c
        else
            out[i] = v
        end
    end
    return out
end

-- opts: name, realm, seed, clock (start of now()), unix (start of serverTime()).
function M.New(opts)
    opts = opts or {}
    local realm = opts.realm or "Realm"
    local function normalize(name)
        if type(name) ~= "string" or name == "" then return nil end
        if name:find("-", 1, true) then return name end
        return name .. "-" .. realm
    end

    local clock = opts.clock or 1000
    local clock0, unix0 = clock, opts.unix or 1760000000
    local seed = ((opts.seed or 1) % PM_MOD) + 0.0 -- float: exact, and no 32-bit integer overflow on any runtime
    if seed == 0 then seed = 1 end

    local S = {
        me = normalize(opts.name or "Tester"),
        timers = {}, nextTimer = 1, restricted = false,
        prefixes = {},
        roster = {}, guild = {}, inRaid = false, lootMethod = "group", masterLooter = nil,
        loot = { open = false, slots = {} },
        items = {}, pendingInfo = {}, tradeable = {}, trade = nil,
        storage = { account = {}, char = {} },
    }

    local bus = Client.NewBus()

    local h = {
        caps = { masterLoot = true, trade = true, comms = true, guild = true },
        maxMessage = 255,
        sent = {},    -- everything the client tried to send
        given = {},   -- loot handed out through give()
        printed = {}, logs = {}, sounds = {},
        onSend = nil, -- SimNetwork hooks in here: function(client, message)
        pendingCount = 0,
    }

    ---------------------------------------------------------------- time
    function h:now() return clock end
    function h:serverTime() return unix0 + math.floor(clock - clock0) end

    function h:after(sec, fn)
        local t = { id = S.nextTimer, due = clock + sec, fn = fn }
        S.nextTimer = S.nextTimer + 1
        S.timers[#S.timers + 1] = t
        return t
    end

    function h:every(sec, fn)
        assert(sec > 0, "every: interval must be positive")
        local t = { id = S.nextTimer, due = clock + sec, interval = sec, fn = fn }
        S.nextTimer = S.nextTimer + 1
        S.timers[#S.timers + 1] = t
        return t
    end

    function h:cancel(handle)
        if handle then handle.cancelled = true end
    end

    -- Move the clock forward, firing due timers in order (each sees the right now()).
    function h:advance(sec)
        local target = clock + sec
        while true do
            local nxt
            for _, t in ipairs(S.timers) do
                if not t.cancelled and t.due <= target
                    and (not nxt or t.due < nxt.due or (t.due == nxt.due and t.id < nxt.id)) then
                    nxt = t
                end
            end
            if not nxt then break end
            if nxt.due > clock then clock = nxt.due end
            if nxt.interval then nxt.due = nxt.due + nxt.interval else nxt.cancelled = true end
            nxt.fn()
        end
        clock = target
        local keep = {}
        for _, t in ipairs(S.timers) do
            if not t.cancelled then keep[#keep + 1] = t end
        end
        S.timers = keep
    end

    function h:random(n)
        seed = (seed * 16807) % PM_MOD
        local r = seed / PM_MOD
        if n then return math.floor(r * n) + 1 end
        return r
    end

    ---------------------------------------------------------------- events
    function h:on(event, fn) return bus.on(event, fn) end
    function h:emit(event, payload) bus.emit(event, payload) end

    ---------------------------------------------------------------- identity, roster
    function h:me() return S.me end
    function h:normalize(name) return normalize(name) end
    function h:inRaid() return S.inRaid and #S.roster > 0 end
    function h:inGroup() return #S.roster > 0 end
    function h:roster() return copyList(S.roster) end

    function h:rankOf(name)
        name = normalize(name)
        for _, m in ipairs(S.roster) do
            if m.name == name then return m.rank end
        end
    end

    -- The raid (or dungeon group) leader: there is always one in a group. nil when not in a group.
    function h:leader()
        for _, m in ipairs(S.roster) do
            if m.rank == 2 then return m.name end
        end
    end

    function h:guildRoster() return copyList(S.guild) end

    -- members: array of "Name" or { name, class, online }; o: leader, assistants, lootMethod, masterLooter.
    function h:setRaid(members, o)
        o = o or {}
        local assist = {}
        for _, a in ipairs(o.assistants or {}) do assist[normalize(a)] = true end
        local leader = o.leader and normalize(o.leader)
        S.roster = {}
        for i, m in ipairs(members) do
            local isTable = type(m) == "table"
            local name = normalize(isTable and m.name or m)
            S.roster[#S.roster + 1] = {
                name = name,
                class = (isTable and m.class) or "WARRIOR",
                rank = (name == leader and 2) or (assist[name] and 1) or 0,
                online = not (isTable and m.online == false),
                subgroup = math.floor((i - 1) / 5) + 1,
            }
        end
        S.inRaid = true
        local oldMethod, oldLooter = S.lootMethod, S.masterLooter
        if o.lootMethod then S.lootMethod = o.lootMethod end
        if o.masterLooter then S.masterLooter = normalize(o.masterLooter) end
        self:emit("roster.changed")
        if S.lootMethod ~= oldMethod or S.masterLooter ~= oldLooter then self:emit("lootMethod.changed", { method = S.lootMethod }) end
    end

    function h:setGuild(members)
        S.guild = {}
        for _, m in ipairs(members) do
            local isTable = type(m) == "table"
            S.guild[#S.guild + 1] = {
                name = normalize(isTable and m.name or m),
                class = (isTable and m.class) or "WARRIOR",
                online = not (isTable and m.online == false),
            }
        end
    end

    ---------------------------------------------------------------- loot
    local METHODS = { master = true, group = true, freeforall = true, needbeforegreed = true, personal = true, roundrobin = true }
    -- Only the leader can change the loot method, as in the game. For "master", `looter` names the Master Looter (default:
    -- the leader). Returns true, or false + a reason: nogroup, notleader, badmethod, badlooter.
    function h:setLootMethodAs(actor, method, looter)
        actor = normalize(actor)
        if #S.roster == 0 then return false, "nogroup" end
        if self:leader() ~= actor then return false, "notleader" end
        if not METHODS[method] then return false, "badmethod" end
        local ml
        if method == "master" then
            ml = normalize(looter or actor)
            local inRaid = false
            for _, m in ipairs(S.roster) do if m.name == ml then inRaid = true end end
            if not inRaid then return false, "badlooter" end
        end
        S.lootMethod, S.masterLooter = method, ml
        self:emit("lootMethod.changed", { method = method })
        return true
    end
    -- (the simulator drives the raid leader, who is another player, through setLootMethodAs)
    function h:setLootMethod(method, looter) return self:setLootMethodAs(S.me, method, looter) end

    -- Hand the raid leadership to another member (the game's "promote to leader").
    function h:setLeader(name)
        name = normalize(name)
        local found = false
        for _, m in ipairs(S.roster) do if m.name == name then found = true end end
        if not found then return false, "notinraid" end
        for _, m in ipairs(S.roster) do
            if m.name == name then m.rank = 2 elseif m.rank == 2 then m.rank = 0 end
        end
        self:emit("roster.changed")
        return true
    end

    function h:lootMethod() return S.lootMethod end
    function h:isMasterLooter() return S.lootMethod == "master" and S.masterLooter == S.me end
    -- Who the Master Looter is (Name-Realm), or nil when the loot method is not master looter.
    function h:masterLooter() return S.lootMethod == "master" and S.masterLooter or nil end

    local function openSlots()
        local out = {}
        for _, s in ipairs(S.loot.slots) do
            if not s.taken then
                out[#out + 1] = { slot = s.slot, link = s.link, itemId = s.itemId, quality = s.quality, quantity = s.quantity }
            end
        end
        return out
    end

    function h:lootSlots() return S.loot.open and openSlots() or {} end

    function h:candidates(slot)
        local s = S.loot.open and S.loot.slots[slot]
        if not s or s.taken then return nil, "gone" end
        return copyList(s.candidates)
    end

    function h:give(slot, name)
        if not self:isMasterLooter() then return false, "notml" end
        local s = S.loot.open and S.loot.slots[slot]
        if not s or s.taken then return false, "gone" end
        name = normalize(name)
        local ok = false
        for _, c in ipairs(s.candidates) do
            if c == name then ok = true; break end
        end
        if not ok then return false, "notcandidate" end
        s.taken = true
        self.given[#self.given + 1] = { slot = slot, link = s.link, to = name, t = clock }
        self:emit("loot.slotCleared", { slot = slot })
        if #openSlots() == 0 then
            S.loot.open = false
            self:emit("loot.closed")
        end
        return true
    end

    -- items: array of { link, itemId, quality, quantity, candidates } (candidates default to the raid).
    function h:dropLoot(items)
        S.loot = { open = true, slots = {} }
        for i, it in ipairs(items) do
            local cands = {}
            if it.candidates then
                for _, c in ipairs(it.candidates) do cands[#cands + 1] = normalize(c) end
            else
                for _, m in ipairs(S.roster) do cands[#cands + 1] = m.name end
            end
            S.loot.slots[i] = { slot = i, link = it.link, itemId = it.itemId, quality = it.quality or 4,
                quantity = it.quantity or 1, candidates = cands, taken = false }
        end
        self:emit("loot.opened", { slots = openSlots() })
    end

    function h:closeLoot()
        if S.loot.open then
            S.loot.open = false
            self:emit("loot.closed")
        end
    end

    function h:itemInfo(link)
        local info = S.items[link]
        if not info or S.pendingInfo[link] then return nil end
        local c = {}
        for k, v in pairs(info) do c[k] = v end
        return c
    end

    -- Register item data. With { delayed = true } itemInfo() returns nil until cacheItem(link).
    function h:setItemInfo(link, info, o)
        S.items[link] = info
        if o and o.delayed then S.pendingInfo[link] = true end
    end

    -- Stats and class restriction: { stats = { str = 12, ... }, classes = { "PRIEST" } | nil } (see ItemFit).
    function h:setItemStats(link, st) S.itemStats = S.itemStats or {}; S.itemStats[link] = st end
    function h:itemStats(link)
        if S.pendingInfo[link] then return nil end
        return S.itemStats and S.itemStats[link] or nil
    end

    function h:cacheItem(link)
        S.pendingInfo[link] = nil
        self:emit("item.info", { link = link, itemId = tonumber(tostring(link):match("item:(%d+)")) })
    end

    -- What this player holds: setBags({ [nameOrId] = count }), setReputation(factionId, reaction 1..8).
    function h:itemCount(what) return (S.bags and S.bags[what]) or 0 end
    function h:setBags(bags) S.bags = bags end
    function h:reputation(factionId) return S.reps and S.reps[factionId] end
    function h:setReputation(factionId, reaction) S.reps = S.reps or {}; S.reps[factionId] = reaction end

    ---------------------------------------------------------------- communication
    function h:registerPrefix(prefix)
        S.prefixes[prefix] = true
        return true
    end

    function h:send(prefix, payload, channel, target)
        if not self.caps.comms then return false, "nocomms" end
        if S.restricted then return false, "restricted" end
        if not S.prefixes[prefix] then return false, "noprefix" end
        if type(payload) ~= "string" then return false, "badpayload" end
        if #payload > self.maxMessage then return false, "toolong" end
        if not CHANNELS[channel] then return false, "badchannel" end
        if channel == "WHISPER" and not target then return false, "notarget" end
        local msg = { kind = "addon", prefix = prefix, payload = payload, channel = channel,
            target = target and normalize(target), from = S.me, t = clock }
        self.sent[#self.sent + 1] = msg
        if self.onSend then self.onSend(self, msg) end
        return true
    end

    function h:pending() return self.pendingCount end

    -- Simulate the client restricting outgoing addon messages (e.g. during a boss encounter).
    function h:setRestricted(flag)
        S.restricted = flag and true or false
        self:emit("comms.restrictionChanged", { restricted = S.restricted })
    end

    function h:whisper(name, text)
        self.sent[#self.sent + 1] = { kind = "whisper", target = normalize(name), text = text, from = S.me, t = clock }
        return true
    end

    function h:announce(text, channel)
        self.sent[#self.sent + 1] = { kind = "announce", channel = channel or "RAID", text = text, from = S.me, t = clock }
        return true
    end

    function h:serialize(t) return Hash.Canon(t) end
    function h:deserialize(str) return Hash.Decode(str) end

    function h:clearSent() self.sent = {} end

    -- The world talking to the client.
    function h:receive(prefix, payload, channel, sender)
        if not S.prefixes[prefix] then return false end
        self:emit("comms.received", { prefix = prefix, payload = payload, channel = channel, sender = normalize(sender) })
        return true
    end

    function h:whisperFrom(name, text)
        self:emit("whisper.received", { sender = normalize(name), text = text })
    end

    ---------------------------------------------------------------- trade
    function h:trade()
        if not S.trade then return nil end
        return { partner = S.trade.partner, give = copyList(S.trade.give), get = copyList(S.trade.get), accepted = S.trade.accepted }
    end

    function h:setTrade(t)
        S.trade = { partner = normalize(t.partner), give = t.give or {}, get = t.get or {}, accepted = t.accepted or false }
        self:emit("trade.changed", { trade = self:trade() })
    end

    function h:completeTrade(partner, gave, got)
        S.trade = nil
        self:emit("trade.closed", { completed = true, partner = normalize(partner), gave = gave or {}, got = got or {} })
    end

    function h:cancelTrade()
        S.trade = nil
        self:emit("trade.closed", { completed = false })
    end

    function h:setTradeable(link, seconds) S.tradeable[link] = clock + seconds end

    function h:tradeableUntil(link)
        local exp = S.tradeable[link]
        if exp and exp > clock then return exp - clock end
    end

    ---------------------------------------------------------------- environment
    function h:storage() return S.storage end
    function h:playSound(kind) self.sounds[#self.sounds + 1] = kind end
    function h:print(text) self.printed[#self.printed + 1] = text end
    function h:log(level, text) self.logs[#self.logs + 1] = { level = level, text = text } end

    function h:endEncounter(id, name, success)
        self:emit("encounter.ended", { id = id, name = name, success = success })
    end

    function h:enterWorld() self:emit("world.entered") end

    -- Simulate /reload: timers, handlers and prefix registrations vanish; storage, clock and
    -- the simulated world survive. The caller builds a fresh client over the same client.
    function h:reload()
        S.timers, S.prefixes = {}, {}
        bus.clear()
        return self
    end

    return h
end
