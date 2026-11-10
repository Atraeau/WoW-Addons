-- King's Gambit: the text commands for raids and who may write: opening, listing and closing raids, their list, and the disenchanter. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local Ledger, Requests
local M = SK:NewModule("CmdRaids", { "Ledger", "Requests?" }, function(d) Ledger, Requests = d.Ledger, d.Requests end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, engine, out, why, name, short, list = h.ctx, h.client, h.engine, h.out, h.why, h.name, h.short, h.list
    local methodName = h.methodName

    ---------------------------------------------------------------- raids and who may write
    local function minutesLeft(r) return math.max(0, math.floor((r.expires - client:serverTime()) / 60 + 0.5)) end

    local function findRaid(ml)
        local raids = engine:ActiveRaids()
        if ml then
            for _, r in ipairs(raids) do if r.ml == ml then return r end end
            return nil
        end
        if #raids == 1 then return raids[1] end
    end

    local function writeAuthority(type_, data)
        local ev, err = engine:Write(type_, data)
        if not ev then out("Not recorded: " .. why(err)) end
        return ev
    end

    local raid = {}
    function raid.show()
        if client:inGroup() then
            local leader = client:leader()
            local ml = client:masterLooter()
            out(("Raid leader: %s. Loot method: %s%s."):format(leader and short(leader) or "(none)", methodName(client:lootMethod()),
                (client:lootMethod() == "master" and ml) and (", Master Looter " .. short(ml)) or ""))
            if client:lootMethod() ~= "master" then out("Loot cannot be handed out until the raid leader sets Master Looter (masterloot).") end
        end
        local raids = engine:ActiveRaids()
        for _, r in ipairs(raids) do
            local ml = client:masterLooter()
            if client:lootMethod() == "master" and ml and ml ~= r.ml then
                out(("Note: the game's Master Looter is %s, but the open raid names %s, and only they may write to the list."):format(short(ml), short(r.ml)))
            end
        end
        if #raids == 0 then
            out("No raid is open. Officers write to the list directly; an officer opens a raid with: raid open <Master Looter>")
            return
        end
        for _, r in ipairs(raids) do
            local l = engine:ListOfRaid(r)
            out(("Raid %s: %s is Master Looter for %d more minute(s) (opened by %s), on the %s list. Only they write to it."):format(
                r.id, short(r.ml), minutesLeft(r), short(r.by), l or "(none yet: raid list <id>)"))
        end
    end
    function raid.open(args)
        local listId = args:match("%f[%w]list%s+(%S+)")
        args = args:gsub("%s*%f[%w]list%s+%S+", "")
        local who, hours = args:match("^%s*(%a[^%s]*)%s*(%S*)$")
        if not who then hours = args:match("^%s*(%S*)$") end
        if not engine:IsOfficer() then return out("Only an officer can open a raid.") end
        if listId and not Ledger.ValidListId(listId) then return out("Not opened: " .. why("badlistid")) end
        if listId == "main" and engine:ListPolicy() == "perraid" then return out("Not opened: " .. why("needsownlist")) end
        if not listId and engine:ListPolicy() == "perraid" then
            return out("Not opened: the guild requires a list of its own for each raid. Name it: raid open <Master Looter> [hours] list <id>")
        end
        local ml = who and name(who) or client:masterLooter() or client:me()
        local h = tonumber(hours ~= "" and hours or nil) or 4
        local id = ("%s-%d"):format(short(ml), client:serverTime())
        if not writeAuthority("Elevate", { raid = id, ml = ml, minutes = math.floor(h * 60) }) then return end
        if listId and not writeAuthority("SetRaidList", { raid = id, list = listId }) then
            out(("The raid is open, but its list was not set. Set it now: raid list %s"):format(listId))
        end
        out(("Raid open: %s is Master Looter for %s hour(s), on the %s list. Until it is closed, only they write to the list;"):format(short(ml), h, listId or "main"))
        out("everyone else, officers included, sends them requests (request ...). Close it with: raid close")
        if listId then out("A list that doesn't exist yet is created, in the order of main, when the first session starts.") end
    end
    -- Name the list the open raid plays on (once), or show it.
    function raid.list(args)
        local raids = engine:ActiveRaids()
        if args == "" then
            if #raids == 0 then return out("No raid is open.") end
            for _, r in ipairs(raids) do
                local l = engine:ListOfRaid(r)
                out(("Raid %s plays on the %s list%s."):format(r.id, l or "(none yet)", r.listEv and "" or (l and " (the default)" or ": the guild requires one, name it: raid list <id>")))
            end
            return
        end
        if not engine:IsOfficer() then return out("Only an officer can name a raid's list.") end
        local r = findRaid(nil)
        if not r then return out("Which raid? More than one is open, or none: close the others or name the Master Looter first.") end
        if writeAuthority("SetRaidList", { raid = r.id, list = args }) then
            out(("Raid %s plays on the %s list. It cannot change any more."):format(r.id, args))
        end
    end
    -- The ledger owner's rule for how raids pick their list.
    function raid.policy(args)
        local a = engine:View().auth
        if args == "" then
            return out(a.policy == "perraid" and "Policy: every raid must have a list of its own (perraid). Change it: raid policy choose"
                or "Policy: a raid plays on main unless an officer names another list (choose). Require one list per raid: raid policy perraid")
        end
        args = args:lower()
        if writeAuthority("SetListPolicy", { mode = args }) then
            out(args == "perraid" and "From now on every raid must be opened with a list of its own (and can't use main). Raids already open are not changed."
                or "Raids play on main unless an officer names another list. Raids already open are not changed.")
        end
    end
    function raid.extend(args)
        if not engine:IsOfficer() then return out("Only an officer can extend a raid.") end
        local who, hours = args:match("^(%a[^%s]*)%s*(%S*)$")
        if not who then hours = args end
        local r = findRaid(who and name(who))
        if not r then return out("Which raid? Name its Master Looter: raid extend <name> [hours]") end
        local h = tonumber(hours ~= "" and hours or nil) or 1
        local minutes = math.floor((r.expires - client:serverTime()) / 60 + h * 60)
        if writeAuthority("Elevate", { raid = r.id, ml = r.ml, minutes = math.min(minutes, 24 * 60) }) then
            out(("Raid %s extended by %s hour(s)."):format(r.id, h))
        end
    end
    -- Start the raid now, for a raid outside an instance (a world boss). Inside an instance it starts by itself at the first kill.
    function raid.start()
        local r = findRaid(client:me())
        if not r then return out("You are not the Master Looter of an open raid.") end
        local a = ctx.attendance
        if not a then return out("Attendance is not available here.") end
        if a:started() then return out("This raid has already started: who is in it is being written down.") end
        local n, why = a:start()
        if not n then return out("Not started: " .. tostring(why)) end
        out("The raid has started: everyone in the group now is written down as there, and the group is followed from here.")
    end
    -- Take the start of the raid into your own hands (off), or leave it to the first kill in an instance (on, the default).
    function raid.autostart(args)
        local a = ctx.attendance
        if not a then return out("Attendance is not available here.") end
        args = args:lower()
        if args == "" then
            return out(a:auto() and "The raid starts by itself at the first enemy killed in an instance. Take control of the start: raid autostart off"
                or "The raid starts only when you say so (raid start). Let it start by itself at the first kill in an instance: raid autostart on")
        end
        if args ~= "on" and args ~= "off" then return out("raid autostart [on|off]") end
        a:setAuto(args == "on")
        out(args == "on" and "The raid will start by itself at the first enemy killed in an instance (or when you say: raid start)."
            or "The raid will start only when you say so: raid start. Nothing starts it by itself now.")
    end
    function raid.close(args)
        local r = findRaid(client:me())
        if not r then return out("You are not the Master Looter of an open raid.") end
        local waiting = ctx.requests and ctx.requests:pending() or {}
        if #waiting > 0 and args ~= "anyway" then
            out(("%d request(s) are still waiting. Once the raid is closed you can't answer them:"):format(#waiting))
            for _, p in ipairs(waiting) do out(("  #%d from %s: %s"):format(p.num, short(p.by), Requests.Describe(p))) end
            return out("Answer them (accept <n>, decline <n> <reason>), or close regardless: raid close anyway")
        end
        if writeAuthority("RaidClose", { raid = r.id }) then
            out("Raid closed. Officers can edit the list directly again.")
        end
    end
    function raid.revoke(args)
        if not engine:IsOfficer() then return out("Only an officer can revoke a Master Looter.") end
        local r = findRaid(args ~= "" and name(args) or nil)
        if not r then return out("Which raid? Name its Master Looter: raid revoke <name>") end
        if writeAuthority("Revoke", { raid = r.id }) then
            out(("%s is no longer Master Looter of raid %s. The revocation is in the record."):format(short(r.ml), r.id))
        end
    end
    function cmds.disenchanter(args)
        local r = findRaid(client:me())
        local who = args ~= "" and name(args) or nil
        if not who then
            local current = engine:RaidDisenchanter()
            if current then return out(("%s disenchants for your raid (chosen by you)."):format(short(current))) end
            local anyRaid = engine:ActiveRaids()[1]
            if anyRaid and anyRaid.disenchanter then
                return out(("%s disenchants for raid %s (chosen by its Master Looter, %s)."):format(short(anyRaid.disenchanter), anyRaid.id, short(anyRaid.ml)))
            end
            return out("No disenchanter is designated yet. The raid's Master Looter chooses: disenchanter <name>")
        end
        if not r then return out("Only a raid's Master Looter chooses its disenchanter, and you are not the Master Looter of an open raid.") end
        if writeAuthority("SetDisenchanter", { raid = r.id, name = who }) then
            out(("%s disenchants what nobody wants, for this raid. It is in the record."):format(short(who)))
        end
    end

    function cmds.raid(args)
        local sub, rest = args:match("^(%S*)%s*(.-)$")
        local fn = raid[sub ~= "" and sub:lower() or "show"]
        if not fn then return out("raid [open [name] [hours] [list <id>] | list [id] | policy [choose|perraid] | start | autostart [on|off] | close | extend [name] [hours] | revoke [name]]") end
        fn(rest)
    end

    -- for the files installed after this one
    h.writeAuthority = writeAuthority
end
