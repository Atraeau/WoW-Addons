-- Hello Forever
-- Example addon proving the dev environment works end to end.
-- The loader passes (addonName, ns) as varargs to each Lua file.
local addonName, ns = ...

-- Saved variables (declared as SavedVariables in the .toc)
HelloForeverDB = HelloForeverDB or {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		HelloForeverDB.logins = (HelloForeverDB.logins or 0)
	elseif event == "PLAYER_LOGIN" then
		HelloForeverDB.logins = HelloForeverDB.logins + 1
		local _, build, _, iface = GetBuildInfo()
		print(("|cff33ff99Hello Forever|r loaded — build %s, interface %s. Type /hf for a hello.")
			:format(tostring(build), tostring(iface)))
	end
end)

-- /hf and /helloforever both work
SLASH_HELLOFOREVER1 = "/hf"
SLASH_HELLOFOREVER2 = "/helloforever"
SlashCmdList["HELLOFOREVER"] = function(msg)
	local name = UnitName("player") or "adventurer"
	print(("|cff33ff99Hello Forever|r: greetings, %s! (login #%d)")
		:format(name, HelloForeverDB.logins or 1))
end
