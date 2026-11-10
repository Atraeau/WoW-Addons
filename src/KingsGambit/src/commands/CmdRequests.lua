-- King's Gambit: the text commands for the dispute path: requests to the Master Looter and their answers, the history of changes, and the words for a ledger event. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local Standings, ItemFit, Requests
local M = SK:NewModule("CmdRequests", { "Standings", "ItemFit", "Requests?" }, function(d) Standings, ItemFit, Requests = d.Standings, d.ItemFit, d.Requests end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, engine, out, why, name, short, cur = h.ctx, h.client, h.engine, h.out, h.why, h.name, h.short, h.cur
    local act, char, linkOf, myClass = h.act, h.char, h.linkOf, h.myClass

    ---------------------------------------------------------------- requests (the dispute path)
    local REQUEST_USAGE = {
        move = "request move <name> <top|bottom|N> <reason>", undo = "request undo <name> <reason>",
        add = "request add <name> [top|bottom|N] <reason>", remove = "request remove <name> <reason>",
        award = "request award <name> <item> <reason>", gift = "request gift <name> <to> <reason>",
        trade = "request trade <name> <to> <reason>",
        eligible = "request eligible <item or item#> <reason>",
    }
    local function isPos(p) return p == "top" or p == "bottom" or (tonumber(p) ~= nil) end

    -- Parse "request ..." into a request table, or nil + usage text.
    function c.parseRequest(args)
        local target, rest = args:match("^@(%S+)%s+(.*)$")
        args = rest or args
        local kind, body = args:match("^(%a+)%s*(.-)$")
        kind = kind and kind:lower()
        if kind == "disenchanted" then return nil, nil, "To record what disenchanting gave, use: disenchanted <what you got>" end
        if not (kind and Requests.KINDS[kind]) then return nil, nil, "request <move|undo|add|remove|award|trade|gift|eligible> ...  (see help)" end
        local r = { kind = kind }
        if kind == "eligible" then
            -- the item: a link, an item id, or an item's number in the running loot session
            local link, reason = body:match("^(|c.-|r)%s*(.-)$")
            if not link then link, reason = body:match("^(%S+)%s*(.-)$") end
            local n = link and tonumber(link)
            if n and linkOf(n) then link = linkOf(n) elseif n then link = "item:" .. n end -- a bare item id
            r.item, r.reason, r.class = link, reason ~= "" and reason or nil, myClass()
            r.spec = char.spec and char.spec.main
            if not Requests.Validate(r) then return nil, nil, REQUEST_USAGE.eligible .. "  (a reason is required: it goes in the record)" end
            return r, target and name(target)
        end
        local who, more = body:match("^(%S+)%s*(.-)$")
        r.member = who and name(who)
        if kind == "move" then
            local pos, reason = (more or ""):match("^(%S+)%s+(.+)$")
            if pos and isPos(pos) then r.pos, r.reason = pos, reason end
        elseif kind == "add" then
            local pos, reason = (more or ""):match("^(%S+)%s+(.+)$")
            if pos and isPos(pos) then r.pos, r.reason = pos, reason else r.reason = more end
        elseif kind == "award" then
            local link, reason = (more or ""):match("^(|c.-|r)%s+(.+)$")
            if not link then link, reason = (more or ""):match("^(%S+)%s+(.+)$") end
            r.item, r.reason = link, reason
        elseif kind == "gift" or kind == "trade" then
            local to, reason = (more or ""):match("^(%S+)%s+(.+)$")
            r.to, r.reason = to and name(to), reason
        else
            r.reason = more
        end
        if r.reason == "" then r.reason = nil end
        if not Requests.Validate(r) then return nil, nil, REQUEST_USAGE[kind] .. "  (a reason is required: it goes in the record)" end
        return r, target and name(target)
    end

    function cmds.request(args)
        if not ctx.requests then return out("Requests are not available here.") end
        local r, target, usage = c.parseRequest(args)
        if not r then return out(usage) end
        if #engine:ActiveRaids() == 0 and engine:MayWrite() then
            return out("No raid is open, so you can make this change directly (e.g. move, add, remove, undo).")
        end
        local sent, err = ctx.requests:send(r, target)
        if not sent then return out("Not sent: " .. why(err)) end
        out(("Asking %s to %s. You'll see the answer here."):format(short(sent.ml), Requests.Describe(sent)))
    end

    function cmds.requests()
        local q = ctx.requests
        if not q then return out("Requests are not available here.") end
        local waiting = q:pending()
        if #waiting > 0 then
            out("Waiting for your answer (accept <n> | decline <n> <reason>):")
            for _, p in ipairs(waiting) do out(("  #%d from %s: %s. Reason: %s"):format(p.num, short(p.by), Requests.Describe(p), p.reason)) end
        end
        local mine = {}
        for _, r in pairs(q.sent) do mine[#mine + 1] = r end
        table.sort(mine, function(a, b) return a.rid < b.rid end)
        for _, r in ipairs(mine) do
            out(("  your request to %s: %s (%s)"):format(short(r.ml), Requests.Describe(r), r.state))
        end
        -- Recent decisions, from the ledger.
        local decided = {}
        for _, ev in ipairs(engine:View().applied) do
            if ev.data.requestedBy then decided[#decided + 1] = ev end
        end
        if #waiting == 0 and #mine == 0 and #decided == 0 then return out("No requests.") end
        if #decided > 0 then out("Recent decisions:") end
        for i = math.max(1, #decided - 4), #decided do out("  " .. c.describe(decided[i])) end
    end

    function cmds.accept(args)
        local q = ctx.requests
        local num = tonumber(args)
        if not (q and num) then return out("accept <n>  (see: requests)") end
        local ev, err = q:accept(num)
        if not ev then return out(("Request #%d not carried out: %s. It is still waiting; decline it with a reason if it can't be done."):format(num, why(err))) end
        out(("Done, and recorded as requested by %s: %s"):format(short(ev.data.requestedBy), c.describe(ev)))
    end

    function cmds.decline(args)
        local q = ctx.requests
        local num, reason = args:match("^(%d+)%s*(.-)$")
        if q and num then
            if reason == "" then return out("decline <n> <reason>  (the reason goes in the record, and the requester sees it)") end
            local ev, err = q:decline(tonumber(num), reason)
            if not ev then return out("Not declined: " .. why(err)) end
            return out(("Declined, and recorded: %s"):format(c.describe(ev)))
        end
        -- no number: declining a salvage offer in a loot session
        act(function(s) return s:decline(client:me()) end, function(p) return p:decline() end)
    end

    -- One ledger event in words.
    function c.describe(ev)
        local d = ev.data
        local who, by = short(d.member), short(ev.author)
        local text
        if ev.type == "Award" then
            text = ("%s won %s%s"):format(who, tostring(d.item), d.to and d.to ~= d.member and (" (for " .. short(d.to) .. ")") or "")
            if d.replaces then
                local old
                for _, e in ipairs(engine:View().applied) do if e.id == d.replaces then old = e.data and e.data.member end end
                text = ("%s took %s, which had been recorded for %s (%s restored)"):format(who, tostring(d.item), old and short(old) or "someone else", old and short(old) or "they")
            end
        elseif ev.type == "MovePlayer" then text = ("%s moved %s to %s"):format(by, who, d.to or ("just above " .. short(d.above)))
        elseif ev.type == "AddMember" then text = ("%s added %s"):format(by, who)
        elseif ev.type == "Disenchant" then text = ("%s was given to %s to disenchant"):format(tostring(d.item), short(d.to))
        elseif ev.type == "DisenchantResult" then
            local item
            for _, e in ipairs(engine:View().applied) do if e.id == d.disenchant then item = e.data and e.data.item end end
            text = ("%s disenchanted %s and got %s"):format(short(d.requestedBy or ev.author), tostring(item or "an item"), Standings.ResultText(d.results))
        elseif ev.type == "Attendance" then
            local function some(names)
                local out = {}
                for i = 1, math.min(#names, 3) do out[i] = short(names[i]) end
                local text = table.concat(out, ", ")
                return #names > 3 and (text .. (" and %d more"):format(#names - 3)) or text
            end
            local parts = {}
            if d.joined and #d.joined > 0 then parts[#parts + 1] = some(d.joined) .. (#d.joined == 1 and " was" or " were") .. " in the raid" end
            if d.left and #d.left > 0 then parts[#parts + 1] = some(d.left) .. " left the raid" end
            text = table.concat(parts, "; ")
        elseif ev.type == "CreateList" then text = ("%s started the list %s"):format(by, tostring(d.name or ev.list or "main"))
        elseif ev.type == "RemoveMember" then text = ("%s removed %s"):format(by, who)
        elseif ev.type == "Revert" then text = ("%s undid %s"):format(by, who and (who .. "'s award") or "an award")
        elseif ev.type == "Salvage" then text = ("%s noted that %s's item was %s"):format(by, who or "a winner",
            ({ keep = "kept", gift = "given away", sell = "sold", disenchant = "disenchanted", bank = "banked" })[d.action] or tostring(d.action))
        elseif ev.type == "Transfer" then text = ("%s recorded that %s's item went to %s"):format(by, who or "a winner", short(d.to))
        elseif ev.type == "Declined" then text = ("%s declined %s's request to %s: %s"):format(by, short(d.requestedBy), d.request, d.declineReason)
        elseif ev.type == "Pass" then
            text = ("%s passed on %s"):format(who, tostring(d.item))
            if d.kind == "undecided" then text = text .. " (won it as a gift but didn't say who gets it; the Master Looter counted it as a pass)" end
        elseif ev.type == "SetDisenchanter" then text = ("%s chose %s to disenchant for raid %s"):format(by, short(d.name), tostring(d.raid))
        elseif ev.type == "ItemSuits" then
            text = ("%s set who %s suits: %s"):format(by, d.name or ("item " .. tostring(d.item)),
                #(d.roles or {}) > 0 and table.concat(d.roles, ", ") or "back to the addon's own judgment")
        elseif ev.type == "ItemClasses" then
            local names = {}
            for i, cl in ipairs(d.classes or {}) do names[i] = ItemFit.CLASS_NAMES[cl] or cl end
            text = ("%s set who may bid on %s: %s"):format(by, d.name or ("item " .. tostring(d.item)),
                #names > 0 and table.concat(names, ", ") or "any class")
        else text = ("%s: %s"):format(by, ev.type) end
        if ev.type ~= "Declined" and d.requestedBy then text = text .. (", at the request of %s"):format(short(d.requestedBy)) end
        if d.reason and ev.type ~= "Declined" then text = text .. (" (%s)"):format(d.reason) end
        return text
    end

    function cmds.history(args)
        local n = tonumber(args) or 10
        local rows = {}
        for _, ev in ipairs(engine:View().applied) do
            if ev.list == cur() or ev.type == "Declined" or ev.type == "ItemClasses" or ev.type == "ItemSuits" then rows[#rows + 1] = ev end
        end
        -- who disenchants is a raid decision, not a list change, but it belongs in the same history
        for _, ev in ipairs(engine:View().authApplied) do
            if ev.type == "SetDisenchanter" or ev.type == "SetRaidList" or ev.type == "SetListPolicy" then rows[#rows + 1] = ev end
        end
        local order = {}
        for i, ev in ipairs(rows) do order[ev] = i end
        table.sort(rows, function(x, y) if x.ts ~= y.ts then return x.ts < y.ts end return order[x] < order[y] end)
        if #rows == 0 then return out("Nothing has happened on the list yet.") end
        out(("The last %d change(s) to the list:"):format(math.min(n, #rows)))
        for i = math.max(1, #rows - n + 1), #rows do out("  " .. c.describe(rows[i])) end
    end
end
