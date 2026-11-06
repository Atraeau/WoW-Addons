-- King's Gambit: namespace, startup wiring (the composition root), /gambit entry point.
-- The module registry is Registry.lua, loaded first.
-- Design: docs/ (manifesto, rationale, design-journal).
local ADDON, SK = ...
_G.KingsGambit = SK

SK.name = ADDON
SK.SCHEMA = 1

-- SavedVariables (created by RealClient:storage(), read by the Engine):
-- KingsGambitDB (account-wide): selfcheck, and worlds = { [world] = the ledger store: schema, ledger = { chains }, mine, requests, orphans, config }.
-- A world is the game's mode (its ruleset) and the faction, so characters in different ones never share a ledger (RealClient:storage).
-- KingsGambitCharDB (per character): ui = { frame positions, scale, opacity, hints }

function SK:Print(...)
    print("|cff66ccffGambit|r", ...)
end

-- Everything is built at PLAYER_LOGIN, when the player's name and group are all known, and once the guild has loaded: the saved ledger is the GUILD's, so
-- which one to open depends on the guild's name, which the game gives a moment after login. Waiting up to 20 seconds; if it never comes, nothing is started
-- (a wrong guess would put the ledger in the wrong place).
local function Start(attempt)
    SK:Resolve() -- every file has loaded: hand each module what it depends on
    local M = SK.modules
    local client = SK.pendingClient or M.RealClient.New()
    if client.guildKnown and not client:guildKnown() then
        attempt = (attempt or 0) + 1
        if attempt == 1 then SK:Print("waiting for your guild to load...") end
        if attempt > 20 then
            SK:Print("couldn't tell which guild you are in, so nothing was started (a wrong guess would put the ledger in the wrong place). /reload to try again.")
            return
        end
        SK.pendingClient = client
        client:after(1, function()
            local ok, err = pcall(Start, attempt)
            if not ok then SK:Print("failed to start: " .. tostring(err)) end
        end)
        return
    end
    SK.pendingClient = nil
    local engine = M.Engine.New(client)
    local sync = M.Sync.New(engine)
    sync:start()
    local host = M.LootNet.NewHost(sync, engine)
    local player = M.LootNet.NewPlayer(sync)
    local requests = M.Requests.New(sync, engine)
    SK.client, SK.engine, SK.sync, SK.host, SK.player, SK.requests = client, engine, sync, host, player, requests
    SK.attendance = M.Attendance.New(engine, client, host) -- as a Master Looter, writes down who is in the raid, from the first kill on
    SK.db, SK.char = client:storage().account, client:storage().char
    SK.commands = M.Commands.New({ client = client, engine = engine, sync = sync, host = host, player = player,
        requests = requests, selfcheck = M.SelfCheck, attendance = SK.attendance })
    for _, m in pairs(M) do
        if m.OnInit then m:OnInit() end
    end
    local lists = 0
    for _ in pairs(engine.view.lists) do lists = lists + 1 end
    SK.world = client:world()
    local guild = client.guildName and client:guildName()
    SK:Print(("ready: %d list(s) for %s. Type /gambit to open the window, or /gambit help."):format(lists, guild and ("the guild " .. guild) or "you (no guild)"))
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
pcall(frame.RegisterEvent, frame, "PLAYER_GUILD_UPDATE")
frame:SetScript("OnEvent", function(_, event, unit)
    if event == "PLAYER_LOGIN" then
        frame:UnregisterEvent("PLAYER_LOGIN")
        local ok, err = pcall(Start)
        if not ok then SK:Print("failed to start: " .. tostring(err)) end
    elseif event == "PLAYER_GUILD_UPDATE" and (unit == nil or unit == "player") and SK.client and SK.world and SK.client.world then
        -- joined or left a guild while playing: the open ledger is the old guild's, so say so rather than quietly mixing them
        local ok, now = pcall(SK.client.world, SK.client)
        if ok and now ~= SK.world and not SK.worldWarned then
            SK.worldWarned = true
            SK:Print("your guild changed: type /reload to switch to its ledger (until then this is still the old guild's).")
        end
    end
end)

SLASH_KINGSGAMBIT1 = "/gambit"
SLASH_KINGSGAMBIT2 = "/kg"
SlashCmdList["KINGSGAMBIT"] = function(msg)
    if not SK.commands then SK:Print("not started yet (or it failed to start; see the earlier message)"); return end
    -- `/gambit` alone opens the window; with the game's frame functions missing (or if it fails) the standings are printed as before.
    if (msg or ""):match("^%s*$") and SK.modules.UI and SK.modules.UI.Toggle then
        local ok, shown = pcall(SK.modules.UI.Toggle, SK.modules.UI)
        if ok and shown then return end
        if not ok then SK:Print("the window failed to open: " .. tostring(shown)) end
    end
    -- `/gambit window` opens the Loot window (to look at it between sessions; it opens by itself when a session starts).
    if (msg or ""):match("^%s*window%s+reset%s*$") and SK.modules.UI and SK.modules.UI.ResetWindows then
        SK.modules.UI:ResetWindows()
        SK:Print("the windows are back where they start")
        return
    end
    if (msg or ""):match("^%s*window%s*$") and SK.modules.UI and SK.modules.UI.OpenLoot then
        local ok, err = pcall(SK.modules.UI.OpenLoot, SK.modules.UI)
        if not ok then SK:Print("the loot window failed to open: " .. tostring(err)) end
        return
    end
    local ok, err = pcall(SK.commands.handle, msg)
    if not ok then SK:Print("error: " .. tostring(err)) end
end
