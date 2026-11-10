-- King's Gambit: the text commands for what the addon says on its own, from protocol events (a session starting, a request arriving, a raid ending). Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local Tokens, Requests
local M = SK:NewModule("CmdEvents", { "Tokens?", "Requests?" }, function(d) Tokens, Requests = d.Tokens, d.Requests end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, out, why, short = h.ctx, h.client, h.out, h.why, h.short
    local methodName = h.methodName

    ---------------------------------------------------------------- notifications from the protocol
    if ctx.sync then
        ctx.sync:on("incompatible", function(e)
            if e.mustUpdate == "them" then
                out(("%s runs King's Gambit %s, an older line than yours (%s.x): it can't share the ledger with this version until they update. Type: version"):format(short(e.peer), e.build or "?", e.ourLine))
            else
                out(("%s runs King's Gambit %s, which this version (%s) can't work with: update King's Gambit to share the ledger with them. Type: version"):format(short(e.peer), e.build or "?", e.ours))
            end
            if client:masterLooter() == e.peer then out("They are the Master Looter: you won't see their loot sessions until this is sorted out.") end
        end)
        ctx.sync:on("unreadable", function(e)
            out(("The ledger has moved to format %d, which this version cannot read (it reads %s). Update King's Gambit to see new entries. Type: version"):format(e.format, table.concat(e.readable, ", ")))
        end)
        ctx.sync:on("newerBuild", function(e)
            out(("%s runs King's Gambit %s, newer than yours (%s). An update is available; it is not required."):format(short(e.peer), e.build, e.ours))
        end)
    end
    if ctx.player then
        ctx.player.on("session", function(s)
            out(("Loot! %d item(s) from %s:"):format(#s.items, short(s.host)))
            local tokens = false
            for _, it in ipairs(s.items) do
                local token = Tokens and Tokens.Find(it.link)
                tokens = tokens or token ~= nil
                out(("  %d) %s%s%s"):format(it.id, it.link, token and (" (token: " .. token.token.makes .. ")") or "", c.itemNote(it.link)))
            end
            out("Answer with: need <n>, off <n>, pass <n>, or gift <n> <name>.")
            if tokens then out("For a token, add 'ready' if you can turn it in but the addon can't see it (e.g. bank): need <n> ready.") end
        end)
        ctx.player.on("turn", function(t)
            if t.type == "recipient" and t.player ~= client:me() then
                return out(("%s won item %d as a gift and is choosing who gets it."):format(short(t.player), t.item))
            end
            if not ctx.player:myTurn() then return end
            if t.type == "recipient" then
                return out(("You won item %d as a gift. Who gets it? recipient <name>, or keep (if it suits you), or withdraw yes (a pass)."):format(t.item))
            end
            if t.type == "pick" then
                out("It's your pick! Items you bid on: " .. table.concat(t.options, ", ") .. ".  Use: pick <n>, or skip.")
            else
                out(("Salvage: nobody wanted item %d, and you are the lowest on the list right now, so it is yours to decide. claim [name to gift it to], or decline (the disenchanter takes it)."):format(t.item))
            end
        end)
        ctx.player.on("result", function(r)
            for _, a in ipairs(r.awards) do out(("Item %d: %s won it%s."):format(a.item, short(a.winner), a.to ~= a.winner and (" and gave it to " .. short(a.to)) or "")) end
            for _, d in ipairs(r.de) do out(("Item %d goes to %s to disenchant."):format(d.item, short(d.to))) end
        end)
        ctx.player.on("ack", function(a)
            if a.ok == false then out("Not recorded: " .. why(a.why)) end
        end)
    end
    client:on("lootMethod.changed", function(p)
        local ml = client:masterLooter()
        out(("The loot method is now %s%s."):format(methodName(client:lootMethod()), (client:lootMethod() == "master" and ml) and (" (Master Looter: " .. short(ml) .. ")") or ""))
    end)
    if ctx.host then
        ctx.host.on("phase", function(p)
            if p.phase == "review" then out("Everyone has been through the draft. Review, then 'confirm' to hand the items out and record them.") end
            if p.phase == "cancelled" and p.reason == "lootmethod" then
                out("The loot method (or the Master Looter) changed, so the session was cancelled. Nothing was recorded. Once the raid leader has set Master Looter again, start it with: loot")
            end
        end)
        ctx.host.on("turn", function(t)
            if t.type == "recipient" then
                if t.player == client:me() then
                    return out(("You won item %d as a gift. Who gets it? recipient <name>, or keep (if it suits you), or withdraw yes (a pass)."):format(t.item))
                end
                return out(("%s won item %d as a gift and is choosing who gets it. The draft waits for them (override: count it as their pass)."):format(short(t.player), t.item))
            end
            if t.player == client:me() then
                out(t.type == "pick" and ("Your pick! Items you bid on: " .. table.concat(t.options, ", ") .. ". pick <n> or skip.")
                    or ("Item " .. t.item .. " is offered to you. claim [name] or decline."))
            end
        end)
    end

    if ctx.requests then
        local q = ctx.requests
        q.on("request", function(p)
            local r = p.req
            out(("Request #%d from %s: %s. Reason: %s"):format(r.num, short(r.by), Requests.Describe(r), r.reason))
            out(("Answer with: accept %d, or decline %d <reason>. Both are recorded."):format(r.num, r.num))
        end)
        q.on("received", function(p) out(("%s has your request (#%d) and will answer it."):format(short(p.req.ml), p.req.num or 0)) end)
        q.on("refused", function(p) out(("%s's addon refused the request: %s."):format(short(p.req.ml), why(p.why))) end)
        q.on("unanswered", function(p)
            out(("No answer from %s's addon (they may not have it, or be offline). Ask them in chat."):format(short(p.req.ml)))
        end)
        q.on("decided", function(p)
            local ev = p.ev
            if p.mine then
                if p.accepted then out(("%s accepted your request: %s."):format(short(ev.author), c.describe(ev)))
                else out(("%s declined your request to %s: %s."):format(short(ev.author), ev.data.request, ev.data.declineReason)) end
            elseif p.accepted and ev.data.member == client:me() and ev.author ~= client:me() then
                out("The list changed for you: " .. c.describe(ev) .. ".")
            end
        end)
    end

end
