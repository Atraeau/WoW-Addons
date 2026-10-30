-- Shared test harness: loads the addon modules the way WoW does (addonName, namespace).
local H = { passed = 0, failed = 0 }
-- The registry first; the modules in any order (they declare their dependencies; see Registry.lua).
H.MODULES = { "Hash", "Standings", "Ledger", "Client", "MockClient", "RealClient", "Engine", "ItemFit", "Loot", "SimNetwork", "Sync",
    "LootNet", "Requests", "Commands", "MoltenCore", "AQ40", "Tokens", "Sim", "Scenarios" }
function H.load(files)
    local SK = {}
    assert(loadfile("src/Registry.lua"))("KingsGambit", SK)
    for _, f in ipairs(files or H.MODULES) do
        assert(loadfile("src/" .. f .. ".lua"))("KingsGambit", SK)
    end
    return SK
end
local SK = H.load()
SK:Resolve()
H.SK = SK
-- A loot session refuses to start until a disenchanter is designated (the raid's Master Looter does that, in the
-- ledger). Most tests are about other rules, so by default their sessions get one (the local player); the tests
-- about the requirement itself use H.rawNewSession, which has no default.
H.rawNewSession = SK.modules.Loot.NewSession
SK.modules.Loot.NewSession = function(engine, opts)
    local o = {}
    for k, v in pairs(opts or {}) do o[k] = v end
    if o.deHandler == nil and not engine:RaidDisenchanter() then o.deHandler = engine.client:me() end
    return H.rawNewSession(engine, o)
end

function H.section(name) print(name) end

function H.test(name, fn)
    local ok, err = pcall(fn)
    if ok then H.passed = H.passed + 1; print("  ok   " .. name)
    else H.failed = H.failed + 1; print("  FAIL " .. name .. "\n       " .. tostring(err)) end
end

function H.eq(a, b, msg)
    if a ~= b then error((msg or "eq") .. ": expected " .. tostring(b) .. ", got " .. tostring(a), 2) end
end

return H
