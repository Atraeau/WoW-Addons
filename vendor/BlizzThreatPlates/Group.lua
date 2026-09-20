
local _, addon = ...

--------------------------------------------------------------------------------
-- Group management
--------------------------------------------------------------------------------

-- Group data indexed by GUID
-- Define the class of each group member and if it's a tank.
local groupData = {}

-- Return all group units but excluding the player.
function addon.GetGroupUnits(includePets)
    local groupType
    local nbMembers
    local units = {}

    if IsInRaid() then
        groupType = "raid"
        nbMembers = GetNumGroupMembers()
    elseif IsInGroup() then
        groupType = "party"
        nbMembers = GetNumSubgroupMembers()
    end

    -- The player's pet
    if includePets and UnitExists("pet") and groupType ~= "raid" then
        units[#units + 1] = "pet"
    end

    -- Group players and their pets.
    if groupType == "party" or groupType == "raid" then
        for i = 1, nbMembers do
            local unit = groupType .. i
            if UnitExists(unit) then
                if not UnitIsUnit(unit, "player") then
                    units[#units + 1] = unit
                end
                if includePets then
                    local petUnit = groupType .. "pet" .. i
                    if UnitExists(petUnit) then
                        units[#units + 1] = petUnit
                    end
                end
            end
        end
    end

    return units
end

-- Detect group members roles based on combat log
function addon.UpdateGroupRole(groupGUID, event, spellId, damageAmount, healAmount)
    if not groupData[groupGUID] then
        return
    end

    local unit = groupData[groupGUID].unit
    local class = select(2, UnitClass(unit))

    -- Damage and Heal recent history to determine if a player is a healer or dps
    if groupData[groupGUID].recentEvents ~= nil then
        if addon.IsDamageEvent(event) then
            local damageEvent = {
                type   = "DAMAGE",
                amount = damageAmount,
            }
            groupData[groupGUID].recentEvents:Add(damageEvent)
        elseif addon.IsHealEvent(event) then
            local healEvent = {
                type   = "HEAL",
                amount = healAmount,
            }
            groupData[groupGUID].recentEvents:Add(healEvent)
        end
    end


    local isTankEvent = addon.IsTankEvent(class, event, spellId)
    if isTankEvent ~= nil then
        groupData[groupGUID].isTank = isTankEvent
    end
end

local function IsGroupUnit(unit, includePets)
    if not UnitExists(unit) or UnitIsUnit(unit, "player") then
        return false
    end

    local isParty     = unit:match("^party%d+$")
    local isRaid      = unit:match("^raid%d+$")
    local isPlayerPet = unit == "pet"
    local isPartyPet  = unit:match("^party%d+pet$")
    local isRaidPet   = unit:match("^raid%d+pet$")

    if isParty or isRaid then
        return true
    end

    if includePets and (isPlayerPet or isPartyPet or isRaidPet) then
        return true
    end

    return false
end

local function GetUnitTargetGUID(unit)
    if UnitExists(unit) then
        return UnitGUID(unit .. "target")
    end
    return nil
end

-- Update the Paladin tank status of a group member.
function addon.UpdateGroupPaladinTank(unit)
    local guid = UnitGUID(unit)
    if not guid or not IsGroupUnit(unit, true) then
        return
    end

    local class = select(2, UnitClass(unit))
    if class == "PALADIN" and groupData[guid] ~= nil then
        groupData[guid].isTank = addon.IsPaladinTank(unit)
    end
end

-- Remove a group member from groupData
function addon.DeleteGroupData(groupGUID)
    groupData[groupGUID] = nil
end

-- Update groupData with group classes and Paladin tanks.
function addon.UpdateGroupData()
    local units = addon.GetGroupUnits(true)
    local current = {}

    for _, unit in ipairs(units) do
        local guid = UnitGUID(unit)
        local isNewGroupMember = (groupData[guid] == nil)
        current[guid] = unit

        if isNewGroupMember then
            groupData[guid] = {}
            groupData[guid].unit = unit
            groupData[guid].isTank = false

            local class = select(2, UnitClass(unit))
            if addon.IsHealerAndDpsClass(class) then
                groupData[guid].recentEvents = addon.RingBuffer:New(20)
            end
        end

        addon.UpdateGroupPaladinTank(unit)
    end

    for guid in pairs(groupData) do
        if not current[guid] then
            groupData[guid] = nil
        end
    end
end

-- Update the target of a group unit
function addon.UpdateGroupUnitTarget(unit)
    if not IsGroupUnit(unit, false) then
        return
    end

    local guid = UnitGUID(unit)

    if not guid or not groupData[guid] then
        return
    end

    local oldTarget = groupData[guid].target
    if oldTarget then
        local oldCounter = addon.GetMobTargetCounter(oldTarget)
        addon.SetMobTargetCounter(oldTarget, math.max(oldCounter - 1, 0))
        addon.UpdateTargetCounter(oldTarget)
    end

    local newTarget = GetUnitTargetGUID(unit)
    groupData[guid].target = newTarget

    if newTarget then
        local newCounter = addon.GetMobTargetCounter(newTarget) + 1
        addon.SetMobTargetCounter(newTarget, newCounter)
        addon.UpdateTargetCounter(newTarget)
    end
end

-- Get the number of group members targeting guid
function addon.GetGroupTargetCounter(guid)
    local counter = 0
    local groupUnits = addon.GetGroupUnits(false)
    for _, groupUnit in ipairs(groupUnits) do
        local groupGUID = UnitGUID(groupUnit)
        if groupData[groupGUID].target and groupData[groupGUID].target == guid then
            counter = counter + 1
        end
    end
    return counter
end

-- Check if a guid is a group member
function addon.IsInGroup(guid)
    return groupData[guid] ~= nil
end

-- Get the unit of a group player
function addon.GetGroupUnit(guid)
    return groupData[guid] and groupData[guid].unit or false
end

-- Check if a group player has a certain role (TANK or HEALER) using automatic detection
local function IsGroupRoleAutomatic(unit, role)
    local guid = UnitGUID(unit)

    if groupData[guid] == nil then
        return false
    end

    if role == "TANK" then
        -- Check if a group player is a tank automatically based on stance, form or Righteous Fury.
        return groupData[guid].isTank
    elseif role == "HEALER" then
        -- Check if a group player is a healer automatically based on his heal/damage ratio.
        return addon.GetRecentEventsRole(groupData[guid].recentEvents) == "HEALER"
    end

    return false
end

-- Check if a group player has a certain role based on the player detection mode
function addon.IsGroupRole(guid, role)
    if groupData[guid] == nil or guid:match("^Pet") then
        return false
    end

    local groupRoleDetection = BlizzThreatPlatesConfig["groupRoleDetection"]
    local unit = groupData[guid].unit

    if groupRoleDetection == addon.ROLE_DETECTION_AUTOMATIC then
        return IsGroupRoleAutomatic(unit, role)
    elseif groupRoleDetection == addon.ROLE_DETECTION_LFG_ROLE then
        return addon.IsUnitRoleLFGAssignedRole(unit, role, IsGroupRoleAutomatic)
    end

    return false
end

-- Get the group player's role
function addon.GetGroupRole(guid)
    if addon.IsGroupRole(guid, "TANK") then
        return "TANK"
    elseif addon.IsGroupRole(guid, "HEALER") then
        return "HEALER"
    else
        return "DAMAGER"
    end
end
