
local _, addon = ...

-- The config panel frames
local configFrame
local contentFrame
local showOnlyInGroupRaidFrame
local petExceptionFrame
local enableHealthBarColoringFrame
local useRoleBasedColorsFrame
local playerRoleDetectionFrame
local groupRoleDetectionFrame
local tankTypeFrame
local enableThreatIndicatorFrame
local threatIndicatorModeFrame
local threatIndicatorPositionFrame
local threatIndicatorScaleFrame
local enablePriorityMarkerFrame
local priorityMarkerColorFrame
local priorityMarkerPreviewFrame
local elitesOnlyFrame
local minimumHealthFrame
local threatSafetyBufferFrame

-- Constants
local SECTIONX       = 10
local LABELX         = 50
local SUBLABELX      = 75
local CONFIGX        = 250
local LINEHEIGHT     = 35
local COLOR_DISABLED = { r = 0.5, g = 0.5, b = 0.5, a = 1 }

local yOffset        = -LINEHEIGHT / 2

-- Role Detection Modes
addon.ROLE_DETECTION_LFG_ROLE  = 0
addon.ROLE_DETECTION_AUTOMATIC = 1

-- Tank Types
addon.TANK_TYPE_MAIN    = 0
addon.TANK_TYPE_OFFTANK = 1

-- Threat Display Modes
addon.THREAT_LEAD_VALUE       = 0
addon.THREAT_PERCENT_RAW      = 1
addon.THREAT_PERCENT          = 2

-- Threat Indicator Positions
addon.THREAT_INDICATOR_POSITION_TOPLEFT     = 0
addon.THREAT_INDICATOR_POSITION_TOP         = 1
addon.THREAT_INDICATOR_POSITION_TOPRIGHT    = 2
addon.THREAT_INDICATOR_POSITION_LEFT        = 3
addon.THREAT_INDICATOR_POSITION_RIGHT       = 4

-- Default values
local DEFAULTS = {
    showOnlyInGroupRaid     = true,
    petException            = true,
    enableHealthBarColoring = true,
    groupRoleDetection      = addon.ROLE_DETECTION_LFG_ROLE,
    useRoleBasedColors      = true,
    enableThreatIndicator   = true,
    threatIndicatorMode     = addon.THREAT_LEAD_VALUE,
    threatIndicatorPosition = addon.THREAT_INDICATOR_POSITION_RIGHT,
    threatIndicatorScale    = 100,
    prioritizeElitesOnly    = true,
    minHealthPercent        = 20,
}

-- Default values (character)
local DEFAULTS_CHARACTER = {
    playerRoleDetection     = addon.ROLE_DETECTION_LFG_ROLE,
    tankType                = addon.TANK_TYPE_MAIN,
    enablePriorityMarker    = true,
    priorityMarkerColor     = { r = 0, g = 0, b = 0.5, a = 1 },
    threatSafetyBuffer      = 3,
}

local UpdateShowOnlyInGroupRaidDependencies
local UpdateHealthBarDependencies
local UpdateThreatIndicatorDependencies
local UpdatePriorityMarkerDependencies

-- Initialize an option with a default value if it's not already defined
local function InitConfig(configName, defaultValue)
    if BlizzThreatPlatesConfig[configName] == nil then
        BlizzThreatPlatesConfig[configName] = defaultValue
    end
end

-- Initialize a character option with a default value if it's not already defined
local function InitCharacterConfig(configName, defaultValue)
    if BlizzThreatPlatesCharacterConfig[configName] == nil then
        BlizzThreatPlatesCharacterConfig[configName] = defaultValue
    end
end

-- Initialize configs
local function InitConfigs()
    BlizzThreatPlatesConfig = BlizzThreatPlatesConfig or {}
    BlizzThreatPlatesCharacterConfig = BlizzThreatPlatesCharacterConfig or {}
    for key, value in pairs(DEFAULTS) do
        InitConfig(key, value)
    end
    for key, value in pairs(DEFAULTS_CHARACTER) do
        InitCharacterConfig(key, value)
    end
end

-- Reset all BlizzThreatPlates configs to default values
local function ResetToDefaults()
    for key, value in pairs(DEFAULTS) do
        BlizzThreatPlatesConfig[key] = value
    end
    for key, value in pairs(DEFAULTS_CHARACTER) do
        BlizzThreatPlatesCharacterConfig[key] = value
    end

    showOnlyInGroupRaidFrame:SetChecked(BlizzThreatPlatesConfig["showOnlyInGroupRaid"])
    petExceptionFrame:SetChecked(BlizzThreatPlatesConfig["petException"])
    enableHealthBarColoringFrame:SetChecked(BlizzThreatPlatesConfig["enableHealthBarColoring"])
    playerRoleDetectionFrame.Dropdown:SignalUpdate()
    groupRoleDetectionFrame.Dropdown:SignalUpdate()
    tankTypeFrame.Dropdown:SignalUpdate()
    useRoleBasedColorsFrame:SetChecked(BlizzThreatPlatesConfig["useRoleBasedColors"])
    enableThreatIndicatorFrame:SetChecked(BlizzThreatPlatesConfig["enableThreatIndicator"])
    threatIndicatorModeFrame.Dropdown:SignalUpdate()
    threatIndicatorPositionFrame.Dropdown:SignalUpdate()
    threatIndicatorScaleFrame:SetValue(BlizzThreatPlatesConfig["threatIndicatorScale"])
    enablePriorityMarkerFrame:SetChecked(BlizzThreatPlatesCharacterConfig["enablePriorityMarker"])
    local color = BlizzThreatPlatesCharacterConfig["priorityMarkerColor"]
    priorityMarkerColorFrame:SetBackdropColor(color.r, color.g, color.b, color.a)
    addon.SetPriorityMarkerColor(color)
    elitesOnlyFrame:SetChecked(BlizzThreatPlatesConfig["prioritizeElitesOnly"])
    minimumHealthFrame:SetValue(BlizzThreatPlatesConfig["minHealthPercent"])
    threatSafetyBufferFrame:SetValue(BlizzThreatPlatesCharacterConfig["threatSafetyBuffer"])

    UpdateShowOnlyInGroupRaidDependencies()
    UpdateHealthBarDependencies()
    UpdateThreatIndicatorDependencies()
    UpdatePriorityMarkerDependencies()
end

-- Create a tooltip for a frame
local function CreateTooltip(frame, tooltip)
    if tooltip then
        frame:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(tooltip[1], 1, 1, 1, false, "GameFontNormalLarge")
            for i = 2, #tooltip do
                GameTooltip:AddLine(tooltip[i], nil, nil, nil, true)
            end
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
end

-- Create the config page header section
local function CreateHeader(title)
    local header = CreateFrame("Frame", nil, configFrame)
    header:SetSize(configFrame:GetWidth(), 50)
    header:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", configFrame, "TOPRIGHT", 0, 0)

    local titleFontString = header:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
    titleFontString:SetPoint("TOPLEFT", header, "TOPLEFT", 7, -22)
    titleFontString:SetText(title)

    local divider = header:CreateTexture(nil, "ARTWORK")
    divider:SetAtlas("Options_HorizontalDivider", true)
    divider:SetPoint("TOP", header, "TOP", 0, -50)

    local defaultsButton = CreateFrame("Button", nil, header, "UIPanelButtonTemplate")
    defaultsButton:SetSize(96, 22)
    defaultsButton:SetPoint("TOPRIGHT", header, "TOPRIGHT", -36, -16)
    defaultsButton:SetText("Defaults")
    defaultsButton:SetScript("OnClick", ResetToDefaults)

    return header
end

-- Create a section header
local function CreateSectionHeader(title, tooltip)
    local header = CreateFrame("Frame", nil, contentFrame, "SettingsListSectionHeaderTemplate")
    header:SetPoint("LEFT", contentFrame, "TOPLEFT", SECTIONX, yOffset)
    header:SetPoint("RIGHT", contentFrame, "TOPRIGHT", 0, yOffset)
    header.Title:SetText(title)

    CreateTooltip(header.Title, tooltip)

    return header
end

-- Create a dropdown with stepper and label
local function CreateDropdownWithStepperAndLabel(label, isSubConfig, dropdownWidth, setupMenuFct, tooltip)
    local dropdown = CreateFrame("Frame", nil, contentFrame, "Metal2DropdownWithSteppersAndLabelTemplate")
    dropdown:SetPoint("LEFT", contentFrame, "TOPLEFT", CONFIGX + 34, yOffset)
    dropdown:SetText(label)

    dropdown.Label:SetFontObject(isSubConfig and "GameFontNormalSmall" or "GameFontNormal")
    dropdown.Label:ClearAllPoints()
    dropdown.Label:SetPoint("LEFT", contentFrame, "TOPLEFT", isSubConfig and SUBLABELX or LABELX, yOffset)

    dropdown.Dropdown:SetWidth(dropdownWidth)
    dropdown.Dropdown:SetupMenu(setupMenuFct)
    dropdown.Dropdown:GenerateMenu()
    dropdown.Dropdown:SignalUpdate()

    CreateTooltip(dropdown.Label, tooltip)
    CreateTooltip(dropdown.Dropdown, tooltip)

    return dropdown
end

local function CreateDropdownOption(rootDescription, text, isSelected, setSelected, data)
    local function Initializer(button, description, menu)
        button:SetScript("OnClick", function(btn, buttonName)
            description:Pick(MenuInputContext.MouseButton, buttonName)
        end)

        button.Text:Show()
        button.Text:SetTextToFit(text)
        button.HighlightBGTex:SetAlpha(0)

        if description:IsSelected() then
            button.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGBA())
        else
            button.Text:SetTextColor(VERY_LIGHT_GRAY_COLOR:GetRGB())
        end

        button:Layout()
    end

    local function OnEnter(button)
        button.HighlightBGTex:SetAlpha(0.15)
        local description = button:GetElementDescription()
        if description:IsEnabled() and not description:IsSelected() then
            button.Text:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
        end
    end

    local function OnLeave(button)
        button.HighlightBGTex:SetAlpha(0)
        local description = button:GetElementDescription()
        if description:IsEnabled() and not description:IsSelected() then
            button.Text:SetTextColor(VERY_LIGHT_GRAY_COLOR:GetRGB())
        end
    end

    local optionDescription = rootDescription:CreateTemplate("SettingsDropdownButtonTemplate")
    optionDescription:AddInitializer(Initializer)
    optionDescription:SetIsSelected(isSelected)
    optionDescription:SetResponder(setSelected)
    optionDescription:SetData(data)
    optionDescription:SetOnEnter(OnEnter)
    optionDescription:SetOnLeave(OnLeave)
    MenuUtil.SetElementText(optionDescription, text)

    return optionDescription
end

-- Create a checkbox
local function CreateCheckbox(label, isSubConfig, checked, onChanged, tooltip)
    local checkbox = CreateFrame("CheckButton", nil, contentFrame, "SettingsCheckboxTemplate")
    checkbox:SetPoint("LEFT", contentFrame, "TOPLEFT", CONFIGX, yOffset)
    checkbox:SetChecked(checked)

    checkbox.text = checkbox:CreateFontString(nil, "OVERLAY", isSubConfig and "GameFontNormalSmall" or "GameFontNormal")
    checkbox.text:SetPoint("LEFT", contentFrame, "TOPLEFT", isSubConfig and SUBLABELX or LABELX, yOffset)
    checkbox.text:SetText(label)

    CreateTooltip(checkbox.text, tooltip)
    CreateTooltip(checkbox, tooltip)

    checkbox:SetScript("OnClick", function(self)
        onChanged(self:GetChecked())
    end)

    return checkbox
end

local function SliderFormatterPercent(value)
    return string.format("%d%%", value)
end

local function SliderFormatterSeconds(value)
    if value == 0 then
        return "None"
    elseif value == 1 then
        return "1 second"
    else
        return string.format("%d seconds", value)
    end
end

-- Create a slider with steppers
local function CreateMinimalSliderWithSteppers(label, isSubConfig, minValue, maxValue, steps, value, formatter, onChanged, tooltip)
    local slider = CreateFrame("Frame", nil, contentFrame, "MinimalSliderWithSteppersTemplate")
    slider:SetPoint("LEFT", contentFrame, "TOPLEFT", CONFIGX, yOffset)
    slider:SetValue(value)

    slider.text = slider:CreateFontString(nil, "OVERLAY", isSubConfig and "GameFontNormalSmall" or "GameFontNormal")
    local offsetX = isSubConfig and SUBLABELX or LABELX
    slider.text:SetPoint("LEFT", contentFrame, "TOPLEFT", offsetX, yOffset)
    slider.text:SetText(label)
    slider.text:SetJustifyH("LEFT")
    slider.text:SetHeight(14)
    slider.text:SetWidth(CONFIGX - offsetX)
    slider.text:SetWordWrap(false)
    slider.text:SetMaxLines(1)
    slider.text:SetNonSpaceWrap(false)

    local formatters = {
        [MinimalSliderWithSteppersMixin.Label.Right] = formatter,
    }

    slider:Init(value, minValue, maxValue, steps, formatters)

    CreateTooltip(slider.text, tooltip)
    CreateTooltip(slider.Slider, tooltip)

    slider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, onChanged)

    return slider
end

-- Create a color picker
local function CreateColorPicker(label, isSubConfig, configKey, isCharacterConfig, onChanged, onCancel, tooltip)
    local colorDisplay = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
    colorDisplay:SetSize(30, 30)
    colorDisplay:SetPoint("LEFT", contentFrame, "TOPLEFT", CONFIGX, yOffset)
    colorDisplay:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })

    local color = isCharacterConfig and
        BlizzThreatPlatesCharacterConfig[configKey] or BlizzThreatPlatesConfig[configKey]
    colorDisplay:SetBackdropColor(color.r, color.g, color.b, color.a)
    colorDisplay:SetBackdropBorderColor(.5, .5, .5, 1)

    colorDisplay.text = colorDisplay:CreateFontString(nil, "OVERLAY", isSubConfig and "GameFontNormalSmall" or "GameFontNormal")
    colorDisplay.text:SetPoint("LEFT", contentFrame, "TOPLEFT", isSubConfig and SUBLABELX or LABELX, yOffset)
    colorDisplay.text:SetText(label)

    CreateTooltip(colorDisplay.text, tooltip)
    CreateTooltip(colorDisplay, tooltip)

    colorDisplay:EnableMouse(true)
    colorDisplay:SetScript("OnMouseDown", function(self)
        local currentColor = isCharacterConfig and
            BlizzThreatPlatesCharacterConfig[configKey] or BlizzThreatPlatesConfig[configKey]
        ColorPickerFrame:SetupColorPickerAndShow({
            r = currentColor.r, g = currentColor.g, b = currentColor.b,
            opacity = currentColor.a,
            hasOpacity = true,
            swatchFunc = onChanged,
            opacityFunc = onChanged,
            cancelFunc = onCancel,
        })
    end)

    return colorDisplay
end

-- Enable / disable the Priority Marker's configs
function UpdateShowOnlyInGroupRaidDependencies()
    local enabled = BlizzThreatPlatesConfig["showOnlyInGroupRaid"]
    local font = enabled and "GameFontNormalSmall" or "GameFontDisableSmall"

    petExceptionFrame:SetEnabled(enabled)
    petExceptionFrame.text:SetFontObject(font)
end

-- Create the Show Only in Group or Raid config
local function CreateShowOnlyInGroupRaidConfig()
    local label = "Show Only in Group or Raid"
    local checked = BlizzThreatPlatesConfig["showOnlyInGroupRaid"]
    local tooltip = {
        label,
        " ",
        "Show threat information (threat indicator, threat leader, priority marker and target counter) only when grouped.",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["showOnlyInGroupRaid"] = value
        UpdateShowOnlyInGroupRaidDependencies()
    end

    showOnlyInGroupRaidFrame = CreateCheckbox(label, false, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Pet Exception config
local function CreatePetExceptionConfig()
    local label = "Pet Exception"
    local checked = BlizzThreatPlatesConfig["petException"]
    local tooltip = {
        label,
        " ",
        "Threat information will be shown when using a pet, regardless of the group-only restriction",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["petException"] = value
    end

    petExceptionFrame = CreateCheckbox(label, true, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Health Bar section header
local function CreateHealthBarSectionHeader()
    local label = "Health Bar"
    local tooltip = { label }

    CreateSectionHeader(label, tooltip)
	
    yOffset = yOffset - LINEHEIGHT
end

-- Enable / disable the Health Bar's configs
function UpdateHealthBarDependencies()
    local enabled = BlizzThreatPlatesConfig["enableHealthBarColoring"]
    local font = enabled and "GameFontNormalSmall" or "GameFontDisableSmall"

    useRoleBasedColorsFrame:SetEnabled(enabled)
    useRoleBasedColorsFrame.text:SetFontObject(font)
end

-- Create the Enable Health Bar Coloring config
local function CreateEnableHealthBarColoringConfig()
    local label = "Enable Health Bar Coloring"
    local checked = BlizzThreatPlatesConfig["enableHealthBarColoring"]
    local tooltip = {
        label,
        " ",
        "Checking this will change the color of the enemies' health bars to reflect your aggro status.",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["enableHealthBarColoring"] = value
        UpdateHealthBarDependencies()
    end

    enableHealthBarColoringFrame = CreateCheckbox(label, false, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Role Based Threat Colors config
local function CreateRoleBasedColorsConfig()
    local label = "Use Role-Based Colors"
    local checked = BlizzThreatPlatesConfig["useRoleBasedColors"]
    local tooltip = {
        label,
        " ",
        "Use different health bar colors for tanks and healers/damage dealers. When disabled, the healers/damage dealers colors are used.",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["useRoleBasedColors"] = value
    end

    useRoleBasedColorsFrame = CreateCheckbox(label, true, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Roles section header
local function CreateRolesSectionHeader()
    local label = "Roles"
    local tooltip = { label }

    CreateSectionHeader(label, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Player Role Detection config
local function CreatePlayerRoleDetectionConfig()
    local label = "Role Detection (your character)"
    local tooltip = {
        label,
        " ",
        "|cffffffffLFG Assigned Role:|r Use the LFG tool (Looking For Group) assigned role to detect your character's role. If not available, it will fallback to the Automatic mode.",
        " ",
        "|cffffffffAutomatic:|r Use Defensive Stance, Bear Form or Righteous Fury to detect if your character is a tank and the heal/damage ratio to detect if your character is a healer or a damage dealer.",
        " ",
        "|cffff0000This option is per character.|r",
    }

    local options = {
        { label = "LFG Assigned Role", value = addon.ROLE_DETECTION_LFG_ROLE },
        { label = "Automatic", value = addon.ROLE_DETECTION_AUTOMATIC },
    }

    local function SetupMenu(dropdown, rootDescription)
        for _, option in ipairs(options) do
            local text = option.label
            local isSelected = function()
                return option.value == BlizzThreatPlatesCharacterConfig["playerRoleDetection"]
            end
            local setSelected = function()
                BlizzThreatPlatesCharacterConfig["playerRoleDetection"] = option.value
                dropdown:SignalUpdate()
            end
            CreateDropdownOption(rootDescription, text, isSelected, setSelected)
        end
    end

    playerRoleDetectionFrame = CreateDropdownWithStepperAndLabel(label, false, 225, SetupMenu, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Group Role Detection config
local function CreateGroupRoleDetectionConfig()
    local label = "Role Detection (group members)"
    local tooltip = {
        label,
        " ",
        "|cffffffffLFG Assigned Role:|r Use the LFG tool (Looking For Group) assigned roles to detect other group members roles. If not available, it will fallback to the Automatic mode.",
        " ",
        "|cffffffffAutomatic:|r Use Defensive Stance, Bear Form or Righteous Fury to detect if other group members are tanks and their heal/damage ratio to detect if they are healers or damage dealers.",
    }

    local options = {
        { label = "LFG Assigned Role", value = addon.ROLE_DETECTION_LFG_ROLE },
        { label = "Automatic", value = addon.ROLE_DETECTION_AUTOMATIC },
    }

    local function SetupMenu(dropdown, rootDescription)
        for _, option in ipairs(options) do
            local text = option.label
            local isSelected = function()
                return option.value == BlizzThreatPlatesConfig["groupRoleDetection"]
            end
            local setSelected = function()
                BlizzThreatPlatesConfig["groupRoleDetection"] = option.value
                dropdown:SignalUpdate()
            end
            CreateDropdownOption(rootDescription, text, isSelected, setSelected)
        end
    end

    groupRoleDetectionFrame = CreateDropdownWithStepperAndLabel(label, false, 225, SetupMenu, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Tank Type config
local function CreateTankTypeConfig()
    local label = "Tank Type"
    local tooltip = {
        label,
        " ",
        "When tanking, this option controls how the aggro status changes the colors.",
        " ",
        "|cffffffffMain Tank:|r You are tanking most/all enemies. Colors will reflect your aggro status.",
        " ",
        "|cffffffffOff-Tank:|r You can tank some enemies or not. Colors will stay the same no matter your aggro status.",
        " ",
        "|cffff0000This option is per character.|r",
    }

    local options = {
        { label = "Main Tank", value = addon.TANK_TYPE_MAIN },
        { label = "Off-Tank", value = addon.TANK_TYPE_OFFTANK },
    }

    local function SetupMenu(dropdown, rootDescription)
        for _, option in ipairs(options) do
            local text = option.label
            local isSelected = function()
                return option.value == BlizzThreatPlatesCharacterConfig["tankType"]
            end
            local setSelected = function()
                BlizzThreatPlatesCharacterConfig["tankType"] = option.value
                dropdown:SignalUpdate()
            end
            CreateDropdownOption(rootDescription, text, isSelected, setSelected)
        end
    end

    tankTypeFrame = CreateDropdownWithStepperAndLabel(label, false, 225, SetupMenu, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Threat Indicator section header
local function CreateThreatIndicatorSectionHeader()
    local label = "Threat Indicator"
    local tooltip = { label }

    CreateSectionHeader(label, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Enable / disable the Priority Marker's configs
function UpdateThreatIndicatorDependencies()
    local enabled                 = BlizzThreatPlatesConfig["enableThreatIndicator"]
    local font                    = enabled and "GameFontNormalSmall" or "GameFontDisableSmall"

    threatIndicatorModeFrame.Label:SetFontObject(font)
    threatIndicatorModeFrame:SetEnabled(enabled)
    threatIndicatorPositionFrame.Label:SetFontObject(font)
    threatIndicatorPositionFrame:SetEnabled(enabled)
    threatIndicatorScaleFrame.text:SetFontObject(font)
    threatIndicatorScaleFrame:SetEnabled(enabled)
end

-- Create the Enable Threat Indicator config
local function CreateEnableThreatIndicatorConfig()
    local label = "Enable Threat Indicator"
    local checked = BlizzThreatPlatesConfig["enableThreatIndicator"]
    local tooltip = {
        label,
        " ",
        "Checking this will enable the Threat Indicator. This is the box showing the threat values and the current threat leader.",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["enableThreatIndicator"] = value
        UpdateThreatIndicatorDependencies()
    end

    enableThreatIndicatorFrame = CreateCheckbox(label, false, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the threat indicator mode config (threat value VS threat percentage)
local function CreateThreatIndicatorModeConfig()
    local label = "Threat Indicator Mode"
    local tooltip = {
        label,
        " ",
        "|cffffffffValue Diff:|r\nDisplays how many threat points you are ahead or behind.",
        " ",
        "|cffffffffPercentage:|r\nDisplays your threat as a percentage of the tank's threat (0% to 999%).\n|cff00ff00Aggro melee at 110% / ranged at 130%|r",
        " ",
        "|cffffffffNormalized Percentage:|r\nDisplays your threat as a percentage of the tank’s threat (0% to 100%).\n|cff00ff00Aggro at 100%|r",
    }

    local options = {
        { label = "Value Diff",                 value = addon.THREAT_LEAD_VALUE },
        { label = "Percentage",                 value = addon.THREAT_PERCENT_RAW },
        { label = "Normalized Percentage",      value = addon.THREAT_PERCENT },
    }

    local function SetupMenu(dropdown, rootDescription)
        for _, option in ipairs(options) do
            local text = option.label
            local isSelected = function()
                return option.value == BlizzThreatPlatesConfig["threatIndicatorMode"]
            end
            local setSelected = function()
                BlizzThreatPlatesConfig["threatIndicatorMode"] = option.value
                dropdown:SignalUpdate()
            end
            CreateDropdownOption(rootDescription, text, isSelected, setSelected)
        end
    end

    threatIndicatorModeFrame = CreateDropdownWithStepperAndLabel(label, true, 225, SetupMenu, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Threat Indicator Position config
local function CreateThreatIndicatorPositionConfig()
    local label = "Threat Indicator Position"
    local tooltip = {
        label,
        " ",
        "The position where the Threat Indicator is displayed relative to the nameplate.",
        " ",
        "|cffff0000Note:|r The left position may overlap with icons from other addons (e.g. Questie). If this happens, choose another position or disable those icons.",
    }

    local options = {
        { label = "Top Left",     value = addon.THREAT_INDICATOR_POSITION_TOPLEFT },
        { label = "Top",          value = addon.THREAT_INDICATOR_POSITION_TOP },
        { label = "Top Right",    value = addon.THREAT_INDICATOR_POSITION_TOPRIGHT },
        { label = "Left",         value = addon.THREAT_INDICATOR_POSITION_LEFT },
        { label = "Right",        value = addon.THREAT_INDICATOR_POSITION_RIGHT },
    }

    local function SetupMenu(dropdown, rootDescription)
        for _, option in ipairs(options) do
            local text = option.label
            local isSelected = function()
                return option.value == BlizzThreatPlatesConfig["threatIndicatorPosition"]
            end
            local setSelected = function()
                BlizzThreatPlatesConfig["threatIndicatorPosition"] = option.value
                dropdown:SignalUpdate()
            end
            CreateDropdownOption(rootDescription, text, isSelected, setSelected)
        end
    end

    threatIndicatorPositionFrame = CreateDropdownWithStepperAndLabel(label, true, 225, SetupMenu, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Threat Indicator Scale config
local function CreateThreatIndicatorScaleConfig()
    local label = "Threat Indicator Scale"
    local tooltip = {
        label,
        " ",
        "Adjust the size of the threat indicator and its text. Increase the scale to make the indicator more visible, or reduce it to keep UI compact.",
    }

    local value = BlizzThreatPlatesConfig["threatIndicatorScale"]
    local function OnChanged(_, value)
        BlizzThreatPlatesConfig["threatIndicatorScale"] = value
    end

    threatIndicatorScaleFrame = CreateMinimalSliderWithSteppers(label, true, 50, 200, 30, value, SliderFormatterPercent, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Priority Marker section header
local function CreatePriorityMarkerSectionHeader()
    local label = "Priority Marker"
    local tooltip = { label }

    CreateSectionHeader(label, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Enable / disable the Priority Marker's configs
function UpdatePriorityMarkerDependencies()
    local enabled = BlizzThreatPlatesCharacterConfig["enablePriorityMarker"]
    local font = enabled and "GameFontNormalSmall" or "GameFontDisableSmall"
    local priorityMarkerColor = BlizzThreatPlatesCharacterConfig["priorityMarkerColor"]
    local color = enabled and priorityMarkerColor or COLOR_DISABLED
    local borderColor = enabled and addon.COLOR_GREY or COLOR_DISABLED
    local r, g, b, a = color.r, color.g, color.b, color.a

    priorityMarkerColorFrame.text:SetFontObject(font)
    priorityMarkerColorFrame:SetBackdropColor(r, g, b, a)
    priorityMarkerPreviewFrame:SetBackdropColor(r, g, b, a)
    priorityMarkerPreviewFrame:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
    priorityMarkerPreviewFrame:EnableMouse(enabled)
    elitesOnlyFrame.text:SetFontObject(font)
    elitesOnlyFrame:SetEnabled(enabled)
    minimumHealthFrame.text:SetFontObject(font)
    minimumHealthFrame:SetEnabled(enabled)
    threatSafetyBufferFrame.text:SetFontObject(font)
    threatSafetyBufferFrame:SetEnabled(enabled)
end

-- Create the Enable Priority Marker config
local function CreateEnablePriorityMarkerConfig()
    local label = "Enable Priority Marker"
    local checked = BlizzThreatPlatesCharacterConfig["enablePriorityMarker"]
    local tooltip = {
        label,
        " ",
        "Checking this will enable the Priority Marker, shown as a colored box behind an enemy's name.",
        " ",
        "|cffffffffMain Tanks|r",
        "Marks the enemy against whom you currently have the largest threat deficit.",
        " ",
        "|cffffffffOff-Tanks|r",
        "Unavailable for off-tanks.",
        " ",
        "|cffffffffHealers and Damage Dealers|r",
        "Marks the lowest-health enemy that is safe for you to attack based on your threat safety buffer.",
        " ",
        "|cffff0000This option is per character.|r",
    }

    local function OnChanged(value)
        BlizzThreatPlatesCharacterConfig["enablePriorityMarker"] = value
        UpdatePriorityMarkerDependencies()
    end

    enablePriorityMarkerFrame = CreateCheckbox(label, false, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Priority Marker Color config
local function CreatePriorityMarkerColorConfig()
    local label = "Background Color"
    local tooltip = {
        label,
        " ",
        "The color used for the Priority Marker's box shown behind the enemy's name.",
        " ",
        "|cffff0000This option is per character.|r",
    }

    local function OnChanged()
        local r, g, b = ColorPickerFrame:GetColorRGB()
        local a = ColorPickerFrame:GetColorAlpha()
        BlizzThreatPlatesCharacterConfig["priorityMarkerColor"] = { r = r, g = g, b = b, a = a }
        priorityMarkerColorFrame:SetBackdropColor(r, g, b, a)
        priorityMarkerPreviewFrame:SetBackdropColor(r, g, b, a)
        addon.SetPriorityMarkerColor(BlizzThreatPlatesCharacterConfig["priorityMarkerColor"])
    end

    local function OnCancel(previousValues)
        local r, g, b = previousValues.r, previousValues.g, previousValues.b
        local a = previousValues.a
        BlizzThreatPlatesCharacterConfig["priorityMarkerColor"] = { r = r, g = g, b = b, a = a }
        priorityMarkerColorFrame:SetBackdropColor(r, g, b, a)
        priorityMarkerPreviewFrame:SetBackdropColor(r, g, b, a)
        addon.SetPriorityMarkerColor(BlizzThreatPlatesCharacterConfig["priorityMarkerColor"])
    end

    priorityMarkerColorFrame = CreateColorPicker(label, true, "priorityMarkerColor", true, OnChanged, OnCancel, tooltip)

    -- Preview
    priorityMarkerPreviewFrame = addon.CreatePriorityMarker()
    priorityMarkerPreviewFrame:SetParent(contentFrame)
    priorityMarkerPreviewFrame:SetWidth(225)
    priorityMarkerPreviewFrame:SetHeight(32)
    priorityMarkerPreviewFrame:SetPoint("LEFT", priorityMarkerColorFrame, "RIGHT", 5, 0)
    priorityMarkerPreviewFrame:EnableMouse(true)
    priorityMarkerPreviewFrame:Show()
    priorityMarkerPreviewFrame:SetScript("OnMouseDown", function(self)
        local currentColor = BlizzThreatPlatesCharacterConfig["priorityMarkerColor"]
        ColorPickerFrame:SetupColorPickerAndShow({
            r = currentColor.r, g = currentColor.g, b = currentColor.b,
            opacity = currentColor.a,
            hasOpacity = true,
            swatchFunc = OnChanged,
            opacityFunc = OnChanged,
            cancelFunc = OnCancel,
        })
    end)

    local previewText = priorityMarkerColorFrame:CreateFontString(nil, "OVERLAY", "SystemFont_LargeNamePlate")
    previewText:SetAllPoints(priorityMarkerPreviewFrame)
    previewText:SetText("Preview")

    local font, _, flags = previewText:GetFont()
    previewText:SetFont(font, 14, flags)
    priorityMarkerPreviewFrame.text = previewText

    priorityMarkerPreviewFrame:SetScript("OnEnter", function()
        local color = addon.COLOR_YELLOW
        previewText:SetTextColor(color.r, color.g, color.b, color.a)
    end)

    priorityMarkerPreviewFrame:SetScript("OnLeave", function()
        local color = addon.COLOR_WHITE
        previewText:SetTextColor(color.r, color.g, color.b, color.a)
    end)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the prioritize elites only config
local function CreatePrioritizeElitesOnlyConfig()
    local label = "Elite Enemies Only"
    local checked = BlizzThreatPlatesConfig["prioritizeElitesOnly"]
    local tooltip = {
        label,
        "|cffff0000Requires Main Tank role|r",
        "Restricts the priority marker to elite enemies. Useful when you want to focus attention on the most dangerous enemies.",
    }

    local function OnChanged(value)
        BlizzThreatPlatesConfig["prioritizeElitesOnly"] = value
    end

    elitesOnlyFrame = CreateCheckbox(label, true, checked, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the health lower than config
local function CreateHealthLowerThanConfig()
    local label = "Enemies Minimum Health"
    local tooltip = {
        label,
        "|cffff0000Requires Main Tank role|r",
        "Ignore low-health enemies. Prevents the priority marker from selecting enemies whose health is below this percentage. Useful for avoiding targets that are about to die.",
    }

    local value = BlizzThreatPlatesConfig["minHealthPercent"]
    local function OnChanged(_, value)
        BlizzThreatPlatesConfig["minHealthPercent"] = value
    end

    minimumHealthFrame = CreateMinimalSliderWithSteppers(label, true, 0, 100, 20, value, SliderFormatterPercent, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the Threat Safety Buffer config
local function CreateThreatSafetyBufferConfig()
    local label = "Threat Safety Buffer"
    local tooltip = {
        label,
        "|cffff0000Requires Healer or Damage Dealer role|r",
        "Sets the minimum time window used to calculate a threat safety buffer between your threat and the threat leader's threat using your median threat per second. Only safe targets will be prioritized.",
        " ",
        "|cffff0000This option is per character.|r",
    }

    local value = BlizzThreatPlatesCharacterConfig["threatSafetyBuffer"]
    local function OnChanged(_, value)
        BlizzThreatPlatesCharacterConfig["threatSafetyBuffer"] = value
    end

    threatSafetyBufferFrame = CreateMinimalSliderWithSteppers(label, true, 0, 5, 5, value, SliderFormatterSeconds, OnChanged, tooltip)

    yOffset = yOffset - LINEHEIGHT
end

-- Create the addon config panel
function addon.InitConfigs()
    local title = "Blizz Threat Plates"

    configFrame = CreateFrame("Frame")
    local category, _ = Settings.RegisterCanvasLayoutCategory(configFrame, title)
    Settings.RegisterAddOnCategory(category)

    -- /btp Slash Command
    SLASH_BTP1 = "/btp"
    SlashCmdList["BTP"] = function()
        Settings.OpenToCategory(category.ID)
    end

    local scrollFrame = CreateFrame("ScrollFrame", nil, configFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 10, -55)
    scrollFrame:SetPoint("BOTTOMRIGHT", configFrame, "BOTTOMRIGHT", -30, 10)

    contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetSize(1, 1)
    scrollFrame:SetScrollChild(contentFrame)

    InitConfigs()
    CreateHeader(title)
    CreateShowOnlyInGroupRaidConfig()
    CreatePetExceptionConfig()
    CreateHealthBarSectionHeader()
    CreateEnableHealthBarColoringConfig()
    CreateRoleBasedColorsConfig()
    CreateRolesSectionHeader()
    CreatePlayerRoleDetectionConfig()
    CreateGroupRoleDetectionConfig()
    CreateTankTypeConfig()
    CreateThreatIndicatorSectionHeader()
    CreateEnableThreatIndicatorConfig()
    CreateThreatIndicatorModeConfig()
    CreateThreatIndicatorPositionConfig()
    CreateThreatIndicatorScaleConfig()
    CreatePriorityMarkerSectionHeader()
    CreateEnablePriorityMarkerConfig()
    CreatePriorityMarkerColorConfig()
    CreatePrioritizeElitesOnlyConfig()
    CreateHealthLowerThanConfig()
    CreateThreatSafetyBufferConfig()

    UpdateShowOnlyInGroupRaidDependencies()
    UpdateHealthBarDependencies()
    UpdateThreatIndicatorDependencies()
    UpdatePriorityMarkerDependencies()

    return configFrame
end