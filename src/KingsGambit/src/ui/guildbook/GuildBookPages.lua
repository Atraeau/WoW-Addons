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
        { kind = "callout", text = "Suicide Kings has real strengths: a single rule that is easy to state (the winner of an item moves to the bottom of the list), turns that are earned rather than drawn by chance, an even distribution of loot among those who attend, and very little administrative burden. King's Gambit retains all of these and addresses the system's principal limitations." },
        { kind = "heading", text = "Limitations of Suicide Kings" },
        { kind = "bullets", items = {
            { lead = "Useful loot is wasted.", text = "Because a win costs the winner their position, experienced players withhold their bids for the best-in-slot item and pass on upgrades that would still benefit them. When no one lower on the list bids, a useful item is disenchanted." },
            { lead = "The conventional remedy introduces an exploit.", text = "Awarding a free roll when all players pass allows a group to coordinate their passes and roll for an item at no cost." },
            { lead = "Legitimacy rests on one officer's list.", text = "When a position appears incorrect, or an item is traded after the raid, there is no independent record against which to verify it." },
            { lead = "Players are asked about everything,", text = "including equipment they cannot use, which obscures the decisions that matter." },
        } },
        { kind = "heading", text = "How King's Gambit responds" },
        { kind = "bullets", items = {
            { lead = "Gifting.", text = "A winner may give the item to any player, in any direction. The winner bears the positional cost and the recipient receives the item, so a minor upgrade reaches a player who can use it even when that player is too high on the list to bid. Gifting is optional and always visible." },
            { lead = "Salvage in place of a roll.", text = "When no one bids, the item passes to the player at the bottom of the list, who may keep, gift, sell or disenchant it. Because there is no roll, collusion yields no advantage, and the group cannot select the recipient." },
            { lead = "A shared ledger.", text = "Every win, move and correction is an entry that each player holds and can verify, so the record can be audited rather than merely trusted." },
            { lead = "Corrections made in the open.", text = "Any of the Master Looter's awards can be reversed exactly, and a trade after the raid is recorded. No entry is erased." },
            { lead = "Relevant prompts only.", text = "A player is asked only about items their class and specialization could use, so the meaningful decisions are not obscured." },
            { lead = "Decisions made at the time of the drop.", text = "Players choose after the item drops. Officers administer the process and do not determine who deserves loot." },
            { lead = "A draft and a separate off-spec list.", text = "Simultaneous drops are resolved in order, with each player's ranking submitted in advance, and an off-spec bid never displaces a player who needs the item for their main specialization." },
        } },
        { kind = "text", text = "Passing carries no cost. A player's position falls only when that player wins, and every other player's win raises it." },
    } },

    { id = "rules", label = "The rules", blocks = {
        { kind = "title", text = "The rules at the table" },
        { kind = "heading", text = "How it works in 60 seconds" },
        { kind = "numbered", items = {
            { lead = "One list.", text = "Every member has a position. The top belongs to whoever has gone longest without winning." },
            { lead = "Something drops.", text = "A small window asks each eligible player: Need, Off-spec, Gift or Pass. Each decides at that moment." },
            { lead = "The highest place that wants it wins,", text = "and drops to the bottom. That is the only way you lose a place." },
            { lead = "Passing is always free.", text = "" },
            { lead = "Everything is recorded", text = "in a ledger that any member of the guild can read and verify." },
        } },
        { kind = "heading", text = "The rules in detail" },
        { kind = "bullets", items = {
            { lead = "Who is asked.", text = "Only players who could use the item: their class can equip it and it carries enough of the stats their specialization values. An officer may override this for an item, and the override is recorded in the ledger." },
            { lead = "Need.", text = "Among all players who need it, the highest place wins and drops to the bottom." },
            { lead = "Off-spec.", text = "A separate off-spec list, so winning off-spec costs a player only on that list. A main-spec need always takes precedence over an off-spec bid." },
            { lead = "The draft.", text = "With several items, the top player chooses first and drops to the bottom, then the next. A player who wants more than one ranks them in advance, and the draft takes the highest-ranked item still available." },
            { lead = "Gifting.", text = "A winner may give the item to another player, in any direction. The giver pays the position; the recipient receives the item. Gifts rank after every player who wants the item for themselves." },
            { lead = "Nobody bids.", text = "The player at the bottom is the salvager, who may keep, give away, sell or disenchant the item, or pass it to the designated disenchanter and the guild bank." },
            { lead = "Disenchants", text = "are recorded together with what they actually gave." },
            { lead = "Mistakes", text = "are corrected with new entries (undo, trade, move, each with a reason). Nothing is erased." },
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
