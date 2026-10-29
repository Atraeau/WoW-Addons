-- King's Gambit: namespace, saved-variable schema, module registry, /gambit entry point.
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

-- KingsGambitDB (account-wide, the shared ledger):
--   schema   number
--   lists    { [listId] = { name, events = {}, head = "" } }   -- append-only per-list chain
--   config   { officerDE = nil, guildBankMode = false, bidTimer = 30, ... }
-- KingsGambitCharDB (per character): ui = { frame positions, scale, opacity, hints }
local function InitDB()
    KingsGambitDB = KingsGambitDB or {}
    local db = KingsGambitDB
    db.schema = db.schema or SK.SCHEMA
    db.lists = db.lists or {}
    db.config = db.config or {}
    KingsGambitCharDB = KingsGambitCharDB or { ui = {} }
    SK.db, SK.char = db, KingsGambitCharDB
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

SLASH_KINGSGAMBIT1 = "/gambit"
SlashCmdList["KINGSGAMBIT"] = function(msg)
    local cmd = (msg or ""):match("^(%S*)"):lower()
    local ui = SK.modules.UI
    if cmd == "" or cmd == "show" then
        if ui and ui.Toggle then ui:Toggle() else SK:Print("v0.0.1 scaffold -- no UI yet") end
    else
        SK:Print("commands: /gambit [show]")
    end
end

-- Short alias.
SLASH_KINGSGAMBIT2 = "/kg"
