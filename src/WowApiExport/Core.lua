-- WowApiExport
-- Exports the RUNNING client's own API documentation (the APIDocumentation system
-- behind the in-game /api command) plus a raw _G inventory, to SavedVariables.
-- This is the authoritative, client-confirmed API surface -- no external assumptions.
--
-- Usage:
--   1. Run /apiexport (or /wowapiexport) when you want a fresh dump. It does not run at login.
--   2. /reload   (SavedVariables are only flushed to disk on reload/logout)
--   3. Read WTF/Account/<acct>/SavedVariables/WowApiExport.lua
--
-- Produces two saved variables:
--   WowApiExportDB   - native Lua table (human readable)
--   WowApiExportJSON - the same data as a JSON string (easy to parse offline)
local addonName, ns = ...

WowApiExportDB = WowApiExportDB or {}
WowApiExportJSON = WowApiExportJSON or ""
WowApiExportB64 = WowApiExportB64 or ""   -- canonical machine-readable payload (base64 of the JSON)

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
-- Base64 (pure Lua) -- base64 has no quotes/backslashes so it survives the
-- SavedVariables serializer with zero escaping, making offline parsing trivial.
--------------------------------------------------------------------------------
local B64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local B64_LOOKUP = {}
for k = 1, 64 do B64_LOOKUP[k - 1] = B64_CHARS:sub(k, k) end

local function Base64Encode(data)
	local byte = string.byte
	local floor = math.floor
	local lookup = B64_LOOKUP
	local out, oi = {}, 0
	local n = #data
	local i = 1
	while i <= n do
		local b1 = byte(data, i)
		local b2 = byte(data, i + 1)
		local b3 = byte(data, i + 2)
		oi = oi + 1; out[oi] = lookup[floor(b1 / 4)]
		oi = oi + 1; out[oi] = lookup[(b1 % 4) * 16 + floor((b2 or 0) / 16)]
		if b2 then
			oi = oi + 1; out[oi] = lookup[(b2 % 16) * 4 + floor((b3 or 0) / 64)]
		else
			oi = oi + 1; out[oi] = "="
		end
		if b3 then
			oi = oi + 1; out[oi] = lookup[b3 % 64]
		else
			oi = oi + 1; out[oi] = "="
		end
		i = i + 3
	end
	return table.concat(out)
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

-- APIDocumentation is provided by a load-on-demand Blizzard addon; force it in.
local function EnsureAPIDocumentationLoaded()
	local load = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
	if not load then return end
	for _, name in ipairs({ "Blizzard_APIDocumentation", "Blizzard_APIDocumentationGenerated" }) do
		pcall(load, name)
	end
end

local function ExtractAPIDocumentation()
	EnsureAPIDocumentationLoaded()
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
-- The console commands and CVars (what the in-game console lists and searches)
--------------------------------------------------------------------------------
local function ExtractConsole()
	local out = {}
	if not ConsoleGetAllCommands then return out end
	local function names(enum)
		local map = {}
		for k, v in pairs(enum or {}) do map[v] = k end
		return map
	end
	local catNames = names(Enum and Enum.ConsoleCategory)
	local typeNames = names(Enum and Enum.ConsoleCommandType)
	local ok, list = pcall(ConsoleGetAllCommands)
	if not ok or type(list) ~= "table" then return out end
	for _, c in ipairs(list) do
		local entry = {
			command = c.command,
			help = c.help,
			category = catNames[c.category] or c.category,
			commandType = typeNames[c.commandType] or c.commandType,
		}
		if type(c.scriptContents) == "string" and c.scriptContents ~= "" then entry.script = c.scriptContents end
		-- A CVar's current and default values (the command's own name is the CVar's).
		if type(c.command) == "string" and C_CVar and C_CVar.GetCVarInfo then
			local ok2, value, default = pcall(C_CVar.GetCVarInfo, c.command)
			if ok2 and value ~= nil then entry.value, entry.default = value, default end
		end
		out[#out + 1] = entry
	end
	return out
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
		consoleCommands = ExtractConsole(),
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
	data.meta.consoleCommandCount = #data.consoleCommands

	WowApiExportDB = data

	-- JSON: prefer the native (fast) serializer if the client has it.
	local json
	if C_EncodingUtil and C_EncodingUtil.SerializeJSON then
		local ok, native = pcall(C_EncodingUtil.SerializeJSON, data)
		json = ok and native or JsonEncode(data)
	else
		json = JsonEncode(data)
	end
	WowApiExportJSON = json
	-- Canonical payload for offline tooling: base64 of the JSON (no escaping issues).
	WowApiExportB64 = Base64Encode(json)

	print(("|cff33ff99WowApiExport|r  interface %s, build %s"):format(tostring(interface), tostring(build)))
	if hasDocs then
		print(("   %d systems, %d functions, %d events, %d tables, %d console commands"):format(#systems, fnCount, evCount, tbCount, #data.consoleCommands))
	else
		print("   |cffff4040APIDocumentation not found|r on this client -- only the raw _G inventory was captured.")
	end
	print("   Now type |cffffd100/reload|r to flush SavedVariables to disk.")
end

-- It only runs when asked: it takes a moment and rewrites a large saved variable, so it is not done at every login.
SLASH_APIEXPORT1 = "/apiexport"
SLASH_APIEXPORT2 = "/wowapiexport"
SlashCmdList["APIEXPORT"] = Build
