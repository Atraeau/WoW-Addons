-- Spell Dump
-- Dev tool: saves the character's spellbook and talent tree to SavedVariables so the abilities can be read offline.
--
-- Usage:
--   1. Log in on the character you want to dump.
--   2. /spelldump           (or /spelldump quiet to skip the chat summary)
--   3. /reload              (SavedVariables are only written to disk on reload/logout)
--   4. Read WTF/Account/<acct>/SavedVariables/SpellDump.lua
--
-- Everything is wrapped in pcall: an API that is missing or behaves differently on this client is recorded, not fatal.
local addonName, ns = ...

SpellDumpDB = SpellDumpDB or {}

local function try(fn, ...)
	local ok, a, b, c = pcall(fn, ...)
	if ok then return a, b, c end
	return nil, nil, nil, tostring(a)
end

local function spellName(spellID)
	if not spellID then return nil end
	if C_Spell and C_Spell.GetSpellName then
		local n = try(C_Spell.GetSpellName, spellID)
		if n then return n end
	end
	if C_Spell and C_Spell.GetSpellInfo then
		local info = try(C_Spell.GetSpellInfo, spellID)
		if type(info) == "table" then return info.name end
	end
	return nil
end

local function spellDescription(spellID)
	if not (spellID and C_Spell and C_Spell.GetSpellDescription) then return nil end
	local d = try(C_Spell.GetSpellDescription, spellID)
	return d
end

-- The spellbook: every skill line (general, class, spec, ...) with each spell in it.
local function dumpSpellbook(errors)
	local out = {}
	if not (C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines) then
		errors[#errors + 1] = "C_SpellBook.GetNumSpellBookSkillLines is missing"
		return out
	end
	local bank = Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player or 0
	local n = try(C_SpellBook.GetNumSpellBookSkillLines) or 0
	for i = 1, n do
		local line = try(C_SpellBook.GetSpellBookSkillLineInfo, i)
		if type(line) == "table" then
			local entry = { name = line.name, offset = line.itemIndexOffset, count = line.numSpellBookItems, spells = {} }
			for slot = (line.itemIndexOffset or 0) + 1, (line.itemIndexOffset or 0) + (line.numSpellBookItems or 0) do
				local info = try(C_SpellBook.GetSpellBookItemInfo, slot, bank)
				if type(info) == "table" then
					entry.spells[#entry.spells + 1] = {
						name = info.name or try(C_SpellBook.GetSpellBookItemName, slot, bank),
						spellID = info.spellID,
						actionID = info.actionID,
						itemType = info.itemType,
						passive = info.isPassive,
						offSpec = info.isOffSpec,
						subName = info.subName,
						description = spellDescription(info.spellID),
					}
				end
			end
			out[#out + 1] = entry
		else
			errors[#errors + 1] = "skill line " .. i .. " unreadable"
		end
	end
	return out
end

-- The talent tree, modern style (C_Traits): every node in the tree, learned or not.
local function dumpTraits(errors)
	local out = {}
	if not (C_ClassTalents and C_ClassTalents.GetActiveConfigID and C_Traits) then
		errors[#errors + 1] = "C_ClassTalents / C_Traits missing"
		return out
	end
	local configID = try(C_ClassTalents.GetActiveConfigID)
	out.configID = configID
	if not configID then errors[#errors + 1] = "no active talent config"; return out end
	local cfg = try(C_Traits.GetConfigInfo, configID)
	if type(cfg) ~= "table" then errors[#errors + 1] = "GetConfigInfo returned nothing"; return out end
	out.trees = {}
	for _, treeID in ipairs(cfg.treeIDs or {}) do
		local tree = { treeID = treeID, nodes = {} }
		local nodeIDs = C_Traits.GetTreeNodes and try(C_Traits.GetTreeNodes, treeID)
		if not nodeIDs then errors[#errors + 1] = "C_Traits.GetTreeNodes unavailable for tree " .. tostring(treeID) end
		for _, nodeID in ipairs(nodeIDs or {}) do
			local node = try(C_Traits.GetNodeInfo, configID, nodeID)
			if type(node) == "table" then
				local entries = {}
				for _, entryID in ipairs(node.entryIDs or {}) do
					local e = C_Traits.GetEntryInfo and try(C_Traits.GetEntryInfo, configID, entryID)
					local def = type(e) == "table" and e.definitionID and C_Traits.GetDefinitionInfo and try(C_Traits.GetDefinitionInfo, e.definitionID)
					local spellID = type(def) == "table" and def.spellID or nil
					entries[#entries + 1] = {
						entryID = entryID,
						spellID = spellID,
						name = spellName(spellID),
						description = spellDescription(spellID),
					}
				end
				tree.nodes[#tree.nodes + 1] = {
					nodeID = nodeID,
					x = node.posX, y = node.posY,
					ranks = node.ranksPurchased, maxRanks = node.maxRanks,
					canPurchase = node.canPurchaseRank, active = node.activeRank,
					entries = entries,
				}
			end
		end
		out.trees[#out.trees + 1] = tree
	end
	return out
end

-- The talent tree, classic style (GetTalentInfo), in case this client still has the old tabs.
local function dumpClassicTalents(errors)
	local out = {}
	if not (GetNumTalentTabs and GetTalentInfo) then return out end
	for tab = 1, (try(GetNumTalentTabs) or 0) do
		local tabName = try(GetTalentTabInfo or function() end, tab)
		local t = { tab = tab, name = tabName, talents = {} }
		for i = 1, (try(GetNumTalents, tab) or 0) do
			local name, _, tier, column, rank, maxRank = try(GetTalentInfo, tab, i)
			t.talents[#t.talents + 1] = { name = name, tier = tier, column = column, rank = rank, maxRank = maxRank }
		end
		out[#out + 1] = t
	end
	return out
end

-- Which functions the trait/talent namespaces really have on this client (the generated types are only partly complete).
local function apiNames(tbl)
	local names = {}
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do if type(v) == "function" then names[#names + 1] = k end end
		table.sort(names)
	end
	return names
end

local function run(quiet)
	local errors = {}
	local _, class = UnitClass("player")
	local _, build, _, iface = GetBuildInfo()
	local db = {
		meta = {
			character = UnitName("player"), class = class, level = UnitLevel("player"),
			build = build, interface = iface, date = date("%Y-%m-%d %H:%M:%S"),
		},
		spellbook = dumpSpellbook(errors),
		traits = dumpTraits(errors),
		classicTalents = dumpClassicTalents(errors),
		api = { C_Traits = apiNames(C_Traits), C_ClassTalents = apiNames(C_ClassTalents), C_SpellBook = apiNames(C_SpellBook) },
		errors = errors,
	}
	-- One dump per character, so Morla and Atraeau can both be kept.
	SpellDumpDB[(db.meta.character or "unknown")] = db

	local spells, passives = 0, 0
	for _, line in ipairs(db.spellbook) do
		for _, s in ipairs(line.spells) do
			spells = spells + 1
			if s.passive then passives = passives + 1 end
		end
	end
	local nodes = 0
	for _, tree in ipairs(db.traits.trees or {}) do nodes = nodes + #tree.nodes end
	if not quiet then
		print(("|cff33ff99Spell Dump|r: %s (%s): %d spellbook entries (%d passive) in %d lines, %d talent nodes, %d problems. /reload to save to disk.")
			:format(tostring(db.meta.character), tostring(class), spells, passives, #db.spellbook, nodes, #errors))
		for _, e in ipairs(errors) do print("|cffff8800  " .. e .. "|r") end
	end
end

SLASH_SPELLDUMP1 = "/spelldump"
SlashCmdList["SPELLDUMP"] = function(msg)
	msg = (msg or ""):lower()
	local ok, err = pcall(run, msg:find("quiet") ~= nil)
	if not ok then print("|cffff4444Spell Dump failed:|r " .. tostring(err)) end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	print("|cff33ff99Spell Dump|r loaded. Type /spelldump, then /reload.")
end)
