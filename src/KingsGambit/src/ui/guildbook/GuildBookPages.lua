-- King's Gambit: the Guild book as tables, its sections and the Welcome pages (the first-run copy). Keep this file Lua 5.1-safe.
-- Part of GuildBook (ui/GuildBook.lua): GuildBook merges what this module exports, so callers use GuildBook.<name>.
local _, SK = ...
local M = SK:NewModule("GuildBookPages")

-- The sections of the navigation column. A section with `actions` is a page of forms (UITools actions, by id): each runs the command a player would type.
-- `gap` puts a space above its button: Admin is the ledger owner's and maintenance corner, kept apart from the everyday sections.
-- Every action belongs to exactly one section (the old History form is the Ledger section now).
M.SECTIONS = {
    { id = "welcome", label = "Welcome", tip = "What King's Gambit is, how loot works, what the guild values, and where everything is. The addon opens here until you turn that off (the checkbox at the foot of the page); always here." },
    { id = "lists", label = "Lists", tip = "The standings: who is first for what, and the officers' moves." },
    { id = "thisraid", label = "This raid", tip = "The raid that is open now: how long it has run, what has been handed out, what is still to hand out and how long it can be traded, and its part of the ledger." },
    { id = "ledger", label = "Ledger", tip = "The record of everything that happened to the lists, in words: who won what, who moved whom, and why. Nothing in it can be edited or erased." },
    { id = "stats", label = "Stats", tip = "Who is at which place and for how long, who has won and when, from the record." },
    { id = "awards", label = "Awards", tip = "Record a win the session missed, undo an award, note where an item went. Corrections are new entries; nothing is erased.",
        actions = { "award", "undo", "trade", "salvaged", "disenchanted" } },
    { id = "raids", label = "Raids", tip = "Open and close a raid, choose its Master Looter, its list and its disenchanter.",
        actions = { "raidshow", "raidopen", "raidlist", "raidextend", "raidclose", "raidrevoke", "masterloot", "disenchanter", "policy" } },
    { id = "people", label = "People", tip = "Add, remove and move players; who the officers are (the game's rank permission) and who is being disregarded; and your own spec.",
        actions = { "add", "remove", "move", "officers", "disregard", "regard", "spec", "hints" } },
    { id = "rules", label = "Rules", tip = "Which classes may bid on an item, who it suits, and requests to the Master Looter.",
        actions = { "eligibles", "eligible", "suits", "reqelig", "request", "requests", "accept", "decline" } },
    { id = "admin", label = "Admin", gap = true, tip = "Starting a list, the record's format and versions, syncing, and the ledger stored on this computer (retiring it): the ledger owner's and maintenance steps. (The record itself is the Ledger.)",
        actions = { "create", "listuse", "migratestatus", "migrate", "version", "sync", "check" } },
}

-- The Welcome section: what the addon is and how to use it, in four short pages (progressive disclosure: one screenful at a time, each with one job), as plain
-- blocks the game's window (and later the web page) draws:
--   { kind = "title" | "heading" | "text" | "callout", text = "..." }   and   { kind = "bullets" | "numbered", items = { "..." | { lead = "...", text = "..." } } }
-- An item with a lead has its first words in white and the rest softer, so a list can be skimmed. It mirrors docs/manifesto.md (the values and principles) and
-- docs/rationale.md (the rules), in short; those say it all, with the reasons.
M.WELCOME_PAGES = {
    { id = "start", label = "Start here", blocks = {
        { kind = "title", text = "Welcome to King's Gambit" },
        { kind = "text", text = "Inspired by Suicide Kings, King's Gambit is a list-centric loot system, valuing transparency, agency and fairness. Where it is distinct is through how it attempts to address one of the most painful flaws in Suicide Kings: wasting useful loot." },
        { kind = "callout", text = "Suicide Kings is worth keeping: win an item and drop to the bottom, turns that are earned rather than rolled, loot that spreads evenly across everyone who shows up, and almost no upkeep. King's Gambit keeps all of that and fixes what goes wrong with it." },
        { kind = "heading", text = "Where Suicide Kings breaks down" },
        { kind = "bullets", items = {
            { lead = "Useful loot gets thrown away.", text = "Winning costs your place, so a veteran holds out for the best-in-slot piece and passes on items that would help them. If nobody lower bids, a good item is disenchanted." },
            { lead = "The usual fix creates a loophole.", text = "A free roll when everyone passes lets a group agree to pass together and roll for a free item." },
            { lead = "It runs on trust in one officer's list.", text = "When a place looks wrong, or an item is traded after the raid, there is nothing to check it against." },
            { lead = "Everyone is asked about everything,", text = "including gear they can't use, so the real decisions get buried." },
        } },
        { kind = "heading", text = "How King's Gambit fixes it" },
        { kind = "bullets", items = {
            { lead = "Gifting.", text = "Win an item and hand it to anyone, in any direction. You pay the place and they get the item, so a side-grade finds a home even when the player who needs it sits too high to bid. Never required, always visible." },
            { lead = "Salvage, not a roll.", text = "With no bidders the item goes to whoever is at the bottom, who keeps, gifts, sells or disenchants it. There is no roll to win by conspiring, and the group can't choose who gets it." },
            { lead = "A shared ledger.", text = "Every win, move and correction is an entry each player holds and can verify. Trust is checkable, and nobody changes it quietly." },
            { lead = "Mistakes fixed in the open.", text = "Any of the Master Looter's awards can be undone exactly, and a trade after the raid is recorded. Nothing is erased." },
            { lead = "Asked only when you could use it,", text = "by class and by your spec's stats, so the real choices stand out." },
            { lead = "Live decisions.", text = "You choose after the drop. Officers run the process and don't decide who deserves what." },
            { lead = "A draft and an off-spec list.", text = "Several drops at once are picked in order, with your ranking made up front, and off-spec never jumps someone who needs it for their main." },
        } },
        { kind = "text", text = "Passing is free. You only ever drop a place by winning, and every other player's win moves you up." },
    } },

    { id = "rules", label = "The rules", blocks = {
        { kind = "title", text = "The rules at the table" },
        { kind = "heading", text = "How it works in 60 seconds" },
        { kind = "numbered", items = {
            { lead = "One list.", text = "Everyone has a place. The top is whoever has gone longest since winning something." },
            { lead = "Something drops.", text = "A small window asks: Need, Off-spec, Gift or Pass. You decide live." },
            { lead = "The highest place that wants it wins,", text = "and drops to the bottom. That is the only way you lose a place." },
            { lead = "Passing is always free.", text = "" },
            { lead = "Everything is recorded", text = "in a ledger anyone in the guild can read and verify." },
        } },
        { kind = "heading", text = "The rules in detail" },
        { kind = "bullets", items = {
            { lead = "Who is asked.", text = "Only players who could use the item: their class can equip it and it has enough of the stats their spec values. An officer can override this for an item, and the override is in the ledger." },
            { lead = "Need.", text = "Among everyone who needs it, the highest place wins and drops to the bottom." },
            { lead = "Off-spec.", text = "A separate off-spec list, so winning off-spec costs you there only. A main-spec need always beats an off-spec bid." },
            { lead = "The draft.", text = "With several items, the top player picks first and drops to the bottom, then the next. If you want more than one, you rank them up front and the draft picks your highest-ranked one still there." },
            { lead = "Gifting.", text = "Win an item and hand it to someone else, in any direction. You pay the place, they get the item. Gifts come after everyone who wants the item for themselves." },
            { lead = "Nobody bids.", text = "The player at the bottom is the salvager. They keep, give away, sell or disenchant it, or pass it to the designated disenchanter and the guild bank." },
            { lead = "Disenchants", text = "are recorded together with what they actually gave." },
            { lead = "Mistakes", text = "are corrected with new entries (undo, trade, move, with a reason). Nothing is erased." },
            { lead = "A list per raid,", text = "and every correction and disenchant result written down in the open." },
        } },
    } },

    { id = "use", label = "Using it", blocks = {
        { kind = "title", text = "Using the addon" },
        { kind = "text", text = "Type /gambit to open the Guild book, the larger window. The small Loot window opens by itself when a loot session starts and asks you Need, Off-spec, Gift or Pass." },
        { kind = "heading", text = "Finding your way around" },
        { kind = "bullets", items = {
            { lead = "Lists:", text = "the standings and the officers' moves." },
            { lead = "This raid:", text = "what has been handed out, what is held, and how long it can be traded." },
            { lead = "Ledger:", text = "everything that happened, in words. Click an item to try it on." },
            { lead = "Stats:", text = "who held which place for how long, wins, and who was at which raid." },
            { lead = "Awards:", text = "record a win the session missed, undo an award, say what a disenchant gave." },
            { lead = "Raids:", text = "open and close a raid, and choose its Master Looter, list and disenchanter." },
            { lead = "People:", text = "add, remove and move players; who the officers are; your own spec." },
            { lead = "Rules:", text = "which classes may bid on an item, and requests to the Master Looter." },
            { lead = "Admin:", text = "versions, syncing, and retiring a ledger you no longer use." },
        } },
        { kind = "text", text = "Tick Practice mode at the top to rehearse on a simulated guild: a whole raid night, or one of the lessons from the web page (a set raid and drop, with a verdict at the end). Nothing in it is recorded or sent. Hover over any button for what it does; /gambit help lists every command." },
        { kind = "heading", text = "Getting started" },
        { kind = "bullets", items = {
            { lead = "Raider:", text = "nothing to set up. The ledger reaches you from your officers when you are online with them. Try Practice mode first." },
            { lead = "First officer in a guild:", text = "open Lists and press Start the ledger, once, on the character that should be ledger owner. Then add your players." },
            { lead = "Officer:", text = "your rank needs the game's Is Officer permission, which the Guild Master sets. The addon asks the game; it keeps no list of officers." },
            { lead = "Master Looter:", text = "an officer opens a raid for you in Raids. It starts by itself at the first enemy killed inside an instance." },
        } },
    } },

    { id = "why", label = "Why", blocks = {
        { kind = "title", text = "What we value, and why" },
        { kind = "text", text = "There is value on both sides of each of these, but we value the first more." },
        { kind = "bullets", items = {
            { lead = "In-the-moment decisions", text = "over plans made before the raid." },
            { lead = "Individual agency", text = "over central authority." },
            { lead = "Earned turns", text = "over the luck of the roll." },
            { lead = "Transparency and social trust", text = "over rules enforced by penalty." },
            { lead = "Effortless fairness", text = "over high-maintenance optimization: hard to be unfair, easy to be fair." },
        } },
        { kind = "heading", text = "The principles behind it" },
        { kind = "numbered", items = {
            { lead = "A loot system's first job is to be trusted:", text = "every decision is visible and verifiable." },
            { lead = "Decisions are made live,", text = "after the drop." },
            { lead = "Your place is your only currency.", text = "You spend it only when you win; passing is free." },
            { lead = "The highest player who wants an item wins it", text = "and returns to the bottom. One rule, every time." },
            { lead = "An item is worth whatever someone will spend on it;", text = "the standings show its value." },
            { lead = "Usable loot finds a home, not a shard:", text = "it is disenchanted only when truly no one wants it." },
            { lead = "We surface hoarding rather than punish it.", text = "You only drop when you win, never by decay, absence or judgment." },
            { lead = "Generosity is enabled and seen, never required:", text = "you can give an item to anyone, and the cost is yours." },
            { lead = "Mistakes are fixed in the open:", text = "corrections are recorded, history is never rewritten." },
            { lead = "Officers run the process;", text = "they do not decide who deserves loot. The rules do." },
            { lead = "Success comes from fairness and trust,", text = "not how to distribute loot for optimal performance." },
        } },
        { kind = "heading", text = "What this is not" },
        { kind = "bullets", items = {
            { lead = "Not an optimizer.", text = "It guarantees a fair, transparent process, not that the best item reaches the best use." },
            { lead = "Not a replacement for culture.", text = "It makes behavior visible; people still choose how to behave." },
            { lead = "Not trustless.", text = "It assumes officers act in good faith. The ledger catches mistakes, lost messages and desync, not a determined bad-faith officer. If someone writes who shouldn't, officers are told and can disregard them." },
        } },
        { kind = "heading", text = "Read more" },
        { kind = "text", text = "The manifesto, the player guide with the reason for every rule, the ledger owner's guide and every design decision are in the addon's repository: github.com/Atraeau/WoW-Addons (the folder src/KingsGambit/docs). You can also play the whole thing in a browser, no game needed: atraeau.github.io/WoW-Addons/kings-gambit" },
    } },
}

-- Every block of every page, in order (for a reader that wants it all, and for tests).
M.WELCOME = {}
for _, page in ipairs(M.WELCOME_PAGES) do
    for _, b in ipairs(page.blocks) do M.WELCOME[#M.WELCOME + 1] = b end
end

-- An item as plain text: "Lead text" (a lead that ends in a letter has no punctuation added).
local function itemText(item)
    if type(item) == "string" then return item end
    return (item.text ~= "" and (item.lead .. " " .. item.text)) or item.lead
end
M.ItemText = itemText

-- The first-run experience is a setting, on until someone turns it off (the checkbox on the Welcome page, or `/gambit welcome off`): while it is on, opening the
-- Guild book starts on Welcome. Looking at it, or closing the window at once, changes nothing: someone who opened the addon in the middle of something else
-- still gets it next time. Once it is off the window opens on the section it was on when it was last closed (Lists the first time).
-- (Nothing opens by itself: the addon says in chat that /gambit opens it.) The setting is per account (KingsGambitDB.welcomeOff); the last section per character.
function M.WelcomeFirst(db) return type(db) == "table" and not db.welcomeOff end
function M.SetWelcomeFirst(db, on) if type(db) == "table" then db.welcomeOff = (not on) or nil end end
function M.StartTab(db, char)
    if M.WelcomeFirst(db) then return "welcome" end
    local tab = type(char) == "table" and char.lastTab
    return (tab and M.Section(tab)) and tab or "lists"
end
function M.RememberTab(char, tab)
    if type(char) == "table" and tab and M.Section(tab) then char.lastTab = tab end
end

function M.Section(id)
    for _, s in ipairs(M.SECTIONS) do if s.id == id then return s end end
end

-- The section that holds a form (so a button elsewhere can open it).
function M.SectionOf(actionId)
    for _, s in ipairs(M.SECTIONS) do
        for _, a in ipairs(s.actions or {}) do if a == actionId then return s end end
    end
end

-- Which group of the record an entry belongs to, for the filter.
-- "happened" (the default) is what happened to items, lists, rules and raids: it leaves out passes, which are the most common entries by far and say what
-- could have happened, not what did, and attendance (who was in a raid), which has its own place in Stats (both stay in the record, under their own
-- filter and "Everything").
