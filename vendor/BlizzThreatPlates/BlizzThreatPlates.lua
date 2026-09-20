
local _, addon = ...

-- Colors
addon.COLOR_RED    = { r = 1,    g = 0,     b = 0 }
addon.COLOR_YELLOW = { r = 1,    g = 1,     b = 0 }
addon.COLOR_GREEN  = { r = 0,    g = 1,     b = 0 }
addon.COLOR_WHITE  = { r = 1,    g = 1,     b = 1 }
addon.COLOR_GREY   = { r = 0.7,  g = 0.7,   b = 0.7 }
addon.COLOR_GOLD   = { r = 0.85, g = 0.675, b = 0 }

-- Threat Status
local STATUS_STRONGLY_NOT_TANKING = 0
local STATUS_WEAKLY_NOT_TANKING   = 1
local STATUS_WEAKLY_TANKING       = 2
local STATUS_STRONGLY_TANKING     = 3

-- Colors for each tank type and status
local THREAT_COLORS = {
    ROLE = {
        MAINTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_RED,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_RED,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_YELLOW,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_GREEN,
        },
        OFFTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_GREEN,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_GREEN,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_GREEN,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_GREEN,
        },
        NOTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_GREEN,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_YELLOW,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_RED,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_RED,
        },
    },
    NOROLE = {
        MAINTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_GREEN,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_GREEN,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_YELLOW,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_RED,
        },
        OFFTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_RED,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_RED,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_RED,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_RED,
        },
        NOTANK = {
            [STATUS_STRONGLY_NOT_TANKING] = addon.COLOR_GREEN,
            [STATUS_WEAKLY_NOT_TANKING]   = addon.COLOR_YELLOW,
            [STATUS_WEAKLY_TANKING]       = addon.COLOR_RED,
            [STATUS_STRONGLY_TANKING]     = addon.COLOR_RED,
        },
    },
}

-- All active nameplates
local nameplates = {}

--------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------

function addon.ShowThreatInformation()
    local showOnlyInGroupRaid = BlizzThreatPlatesConfig["showOnlyInGroupRaid"]
    local petException = BlizzThreatPlatesConfig["petException"]
    local isInGroupRaid = IsInRaid() or IsInGroup()
    local hasPet = UnitExists("pet")

    return not showOnlyInGroupRaid or isInGroupRaid or (petException and hasPet)
end

local function IsNamePlateUnit(unit)
    return unit ~= nil and string.find(unit, "nameplate", 1, true) ~= nil
end

local function hasUnitValidNamePlate(unit)
    if not unit then
        return false
    end

    local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
    if not nameplate then
        return false
    end

    local unitFrame = nameplate.UnitFrame
    if not unitFrame or unitFrame:IsForbidden() then
        return false
    end

    if not IsNamePlateUnit(unit) then
        return false
    end

    return true
end

local function MobUnitIsNotTappedDenied(unit)
    return not UnitIsPlayer(unit) and UnitCanAttack("player", unit) and
           not UnitIsTapDenied(unit) and not UnitIsDead(unit)
end

--------------------------------------------------------------------------------
-- Health Bar Replica
--------------------------------------------------------------------------------

local function CreateHealthBarReplica(unitFrame)
    local healthBar = unitFrame.healthBar
    unitFrame.healthBarReplica = CreateFrame("StatusBar", nil, unitFrame.HealthBarsContainer)
    unitFrame.healthBarReplica:SetOrientation(healthBar:GetOrientation())
    unitFrame.healthBarReplica:SetSize(healthBar:GetWidth(), healthBar:GetHeight())
    unitFrame.healthBarReplica:SetAllPoints(healthBar)
    unitFrame.healthBarReplica:SetStatusBarTexture(healthBar:GetStatusBarTexture():GetTexture())
    unitFrame.healthBarReplica:SetAlpha(healthBar:GetAlpha())
    unitFrame.healthBarReplica:Hide()

    local background = unitFrame.healthBarReplica:CreateTexture(nil, "BACKGROUND")
    background:SetColorTexture(0.2, 0.2, 0.2, 0.85)
    background:SetAllPoints(unitFrame.healthBarReplica)
    unitFrame.healthBarReplica.background = background

    healthBar.regionsAlpha = {}
    local regions = { healthBar:GetRegions() }
    for index, region in ipairs(regions) do
        healthBar.regionsAlpha[index] = region:GetAlpha()
    end

    return unitFrame.healthBarReplica
end

local function SetHealthBarReplicaVisibility(unitFrame, visible)
    local healthBar = unitFrame.healthBar
    local replica = unitFrame.healthBarReplica

    -- Blizzard's Health Bar
    local regions = { healthBar:GetRegions() }
    for index, region in ipairs(regions) do
        region:SetAlpha(visible and 0 or healthBar.regionsAlpha[index])
    end

    -- Health Bar Replica
    if replica then
        if visible then
            replica:Show()
        else
            replica:Hide()
        end
    end

    -- Selection Highlight
    local highlight = unitFrame.selectionHighlight
    if visible then
        highlight:SetParent(replica)
    else
        highlight:SetParent(healthBar)
    end
    highlight:SetAlpha(0.25)
end

--------------------------------------------------------------------------------
-- NamePlate update based on threat events
--------------------------------------------------------------------------------

local function GetThreatColor(threatStatus, isTankedByOtherTank)
    local isPlayerTank = addon.IsPlayerRole("TANK")
    local tankMode = BlizzThreatPlatesCharacterConfig["tankType"]
    local useRole = BlizzThreatPlatesConfig["useRoleBasedColors"] and "ROLE" or "NOROLE"
    local role = isPlayerTank and (tankMode == addon.TANK_TYPE_MAIN and "MAINTANK" or "OFFTANK") or "NOTANK"
    local status = (isPlayerTank and isTankedByOtherTank) and STATUS_STRONGLY_TANKING or threatStatus
    return THREAT_COLORS[useRole][role][status]
end

local function ShowPulledByGroupVisual(unitFrame, mobGUID)
    local mobUnit = unitFrame.displayedUnit or unitFrame.unit
    local topDamageDealerGUID, topDamage = addon.GetMobTopDamageDealer(mobGUID)
    local isTankedByOtherTank = topDamageDealerGUID and addon.IsGroupRole(topDamageDealerGUID, "TANK") or false
    local healthBarColor = GetThreatColor(STATUS_STRONGLY_NOT_TANKING, isTankedByOtherTank)
    unitFrame.healthBarReplica:SetStatusBarColor(healthBarColor.r, healthBarColor.g, healthBarColor.b)
    SetHealthBarReplicaVisibility(unitFrame, BlizzThreatPlatesConfig["enableHealthBarColoring"])
    addon.UpdateThreatIndicator(unitFrame, mobUnit, 0)
    addon.UpdatePriorityMarker()
end

local function ShowThreatVisual(unitFrame, mobGUID, status, threatPct, threatValue)
    local unit = unitFrame.displayedUnit or unitFrame.unit
    addon.UpdateMobsThreatData(unitFrame, unit, threatValue)
    local threatData = addon.GetThreatData(mobGUID)
    local healthBarColor = GetThreatColor(status, threatData.isTankedByOtherTank)
    unitFrame.healthBarReplica:SetStatusBarColor(healthBarColor.r, healthBarColor.g, healthBarColor.b)
    SetHealthBarReplicaVisibility(unitFrame, BlizzThreatPlatesConfig["enableHealthBarColoring"])
    addon.UpdateThreatIndicator(unitFrame, unit, threatPct)
    addon.UpdatePriorityMarker()
end

local function ShowDefaultVisual(unitFrame)
    if unitFrame.threatIndicator then
        unitFrame.threatIndicator:Hide()
    end
    SetHealthBarReplicaVisibility(unitFrame, false)
    addon.UpdatePriorityMarker()
end

local function UpdateHealthBarReplicaValues(unit)
    if not hasUnitValidNamePlate(unit) then
        return
    end

    -- Change the health bar color only for NPCs that can be attacked and are not tapped
    if not MobUnitIsNotTappedDenied(unit) then
        return
    end

    -- Update the health bar values
    local unitFrame = C_NamePlate.GetNamePlateForUnit(unit).UnitFrame
    unitFrame.healthBarReplica:SetMinMaxValues(0, UnitHealthMax(unit))
    unitFrame.healthBarReplica:SetValue(UnitHealth(unit))
end

local function UpdateUnitNamePlate(unit)
    if not hasUnitValidNamePlate(unit) then
        return
    end

    local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
    local unitFrame = nameplate.UnitFrame

    -- Change the health bar color only for NPCs that can be attacked and are not tapped
    if MobUnitIsNotTappedDenied(unit) then
        if unitFrame:IsForbidden() then
            ShowDefaultVisual(unitFrame)
            return
        end

        local mobGUID = UnitGUID(unit)
        local isTanking, status, threatPct, rawThreatPct, threatValue = UnitDetailedThreatSituation("player", unit)

        if threatPct == nil or threatPct > 100 then
            threatPct = 0
        end

        local isOnThreatTable = threatValue ~= nil
        local hasThreat = isOnThreatTable and threatValue > 0
        if hasThreat then
            addon.SetMobStatus(mobGUID, addon.MOB_STATUS_IN_COMBAT_WITH_PLAYER)
        end

        if addon.ShowThreatInformation() then
            local mobStatus = addon.GetMobStatus(mobGUID)
            if mobStatus == addon.MOB_STATUS_IN_COMBAT_WITH_GROUP then
                ShowPulledByGroupVisual(unitFrame, mobGUID)
                return
            elseif hasThreat or (isOnThreatTable and mobStatus == addon.MOB_STATUS_IN_COMBAT_WITH_PLAYER) then
                ShowThreatVisual(unitFrame, mobGUID, status, threatPct, threatValue)
                return
            end
        end
    end

    ShowDefaultVisual(unitFrame)
end

local function UpdateAllNamePlates()
    local nameplates = C_NamePlate.GetNamePlates()
    for _, nameplate in ipairs(nameplates) do
        local unitFrame = nameplate.UnitFrame
        if unitFrame and not unitFrame:IsForbidden() then
            local unit = unitFrame.displayedUnit or unitFrame.unit
            UpdateUnitNamePlate(unit)
        end
    end
end

local function UpdateNamePlatesHealthColorForGUID(mobGUID)
    local unitFrame = addon.GetUnitFrameByGUID(mobGUID)
    if unitFrame then
        local unit = unitFrame.displayedUnit or unitFrame.unit
        UpdateUnitNamePlate(unit)
    end
end

--------------------------------------------------------------------------------
-- Pulled mobs tracking and tank detection
--------------------------------------------------------------------------------
local function IsAttackableNPC(destFlags)
    local isNeutral       = bit.band(destFlags, COMBATLOG_OBJECT_REACTION_NEUTRAL) > 0
    local isHostile       = bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0
    local isNPCControlled = bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_NPC) > 0
    local isNPC           = bit.band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) > 0
    local isPet           = bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PET) > 0
    local isGuardian      = bit.band(destFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) > 0

    return (isNeutral or isHostile) and isNPCControlled and (isNPC or isPet or isGuardian)
end

local function OnCombatLogEvent()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
          destFlags, destRaidFlags, p12, p13, p14, p15, p16, p17, p18, p19, p20 = CombatLogGetCurrentEventInfo()

    local spellId      = p12
    local damageAmount = (event == "SWING_DAMAGE") and p12 or p15
    local healAmount   = p15

    -- Update the recent DAMAGE and HEAL event list for the player for role detection purpose.
    if sourceGUID == UnitGUID("player") then
        addon.UpdatePlayerRecentEvents(event, damageAmount, healAmount)
    end

    -- Only consider events from players or pets in our group / raid
    if sourceGUID and destGUID and addon.IsInGroup(sourceGUID) then

        -- Update group members roles based on combat log
        addon.UpdateGroupRole(sourceGUID, event, spellId, damageAmount, healAmount)

        if addon.GetMobStatus(destGUID) ~= addon.MOB_STATUS_IN_COMBAT_WITH_PLAYER then
            if (IsAttackableNPC(destFlags)) then
                local isThreatEvent = false
                local isSpell = (
                    event == "SPELL_DAMAGE" or
                    event == "SPELL_PERIODIC_DAMAGE" or
                    event == "DAMAGE_SHIELD" or
                    event == "DAMAGE_SPLIT")

                -- Threat-generating events
                if event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" or isSpell then
                    isThreatEvent = true
                elseif event == "SPELL_AURA_APPLIED" then
                    local auraType = p15
                    if auraType == "DEBUFF" and not addon.IsNoThreatDebuff(spellId) then
                        isThreatEvent = true
                    end
                end

                if isThreatEvent then
                    local damage
                    if event == "SWING_DAMAGE" then
                        damage = p12
                    elseif event == "RANGE_DAMAGE" or
                           event == "SPELL_DAMAGE" or
                           event == "SPELL_PERIODIC_DAMAGE" or
                           event == "DAMAGE_SHIELD" or
                           event == "DAMAGE_SPLIT" then
                        damage = p15
                    elseif event == "SPELL_AURA_APPLIED" then
                        damage = 0
                    end

                    if not addon.GetMobStatus(destGUID) then
                        addon.SetMobStatus(destGUID, addon.MOB_STATUS_IN_COMBAT_WITH_GROUP)
                    end

                    if damage then
                        addon.AddMobDamageReceived(destGUID, sourceGUID, damage)
                    end

                    UpdateNamePlatesHealthColorForGUID(destGUID)
                end
            end
        end
    end

    if destGUID and event == "UNIT_DIED" then
        local isPet = destGUID:match("^Pet")
        if isPet then
            -- Remove dead pets from group
            addon.DeleteGroupData(destGUID)
        else
            -- Remove dead mobs from mob list
            addon.DeleteMobData(destGUID)
        end
    end
end

--------------------------------------------------------------------------------
-- Miscellaneous
--------------------------------------------------------------------------------

local function OnNamePlateAdded(unit)
    local unitFrame = C_NamePlate.GetNamePlateForUnit(unit).UnitFrame
    nameplates[unit] = unitFrame
    if not unitFrame.healthBarReplica then
        CreateHealthBarReplica(unitFrame)
    end
    SetHealthBarReplicaVisibility(unitFrame, false)
    UpdateHealthBarReplicaValues(unit)
    UpdateUnitNamePlate(unit)
end

local function OnNamePlateRemoved(unit)
    local unitFrame = nameplates[unit]
    if unitFrame then
        SetHealthBarReplicaVisibility(unitFrame, false)
	nameplates[unit] = nil
    end
    
    local unitGUID = UnitGUID(unit)
    if unitGUID then
        addon.DeleteThreatData(unitGUID)
    end
    addon.UpdatePriorityMarker()
end

local function OnCombatEnd()
    addon.DeleteAllMobData()
end

--------------------------------------------------------------------------------
-- Events
--------------------------------------------------------------------------------

local function OnAddonLoaded(self, event, addonName)
    if addonName == "BlizzThreatPlates" then
        addon.InitConfigs()
        addon.InitPriorityMarker()
        addon.InitPlayerRecentEvents()
        addon.UpdateGroupData()
        addon.DeleteAllMobData()
    end
end

local function EventHandler(_, event, ...)
    if event == "UPDATE_SHAPESHIFT_FORM" then
        UpdateAllNamePlates()
    elseif event == "UNIT_AURA" then
        local unit = ...
        if unit == "player" then
            UpdateAllNamePlates()
        else
            addon.UpdateGroupPaladinTank(unit)
            if IsNamePlateUnit(unit) then
                -- Update Priority Marker after Polymorph is cast
                addon.UpdatePriorityMarker()
            end
        end
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        OnNamePlateAdded(...)
    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        OnNamePlateRemoved(...)
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        OnCombatLogEvent()
    elseif event == "PLAYER_REGEN_ENABLED" then
        OnCombatEnd()
    elseif event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" then
        local unit = ...
        if IsNamePlateUnit(unit) then
            UpdateHealthBarReplicaValues(unit)
        end
    elseif event == "GROUP_ROSTER_UPDATE" or event == "UNIT_PET" then
        addon.UpdateGroupData()
        UpdateAllNamePlates()
    elseif event == "UNIT_TARGET" then
        local unit = ...
        if unit ~= "player" then
            addon.UpdateGroupUnitTarget(unit)
        end
    elseif event == "UNIT_THREAT_LIST_UPDATE" or event == "UNIT_THREAT_SITUATION_UPDATE" or event == "PLAYER_TARGET_CHANGED" then
        UpdateUnitNamePlate(...)
    end
end

-- Blizz Threat Plates initialization
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", OnAddonLoaded)

-- Initialize the event handler frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
eventFrame:RegisterEvent("UNIT_AURA")
eventFrame:RegisterEvent("UNIT_HEALTH")
eventFrame:RegisterEvent("UNIT_TARGET")
eventFrame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
eventFrame:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
eventFrame:RegisterEvent("UNIT_PET")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:SetScript("OnEvent", EventHandler)