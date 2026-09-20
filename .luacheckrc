-- Luacheck config for World of Warcraft addon development.
-- Install luacheck (via LuaRocks) to lint: `luacheck src`
-- The WoW client uses Lua 5.1 semantics.

std = "lua51"
max_line_length = false
codes = true
self = false

exclude_files = {
	"build/",
	"dist/",
	".luarocks/",
	"types/",   -- generated LSP definitions (annotations only)
	"vendor/",  -- tracked third-party addons
}

-- Each addon gets its own private table via the "..." vararg on load:
--   local addonName, ns = ...
-- so declaring globals is rarely needed. Add per-addon globals below if you
-- intentionally expose a global (e.g. for a slash-command handler or LibStub).
globals = {
	"SLASH_HELLOFOREVER1",
	"SLASH_HELLOFOREVER2",
}

-- Common WoW API + FrameXML globals. This is a pragmatic subset; extend as needed.
read_globals = {
	-- Core API
	"C_AddOns", "C_Timer", "C_ChatInfo", "C_CVar", "C_Container",
	"CreateFrame", "GetBuildInfo", "GetAddOnMetadata", "IsAddOnLoaded",
	"GetTime", "GetServerTime", "date", "time", "debugprofilestop",
	"print", "format", "strsplit", "strjoin", "strtrim", "strmatch", "gsub",
	"tContains", "tinsert", "tremove", "wipe", "tostringall", "tostring", "tonumber",
	"pairs", "ipairs", "next", "select", "unpack", "type", "error", "assert",
	"pcall", "xpcall", "securecall", "hooksecurefunc",
	"bit", "math", "string", "table", "coroutine", "os",

	-- Chat / messaging
	"DEFAULT_CHAT_FRAME", "ChatFrame1", "SendChatMessage", "SlashCmdList",
	"UIErrorsFrame", "RaidNotice_AddMessage",

	-- Unit / player info
	"UnitName", "UnitClass", "UnitLevel", "UnitHealth", "UnitHealthMax",
	"UnitExists", "UnitGUID", "UnitIsPlayer", "GetRealmName",

	-- Events / frames
	"UIParent", "GameTooltip", "GameFontNormal", "InterfaceOptions_AddCategory",
	"Settings", "RegisterStateDriver",

	-- Color helpers
	"NORMAL_FONT_COLOR", "RED_FONT_COLOR", "GREEN_FONT_COLOR",
	"RAID_CLASS_COLORS", "WrapTextInColorCode",
}
