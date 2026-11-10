-- King's Gambit: the text commands for the Master Looter's session: the loot method, starting, resolving and confirming a session, and what disenchanting gave. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local M = SK:NewModule("CmdSession")

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, engine, out, why, name, short, cur, list, append, hosting = h.ctx, h.client, h.engine, h.out, h.why, h.name, h.short, h.cur, h.list, h.append, h.hosting

    -- The disenchants given to me whose result is not recorded yet, oldest first: { listId, eventId }.
    function c.pendingDisenchants()
        local out = {}
        for _, id in ipairs(engine:Lists()) do
            local chain = engine:Get(id)
            for eid, dis in pairs(chain and chain.state.disenchants or {}) do
                if dis.to == client:me() and not dis.result then out[#out + 1] = { list = id, id = eid, ts = dis.ts, item = dis.item } end
            end
        end
        table.sort(out, function(a, b) if a.ts ~= b.ts then return a.ts < b.ts end return a.id < b.id end)
        return out
    end

    -- What you got, as typed ("3 Strange Dust, 1 Lesser Magic Essence", "Strange Dust x3") or as shift-clicked links (each followed by x2 for a stack).
    function c.parseResults(args)
        local results = {}
        for link, count in tostring(args or ""):gmatch("(|c%x+|Hitem:.-|h%[.-%]|h|r)%s*[xX]?(%d*)") do
            results[#results + 1] = { item = tonumber(link:match("item:(%d+)")), name = link:match("%[(.-)%]"), count = tonumber(count) or 1 }
        end
        if #results == 0 then
            for piece in (tostring(args or "") .. ","):gmatch("%s*(.-)%s*,") do
                if piece ~= "" then
                    local n, nm = piece:match("^(%d+)%s*[xX]?%s+(.+)$")
                    if not n then nm, n = piece:match("^(.-)%s+[xX](%d+)$") end
                    results[#results + 1] = { name = nm or piece, count = tonumber(n) or 1 }
                end
            end
        end
        if #results == 0 then return nil end
        return results
    end

    -- Record what disenchanting gave for the oldest item waiting (the Master Looter writes it; anyone else tells the Master Looter, who writes it at once).
    function c.reportDisenchant(results, silent)
        local waiting = c.pendingDisenchants()[1]
        if not waiting then
            if not silent then out("Nothing is waiting: no item was given to you to disenchant, or what it gave is already recorded.") end
            return
        end
        local data = { disenchant = waiting.id, results = results }
        if engine:LedgerId() and engine:MayWrite() then
            local ev = append(waiting.list, "DisenchantResult", data)
            if ev then out(("Recorded: %s"):format(c.describe(ev))) end
            return ev
        end
        if not ctx.requests then return out("Not sent: requests are not available here.") end
        local sent, err = ctx.requests:send({ kind = "disenchanted", disenchant = waiting.id, results = results, reason = "disenchanted" })
        if not sent then return out("Not sent: " .. why(err)) end
        out(("Telling %s what %s gave. It is written in the record when they receive it."):format(short(sent.ml), tostring(waiting.item)))
    end

    -- The game's own report: the loot window a Disenchant cast opened. What is in it is what the item gave, recorded against the oldest item waiting
    -- (silent when nothing is waiting: it is any other disenchant).
    if client.on then
        client:on("disenchant.loot", function(p)
            local results = {}
            for _, s in ipairs(p and p.slots or {}) do
                results[#results + 1] = { item = s.itemId, name = tostring(s.link or ""):match("%[(.-)%]") or "?", count = s.quantity or 1 }
            end
            if #results > 0 then c.reportDisenchant(results, true) end
        end)
    end

    function cmds.disenchanted(args)
        local results = c.parseResults(args)
        if not results then return out("disenchanted <what you got>  e.g. disenchanted 3 Strange Dust, 1 Lesser Magic Essence (or shift-click the items, each followed by x2 for a stack)") end
        c.reportDisenchant(results)
    end

    -- What the salvager (or anyone who claimed a leftover) did with it: keep, gift, sell, disenchant or bank. For transparency
    -- only: it moves nobody. Written by the Master Looter, about the player's most recent award that still stands.
    function cmds.salvaged(args)
        local usage = "salvaged <name> <keep|gift|sell|disenchant|bank>  (what <name> did with their latest item; it moves nobody)"
        local who, action = args:match("^(%S+)%s+(%S+)%s*$")
        if not who then return out(usage) end
        action = action:lower()
        local st = list(cur()) and list(cur()).state
        local best, bestId
        for id, a in pairs(st and st.awards or {}) do
            if a.member == name(who) and not a.reverted and (not best or a.ts > best.ts or (a.ts == best.ts and id > bestId)) then best, bestId = a, id end
        end
        if not best then return out(("%s has no award on the list to note."):format(short(name(who)))) end
        local ev = append(cur(), "Salvage", { award = bestId, action = action, member = best.member }, ("salvaged %s %s"):format(who, action))
        if ev then out(("Noted: %s %s %s. The list is unchanged."):format(short(name(who)), ({ keep = "kept", gift = "gave away", sell = "sold",
            disenchant = "disenchanted", bank = "banked" })[action] or action, tostring(best.item))) end
    end

    ---------------------------------------------------------------- Master Looter
    ---------------------------------------------------------------- the raid leader and the loot method
    local METHOD_NAMES = { master = "Master Looter", group = "Group Loot", needbeforegreed = "Need Before Greed",
        freeforall = "Free For All", personal = "Personal Loot", roundrobin = "Round Robin" }
    local function methodName(m) return METHOD_NAMES[m] or tostring(m) end

    -- Loot is handed out only with the loot method set to Master Looter (by the raid leader, in the game's raid setup)
    -- and only by the Master Looter named there. Say what is missing and who can fix it; true when ready.
    function c.explainLootSetup()
        if not client:inGroup() then
            out("You are not in a group. Loot is handed out in a raid or dungeon group, with the loot method set to Master Looter.")
            return false
        end
        local leader = client:leader()
        local leaderText = leader and (short(leader) .. (leader == client:me() and " (you)" or "")) or "the raid leader"
        if client:lootMethod() ~= "master" then
            out(("The loot method is %s. Loot is only handed out with Master Looter, and the raid leader (%s) sets that."):format(
                methodName(client:lootMethod()), leaderText))
            if leader == client:me() then
                out("You are the raid leader: masterloot <name> sets it (the name is who will be Master Looter; leave it out for yourself).")
            else
                out(("Ask %s to set it (Master Looter, naming the looter), or %s can do it with: masterloot <name>."):format(leaderText, leaderText))
            end
            return false
        end
        local ml = client:masterLooter()
        if ml ~= client:me() then
            out(("%s is the Master Looter, so only they start a loot session."):format(ml and short(ml) or "No one"))
            out(("If it should be you, the raid leader (%s) changes it."):format(leaderText))
            return false
        end
        return true
    end

    function cmds.masterloot(args)
        if not client:inGroup() then return out("You are not in a group.") end
        local leader = client:leader()
        if leader ~= client:me() then
            return out(("Only the raid leader can change the loot method. %s is the raid leader: ask them."):format(leader and short(leader) or "Someone"))
        end
        local who = args ~= "" and name(args) or client:me()
        local ok, reason = client:setLootMethod("master", who)
        if ok then
            return out(("Loot method set to Master Looter, with %s as Master Looter. (This is the game's own setting.)"):format(short(who)))
        end
        local WHYNOT = { badlooter = "that player is not in the raid", unavailable = "the game says Master Looter is not available here",
            failed = "the game refused the change", notleader = "only the raid leader can", badmethod = "unknown loot method", nogroup = "you are not in a group" }
        out("Could not set it: " .. (WHYNOT[reason] or tostring(reason)) .. ".")
    end

    function cmds.loot()
        if not ctx.host then return out("Loot sessions are not available here.") end
        if not c.explainLootSetup() then return end
        if engine:LedgerId() then
            local ok, reason = engine:MayWrite()
            if not ok then
                out("You can't record awards: " .. why(reason) .. ".")
                return out("An officer opens a raid with you as its Master Looter: raid open " .. short(client:me()))
            end
        end
        local slots = client:lootSlots()
        if #slots == 0 then return out("Open the loot window on the corpse first.") end
        local items = {}
        for i, s in ipairs(slots) do items[i] = { link = s.link, slot = s.slot } end
        local ok, err = ctx.host:start(items)
        if not ok then return out("Could not start: " .. why(err)) end
        local s = ctx.host.session
        out(("Loot session started for %d item(s). %d eligible. Players answer in their addon or by whisper."):format(#s.items, #s.eligibleList))
        for _, it in ipairs(s.items) do out(("  %d) %s%s"):format(it.id, it.link, c.itemNote(it.link))) end
        out("Next: announce (tell the raid how to answer), resolve (close bidding), extend, confirm, cancel.")
    end

    function cmds.announce()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        s:announce("RAID")
        out("Announced to the raid.")
    end

    function cmds.resolve()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        if not s:resolveNow() then out("Bidding is already closed (phase: " .. s.phase .. ").") end
    end

    function cmds.extend(args)
        local s = hosting()
        if not s then return out("No loot session is running.") end
        out(s:extend(tonumber(args) or 30) and "Added time." or "There is no running bid timer.")
    end

    function cmds.confirm()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        local ok, failures = s:confirm()
        if not ok then
            out("Not ready to confirm: " .. why(failures))
            if failures == "expired" or failures == "notauthorized" or failures == "duringraid" then
                out("Nothing was handed out or recorded, and the session is still waiting. Ask an officer to open the raid with you as Master Looter (raid open), then confirm again; or cancel.")
            end
            return
        end
        for _, f in ipairs(failures) do
            local item = f.item and f.item.link or "a list entry"
            out(("Could not hand over %s (%s: %s). It was NOT recorded. If you give it by hand, record it with: award <name> <item> <reason>"):format(item, f.stage, tostring(f.reason)))
        end
        out("Confirmed and recorded.")
    end

    function cmds.cancel()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        s:cancel()
        out("Session cancelled. Nothing was recorded.")
    end

    -- for the files installed after this one
    h.methodName = methodName
end
