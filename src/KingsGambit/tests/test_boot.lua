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
    local a, b = tocFiles("src/KingsGambit.toc"), tocFiles("src/KingsGambit_Camelot.toc")
    eq(table.concat(a, ","), table.concat(b, ","), "the two TOCs have drifted apart")
    for _, f in ipairs(a) do
        local fh = io.open("src/" .. f, "r")
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
        for _, f in ipairs(tocFiles("src/KingsGambit.toc")) do
            local chunk = assert(loadfile("src/" .. f))
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
        for i = before + 1, #printed do if printed[i]:find("ready: there is no ledger") then ready = true end end
        assert(ready, "it reports it is ready: " .. table.concat(printed, " | "))
        assert(SK.sync.running, "sync started")

        printed = {}
        env.SlashCmdList.KINGSGAMBIT("create main The Main List")
        env.SlashCmdList.KINGSGAMBIT("add Aldric")
        env.SlashCmdList.KINGSGAMBIT("standings")
        local all = table.concat(printed, "\n")
        assert(all:find("Created list 'main'"), all); assert(all:find("main: 1 on the list"), all); assert(all:find("Aldric"), all)
        local _, world = next(_G.KingsGambitDB.worlds)
        local _, c = next(world.ledger.chains); eq(#c.events, 3, "the ledger (Genesis, CreateList, AddMember) is in SavedVariables")
    end)
    for k in pairs(env) do _G[k] = saved[k] end
    for _, k in ipairs { "KingsGambit", "KingsGambitDB", "KingsGambitCharDB", "SLASH_KINGSGAMBIT1", "SLASH_KINGSGAMBIT2" } do _G[k] = nil end
    assert(ok, tostring(err))
end)

-- The files on disk, relative to src/ (nil when the platform can't list a folder).
local function srcFiles()
    if not io.popen then return nil end
    local windows = package.config:sub(1, 1) == "\\"
    local p = io.popen(windows and "dir /b /s src\\*.lua 2>nul" or "find src -name '*.lua' 2>/dev/null")
    if not p then return nil end
    local out = {}
    for line in p:lines() do
        line = line:gsub("\r", ""):gsub("\\", "/")
        local rel = line:match("^.*src/(.+%.lua)$")
        if rel then out[#out + 1] = rel end
    end
    p:close()
    return out
end

test("every Lua file under src/ is in the TOC (nothing is left out of the game), and the code map names each one", function()
    local files = srcFiles()
    if not files then return end
    local listed = {}
    for _, f in ipairs(tocFiles("src/KingsGambit.toc")) do listed[f] = true end
    assert(#files > 0, "the file listing found nothing")
    for _, f in ipairs(files) do assert(listed[f], f .. " is under src/ but not in the TOC") end
    local map = assert(io.open("docs/code-map.md", "rb")):read("a")
    for f in pairs(listed) do
        local base = f:match("([^/]+)$")
        assert(map:find(base, 1, true), "docs/code-map.md does not mention " .. f)
    end
end)

test("the simulator page inlines a dependency-complete set of real files, each in the TOC", function()
    local text = assert(io.open("scripts/build-simulator.lua", "rb")):read("a")
    local list = assert(text:match("local MODULES = {(.-)}"), "MODULES not found in scripts/build-simulator.lua")
    local listed = {}
    for _, f in ipairs(tocFiles("src/KingsGambit.toc")) do listed[f] = true end
    local SK = {}
    assert(loadfile("src/core/Registry.lua"))("KingsGambit", SK)
    local n = 0
    for path in list:gmatch('"([^"]+)"') do
        n = n + 1
        assert(listed[path .. ".lua"], "the simulator build lists " .. path .. ", which is not in the TOC")
        assert(loadfile("src/" .. path .. ".lua"))("KingsGambit", SK)
    end
    assert(n > 20, "the simulator module list looks empty")
    local ok, err = pcall(SK.Resolve, SK) -- a part or a dependency missing from the page's list stops here, as it would in the browser
    assert(ok, tostring(err))
end)

test("the text interface installs every command (a split-up Commands lost none)", function()
    local SK = H.load()
    SK:Resolve()
    local MockClient, Engine, Commands = SK.modules.MockClient, SK.modules.Engine, SK.modules.Commands
    local client = MockClient.New({ name = "Raidlead" })
    local c = Commands.New({ client = client, engine = Engine.New(client) })
    for _, name in ipairs { "help", "migrate", "version", "standings", "list", "create", "newlist", "add", "addall", "remove", "move", "undo", "award", "trade",
        "disenchanted", "salvaged", "masterloot", "loot", "announce", "resolve", "extend", "confirm", "cancel", "need", "off", "pass", "gift", "bid", "ready", "rank",
        "pick", "skip", "recipient", "override", "keep", "withdraw", "claim", "disenchanter", "raid", "ledgers", "officers", "disregard", "regard", "request",
        "requests", "accept", "decline", "history", "eligible", "suits", "spec", "hints", "sync", "check" } do
        assert(type(c.commands[name]) == "function", "the command '" .. name .. "' is missing")
    end
end)

test("Emitter: listeners get what is emitted, can stop listening, and a listener added during an emit waits for the next one", function()
    local SK = H.load()
    SK:Resolve()
    local ev = SK.modules.Emitter.New()
    local got = {}
    local off = ev.on("x", function(p) got[#got + 1] = "a" .. p end)
    ev.on("x", function(p) got[#got + 1] = "b" .. p; ev.on("x", function(q) got[#got + 1] = "late" .. q end) end)
    ev.emit("x", 1)
    eq(table.concat(got, ","), "a1,b1")
    off(); got = {}
    ev.emit("x", 2)
    eq(table.concat(got, ","), "b2,late2", "the stopped listener is silent; the one added during the first emit hears the second")
    ev.emit("nobody listens", 3)
end)
