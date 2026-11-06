-- King's Gambit: the Master Looter's addon writes down who is in the raid. Keep this file Lua 5.1-safe.
--
-- While a raid this character runs is open, the raid roster is compared with what the ledger already says about it, and the difference is written as one
-- or more Attendance entries ({ raid, joined, left }): everyone there when the raid opens, then whoever comes or goes. It follows the group (the game's
-- roster-changed event), settles for a few seconds so a burst of changes is one entry, and checks again every half minute in case an event was missed.
-- Someone who leaves mid-raid is written as having left at that time, which is what makes "was in the raid when the boss died" answerable.
-- Names are split into entries of at most CHUNK so each stays small enough to travel (see Sync).
local _, SK = ...
local M = SK:NewModule("Attendance", {}, function() end)

M.CHUNK = 12
M.SETTLE = 4      -- seconds to wait after a roster change before writing it
M.RECHECK = 30    -- seconds between checks in case a change was missed

function M.New(engine, client)
    local a = { engine = engine, client = client }
    local waiting = false

    local function myRaid()
        local me = client:me()
        for _, r in ipairs(engine:ActiveRaids()) do if r.ml == me then return r end end
    end

    -- Write what differs between the roster and the ledger. Returns how many entries were written.
    function a:sync()
        local r = myRaid()
        if not r then return 0 end
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

    client:on("roster.changed", function() a:soon() end)
    engine:OnChange(function(kind, _, ev)
        if kind == "local" and type(ev) == "table" and ev.type == "Elevate" then a:soon() end
    end)
    if client.every then client:every(M.RECHECK, function() a:sync() end) end
    return a
end

function M:OnInit() end

return M
