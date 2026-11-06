-- King's Gambit: the Master Looter's addon writes down who is in the raid. Keep this file Lua 5.1-safe.
--
-- A raid officially starts when its FIRST ENEMY DIES INSIDE AN INSTANCE (a boss or trash: both drop loot that matters; something killed in the open world
-- while in a raid doesn't count): before that people are still arriving and nothing has been done. A raid outside an instance, such as a world boss, is
-- started by hand: `start()` (the Master Looter's "raid start"). From then on, while a raid this
-- character runs is open, the raid roster is compared with what the ledger already says about it, and the difference is written as one or more
-- Attendance entries ({ raid, joined, left }): everyone there at the first kill, then whoever comes or goes. It follows the group (the game's
-- roster-changed event), settles for a few seconds so a burst of changes is one entry, and checks again every half minute in case an event was missed.
-- A kill is seen as the first of: the game's encounter-ended event with a success; the Master Looter's loot window opening (they loot the corpse, trash or
-- boss, to hand its loot out); a loot session starting; or `enemyKilled()`. (The game's combat log would say it directly, but this client doesn't export the
-- function that reads it.)
-- Someone who leaves mid-raid is written as having left at that time, which is what makes "was in the raid when the boss died" answerable.
-- Names are split into entries of at most CHUNK so each stays small enough to travel (see Sync).
local _, SK = ...
local M = SK:NewModule("Attendance", {}, function() end)

M.CHUNK = 12
M.SETTLE = 4      -- seconds to wait after a roster change before writing it
M.RECHECK = 30    -- seconds between checks in case a change was missed

function M.New(engine, client, host)
    local a = { engine = engine, client = client }
    local waiting = false
    local official = {} -- raids whose first kill has happened, as far as this session knows (the ledger remembers it past a /reload)

    local function myRaid()
        local me = client:me()
        for _, r in ipairs(engine:ActiveRaids()) do if r.ml == me then return r end end
    end

    -- Write what differs between the roster and the ledger. Returns how many entries were written.
    function a:sync()
        local r = myRaid()
        if not r then return 0 end
        -- not started yet: nothing is written until the first kill (unless the ledger already has entries, e.g. after a /reload)
        if not official[r.id] and not engine:View().attendance[r.id] then return 0 end
        local present = {}
        for _, m in ipairs(client:roster()) do if m.name then present[m.name] = true end end
        local known = engine:Present(r.id)
        local joined, left = {}, {}
        for who in pairs(present) do if not known[who] then joined[#joined + 1] = who end end
        for who in pairs(known) do if not present[who] then left[#left + 1] = who end end
        table.sort(joined); table.sort(left)
        local written = 0
        local function flush(j, l)
            if #j + #l == 0 then return end
            local ev = engine:Write("Attendance", { raid = r.id, joined = #j > 0 and j or nil, left = #l > 0 and l or nil })
            if ev then written = written + 1 end
        end
        local j, l, n = {}, {}, 0
        for _, who in ipairs(joined) do
            j[#j + 1] = who; n = n + 1
            if n >= M.CHUNK then flush(j, l); j, l, n = {}, {}, 0 end
        end
        for _, who in ipairs(left) do
            l[#l + 1] = who; n = n + 1
            if n >= M.CHUNK then flush(j, l); j, l, n = {}, {}, 0 end
        end
        flush(j, l)
        return written
    end

    -- A change settles for a moment before it is written, so a burst (a raid filling up) is a few entries, not dozens.
    function a:soon()
        if waiting then return end
        waiting = true
        client:after(M.SETTLE, function() waiting = false; a:sync() end)
    end

    -- The first enemy has died: the raid officially starts, with everyone there now. Only inside an instance; a kill in the open world is not the raid.
    function a:enemyKilled()
        if client.inInstance and not client:inInstance() then return 0 end
        return a:start()
    end
    a.bossKilled = a.enemyKilled

    -- Start the raid now, wherever it is (a world boss): the Master Looter says so. Returns how many entries were written, or nil + why.
    function a:start()
        local r = myRaid()
        if not r then return nil, "notml" end
        official[r.id] = true
        return a:sync()
    end

    -- Has the raid I run officially started (the ledger has attendance for it)?
    function a:started()
        local r = myRaid()
        return r ~= nil and (official[r.id] or engine:View().attendance[r.id] ~= nil) and true or false
    end

    client:on("roster.changed", function() a:soon() end)
    client:on("encounter.ended", function(p) if type(p) == "table" and p.success then a:enemyKilled() end end)
    -- the Master Looter opening a loot window (a corpse, trash or boss) while their raid is open: something has died
    client:on("loot.opened", function(p) if type(p) == "table" and p.slots and #p.slots > 0 then a:enemyKilled() end end)
    if host and host.on then
        host.on("phase", function(p) if p == "bidding" or (type(p) == "table" and p.phase == "bidding") then a:enemyKilled() end end)
    end
    if client.every then client:every(M.RECHECK, function() a:sync() end) end
    return a
end

function M:OnInit() end

return M
