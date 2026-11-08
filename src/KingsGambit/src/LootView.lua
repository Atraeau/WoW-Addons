-- King's Gambit: what the Loot window shows, as a plain table. Keep this file Lua 5.1-safe.
--
-- Build(model) turns what UILoot.Model reads from a session into the window itself: its state, its timer, each item's row and buttons (enabled or
-- grayed, and why), the panel for a player's turn, and the Master Looter's strip. Nothing here draws or runs anything. The game draws it with the
-- game's frames and the web simulator draws it as HTML; both read these same tables, so the two show the same screens, the same words, and the same
-- grayed-out buttons. A button carries `act`, a neutral description of what it does ({ name = "bid", item = 2, kind = "need" }); each place maps
-- that to its own way of running it (the game types the same command a player could, the page calls the engine).
-- Design: docs/ui-design.md, section 5.1.
local _, SK = ...
local Tips, ItemFit
local M = SK:NewModule("LootView", { "UITips", "ItemFit?" }, function(d) Tips, ItemFit = d.UITips, d.ItemFit end)

-- The game's class colors (hex, no alpha), so a name is colored the same in the game, on the page and in the list.
M.CLASS_COLOR = { WARRIOR = "c79c6e", PALADIN = "f58cba", HUNTER = "abd473", ROGUE = "fff569", PRIEST = "ffffff", SHAMAN = "0070de",
    MAGE = "69ccf0", WARLOCK = "9482c9", DRUID = "ff7d0a" }

-- A line of text made of pieces: plain words, and people. A person carries what a renderer needs to draw them like the standings list does: their name in the
-- class color, with their spec and class under or beside it (the spec only where it is known). `text` is the same line as plain words, for anything that
-- can't draw the pieces.
local function line()
    local b = { segments = {}, parts = {} }
    function b.text(t) b.segments[#b.segments + 1] = { text = t }; b.parts[#b.parts + 1] = t end
    function b.who(w, label, short)
        label = label or (w and w.name) or "?"
        if not w then return b.text(label) end
        b.segments[#b.segments + 1] = { who = { name = label, class = w.class, className = (ItemFit and ItemFit.CLASS_NAMES or {})[w.class],
            spec = w.spec, color = M.CLASS_COLOR[w.class], short = short or nil } }
        b.parts[#b.parts + 1] = label
    end
    function b.plain() return table.concat(b.parts) end
    return b
end

-- The four answers, in the order they are shown. `letter` is there so color is never the only difference.
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
    v.lesson = m.lesson
    if m.mode == "none" then
        v.night = m.night
        return v
    end
    v.night = m.night
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
            -- who gets it: the winner, who it is given to if not the winner, which round, and where the winner falls on the list
            row.state = "awarded"
            local you = r.winnerIsMe
            local b = line()
            b.who(r.winnerWho or { name = r.winner }, you and "You" or r.winner)
            b.text((you and " win" or " wins") .. (r.tier and (" (" .. (TIER[r.tier] or r.tier) .. ")") or ""))
            if r.undecided then
                b.text(you and ", and haven't chosen who gets it yet" or ", and hasn't chosen who gets it yet")
            elseif r.to and r.to ~= r.winner then
                b.text(you and " and give it to " or " and gives it to ")
                b.who(r.toWho or { name = r.to }, r.toIsMe and "you" or r.to)
            end
            if r.from and r.from > 0 and r.tier ~= "salvage" then
                b.text((" · moves from place %d to the bottom of the %s"):format(r.from, r.tier == "off" and "off-spec list" or "list"))
            end
            row.note, row.segments = b.plain(), b.segments
            row.mineWon = (r.winnerIsMe or r.toIsMe) and true or false
            row.winnerName = r.winner
        elseif r.status == "de" then
            row.state, row.note = "unwanted", "Nobody wanted it: goes to the disenchanter" .. (r.deTo and (", " .. r.deTo) or "")
        else
            row.state, row.note = "locked", answerText(r) or "Bidding is closed"
        end
        v.rows[#v.rows + 1] = row
    end
    v.hidden = m.hidden

    -- Where you want several items of one kind, which you want most. Until it is set the session waits for you (and the window says so).
    local KIND = { need = "main-spec", off = "off-spec", gift = "gift" }
    if bidding and m.rankings and #m.rankings > 0 then
        v.rankings = {}
        local incomplete = 0
        for _, g in ipairs(m.rankings) do
            local ids = {}
            for i, it in ipairs(g.items) do ids[i] = it.id end
            local panel = { kind = g.kind, title = ("Your order for the %s items (most wanted first)"):format(KIND[g.kind] or g.kind), complete = g.complete, dirty = g.dirty, items = {} }
            for i, it in ipairs(g.items) do
                local function swapped(j)
                    local o = {}
                    for k, id in ipairs(ids) do o[k] = id end
                    o[i], o[j] = o[j], o[i]
                    return o
                end
                panel.items[i] = { id = it.id, link = it.link, tip = it.tip, position = i, ranked = it.rank ~= nil,
                    -- Up and Down only rearrange the draft (`rankmove`); nothing is held by the session until Confirm (`rank`).
                    up = button("rankup", "Up", { name = "rankmove", kind = g.kind, order = i > 1 and swapped(i - 1) or ids }, { enabled = i > 1 }),
                    down = button("rankdown", "Down", { name = "rankmove", kind = g.kind, order = i < #ids and swapped(i + 1) or ids }, { enabled = i < #ids }) }
            end
            panel.confirm = button("rankconfirm", g.complete and "Order set" or "Confirm order", { name = "rank", kind = g.kind, order = ids },
                { enabled = not g.complete, primary = not g.complete })
            if not g.complete then incomplete = incomplete + 1 end
            v.rankings[#v.rankings + 1] = panel
        end
        if incomplete > 0 and (v.state == "bidding" or v.state == "waiting") then v.state = "ranking" end
    end

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
            if turn.targets and #turn.targets == 0 then
                v.turn.noTargets = true
                v.turn.text = "You won a gift, but nobody in your group can have this item. Keep it or withdraw. The draft waits for you."
            end
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
        local b = line()
        b.text("Waiting for ")
        b.who(m.waitingWho or { name = m.waitingFor or "the next player" }, m.waitingFor or "the next player")
        b.text(m.phase and TIER[m.phase] and (" (" .. TIER[m.phase] .. ")") or "")
        v.banner = { kind = "info", text = b.plain(), segments = b.segments }
    elseif v.state == "ranking" then
        v.banner = { kind = "warn", text = "Put the items you want in order, most wanted first, then confirm. The session waits for your order." }
    elseif v.state == "waiting" then
        v.banner = { kind = "info", text = "You've answered everything. Waiting for the others. You can still change an answer until bidding closes." }
    elseif v.state == "review" then
        v.banner = { kind = "info", text = m.isML
            and "Review: this is who gets what. Nothing is handed out or recorded until you confirm."
            or "The Master Looter is reviewing the loot. Who gets what is shown below." }
    elseif v.state == "cancelled" then
        local again = (m.lesson and "Nothing was recorded. Press Try again to run the lesson again.")
            or ((m.night and (m.night.held or 0) > 0) and "Nothing was recorded, and the loot is still on the boss: hand it out again whenever you are ready.")
        v.banner = { kind = "warn", text = again and ("Cancelled. " .. again) or "Cancelled. Nothing was recorded." }
    elseif v.state == "result" then
        local won = {}
        for _, row in ipairs(v.rows) do if row.mineWon then won[#won + 1] = row.link end end
        v.banner = { kind = "good", text = #won > 0 and ("You won: " .. table.concat(won, ", ")) or "Finished. Nothing for you this time." }
    end

    -- who has bid on what, as it happens (answers are public): while bidding is open, a line for each item. The window lets it be hidden.
    v.sessionKey = m.sessionKey
    if m.board and #m.board > 0 then
        v.bids = { items = {}, answered = m.answered, eligible = m.eligible, live = (v.state == "bidding" or v.state == "waiting") }
        for _, e in ipairs(m.board) do
            local b = line()
            local any = false
            for _, k in ipairs({ { "need", "Need" }, { "off", "Off-spec" }, { "gift", "Gift" } }) do
                local list = e[k[1]]
                if #list > 0 then
                    if any then b.text("   ") end
                    b.text(k[2] .. ": ")
                    for i, w in ipairs(list) do
                        if i > 1 then b.text(", ") end
                        b.who(w, nil, true)
                    end
                    any = true
                end
            end
            local rest = {}
            if e.pass > 0 then rest[#rest + 1] = ("Pass %d"):format(e.pass) end
            if e.waiting > 0 then rest[#rest + 1] = ("waiting on %d"):format(e.waiting) end
            if #rest > 0 then b.text((any and "   " or "") .. table.concat(rest, ", ")) end
            if not any and #rest == 0 then b.text("Nobody to answer.") end
            -- everyone's answer on this item (the side panel, scrollable): one row per player in a fixed order, their place on the list, and what they said
            -- (the rows never move as answers come in: only a row's status changes)
            local STATUS = { need = { "Need", "40ff40" }, off = { "Off-spec", "69b4ff" }, gift = { "Gift", "c080ff" }, pass = { "Pass", "999999" },
                waiting = { "not answered yet", "777777" }, away = { "away", "777777" } }
            local people = {}
            for _, p in ipairs(e.all or {}) do
                local st = STATUS[p.kind] or STATUS.waiting
                local g = line()
                g.text(p.place .. ". ")
                g.who(p.who)
                g.text("  |cff" .. st[2] .. st[1] .. ((p.kind == "gift" and p.to) and (" to " .. p.to) or "") .. "|r")
                people[#people + 1] = { place = p.place, kind = p.kind, segments = g.segments, text = g.plain() }
            end
            v.bids.items[#v.bids.items + 1] = { id = e.id, link = e.link, segments = b.segments, text = b.plain(), people = people }
        end
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
