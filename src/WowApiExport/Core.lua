-- WowApiExport
-- Exports the RUNNING client's own API documentation (the APIDocumentation system
-- behind the in-game /api command) plus a raw _G inventory, to SavedVariables.
-- This is the authoritative, client-confirmed API surface -- no external assumptions.
--
-- Usage:
--   1. Log in with this addon enabled (it auto-builds on login), or run /apiexport.
--   2. /reload   (SavedVariables are only flushed to disk on reload/logout)
--   3. Read WTF/Account/<acct>/SavedVariables/WowApiExport.lua
--
-- Produces two saved variables:
--   WowApiExportDB   - native Lua table (human readable)
--   WowApiExportJSON - the same data as a JSON string (easy to parse offline)
local addonName, ns = ...

WowApiExportDB = WowApiExportDB or {}
WowApiExportJSON = WowApiExportJSON or ""

--------------------------------------------------------------------------------
-- Minimal JSON encoder (fallback when C_EncodingUtil is unavailable)
--------------------------------------------------------------------------------
local function EncodeString(s)
	s = s:gsub('[%z\1-\31\\"]', function(c)
		local map = { ['"'] = '\\"', ['\\'] = '\\\\', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
		return map[c] or string.format('\\u%04x', string.byte(c))
	end)
	return '"' .. s .. '"'
end

local function IsArray(t)
	local n = 0
	for k in pairs(t) do
		if type(k) ~= "number" then return false end
		n = n + 1
	end
	return n == #t
end

local function JsonEncode(v)
	local tv = type(v)
	if tv == "string" then
		return EncodeString(v)
	elseif tv == "number" then
		if v ~= v or v == math.huge or v == -math.huge then return "null" end
		return tostring(v)
	elseif tv == "boolean" then
		return tostring(v)
	elseif tv == "table" then
		if IsArray(v) then
			local parts = {}
			for i = 1, #v do parts[i] = JsonEncode(v[i]) end
			return "[" .. table.concat(parts, ",") .. "]"
		else
			local parts = {}
			for k, val in pairs(v) do
				parts[#parts + 1] = EncodeString(tostring(k)) .. ":" .. JsonEncode(val)
			end
			return "{" .. table.concat(parts, ",") .. "}"
		end
	end
	return "null"
end

--------------------------------------------------------------------------------
-- Extract the client's APIDocumentation system
--------------------------------------------------------------------------------
local function Doc(list)
	-- Documentation is a table of strings; join into one.
	if type(list) == "table" then return table.concat(list, " ") end
	return list
end

local function ExtractField(fld)
	return {
		name = fld.Name,
		type = fld.Type,
		innerType = fld.InnerType,
		nilable = fld.Nilable and true or false,
		default = fld.Default,
		enumValue = fld.EnumValue,
		documentation = Doc(fld.Documentation),
	}
end

local function ExtractAPIDocumentation()
	local result = {}
	if not APIDocumentation or not APIDocumentation.systems then
		return result, false
	end

	for _, system in ipairs(APIDocumentation.systems) do
		local sys = {
			name = system.Name,
			namespace = system.Namespace,
			documentation = Doc(system.Documentation),
			functions = {},
			events = {},
			tables = {},
		}

		for _, fn in ipairs(system.Functions or {}) do
			local f = {
				name = fn.Name,
				documentation = Doc(fn.Documentation),
				arguments = {},
				returns = {},
			}
			for _, a in ipairs(fn.Arguments or {}) do f.arguments[#f.arguments + 1] = ExtractField(a) end
			for _, r in ipairs(fn.Returns or {}) do f.returns[#f.returns + 1] = ExtractField(r) end
			sys.functions[#sys.functions + 1] = f
		end

		for _, ev in ipairs(system.Events or {}) do
			local e = { name = ev.Name, literalName = ev.LiteralName, documentation = Doc(ev.Documentation), payload = {} }
			for _, p in ipairs(ev.Payload or {}) do e.payload[#e.payload + 1] = ExtractField(p) end
			sys.events[#sys.events + 1] = e
		end

		for _, tb in ipairs(system.Tables or {}) do
			local t = { name = tb.Name, type = tb.Type, documentation = Doc(tb.Documentation), fields = {} }
			for _, fld in ipairs(tb.Fields or {}) do t.fields[#t.fields + 1] = ExtractField(fld) end
			sys.tables[#sys.tables + 1] = t
		end

		result[#result + 1] = sys
	end

	return result, true
end

--------------------------------------------------------------------------------
-- Raw _G inventory (catches globals not covered by APIDocumentation)
--------------------------------------------------------------------------------
local function ExtractGlobals()
	local globals = {}
	for name, value in pairs(_G) do
		local t = type(value)
		if t == "function" then
			globals[name] = "function"
		elseif t == "table" and name:match("^C_%w+$") then
			-- Namespace table: record its function members.
			local members = {}
			for k, v in pairs(value) do
				if type(v) == "function" then members[#members + 1] = k end
			end
			table.sort(members)
			globals[name] = members
		end
	end
	return globals
end

--------------------------------------------------------------------------------
-- Build the export
--------------------------------------------------------------------------------
local function Build()
	local version, build, buildDate, interface = GetBuildInfo()
	local systems, hasDocs = ExtractAPIDocumentation()

	local data = {
		meta = {
			version = version,
			build = build,
			buildDate = buildDate,
			interface = interface,
			product = "wow_classic_beta",
			exportedAt = date("%Y-%m-%d %H:%M:%S"),
			hasAPIDocumentation = hasDocs,
			systemCount = #systems,
		},
		systems = systems,
		globals = ExtractGlobals(),
	}

	-- Count functions/events for a quick summary.
	local fnCount, evCount, tbCount = 0, 0, 0
	for _, s in ipairs(systems) do
		fnCount = fnCount + #s.functions
		evCount = evCount + #s.events
		tbCount = tbCount + #s.tables
	end
	data.meta.functionCount = fnCount
	data.meta.eventCount = evCount
	data.meta.tableCount = tbCount

	WowApiExportDB = data

	-- JSON: prefer the native (fast) serializer if the client has it.
	if C_EncodingUtil and C_EncodingUtil.SerializeJSON then
		local ok, json = pcall(C_EncodingUtil.SerializeJSON, data)
		WowApiExportJSON = ok and json or JsonEncode(data)
	else
		WowApiExportJSON = JsonEncode(data)
	end

	print(("|cff33ff99WowApiExport|r  interface %s, build %s"):format(tostring(interface), tostring(build)))
	if hasDocs then
		print(("   %d systems, %d functions, %d events, %d tables"):format(#systems, fnCount, evCount, tbCount))
	else
		print("   |cffff4040APIDocumentation not found|r on this client -- only the raw _G inventory was captured.")
	end
	print("   Now type |cffffd100/reload|r to flush SavedVariables to disk.")
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	C_Timer.After(2, Build)
end)

SLASH_APIEXPORT1 = "/apiexport"
SlashCmdList["APIEXPORT"] = Build
