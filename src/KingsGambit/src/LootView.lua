-- King's Gambit: what the Loot window shows, as a plain table. Keep this file Lua 5.1-safe.
--
-- Build(model) turns what UILoot.Model reads from a session into the window itself: its state, its timer, each item's row and buttons (enabled or
-- greyed, and why), the panel for a player's turn, and the Master Looter's strip. Nothing here draws or runs anything. The game draws it with the
-- game's frames and the web simulator draws it as HTML; both read these same tables, so the two show the same screens, the same words, and the same
-- greyed-out buttons. A button carries `act`, a neutral description of what it does ({ name = "bid", item = 2, kind = "need" }); each place maps
-- that to its own way of running it (the game types the same command a player could, the page calls the engine).
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local Tips
local M = SK:NewModule("LootView", { "UITips" }, function(d) Tips = d.UITips end)

-- The four answers, in the order they are shown. `letter` is there so colour is never the only difference.
M.ANSWERS = {
    { key = "need", letter = "N", label = "Need" },
    { key = "off", letter = "O", label = "Off-spec" },
    { key = "gift", letter = "G", label = "Gift" },
    { key = "pass", letter = "P", label = "Pass" },
}

local TIER = { main = "main-spec draft", off = "off-spec draft", gift = "gift draft", salvage = "salvage" }

local WHY = {
    cantequip = "Your class can't wear or wield this. You can still gift it or pass.",
    nostats = "Nothing on this helps your class. You can still gift it or pass.",
    wrongclass = "This isn't for your class. You can still gift it or pass.",
}

local function tipOf(id)
    local t = Tips and Tips.TEXT and Tips.TEXT[id]
    if t then return { title = t[1], text = t[2] } end
end

local function button(key, label, act, o)
    o = o or {}
    return { key = key, letter = o.letter, label = label, act = act, tip = tipOf(o.tip or key), enabled = o.enabled ~= false,
        why = o.why, selected = o.selected or false, primary = o.primary or false }
end

local function answerButtons(m, row)
    local out = {}
    for _, a in ipairs(M.ANSWERS) do
        local enabled, why = true, nil
        if (a.key == "need" or a.key == "off") and row.canBid == false then
            enabled, why = false, WHY[row.whyNot] or "This isn't for your class."
        end
        out[#out + 1] = button(a.key, a.label, { name = "bid", item = row.id, kind = a.key },
            { letter = a.letter, enabled = enabled, why = why, selected = row.mine == a.key })
    end
    return out
end

local function answerText(row)
    if row.mine == "gift" then return "You: Gift" .. (row.mineTo and (" to " .. row.mineTo) or " (you'll choose who if you win)") end
    local word = ({ need = "Need", off = "Off-spec", pass = "Pass" })[row.mine]
    return word and ("You: " .. word) or nil
end

-- The window, for one player. `m` is UILoot.Model's table.
function M.Build(m)
    local v = { visible = false, state = "none", rows = {}, practice = m.practice or false }
    if m.mode == "none" then
        v.night = m.night
        return v
    end
    v.visible = true
    v.title = "King's Gambit"
    v.subtitle = m.phaseText
    v.place = m.place
    v.isML = m.isML or false
    if m.seconds and (m.phase == "bidding" or m.turn or m.waitingFor) then
        v.timer = { seconds = m.seconds, fraction = (m.total and m.total > 0) and math.min(1, m.seconds / m.total) or nil,
            urgent = m.seconds <= 10 }
    end

    local phase = m.phase
    local bidding = phase == "bidding"
    local turn = m.turn

    -- the state, which decides what the window leads with
    if phase == "cancelled" then v.state = "cancelled"
    elseif phase == "done" then v.state = "result"
    elseif phase == "review" then v.state = "review"
    elseif turn then v.state = "myturn"
    elseif m.waitingFor then v.state = "turn"
    elseif bidding then
        local open = 0
        for _, r in ipairs(m.items) do if not r.mine then open = open + 1 end end
        v.state = open == 0 and "waiting" or "bidding"
    else v.state = "turn" end

    -- the line under the title
    if bidding and m.answered and m.eligible then
        v.progress = ("%d of %d answered"):format(m.answered, m.eligible)
    end

    -- rows: one per item
    for _, r in ipairs(m.items) do
        local row = { id = r.id, link = r.link, tip = r.tip, buttons = {}, note = nil, giftTargets = r.giftTargets }
        if bidding then
            row.state = r.mine and "answered" or "open"
            row.buttons = answerButtons(m, r)
            row.note = answerText(r)
            if r.canBid == false then row.warn = WHY[r.whyNot] or "This isn't for your class." end
        elseif r.winner then
            row.state = "awarded"
            local to = (r.to and r.to ~= r.winner) and (" for " .. r.to) or ""
            row.note = r.winner .. to .. (r.tier and (" (" .. (TIER[r.tier] or r.tier) .. ")") or "")
            row.mineWon = (r.winner == m.me) or (r.to == m.me)
        elseif r.status == "de" then
            row.state, row.note = "unwanted", "Goes to the disenchanter"
        else
            row.state, row.note = "locked", answerText(r) or "Bidding is closed"
        end
        v.rows[#v.rows + 1] = row
    end
    v.hidden = m.hidden

    -- what the window says to the player, in plain words
    if v.state == "myturn" then
        if turn.type == "pick" then
            v.turn = { kind = "pick", text = "Your turn: pick one item. You'll move to the bottom of the list.", buttons = {}, itemLink = nil }
            for _, id in ipairs(turn.options or {}) do
                local link
                for _, r in ipairs(m.items) do if r.id == id then link = r.link end end
                v.turn.buttons[#v.turn.buttons + 1] = button("pick", "Pick", { name = "pick", item = id }, { primary = true })
                v.turn.buttons[#v.turn.buttons].link = link
                v.turn.buttons[#v.turn.buttons].item = id
            end
            v.turn.buttons[#v.turn.buttons + 1] = button("skip", "Skip", { name = "skip" })
        elseif turn.type == "recipient" then
            v.turn = { kind = "recipient", text = "You won a gift. Who gets it? The draft waits for you.", item = turn.item, itemLink = turn.itemLink,
                targets = turn.targets, buttons = {} }
            v.turn.buttons[1] = button("give", "Give it", { name = "give", item = turn.item }, { primary = true })
            v.turn.buttons[1].needsTarget = true
            v.turn.buttons[2] = button("keep", "Keep it", { name = "keep", item = turn.item },
                { enabled = turn.canKeep ~= false, why = turn.canKeep == false and "It isn't for your class, and you aren't the salvager." or nil })
            v.turn.buttons[3] = button("withdraw", "Withdraw", { name = "withdraw", item = turn.item })
        else
            v.turn = { kind = "salvage", text = "Nobody wanted this. Claim it, claim it and gift it on, or decline and the disenchanter takes it.", item = turn.item,
                itemLink = turn.itemLink, targets = turn.targets, buttons = {} }
            v.turn.buttons[1] = button("claim", "Claim it", { name = "claim", item = turn.item }, { primary = true })
            v.turn.buttons[2] = button("claimgift", "Claim and gift", { name = "claim", item = turn.item, gift = true }, { tip = "claim" })
            v.turn.buttons[2].needsTarget = true
            v.turn.buttons[3] = button("decline", "Decline", { name = "decline", item = turn.item })
        end
    elseif v.state == "turn" then
        v.banner = { kind = "info", text = ("Waiting for %s%s"):format(m.waitingFor or "the next player", m.phase and TIER[m.phase] and (" (" .. TIER[m.phase] .. ")") or "") }
    elseif v.state == "waiting" then
        v.banner = { kind = "info", text = "You've answered everything. Waiting for the others. You can still change an answer until bidding closes." }
    elseif v.state == "review" then
        v.banner = { kind = "info", text = m.isML and "Review what will be recorded, then confirm." or "The Master Looter is confirming the loot." }
    elseif v.state == "cancelled" then
        v.banner = { kind = "warn", text = "Cancelled. Nothing was recorded." }
    elseif v.state == "result" then
        local won = {}
        for _, row in ipairs(v.rows) do if row.mineWon then won[#won + 1] = row.link end end
        v.banner = { kind = "good", text = #won > 0 and ("You won: " .. table.concat(won, ", ")) or "Finished. Nothing for you this time." }
    end

    -- the Master Looter's strip
    if m.isML then
        v.ml = { buttons = {
            button("resolve", "Resolve now", { name = "resolve" }, { enabled = m.can.resolve, why = (not m.can.resolve) and "Only while bidding is open." or nil }),
            button("extend", "+30 seconds", { name = "extend", seconds = 30 }, { enabled = m.can.extend, why = (not m.can.extend) and "Only while there is a timer." or nil }),
            button("confirm", "Confirm", { name = "confirm" }, { enabled = m.can.confirm, primary = m.can.confirm,
                why = (not m.can.confirm) and "After the draft, when the result is in review." or nil }),
            button("cancel", "Cancel", { name = "cancel" }, { enabled = m.can.cancel, why = (not m.can.cancel) and "There is nothing running to cancel." or nil }),
        }, pending = m.pending }
    end
    return v
end

function M:OnInit() end
