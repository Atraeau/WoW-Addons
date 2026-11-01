-- King's Gambit: in-game self-check (Phase 1.6). `/gambit check` probes the REAL client through
-- RealClient with read-only calls, prints a pass/fail summary, and saves the details to
-- KingsGambitDB.selfcheck so they can be read back from the SavedVariables file after /reload.
-- Everything here is safe to run anywhere: no loot is given, no ledger events are written.
local _, SK = ...
local Client
local M = SK:NewModule("SelfCheck", { "Client" }, function(d) Client = d.Client end)

local function show(v)
    if type(v) == "table" then
        local n = 0
        for _ in pairs(v) do n = n + 1 end
        return "table(" .. n .. ")"
    end
    return tostring(v)
end

-- Enum tables are recorded verbatim: they are ground truth for the names RealClient maps.
local function dumpEnum(e)
    local out = {}
    if type(e) == "table" then
        for k, v in pairs(e) do out[#out + 1] = k .. "=" .. tostring(v) end
        table.sort(out)
    end
    return table.concat(out, ", ")
end

function M.Run(client)
    local results, order = {}, {}
    local function add(name, ok, detail)
        results[#results + 1] = { name = name, ok = ok and true or false, detail = detail }
    end
    local function probe(name, fn)
        local ok, a, b = pcall(fn)
        if not ok then add(name, false, "error: " .. tostring(a))
        elseif a == false then add(name, false, tostring(b))
        else add(name, true, show(a)) end
    end

    probe("contract: no missing methods", function()
        local missing = Client.Missing(client)
        if #missing > 0 then return false, "missing " .. table.concat(missing, ",") end
        return "complete"
    end)
    probe("me()", function() return client:me() or false end)
    probe("normalize('Test')", function() return client:normalize("Test") or false end)
    probe("now() / serverTime()", function() return client:now() .. " / " .. client:serverTime() end)
    probe("inGroup / inRaid", function() return tostring(client:inGroup()) .. " / " .. tostring(client:inRaid()) end)
    probe("roster()", function()
        local r = client:roster()
        local first = r[1] and (r[1].name .. " rank=" .. tostring(r[1].rank) .. " " .. tostring(r[1].class)) or "empty"
        return #r .. " members; first: " .. first
    end)
    probe("lootMethod()", function() return client:lootMethod() end)
    probe("isMasterLooter()", function() return tostring(client:isMasterLooter()) end)
    probe("guildRoster()", function() return #client:guildRoster() .. " members" end)
    probe("serialize round trip", function()
        local v = { a = { 1, 2, 3 }, b = "x:y,{}", c = 4.5 }
        local s = client:serialize(v)
        local back = client:deserialize(s)
        if not (back and back.b == "x:y,{}" and back.a[3] == 3 and back.c == 4.5) then return false, "mismatch: " .. show(back) end
        return "tag " .. s:sub(1, 1) .. ", " .. #s .. " bytes"
    end)
    probe("registerPrefix('KGCHECK')", function() return client:registerPrefix("KGCHECK") or false end)
    probe("itemInfo(Hearthstone)", function()
        local info = client:itemInfo("item:6948")
        return info and (info.name .. " ilvl " .. tostring(info.ilvl)) or "nil (not cached yet; normal on first call)"
    end)

    -- Asynchronous: whisper an addon message to ourselves and wait for it to come back.
    local got
    local off = client:on("comms.received", function(p)
        if p.prefix == "KGCHECK" then got = p end
    end)
    local sent, why = client:send("KGCHECK", "ping", "WHISPER", client:me())
    if not sent then add("send+receive loopback", false, "send failed: " .. tostring(why)) end

    client:after(2, function()
        off()
        if sent then
            add("send+receive loopback", got ~= nil, got and ("received from " .. tostring(got.sender)) or "no message came back in 2s")
        end
        local passed = 0
        for _, r in ipairs(results) do if r.ok then passed = passed + 1 end end
        local E = _G
        local saved = {
            at = client:serverTime(), passed = passed, total = #results, results = results,
            unregisteredEvents = client.unregistered or {},
            env = {
                build = (E.GetBuildInfo and select(2, E.GetBuildInfo())) or "?",
                interface = (E.GetBuildInfo and select(4, E.GetBuildInfo())) or "?",
                luaVersion = E._VERSION, projectId = E.WOW_PROJECT_ID,
                issecretvalue = E.issecretvalue ~= nil, bitLib = E.bit ~= nil,
                encodingUtil = E.C_EncodingUtil ~= nil,
            },
            enums = {
                SendAddonMessageResult = dumpEnum(E.Enum and E.Enum.SendAddonMessageResult),
                RegisterAddonMessagePrefixResult = dumpEnum(E.Enum and E.Enum.RegisterAddonMessagePrefixResult),
                LootMethod = dumpEnum(E.Enum and E.Enum.LootMethod),
                Base64Variant = dumpEnum(E.Enum and E.Enum.Base64Variant),
            },
        }
        client:storage().account.selfcheck = saved
        for _, r in ipairs(results) do
            client:print((r.ok and "|cff3fb950ok|r   " or "|cfff85149FAIL|r ") .. r.name .. "  " .. tostring(r.detail))
        end
        client:print(("self-check: %d of %d passed. Details saved; /reload to write them to disk."):format(passed, #results))
    end)
    client:print("self-check running (2s)...")
end
