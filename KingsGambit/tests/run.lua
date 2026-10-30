-- King's Gambit tests. Run from the KingsGambit folder:  lua tests/run.lua
local H = dofile("tests/harness.lua")
for _, f in ipairs { "test_modules", "test_ledger", "test_client", "test_realclient", "test_engine", "test_loot", "test_sync", "test_sim", "test_tokens", "test_itemfit", "test_fuzz", "test_fuzz_loot", "test_fuzz_rules", "test_tools", "test_lootnet", "test_commands", "test_requests", "test_mistakes", "test_boot" } do
    assert(loadfile("tests/" .. f .. ".lua"))(H)
end
print(("\n%d passed, %d failed"):format(H.passed, H.failed))
os.exit(H.failed == 0 and 0 or 1)
