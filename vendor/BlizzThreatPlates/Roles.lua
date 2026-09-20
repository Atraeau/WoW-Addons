
local _, addon = ...

--------------------------------------------------------------------------------
-- Roles Management
--------------------------------------------------------------------------------

-- The minimum heal/damage ratio used to detect a healer
local HEALER_HEAL_DAMAGE_RATIO = 0.3

-- Shapeshift
local SHAPESHIFT_DEFENSIVE_STANCE = 2
local SHAPESHIFT_BEAR_FORM        = 1

-- Damage and Heal recent history to determine if the current player is a healer or dps
local playerRecentEvents

-- Check whether a class can fullfill either healer or dps roles
function addon.IsHealerAndDpsClass(class)
    return class == "PALADIN" or class == "DRUID" or class == "SHAMAN" or class == "PRIEST"
end

-- Initialize the players recent heal/damage history
function addon.InitPlayerRecentEvents()
    if playerRecentEvents == nil and addon.IsHealerAndDpsClass(select(2, UnitClass("player"))) then
        playerRecentEvents = addon.RingBuffer:New(20)
    end
end

-- DAMAGE event detection
function addon.IsDamageEvent(event)
    return event:sub(-7) == "_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD"
end

-- HEAL event detection
function addon.IsHealEvent(event)
    return event:sub(-5) == "_HEAL"
end

-- Update the recent DAMAGE and HEAL event list for the player for role detection purpose
function addon.UpdatePlayerRecentEvents(event, damageAmount, healAmount)
    if playerRecentEvents == nil then
        return
    end

    if addon.IsDamageEvent(event) then
        local damageEvent = {
            type = "DAMAGE",
            amount = damageAmount,
        }
        playerRecentEvents:Add(damageEvent)
    elseif addon.IsHealEvent(event) then
        local healEvent = {
            type = "HEAL",
            amount = healAmount,
        }
        playerRecentEvents:Add(healEvent)
    end
end

-- Return a HEALER or DAMAGER role based on a recent events history
function addon.GetRecentEventsRole(recentEvents)
    if recentEvents == nil then
        return "DAMAGER"
    end

    local totalDamage = 0
    local totalHeal   = 0
    local data        = recentEvents:GetData()
    local count       = recentEvents:GetCount()

    for i = 1, count do
        if data[i] ~= nil then
            if data[i].type == "DAMAGE" then
                totalDamage = totalDamage + data[i].amount
            elseif data[i].type == "HEAL" then
                totalHeal = totalHeal + data[i].amount
            end
        end
    end

    local total = totalHeal + totalDamage
    local healRatio = total > 0 and (totalHeal / total) or 0

    return (healRatio >= HEALER_HEAL_DAMAGE_RATIO) and "HEALER" or "DAMAGER"
end

-- Return true if it's an event triggered by a tank, false if it's an event triggered by a non-tank or nil if we can't tell
function addon.IsTankEvent(class, event, spellId)
    -- Event based tank detection not supported for other classes
    if class ~= "WARRIOR" and class ~= "DRUID" then
        return false
    end

    -- SPELL_AURA based detection (Warrior stance or Druid Form)
    if (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED") and addon.IsTankStanceOrForm(spellId) then
        return (event == "SPELL_AURA_APPLIED")
    end

    -- Stance or Form exclusive spells based detection
    return addon.IsTankSpell(class, spellId)
end

-- Check if a unit has a buff spell or not
local function UnitHasBuffBySpellId(unit, spellId)
    if UnitExists(unit) then
        for i = 1, 40 do
            local aura = C_UnitAuras.GetBuffDataByIndex(unit, i)
            if not aura then
                break
            elseif aura.spellId == spellId then
                return true
            end
        end
    end
    return false
end

-- Check if a unit is a Paladin tank
function addon.IsPaladinTank(unit)
    if UnitExists(unit) then
        local class = select(2, UnitClass(unit))
        if class == "PALADIN" then
            return UnitHasBuffBySpellId(unit, addon.GetRighteousFurySpellId())
        end
    end
    return false
end

-- Check if the player has a certain role (TANK or HEALER) using automatic detection
local function IsPlayerRoleAutomatic(unit, role)
    if role == "TANK" then
        local class = select(2, UnitClass("player"))
        return (class == "WARRIOR" and GetShapeshiftForm() == SHAPESHIFT_DEFENSIVE_STANCE) or
                (class == "DRUID" and GetShapeshiftForm() == SHAPESHIFT_BEAR_FORM) or
                addon.IsPaladinTank("player")
    elseif role == "HEALER" then
        return addon.GetRecentEventsRole(playerRecentEvents) == "HEALER"
    end

    return false
end

-- Check if a unit has a certain role based on his assigned role in the LFG tool
function addon.IsUnitRoleLFGAssignedRole(unit, role, fallbackFct)
    local lfgAssignedRole = UnitGroupRolesAssigned(unit)
    if lfgAssignedRole == role then
        return true
    elseif lfgAssignedRole == "NONE" then
        return fallbackFct(unit, role)
    end

    return false
end

-- Check if the player has a certain role based on the player detection mode
function addon.IsPlayerRole(role)
    local playerRoleDetection = BlizzThreatPlatesCharacterConfig["playerRoleDetection"]

    if playerRoleDetection == addon.ROLE_DETECTION_AUTOMATIC then
        return IsPlayerRoleAutomatic("player", role)
    elseif playerRoleDetection == addon.ROLE_DETECTION_LFG_ROLE then
        return addon.IsUnitRoleLFGAssignedRole("player", role, IsPlayerRoleAutomatic)
    end

    return false
end

-- Get the player's role
function addon.GetPlayerRole()
    if addon.IsPlayerRole("TANK") then
        return "TANK"
    elseif addon.IsPlayerRole("HEALER") then
        return "HEALER"
    else
        return "DAMAGER"
    end
end