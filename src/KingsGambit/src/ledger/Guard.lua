-- King's Gambit: tells the officers when someone who is not an officer writes to the ledger. Keep this file Lua 5.1-safe.
--
-- The ledger takes an entry from anyone who isn't being disregarded, because who is an officer is the game's to say and each writer's own addon checks it
-- just before writing (Engine:Allowed). That leaves one hole: a modified addon could write anyway. So when an entry arrives from a player whom the game says is
-- NOT an officer now, and who is not (and was not) the Master Looter of a raid, the officers here are told, with what was written and how to answer it:
-- `disregard <name> <reason>`, which ignores that player's entries from then on on every client. This check only warns: it never decides whether an entry is
-- accepted (the game keeps no history, so a later look at someone's rank can't judge an old entry). Each player is announced at most once in ten minutes.
local _, SK = ...
local M = SK:NewModule("Guard", {}, function() end)

M.QUIET = 600 -- seconds before the same player is announced again

function M.New(engine, client, opts)
    opts = opts or {}
    local describe = opts.describe or function(ev) return tostring(ev.type) end
    local g = { alerts = {}, announced = {} }

    local function wasMasterLooter(name)
        for _, r in pairs(engine:View().auth.raids) do if r.ml == name then return true end end
        return false
    end

    engine:OnChange(function(kind, _, ev)
        if kind ~= "remote" or type(ev) ~= "table" or not ev.author or ev.author == client:me() then return end
        if not client.isOfficer or client:isOfficer() ~= true then return end   -- only an officer is told
        if client:isOfficer(ev.author) ~= false then return end                 -- an officer, or the game doesn't say: nothing to report
        if wasMasterLooter(ev.author) then return end                           -- a Master Looter writes the raid's entries
        if engine:View().auth.disregarded[ev.author] then return end             -- already being disregarded
        local now = client:serverTime()
        local last = g.announced[ev.author]
        if last and now - last < M.QUIET then return end
        g.announced[ev.author] = now
        local who = (opts.display and opts.display(ev.author)) or ev.author
        local text = ("%s is not an officer in the guild but wrote to the ledger: %s. If that isn't right, record: disregard %s <reason>"):format(who, describe(ev), who)
        g.alerts[#g.alerts + 1] = { who = ev.author, id = ev.id, text = text, at = now }
        client:print(text)
    end)
    return g
end

function M:OnInit() end

return M
