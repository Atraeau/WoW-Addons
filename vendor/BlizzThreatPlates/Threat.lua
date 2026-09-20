
local _, addon = ...

--------------------------------------------------------------------------------
-- Threat calculation
--------------------------------------------------------------------------------

-- Threat of the player on every mob that has a nameplate.
local mobsThreatData = {}

-- An history of the player's recent threat per second calculations
local playerTpsSamples

local function GetMedianTPS()
    if playerTpsSamples == nil then
        return 0
    end

    local data     = playerTpsSamples:GetData()
    local count    = playerTpsSamples:GetCount()

    if count == 0 then
        return 0
    end

    local sortedTPS = {}

    for i = 1, count do
        if data[i] ~= nil then
            sortedTPS[#sortedTPS + 1] = data[i]
        end
    end

    table.sort(sortedTPS)

    local n = #sortedTPS

    if n % 2 == 1 then
        -- Odd number of samples -> middle element
        return sortedTPS[(n + 1) / 2]
    else
        -- Even number of samples -> average of the 2 middle elements
        local mid = n / 2
        return (sortedTPS[mid] + sortedTPS[mid + 1]) / 2
    end
end

local function SavePlayerRecentTPS(mobGUID)
    if mobsThreatData[mobGUID] then
        local currentTime     = mobsThreatData[mobGUID].lastTime
        local currentThreat   = mobsThreatData[mobGUID].threatValue
        local timeDiff        = currentTime - mobsThreatData[mobGUID].startTime
        local threatDiff      = currentThreat - mobsThreatData[mobGUID].startThreat
        local threatPerSecond = 0

        if timeDiff > 0 then
            threatPerSecond = threatDiff / timeDiff
        end

        if threatPerSecond > 0 then
            playerTpsSamples:Add(threatPerSecond)
            BlizzThreatPlatesCharacterConfig["medianTPS"] = GetMedianTPS()
        end
    end
end

function addon.UpdateMobsThreatData(nameplate, mobUnit, playerThreatValue)
    local mobGUID = UnitGUID(mobUnit)
    if not mobGUID then
        return
    end

    local groupThreatValues = {}
    local groupUnits = addon.GetGroupUnits(true)
    local isTankedByOtherTank = false

    for _, groupUnit in ipairs(groupUnits) do
        local isTanking, _, threatPct, _, threatValue = UnitDetailedThreatSituation(groupUnit, mobUnit)

        if threatPct == nil or threatPct > 100 then
            threatPct = 0
        end

        local groupGUID = UnitGUID(groupUnit)
        if isTanking and addon.IsGroupRole(groupGUID, "TANK") then
            isTankedByOtherTank = true
        end
        groupThreatValues[#groupThreatValues + 1] = {
            unit         = groupUnit,
            threatValue  = threatValue or 0,
            threatPct    = threatPct or 0,
        }
    end

    table.sort(groupThreatValues, function(a, b)
        return a.threatValue > b.threatValue
    end)

    local threatLeadValue
    local rawThreatPct
    local threatLeaderUnit
    local threatLeaderName
    local threatLeaderClass
    local threatLeaderRole
    local threatLeaderIsPlayer

    if #groupThreatValues > 0 then
        local groupThreatLeader = groupThreatValues[1]
        threatLeadValue         = playerThreatValue - groupThreatLeader.threatValue
        threatLeaderIsPlayer    = playerThreatValue >= groupThreatLeader.threatValue
        threatLeaderUnit        = threatLeaderIsPlayer and "player" or groupThreatLeader.unit

        -- rawThreatPct from UnitDetailedThreatSituation is incorrect while tanking so we calculate it manually
        if groupThreatLeader.threatValue == 0 then
            rawThreatPct = (playerThreatValue > 0) and 100 or 0
        else
            rawThreatPct = math.min(playerThreatValue * 100 / groupThreatLeader.threatValue, 999)
        end
    else
        threatLeadValue         = playerThreatValue
        rawThreatPct            = 100
        threatLeaderIsPlayer    = true
        threatLeaderUnit        = "player"
    end

    local threatLeaderGUID = UnitGUID(threatLeaderUnit)
    threatLeaderName       = UnitName(threatLeaderUnit)
    threatLeaderClass      = select(2, UnitClass(threatLeaderUnit))
    threatLeaderRole       = threatLeaderIsPlayer and addon.GetPlayerRole() or addon.GetGroupRole(threatLeaderGUID)
    threatLeadValue        = threatLeadValue / 100

    -- Threat per second calculation
    if playerTpsSamples == nil then
        playerTpsSamples = addon.RingBuffer:New(10)
    end

    local currentTime = GetTime()
    local startTime
    local startThreat
    if mobsThreatData[mobGUID] then
        if currentTime - mobsThreatData[mobGUID].lastTime > 5 then
            -- If there was more than 5 seconds since the last threat event we assume the player stopped attacking this
            -- mob so we restart counting from 0 since we want continuous threat data.
            SavePlayerRecentTPS(mobGUID)
            startTime = currentTime
            startThreat = playerThreatValue / 100
        else
            startTime   = mobsThreatData[mobGUID].startTime
            startThreat = mobsThreatData[mobGUID].startThreat
        end
    else
        startTime   = currentTime
        startThreat = 0
    end

    mobsThreatData[mobGUID] = {
        startTime           = startTime,
        startThreat         = startThreat,
        lastTime            = currentTime,
        threatValue         = playerThreatValue / 100,
        threatLeadValue     = threatLeadValue,
        rawThreatPct        = rawThreatPct,
        threatLeaderUnit    = threatLeaderUnit,
        threatLeaderName    = threatLeaderName,
        threatLeaderClass   = threatLeaderClass,
        threatLeaderRole    = threatLeaderRole,
        nameplate           = nameplate,
        isTankedByOtherTank = isTankedByOtherTank,
    }
end

function addon.GetThreatData(mobGUID)
    return mobsThreatData[mobGUID]
end

function addon.DeleteThreatData(mobGUID)
    SavePlayerRecentTPS(mobGUID)
    mobsThreatData[mobGUID] = nil
end

function addon.GetLowestThreatLeadNamePlate()
    local lowestThreatLeadMobGUID
    local lowestThreatLeadValue
    local nameplate
    local prioritizeElitesOnly = BlizzThreatPlatesConfig["prioritizeElitesOnly"]

    for mobGUID, threatData in pairs(mobsThreatData) do
        if (threatData.threatLeadValue and not threatData.isTankedByOtherTank) then
            if not lowestThreatLeadValue or threatData.threatLeadValue < lowestThreatLeadValue then
                local canBePrioritized = true
                local unitFrame = threatData.nameplate
                local unit = unitFrame.displayedUnit or unitFrame.unit
                if (prioritizeElitesOnly and not addon.UnitIsEliteOrBoss(unit)) or
                        not addon.UnitHasMinimumHealth(unit) or addon.UnitIsIncapacitated(unit) then
                    canBePrioritized = false
                end
                if canBePrioritized then
                    lowestThreatLeadValue = threatData.threatLeadValue
                    lowestThreatLeadMobGUID = mobGUID
                end
            end
        end
    end

    if lowestThreatLeadMobGUID then
        nameplate = mobsThreatData[lowestThreatLeadMobGUID].nameplate
    end

    return nameplate
end

-- Return the nameplate of the enemy which is the priority for healers and DPS
function addon.GetHealerAndDpsPriorityNameplate()
    local nameplate
    local lowestHealthPercent
    local threatSafetyBuffer = BlizzThreatPlatesCharacterConfig["threatSafetyBuffer"]
    local medianTPS = BlizzThreatPlatesCharacterConfig["medianTPS"] and BlizzThreatPlatesCharacterConfig["medianTPS"] or 0
    local minimumSafeThreat = (medianTPS * threatSafetyBuffer)

    for mobGUID, threatData in pairs(mobsThreatData) do
        local unitFrame = threatData.nameplate
        local unit = unitFrame.displayedUnit or unitFrame.unit
        if UnitHealthMax(unit) > 0 then
            local healthPercent = UnitHealth(unit) / UnitHealthMax(unit)
            local hasHealth = healthPercent and healthPercent > 0 or false
            if hasHealth then
               local isLowestHealth = (lowestHealthPercent == nil or healthPercent < lowestHealthPercent)
               local isSafe = (threatData.threatLeadValue < -minimumSafeThreat)
               if isLowestHealth and isSafe and not addon.UnitIsIncapacitated(unit) then
                   lowestHealthPercent = healthPercent
                   nameplate = threatData.nameplate
               end
            end
        end
    end

    local dmgNameplate, dmgLowestHealthPercent = addon.GetHealerAndDpsPriorityNameplateByDamage(minimumSafeThreat)

    if lowestHealthPercent and dmgLowestHealthPercent then
        return (lowestHealthPercent < dmgLowestHealthPercent) and nameplate or dmgNameplate
    end

    return nameplate or dmgNameplate
end