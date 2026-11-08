-- King's Gambit: the tooltips for the window's buttons. Keep this file Lua 5.1-safe.
-- Each button explains what it does in full: the rule behind it, what it costs, who may use it. A grayed-out button's tooltip also says why it is
-- unavailable. The words describe the same rules as docs/rationale.md and docs/ledger-owner.md.
local _, SK = ...
local M = SK:NewModule("UITips")

M.TEXT = {
    -- answering for an item
    need = { "Need (main spec)", "Bid on this item as an upgrade for your main spec.\n\nWhen bidding closes, the main-spec draft goes down the list from the top: each player who bid on something picks one item they bid on. Whoever picks an item moves to the bottom of the main list; everyone else keeps their place.\n\nOnly for items your class may have. If it isn't, this is grayed out: you can still pass, or gift it." },
    off = { "Off-spec", "Bid on this item for your off-spec.\n\nOff-spec bids are drafted after the main-spec round, down a separate off-spec list. Winning here moves you to the bottom of the off-spec list, and does not cost you your place on the main list." },
    pass = { "Pass", "No bid on this item.\n\nYour answer is public, like everyone's. Passing costs nothing and never changes your place on any list." },
    gift = { "Gift", "Bid to win this item for someone else.\n\nYou can name who gets it later, if you win. They must be able to use it. Gifts are drafted after the main-spec and off-spec rounds, and as the winner you move to the bottom of the list. The Master Looter never chooses a gift's recipient for you." },
    -- the Master Looter's session controls
    resolve = { "Resolve now", "Master Looter: close bidding right now instead of waiting for the timer.\n\nThe drafts then run down the list. Items nobody bid on go to the salvage round." },
    extend = { "Add 30 seconds", "Master Looter: add 30 seconds to the bid timer, or to the current player's turn, so people have time to answer." },
    confirm = { "Confirm", "Master Looter: after the draft, review the results and confirm to hand every item over and record the wins in the ledger.\n\nNothing is handed out or recorded until you confirm. You can only record if a raid is open with you as its Master Looter (an officer opens it)." },
    cancel = { "Cancel the session", "Master Looter: end this session. Nothing is handed out and nothing is recorded." },
    start = { "Start from the loot window", "Master Looter: with the boss's loot window open, start a session for all its items.\n\nEveryone in the raid gets this window and answers for each item. The loot method must be Master Looter (the raid leader sets it)." },
    -- your turn
    pick = { "Pick this item", "Your turn in the draft: take this item.\n\nYou move to the bottom of the list. You may only pick one of the items you bid on." },
    skip = { "Skip", "Give up the rest of this round. Passing on your turn is always free, and your place does not change." },
    claim = { "Claim it", "Salvage: take this item that nobody wanted. It is yours to keep, sell, or gift on. Declining sends it to the disenchanter instead." },
    decline = { "Decline", "Salvage: you don't want it. It goes to the disenchanter. It is never offered to anyone else." },
    give = { "Give it", "Name who gets the gift you won. They must be able to use it. Type the name, or leave it, keep it yourself, or withdraw." },
    keep = { "Keep it", "Keep the gift yourself. Only allowed if the item is for your class (or you are the salvager)." },
    withdraw = { "Withdraw", "Give up the gift: it counts as your pass, and the draft moves on to the next player." },
    -- practice
    kill = { "Kill the next practice boss", "Practice only: the next practice boss dies and drops two items. The simulated raiders answer as their class and role would, just like in the simulator on the website." },
    handout = { "Hand out the held loot", "Practice only: put loot that was held back up for bidding." },
    wait = { "Wait 10 seconds", "Practice only: let 10 simulated seconds pass, so bid timers run out and the simulated raiders answer." },
    practice = { "Practice mode", "Run everything in this window on a simulated raid and guild, with loot from your own gear.\n\nNothing in practice mode is saved, sent to anyone or recorded: your real ledger is untouched. Untick it to go back." },
    practicelesson = { "Practice lesson", "Choose what to practice: a raid night on the gear you carry (the default), or one of the lessons from the web page. A lesson is a set raid and a set drop with a known right answer: you play it, and at the end it says whether what happened matches the lesson. Changing it restarts practice." },
    lessonstart = { "Start the lesson", "Bids and timers begin when you press this. Read the lesson first." },
    lessonagain = { "Try again", "Run the lesson again from the start, with the same raid and the same drop." },
    lessonnext = { "Next lesson", "Go on to the next lesson (simple ones first, harder ones later)." },
    statssort = { "Sort the stats", "Click a heading to sort by it: a name from A to Z, a count with the most at the top, the places from first. Click it again to reverse the order. It opens with the most active (most wins) at the top." },
    bidspick = { "Everyone", "Tick this to see every player's answer on this item in a window beside this one: who wants it, who passed, who has not answered yet, each with their place on the list. One item at a time; untick it to close." },
    practicesize = { "Practice group size", "How many players the simulated group has, from a 5-player party to a 40-player raid. Changing it restarts practice." },
    -- ranking
    rankup = { "Move up", "Move this item up your order (not saved until you confirm): higher means you want it more. On your turn in the draft you get the highest-ranked item still available, with no prompt." },
    rankdown = { "Move down", "Move this item down your order (not saved until you confirm): lower means you want it less." },
    rankconfirm = { "Confirm order", "Confirm the order shown (most wanted first). Wanting several items means saying which you want most; the session waits for that, and on your turn the draft takes your highest-ranked item still available for you, so nobody is asked live.\n\nMove items up or down first if the order isn't right. Moving only rearranges what you see: nothing is sent until you press Confirm, so you can keep deciding." },
    -- the windows
    navlists = { "Lists", "The standings: who is first for what. Officers (and a raid's Master Looter) move players here." },
    tryon = { "Try it on", "See how this entry's item looks on your character, in the game's dressing room. You can also Ctrl-click an entry. It only shows the item; nothing is recorded or equipped." },
    navwelcome = { "Welcome", "What King's Gambit is, how loot works, what the guild values and where everything is. The addon opens on this page until you turn that off (the checkbox at its foot); it is always here." },
    welcomefirst = { "Show the welcome page first", "While this is ticked, King's Gambit opens on the Welcome page. Untick it when you have read it: from then on it opens on the section you last had open." },
    retireledger = { "Retire or keep", "Retire: remove this ledger's saved data from this computer (it asks first; only an officer of its guild can). Nothing in the ledger is erased and nobody else's copy is touched. An officer's retirement is told to the guild: each member can restore it or let it expire in 30 days. The ledger in use now is removed at your next login.\n\nKeep: bring a retired ledger back. Everyone is told, and if its data was removed here it is fetched again from whoever still has it." },
    navstats = { "Stats", "Who is at which place and for how long, who has won and when, worked out from the record. Click a player to see every place they have held." },
    raidautostart = { "Start by itself", "Ticked (the default): the raid starts by itself when the first enemy dies inside an instance, boss or trash. Unticked: you take control, and nothing starts it but Start the raid now. Kept for this character." },
    raidstartnow = { "Start the raid now", "Start the raid yourself, wherever it is (a world boss, for one): everyone in the group at this moment is written down as being there, and the group is followed from then on." },
    navthisraid = { "This raid", "The raid that is open now: how long it has run, how many items have been handed out, what the Master Looter still holds to hand out and how long it can be traded, and the raid's own part of the ledger." },
    raidtoggle = { "End or open a raid", "Practice. While a raid is open this ends it: the Master Looter closes it (the same as 'raid close'), recorded in the ledger. Hand out the held loot first. When none is open it opens the next one a few days later (the same as 'raid open'): a couple of raiders can't make it, and the bosses are back. Stats and the Ledger then cover more than one raid." },
    leaveraid = { "Someone leaves", "Practice: a raider leaves the group mid-raid (a disconnect, called away). The addon writes down that they left, and what they miss is shown in Stats." },
    rejoinraid = { "Someone returns", "Practice: the raider who left comes back, and the addon writes down that they rejoined." },
    navledger = { "Ledger", "The record of everything that happened to the lists, in words: who won what, who moved whom, and why. Nothing in it can be edited or erased." },
    navawards = { "Awards", "Record a win the session missed, undo an award, note where an item went. Corrections are new entries; nothing is erased." },
    navraids = { "Raids", "Open and close a raid, choose its Master Looter, its list and its disenchanter." },
    navpeople = { "People", "Add, remove and move players; who the officers are (the game's rank permission) and who is being disregarded; and your own spec." },
    navrules = { "Rules", "Which classes may bid on an item, who it suits, and requests to the Master Looter." },
    navadmin = { "Admin", "Starting a list, the record's format and versions, syncing: the ledger owner's and maintenance steps. (The record itself is the Ledger.)" },
    historykind = { "Show", "What happened (the default) leaves out passes: they are the most common entries and say what could have happened to an item, not what did. Passes stay in the record: choose Passes to see only them, or Everything to see all." },
    historyfind = { "Find", "Type part of a player's or an item's name to show only the entries that mention it." },
    lootwindow = { "Loot window", "Show or hide the small window for a live loot session. It opens by itself when a session starts, so you only need this to look at it between sessions or to bring it back after closing it." },
    -- standings
    listpick = { "Which list", "Choose which list to look at. Each raid plays on one list; the officers and the ledger owner decide which (see Tools, Raid)." },
    sort = { "Sort", "Click to sort the table by this column; click again to reverse it.\n\nThis only changes how the table is shown. It never changes the list's real order, which is the order players are called in." },
    top = { "Move to the top", "Stage a move of the selected player to the top of this list.\n\nNothing is recorded yet: the table shows the list as it would be. Stage as many changes as you like, then press Apply all (with a reason); Discard drops them." },
    up = { "Up one place", "Stage a move of the selected player up one place. Each press only changes the preview; nothing is recorded until you press Apply all." },
    down = { "Down one place", "Stage a move of the selected player down one place. Each press only changes the preview; nothing is recorded until you press Apply all." },
    bottom = { "Move to the bottom", "Stage a move of the selected player to the bottom of this list. Nothing is recorded until you press Apply all." },
    place = { "To place", "Type the place to move the selected player to, then Set. You can also drag a player onto another row. Either way it is only a preview until you press Apply all." },
    apply = { "Apply all", "Write every pending change to the shared ledger, one after another, each with the reason you typed. A reason is required: it is part of the record, with who made the change. If one is refused, the ones already written stay and the rest stay staged.\n\nThe Ledger is never rewritten: the old order stays visible." },
    cancelmove = { "Discard", "Drop every pending change. Nothing was recorded." },
    remove = { "Remove from the list", "Stage taking the selected player off this list. It is recorded when you press Apply all, with your reason.\n\nThe record keeps the place they were at, so they can be put back there." },
    award = { "Record a win", "Open the 'Record a win' form for the selected player: for a win a session didn't record (a failed hand-out, a corrected winner).\n\nThey move to the bottom of the list, as after any win. You choose the item and give a reason." },
    addall = { "Add everyone from your group and guild", "Add every player in your group and guild who isn't on this list yet, with their classes.\n\nThis writes one entry per player to the shared ledger, the same as the 'add' command, so only an officer (or a raid's Master Looter) can." },
    startledger = { "Start the ledger", "Found this guild's ledger and create the main list, with you as the ledger owner.\n\nDo this once, on the character that should be ledger owner. Everyone else gets the ledger by syncing with you. Two people founding separate ledgers end up with two unrelated ones." },
    -- tools
    dothis = { "Do it", "Run this form's command: the same one you could type in chat. If you aren't allowed, the output at the foot of the window says why, and nothing is changed." },
}

-- What a tooltip says: an id from TEXT, a { title, text } pair, or a function returning title, text. `extra` (optional, a function) gives a line to
-- add at hover time (a button that is grayed out says why).
function M.Resolve(tip)
    if type(tip) == "function" then return tip() end
    if type(tip) == "string" then tip = M.TEXT[tip] end
    if type(tip) == "table" then return tip[1], tip[2] end
end

function M.Attach(frame, tip, extra)
    if not frame then return end
    local function enter(self)
        if not GameTooltip then return end
        local title, text = M.Resolve(tip)
        if not title then return end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(title, 1, 1, 1)
        if text then GameTooltip:AddLine(text, 0.85, 0.85, 0.85, true) end
        local more = extra and extra()
        if more then GameTooltip:AddLine("\n" .. more, 1, 0.5, 0.25, true) end
        GameTooltip:Show()
    end
    local function leave() if GameTooltip then GameTooltip:Hide() end end
    -- A grayed-out button should still explain itself.
    if frame.SetMotionScriptsWhileDisabled then frame:SetMotionScriptsWhileDisabled(true) end
    if frame.HookScript then
        frame:HookScript("OnEnter", enter); frame:HookScript("OnLeave", leave)
    else
        frame:SetScript("OnEnter", enter); frame:SetScript("OnLeave", leave)
    end
end

function M:OnInit() end
