-- King's Gambit: namespace, module registry, startup wiring, /gambit entry point.
-- Design: docs/kings-gambit/ (manifesto, rationale, design-journal).
local ADDON, SK = ...
_G.KingsGambit = SK

SK.name = ADDON
SK.SCHEMA = 1
SK.modules = {}

-- Modules register themselves so load order stays explicit in the TOC.
function SK:NewModule(name)
    local m = { name = name }
    self.modules[name] = m
    return m
end

-- SavedVariables (created by RealClient:storage(), read by the Engine):
-- KingsGambitDB (account-wide): schema, lists = { [listId] = { events = {...} } }, config, selfcheck
-- KingsGambitCharDB (per character): ui = { frame positions, scale, opacity, hints }

function SK:Print(...)
    print("|cff66ccffGambit|r", ...)
end

local function Start()
    local client = SK.modules.RealClient.New()
    SK.client = client
    SK.engine = SK.modules.Engine.New(client)
    SK.db, SK.char = client:storage().account, client:storage().char
    for _, m in pairs(SK.modules) do
        if m.OnInit then m:OnInit() end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == ADDON then
        frame:UnregisterEvent("ADDON_LOADED")
        local ok, err = pcall(Start)
        if not ok then SK:Print("failed to start: " .. tostring(err)) end
    end
end)

SLASH_KINGSGAMBIT1 = "/gambit"
SlashCmdList["KINGSGAMBIT"] = function(msg)
    local cmd = (msg or ""):match("^(%S*)"):lower()
    if not SK.client then SK:Print("not started (see earlier error)"); return end
    if cmd == "" or cmd == "show" then
        local ui = SK.modules.UI
        if ui and ui.Toggle then ui:Toggle() else SK:Print("v0.0.1 scaffold, no UI yet. Try /gambit check") end
    elseif cmd == "check" then
        SK.modules.SelfCheck.Run(SK.client)
    else
        SK:Print("commands: /gambit [show] | check")
    end
end

-- Short alias.
SLASH_KINGSGAMBIT2 = "/kg"
