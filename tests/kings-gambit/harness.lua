-- Shared test harness: loads the addon modules the way WoW does (addonName, namespace).
local H = { passed = 0, failed = 0 }
-- The registry first; the modules in any order (they declare their dependencies; see Registry.lua).
H.MODULES = { "Hash", "Standings", "Ledger", "Client", "MockClient", "RealClient", "Engine", "Loot", "SimNetwork", "Sync",
    "LootNet", "Requests", "Commands", "MoltenCore", "AQ40", "Tokens", "Sim", "Scenarios" }
function H.load(files)
    local SK = {}
    assert(loadfile("src/KingsGambit/Registry.lua"))("KingsGambit", SK)
    for _, f in ipairs(files or H.MODULES) do
        assert(loadfile("src/KingsGambit/" .. f .. ".lua"))("KingsGambit", SK)
    end
    return SK
end
local SK = H.load()
SK:Resolve()
H.SK = SK

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
