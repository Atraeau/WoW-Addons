-- King's Gambit: the text commands for the ledger itself: its format and migration, versions, stored ledgers, officers and who is disregarded, sync status and the client check. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local Ledger, Version, Ledgers
local M = SK:NewModule("CmdLedger", { "Ledger", "Version", "Ledgers" }, function(d) Ledger, Version, Ledgers = d.Ledger, d.Version, d.Ledgers end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local ctx, client, engine, out, why, name, short = h.ctx, h.client, h.engine, h.out, h.why, h.name, h.short
    local writeAuthority = h.writeAuthority

    -- The ledger's format, and who can read the next one. The ledger owner moves the ledger to it with `migrate <format> <reason>` once the guild is ready:
    -- the entry records exactly which entries are before the change and what they add up to, and every client checks its own replay against that.
    function cmds.migrate(args)
        local sub, rest = args:match("^(%S*)%s*(.-)$")
        local fmt = engine:Format()
        if tonumber(sub) then
            if rest == "" then return out("migrate <format> <reason>: say why (it goes in the record)") end
            local ev, err = engine:Migrate(tonumber(sub), rest)
            if ev then
                out(("Recorded: the ledger is now in format %d. Players whose King's Gambit can't read it are told to update; the rest check the change against their own replay."):format(fmt + 1))
            else
                out("Not recorded: " .. why(err))
            end
            return
        end
        local readable = engine:Readable()
        out(("The ledger is in format %d. This version reads format%s %s."):format(fmt, #readable > 1 and "s" or "", table.concat(readable, ", ")))
        if next(engine:Ahead()) then out("This ledger has entries in a newer format than this version can read: you see it as of the last entry you can read, and writing is paused. Update King's Gambit.") end
        local frozen = engine:Frozen()
        if frozen then out(("This client could not reproduce the migration to format %d (it got a different result from the ledger owner's), so it will not write. Update King's Gambit."):format(frozen.to)) end
        local nextFormat = fmt + 1
        if readable[#readable] < nextFormat then out(("This version does not know format %d: there is nothing newer to move to yet."):format(nextFormat)); return end
        local ready, notReady, unknown = {}, {}, {}
        for _, p in ipairs(ctx.sync and ctx.sync:peerVersions() or {}) do
            local who = short(p.name)
            if not p.formats then unknown[#unknown + 1] = who
            else
                local can = false
                for _, f in ipairs(p.formats) do if f == nextFormat then can = true end end
                if can then ready[#ready + 1] = who else notReady[#notReady + 1] = who end
            end
        end
        out(("Format %d is available. Can read it: %s. Cannot yet: %s. Not heard from: %s."):format(nextFormat,
            #ready > 0 and table.concat(ready, ", ") or "nobody", #notReady > 0 and table.concat(notReady, ", ") or "nobody",
            #unknown > 0 and table.concat(unknown, ", ") or "nobody"))
        out("The ledger owner moves the ledger with: migrate " .. nextFormat .. " <reason>. Anyone who cannot read it yet will have to update first.")
    end

    -- Which version is this, and can it work with what the others run? Players are listed from their heartbeats.
    function cmds.version()
        local mine = client:addonVersion()
        local line = Version.Line(mine)
        out(("King's Gambit %s (works with %s; ledger format %d)"):format(mine,
            line and (line:find("%.") and (line .. ".x") or (line .. ".x.y")) .. ", a different version on that line is fine" or "anyone: a development copy",
            Ledger.VERSION))
        local peers = ctx.sync and ctx.sync:peerVersions() or {}
        if #peers == 0 then out("No other King's Gambit players seen yet."); return end
        local WORDS = { same = "same as yours", newer = "newer than yours, compatible", older = "older than yours, compatible", unknown = "can't compare" }
        for _, p in ipairs(peers) do
            if p.relation == "incompatible" then
                out(("  %s: %s. INCOMPATIBLE: they are on %s.x, you are on %s.x; %s must update to share the ledger"):format(short(p.name),
                    p.build or "unknown version", p.line, p.ourLine, p.mustUpdate == "them" and "they" or "you"))
            else
                out(("  %s: %s (%s)"):format(short(p.name), p.build or "unknown version", WORDS[p.relation]))
            end
        end
    end


    -- The ledgers stored on this account (one per world: ruleset, faction and guild), and retiring the stale ones (Ledgers.lua).
    function cmds.ledgers(args)
        local db = client.storage and client:storage().shared
        if not db then return out("This client doesn't keep stored ledgers.") end
        local now = client:serverTime()
        local rows = Ledgers.Stored(db, client.world and client:world() or nil, client.world ~= nil) -- only this ruleset, faction and guild
        local sub, num, rest = args:match("^(%S*)%s*(%d*)%s*(.-)$")
        sub = sub:lower()
        if sub == "" or sub == "list" then
            if #rows == 0 then return out("No ledgers are stored on this account.") end
            for _, r in ipairs(rows) do
                local d = Ledgers.Describe(r, now, short)
                out(("%d. %s: %s%s"):format(r.n, d.title, d.detail, d.status and (" [" .. d.status .. "]") or ""))
            end
            return out("ledgers retire <n> removes a stale one from this machine (it asks first); ledgers keep <n> brings a retired one back. An officer's retirement is told to the guild, which can restore it or let it expire (30 days).")
        end
        local row = rows[tonumber(num) or 0]
        if sub ~= "retire" and sub ~= "keep" then return out("ledgers | ledgers retire <n> [yes] | ledgers keep <n>") end
        if not row then return out("No such ledger: type ledgers to see the numbers.") end
        local d = Ledgers.Describe(row, now, short)
        if sub == "keep" then
            if not row.retired then return out(("%s isn't retired."):format(d.title)) end
            if not Ledgers.Keep(db, row.id, now) then return out("That ledger isn't retired.") end
            return out(("%s is not retired any more. The guild is told%s."):format(d.title,
                row.held and "" or "; its data is fetched again from whoever still has it"))
        end
        if row.retired then return out(("%s is already retired (%s)."):format(d.title, d.status or "")) end
        local may, whyNot = Ledgers.MayRetire(client, row)
        if not may then return out("Not retired: " .. whyNot .. ".") end
        if rest:lower() ~= "yes" then
            return out(("Retire %s (%s)? This removes its saved data from this machine%s%s. Nothing is written to the ledger and nobody else's copy is touched. To go ahead: ledgers retire %d yes"):format(
                d.title, d.detail, row.open and " at your next login (it is the ledger in use now)" or " at once",
                (row.id and client.isOfficer and client:isOfficer() == true) and ", and tells the guild so they can restore it or let it expire" or "", row.n))
        end
        local ok, t, later = Ledgers.Retire(db, row.key, client:me(), now, client.world and client:world() or nil)
        if not ok then return out("That ledger is gone already.") end
        out(("Retired %s.%s"):format(d.title, later and " It is in use now, so it is removed at your next login (/reload); then you can start a new ledger for the guild." or " Its data is removed from this machine."))
    end

    -- Officers are the game's: the members of the guild whose rank has the "Is Officer" permission, which the guild's Guild Master sets in the game.
    function cmds.officers(args)
        local sub = args:match("^(%S*)"):lower()
        if sub == "set" then
            return out("Officers are not set here any more: they are the guild members whose rank has the \"Is Officer\" permission (the Guild Master sets that in the game's guild control). Nothing was changed.")
        end
        local a = engine:View().auth
        local names = {}
        for i, n in ipairs(client.officers and client:officers() or {}) do names[i] = short(n) end
        out(("Ledger owner: %s. Officers (by the game's \"Is Officer\" rank permission): %s."):format(short(a.gm) or "none (no ledger yet)",
            #names > 0 and table.concat(names, ", ") or "none known"))
        local dis = {}
        for n in pairs(a.disregarded) do dis[#dis + 1] = short(n) end
        table.sort(dis)
        if #dis > 0 then out("Entries from these players are being disregarded: " .. table.concat(dis, ", ") .. ".") end
    end

    -- An officer says to ignore a player's entries from now on (or to stop). The same on every client; nothing is deleted.
    function cmds.disregard(args)
        local who, reason = args:match("^(%S+)%s+(.+)$")
        if not who then return out("disregard <name> <reason>  (ignores that player's entries from now on, on every client; a reason is part of the record. Undo it: regard <name>)") end
        if writeAuthority("Disregard", { name = name(who), reason = reason }) then
            out(("From now on %s's entries are disregarded, on every client. What they wrote before stays. Undo it: regard %s"):format(short(name(who)), short(name(who))))
        end
    end
    function cmds.regard(args)
        local who = args:match("^(%S+)")
        if not who then return out("regard <name>  (stop disregarding a player's entries)") end
        if writeAuthority("Disregard", { name = name(who), reason = "regarded again", lift = 1 }) then
            out(("%s's entries count again."):format(short(name(who))))
        end
    end


    ---------------------------------------------------------------- misc
    function cmds.sync()
        if not ctx.sync then return out("Sync is not running.") end
        local st = ctx.sync:status()
        out(("Sync: %d message(s) waiting%s, %d rejected, %d fork(s) resolved%s."):format(st.pending,
            st.blocked and (" (" .. st.blocked .. ")") or "", st.rejected, st.forksResolved, st.resolvingForks and ", resolving a fork now" or ""))
        out(("Ledger fingerprint %s%s"):format((engine:Fingerprint() or ""):sub(1, 8), engine:IsVerified() and "" or " (still verifying)"))
        local ids = {}
        for cid in pairs(engine.store.chains) do ids[#ids + 1] = cid end
        table.sort(ids)
        for _, cid in ipairs(ids) do
            local chain = engine.store.chains[cid]
            out(("  %s: %d events, head %s"):format(short(chain.author or cid), #chain.events, chain.head:sub(1, 8)))
        end
        for id, p in pairs(engine.problems) do out(("  %s: FAILED verification at event %s (%s)"):format(id, tostring(p.index), tostring(p.reason))) end
        local conflicts = engine:Conflicts()
        if #conflicts > 0 then out(("%d event(s) were skipped as conflicts (see: conflicts)"):format(#conflicts)) end
    end

    function cmds.check()
        if ctx.selfcheck then ctx.selfcheck.Run(client) else out("Self-check is not available.") end
    end
end
