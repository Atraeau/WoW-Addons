
local _, addon = ...

--------------------------------------------------------------------------------
-- Priority Marker
--------------------------------------------------------------------------------

-- Marker to identify which target should be prioritized
local priorityMarker

function addon.InitPriorityMarker()
    priorityMarker = addon.CreatePriorityMarker()
end

function addon.CreatePriorityMarker()
    local color = BlizzThreatPlatesCharacterConfig["priorityMarkerColor"]
    local priorityMarker = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    priorityMarker:SetBackdrop({
        bgFile = "Interface\\TargetingFrame\\UI-StatusBar",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    priorityMarker:SetBackdropColor(color.r, color.g, color.b, color.a)
    priorityMarker:SetBackdropBorderColor(addon.COLOR_GREY.r, addon.COLOR_GREY.g, addon.COLOR_GREY.b, 1)

    return priorityMarker
end

local function SetPriorityMarker(unitFrame)
    if unitFrame then
        priorityMarker:SetParent(unitFrame)
        priorityMarker:ClearAllPoints()
        priorityMarker:SetPoint("TOPLEFT", unitFrame.name, "TOPLEFT", -10, 5)
        priorityMarker:SetPoint("BOTTOMRIGHT", unitFrame.name, "BOTTOMRIGHT", 10, -5)
        priorityMarker:SetFrameLevel(unitFrame:GetFrameLevel() - 1)

        if not priorityMarker:IsShown() then
            priorityMarker:Show()
        end
    else
        if priorityMarker:IsShown() then
            priorityMarker:Hide()
        end
    end
end

function addon.UpdatePriorityMarker()
    local enablePriorityMarker = BlizzThreatPlatesCharacterConfig["enablePriorityMarker"]
    local tankMode = BlizzThreatPlatesCharacterConfig["tankType"]

    if enablePriorityMarker then
        if addon.IsPlayerRole("TANK") then
            if tankMode == addon.TANK_TYPE_MAIN then
                -- First priority - mob pulled by other group members with the highest damage received
                --                  that the tank has not hit yet and has a nameplate.
                local unitFrame = addon.GetDamagePriorityMobUnitFrame()
                if unitFrame then
                    SetPriorityMarker(unitFrame)
                    return
                end

                -- Second priority - the mob on which the tank has the lowest threat lead (among visible nameplates) that is
                -- not tanked by another tank.
                local nameplate = addon.GetLowestThreatLeadNamePlate()
                if nameplate then
                    SetPriorityMarker(nameplate)
                    return
                end
            end
        else
            -- Healers and DPS
            local nameplate = addon.GetHealerAndDpsPriorityNameplate()
            if nameplate then
                SetPriorityMarker(nameplate)
                return
            end
        end
    end

    if priorityMarker:IsShown() then
        priorityMarker:Hide()
    end
end

function addon.SetPriorityMarkerColor(color)
    priorityMarker:SetBackdropColor(color.r, color.g, color.b, color.a)
end

function addon.UnitIsEliteOrBoss(unit)
    local classification = UnitClassification(unit)
    return classification == "elite" or classification == "rareelite" or
           classification == "worldboss" or classification == "boss"
end

function addon.UnitHasMinimumHealth(unit)
    local health = UnitHealth(unit)
    local healthMax = UnitHealthMax(unit)
    local percent = (health / healthMax) * 100

    return percent > BlizzThreatPlatesConfig["minHealthPercent"]
end