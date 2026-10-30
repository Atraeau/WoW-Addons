-- King's Gambit command-line audit tool (needs Lua 5.4; no game required).
--
--   lua tools/kg.lua verify    <KingsGambit.lua>             check every hash and rule
--   lua tools/kg.lua standings <KingsGambit.lua> [list]      standings as a Markdown table
--   lua tools/kg.lua history   <KingsGambit.lua> [list] [N]  the last N events (default 20)
--   lua tools/kg.lua conflicts <KingsGambit.lua>             events skipped in replay, and why
--
-- <KingsGambit.lua> is the SavedVariables file, for example
--   World of Warcraft/_forever_/WTF/Account/<ACCOUNT>/SavedVariables/KingsGambit.lua
-- Exit status is 1 if any list fails verification, so it can be used in scripts.
local here = (arg[0]:match("^(.*)[/\\][^/\\]*$") or ".")
local audit = dofile(here .. "/kgaudit.lua")
local root = here .. "/.."

local cmd, path, a, b = arg[1], arg[2], arg[3], arg[4]
if not (cmd and path) then
    io.stderr:write("usage: lua tools/kg.lua verify|standings|history|conflicts <KingsGambit.lua> [list] [N]\n")
    os.exit(2)
end
local mods = audit.loadEngine(root)
local db, err = audit.loadSaved(path)
if not db then
    io.stderr:write("cannot read ledger: " .. tostring(err) .. "\n")
    os.exit(2)
end

if cmd == "verify" then
    local results, view, fingerprint, orphans = audit.verify(db, mods)
    local failed = false
    for _, r in ipairs(results) do
        if r.ok then
            print(("OK      %-32s %6d events  head %s"):format(r.chain, r.events, r.head))
        else
            failed = true
            print(("FAILED  %-32s %6d events  %s at event %s"):format(r.chain, r.events, tostring(r.reason), tostring(r.index)))
        end
    end
    if #results == 0 then print("no chains found") end
    print("fingerprint " .. fingerprint)
    if #view.conflicts > 0 then print(("note: %d events were skipped in replay (see: conflicts)"):format(#view.conflicts)) end
    if orphans > 0 then print(("note: %d events from a resolved chain fork are kept aside for review (db.orphans)"):format(orphans)) end
    os.exit(failed and 1 or 0)
elseif cmd == "conflicts" then
    for _, l in ipairs(audit.conflicts(db, mods)) do print(l) end
elseif cmd == "standings" then
    local rows, e = audit.standings(db, mods, a or "main")
    if not rows then io.stderr:write(e .. "\n"); os.exit(1) end
    print(audit.markdown(rows, "Standings: " .. (a or "main")))
elseif cmd == "history" then
    local lines, e = audit.history(db, a or "main", tonumber(b), mods)
    if not lines then io.stderr:write(e .. "\n"); os.exit(1) end
    for _, l in ipairs(lines) do print(l) end
else
    io.stderr:write("unknown command: " .. tostring(cmd) .. "\n")
    os.exit(2)
end
