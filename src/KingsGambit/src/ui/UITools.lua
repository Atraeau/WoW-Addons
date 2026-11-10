-- King's Gambit: the forms of the Guild book: a form for every command that needs a name, a reason or a choice. GuildBook.SECTIONS says which section (Awards, Raids, People, Rules, Ledger) holds which.
-- Keep this file Lua 5.1-safe. A form only COMPOSES the command a person would have typed (Compose, pure and tested) and runs it, so a form can
-- never do what the command could not, and the commands' own checks and messages apply unchanged.
local _, SK = ...
local Tips, Skin
local installParts -- defined at the end of the file: the frames are in tools/UIToolsFrames.lua
local M = SK:NewModule("UITools", { "UITips", "UISkin?", "UIToolsFrames" }, function(d)
    Tips, Skin = d.UITips, d.UISkin
    installParts(d)
end)

-- a button in the addon's own look (the game's stock one if the skin isn't there)
local function newButton(parent)
    if Skin then return Skin.Button(parent, "", 100, 24) end
    return CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
end

-- Field: key, label, optional (may be left empty), default, name (a character: spaces become the First_Last form).
-- cmd: pieces joined by spaces. "@key" is the field's text; a { ... } piece is dropped when its fields are empty.
local function F(key, label, opts)
    local f = { key = key, label = label }
    for k, v in pairs(opts or {}) do f[k] = v end
    return f
end

M.GROUPS = {
    { id = "raid", title = "Raid", actions = {
        { id = "raidopen", label = "Open a raid", help = "Officers. The Master Looter writes the raid's awards. Name a list to play on it (required if the ledger owner set one list per raid).",
            fields = { F("ml", "Master Looter", { name = true, optional = true, source = "group" }), F("hours", "Hours", { optional = true, default = "4" }), F("list", "List", { optional = true }) },
            cmd = { "raid open", "@ml", "@hours", { "list", "@list" } } },
        { id = "raidlist", label = "Name the raid's list", help = "Officers. Once named, a raid never changes list.", fields = { F("id", "List") }, cmd = { "raid list", "@id" } },
        { id = "raidshow", label = "Open raids", help = "Who is Master Looter of the raids that are open, and on which list.", fields = {}, cmd = { "raid" } },
        { id = "raidextend", label = "Extend a raid", help = "Give a running raid more time (24 hours at most).", fields = { F("hours", "Hours", { optional = true, default = "2" }) }, cmd = { "raid extend", "@hours" } },
        { id = "raidrevoke", label = "Revoke a raid", help = "Take the Master Looter's right to write away at once. It is in the record.", fields = { F("name", "Raid or Master Looter", { optional = true, name = true, source = "group" }) }, cmd = { "raid revoke", "@name" } },
        { id = "raidclose", label = "Close my raid", help = "Master Looter: end your raid.", fields = {}, cmd = { "raid close" } },
        { id = "masterloot", label = "Set Master Looter", help = "Raid leader: set the loot method to Master Looter (the game's own setting).", fields = { F("name", "Looter (default you)", { optional = true, name = true, source = "group" }) }, cmd = { "masterloot", "@name" } },
        { id = "disenchanter", label = "Disenchanter", help = "Master Looter: who disenchants what nobody wants. Required before loot is handed out. Empty shows who it is.", fields = { F("name", "Name", { optional = true, name = true, source = "group" }) }, cmd = { "disenchanter", "@name" } },
    } },
    { id = "list", title = "List", actions = {
        { id = "listuse", label = "Work on a list", help = "Which list add, move, award and undo change (empty = your raid's list, else main).", fields = { F("id", "List", { optional = true }) }, cmd = { "list use", "@id" } },
        { id = "create", label = "Create a list", help = "Give it a name. Its id is made for you from the name, the date and who made it.", fields = { F("name", "Name") }, cmd = { "newlist", "@name" } },
        { id = "add", label = "Add a player", help = "Add one player (the Lists section adds everyone in your group and guild at once).", fields = { F("name", "Player", { name = true, source = "missing" }), F("pos", "top, bottom or a place", { optional = true }) }, cmd = { "add", "@name", "@pos" } },
        { id = "remove", label = "Remove a player", help = "Take a player off the list. They can be put back at the same place.", fields = { F("name", "Player", { name = true }), F("reason", "Reason", { optional = true }) }, cmd = { "remove", "@name", "@reason" } },
        { id = "move", label = "Move a player", help = "A reason is required: it is part of the record.", fields = { F("name", "Player", { name = true }), F("pos", "top, bottom or a place"), F("reason", "Reason") }, cmd = { "move", "@name", "@pos", "@reason" } },
        { id = "award", label = "Record a win", help = "A win the session didn't record (a failed hand-out, a corrected winner). Choose the item from what you hold (tradeable items in your bags, the open loot window), or shift-click any item link, for instance one from chat: the item may already be in someone else's bags.", fields = { F("name", "Winner", { name = true }), F("item", "Item (held, or shift-click one)", { source = "items", link = true }), F("reason", "Reason") }, cmd = { "award", "@name", "@item", "@reason" } },
        { id = "undo", label = "Undo the last award", help = "Reverses your latest award. It asks first; this button confirms.", fields = {}, cmd = { "undo yes" } },
        { id = "trade", label = "Item went elsewhere", help = "Master Looter: the item went to someone else. The winner is restored, the other player moves to the bottom.", fields = { F("name", "Winner", { name = true }), F("to", "Who has it", { name = true }), F("reason", "Reason") }, cmd = { "trade", "@name", "@to", "@reason" } },
        { id = "disenchanted", label = "What disenchanting gave", help = "You were given an item to disenchant: say what you got, e.g. 3 Strange Dust, 1 Lesser Magic Essence (or shift-click the items, each followed by x2 for a stack). It is written in the record against that item; if you are not the Master Looter, they are told and write it.", fields = { F("results", "What you got") }, cmd = { "disenchanted", "@results" } },
        { id = "salvaged", label = "Note a salvager", help = "For the record only: what a salvager did with their item.", fields = { F("name", "Salvager", { name = true }), F("what", "keep, gift, sell, disenchant or bank") }, cmd = { "salvaged", "@name", "@what" } },
    } },
    { id = "rules", title = "Rules and requests", actions = {
        { id = "eligible", label = "Class rule for an item", help = "Officers. Which classes may bid on an item before it drops (a token, a set piece). 'any' removes the restriction.", fields = { F("item", "Item (shift-click one)", { link = true }), F("classes", "Classes, or any"), F("reason", "Reason") }, cmd = { "eligible", "@item", "@classes", "@reason" } },
        { id = "eligibles", label = "Show class rules", help = "The rule for one item, or every rule.", fields = { F("item", "Item (shift-click one; empty = all)", { optional = true, link = true }) }, cmd = { "eligible", "@item" } },
        { id = "suits", label = "Who an item suits", help = "Officers. Override the addon's stat check: tank, melee, hunter, caster, healer, or auto.", fields = { F("item", "Item (shift-click one)", { link = true }), F("roles", "Roles, or auto"), F("reason", "Reason") }, cmd = { "suits", "@item", "@roles", "@reason" } },
        { id = "reqelig", label = "Request: let my class bid", help = "Ask for your class to be allowed to bid on an item, from now on.", fields = { F("item", "Item (shift-click one)", { link = true }), F("reason", "Reason") }, cmd = { "request eligible", "@item", "@reason" } },
        { id = "request", label = "Request a list change", help = "Ask the Master Looter during a raid. Kind: move, undo, remove, add, award, trade or gift; then its details as the command takes them.", fields = { F("kind", "Kind"), F("details", "Details (player, place, reason...)") }, cmd = { "request", "@kind", "@details" } },
        { id = "requests", label = "Waiting requests", help = "Waiting requests and recent decisions.", fields = {}, cmd = { "requests" } },
        { id = "accept", label = "Accept a request", help = "Master Looter.", fields = { F("n", "Request number") }, cmd = { "accept", "@n" } },
        { id = "decline", label = "Decline a request", help = "Master Looter. A reason is required.", fields = { F("n", "Request number"), F("reason", "Reason") }, cmd = { "decline", "@n", "@reason" } },
        { id = "history", label = "History", help = "The last changes to the list, with who, why and at whose request.", fields = { F("n", "How many", { optional = true, default = "10" }) }, cmd = { "history", "@n" } },
    } },
    { id = "admin", title = "Ledger owner and me", actions = {
        { id = "officers", label = "Officers", help = "Show the ledger owner, the officers (the game's \"Is Officer\" rank permission) and anyone being disregarded.", fields = {}, cmd = { "officers" } },
        { id = "disregard", label = "Disregard a player's entries", help = "An officer. If someone who shouldn't be writing to the ledger has, this ignores everything they write from now on, on every client (what they wrote before stays). A reason is part of the record.", fields = { F("name", "Player", { name = true }), F("reason", "Reason") }, cmd = { "disregard", "@name", "@reason" } },
        { id = "regard", label = "Stop disregarding a player", help = "An officer. The player's entries count again, from now on.", fields = { F("name", "Player", { name = true }) }, cmd = { "regard", "@name" } },
        { id = "policy", label = "One list per raid?", help = "Ledger owner. choose (the default): the officer may name a list. perraid: every raid must have a list of its own. Empty shows it.", fields = { F("mode", "choose or perraid", { optional = true }) }, cmd = { "raid policy", "@mode" } },
        { id = "migratestatus", label = "Ledger format", help = "The ledger's format, and which players can already read the next one.", fields = {}, cmd = { "migrate status" } },
        { id = "migrate", label = "Move to the next format", help = "Ledger owner. Permanent. Only when 'Ledger format' shows everyone is ready.", fields = { F("format", "Next format number"), F("reason", "Reason") }, cmd = { "migrate", "@format", "@reason" } },
        { id = "version", label = "Versions", help = "This addon's version, and what every other player runs.", fields = {}, cmd = { "version" } },
        { id = "sync", label = "Sync status", help = "How the ledger is syncing with other players.", fields = {}, cmd = { "sync" } },
        { id = "check", label = "Check the game client", help = "Probe the game's API (results are saved for the developer).", fields = {}, cmd = { "check" } },
        { id = "spec", label = "My specs", help = "Your main (and off) spec, for fit hints.", fields = { F("main", "Main spec"), F("off", "Off-spec", { optional = true }) }, cmd = { "spec", "@main", "@off" } },
        { id = "hints", label = "Fit hints", help = "Show how items fit you while you bid.", fields = { F("mode", "on or off") }, cmd = { "hints", "@mode" } },
    } },
}

local function trim(s) return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", "")) end

-- An item link in a form field becomes "item:ID".
function M.PlainLinks(text)
    return (tostring(text or ""):gsub("|c%x%x%x%x%x%x%x%x|Hitem:(%d+)[^|]*|h%[.-%]|h|r", "item:%1"):gsub("|Hitem:(%d+)[^|]*|h%[.-%]|h", "item:%1"))
end

-- The command text for an action and the values typed, or nil and what is missing.
function M.Compose(action, values)
    values = values or {}
    local v, fields = {}, {}
    for _, f in ipairs(action.fields) do
        fields[f.key] = f
        local text = trim(M.PlainLinks(values[f.key]))
        if f.name then text = text:gsub("%s+", "_") end
        v[f.key] = text
        if text == "" and not f.optional then return nil, f.label end
    end
    local out = {}
    for _, piece in ipairs(action.cmd) do
        if type(piece) == "table" then
            local words, empty = {}, false
            for _, p in ipairs(piece) do
                local key = p:match("^@(.+)$")
                if key then
                    if v[key] == "" then empty = true else words[#words + 1] = v[key] end
                else
                    words[#words + 1] = p
                end
            end
            if not empty then out[#out + 1] = table.concat(words, " ") end
        else
            local key = piece:match("^@(.+)$")
            if key then
                if v[key] ~= "" then out[#out + 1] = v[key] end
            else
                out[#out + 1] = piece
            end
        end
    end
    return table.concat(out, " ")
end

-- The players a field can be: "members" (on the list), "group" (in your party or raid, else the list's members), "missing" (in the group or
-- guild but not on the list yet). Canonical names, in list order for members.
function M.Players(ctx, source, listId)
    local out, seen = {}, {}
    local function add(name) if name and not seen[name] then seen[name] = true; out[#out + 1] = name end end
    local engine, client = ctx.engine, ctx.client
    local chain = engine:Get(listId or engine:RaidList() or "main")
    local onList = chain and chain.state.members or {}
    if source == "group" then
        for _, m in ipairs(client:roster()) do add(m.name) end
    elseif source == "missing" then
        for _, list in ipairs { client:roster(), client:guildRoster() } do
            for _, m in ipairs(list) do if m.name and not onList[m.name] then add(m.name) end end
        end
        return out
    end
    if #out == 0 and chain then for _, name in ipairs(chain.state.order) do add(name) end end
    return out
end

-- Reasons people give most often, offered next to every Reason box so the usual ones are always spelled the same way. Choosing one fills the box;
-- the text can still be typed or changed freely.
M.REASONS = {
    "Regret trade", "Gift", "Wrong player", "Mistake", "Duplicate", "Left the raid",
    "Late to the raid", "Disconnected", "Requested by the player", "Officer decision",
}

local function shown(name) return (tostring(name):gsub("_", " ")) end

-- Something to choose from rather than type: a player, or an item you hold.
local function isPick(fld) return fld.name or fld.source == "items" end

-- The tradeable items in the bags: not soulbound, or soulbound with the loot-trade window still open (the tooltip says so). Game only.
function M.BagLinks()
    local out, stats = {}, { seen = 0, bound = 0, tradeable = 0 }
    local C = C_Container
    if not (C and C.GetContainerNumSlots and C.GetContainerItemInfo) then stats.unavailable = true; return out, stats end
    local pattern = BIND_TRADE_TIME_REMAINING and ("^" .. BIND_TRADE_TIME_REMAINING:gsub("([%%%(%)%.%+%-%*%?%[%]%^%$])", "%%%1"):gsub("%%%%s", ".+") .. "$")
    local function tradeWindow(bag, slot)
        if not (pattern and C_TooltipInfo and C_TooltipInfo.GetBagItem) then return false end
        local ok, data = pcall(C_TooltipInfo.GetBagItem, bag, slot)
        if not (ok and data and data.lines) then return false end
        for _, line in ipairs(data.lines) do
            if type(line.leftText) == "string" and line.leftText:find(pattern) then return true end
        end
        return false
    end
    for bag = 0, 5 do
        for slot = 1, (C.GetContainerNumSlots(bag) or 0) do
            local info = C.GetContainerItemInfo(bag, slot)
            if info and info.hyperlink then
                stats.seen = stats.seen + 1
                if info.isBound then stats.bound = stats.bound + 1 end
                if not info.isBound or tradeWindow(bag, slot) then
                    stats.tradeable = stats.tradeable + 1
                    out[#out + 1] = info.hyperlink
                end
            end
        end
    end
    return out, stats
end

-- The items a record of a win could be for: what is in the open loot window, and the tradeable items in the bags (in practice, the practice
-- raid's loot). An item you don't hold can't be chosen. Each: { link, where }.
function M.Items(ctx)
    local out, seen = {}, {}
    local function add(link, where)
        if type(link) ~= "string" then return end
        local key = link:match("item:(%d+)") or link
        if seen[key] then return end
        seen[key] = true
        out[#out + 1] = { link = link, where = where }
    end
    local stats
    for _, slot in ipairs(ctx.client:lootSlots() or {}) do add(slot.link, "loot window") end
    if ctx.sim then
        -- practice: the loot the practice raid has dropped, and the gear it is made of (that is "held" here)
        local session = ctx.sim.session
        for _, it in ipairs(session and session.items or {}) do add(it.link, "practice loot") end
        for _, h in ipairs(ctx.sim.held or {}) do add(h.item and h.item.name, "held practice loot") end
        local raidItems = ctx.sim.raid and ctx.sim.raid.items or {}
        local ids = {}
        for id in pairs(raidItems) do ids[#ids + 1] = id end
        table.sort(ids)
        for _, id in ipairs(ids) do
            local name = raidItems[id].name
            if type(name) == "string" and name:find("|Hitem:", 1, true) then add(name, "practice gear") end
        end
    elseif ctx.bagLinks then
        local links
        links, stats = ctx.bagLinks()
        for _, link in ipairs(links) do add(link, "bags") end
    end
    return out, stats
end

function M.Find(id)
    for _, g in ipairs(M.GROUPS) do
        for _, a in ipairs(g.actions) do if a.id == id then return a, g end end
    end
end

-- Add the frames' functions to M (once every module is loaded: see Registry.lua), handing them the helpers they share.
function installParts(d)
    d.UIToolsFrames.Install(M, { isPick = isPick, newButton = newButton, shown = shown })
end
