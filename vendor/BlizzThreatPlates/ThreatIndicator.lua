
local _, addon = ...

--------------------------------------------------------------------------------
-- Threat indicator
--------------------------------------------------------------------------------

-- Class Icons
local CLASS_ICON_TEXTURES = {
    WARRIOR     = "groupfinder-icon-class-warrior",
    MAGE        = "groupfinder-icon-class-mage",
    ROGUE       = "groupfinder-icon-class-rogue",
    DRUID       = "groupfinder-icon-class-druid",
    HUNTER      = "groupfinder-icon-class-hunter",
    SHAMAN      = "groupfinder-icon-class-shaman",
    PRIEST      = "groupfinder-icon-class-priest",
    WARLOCK     = "groupfinder-icon-class-warlock",
    PALADIN     = "groupfinder-icon-class-paladin",
    DEATHKNIGHT = "groupfinder-icon-class-deathknight",
}

-- Role Icons
local ROLE_ICON_TEXTURES = {
    TANK    = "groupfinder-icon-role-large-tank",
    HEALER  = "groupfinder-icon-role-large-heal",
    DAMAGER = "groupfinder-icon-role-large-dps",
}

local function GetThreatLeadText(threatLead, isPlayerTank, suffix)
    local text, color, sign

    threatLead = (threatLead >= 0) and math.floor(threatLead) or math.ceil(threatLead)

    if threatLead > 0 then
        sign = "+"
    elseif threatLead < 0 then
        sign = "-"
    else
        sign = ""
    end

    if (isPlayerTank and threatLead > 0) or (not isPlayerTank and threatLead < 0) then
        color = addon.COLOR_GREEN
    elseif (isPlayerTank and threatLead < 0) or (not isPlayerTank and threatLead > 0) then
        color = addon.COLOR_RED
    else
        color = addon.COLOR_YELLOW
    end

    text = sign .. AbbreviateNumbers(math.abs(threatLead))

    if suffix then
        text = text .. suffix
    end

    return text, color
end

local function GetThreatPercentText(threatPct, isPlayerTank)
    local text, color

    text = tostring(math.floor(threatPct)) .. "%"
    if (isPlayerTank and threatPct >= 100) or (not isPlayerTank and threatPct < 100) then
        color = addon.COLOR_GREEN
    elseif (isPlayerTank and threatPct < 100) or (not isPlayerTank and threatPct >= 100) then
        color = addon.COLOR_RED
    else
        color = addon.COLOR_YELLOW
    end

    return text, color
end

local function CreateThreatIndicator(unitFrame)
    if unitFrame.threatIndicator then
        return
    end

    -- Background
    unitFrame.threatIndicator = CreateFrame("Frame", nil, unitFrame, "BackdropTemplate")
    unitFrame.threatIndicator:SetSize(50, 18)
    unitFrame.threatIndicator:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    unitFrame.threatIndicator:SetBackdropColor(0, 0, 0, 0.85)
    unitFrame.threatIndicator:SetBackdropBorderColor(addon.COLOR_GOLD.r, addon.COLOR_GOLD.g, addon.COLOR_GOLD.b, 1)
    unitFrame.threatIndicator:Hide()

    -- Text
    unitFrame.threatIndicator.text = unitFrame.threatIndicator:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    unitFrame.threatIndicator.text:SetPoint("CENTER", unitFrame.threatIndicator, "CENTER", 0, 0)
    unitFrame.threatIndicator.text:SetJustifyH("LEFT")

    -- Threat leader class icon
    unitFrame.threatIndicator.classIcon = unitFrame.threatIndicator:CreateTexture(nil, "ARTWORK")

    -- Pet portrait border
    unitFrame.threatIndicator.classIconBorder = unitFrame.threatIndicator:CreateTexture(nil, "OVERLAY")
    unitFrame.threatIndicator.classIconBorder:SetSize(15, 15)
    unitFrame.threatIndicator.classIconBorder:SetPoint("CENTER", unitFrame.threatIndicator.classIcon, "CENTER", 0, 0)
    unitFrame.threatIndicator.classIconBorder:SetAtlas("Capacitance-General-PortraitRing")

    -- Threat leader's name
    unitFrame.threatIndicator.threatLeader = unitFrame.threatIndicator:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    local file, size, _ = unitFrame.threatIndicator.threatLeader:GetFont()
    unitFrame.threatIndicator.threatLeader:SetFont(file, size, "OUTLINE")

    -- Threat leader's role icon
    unitFrame.threatIndicator.roleIcon = unitFrame.threatIndicator:CreateTexture(nil, "OVERLAY")
    unitFrame.threatIndicator.roleIcon:SetSize(15, 15)

    -- Target Counter Background
    unitFrame.threatIndicator.targetCounterBg = unitFrame.threatIndicator:CreateTexture(nil, "ARTWORK")
    unitFrame.threatIndicator.targetCounterBg:SetSize(18, 18)
    unitFrame.threatIndicator.targetCounterBg:SetAtlas("PetJournal-LevelBubble")

    -- Target Counter Text
    unitFrame.threatIndicator.targetCounterText = unitFrame.threatIndicator:CreateFontString(nil, "OVERLAY", "GameNormalNumberFont")
    unitFrame.threatIndicator.targetCounterText:SetJustifyH("CENTER")
    unitFrame.threatIndicator.targetCounterText:SetJustifyV("MIDDLE")
    unitFrame.threatIndicator.targetCounterText:SetScale(0.9)
end

local function SetThreatIndicatorPosition(unitFrame, position, scale)
    unitFrame.threatIndicator:ClearAllPoints()
    if position == addon.THREAT_INDICATOR_POSITION_TOPLEFT then
        unitFrame.threatIndicator:SetPoint("BOTTOMLEFT", unitFrame, "TOPLEFT", 0 / scale, 2 / scale)
    elseif position == addon.THREAT_INDICATOR_POSITION_TOP then
        unitFrame.threatIndicator:SetPoint("BOTTOM", unitFrame, "TOP", 0 / scale, 2 / scale)
    elseif position == addon.THREAT_INDICATOR_POSITION_TOPRIGHT then
        unitFrame.threatIndicator:SetPoint("BOTTOMRIGHT", unitFrame, "TOPRIGHT", 0 / scale, 2 / scale)
    elseif position == addon.THREAT_INDICATOR_POSITION_LEFT then
        unitFrame.threatIndicator:SetPoint("TOPRIGHT", unitFrame.healthBar, "TOPLEFT", -1 / scale, 3 / scale)
    elseif position == addon.THREAT_INDICATOR_POSITION_RIGHT then
        unitFrame.threatIndicator:SetPoint("TOPLEFT", unitFrame.healthBar, "TOPRIGHT", 18 / scale, 3 / scale)
    end

    unitFrame.threatIndicator.targetCounterBg:ClearAllPoints()
    if position == addon.THREAT_INDICATOR_POSITION_TOPLEFT or position == addon.THREAT_INDICATOR_POSITION_TOP or
       position == addon.THREAT_INDICATOR_POSITION_LEFT then
        unitFrame.threatIndicator.targetCounterBg:SetPoint("CENTER", unitFrame.threatIndicator, "LEFT", -4, 0)
    else
        unitFrame.threatIndicator.targetCounterBg:SetPoint("CENTER", unitFrame.threatIndicator, "RIGHT", 4, 0)
    end
end

local function SetThreatLeaderPosition(unitFrame, position, scale)
    unitFrame.threatIndicator.classIcon:ClearAllPoints()
    unitFrame.threatIndicator.threatLeader:ClearAllPoints()
    unitFrame.threatIndicator.roleIcon:ClearAllPoints()
    if position == addon.THREAT_INDICATOR_POSITION_TOPLEFT or position == addon.THREAT_INDICATOR_POSITION_TOP then
        unitFrame.threatIndicator.classIcon:SetPoint("LEFT", unitFrame.threatIndicator, "RIGHT", 1, 0)
        unitFrame.threatIndicator.threatLeader:SetPoint("LEFT", unitFrame.threatIndicator.classIcon, "RIGHT", 0, 0)
        unitFrame.threatIndicator.threatLeader:SetJustifyH("LEFT")
        unitFrame.threatIndicator.roleIcon:SetPoint("LEFT", unitFrame.threatIndicator.threatLeader, "RIGHT", -2 / scale, 0)
    elseif position == addon.THREAT_INDICATOR_POSITION_TOPRIGHT then
        unitFrame.threatIndicator.classIcon:SetPoint("RIGHT", unitFrame.threatIndicator, "LEFT", -1, 0)
        unitFrame.threatIndicator.threatLeader:SetPoint("RIGHT", unitFrame.threatIndicator.classIcon, "LEFT", 0, 0)
        unitFrame.threatIndicator.threatLeader:SetJustifyH("RIGHT")
        unitFrame.threatIndicator.roleIcon:SetPoint("RIGHT", unitFrame.threatIndicator.threatLeader, "LEFT", scale / 2, 0)
    elseif position == addon.THREAT_INDICATOR_POSITION_LEFT then
        unitFrame.threatIndicator.classIcon:SetPoint("TOPRIGHT", unitFrame.threatIndicator, "BOTTOMRIGHT", 0, 1)
        unitFrame.threatIndicator.threatLeader:SetPoint("RIGHT", unitFrame.threatIndicator.classIcon, "LEFT", 0, 0)
        unitFrame.threatIndicator.threatLeader:SetJustifyH("RIGHT")
        unitFrame.threatIndicator.roleIcon:SetPoint("RIGHT", unitFrame.threatIndicator.threatLeader, "LEFT", scale / 2, 0)
    elseif position == addon.THREAT_INDICATOR_POSITION_RIGHT then
        unitFrame.threatIndicator.classIcon:SetPoint("TOPLEFT", unitFrame.threatIndicator, "BOTTOMLEFT", 0, 1)
        unitFrame.threatIndicator.threatLeader:SetPoint("LEFT", unitFrame.threatIndicator.classIcon, "RIGHT", 0, 0)
        unitFrame.threatIndicator.threatLeader:SetJustifyH("LEFT")
        unitFrame.threatIndicator.roleIcon:SetPoint("LEFT", unitFrame.threatIndicator.threatLeader, "RIGHT", -2 / scale, 0)
    end
end

function addon.UpdateThreatIndicator(unitFrame, unit, threatPct)
    if not unitFrame.threatIndicator then
        CreateThreatIndicator(unitFrame)
    end

    local enableThreatIndicator = BlizzThreatPlatesConfig["enableThreatIndicator"]
    local position              = BlizzThreatPlatesConfig["threatIndicatorPosition"]
    local scale                 = BlizzThreatPlatesConfig["threatIndicatorScale"] / 100
    local threatIndicatorMode   = BlizzThreatPlatesConfig["threatIndicatorMode"]
    local useTankColors         = BlizzThreatPlatesConfig["useRoleBasedColors"] and addon.IsPlayerRole("TANK")
    local guid                  = UnitGUID(unit)
    local mobInCombatWithGroup  = (addon.GetMobStatus(guid) == addon.MOB_STATUS_IN_COMBAT_WITH_GROUP)
    local threatData            = addon.GetThreatData(guid)
    local threatLeadValue       = threatData and threatData.threatLeadValue or 0
    local rawThreatPct          = threatData and threatData.rawThreatPct or 0
    local threatLeaderClass     = threatData and threatData.threatLeaderClass or nil
    local threatLeaderUnit      = threatData and threatData.threatLeaderUnit or ""
    local threatLeaderName      = threatData and threatData.threatLeaderName or ""
    local threatLeaderRole      = threatData and threatData.threatLeaderRole or false
    local threatText            = ""
    local threatColor           = addon.COLOR_YELLOW

    unitFrame.threatIndicator:SetScale(scale)
    SetThreatIndicatorPosition(unitFrame, position, scale)

    if mobInCombatWithGroup then
        local topDamageDealerGUID, topDamage = addon.GetMobTopDamageDealer(guid)
        if topDamageDealerGUID and topDamage then
            threatLeaderUnit = addon.GetGroupUnit(topDamageDealerGUID)
            if threatLeaderUnit then
                threatLeaderClass = select(2, UnitClass(threatLeaderUnit))
                threatLeaderName  = UnitName(threatLeaderUnit)
                threatLeaderRole  = addon.GetGroupRole(topDamageDealerGUID)
            end
            threatText = AbbreviateNumbers(topDamage)
            threatColor = addon.COLOR_WHITE
        end
    else
        if threatIndicatorMode == addon.THREAT_LEAD_VALUE then
            threatText, threatColor = GetThreatLeadText(threatLeadValue, useTankColors)
        elseif threatIndicatorMode == addon.THREAT_PERCENT_RAW then
            threatText, threatColor = GetThreatPercentText(rawThreatPct, useTankColors)
        elseif threatIndicatorMode == addon.THREAT_PERCENT then
            threatText, threatColor = GetThreatPercentText(threatPct, useTankColors)
        end
    end

    unitFrame.threatIndicator.text:SetText(threatText)
    unitFrame.threatIndicator.text:SetTextColor(threatColor.r, threatColor.g, threatColor.b)

    if threatLeaderClass then
        local color = RAID_CLASS_COLORS[threatLeaderClass]
        local isPet = (threatLeaderUnit == "pet") or UnitIsOtherPlayersPet(threatLeaderUnit)

        if isPet then
            SetPortraitTexture(unitFrame.threatIndicator.classIcon, threatLeaderUnit)
            unitFrame.threatIndicator.classIcon:SetSize(13, 13)
            unitFrame.threatIndicator.classIconBorder:Show()
        else
            unitFrame.threatIndicator.classIcon:SetAtlas(CLASS_ICON_TEXTURES[threatLeaderClass])
            unitFrame.threatIndicator.classIcon:SetSize(15, 15)
            unitFrame.threatIndicator.classIconBorder:Hide()
        end

        SetThreatLeaderPosition(unitFrame, position, scale)

        unitFrame.threatIndicator.classIcon:Show()
        unitFrame.threatIndicator.threatLeader:SetText(threatLeaderName)
        unitFrame.threatIndicator.threatLeader:SetTextColor(color.r, color.g, color.b)
        unitFrame.threatIndicator.threatLeader:Show()

        if threatLeaderRole and not isPet then
            unitFrame.threatIndicator.roleIcon:SetAtlas(ROLE_ICON_TEXTURES[threatLeaderRole])
            unitFrame.threatIndicator.roleIcon:Show()
        else
            unitFrame.threatIndicator.roleIcon:Hide()
        end
    else
        unitFrame.threatIndicator.classIcon:Hide()
        unitFrame.threatIndicator.classIconBorder:Hide()
        unitFrame.threatIndicator.threatLeader:SetText("")
        unitFrame.threatIndicator.threatLeader:Hide()
        unitFrame.threatIndicator.roleIcon:Hide()
    end

    if IsInRaid() or IsInGroup() then
        local targetCounter = addon.GetMobTargetCounter(guid)
        unitFrame.threatIndicator.targetCounterText:SetPoint("CENTER", unitFrame.threatIndicator.targetCounterBg, "CENTER", 0.9 / scale, -1)
        unitFrame.threatIndicator.targetCounterText:SetText(targetCounter)
        unitFrame.threatIndicator.targetCounterBg:Show()
        unitFrame.threatIndicator.targetCounterText:Show()
    else
        unitFrame.threatIndicator.targetCounterBg:Hide()
        unitFrame.threatIndicator.targetCounterText:Hide()
    end

    if enableThreatIndicator then
        unitFrame.threatIndicator:Show()
    else
        unitFrame.threatIndicator:Hide()
    end
end

function addon.UpdateTargetCounter(guid)
    local unitFrame = addon.GetUnitFrameByGUID(guid)
    if unitFrame then
        local targetCounter = addon.GetMobTargetCounter(guid)
        if unitFrame.threatIndicator and unitFrame.threatIndicator.targetCounterText then
            unitFrame.threatIndicator.targetCounterText:SetText(targetCounter)
        end
    end
end