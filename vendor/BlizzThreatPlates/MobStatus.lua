
local _, addon = ...

--------------------------------------------------------------------------------
-- Mob status
--------------------------------------------------------------------------------

-- Mob status
addon.MOB_STATUS_IN_COMBAT_WITH_GROUP  = 1 -- In combat with other group members but not with player
addon.MOB_STATUS_IN_COMBAT_WITH_PLAYER = 2 -- In combat with player

-- Mob data indexed by GUID
local mobData = {}

function addon.GetMobStatus(mobGUID)
    if mobData[mobGUID] and mobData[mobGUID].status then
        return mobData[mobGUID].status
    else
        return nil
    end
end

function addon.SetMobStatus(mobGUID, mobStatus)
    mobData[mobGUID] = mobData[mobGUID] or {}
    mobData[mobGUID].status = mobStatus
end

function addon.GetMobTargetCounter(mobGUID)
    if mobData[mobGUID] and mobData[mobGUID].targetCounter then
        return mobData[mobGUID].targetCounter
    else
        return 0
    end
end

function addon.SetMobTargetCounter(mobGUID, targetCounter)
    mobData[mobGUID] = mobData[mobGUID] or {}
    mobData[mobGUID].targetCounter = targetCounter
end

function addon.DeleteMobData(mobGUID)
    mobData[mobGUID] = nil
end

function addon.DeleteAllMobData()
    wipe(mobData)
end

function addon.GetUnitFrameByGUID(GUID)
    if not GUID then
        return nil
    end

    local nameplates = C_NamePlate.GetNamePlates()
    for _, nameplate in ipairs(nameplates) do
        local unitFrame = nameplate.UnitFrame
        if unitFrame and not unitFrame:IsForbidden() then
            local unit = unitFrame.displayedUnit or unitFrame.unit
            if unit and UnitGUID(unit) == GUID then
                return unitFrame
            end
        end
    end

    return nil
end

function addon.GetDamagePriorityMobUnitFrame()
    local prioritizeElitesOnly = BlizzThreatPlatesConfig["prioritizeElitesOnly"]
    local topDamageMobUnitFrame, topDamage

    for mobGUID, data in pairs(mobData) do
        if data.status == addon.MOB_STATUS_IN_COMBAT_WITH_GROUP then
            local unitFrame = addon.GetUnitFrameByGUID(mobGUID)
            if unitFrame then
                local unit = unitFrame.displayedUnit or unitFrame.unit
                if (not prioritizeElitesOnly or addon.UnitIsEliteOrBoss(unit)) and
                    addon.UnitHasMinimumHealth(unit) and data.damageReceived and not addon.UnitIsIncapacitated(unit) then
                    for groupGUID, damageReceived in pairs(data.damageReceived) do
                        if (topDamage == nil or damageReceived > topDamage) and not addon.IsGroupRole(groupGUID, "TANK") then
                            topDamageMobUnitFrame = unitFrame
                            topDamage = damageReceived
                        end
                    end
                end
            end
        end
    end

    return topDamageMobUnitFrame
end

function addon.GetHealerAndDpsPriorityNameplateByDamage(minimumSafeDamage)
    local nameplate
    local lowestHealthPercent

    for mobGUID, data in pairs(mobData) do
        if data.status == addon.MOB_STATUS_IN_COMBAT_WITH_GROUP then
            local unitFrame = addon.GetUnitFrameByGUID(mobGUID)
            if unitFrame then
                local unit = unitFrame.displayedUnit or unitFrame.unit
                if UnitHealthMax(unit) > 0 then
                    local healthPercent = UnitHealth(unit) / UnitHealthMax(unit)
                    local hasHealth = healthPercent and healthPercent > 0 or false
                    if hasHealth then
                        local isLowestHealth = (lowestHealthPercent == nil or healthPercent < lowestHealthPercent)
                        if isLowestHealth then
                            local topDamage = select(2, addon.GetMobTopDamageDealer(mobGUID))
                            if topDamage > minimumSafeDamage and not addon.UnitIsIncapacitated(unit) then
                                nameplate = unitFrame
                                lowestHealthPercent = healthPercent
                            end
                        end
                    end
                end
            end
        end
    end

    return nameplate, lowestHealthPercent
end

-- Increase the damage received amount on a certain mob
function addon.AddMobDamageReceived(mobGUID, groupGUID, damageReceived)
    mobData[mobGUID].damageReceived = mobData[mobGUID].damageReceived or {}
    mobData[mobGUID].damageReceived[groupGUID] = mobData[mobGUID].damageReceived[groupGUID] or 0
    mobData[mobGUID].damageReceived[groupGUID] = mobData[mobGUID].damageReceived[groupGUID] + damageReceived
end

-- Return the top damage dealer and the top damage done on a mob
function addon.GetMobTopDamageDealer(mobGUID)
    local topDamageDealerGUID, topDamage

    if mobData[mobGUID].damageReceived then
        for groupGUID, damage in pairs(mobData[mobGUID].damageReceived) do
            if topDamage == nil or damage > topDamage then
                topDamageDealerGUID = groupGUID
                topDamage = damage
            end
        end
    end

    return topDamageDealerGUID, topDamage
end