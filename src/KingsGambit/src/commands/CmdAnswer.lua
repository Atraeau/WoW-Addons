-- King's Gambit: the text commands for answering for items, as a player or as the host: need, off, gift, pass, ranking, turns, salvage, and how an item fits. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local ItemFit, Loot, Tokens
local M = SK:NewModule("CmdAnswer", { "ItemFit", "Loot", "Tokens?" }, function(d) ItemFit, Loot, Tokens = d.ItemFit, d.Loot, d.Tokens end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, engine, out, why, short, cur, list, hosting = h.ctx, h.client, h.engine, h.out, h.why, h.short, h.cur, h.list, h.hosting

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

    local function myClass()
        for _, m in ipairs(client:roster()) do if m.name == client:me() then return m.class end end
    end
    -- The link of item n in the session this machine runs or is answering.
    local function linkOf(item)
        local s = hosting()
        local items = s and s.items or (ctx.player and ctx.player.session and ctx.player.session.items) or {}
        return items[item] and items[item].link
    end

    ---------------------------------------------------------------- who may bid, and how an item fits
    local char = client:storage().char
    local function myFit(link)
        local rule, suits = ItemFit.Rules(engine, link)
        return ItemFit.Describe(client, link, Tokens and Tokens.Find(link), rule, suits)
    end
    -- May this player bid need or off-spec on item n of the running session? (The window grays those buttons out when not.)
    -- Returns true, or false and why (cantequip, nostats, wrongclass).
    function c.mayHave(item)
        local link = linkOf(item)
        if not link then return true end
        return Loot.MayHave(myFit(link), myClass())
    end

    -- Does item n suit this spec, so that a Need on it is a main-spec Need? (The window grays Need out when not; the Master Looter enforces it too.)
    function c.needOk(item, spec)
        local link = linkOf(item)
        if not link then return true end
        return ItemFit.NeedOk(myFit(link), myClass(), spec)
    end

    -- Who in the group may be given item n: those whose class may have it (the same rule the session applies to a gift's recipient), never yourself.
    -- The window offers only these, so a gift to someone who can't have it can't be chosen. Names as the roster has them.
    function c.giftTargets(item)
        local link = linkOf(item)
        local fit = link and myFit(link)
        local out = {}
        for _, m in ipairs(client:roster()) do
            if m.name ~= client:me() and (not fit or Loot.MayHave(fit, m.class)) then out[#out + 1] = m.name end
        end
        return out
    end

    -- "  [for: Priest, Mage]" when the item is restricted, plus suggestions when this player wants hints.
    function c.itemNote(link)
        local fit = myFit(link)
        if not fit then return "" end
        local parts = {}
        local classes = ItemFit.ClassList(fit)
        if classes then parts[#parts + 1] = "for: " .. classes .. (fit.rule and " (guild rule)" or "") end
        local mine = myClass()
        local may, mayWhy = Loot.MayHave(fit, mine)
        if not may then
            parts[#parts + 1] = mayWhy == "cantequip" and "your class can't wear or wield it (you can gift it)"
                or mayWhy == "nostats" and "its stats don't help your class (you can gift it, or ask: request eligible <item#> <reason>)"
                or "not for your class yet (you can gift it, or ask: request eligible <item#> <reason>)"
        end
        if char.hints then
            local suits = ItemFit.SuitsText(fit)
            if suits then parts[#parts + 1] = "suits: " .. suits .. (fit.suits and (" (%s's call: %s)"):format(short(fit.suits.by), fit.suits.reason or "no reason given") or "") end
            local class = myClass()
            if class then
                local spec = char.spec and char.spec.main
                local f = ItemFit.ForPlayer(fit, class, spec)
                if not f.usable then parts[#parts + 1] = "you can't use it"
                elseif f.rating then parts[#parts + 1] = ("your fit: %s (%s)"):format(f.rating, f.spec) end
                local off = char.spec and char.spec.off
                if f.usable and off then
                    local g = ItemFit.ForPlayer(fit, class, off)
                    if g.rating then parts[#parts + 1] = ("off-spec: %s"):format(g.rating) end
                end
            end
        end
        return #parts > 0 and ("  [" .. table.concat(parts, "; ") .. "]") or ""
    end

    -- declared: the player says they can turn a token in (the addon can't always see the bank).
    local function bid(item, kind, to, declared)
        item = tonumber(item)
        if not item then return out("Which item? Use its number, e.g. need 1") end
        -- Only bids the session would take are sent: an item your class may not have takes a pass, a gift to
        -- someone who may have it, or a request.
        if (kind == "need" or kind == "off") and linkOf(item) then
            local may, mayWhy = Loot.MayHave(myFit(linkOf(item)), myClass())
            if not may then
                out(("Item %d: %s."):format(item, mayWhy == "cantequip" and "your class can't wear or wield it, so you can pass or gift it"
                    or mayWhy == "nostats" and "its stats don't help your class, so you can pass or gift it"
                    or "your class isn't eligible for it, so you can pass or gift it"))
                if mayWhy == "wrongclass" or mayWhy == "nostats" then out(("If you think you should be: request eligible %d <reason>"):format(item)) end
                return
            end
        end
        local token = Tokens and Tokens.Find(linkOf(item))
        local ready
        if token and kind ~= "pass" then
            ready = Tokens.Mine(client, token, myClass(), declared)
            out(("Item %d is a token (%s). Your readiness, shown to the raid as a hint: %s."):format(item, token.token.makes, Tokens.Label(ready)))
        end
        act(function(s) return s:bid(client:me(), item, kind, { to = to, ready = ready }) end,
            function(p) return p:bid(item, kind, to, nil, { ready = ready }) end)
    end

    function cmds.bid(args)
        local item, kind, to = args:match("^(%d+)%s+(%a+)%s*(%S*)$")
        if not item then return out("bid <item#> <need|off|gift|pass> [name]") end
        bid(item, kind:lower(), to ~= "" and to or nil)
    end
    for _, kind in ipairs { "need", "off", "pass" } do
        cmds[kind] = function(args)
            local item = args:match("^(%d+)") or (#(hosting() and hosting().items or (ctx.player and ctx.player.session and ctx.player.session.items) or {}) == 1 and "1")
            bid(item, kind, nil, args:lower():find("ready", 1, true) ~= nil)
        end
    end
    function cmds.gift(args)
        local item, to = args:match("^(%d+)%s*(%S*)$")
        if not item then return out("gift <item#> [name]   (leave the name out to choose later, if you win)") end
        bid(item, "gift", to ~= "" and to or nil)
    end

    function cmds.ready(args)
        local item = tonumber(args)
        if not item then return out("ready <item#>") end
        local token = Tokens and Tokens.Find(linkOf(item))
        if not token then return out("Item " .. item .. " is not a token.") end
        local rows = {}
        local s = hosting()
        if s then rows = s:readiness(item) or {}
        elseif ctx.player and ctx.player.session then
            local answers = ctx.player.session.answers
            local main = list(cur())
            for _, n in ipairs(main and main.state.order or {}) do
                local a = answers[n] and answers[n][item]
                if a and a.kind ~= "pass" then rows[#rows + 1] = { player = n, kind = a.kind, ready = a.ready } end
            end
        end
        out(("%s (makes: %s). Wanted by, in list order:"):format(linkOf(item), token.token.makes))
        if #rows == 0 then out("  nobody yet") end
        for _, r in ipairs(rows) do out(("  %s (%s): %s"):format(short(r.player), r.kind, Tokens.Label(r.ready))) end
        out("Readiness is a hint: materials in someone's bank can't be seen.")
    end

    -- rank 2 1 3: put the items you want in order, most wanted first. Each must already be answered need, off or gift. When you want two or more items
    -- the Master Looter's session waits for this (see Loot's requireRanking); on your turn your highest-ranked item still available is taken for you.
    function cmds.rank(args)
        local ids = {}
        for n in args:gmatch("%d+") do ids[#ids + 1] = tonumber(n) end
        if #ids == 0 then return out("rank <item#> [<item#> ...]   (the items you want, most wanted first; answer need/off/gift for them first)") end
        local s = hosting()
        local mine = s and s.bids[client:me()] or (ctx.player and ctx.player.session and ctx.player.session.mine) or nil
        if not mine then return out("There is no loot session to answer.") end
        local seen = {}
        for _, id in ipairs(ids) do
            local b = mine[id]
            if not b or b.kind == "pass" then return out(("Item %d: answer need, off or gift for it first."):format(id)) end
            if seen[id] then return out(("Item %d is listed twice."):format(id)) end
            seen[id] = true
        end
        for k, id in ipairs(ids) do
            local b = mine[id]
            act(function(session) return session:bid(client:me(), id, b.kind, { to = b.to, ready = b.ready, rank = k }) end,
                function(p) return p:bid(id, b.kind, b.to, nil, { ready = b.ready, rank = k }) end)
        end
    end

    function cmds.pick(args)
        local item = tonumber(args)
        if not item then return out("pick <item#>") end
        act(function(s) return s:pick(client:me(), item) end, function(p) return p:pick(item) end)
    end
    function cmds.skip() act(function(s) return s:skip(client:me()) end, function(p) return p:skip() end) end
    function cmds.recipient(args)
        if args == "" then return out("recipient <name>   (who gets the gift you won)") end
        act(function(s) return s:chooseRecipient(client:me(), args) end, function(p) return p:recipient(args) end)
    end
    -- Master Looter: the gifter hasn't said who gets it; downgrade their win to a pass and carry on.
    function cmds.override()
        local s = hosting()
        if not s then return out("No loot session is running.") end
        local t = s.turn
        if not (t and t.type == "recipient") then return out("Nothing to override: no one is choosing a gift recipient.") end
        local who = short(t.player)
        local ok, err = s:overrideGift()
        if not ok then return out("Not done: " .. why(err)) end
        out(("%s's gift is treated as a pass (it is recorded: they didn't say who gets it). The draft goes on."):format(who))
    end
    function cmds.keep() act(function(s) return s:keepGift(client:me()) end, function(p) return p:keep() end) end
    function cmds.withdraw(args)
        if args:lower() ~= "yes" then
            return out("This gives up your win and counts as a pass; you keep your place on the list. To go ahead: withdraw yes")
        end
        act(function(s) return s:withdrawGift(client:me()) end, function(p) return p:withdraw() end)
    end
    function cmds.claim(args)
        local to = args ~= "" and args or nil
        act(function(s) return s:claimItem(client:me(), to and { to = to } or nil) end, function(p) return p:claim(to) end)
    end

    -- for the files installed after this one
    h.act = act
    h.char = char
    h.linkOf = linkOf
    h.myClass = myClass
    h.myFit = myFit
end
