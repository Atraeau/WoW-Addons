# Curated, runnable examples for the API doc generator.
# Key = "<Namespace>.<Function>" (namespaced) or "<Function>" (global).
# Only keys that match a documented function are used; others are reported as warnings.
# These override the auto-generated example for that function.
@{
    'C_Timer.After' = @'
-- Run a function once after a delay (in seconds)
C_Timer.After(2, function()
    print("2 seconds later")
end)
'@

    'C_Timer.NewTicker' = @'
-- Repeat every 5s; pass a 3rd arg to limit iterations (omit for infinite)
local ticker = C_Timer.NewTicker(5, function()
    print("tick")
end, 3)
-- ticker:Cancel()  -- stop early
'@

    'C_AddOns.GetAddOnMetadata' = @'
-- Read a field from an addon's .toc (## Version:, ## Title:, ## X-*:)
local version = C_AddOns.GetAddOnMetadata("BlizzThreatPlates", "Version")
print(version)
'@

    'C_AddOns.IsAddOnLoaded' = @'
if not C_AddOns.IsAddOnLoaded("Blizzard_APIDocumentation") then
    C_AddOns.LoadAddOn("Blizzard_APIDocumentation")
end
'@

    'C_Spell.GetSpellInfo' = @'
-- Modern replacement for the old multi-return GetSpellInfo; returns a table.
local info = C_Spell.GetSpellInfo(2050)  -- 2050 = Lesser Heal
if info then
    print(info.name, info.spellID, info.iconID, info.castTime)
end
'@

    'C_Spell.GetSpellCooldown' = @'
-- Returns a SpellCooldownInfo table
local cd = C_Spell.GetSpellCooldown(2050)
if cd and cd.duration > 0 then
    local remaining = (cd.startTime + cd.duration) - GetTime()
    print(("%.1fs remaining"):format(remaining))
end
'@

    'C_Spell.GetSpellTexture' = @'
local icon = C_Spell.GetSpellTexture(2050)
print(icon)  -- fileID of the spell's icon
'@

    'C_Spell.IsSpellUsable' = @'
local usable, insufficientPower = C_Spell.IsSpellUsable(2050)
print(usable, insufficientPower)
'@

    'C_UnitAuras.GetAuraDataByIndex' = @'
-- Iterate a unit's buffs (filter "HELPFUL"/"HARMFUL") until nil
for i = 1, 40 do
    local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
    if not aura then break end
    print(aura.name, aura.spellId, aura.applications)
end
'@

    'C_UnitAuras.GetBuffDataByIndex' = @'
local aura = C_UnitAuras.GetBuffDataByIndex("player", 1)
if aura then
    print(aura.name, aura.spellId, aura.expirationTime)
end
'@

    'C_Item.GetItemInfo' = @'
-- May return nil until the item is cached; listen for GET_ITEM_INFO_RECEIVED.
local name, link, quality, itemLevel = C_Item.GetItemInfo(6948)  -- Hearthstone
print(name, quality, itemLevel)
'@

    'C_Item.GetItemInfoInstant' = @'
-- Instant, cache-independent basics
local itemID, itemType, itemSubType, equipLoc, icon = C_Item.GetItemInfoInstant(6948)
print(itemID, itemType, icon)
'@

    'C_Item.GetItemCount' = @'
local count = C_Item.GetItemCount(6948, false, false)  -- bags only
print("You have", count)
'@

    'C_Map.GetBestMapForUnit' = @'
local mapID = C_Map.GetBestMapForUnit("player")
print("Current mapID:", mapID)
'@

    'C_Map.GetPlayerMapPosition' = @'
local mapID = C_Map.GetBestMapForUnit("player")
local pos = C_Map.GetPlayerMapPosition(mapID, "player")
if pos then
    local x, y = pos:GetXY()
    print(("%.1f, %.1f"):format(x * 100, y * 100))
end
'@

    'C_ChatInfo.RegisterAddonMessagePrefix' = @'
-- Register your prefix (<= 16 chars) before sending/receiving addon comms
C_ChatInfo.RegisterAddonMessagePrefix("MyAddon")
'@

    'C_ChatInfo.SendAddonMessage' = @'
-- channelType: "PARTY", "RAID", "GUILD", "WHISPER" (needs target), "INSTANCE_CHAT"
C_ChatInfo.SendAddonMessage("MyAddon", "hello", "PARTY")
'@

    'C_Container.GetContainerNumSlots' = @'
local slots = C_Container.GetContainerNumSlots(0)  -- bagID 0 = backpack
print(slots)
'@

    'C_Container.GetContainerItemInfo' = @'
-- Returns a ContainerItemInfo table, or nil for an empty slot
local info = C_Container.GetContainerItemInfo(0, 1)
if info then
    print(info.itemID, info.stackCount, info.hyperlink)
end
'@

    'C_NamePlate.GetNamePlateForUnit' = @'
local nameplate = C_NamePlate.GetNamePlateForUnit("nameplate1")
if nameplate then
    print(nameplate.UnitFrame.healthBar:GetValue())
end
'@

    'UnitName' = @'
local name, realm = UnitName("target")
print(name, realm)  -- realm is nil when the unit is on your realm
'@

    'UnitClass' = @'
local className, classFile, classID = UnitClass("player")
print(className, classFile, classID)  -- e.g. "Warrior", "WARRIOR", 1
'@

    'UnitHealth' = @'
local hp, hpMax = UnitHealth("player"), UnitHealthMax("player")
print(("%d / %d"):format(hp, hpMax))
'@

    'UnitGUID' = @'
local guid = UnitGUID("target")
if guid then
    local kind, _, _, _, _, npcID = strsplit("-", guid)
    print(kind, npcID)  -- e.g. "Creature", "12345"
end
'@

    'GetTime' = @'
-- High-precision seconds since client start; use for timers/throttling, not wall-clock.
local start = GetTime()
-- ... later ...
print(("elapsed: %.3fs"):format(GetTime() - start))
'@

    'UnitDetailedThreatSituation' = @'
-- WoW 12.0: returns are SECRET for enemy units -- addon code cannot read/compare them.
local isTanking, status, threatPct, rawThreatPct, threatValue =
    UnitDetailedThreatSituation("player", "target")
if issecretvalue(status) then
    return  -- only the Blizzard UI may act on secret threat values
end
print(status, threatPct)
'@

    'issecretvalue' = @'
-- True if the value is a protected "secret" value (WoW 12.0). Safe on any value, incl. nil.
local threat = UnitThreatSituation("player", "target")
if issecretvalue(threat) then
    print("threat is secret in this context")
end
'@
}
