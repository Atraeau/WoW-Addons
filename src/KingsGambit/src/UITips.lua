-- King's Gambit: the tooltips for the window's buttons. Keep this file Lua 5.1-safe.
-- Each button explains what it does in full: the rule behind it, what it costs, who may use it. A greyed-out button's tooltip also says why it is
-- unavailable. The words describe the same rules as docs/rationale.md and docs/guild-master.md.
local _, SK = ...
local M = SK:NewModule("UITips")

M.TEXT = {
    -- answering for an item
    need = { "Need (main spec)", "Bid on this item as an upgrade for your main spec.\n\nWhen bidding closes, the main-spec draft goes down the list from the top: each player who bid on something picks one item they bid on. Whoever picks an item moves to the bottom of the main list; everyone else keeps their place.\n\nOnly for items your class may have. If it isn't, this is greyed out: you can still pass, or gift it." },
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
    practicesize = { "Practice group size", "How many players the simulated group has, from a 5-player party to a 40-player raid. Changing it restarts practice." },
    -- the windows
    lootwindow = { "Loot window", "Show or hide the small window for a live loot session. It opens by itself when a session starts, so you only need this to look at it between sessions or to bring it back after closing it." },
    -- standings
    listpick = { "Which list", "Choose which list to look at. Each raid plays on one list; the officers and the guild master decide which (see Tools, Raid)." },
    sort = { "Sort", "Click to sort the table by this column; click again to reverse it.\n\nThis only changes how the table is shown. It never changes the list's real order, which is the order players are called in." },
    top = { "Move to the top", "Stage a move of the selected player to the top of this list.\n\nNothing is recorded yet: the table shows where they would go. Press Apply move (with a reason) to record it as one entry; Cancel to drop it." },
    up = { "Up one place", "Stage a move of the selected player up one place. Each press only changes the preview; nothing is recorded until you press Apply move, so several presses make one entry." },
    down = { "Down one place", "Stage a move of the selected player down one place. Each press only changes the preview; nothing is recorded until you press Apply move, so several presses make one entry." },
    bottom = { "Move to the bottom", "Stage a move of the selected player to the bottom of this list. Nothing is recorded until you press Apply move." },
    place = { "To place", "Type the place to move the selected player to, then Set. You can also drag a player onto another row. Either way it is only a preview until you press Apply move." },
    apply = { "Apply move", "Record the staged move as a single entry in the shared ledger, with the reason you typed. A reason is required: it is part of the record, with who made the change.\n\nHistory is never rewritten: the old order stays visible." },
    cancelmove = { "Cancel the move", "Drop the staged move. Nothing was recorded." },
    remove = { "Remove from the list", "Take the selected player off this list. A reason is optional but recommended.\n\nThe record keeps the place they were at, so they can be put back there." },
    award = { "Record a win", "Open the 'Record a win' form for the selected player: for a win a session didn't record (a failed hand-out, a corrected winner).\n\nThey move to the bottom of the list, as after any win. You choose the item and give a reason." },
    addall = { "Add everyone from your group and guild", "Add every player in your group and guild who isn't on this list yet, with their classes.\n\nThis writes one entry per player to the shared ledger, the same as the 'add' command, so only an officer (or a raid's Master Looter) can." },
    startledger = { "Start the ledger", "Found this guild's ledger and create the main list, with you as the guild master.\n\nDo this once, on the character that should be guild master. Everyone else gets the ledger by syncing with you. Two people founding separate ledgers end up with two unrelated ones." },
    -- tools
    dothis = { "Do it", "Run this form's command: the same one you could type in chat. If you aren't allowed, the output at the foot of the window says why, and nothing is changed." },
}

-- What a tooltip says: an id from TEXT, a { title, text } pair, or a function returning title, text. `extra` (optional, a function) gives a line to
-- add at hover time (a button that is greyed out says why).
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
    -- A greyed-out button should still explain itself.
    if frame.SetMotionScriptsWhileDisabled then frame:SetMotionScriptsWhileDisabled(true) end
    if frame.HookScript then
        frame:HookScript("OnEnter", enter); frame:HookScript("OnLeave", leave)
    else
        frame:SetScript("OnEnter", enter); frame:SetScript("OnLeave", leave)
    end
end

function M:OnInit() end
