-- King's Gambit: the text interface (slash commands). Everything the addon can do, without frames:
-- manage lists, run a loot session as Master Looter, and answer as a player. Output goes through
-- client:print. This is the first usable UI and stays useful alongside the real frames later.
local _, SK = ...
local Standings, Identity
local CmdSession, CmdRaids, CmdLedger, CmdLists, CmdAnswer, CmdRequests, CmdRules, CmdEvents
-- The commands themselves live in the Cmd* modules (src/commands/): this file builds what they share and dispatches to them.
local M = SK:NewModule("Commands", { "Standings", "Identity", "CmdSession", "CmdRaids", "CmdLedger", "CmdLists", "CmdAnswer", "CmdRequests", "CmdRules", "CmdEvents" }, function(d)
    Standings, Identity = d.Standings, d.Identity
    CmdSession, CmdRaids, CmdLedger, CmdLists, CmdAnswer, CmdRequests, CmdRules, CmdEvents = d.CmdSession, d.CmdRaids, d.CmdLedger, d.CmdLists, d.CmdAnswer, d.CmdRequests, d.CmdRules, d.CmdEvents
end)

local WHY = {
    closed = "bidding is closed", ineligible = "you are not eligible for this drop", noitem = "there is no such item",
    badkind = "answer with need, off, gift or pass", badtarget = "name who should get the gift",
    notyourturn = "it is not your turn", noturn = "nothing is waiting for you", badpick = "you didn't bid on that item",
    nosession = "no loot session is running", busy = "a session is already running",
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
    notofficer = "only an officer can do that (an officer is a member of the guild whose rank has the \"Is Officer\" permission)", notguildmaster = "only the ledger owner can do that",
    disregarded = "an officer has decided to disregard that player's entries", notowner = "the ledger owner can't be disregarded",
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
    "  create <list> [name] - create a list with an id you choose",
    "  newlist <name> - create a list named <name>; the id is made for you (name, date, who made it)",
    "  add <name> [top|bottom|N] - add a player to the list",
    "  addall - add everyone in your group and guild who isn't on the list",
    "  remove <name> - take a player off the list",
    "  move <name> <top|bottom|N> <reason>",
    "  award <name> <item> <reason> - record a win the session didn't",
    "  undo yes - undo the last award (it asks first)",
    "  eligible <item> <classes|any> <reason> - which classes may bid on an item",
    "  suits <item> <roles|auto> <reason> - who an item suits: tank, melee, hunter, caster, healer",
    "Ledger owner",
    "  ledgers - the ledgers stored on this account; ledgers retire <n> (removes a stale one, asks first) | ledgers keep <n> (brings it back)",
    "  officers - who the officers are (the game's \"Is Officer\" rank permission) and who is being disregarded",
    "  disregard <name> <reason> | regard <name> - an officer: ignore a player's entries from now on, for everyone; or stop",
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

    -- What the command files share. Each installs its own commands on `cmds` (and exports what a later one needs through h).
    local h = { ctx = ctx, client = client, engine = engine, out = out, why = why, canWrite = canWrite, name = name, short = short, cur = cur, list = list, mls = mls, append = append, hosting = hosting,
        setWorking = function(id) working = id end }
    CmdSession.Install(c, cmds, h)
    CmdRaids.Install(c, cmds, h)
    CmdLedger.Install(c, cmds, h)
    CmdLists.Install(c, cmds, h)
    CmdAnswer.Install(c, cmds, h)
    CmdRequests.Install(c, cmds, h)
    CmdRules.Install(c, cmds, h)
    CmdEvents.Install(c, cmds, h)

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
