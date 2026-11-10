-- King's Gambit: the Guild book as tables, the raid that is open now and when the next one starts. Keep this file Lua 5.1-safe.
-- Part of GuildBook (ui/GuildBook.lua): GuildBook merges what this module exports, so callers use GuildBook.<name>.
local _, SK = ...
local Identity, GuildBookHistory, GuildBookStats
local M = SK:NewModule("GuildBookRaid", { "Identity", "GuildBookHistory", "GuildBookStats" }, function(d) Identity, GuildBookHistory, GuildBookStats = d.Identity, d.GuildBookHistory, d.GuildBookStats end)

---------------------------------------------------------------- the raid that is open now (the This raid section)
-- What the Master Looter holds to hand out: { { link, seconds (left to trade it, nil if not known) } }, soonest to close first. In practice, the practice
-- raid's held loot; in the game, the bind-on-pickup items in the bags still inside their trade window.
local function heldLoot(ctx)
    local out = {}
    if ctx.sim then
        for _, h in ipairs(ctx.sim.held or {}) do
            local link = h.item and h.item.name
            if link then out[#out + 1] = { link = link, seconds = ctx.client:tradeableUntil(link) } end
        end
    elseif ctx.client.tradeableItems then
        for _, it in ipairs(ctx.client:tradeableItems()) do out[#out + 1] = it end
    end
    table.sort(out, function(a, b)
        if (a.seconds or math.huge) ~= (b.seconds or math.huge) then return (a.seconds or math.huge) < (b.seconds or math.huge) end
        return tostring(a.link) < tostring(b.link)
    end)
    return out
end

local function itemName(link) return tostring(link):match("%[(.-)%]") or tostring(link) end

-- The raid that is open now (the one this character runs, else the first), in numbers and words. Handed out = the Master Looter's awards and
-- disenchants on the raid's list since it started; what is held and how long it can be traded come from the Master Looter's own bags (so only they see them).
-- `filter` is what the section's ledger subset uses: this raid's entries only.
function M.RaidNow(ctx)
    local engine = ctx.engine
    local view = engine:View()
    local now = ctx.client:serverTime()
    local me = ctx.client:me()
    local raids = engine:ActiveRaids()
    local raid
    for _, r in ipairs(raids) do if r.ml == me then raid = r end end
    raid = raid or raids[1]
    local out = { running = raid ~= nil, now = now, lines = {} }
    if not raid then
        out.lines[1] = "No raid is open."
        return out
    end
    local list = engine:ListOfRaid(raid) or "main"
    local entries = view.attendance[raid.id]
    out.raid, out.ml, out.list, out.mine = raid.id, raid.ml, list, raid.ml == me
    out.since = entries and entries[1].ts
    out.started = out.since ~= nil
    out.elapsed = out.started and (now - out.since) or nil
    out.filter = { kind = "happened", list = list, lists = { [list] = true, [engine:OffListOf(list)] = true }, since = out.since or raid.start, limit = 300 }
    local awards, disenchants = 0, 0
    for _, ev in ipairs(view.applied) do
        if ev.ts >= (out.since or raid.start) and ev.author == raid.ml and (ev.list == list or ev.list == engine:OffListOf(list)) then
            if ev.type == "Award" then awards = awards + 1 elseif ev.type == "Disenchant" then disenchants = disenchants + 1 end
        end
    end
    out.awards, out.disenchants, out.handedOut = awards, disenchants, awards + disenchants
    local present = 0
    for _ in pairs(engine:Present(raid.id)) do present = present + 1 end
    out.present = present
    out.lines[1] = ("Raid %s on the %s list, run by %s."):format(raid.id, list, Identity.Display(raid.ml))
    if out.started then
        out.lines[2] = ("Started %s ago, at the first kill. %d player%s in the raid now."):format(GuildBookStats.Span(out.elapsed), present, present == 1 and "" or "s")
    else
        out.lines[2] = "Not started yet: it starts at the first enemy killed in an instance, or when the Master Looter says so."
    end
    out.lines[3] = ("Handed out: %d (%d awarded, %d disenchanted)."):format(out.handedOut, awards, disenchants)
    if out.mine then
        out.held = heldLoot(ctx)
        if #out.held == 0 then
            out.lines[4] = "Still to hand out: nothing held."
        else
            out.lines[4] = ("Still to hand out: %d item%s you hold."):format(#out.held, #out.held == 1 and "" or "s")
            local unknown = 0
            for _, it in ipairs(out.held) do if not it.seconds then unknown = unknown + 1 end end
            local soonest = out.held[1]
            if soonest and soonest.seconds then
                out.nextExpiry = { seconds = soonest.seconds, link = soonest.link }
                out.lines[5] = ("The earliest trade window closes in %s (%s)."):format(GuildBookStats.Span(soonest.seconds), itemName(soonest.link))
            end
            if unknown > 0 then out.lines[#out.lines + 1] = ("The trade time of %d item%s can't be read."):format(unknown, unknown == 1 and "" or "s") end
        end
    else
        out.lines[4] = "What is still to hand out is only known to the Master Looter."
    end
    return out
end

---------------------------------------------------------------- when the raid starts (the Raids section's panel)
-- Where the Master Looter's raid stands and what they may do about it, as text and flags for the window: { available, running, started, auto, canStart,
-- text }. `ctx.attendance` is the Master Looter's attendance writer (Attendance.lua).
function M.RaidStart(ctx)
    local a = ctx.attendance
    if not a then return { available = false, running = false, auto = true, canStart = false, text = "Not available here." } end
    local s = a:status()
    local out = { available = true, running = s.running, started = s.started, auto = s.auto }
    if not s.running then
        out.text = "You are not running a raid. An officer opens one for you in the form above, and then it can be started here."
    elseif s.started then
        local now = ctx.client:serverTime()
        out.text = ("Started %s. %d player%s in the raid now."):format(GuildBookHistory.Ago(now, s.since or now), s.present or 0, (s.present or 0) == 1 and "" or "s")
    elseif not s.auto then
        out.text = "Waiting for you: the raid starts when you press Start the raid now."
    elseif s.inInstance then
        out.text = "Waiting for the first enemy killed. The raid starts by itself then, or press Start the raid now."
    else
        out.text = "Not in an instance, so nothing starts it by itself. For a world boss, press Start the raid now."
    end
    out.canStart = s.running and not s.started
    return out
end
