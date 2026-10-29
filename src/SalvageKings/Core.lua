-- Salvage Kings: namespace, saved-variable schema, module registry, /sk entry point.
-- Design: docs/salvage-kings/ (manifesto, rationale, design-journal).
local ADDON, SK = ...
_G.SalvageKings = SK

SK.name = ADDON
SK.SCHEMA = 1
SK.modules = {}

-- Modules register themselves so load order stays explicit in the TOC.
function SK:NewModule(name)
    local m = { name = name }
    self.modules[name] = m
    return m
end

-- SalvageKingsDB (account-wide, the shared ledger):
--   schema   number
--   lists    { [listId] = { name, events = {}, head = "" } }   -- append-only per-list chain
--   config   { officerDE = nil, guildBankMode = false, bidTimer = 30, ... }
-- SalvageKingsCharDB (per character): ui = { frame positions, scale, opacity, hints }
local function InitDB()
    SalvageKingsDB = SalvageKingsDB or {}
    local db = SalvageKingsDB
    db.schema = db.schema or SK.SCHEMA
    db.lists = db.lists or {}
    db.config = db.config or {}
    SalvageKingsCharDB = SalvageKingsCharDB or { ui = {} }
    SK.db, SK.char = db, SalvageKingsCharDB
end

function SK:Print(...)
    print("|cff66ccffSK|r", ...)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == ADDON then
        InitDB()
        for _, m in pairs(SK.modules) do
            if m.OnInit then m:OnInit() end
        end
        frame:UnregisterEvent("ADDON_LOADED")
    end
end)

SLASH_SALVAGEKINGS1 = "/sk"
SlashCmdList["SALVAGEKINGS"] = function(msg)
    local cmd = (msg or ""):match("^(%S*)"):lower()
    local ui = SK.modules.UI
    if cmd == "" or cmd == "show" then
        if ui and ui.Toggle then ui:Toggle() else SK:Print("v0.0.1 scaffold -- no UI yet") end
    else
        SK:Print("commands: /sk [show]")
    end
end

-- Long-form alias; /sk kept as the short command (lineage: Suicide Kings).
SLASH_SALVAGEKINGS2 = "/salvage"
