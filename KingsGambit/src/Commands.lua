-- King's Gambit: the text interface (slash commands). Everything the addon can do, without frames:
-- manage lists, run a loot session as Master Looter, and answer as a player. Output goes through
-- client:print. This is the first usable UI and stays useful alongside the real frames later.
local _, SK = ...
local Standings, ItemFit, Loot, Tokens, Requests
local M = SK:NewModule("Commands", { "Standings", "ItemFit", "Loot", "Tokens?", "Requests?" }, function(d)
    Standings, ItemFit, Loot, Tokens, Requests = d.Standings, d.ItemFit, d.Loot, d.Tokens, d.Requests
end)

local WHY = {
    closed = "bidding is closed", ineligible = "you are not eligible for this drop", noitem = "there is no such item",
    badkind = "answer with need, off, gift or pass", badtarget = "name who should get the gift",
    notyourturn = "it is not your turn", noturn = "nothing is waiting for you", badpick = "you didn't bid on that item",
    nosession = "no loot session is running", busy = "a session is already running", notml = "you are not the Master Looter",
    nolist = "no such list", notreview = "the session is not ready to confirm",
    cantkeep = "you can't keep it: it isn't for your class. Name who gets it, or withdraw", unreachable = "they are out of loot range",
    norecipient = "no one was named to receive it",
    nodisenchanter = "no disenchanter is designated for this raid yet. Choose who disenchants what nobody wants: disenchanter <name>",
    -- who may write (ledger authority)
    notauthorized = "you are not an officer, and no raid is open with you as its Master Looter",
    expired = "your raid has ended, and with it your right to write to the list",
    notofficer = "only an officer can do that", notguildmaster = "only the guild master can do that",
    raidbusy = "that raid already has a different Master Looter", raidended = "that raid has already ended",
    notactive = "no such raid is running", badminutes = "the raid can last at most 24 hours",
    -- requests
    noraid = "no raid is open, so there is no Master Looter to ask",
    whichraid = "more than one raid is running: name the Master Looter, e.g. request @Name ...",
    self = "you are the Master Looter: make the change directly",
    badrequest = "the request is missing something (see help)", noreason = "a reason is required (it goes in the record)",
    longreason = "the reason is too long (200 characters at most)",
    toomany = "you already have 3 requests waiting: wait for the Master Looter to answer them",
    norequest = "there is no waiting request with that number", noaward = "they have no award to change",
    notrevertible = "that award can't be undone directly any more (the list has moved since): ask for a move instead",
    notrestricted = "that item isn't restricted to classes, so everyone may already bid on it",
    cantequip = "that class can't wear or wield that item", cantequipto = "the player you are gifting to can't wear or wield that item",
    alreadyeligible = "that class may already bid on it",
    badpos = "a position is top, bottom or a number",
    -- who may bid on an item
    wrongclass = "that item is for other classes (if you think your class should be eligible: request eligible <item#> <reason>)",
    wrongclassto = "the player you are gifting to is not one of the classes the item is for",
    baditemrule = "that rule is not valid (an item id, the classes, and a reason)",
    baditemsuits = "that override is not valid (an item id, the roles, and a reason)",
}
local function why(w) return WHY[w] or tostring(w) end

local HELP = {
    "King's Gambit commands:",
    "  standings [list] [N]            show the list (default main, top 20)",
    "  create <list> [name]            create a list      add <name> [top|bottom|N]     remove <name>",
    "  move <name> <top|bottom|N> <reason>              undo yes (the last award; it asks first)",
    "  loot                            start a session from the open loot window (Master Looter)",
    "  resolve | extend [sec] | confirm | cancel | announce      run the session (Master Looter)",
    "  need|off|pass <item#>   gift <item#> <name>      answer for an item (or: bid <item#> <kind> [name])",
    "  need <item#> ready              a token: you can turn it in (e.g. materials in your bank)",
    "  ready <item#>                   who wants a token, and how ready each one is (a hint, never enforced)",
    "  pick <item#> | skip | claim [name] | decline     your turn in the draft or the salvage round",
    "  gift <item#> [name]             you may leave the name out and choose later, if you win it",
    "  recipient <name> | keep | withdraw yes           after winning a gift with no name: who gets it, keep it, or",
    "                                  give it up (counts as a pass)",
    "  override                        Master Looter: the gift winner won't say who gets it; count it as their pass",
    "  raid                            who is Master Looter of the raids that are open",
    "  raid open [name] [hours]        open a raid with a Master Looter (officers; default: the loot master, 4 h)",
    "  raid close [anyway]             end your raid (its Master Looter)    raid extend [hours]   raid revoke [name]",
    "  disenchanter [name]             choose who disenchants what nobody wants, for your raid (its Master Looter);",
    "                                  required before loot can be handed out. Without a name: who it is.",
    "  officers [set <names...>]       who are officers (the guild master sets them)",
    "  request move <name> <top|bottom|N> <reason>     ask the Master Looter to change the list during a raid;",
    "  request undo|remove <name> <reason>             also: add <name> [pos] <reason>, award <name> <item> <reason>,",
    "  request gift <name> <to> <reason>               (the item they won went to someone else)",
    "  request eligible <item> <reason>                ask for your class to be allowed to bid on an item, from now on",
    "  requests                        waiting requests and recent decisions",
    "  accept <n> | decline <n> <reason>                answer a request (Master Looter)",
    "  history [N]                     the last changes to the list, with who, why, and at whose request",
    "  eligible <item> <classes|any> <reason>   set which classes may bid on an item, before it drops (officers)",
    "  eligible [item]                 show the rule for an item, or every rule   (item: a link or an item id)",
    "  suits <item> <roles|auto> <reason>   override who an item suits (officers): tank, melee, hunter, caster, healer",
    "  spec <main> [off]               your specs, for fit hints     hints on|off   show how items fit you (default off)",
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

    -- Master Looters of the raids open now, as text.
    local function mls()
        local names = {}
        for _, r in ipairs(engine:ActiveRaids()) do names[#names + 1] = short(r.ml) end
        return table.concat(names, " and ")
    end

    -- asRequest (optional): the same change as a request command, offered when a raid is running.
    local function append(listId, type_, data, asRequest)
        if not engine:LedgerId() then
            if not canWrite() then out("Only the raid leader or an assistant can change a list."); return end
        else
            local ok, reason = engine:MayWrite()
            if not ok and reason == "duringraid" then
                out(("A raid is running: only its Master Looter (%s) writes to the list until it is closed."):format(mls()))
                if asRequest then out("Send it to them as a request: request " .. asRequest) end
                return
            elseif not ok then
                out("Not recorded: " .. why(reason)); return
            end
        end
        local ev, err = engine:Append(listId, type_, data)
        if not ev then out("Not recorded: " .. why(err)); return end
        return ev
    end

    -- A running session on this machine (we are the Master Looter), if any.
    local function hosting()
        local s = ctx.host and ctx.host.session
        if s and s.phase ~= "done" and s.phase ~= "cancelled" then return s end
    end

    -- A position as typed ("top", "bottom" or a number) becomes an anchor: "above whoever is there now".
    -- Numbers are never stored, because their meaning would shift as other raids' events arrive.
    function c.where(listId, pos, moving)
        local chain = list(listId)
        local anchor = Standings.Anchor(chain and chain.state, pos, moving)
        if not anchor then return nil, "Position must be top, bottom or a number." end
        return anchor
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
        if pos ~= "" then
            local where, err = c.where("main", pos, nil)
            if not where then return out(err) end
            for k, v in pairs(where) do data[k] = v end
        end
        local ev = append("main", "AddMember", data, ("add %s %s<reason>"):format(who, pos ~= "" and (pos .. " ") or ""))
        if ev then out(short(data.member) .. " added.") end
    end

    function cmds.remove(args)
        if args == "" then return out("remove <name>") end
        local ev = append("main", "RemoveMember", { member = name(args) }, ("remove %s <reason>"):format(args))
        if ev then out(short(name(args)) .. " removed.") end
    end

    function cmds.move(args)
        local who, pos, reason = args:match("^(%S+)%s+(%S+)%s+(.+)$")
        if not who then return out("move <name> <top|bottom|N> <reason>  (a reason is required and is part of the record)") end
        local where, err = c.where("main", pos, name(who))
        if not where then return out(err) end
        local data = { member = name(who), reason = reason }
        for k, v in pairs(where) do data[k] = v end
        local ev = append("main", "MovePlayer", data, ("move %s %s %s"):format(who, pos, reason))
        if ev then out(short(name(who)) .. " moved. " .. ("This correction is recorded with your reason.")) end
    end

    function cmds.undo(args)
        local chain = list("main")
        local stack = chain and chain.state.undo[engine:MyChain()]
        local top = stack and stack[#stack]
        if not top then
            out("Nothing can be undone (only your own most recent awards, and only until something else moves the list).")
            if #engine:ActiveRaids() > 0 then out("To undo someone else's award during a raid: request undo <name> <reason>") end
            return
        end
        -- Undo changes the list, so it asks first: say what would be undone, and go ahead only on "undo yes".
        if args:lower() ~= "yes" then
            local a = chain.state.awards[top.id]
            out(("This would undo your most recent award%s. The undo is recorded in the history (nothing is erased)."):format(
                a and (": " .. short(a.member) .. " won " .. tostring(a.item)) or ""))
            return out("To go ahead: undo yes")
        end
        local ev = append("main", "Revert", { target = top.id })
        if ev then out("The last award was undone. The undo is recorded in the history.") end
    end

    ---------------------------------------------------------------- Master Looter
    function cmds.loot()
        if not ctx.host then return out("Loot sessions are not available here.") end
        if not client:isMasterLooter() then
            return out("Only the Master Looter can start a loot session. Set the loot method to Master Looter first.")
        end
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
                    or "your class isn't eligible for it, so you can pass or gift it"))
                if mayWhy == "wrongclass" then out(("If you think you should be: request eligible %d <reason>"):format(item)) end
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
            local main = list("main")
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
        local raids = engine:ActiveRaids()
        if #raids == 0 then
            out("No raid is open. Officers write to the list directly; an officer opens a raid with: raid open <Master Looter>")
            return
        end
        for _, r in ipairs(raids) do
            out(("Raid %s: %s is Master Looter for %d more minute(s) (opened by %s). Only they write to the list."):format(
                r.id, short(r.ml), minutesLeft(r), short(r.by)))
        end
    end
    function raid.open(args)
        local who, hours = args:match("^(%a[^%s]*)%s*(%S*)$")
        if not who then hours = args:match("^(%S*)$") end
        if not engine:IsOfficer() then return out("Only an officer can open a raid.") end
        local ml = who and name(who) or client:masterLooter() or client:me()
        local h = tonumber(hours ~= "" and hours or nil) or 4
        local id = ("%s-%d"):format(short(ml), client:serverTime())
        if writeAuthority("Elevate", { raid = id, ml = ml, minutes = math.floor(h * 60) }) then
            out(("Raid open: %s is Master Looter for %s hour(s). Until it is closed, only they write to the list;"):format(short(ml), h))
            out("everyone else, officers included, sends them requests (request ...). Close it with: raid close")
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
        if not fn then return out("raid [open [name] [hours] | close | extend [name] [hours] | revoke [name]]") end
        fn(rest)
    end

    function cmds.officers(args)
        local sub, rest = args:match("^(%S*)%s*(.-)$")
        local a = engine:View().auth
        if sub:lower() ~= "set" then
            local names = {}
            for n in pairs(a.officers) do names[#names + 1] = short(n) end
            table.sort(names)
            out(("Guild master: %s. Officers: %s."):format(short(a.gm) or "none (no ledger yet)", #names > 0 and table.concat(names, ", ") or "none"))
            return
        end
        local names = {}
        for n in rest:gmatch("%S+") do names[#names + 1] = name(n) end
        if writeAuthority("SetOfficers", { names = names }) then
            out(#names > 0 and ("Officers are now: " .. rest .. ".") or "There are no officers now (only the guild master).")
        end
    end

    ---------------------------------------------------------------- requests (the dispute path)
    local REQUEST_USAGE = {
        move = "request move <name> <top|bottom|N> <reason>", undo = "request undo <name> <reason>",
        add = "request add <name> [top|bottom|N] <reason>", remove = "request remove <name> <reason>",
        award = "request award <name> <item> <reason>", gift = "request gift <name> <to> <reason>",
        eligible = "request eligible <item or item#> <reason>",
    }
    local function isPos(p) return p == "top" or p == "bottom" or (tonumber(p) ~= nil) end

    -- Parse "request ..." into a request table, or nil + usage text.
    function c.parseRequest(args)
        local target, rest = args:match("^@(%S+)%s+(.*)$")
        args = rest or args
        local kind, body = args:match("^(%a+)%s*(.-)$")
        kind = kind and kind:lower()
        if not (kind and Requests.KINDS[kind]) then return nil, nil, "request <move|undo|add|remove|award|gift|eligible> ...  (see help)" end
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
        elseif kind == "gift" then
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
        if ev.type == "Award" then text = ("%s won %s%s"):format(who, tostring(d.item), d.to and d.to ~= d.member and (" (for " .. short(d.to) .. ")") or "")
        elseif ev.type == "MovePlayer" then text = ("%s moved %s to %s"):format(by, who, d.to or ("just above " .. short(d.above)))
        elseif ev.type == "AddMember" then text = ("%s added %s"):format(by, who)
        elseif ev.type == "RemoveMember" then text = ("%s removed %s"):format(by, who)
        elseif ev.type == "Revert" then text = ("%s undid %s"):format(by, who and (who .. "'s award") or "an award")
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
            if ev.list == "main" or ev.type == "Declined" or ev.type == "ItemClasses" or ev.type == "ItemSuits" then rows[#rows + 1] = ev end
        end
        -- who disenchants is a raid decision, not a list change, but it belongs in the same history
        for _, ev in ipairs(engine:View().authApplied) do
            if ev.type == "SetDisenchanter" then rows[#rows + 1] = ev end
        end
        local order = {}
        for i, ev in ipairs(rows) do order[ev] = i end
        table.sort(rows, function(x, y) if x.ts ~= y.ts then return x.ts < y.ts end return order[x] < order[y] end)
        if #rows == 0 then return out("Nothing has happened on the list yet.") end
        out(("The last %d change(s) to the list:"):format(math.min(n, #rows)))
        for i = math.max(1, #rows - n + 1), #rows do out("  " .. c.describe(rows[i])) end
    end

    local CLASS_WORDS = {}
    for token, n in pairs(ItemFit.CLASS_NAMES) do CLASS_WORDS[n:lower()] = token end

    local function ruleText(id, rule, name)
        local names = ItemFit.ClassList({ classes = rule.classes }) or "any class"
        return ("%s: %s. Set by %s: %s"):format(name or ("item " .. id), names, short(rule.by), rule.reason)
    end
    local function ruleName(rule)
        local ev = engine.store.byId[rule.id]
        return ev and ev.data.name
    end

    -- eligible                                  every rule
    -- eligible <item>                           the rule for one item
    -- eligible <item> <classes|any> <reason>    set it (classes joined with commas: warrior,rogue,hunter)
    function cmds.eligible(args)
        if args == "" then
            local ids = {}
            for id in pairs(engine:ItemRules()) do ids[#ids + 1] = id end
            table.sort(ids)
            if #ids == 0 then return out("No item rules yet. Set one with: eligible <item> <classes|any> <reason>") end
            for _, id in ipairs(ids) do
                local rule = engine:ItemRule(id)
                out("  " .. ruleText(id, rule, ruleName(rule)))
            end
            return
        end
        local link, rest = args:match("^(|c.-|r)%s*(.-)$")
        if not link then link, rest = args:match("^(%S+)%s*(.-)$") end
        local id = ItemFit.ItemId(link)
        if not id then return out("Which item? Shift-click it into the command, or give its item id.") end
        local itemName = link:match("%[(.-)%]")
        if rest == "" then
            local rule = engine:ItemRule(id)
            if not rule then return out("No rule for item " .. id .. ": the item itself decides (its 'Classes:' line, if any).") end
            return out(ruleText(id, rule, ruleName(rule)))
        end
        local list, reason = rest:match("^(%S+)%s+(.+)$")
        if not list then return out("eligible <item> <classes|any> <reason>  (a reason is required: it goes in the record)") end
        local classes = {}
        if list:lower() ~= "any" then
            for word in list:gmatch("[^,]+") do
                local token = CLASS_WORDS[word:lower()]
                if not token then return out("Unknown class '" .. word .. "'. Classes: warrior, paladin, hunter, rogue, priest, shaman, mage, warlock, druid, or any.") end
                classes[#classes + 1] = token
            end
        end
        local ok, reasonWhy = engine:MayWrite()
        if not ok then
            if reasonWhy == "duringraid" then
                return out(("A raid is running: only its Master Looter (%s) writes now. Set the rule after the raid, or ask them."):format(mls()))
            end
            return out("Not recorded: " .. why(reasonWhy))
        end
        local ev, err = engine:Write("ItemClasses", { item = id, classes = classes, reason = reason, name = itemName })
        if not ev then return out("Not recorded: " .. why(err)) end
        out("Recorded. " .. ruleText(id, engine:ItemRule(id), itemName) .. ". When it drops, only these classes can bid in the drafts.")
    end

    -- suits <item> <roles|auto> <reason>: override the heuristic's judgment of who an item suits (officers),
    -- e.g. "suits 18820 caster the Talisman is for damage casters". "auto" goes back to the heuristic.
    -- suits <item>: what the heuristic says, and any override.
    local ROLE_WORDS = { tank = true, melee = true, hunter = true, caster = true, healer = true }
    function cmds.suits(args)
        local link, rest = args:match("^(|c.-|r)%s*(.-)$")
        if not link then link, rest = args:match("^(%S+)%s*(.-)$") end
        local id = ItemFit.ItemId(link)
        if not id then return out("suits <item> <roles|auto> <reason>  (item: a link or an item id)") end
        local itemName = link:match("%[(.-)%]")
        if rest == "" then
            local o = engine:ItemSuits(id)
            if o then out(("Officer's call for %s: %s. Set by %s: %s"):format(itemName or ("item " .. id), table.concat(o.roles, ", "), short(o.by), o.reason)) end
            local fit = myFit(link)
            local text = fit and ItemFit.SuitsText(fit)
            if not o then out(("The addon's judgment for %s: %s."):format(itemName or ("item " .. id), text or "its stats say nothing (an officer can say: suits <item> <roles> <reason>)")) end
            return
        end
        local list, reason = rest:match("^(%S+)%s+(.+)$")
        if not list then return out("suits <item> <roles|auto> <reason>  (a reason is required: it goes in the record)") end
        local roles = {}
        if list:lower() ~= "auto" then
            for word in list:gmatch("[^,]+") do
                if not ROLE_WORDS[word:lower()] then return out("Unknown role '" .. word .. "'. Roles: tank, melee, hunter, caster, healer, or auto.") end
                roles[#roles + 1] = word:lower()
            end
        end
        local ok, reasonWhy = engine:MayWrite()
        if not ok then
            if reasonWhy == "duringraid" then
                return out(("A raid is running: only its Master Looter (%s) writes now. Set it after the raid, or ask them."):format(mls()))
            end
            return out("Not recorded: " .. why(reasonWhy))
        end
        local ev, err = engine:Write("ItemSuits", { item = id, roles = roles, reason = reason, name = itemName })
        if not ev then return out("Not recorded: " .. why(err)) end
        out(#roles > 0 and ("Recorded: %s suits %s (officer's call, over the addon's judgment)."):format(itemName or ("item " .. id), table.concat(roles, ", "))
            or ("Recorded: %s is judged by the addon again."):format(itemName or ("item " .. id)))
    end

    function cmds.spec(args)
        local main, off = args:match("^(%S+)%s*(%S*)$")
        if not main then
            local s = char.spec
            return out(s and ("Your specs: %s%s."):format(s.main, s.off and (", off-spec " .. s.off) or "") or "No spec set. spec <main> [off]")
        end
        local class = myClass()
        if not class then return out("Your class isn't known yet (join a group, or try again in a moment).") end
        local function find(word)
            word = word:lower()
            for _, s in ipairs(ItemFit.SPECS[class]) do
                if s.name:lower():find(word, 1, true) == 1 or s.name:lower():find("(" .. word, 1, true) then return s.name end
            end
        end
        local m, o = find(main), off ~= "" and find(off) or nil
        if not m or (off ~= "" and not o) then
            local names = {}
            for i, s in ipairs(ItemFit.SPECS[class]) do names[i] = s.name end
            return out("Specs for your class: " .. table.concat(names, ", ") .. ".")
        end
        char.spec = { main = m, off = o }
        out(("Your specs: %s%s. Used for hints only (hints on)."):format(m, o and (", off-spec " .. o) or ""))
    end

    function cmds.hints(args)
        local a = args:lower()
        if a == "on" then char.hints = true elseif a == "off" then char.hints = nil end
        out(char.hints and "Hints are on: items show who they suit and how they fit you. A suggestion, never a rule."
            or "Hints are off: you judge items yourself (hints on to see suggestions).")
    end

    ---------------------------------------------------------------- misc
    function cmds.sync()
        if not ctx.sync then return out("Sync is not running.") end
        local st = ctx.sync:status()
        out(("Sync: %d message(s) waiting%s, %d rejected, %d fork(s) resolved%s."):format(st.pending,
            st.blocked and (" (" .. st.blocked .. ")") or "", st.rejected, st.forksResolved, st.resolvingForks and ", resolving a fork now" or ""))
        out(("Ledger fingerprint %s%s"):format((engine:Fingerprint() or ""):sub(1, 8), engine:IsVerified() and "" or " (still verifying)"))
        local ids = {}
        for cid in pairs(engine.store.chains) do ids[#ids + 1] = cid end
        table.sort(ids)
        for _, cid in ipairs(ids) do
            local chain = engine.store.chains[cid]
            out(("  %s: %d events, head %s"):format(short(cid), #chain.events, chain.head:sub(1, 8)))
        end
        for id, p in pairs(engine.problems) do out(("  %s: FAILED verification at event %s (%s)"):format(id, tostring(p.index), tostring(p.reason))) end
        local conflicts = engine:Conflicts()
        if #conflicts > 0 then out(("%d event(s) were skipped as conflicts (see: conflicts)"):format(#conflicts)) end
    end

    function cmds.check()
        if ctx.selfcheck then ctx.selfcheck.Run(client) else out("Self-check is not available.") end
    end

    ---------------------------------------------------------------- notifications from the protocol
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
                out(("Salvage: nobody wanted item %d, and you are the lowest on the list right now. claim [name to gift it to], or decline."):format(t.item))
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
