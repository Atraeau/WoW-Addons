-- Boot the whole addon the way WoW does: every file in TOC order into a stub environment, then fire
-- PLAYER_LOGIN and run slash commands. Catches wiring mistakes (module names, load order, startup
-- errors) that unit tests of single modules cannot.
local H = ...
local test, eq = H.test, H.eq

local function tocFiles(path)
    local files = {}
    for line in io.lines(path) do
        line = line:gsub("\r", "")
        if line ~= "" and not line:find("^##") then files[#files + 1] = line end
    end
    return files
end

H.section("Addon boot")
test("both TOC files list the same files, and every file exists", function()
    local a, b = tocFiles("src/KingsGambit/KingsGambit.toc"), tocFiles("src/KingsGambit/KingsGambit_Camelot.toc")
    eq(table.concat(a, ","), table.concat(b, ","), "the two TOCs have drifted apart")
    for _, f in ipairs(a) do
        local fh = io.open("src/KingsGambit/" .. f, "r")
        assert(fh, "TOC lists a missing file: " .. f); fh:close()
    end
end)

test("the addon loads in TOC order, starts at login, and answers slash commands", function()
    local env = H.newWowEnv()
    local printed, frames = {}, {}
    env.print = function(...)
        local parts = {}
        for i = 1, select("#", ...) do parts[i] = tostring((select(i, ...))) end
        printed[#printed + 1] = table.concat(parts, " ")
    end
    env.CreateFrame = function()
        local f = { events = {} }
        function f:RegisterEvent(e) f.events[e] = true end
        function f:UnregisterEvent(e) f.events[e] = nil end
        function f:SetScript(_, fn) f.onEvent = fn end
        frames[#frames + 1] = f
        return f
    end
    env.SlashCmdList = {}
    env.C_Timer = { NewTimer = function(_, fn) return { fn = fn, Cancel = function() end } end,
        NewTicker = function(_, fn) return { fn = fn, Cancel = function() end } end }

    -- install the stub environment as globals for the duration of the test
    local saved = {}
    for k, v in pairs(env) do saved[k] = rawget(_G, k); _G[k] = v end
    local ok, err = pcall(function()
        local SK = {}
        for _, f in ipairs(tocFiles("src/KingsGambit/KingsGambit.toc")) do
            local chunk = assert(loadfile("src/KingsGambit/" .. f))
            chunk("KingsGambit", SK)
        end
        assert(SK.modules.Engine and SK.modules.Sync and SK.modules.LootNet and SK.modules.Commands, "modules registered")
        assert(env.SlashCmdList.KINGSGAMBIT, "slash command registered")
        eq(_G.SLASH_KINGSGAMBIT1, "/gambit"); eq(_G.SLASH_KINGSGAMBIT2, "/kg")

        local before = #printed
        env.SlashCmdList.KINGSGAMBIT("help")
        assert(printed[#printed]:find("not started"), "before login the addon says it has not started")

        local core = frames[1]
        assert(core.events.PLAYER_LOGIN, "Core waits for PLAYER_LOGIN")
        core.onEvent(core, "PLAYER_LOGIN")
        assert(SK.client and SK.engine and SK.sync and SK.host and SK.player and SK.commands, "everything was built at login")
        local ready = false
        for i = before + 1, #printed do if printed[i]:find("ready: 0 list") then ready = true end end
        assert(ready, "it reports it is ready: " .. table.concat(printed, " | "))
        assert(SK.sync.running, "sync started")

        printed = {}
        env.SlashCmdList.KINGSGAMBIT("create main The Main List")
        env.SlashCmdList.KINGSGAMBIT("add Aldric")
        env.SlashCmdList.KINGSGAMBIT("standings")
        local all = table.concat(printed, "\n")
        assert(all:find("Created list 'main'"), all); assert(all:find("main: 1 on the list"), all); assert(all:find("Aldric"), all)
        local _, c = next(_G.KingsGambitDB.ledger.chains); eq(#c.events, 3, "the ledger (Genesis, CreateList, AddMember) is in SavedVariables")
    end)
    for k in pairs(env) do _G[k] = saved[k] end
    for _, k in ipairs { "KingsGambit", "KingsGambitDB", "KingsGambitCharDB", "SLASH_KINGSGAMBIT1", "SLASH_KINGSGAMBIT2" } do _G[k] = nil end
    assert(ok, tostring(err))
end)
