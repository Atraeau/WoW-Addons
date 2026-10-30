-- King's Gambit: namespace, startup wiring (the composition root), /gambit entry point.
-- The module registry is Registry.lua, loaded first.
-- Design: docs/kings-gambit/ (manifesto, rationale, design-journal).
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

-- Everything is built at PLAYER_LOGIN, when the player's name, realm and group are all known.
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
    SK.db, SK.char = client:storage().account, client:storage().char
    SK.commands = M.Commands.New({ client = client, engine = engine, sync = sync, host = host, player = player,
        requests = requests, selfcheck = M.SelfCheck })
    for _, m in pairs(M) do
        if m.OnInit then m:OnInit() end
    end
    local lists = 0
    for _ in pairs(engine.view.lists) do lists = lists + 1 end
    SK:Print(("ready: %d list(s). Type /gambit help."):format(lists))
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
    local ok, err = pcall(SK.commands.handle, msg)
    if not ok then SK:Print("error: " .. tostring(err)) end
end
