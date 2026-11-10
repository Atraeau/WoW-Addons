-- King's Gambit: the game's windows, practice mode: the simulated raid, the whisper window, spec choice and the lesson and raid controls. Keep this file Lua 5.1-safe.
-- Part of UI (ui/UI.lua): UI calls Install, which adds these to the module's table.
local _, SK = ...
local Identity, Sim, Commands, UILoot, LootWindow, Scenarios, Skin
local P = SK:NewModule("UIPractice", { "Identity", "Sim?", "Commands?", "UILoot", "LootWindow", "Scenarios?", "UISkin?" }, function(d) Identity, Sim, Commands, UILoot, LootWindow, Scenarios, Skin = d.Identity, d.Sim, d.Commands, d.UILoot, d.LootWindow, d.Scenarios, d.UISkin end)

-- M: the table to add to; h: what UI shares (and what the parts installed before this one exported).
function P.Install(M, h)
local say = h.say

function M:StartPractice()
    if not (Sim and Commands) then return end
    local busy = M.RealRaidBusy()
    if busy then
        say("Practice is off while you are in the middle of a raid: " .. busy .. ".")
        return M:Refresh()
    end
    if M.whisperWin then M.whisperWin:Hide() end -- (a fresh practice starts with the buttons)
    local lessonSc = M.lesson and Scenarios and Scenarios.find(M.lesson)
    if M.lesson and not lessonSc then M.lesson = nil end
    local me = SK.client:me()
    -- You practise as your own class (a warrior is asked about warrior loot, not a priest's); a class the simulation doesn't know falls back to a priest.
    local class = SK.client.myClass and SK.client:myClass() or nil
    -- Loot: the gear in your bags and on your character, which the game really has (Molten Core's items aren't in this game yet). Molten Core's
    -- loot table is the fallback when there are too few pieces to make a raid of.
    local gear = lessonSc and {} or M.GearItems(SK.client, M.GearLinks(), 24)
    local sim
    if lessonSc then
        sim = Sim.NewLesson(lessonSc, { seed = 1 })
        say(("Practice lesson: %s. Read it in the loot window, then press Start the lesson."):format(lessonSc.title))
    elseif #gear >= 3 then
        sim = Sim.NewPractice(gear, { learner = me, seed = 1, size = M.size, learnerClass = class })
        say(("Practice: the loot is %d pieces of gear from your bags and equipment, so it has real tooltips."):format(#gear))
    else
        sim = Sim.NewMoltenCore({ learner = me, seed = 1, size = M.size, learnerClass = class })
        say("Practice: you carry fewer than 3 pieces of gear, so the loot is Molten Core's (those items may not exist in this game yet, so no tooltips).")
    end
    sim.rankingRequired = true -- as in the game: someone who wants several items ranks them
    if not lessonSc then -- a raid night asks for your spec, as the game does (a lesson has its own cast); your talents' pick is your own main spec here
        sim.requireSpec = true
        local li = sim.info and sim.info[sim.learner]
        if li and li.spec and sim.client.setMySpec then sim.client:setMySpec(li.spec) end
    end
    -- A simulated guild: the raid's players, and others who are not in the group (some offline).
    local guild = {}
    for _, m in ipairs(sim.client:roster()) do guild[#guild + 1] = { name = m.name, class = m.class } end
    local classes = { "WARRIOR", "MAGE", "ROGUE", "PRIEST", "HUNTER", "WARLOCK", "DRUID", "PALADIN", "SHAMAN" }
    for i, n in ipairs { "Oswin_Harrowgate", "Perrin_Dunholm", "Rook_Underhill", "Sabine_Valeheart", "Tamsin_Brightfield", "Ulric_Stormcrow", "Vesna_Ashmoor",
        "Wick_Thistledown", "Yorick_Greymantle", "Zora_Emberfall", "Alder_Quickwater", "Bexley_Holloway" } do
        guild[#guild + 1] = { name = n, class = classes[(i - 1) % #classes + 1], online = i % 3 ~= 0 }
    end
    sim.client:setGuild(guild)
    sim.client.print = function(_, text) print("|cffffaa00Practice|r", text) end
    -- The commands find the running loot session through `host.session`: here it is whatever the simulation is running.
    local host = setmetatable({ on = function() end }, { __index = function(_, k) if k == "session" then return sim.session end end })
    local commands = Commands.New({ client = sim.client, engine = sim.engine, host = host, attendance = sim.attendance })
    -- Playing a raider without the addon: what the Master Looter whispers the learner shows in the Whisper window, and a loot session whispers its menu on start.
    local learnerName = sim.learner
    local origWhisper = sim.client.whisper
    sim.client.whisper = function(self, name, text)
        local r, why = origWhisper(self, name, text)
        if M.practice and M.practice.whisperMode and (name == learnerName or self:normalize(name) == learnerName) then M:WhisperLog("ml", text) end
        return r, why
    end
    sim.onSession = function(s)
        if M.practice and M.practice.whisperMode then s:sendMenu(learnerName) end
    end
    M.practice = { engine = sim.engine, client = sim.client, commands = commands, sim = sim, host = host, attendance = sim.attendance,
        lessonIndex = lessonSc and M.LessonIndex(lessonSc.id) or nil, lessonCount = lessonSc and #M.Lessons() or nil, autoSpec = M.AutoSpec }
    -- The practice loot uses real item ids; say how many this game knows (the rest show as plain names, with no tooltip).
    local total, unknown = 0, 0
    for id in pairs(sim.raid and sim.raid.items or {}) do
        total = total + 1
        if not UILoot.KnownToGame(id) then unknown = unknown + 1 end
    end
    if unknown > 0 and not (sim.raid and sim.raid.name == "Your gear") then
        say(("Practice: %d of the %d %s items aren't in this game's item data yet, so they show as plain names without a tooltip."):format(unknown, total, sim.raid.name or "raid"))
    end
    M.list = nil
    M:Refresh()
    if lessonSc then M:OpenLoot() end -- the lesson is read there
end

-- Click an item to see everyone's answer on it, and again to close it.
-- Practice as a raider who has no addon: a Whisper window shows what the Master Looter whispers you, and you type your answers back, one message at a time, exactly
-- as in the game. The loot window's answer buttons are off while it is on.
local function whisperLines() return M.whisperLog or {} end
function M:WhisperLog(who, text)
    M.whisperLog = M.whisperLog or {}
    local line = who == "ml" and ("|cffff80ffMaster Looter whispers: " .. text .. "|r") or ("|cffff80ffTo Master Looter: " .. text .. "|r")
    M.whisperLog[#M.whisperLog + 1] = line
    while #M.whisperLog > 14 do table.remove(M.whisperLog, 1) end
    M:RefreshWhisper()
end

function M:RefreshWhisper()
    local f = M.whisperWin
    if not f then return end
    f.log:SetText(table.concat(whisperLines(), "\n"))
end

function M:WhisperSend(text)
    text = tostring(text or ""):match("^%s*(.-)%s*$")
    if text == "" then return end
    local p = M.practice
    if not (p and p.whisperMode) then return end
    M:WhisperLog("you", text)
    local s = p.host and p.host.session
    if s and s.phase == "bidding" then s:handleWhisper(p.sim.learner, text)
    else M:WhisperLog("ml", "(Nothing is up for bids right now.)") end
    M:Refresh()
end

function M:BuildWhisperWindow()
    if M.whisperWin then return M.whisperWin end
    local ok, f = pcall(CreateFrame, "Frame", "KingsGambitWhisperWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not f then f = CreateFrame("Frame", "KingsGambitWhisperWindow", UIParent) end
    f:SetSize(430, 250)
    f:SetFrameStrata("DIALOG")
    LootWindow.Movable(f, "whisper", { "CENTER", -440, -330 })
    if f.TitleText then f.TitleText:SetText("Whispers (a raider without the addon)") end
    f.help = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.help:SetPoint("TOPLEFT", 14, -30); f.help:SetWidth(400); f.help:SetJustifyH("LEFT"); f.help:SetWordWrap(true)
    f.help:SetText("You are playing a raider who does not have the addon. Type what you would whisper the loot master, then press Enter.")
    f.log = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.log:SetPoint("TOPLEFT", 14, -62); f.log:SetWidth(400); f.log:SetHeight(140); f.log:SetJustifyH("LEFT"); f.log:SetJustifyV("TOP"); f.log:SetWordWrap(true)
    local okBox, box = pcall(CreateFrame, "EditBox", nil, f, "InputBoxTemplate")
    if not okBox or not box then box = CreateFrame("EditBox", nil, f) end
    box:SetSize(320, 24); box:SetPoint("BOTTOMLEFT", 20, 14); box:SetAutoFocus(false)
    if box.SetMaxLetters then box:SetMaxLetters(240) end
    local function send() M:WhisperSend(box:GetText()); box:SetText("") end
    box:SetScript("OnEnterPressed", send)
    box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    f.box = box
    local sendBtn = Skin and Skin.Button(f, "Send", 70, 22) or CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    sendBtn:SetSize(70, 22); sendBtn:SetPoint("BOTTOMRIGHT", -14, 15); sendBtn:SetText("Send")
    sendBtn:SetScript("OnClick", send)
    f.sendBtn = sendBtn
    f:Hide()
    M.whisperWin = f
    return f
end

-- Turn the mode on or off (practice only).
function M:SetWhisperMode(on)
    local p = M.practice
    if not p then return end
    p.whisperMode = on and true or nil
    local f = M:BuildWhisperWindow()
    if on then
        M.whisperLog = {}
        M:WhisperLog("ml", "(Whispers from the loot master appear here when loot drops. Reply the way you would in the game.)")
        f:Show()
        local s = p.host and p.host.session
        if s and s.phase == "bidding" then s:sendMenu(p.sim.learner) end
    else
        f:Hide()
    end
    M:Refresh()
end

-- Your spec for this raid: tell the session (the host's own, or the Master Looter's over the network). The first answer stands for the whole raid.
function M:ChooseSpec(name)
    local ctx = M.Ctx()
    local s = ctx.host and ctx.host.session
    if s and s.setSpec and s.phase ~= "idle" then
        local ok, why = s:setSpec(ctx.client:me(), name)
        if not ok then M.Say("Your spec could not be recorded (" .. tostring(why) .. ").") end
    elseif ctx.player and ctx.player.spec then
        ctx.player:spec(name)
    end
    M:Refresh()
end

-- "Auto-detect": take the talents' spec every time, without asking (kept for this character).
function M:ToggleAutoSpec()
    local char = SK.char
    if char then char.autoSpec = not char.autoSpec end
    M:Refresh()
end
function M.AutoSpec() return SK.char and SK.char.autoSpec == true or false end

function M:SelectBidItem(id)
    M.bidItem = (M.bidItem ~= id) and id or nil
    M.bidFollow = false -- you chose where to look: the panel stays until you answer something
    M:Refresh()
end

-- Practice lessons: pick one (nil: back to a raid night), start it, run it again, or go on to the next.
function M:ChooseLesson(id)
    M.lesson = id
    if M.practice then M:StartPractice() else M:Refresh() end
end
function M:LessonStart()
    local p = M.practice
    if not (p and p.sim.lesson) then return end
    local ok, why = p.sim:startLesson()
    if not ok and why ~= "started" then say("Practice: the lesson could not start (" .. tostring(why) .. ").") end
    M:OpenLoot()
end
function M:LessonAgain()
    if not (M.practice and M.practice.sim.lesson) then return end
    M:StartPractice()
    M:LessonStart()
end
function M:LessonNext()
    local p = M.practice
    if not (p and p.sim.lesson) then return end
    local lessons = M.Lessons()
    local nextSc = lessons[(M.LessonIndex(p.sim.lesson.id) or 0) + 1]
    if nextSc then M:ChooseLesson(nextSc.id) end
end

function M:LeavePractice()
    M.practice = nil
    if M.whisperWin then M.whisperWin:Hide() end
    M.list = nil
    M:Refresh()
end

-- Practice: the next boss dies and its loot goes up (the simulated raiders answer on their own), the held loot is handed out, time passes.
function M:PracticeKill()
    local p = M.practice
    if not p then return end
    local s = p.sim.session
    if s and s.phase ~= "done" and s.phase ~= "cancelled" then return say("Practice: finish handing out the current loot first.") end
    local boss, err, why = p.sim:killBoss(nil, false)
    if not boss then return say(err == "noraid" and "Practice: no raid is open: open the next one first." or "Practice: there are no more bosses.") end
    if why then say("Practice: " .. tostring(why)) end
    M:OpenLoot()
end
-- Practice: end the raid, open the next one a few days later, and people leaving and coming back.
local WHYNOT = { busy = "finish handing out the current loot first", held = "hand out the held loot first", noraid = "no raid is open", open = "a raid is already open" }
function M:PracticeEndRaid()
    local p = M.practice
    if not p then return end
    local ok, why = p.sim:endRaid()
    if not ok then return say("Practice: " .. (WHYNOT[why] or tostring(why))) end
    say("Practice: the raid is over. Open the next one when you are ready.")
    M:Refresh()
end
function M:PracticeOpenRaid()
    local p = M.practice
    if not p then return end
    local n, why = p.sim:openRaid()
    if not n then return say("Practice: " .. (WHYNOT[why] or tostring(why))) end
    say(("Practice: raid %d is open, a few days later. A few raiders are away this time."):format(n))
    M:Refresh()
end
function M:PracticeLeave()
    local p = M.practice
    if not p then return end
    local who, why = p.sim:leave()
    if not who then return say("Practice: nobody can leave (" .. tostring(why) .. ").") end
    say("Practice: " .. Identity.Display(who) .. " left the group.")
    M:Refresh()
end
function M:PracticeRejoin()
    local p = M.practice
    if not p then return end
    local who = p.sim:rejoin()
    if who then say("Practice: " .. Identity.Display(who) .. " is back.") end
    M:Refresh()
end
function M:PracticeHandOut()
    local p = M.practice
    if p then p.sim:handOut(); M:OpenLoot() end
end
function M:PracticeWait(sec)
    local p = M.practice
    if p then p.sim:advance(sec); M:Refresh() end
end
end
