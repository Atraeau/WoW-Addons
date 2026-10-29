-- King's Gambit tests. Run from the repo root:  lua tests/kings-gambit/run.lua
local H = dofile("tests/kings-gambit/harness.lua")
for _, f in ipairs { "test_ledger", "test_host", "test_client" } do
    assert(loadfile("tests/kings-gambit/" .. f .. ".lua"))(H)
end
print(("\n%d passed, %d failed"):format(H.passed, H.failed))
os.exit(H.failed == 0 and 0 or 1)
