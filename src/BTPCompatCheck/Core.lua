-- BTPCompatCheck
-- Ground-truth API probe: asks the RUNNING client which globals/methods exist,
-- instead of trusting external assumptions about "retail vs classic".
-- Resolves dotted paths from _G and prints OK / MISSING.  Run /btpcheck any time.
local addonName, ns = ...

local CHECKS = {
	{ "Replacement APIs the patches now rely on (want OK)", {
		"C_UnitAuras.GetBuffDataByIndex",
		"C_UnitAuras.GetDebuffDataByIndex",
		"ColorPickerFrame.SetupColorPickerAndShow",
		"ColorPickerFrame.GetColorAlpha",
	}},
	{ "Old APIs the patches removed (MISSING confirms the patch was needed)", {
		"UnitBuff",
		"UnitDebuff",
		"OpacitySliderFrame",
		"PixelUtil.SetStatusBarValue",
	}},
	{ "Other APIs BlizzThreatPlates depends on (want OK)", {
		"C_NamePlate.GetNamePlateForUnit",
		"UnitDetailedThreatSituation",
		"AbbreviateNumbers",
		"SetPortraitTexture",
		"UnitGroupRolesAssigned",
		"GetShapeshiftForm",
		"Settings.RegisterCanvasLayoutCategory",
		"Settings.OpenToCategory",
		"MenuUtil.SetElementText",
	}},
}

local function Resolve(path)
	local obj = _G
	for part in path:gmatch("[%w_]+") do
		if type(obj) ~= "table" then return nil end
		obj = obj[part]
	end
	return obj
end

local function RunReport()
	local _, build, _, iface = GetBuildInfo()
	print(("|cff33ff99BTPCompatCheck|r — build %s, interface %s"):format(tostring(build), tostring(iface)))
	for _, group in ipairs(CHECKS) do
		print("|cffffd100" .. group[1] .. "|r")
		for _, path in ipairs(group[2]) do
			local exists = Resolve(path) ~= nil
			local mark = exists and "|cff40ff40OK     |r" or "|cffff4040MISSING|r"
			print("   " .. mark .. "  " .. path)
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	C_Timer.After(1, RunReport)
end)

SLASH_BTPCHECK1 = "/btpcheck"
SlashCmdList["BTPCHECK"] = RunReport
