-- King's Gambit: namespace, startup wiring (the composition root), /gambit entry point.
-- The module registry is Registry.lua, loaded first.
-- Design: docs/ (manifesto, rationale, design-journal).
local ADDON, SK = ...
_G.KingsGambit = SK

SK.name = ADDON
SK.SCHEMA = 1

-- SavedVariables (created by RealClient:storage(), read by the Engine):
-- KingsGambitDB (account-wide): schema, lists = { [listId] = { events = {...} } }, config, orphans, selfcheck
-- KingsGambitCharDB (per character): ui = { frame positions, scale, opacity, hints }

function SK:Print(...)
    print("|cff66ccffGambit|r", ...)
end

-- Everything is built at PLAYER_LOGIN, when the player's name and group are all known.
local function Start()
    SK:Resolve() -- every file has loaded: hand each module what it depends on
    local M = SK.modules
    local client = M.RealClient.New()
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
    SK:Print(("ready: %d list(s). Type /gambit to open the window, or /gambit help."):format(lists))
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        frame:UnregisterEvent("PLAYER_LOGIN")
        local ok, err = pcall(Start)
        if not ok then SK:Print("failed to start: " .. tostring(err)) end
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
