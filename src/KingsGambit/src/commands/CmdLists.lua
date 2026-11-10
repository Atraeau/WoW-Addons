-- King's Gambit: the text commands for the lists: standings, choosing the working list, creating lists, adding, removing and moving players, awards, undo and trades. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local Standings
local M = SK:NewModule("CmdLists", { "Standings" }, function(d) Standings = d.Standings end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local client, engine, out, why, canWrite, name, short, cur, list, append = h.client, h.engine, h.out, h.why, h.canWrite, h.name, h.short, h.cur, h.list, h.append

    function cmds.standings(args)
        local id, n = args:match("^(%S*)%s*(%d*)$")
        id = (id ~= "" and id) or cur()
        local chain = list(id)
        if not chain then return out("No list called '" .. id .. "'. Create one with: create " .. id) end
        local order = chain.state.order
        out(("%s: %d on the list, %d events, head %s"):format(id, #order, #chain.events, chain.head:sub(1, 8)))
        for i = 1, math.min(#order, tonumber(n) or 20) do
            local m = chain.state.members[order[i]]
            out(("%2d. %s%s  (wins %d)"):format(i, short(order[i]), order[i] == client:me() and "  <- you" or "", m.wins))
        end
    end

    -- Which list add, move, award, undo... change. `list use <id>` picks one (officers fixing a past raid's list); `list use` goes back to the default.
    function cmds.list(args)
        local sub, id = args:match("^(%S*)%s*(%S*)$")
        if sub:lower() ~= "use" then return out(("Lists: %s. Working on: %s. Choose with: list use <id>"):format(table.concat(engine:Lists(), ", "), cur())) end
        if id == "" then h.setWorking(nil); return out("Working on " .. cur() .. " (the default).") end
        if not engine:Get(id) then return out("No list called '" .. id .. "'. Lists: " .. table.concat(engine:Lists(), ", ")) end
        h.setWorking(id)
        out("Working on " .. id .. ": add, move, award, undo and the like change that list now.")
    end

    function cmds.create(args)
        local id, title = args:match("^(%S+)%s*(.-)$")
        if not id then return out("create <list> [name]") end
        if not canWrite() then return out("Only the raid leader or an assistant can create a list.") end
        local chain, err = engine:CreateList(id, title ~= "" and title or id)
        out(chain and ("Created list '" .. id .. "'.") or ("Not created: " .. why(err)))
    end

    -- A list from just a friendly name: the id is made up of the name, the date and the officer who made it (letters, digits and _, 24 at most), and
    -- is made unique if that one is taken.
    function cmds.newlist(args)
        local title = args:match("^%s*(.-)%s*$")
        if title == "" then return out("newlist <name>  e.g. newlist Ahn'Qiraj  (the id is made for you)") end
        if not canWrite() then return out("Only the raid leader or an assistant can create a list.") end
        local function slug(text, n) return (text:lower():gsub("[^a-z0-9]+", "_"):gsub("^_+", ""):gsub("_+$", "")):sub(1, n):gsub("_+$", "") end
        local officer = slug((client:me() or ""):match("^([^_]+)") or "", 5)
        local stamp = ((os and os.date) or date)("%y%m%d", client:serverTime())
        local base = slug(title, 10); if base == "" then base = "list" end
        local id = ("%s_%s_%s"):format(base, stamp, officer)
        local n = 1
        while engine:Get(id) do n = n + 1; id = (("%s_%s_%s"):format(base, stamp, officer)):sub(1, 22) .. n end
        local chain, err = engine:CreateList(id, title)
        out(chain and ("Created the list '" .. title .. "' (id " .. id .. ").") or ("Not created: " .. why(err)))
    end

    function cmds.add(args)
        local who, pos = args:match("^(%S+)%s*(%S*)$")
        if not who then return out("add <name> [top|bottom|N]") end
        local data = { member = name(who) }
        if pos ~= "" then
            local where, err = c.where(cur(), pos, nil)
            if not where then return out(err) end
            for k, v in pairs(where) do data[k] = v end
        end
        local ev = append(cur(), "AddMember", data, ("add %s %s<reason>"):format(who, pos ~= "" and (pos .. " ") or ""))
        if ev then out(short(data.member) .. " added.") end
    end

    -- Everyone in the group and the guild who is not on the list yet, with their classes (the window's button).
    function cmds.addall()
        local id = cur()
        local chain = list(id)
        if not chain then return out("No list called '" .. id .. "'. Create one with: create " .. id) end
        local seen, added = {}, 0
        for _, source in ipairs { client:roster(), client:guildRoster() } do
            for _, m in ipairs(source) do
                if m.name and not seen[m.name] and not chain.state.members[m.name] then
                    seen[m.name] = true
                    local ev, err = engine:Append(id, "AddMember", { member = m.name, class = m.class })
                    if not ev then
                        return out(("Added %d, then stopped: %s"):format(added, why(err)))
                    end
                    added = added + 1
                end
            end
        end
        out(added == 0 and "Everyone in your group and guild is already on the list." or ("Added %d to %s."):format(added, id))
    end

    function cmds.remove(args)
        local who, reason = args:match("^(%S+)%s*(.-)$")
        if not who then return out("remove <name> [reason]") end
        local chain = list(cur())
        local was = chain and Standings.Position(chain.state, name(who))
        local data = { member = name(who) }
        if reason ~= "" then data.reason = reason end
        local ev = append(cur(), "RemoveMember", data, ("remove %s <reason>"):format(who))
        if ev then
            out(short(name(who)) .. " removed." .. (was and (" They were at place %d: to put them back, add %s %d"):format(was, short(name(who)), was) or ""))
        end
    end

    function cmds.move(args)
        local who, pos, reason = args:match("^(%S+)%s+(%S+)%s+(.+)$")
        if not who then return out("move <name> <top|bottom|N> <reason>  (a reason is required and is part of the record)") end
        local where, err = c.where(cur(), pos, name(who))
        if not where then return out(err) end
        local data = { member = name(who), reason = reason }
        for k, v in pairs(where) do data[k] = v end
        local chain = list(cur())
        local was = chain and Standings.Position(chain.state, name(who))
        local ev = append(cur(), "MovePlayer", data, ("move %s %s %s"):format(who, pos, reason))
        if ev then
            out(short(name(who)) .. " moved (was place " .. tostring(was or "?") .. "; to undo this: move " .. short(name(who)) .. " " .. tostring(was or "?") .. " <reason>). The correction is recorded with your reason.")
        end
    end

    function cmds.undo(args)
        local chain = list(cur())
        local stack = chain and chain.state.undo[engine:MyChain()]
        if not (stack and #stack > 0) then
            out("Nothing can be undone (only awards you made, and only until you move the list by hand).")
            if #engine:ActiveRaids() > 0 then out("To undo someone else's award during a raid: request undo <name> <reason>") end
            return
        end
        -- undo [name] [yes]: the named player's latest award of yours, or your latest. Later awards are left as they are.
        local words, confirmed = {}, false
        for w in args:gmatch("%S+") do
            if w:lower() == "yes" then confirmed = true else words[#words + 1] = w end
        end
        local target
        if words[1] and words[1]:lower() == "id" then
            -- an entry picked in the Ledger pane: that very award (the entry's id)
            for i = #stack, 1, -1 do if tostring(stack[i].id) == tostring(words[2]) then target = stack[i]; break end end
            if not target then return out("That award can't be undone from here (only awards you made, and only until you move the list by hand).") end
        elseif #words == 0 then
            target = stack[#stack]
        else
            local who = name(words[1])
            for i = #stack, 1, -1 do
                if stack[i].member == who then target = stack[i]; break end
            end
            if not target then
                out(("%s has no award of yours that can be undone. Awards you can undo, latest first:"):format(short(who)))
                for i = #stack, math.max(1, #stack - 7), -1 do
                    local a = chain.state.awards[stack[i].id]
                    out(("  %s won %s"):format(short(stack[i].member), a and tostring(a.item) or "?"))
                end
                return
            end
        end
        local a = chain.state.awards[target.id]
        -- Undo changes the list, so it asks first: say what would be undone, and go ahead only on "yes".
        if not confirmed then
            out(("This would undo %s's award of %s%s. Awards made since stay as they are; the list ends up as if this one had never happened. The undo is recorded in the history (nothing is erased)."):format(
                short(target.member), a and tostring(a.item) or "?", target == stack[#stack] and " (your latest)" or ""))
            if #stack > 1 and #words == 0 then out("To undo an earlier one instead: undo <name>") end
            return out(("To go ahead: undo %s yes"):format(#words > 0 and short(target.member) or ""):gsub("  ", " "))
        end
        local ev = append(cur(), "Revert", { target = target.id })
        if ev then out(("%s's award of %s was undone and %s went back up the list. The undo is recorded in the history."):format(
            short(target.member), a and tostring(a.item) or "?", short(target.member))) end
    end

    -- Record a win that the session didn't: the hand-out failed, or the item went to the wrong person and the mistake is
    -- acknowledged. It is an ordinary award, so the recipient drops to the bottom as if they had won the bid, and the
    -- reason and the writer are in the record. (If the wrong winner was already recorded, undo that first.)
    function cmds.award(args)
        local usage = "award <name> <item> <reason>  (the player moves to the bottom, as if they had won it; the reason is part of the record)"
        local who, more = args:match("^(%S+)%s+(.+)$")
        if not who then return out(usage) end
        local link, reason = more:match("^(|c.-|r)%s+(.+)$")
        if not link then link, reason = more:match("^(%S+)%s+(.+)$") end
        if not link then return out(usage) end
        local chain = list(cur())
        local member = name(who)
        if chain and not (chain.state.members[member] and chain.state.members[member].active) then
            return out(("%s is not on the list, so they cannot be awarded anything. Add them first: add %s"):format(short(member), short(member)))
        end
        local ev = append(cur(), "Award", { member = member, item = link, reason = reason }, ("award %s %s %s"):format(who, link, reason))
        if ev then
            out(("Recorded: %s won %s and moves to the bottom. The reason is in the history."):format(short(member), link))
        end
    end

    -- A regret-trade: the item recorded as won by <name> really went to <to>. The winner is restored to their place and <to>
    -- moves to the bottom, as if they had won the bid; one atomic entry (see Standings, Award.replaces). A deliberate gift
    -- is different and explicit: nobody moves (request gift).
    function cmds.trade(args)
        local usage = "trade <name> <to> <reason>  (the item <name> last won went to <to>: <name> is restored, <to> moves to the bottom)"
        local who, to, reason = args:match("^(%S+)%s+(%S+)%s+(.+)$")
        if not who then return out(usage) end
        local chain = list(cur())
        local st = chain and chain.state
        local mine = {}
        for _, e in ipairs(st and st.undo[engine:MyChain()] or {}) do mine[#mine + 1] = e end
        local winner
        for i = #mine, 1, -1 do if mine[i].member == name(who) then winner = mine[i]; break end end
        if not winner then
            return out(("%s has no award of yours that can be traded. Awards you can change: use undo for the list."):format(short(name(who))))
        end
        local a = st.awards[winner.id]
        local toName = name(to)
        if not (st.members[toName] and st.members[toName].active) then
            return out(("%s is not on the list. Add them first: add %s"):format(short(toName), short(toName)))
        end
        local ev = append(cur(), "Award", { member = toName, item = a.item, replaces = winner.id, reason = reason },
            ("trade %s %s %s"):format(who, to, reason))
        if ev then
            out(("Recorded: %s's %s went to %s. %s is back in their place and %s moves to the bottom."):format(short(name(who)), tostring(a.item), short(toName), short(name(who)), short(toName)))
        end
    end
end
