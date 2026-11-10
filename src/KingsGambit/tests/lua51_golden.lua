-- The ledger under the GAME'S Lua. WoW runs Lua 5.1 (all numbers are doubles, no integer type), while the test suite runs on a newer Lua, so a hash or a replay that
-- only holds on the newer one would pass every test and still break every guild in game. This script is standalone and written in plain Lua 5.1, so CI can run it
-- under lua5.1 and LuaJIT as well as the newer Lua:
--
--   lua5.1 tests/lua51_golden.lua      luajit tests/lua51_golden.lua      lua tests/lua51_golden.lua      (from src/KingsGambit)
--
-- It checks the three things everyone's ledger depends on: the hash algorithm and the canonical text it hashes (golden values, so a different number formatting
-- or integer overflow would show), the documented worked example, and the frozen golden ledger of every published format (loaded, every hash verified, replayed to the
-- standings it was frozen with, every entry checked against its schema).
local SK = {}
local passed = 0
local function check(cond, what, detail)
    if not cond then
        io.stderr:write("FAIL " .. what .. (detail and (": " .. tostring(detail)) or "") .. "\n")
        os.exit(1)
    end
    passed = passed + 1
    print("  ok   " .. what)
end
local function same(got, want, what) check(got == want, what, "expected " .. tostring(want) .. ", got " .. tostring(got)) end

local FOLDER = { Registry = "core", Hash = "ledger", Identity = "ledger", Version = "ledger", Schemas = "ledger", Migrations = "ledger", Standings = "ledger", Ledger = "ledger" }
local function load(name)
    local chunk = assert(loadfile("src/" .. FOLDER[name] .. "/" .. name .. ".lua"))
    chunk("KingsGambit", SK)
end
load("Registry")
for _, name in ipairs { "Hash", "Identity", "Version", "Schemas", "Migrations", "Standings", "Ledger" } do load(name) end
SK:Resolve()
local Hash, Ledger, Schemas = SK.modules.Hash, SK.modules.Ledger, SK.modules.Schemas

print("Lua: " .. tostring(_VERSION) .. (jit and (" (" .. jit.version .. ")") or ""))

-- the hash, locked by values computed on other runtimes
same(Hash.Sum("hello Fenn-Realm"), "3dcf24964da09ca2", "hash of a short string")
same(Hash.Sum("hello Zed-Realm"), "0dda1aa26cc53a36", "hash of another short string")
same(Hash.Sum(""), "811c9dc59e3779b1", "hash of the empty string")
same(Hash.Sum("abc"), "1a47e90bdf63f96f", "hash of abc")

-- the canonical text: whole numbers are the same whether the runtime calls them integers or floats, and large ones survive
same(Hash.Canon({ n = 1 }), Hash.Canon({ n = 1.0 }), "1 and 1.0 canonicalize alike")
same(Hash.Canon({ n = 2147483653 }), "{s1:n=n2147483653,}", "a number past 2^31 keeps every digit")
same(Hash.Canon({ n = 1760000000 }), "{s1:n=n1760000000,}", "a server time")
same(Hash.Canon({ a = "1" }) ~= Hash.Canon({ a = 1 }), true, "a string and a number differ")

-- the documented worked example (docs/ledger-format.md)
do
    local store = Ledger.NewStore()
    local function w(author, epoch, t, d, ts, list)
        local ev = assert(Ledger.Build(store, author .. "#" .. epoch, author, t, d, ts, list))
        assert(Ledger.Receive(store, ev))
        return ev
    end
    local g = w("Guildmaster-Realm", "1a2b3c4d", "Genesis", { name = "Guild ledger" }, 1760000000)
    same(g.id, "89cf69b1d9689705", "the worked example's first event id")
    same(w("Guildmaster-Realm", "1a2b3c4d", "CreateList", { name = "Main" }, 1760000010, "main").id, "2e3878a6c2111092", "its second event id")
    w("Guildmaster-Realm", "1a2b3c4d", "AddMember", { member = "Aldric-Realm" }, 1760000020, "main")
    w("Guildmaster-Realm", "1a2b3c4d", "AddMember", { member = "Brann-Realm" }, 1760000030, "main")
    w("Guildmaster-Realm", "1a2b3c4d", "Elevate", { raid = "thu-1", ml = "Looter-Realm", minutes = 360 }, 1760000100)
    local aw = w("Looter-Realm", "5e6f7a8b", "Award", { member = "Aldric-Realm", item = "Gauntlets of the Ashen Vow" }, 1760000200, "main")
    same(aw.id, "07c2ae4df2d4dc39", "its award's event id")
    same(table.concat(Ledger.View(store).lists.main.order, ","), "Brann-Realm,Aldric-Realm", "its standings after replay")
    same(Ledger.Fingerprint(store), "2cc0444c8382fd78", "its ledger fingerprint")
end

-- the golden ledger of every published format
local function golden(path, format)
    local chunk = assert(loadfile(path))
    local g = chunk()
    check(g.format == format, path .. " is format " .. format)
    local store, problems = Ledger.LoadStore(g.ledger) -- no verify limit: every hash is recomputed
    check(next(problems) == nil, "format " .. format .. " golden ledger: every chain loads and every hash verifies")
    same(Ledger.Fingerprint(store), g.expect.fingerprint, "format " .. format .. " golden ledger: the same chains and heads")
    local view = Ledger.View(store)
    same(#view.conflicts, 0, "format " .. format .. " golden ledger: nothing is refused on replay")
    same(#view.applied, g.expect.applied, "format " .. format .. " golden ledger: the same number of entries applied")
    for id, want in pairs(g.expect.lists) do
        local s = view.lists[id]
        check(s ~= nil, "format " .. format .. " golden ledger: list " .. id .. " exists")
        same(table.concat(s.order, ","), table.concat(want.order, ","), "format " .. format .. " golden ledger: standings of " .. id)
        for name, m in pairs(want.members) do
            local got = s.members[name]
            check(got ~= nil and got.wins == m.wins and got.passes == m.passes and got.active == m.active,
                "format " .. format .. " golden ledger: " .. id .. " record of " .. name)
        end
    end
    local n = 0
    for _, chain in pairs(g.ledger.chains) do
        for _, ev in ipairs(chain.events) do
            local ok, why = Schemas.Validate(format, ev)
            if not ok then check(false, "format " .. format .. " golden ledger: an entry matches its schema", ev.type .. ": " .. tostring(why)) end
            n = n + 1
        end
    end
    check(n > 0, "format " .. format .. " golden ledger: all " .. n .. " entries match their schema")
end
golden("tests/ledgers/format_2.lua", 2)

print(("\n%d checks passed under %s"):format(passed, tostring(_VERSION)))
