-- King's Gambit: the text interface (slash commands). Everything the addon can do, without frames:
-- manage lists, run a loot session as Master Looter, and answer as a player. Output goes through
-- client:print. This is the first usable UI and stays useful alongside the real frames later.
local _, SK = ...
local Standings, ItemFit, Loot, Ledger, Version, Identity, Tokens, Requests
local M = SK:NewModule("Commands", { "Standings", "ItemFit", "Loot", "Ledger", "Version", "Identity", "Tokens?", "Requests?" }, function(d)
    Standings, ItemFit, Loot, Ledger, Version, Identity, Tokens, Requests = d.Standings, d.ItemFit, d.Loot, d.Ledger, d.Version, d.Identity, d.Tokens, d.Requests
end)

local WHY = {
    closed = "bidding is closed", ineligible = "you are not eligible for this drop", noitem = "there is no such item",
    badkind = "answer with need, off, gift or pass", badtarget = "name who should get the gift",
    notyourturn = "it is not your turn", noturn = "nothing is waiting for you", badpick = "you didn't bid on that item",
    nosession = "no loot session is running", busy = "a session is already running", notml = "you are not the Master Looter",
    nolist = "no such list", notreview = "the session is not ready to confirm",
    cantkeep = "you can't keep it: it isn't for your class. Name who gets it, or withdraw", unreachable = "they are out of loot range",
    norecipient = "no one was named to receive it",
    notmasterloot = "the loot method is not Master Looter (the raid leader sets it: masterloot)",
    notml = "you are not the raid's Master Looter",
    -- which list a raid plays on
    nolistchosen = "this raid has no list yet: the guild requires one list of its own per raid (an officer names it: raid list <id>)",
    wronglist = "during a raid its Master Looter writes only to the raid's own list",
    listset = "this raid already has its list; a raid never changes list part-way. If it was the wrong one, revoke the raid and open it again",
    needsownlist = "the guild requires each raid to have a list of its own, so it can't be main",
    badlistid = "a list id is lower-case letters, digits and _ (up to 24), and not 'off'", badpolicy = "the policy is choose or perraid",
    nodisenchanter = "no disenchanter is designated for this raid yet. Choose who disenchants what nobody wants: disenchanter <name>",
    nodisenchant = "there is no such disenchant on the list", notyours = "only the player the item was given to can say what disenchanting it gave",
    alreadyrecorded = "what that item gave is already recorded", badresults = "what you got must be 1 to 8 materials, each with a name and a count (1 to 200)",
    -- who may write (ledger authority)
    notauthorized = "you are not an officer, and no raid is open with you as its Master Looter",
    expired = "your raid has ended, and with it your right to write to the list",
    notofficer = "only an officer can do that", notguildmaster = "only the guild master can do that",
    -- ledger formats (see Migrations.lua)
    ahead = "this ledger has entries in a newer format than this version can read, so writing is paused: update King's Gambit (nothing was lost)",
    frozen = "this client could not reproduce the last migration, so it will not write (it would not agree with everyone else): update King's Gambit",
    badmigrate = "the next format is the current one plus one", cantwrite = "this version does not know that format yet: update King's Gambit first",
    wrongformat = "the ledger is not in the format that migration starts from", unrepresentable = "that can't be written in the ledger's current format until it is migrated",
    nodowncast = "that can't be written in the ledger's current format until it is migrated",
    staleformat = "written in an older format after the ledger was migrated", earlyformat = "written in a newer format before the ledger was migrated",
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
    notrevertible = "that award can't be undone directly any more (the list has moved since, or it was not made by you): use a move instead",
    notrestricted = "that item isn't restricted to classes, so everyone may already bid on it",
    cantequip = "that class can't wear or wield that item", cantequipto = "the player you are gifting to can't wear or wield that item",
    alreadyeligible = "that class may already bid on it",
    badpos = "a position is top, bottom or a number",
    -- who may bid on an item
    nostats = "that item has no stats that help that class (if it should be eligible: request eligible <item#> <reason>)",
    nostatsto = "the item has no stats that help the player you are gifting to",
    wrongclass = "that item is for other classes (if you think your class should be eligible: request eligible <item#> <reason>)",
    wrongclassto = "the player you are gifting to is not one of the classes the item is for",
    baditemrule = "that rule is not valid (an item id, the classes, and a reason)",
    baditemsuits = "that override is not valid (an item id, the roles, and a reason)",
}
local function why(w) return WHY[w] or tostring(w) end

-- One command per line, no columns: the game's chat font is not monospaced, so padded columns never line up.
local HELP = {
    "King's Gambit: type /gambit to open the window. Commands (<> required, [] optional):",
    "Everyone",
    "  standings [list] [N] - show a list (default: yours, top 20)",
    "  need|off|pass <item#> - answer for an item",
    "  gift <item#> [name] - bid to win it for someone else (the name can wait)",
    "  need <item#> ready - a token: you can turn it in",
    "  ready <item#> - who wants a token, and how ready they are",
    "  pick <item#> | skip | claim [name] | decline - your turn in the draft or salvage",
    "  recipient <name> | keep | withdraw yes - after winning a gift with no name",
    "  request move|undo|remove|add|award|trade|gift ... - ask the Master Looter to change the list",
    "  request eligible <item> <reason> - ask for your class to be allowed to bid",
    "  requests - waiting requests and recent decisions",
    "  disenchanted <what you got> - record what disenchanting an item gave, e.g. disenchanted 3 Strange Dust, 1 Lesser Magic Essence",
    "  history [N] - the last changes, with who, why and at whose request",
    "  eligible [item] - the class rule for an item, or every rule",
    "  spec <main> [off] - your specs, for fit hints",
    "  hints on|off - show how items fit you (default off)",
    "  version - this addon's version, and what other players run",
    "  sync - ledger sync status",
    "  check - probe the game client",
    "Master Looter",
    "  loot - start a session from the open loot window",
    "  resolve, extend [sec], confirm, cancel, announce - run the session",
    "  override - a gift winner won't name a recipient: count it as their pass",
    "  disenchanter [name] - who disenchants (required before loot is handed out)",
    "  accept <n> | decline <n> <reason> - answer a request",
    "  trade <name> <to> <reason> - the item went to someone else",
    "  salvaged <name> <keep|gift|sell|disenchant|bank> - note what a salvager did",
    "  raid close [anyway] - end your raid",
    "Officers",
    "  raid - who is Master Looter of the open raids",
    "  raid open [name] [hours] [list <id>] - open a raid (default: 4 hours, list main)",
    "  raid list [<id>] - name the raid's list (once), or show it",
    "  raid extend [hours] | raid revoke [name]",
    "  masterloot [name] - set the loot method to Master Looter",
    "  list use [<id>|main] - the list add, move, award and undo change",
    "  create <list> [name] - create a list",
    "  add <name> [top|bottom|N] - add a player to the list",
    "  addall - add everyone in your group and guild who isn't on the list",
    "  remove <name> - take a player off the list",
    "  move <name> <top|bottom|N> <reason>",
    "  award <name> <item> <reason> - record a win the session didn't",
    "  undo yes - undo the last award (it asks first)",
    "  eligible <item> <classes|any> <reason> - which classes may bid on an item",
    "  suits <item> <roles|auto> <reason> - who an item suits: tank, melee, hunter, caster, healer",
    "Guild master",
    "  officers [set <names...>] - who the officers are",
    "  raid policy [choose|perraid] - how raids pick their list",
    "  migrate [status] - the ledger's format, and who can read the next one",
    "  migrate <format> <reason> - move to the next format (everyone must be ready)",
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
    local function short(n) return n and Identity.Display(n) end -- a character's name as a person reads it: "First Last"
    -- The list manual commands change: one named with `list use`, else the list the raid this character is Master Looter of plays on, else main.
    local working
    local function cur() return working or engine:RaidList() or "main" end
    local function list(id) return engine:Get(id or cur()) end

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

    -- The ledger's format, and who can read the next one. The guild master moves the ledger to it with `migrate <format> <reason>` once the guild is ready:
    -- the entry records exactly which entries are before the change and what they add up to, and every client checks its own replay against that.
    function cmds.migrate(args)
        local sub, rest = args:match("^(%S*)%s*(.-)$")
        local fmt = engine:Format()
        if tonumber(sub) then
            if rest == "" then return out("migrate <format> <reason>: say why (it goes in the record)") end
            local ev, err = engine:Migrate(tonumber(sub), rest)
            if ev then
                out(("Recorded: the ledger is now in format %d. Players whose King's Gambit can't read it are told to update; the rest check the change against their own replay."):format(fmt + 1))
            else
                out("Not recorded: " .. why(err))
            end
            return
        end
        local readable = engine:Readable()
        out(("The ledger is in format %d. This version reads format%s %s."):format(fmt, #readable > 1 and "s" or "", table.concat(readable, ", ")))
        if next(engine:Ahead()) then out("This ledger has entries in a newer format than this version can read: you see it as of the last entry you can read, and writing is paused. Update King's Gambit.") end
        local frozen = engine:Frozen()
        if frozen then out(("This client could not reproduce the migration to format %d (it got a different result from the guild master's), so it will not write. Update King's Gambit."):format(frozen.to)) end
        local nextFormat = fmt + 1
        if readable[#readable] < nextFormat then out(("This version does not know format %d: there is nothing newer to move to yet."):format(nextFormat)); return end
        local ready, notReady, unknown = {}, {}, {}
        for _, p in ipairs(ctx.sync and ctx.sync:peerVersions() or {}) do
            local who = short(p.name)
            if not p.formats then unknown[#unknown + 1] = who
            else
                local can = false
                for _, f in ipairs(p.formats) do if f == nextFormat then can = true end end
                if can then ready[#ready + 1] = who else notReady[#notReady + 1] = who end
            end
        end
        out(("Format %d is available. Can read it: %s. Cannot yet: %s. Not heard from: %s."):format(nextFormat,
            #ready > 0 and table.concat(ready, ", ") or "nobody", #notReady > 0 and table.concat(notReady, ", ") or "nobody",
            #unknown > 0 and table.concat(unknown, ", ") or "nobody"))
        out("The guild master moves the ledger with: migrate " .. nextFormat .. " <reason>. Anyone who cannot read it yet will have to update first.")
    end

    -- Which version is this, and can it work with what the others run? Players are listed from their heartbeats.
    function cmds.version()
        local mine = client:addonVersion()
        local line = Version.Line(mine)
        out(("King's Gambit %s (works with %s; ledger format %d)"):format(mine,
            line and (line:find("%.") and (line .. ".x") or (line .. ".x.y")) .. ", a different version on that line is fine" or "anyone: a development copy",
            Ledger.VERSION))
        local peers = ctx.sync and ctx.sync:peerVersions() or {}
        if #peers == 0 then out("No other King's Gambit players seen yet."); return end
        local WORDS = { same = "same as yours", newer = "newer than yours, compatible", older = "older than yours, compatible", unknown = "can't compare" }
        for _, p in ipairs(peers) do
            if p.relation == "incompatible" then
                out(("  %s: %s. INCOMPATIBLE: they are on %s.x, you are on %s.x; %s must update to share the ledger"):format(short(p.name),
                    p.build or "unknown version", p.line, p.ourLine, p.mustUpdate == "them" and "they" or "you"))
            else
                out(("  %s: %s (%s)"):format(short(p.name), p.build or "unknown version", WORDS[p.relation]))
            end
        end
    end

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
        if id == "" then working = nil; return out("Working on " .. cur() .. " (the default).") end
        if not engine:Get(id) then return out("No list called '" .. id .. "'. Lists: " .. table.concat(engine:Lists(), ", ")) end
        working = id
        out("Working on " .. id .. ": add, move, award, undo and the like change that list now.")
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
        if #words == 0 then
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
    -- The guild master's rule for how raids pick their list.
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
        if not fn then return out("raid [open [name] [hours] [list <id>] | list [id] | policy [choose|perraid] | close | extend [name] [hours] | revoke [name]]") end
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
            out(("  %s: %d events, head %s"):format(short(chain.author or cid), #chain.events, chain.head:sub(1, 8)))
        end
        for id, p in pairs(engine.problems) do out(("  %s: FAILED verification at event %s (%s)"):format(id, tostring(p.index), tostring(p.reason))) end
        local conflicts = engine:Conflicts()
        if #conflicts > 0 then out(("%d event(s) were skipped as conflicts (see: conflicts)"):format(#conflicts)) end
    end

    function cmds.check()
        if ctx.selfcheck then ctx.selfcheck.Run(client) else out("Self-check is not available.") end
    end

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

    -- Everyone the addon knows by name: on a list, in the raid, in the guild. A command names a character as one word (Aldric_Stormwind or "Aldric
    -- Stormwind"); and so a person doesn't have to, two words that make a known name are joined (see Identity.JoinNames).
    local function knownNames()
        local known = {}
        for id, chain in pairs(engine:View().lists) do
            for who in pairs(chain.members) do known[who] = true end
        end
        for _, m in ipairs(client:roster()) do known[m.name] = true end
        for _, m in ipairs(client:guildRoster()) do known[m.name] = true end
        return known
    end

    function c.handle(msg)
        msg = Identity.JoinNames(msg or "", knownNames())
        local cmd, args = msg:match("^%s*(%S*)%s*(.-)%s*$")
        cmd = cmd:lower()
        if cmd == "" or cmd == "show" then cmd = "standings" end
        local fn = cmds[cmd]
        if not fn then return out("Unknown command '" .. cmd .. "'. Type help.") end
        fn(args)
    end

    c.commands = cmds
    return c
end
