-- King's Gambit: a button in the addon's own look, used by the Guild book (UI.lua) and the Loot window (LootWindow.lua). Keep this file Lua 5.1-safe.
-- With the skin (UISkin.lua) it is the addon's button; without it, the game's stock red one.
local _, SK = ...
local Skin
local M = SK:NewModule("UIButton", { "UISkin?" }, function(d) Skin = d.UISkin end)

function M.New(parent, text, w, h)
    if Skin then return Skin.Button(parent, text, w, h) end
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w, h or 22)
    b:SetText(text)
    return b
end
