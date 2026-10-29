-- King's Gambit: the text interface (slash commands). Everything the addon can do, without frames:
-- manage lists, run a loot session as Master Looter, and answer as a player. Output goes through
-- client:print. This is the first usable UI and stays useful alongside the real frames later.
local _, SK = ...
local M = SK:NewModule("Commands")

local WHY = {
    closed = "bidding is closed", ineligible = "you are not eligible for this drop", noitem = "there is no such item",
    badkind = "answer with need, off, gift or pass", badtarget = "name who should get the gift",
    notyourturn = "it is not your turn", noturn = "nothing is waiting for you", badpick = "you didn't bid on that item",
    nosession = "no loot session is running", busy = "a session is already running", notml = "you are not the Master Looter",
    nolist = "no such list", notreview = "the session is not ready to confirm",
}
local function why(w) return WHY[w] or tostring(w) end

local HELP = {
    "King's Gambit commands:",
    "  standings [list] [N]            show the list (default main, top 20)",
    "  create <list> [name]            create a list      add <name> [top|bottom|N]     remove <name>",
    "  move <name> <top|bottom|N> <reason>              undo (the last award)",
    "  loot                            start a session from the open loot window (Master Looter)",
    "  resolve | extend [sec] | confirm | cancel | announce      run the session (Master Looter)",
    "  need|off|pass <item#>   gift <item#> <name>      answer for an item (or: bid <item#> <kind> [name])",
    "  pick <item#> | skip | claim [name] | decline     your turn in the draft or the backstop",
    "  sync                            ledger sync status       check   probe the game client",
}

-- ctx: { client, engine, sync, host (LootNet host), player (LootNet player), selfcheck (optional) }
function M.New(ctx)
    local client, engine = ctx.client, ctx.engine
    local c = { ctx = ctx }
    local function out(text) client:print(text) end

    local function canWrite()
        if not client:inGroup() then return true end
        return (client:rankOf(client:me()) or 0) >= 1
    end

    local function name(n) return n and (client:normalize(n)) end
    local function short(n) return n and (n:gsub("%-.*$", "")) end
    local function list(id) return engine:Get(id or "main") end

    local function append(listId, type_, data)
        if not canWrite() then out("Only the raid leader or an assistant can change a list."); return end
        local ev, err = engine:Append(listId, type_, data)
        if not ev then out("Not recorded: " .. why(err)); return end
        return ev
    end

    -- A running session on this machine (we are the Master Looter), if any.
    local function hosting()
        local s = ctx.host and ctx.host.session
        if s and s.phase ~= "done" and s.phase ~= "cancelled" then return s end
    end

    local cmds = {}

    function cmds.help() for _, l in ipairs(HELP) do out(l) end end

    function cmds.standings(args)
        local id, n = args:match("^(%S*)%s*(%d*)$")
        id = (id ~= "" and id) or "main"
        local chain = list(id)
        if not chain then return out("No list called '" .. id .. "'. Create one with: create " .. id) end
        local order = chain.state.order
        out(("%s: %d on the list, %d events, head %s"):format(id, #order, #chain.events, chain.head:sub(1, 8)))
        for i = 1, math.min(#order, tonumber(n) or 20) do
            local m = chain.state.members[order[i]]
            out(("%2d. %s%s  (wins %d)"):format(i, short(order[i]), order[i] == client:me() and "  <- you" or "", m.wins))
        end
    end

    function cmds.create(args)
        local id, title = args:match("^(%S+)%s*(.-)$")
        if not id then return out("create <list> [name]") end
        if not canWrite() then return out("Only the raid leader or an assistant can create a list.") end
        local chain, err = engine:CreateList(id, title ~= "" and title or id)
        out(chain and ("Created list '" .. id .. "'.") or ("Not created: " .. why(err)))
    end

    function cmds.add(args)
        local who, pos = args:match("^(%S+)%s*(%S*)$")
        if not who then return out("add <name> [top|bottom|N]") end
        local data = { member = name(who) }
        if pos ~= "" then data.pos = tonumber(pos) or pos end
        local ev = append("main", "AddMember", data)
        if ev then out(short(data.member) .. " added.") end
    end

    function cmds.remove(args)
        if args == "" then return out("remove <name>") end
        local ev = append("main", "RemoveMember", { member = name(args) })
        if ev then out(short(name(args)) .. " removed.") end
    end

    function cmds.move(args)
        local who, pos, reason = args:match("^(%S+)%s+(%S+)%s+(.+)$")
        if not who then return out("move <name> <top|bottom|N> <reason>  (a reason is required and is part of the record)") end
        local ev = append("main", "MovePlayer", { member = name(who), pos = tonumber(pos) or pos, reason = reason })
        if ev then out(short(name(who)) .. " moved. " .. ("This correction is recorded with your reason.")) end
    end

    function cmds.undo()
        local chain = list("main")
        local top = chain and chain.state.undo[#chain.state.undo]
        if not top then return out("Nothing can be undone (only the most recent awards, and only until something else moves the list).") end
        local ev = append("main", "Revert", { target = top.id })
        if ev then out("The last award was undone. The undo is recorded in the history.") end
    end

    ---------------------------------------------------------------- Master Looter
    function cmds.loot()
        if not ctx.host then return out("Loot sessions are not available here.") end
        if not client:isMasterLooter() then
            return out("Only the Master Looter can start a loot session. Set the loot method to Master Looter first.")
        end
        local slots = client:lootSlots()
        if #slots == 0 then return out("Open the loot window on the corpse first.") end
        local items = {}
        for i, s in ipairs(slots) do items[i] = { link = s.link, slot = s.slot } end
        local ok, err = ctx.host:start(items)
        if not ok then return out("Could not start: " .. why(err)) end
        local s = ctx.host.session
        out(("Loot session started for %d item(s). %d eligible. Players answer in their addon or by whisper."):format(#s.items, #s.eligibleList))
        for _, it in ipairs(s.items) do out(("  %d) %s"):format(it.id, it.link)) end
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
        if not ok then return out("Not ready to confirm: " .. why(failures)) end
        for _, f in ipairs(failures) do
            out(("Could not hand over %s (%s: %s). It was NOT recorded; give it manually."):format(f.item.link, f.stage, tostring(f.reason)))
        end
        out("Confirmed and recorded.")
    end

    function cmds.cancel()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        s:cancel()
        out("Session cancelled. Nothing was recorded.")
    end

    ---------------------------------------------------------------- answering (as a player or as the host)
    local function act(fn_host, fn_player)
        local s = hosting()
        if s then
            local ok, err = fn_host(s)
            if ok == false or ok == nil then out("Not recorded: " .. why(err)) end
            return
        end
        if ctx.player and ctx.player.session then
            local ok, err = fn_player(ctx.player)
            if not ok then out("Not sent: " .. why(err)) end
            return
        end
        out("There is no loot session to answer.")
    end

    local function bid(item, kind, to)
        item = tonumber(item)
        if not item then return out("Which item? Use its number, e.g. need 1") end
        act(function(s) return s:bid(client:me(), item, kind, { to = to }) end,
            function(p) return p:bid(item, kind, to) end)
    end

    function cmds.bid(args)
        local item, kind, to = args:match("^(%d+)%s+(%a+)%s*(%S*)$")
        if not item then return out("bid <item#> <need|off|gift|pass> [name]") end
        bid(item, kind:lower(), to ~= "" and to or nil)
    end
    for _, kind in ipairs { "need", "off", "pass" } do
        cmds[kind] = function(args)
            local item = args:match("^(%d+)") or (#(hosting() and hosting().items or (ctx.player and ctx.player.session and ctx.player.session.items) or {}) == 1 and "1")
            bid(item, kind)
        end
    end
    function cmds.gift(args)
        local item, to = args:match("^(%d+)%s+(%S+)$")
        if not item then return out("gift <item#> <name>") end
        bid(item, "gift", to)
    end

    function cmds.pick(args)
        local item = tonumber(args)
        if not item then return out("pick <item#>") end
        act(function(s) return s:pick(client:me(), item) end, function(p) return p:pick(item) end)
    end
    function cmds.skip() act(function(s) return s:skip(client:me()) end, function(p) return p:skip() end) end
    function cmds.claim(args)
        local to = args ~= "" and args or nil
        act(function(s) return s:claimItem(client:me(), to and { to = to } or nil) end, function(p) return p:claim(to) end)
    end
    function cmds.decline() act(function(s) return s:decline(client:me()) end, function(p) return p:decline() end) end

    ---------------------------------------------------------------- misc
    function cmds.sync()
        if not ctx.sync then return out("Sync is not running.") end
        local st = ctx.sync:status()
        out(("Sync: %d message(s) waiting%s, %d rejected, %d fork(s) resolved%s."):format(st.pending,
            st.blocked and (" (" .. st.blocked .. ")") or "", st.rejected, st.forksResolved, st.resolvingForks and ", resolving a fork now" or ""))
        for id, chain in pairs(engine.chains) do out(("  %s: %d events, head %s%s"):format(id, #chain.events, chain.head:sub(1, 8), engine:IsVerified(id) and "" or " (still verifying)")) end
        for id, p in pairs(engine.problems) do out(("  %s: FAILED verification at event %s (%s)"):format(id, tostring(p.index), tostring(p.reason))) end
    end

    function cmds.check()
        if ctx.selfcheck then ctx.selfcheck.Run(client) else out("Self-check is not available.") end
    end

    ---------------------------------------------------------------- notifications from the protocol
    if ctx.player then
        ctx.player.on("session", function(s)
            out(("Loot! %d item(s) from %s:"):format(#s.items, short(s.host)))
            for _, it in ipairs(s.items) do out(("  %d) %s"):format(it.id, it.link)) end
            out("Answer with: need <n>, off <n>, pass <n>, or gift <n> <name>.")
        end)
        ctx.player.on("turn", function(t)
            if not ctx.player:myTurn() then return end
            if t.type == "pick" then
                out("It's your pick! Items you bid on: " .. table.concat(t.options, ", ") .. ".  Use: pick <n>, or skip.")
            else
                out(("Item %d is offered to you from the bottom up. claim [name to gift it to], or decline."):format(t.item))
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
    if ctx.host then
        ctx.host.on("phase", function(p)
            if p.phase == "review" then out("Everyone has been through the draft. Review, then 'confirm' to hand the items out and record them.") end
        end)
        ctx.host.on("turn", function(t)
            if t.player == client:me() then
                out(t.type == "pick" and ("Your pick! Items you bid on: " .. table.concat(t.options, ", ") .. ". pick <n> or skip.")
                    or ("Item " .. t.item .. " is offered to you. claim [name] or decline."))
            end
        end)
    end

    function c.handle(msg)
        local cmd, args = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
        cmd = cmd:lower()
        if cmd == "" or cmd == "show" then cmd = "standings" end
        local fn = cmds[cmd]
        if not fn then return out("Unknown command '" .. cmd .. "'. Type help.") end
        fn(args)
    end

    c.commands = cmds
    return c
end
