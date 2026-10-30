-- The module registry: modules declare their dependencies and receive them once every file has loaded, so the
-- order files load in doesn't matter. A missing dependency or a cycle stops startup with a clear error.
local H = ...
local test, eq = H.test, H.eq

-- Run a few modules end to end: a list, an award, a request described, a token looked up.
local function smoke(SK)
    local M = SK.modules
    local client = M.MockClient.New({ name = "Raidlead", realm = "Realm" })
    local engine = M.Engine.New(client)
    assert(engine:CreateList("main", "Main"))
    assert(engine:Append("main", "AddMember", { member = "A-Realm" }))
    assert(engine:Append("main", "AddMember", { member = "B-Realm" }))
    assert(engine:Append("main", "Award", { member = "A-Realm", item = "X" }))
    eq(table.concat(engine:Get("main").state.order, ","), "B-Realm,A-Realm")
    eq(M.Requests.Describe({ kind = "move", member = "A-Realm", pos = "top" }), "move A to the top")
end

local function shuffled(list, seed)
    local out = {}
    for i, v in ipairs(list) do out[i] = v end
    local x = seed
    for i = #out, 2, -1 do
        x = (x * 16807) % 2147483647
        local j = x % i + 1
        out[i], out[j] = out[j], out[i]
    end
    return out
end

H.section("Modules: dependency injection")
test("modules load in any order: reversed, and shuffled", function()
    local reversed = {}
    for i = #H.MODULES, 1, -1 do reversed[#reversed + 1] = H.MODULES[i] end
    for _, files in ipairs { reversed, shuffled(H.MODULES, 3), shuffled(H.MODULES, 11) } do
        local SK = H.load(files)
        SK:Resolve()
        smoke(SK)
    end
end)

test("each module is given its dependencies after they have been given theirs", function()
    local order = H.load():Resolve()
    local at = {}
    for i, name in ipairs(order) do at[name] = i end
    assert(at.Hash < at.Standings and at.Standings < at.Ledger and at.Ledger < at.Engine, table.concat(order, ","))
    assert(at.Loot < at.LootNet and at.Standings < at.Requests, table.concat(order, ","))
end)

test("a missing dependency stops startup and names it", function()
    local SK = H.load({ "Hash", "Ledger" }) -- Ledger needs Standings
    local ok, err = pcall(SK.Resolve, SK)
    eq(ok, false); assert(tostring(err):find("module Ledger needs Standings, which is not loaded"), err)
end)

test("a dependency cycle stops startup and shows it", function()
    local SK = H.load({})
    SK:NewModule("A", { "B" }); SK:NewModule("B", { "C" }); SK:NewModule("C", { "A" })
    local ok, err = pcall(SK.Resolve, SK)
    eq(ok, false); assert(tostring(err):find("module dependency cycle: A %-> B %-> C %-> A"), err)
end)

test("raid data is optional: without it tokens are simply unknown", function()
    local files = {}
    for _, f in ipairs(H.MODULES) do
        if f ~= "AQ40" and f ~= "MoltenCore" and f ~= "Sim" and f ~= "Scenarios" then files[#files + 1] = f end
    end
    local SK = H.load(files)
    SK:Resolve()
    smoke(SK)
    eq(SK.modules.Tokens.Find("|Hitem:20928::::::::60:::::|h[Qiraji Bindings of Command]|h"), nil)
end)

test("no module looks other modules up itself (only the composition roots do)", function()
    for _, f in ipairs(H.MODULES) do
        local src = io.open("src/" .. f .. ".lua"):read("a")
        assert(not src:find("SK%.modules"), f .. ".lua reads SK.modules: declare the dependency instead")
    end
end)
