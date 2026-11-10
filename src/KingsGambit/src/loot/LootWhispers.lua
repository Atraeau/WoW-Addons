-- King's Gambit: the loot session, the whisper fallback: how a player without the addon answers, the prompts and menus sent to them, and reading what they whisper back. Keep this file Lua 5.1-safe.
-- Part of the Loot module (Loot.lua): Loot calls Install, which adds these methods to the Session class.
local _, SK = ...
local ItemFit
local M = SK:NewModule("LootWhispers", { "ItemFit" }, function(d) ItemFit = d.ItemFit end)

---------------------------------------------------------------- whisper fallback
-- Players without the addon answer by whispering the Master Looter. Accepted forms (case does
-- not matter; several answers can be joined with commas or semicolons):
--   "need"  "off"  "pass"  "gift Name"            (when there is only one item)
--   "1 need"  "need 1"  "#2 pass"  "2: off"  "1 gift Name"   (item number, either side)
--   "pass"                                         (several items: passes on all of them)
--   "1 need ready"                                 (a token: I have what it takes to turn it in)
local WORDS = { need = "need", n = "need", greed = "off", off = "off", o = "off", os = "off", offspec = "off",
    ["off-spec"] = "off", pass = "pass", p = "pass", gift = "gift", g = "gift" }

-- Returns an array of { item, kind, to, ready } (item may be nil = "all items", only for pass), a reason when it can't be read ("empty", "unclear",
-- "needitem", "needtarget"; then the array is nil), and the spec the player named, if any ("fury: 1n 2p" or "spec fury 1n 2p"). One message can answer
-- every item: "1 need 2 pass 3 off", "1n, 2p, 3o", "pass all". The order the answers are written in is the order they are ranked in.
function M.ParseWhisper(text, itemCount)
    if type(text) ~= "string" then return nil, "empty" end
    local answers, spec = {}, nil
    local function finish(cur)
        if not cur then return true end
        if not cur.kind then
            if cur.all then cur.kind = "pass" else return nil, "unclear" end
        end
        if cur.kind == "gift" and not cur.to then return nil, "needtarget" end
        local item = cur.item
        if cur.all then
            if cur.kind ~= "pass" then return nil, "needitem" end
            item = nil
        elseif not item then
            if itemCount == 1 then item = 1
            elseif cur.kind == "pass" then item = nil -- all items
            else return nil, "needitem" end
        end
        answers[#answers + 1] = { item = item, kind = cur.kind, to = cur.to, ready = cur.ready }
        return true
    end
    for part in text:lower():gmatch("[^,;]+") do
        local words = {}
        for w in part:gmatch("[^%s]+") do words[#words + 1] = w end
        local cur
        local i = 1
        while i <= #words do
            local w = words[i]
            local num, letter = w:match("^#?(%d+)([nogp])$")
            local plain = w:match("^#?(%d+):?$")
            local specName = w:match("^([%a%-]+):$")
            if w == "spec" and words[i + 1] and not spec then
                spec = words[i + 1]; i = i + 1
            elseif specName and not WORDS[specName] and not spec then
                spec = specName
            elseif num then
                local ok, why = finish(cur); if not ok then return nil, why end
                cur = { item = tonumber(num), kind = WORDS[letter] }
            elseif plain then
                if cur and cur.item == nil and not cur.all then cur.item = tonumber(plain)
                else
                    local ok, why = finish(cur); if not ok then return nil, why end
                    cur = { item = tonumber(plain) }
                end
            elseif w == "all" then
                cur = cur or {}
                if cur.item or cur.all then return nil, "unclear" end
                cur.all = true
            elseif w == "ready" and not (cur and cur.ready) then cur = cur or {}; cur.ready = true
            elseif WORDS[w] and (not cur or not cur.kind) then
                cur = cur or {}
                cur.kind = WORDS[w]
            elseif cur and cur.kind == "gift" and not cur.to and w:match("^[%a%-']+$") then cur.to = w
            else return nil, "unclear" end
            i = i + 1
        end
        local ok, why = finish(cur); if not ok then return nil, why end
    end
    if #answers == 0 then
        if spec then return answers, nil, spec end
        return nil, "empty"
    end
    return answers, nil, spec
end

-- Session: the class table to add methods to; h: what Loot.lua shares (and what the parts installed before this one exported).
function M.Install(Session, h)
local norm = h.norm

local WHISPER_HELP = "Reply n (need), o (off-spec), g (gift) or p (pass) to the item I sent; '3 p' answers item 3, 'pass all' passes everything. You can change answers until the timer ends."

local function whisperProblem(reason)
    if reason == "needitem" then return "Which item? Put its number first, e.g. '1 need'. " .. WHISPER_HELP end
    if reason == "needtarget" then return "Who should get it? e.g. '1 gift Name'." end
    return "I didn't understand that. " .. WHISPER_HELP
end

-- Everything this Master Looter says to a player by whisper goes through here: one message at a time, with a gap between them (`cfg.whisperGap`, the game's
-- limits), so a raid full of players without the addon can't flood the sender. With no gap, it is sent at once.
function Session:say(to, text)
    local gap = self.cfg.whisperGap or 0
    if gap <= 0 then return self.client:whisper(to, text) end
    self.wq = self.wq or {}
    self.wq[#self.wq + 1] = { to = to, text = text }
    if self.wpump then return end
    self.wpump = true
    local function pump()
        local m = table.remove(self.wq, 1)
        if not m then self.wpump = false; return end
        self.client:whisper(m.to, m.text)
        self.client:after(gap, pump)
    end
    pump()
end

-- One item at a time: a whisper per item, and the next goes out when the player has answered the one before. Their reply to an item is just the
-- letter (n, o, g, p, or the words); a numbered answer ("3 p"), "pass all" and the rest still work.
local HINT = "(n = need, o = off-spec, g = gift, p = pass)"

function Session:itemPrompt(idx)
    local it = self.items[idx]
    return ("Item %d of %d: %s  %s"):format(it.id, #self.items, it.link, HINT)
end

-- The first two whispers: what this is, then the first item as a whisper of its own (the item link in it can be hovered for the tooltip).
function Session:menuLines(player)
    local n = #self.items
    local intro = ("King's Gambit loot, %d item%s, one at a time. Reply to each with n, o, g or p ('pass all' passes everything)."):format(n, n == 1 and "" or "s")
    return { intro, self:itemPrompt(1) }
end

-- Whisper the first item to a player who has no addon (so they are not left guessing); remembers who, for the reminder and the summary.
function Session:sendMenu(player)
    player = norm(self, player)
    self.menued = self.menued or {}
    if self.menued[player] then return end
    self.menued[player] = true
    self.cursor = self.cursor or {}
    self.cursor[player] = 1
    for _, line in ipairs(self:menuLines(player)) do self:say(player, line) end
end

-- After an answer: the item to whisper next, or nil (and why: "done" when every item is answered, "stay" while the current one is still open).
function Session:nextPrompt(player)
    local cur = self.cursor and self.cursor[player]
    if not cur then return nil end
    local function open(idx) return not (self.bids[player] and self.bids[player][self.items[idx].id]) end
    if open(cur) then return cur, "stay" end
    for k = 1, #self.items do
        local idx = (cur + k - 1) % #self.items + 1
        if open(idx) then self.cursor[player] = idx; return idx end
    end
    return nil, "done"
end

-- Ten seconds before bidding closes, whoever was sent the menu and has items left open is told which, once.
function Session:remind()
    if self.phase ~= "bidding" then return end
    for player in pairs(self.menued or {}) do
        local open = {}
        for _, it in ipairs(self.items) do
            if not (self.bids[player] and self.bids[player][it.id]) then open[#open + 1] = tostring(it.id) end
        end
        if #open > 0 and not (self.reminded and self.reminded[player]) then
            self.reminded = self.reminded or {}
            self.reminded[player] = true
            self:say(player, ("Still open for you: item %s. Whisper e.g. '%s pass' before time runs out; no answer counts as a pass."):format(table.concat(open, ", "), open[1]))
        end
    end
end

-- One confirmation per player, a moment after their last whisper (`cfg.whisperSettle` seconds; none: at once), saying what was taken and what is still open.
function Session:confirmWhisper(sender, lines, problems)
    local function send()
        local out = {}
        if #lines > 0 then out[#out + 1] = "Got: " .. table.concat(lines, ", ") .. "." end
        for _, p in ipairs(problems) do out[#out + 1] = p end
        if self.cursor and self.cursor[sender] and self.phase == "bidding" then
            -- one item at a time: what was taken and the next item, in one whisper (the current one again only if nothing was wrong with it)
            local idx, why = self:nextPrompt(sender)
            if idx and (why ~= "stay" or #problems == 0) then out[#out + 1] = self:itemPrompt(idx)
            elseif why == "done" then out[#out + 1] = "That's every item. Change any answer by whispering it again, e.g. '3 p'." end
            self:say(sender, table.concat(out, " "))
            return
        end
        local open = {}
        for _, it in ipairs(self.items) do
            if not (self.bids[sender] and self.bids[sender][it.id]) then open[#open + 1] = tostring(it.id) end
        end
        if #open > 0 and self.phase == "bidding" then out[#out + 1] = "Still open: item " .. table.concat(open, ", ") .. ". Change any answer by whispering again." end
        if #open == 0 and self.phase == "bidding" and #lines > 0 then out[#out + 1] = "That's every item." end
        self:say(sender, table.concat(out, " "))
    end
    local settle = self.cfg.whisperSettle or 0
    if settle <= 0 then return send() end
    self.pendingWhisper = self.pendingWhisper or {}
    local p = self.pendingWhisper[sender]
    if p then
        for _, l in ipairs(lines) do p.lines[#p.lines + 1] = l end
        for _, l in ipairs(problems) do p.problems[#p.problems + 1] = l end
        return
    end
    p = { lines = {}, problems = {} }
    for _, l in ipairs(lines) do p.lines[#p.lines + 1] = l end
    for _, l in ipairs(problems) do p.problems[#p.problems + 1] = l end
    self.pendingWhisper[sender] = p
    self.client:after(settle, function()
        self.pendingWhisper[sender] = nil
        lines, problems = p.lines, p.problems
        send()
    end)
end

-- Handle a whispered answer from `sender`. Replies by whisper (one reply per burst). Returns the applied answers or nil + reason.
function Session:handleWhisper(sender, text, specNote)
    self.askedSpec, self.stash = self.askedSpec or {}, self.stash or {}
    -- the answer to "which spec are you?": recorded for the rest of the raid, and the answers that were waiting for it are taken now
    if self.askedSpec[sender] then
        local class = self.class[norm(self, sender)]
        local sp, problem, choices = ItemFit.FindSpec(class, text)
        if problem == "ambiguous" then
            self:say(sender, "Which one: " .. table.concat(choices, " or ") .. "? (Type the full name.)")
            return nil, "ambiguous"
        end
        if sp then
            self.askedSpec[sender] = nil
            local ok, err = self:setSpec(sender, sp.name)
            local waiting = self.stash[sender]; self.stash[sender] = nil
            if not ok and err ~= "specset" then self:say(sender, "I couldn't record that spec (" .. tostring(err) .. ").") return nil, err end
            if waiting then return self:handleWhisper(sender, waiting, sp.name) end
            self:say(sender, "Your spec for this raid is " .. sp.name .. ". Now answer the items.")
            return {}
        end
    end
    -- a bare answer ("need", "p", "gift Name") is about the item they were last asked about
    local cursor = self.cursor and self.cursor[sender]
    if cursor and not text:find("%d") then
        local bare = M.ParseWhisper(text, 1)
        if bare and #bare == 1 and bare[1].item == 1 then text = ("%d %s"):format(self.items[cursor].id, text) end
    end
    local answers, why, specWord = M.ParseWhisper(text, #self.items)
    self.whisperStats = self.whisperStats or { handled = 0, unclear = {} }
    if not answers then
        self.whisperStats.unclear[sender] = true
        self:say(sender, whisperProblem(why))
        return nil, why
    end
    self.whisperStats.handled = self.whisperStats.handled + 1
    local applied, lines, problems = {}, {}, {}
    local function fail(msg) problems[#problems + 1] = msg end
    -- No spec on record yet and something other than a pass is wanted: ask for it (once for the raid), keep what they wrote, and take it when they answer.
    if self.cfg.requireSpec and not specWord and not self:specOf(sender) then
        local wants = false
        for _, a in ipairs(answers) do if a.kind ~= "pass" then wants = true end end
        if wants then
            self.askedSpec[sender], self.stash[sender] = true, text
            local names = table.concat(ItemFit.SpecNames(self.class[norm(self, sender)]) or {}, ", ")
            self:say(sender, ("Before I take that: which spec are you for this raid? Reply with just one: %s. (Asked once; it holds for the whole raid, then I'll take your answers.)"):format(names))
            return nil, "needspec"
        end
    end
    if specNote then lines[#lines + 1] = "spec " .. specNote end
    -- a spec named in the message is recorded first (it holds for the whole raid)
    if specWord then
        local ok, err = self:setSpec(sender, specWord)
        if not ok then
            if err == "specset" then fail("Your spec is already set for this raid; ask an officer to change it.")
            else fail("I don't know that spec. Your choices: " .. table.concat(ItemFit.SpecNames(self.class[norm(self, sender)]), ", ") .. ".") end
        else lines[#lines + 1] = "spec " .. specWord:sub(1, 1):upper() .. specWord:sub(2) end
    end
    local nextRank = 1 -- items wanted are ranked in the order they were written
    local needSpecOnce = false
    for _, a in ipairs(answers) do
        local ids = {}
        if a.item then ids[1] = a.item else for _, it in ipairs(self.items) do ids[#ids + 1] = it.id end end
        for _, id in ipairs(ids) do
            local rank
            if a.kind ~= "pass" then rank, nextRank = nextRank, nextRank + 1 end
            local ok, err = self:bid(sender, id, a.kind, { to = a.to, rank = rank, ready = a.ready and "says" or nil })
            if ok then
                applied[#applied + 1] = { item = id, kind = a.kind, to = a.to }
                lines[#lines + 1] = ("%d %s"):format(id, a.kind)
            elseif err == "needspec" then
                if not needSpecOnce then
                    needSpecOnce = true
                    local names = table.concat(ItemFit.SpecNames(self.class[norm(self, sender)]) or {}, "/")
                    fail(("Tell me your spec first, once for the raid: start your message with it, e.g. 'fury: 1 need, 2 pass'. Yours: %s."):format(names))
                end
            elseif err == "notspec" then
                fail(("item %d isn't a main-spec item for your spec: answer '%d off' instead."):format(id, id))
            elseif err == "cantequip" or err == "cantequipto" then
                fail(("item %d can't be worn or wielded by %s."):format(id, err == "cantequip" and "your class" or "theirs"))
            elseif err == "nostats" or err == "nostatsto" then
                fail(("item %d has no stats that help %s."):format(id, err == "nostats" and "your class" or "theirs"))
            elseif err == "wrongclass" or err == "wrongclassto" then
                fail(("item %d is only for %s."):format(id, ItemFit.ClassList(self:fitOf(id)) or "other classes"))
            elseif err == "noitem" then
                fail(("there is no item %d."):format(id))
            elseif err == "closed" then
                fail("bidding is closed.")
            else
                fail(("could not record item %d (%s)."):format(id, tostring(err)))
            end
        end
    end
    self:confirmWhisper(sender, lines, problems)
    return applied
end
end
