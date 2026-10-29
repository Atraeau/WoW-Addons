-- Engine tests: persistence over a Client, isolation between engines.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local MockClient, Engine = SK.modules.MockClient, SK.modules.Engine

local function newClient(name) return MockClient.New({ name = name or "Raidlead", realm = "Realm" }) end

H.section("Engine")
test("CreateList and Append use the Client's identity and clock", function()
    local h = newClient()
    local c = Engine.New(h)
    assert(c:CreateList("main", "Main"))
    h:advance(30)
    local ev = assert(c:Append("main", "AddMember", { member = "Aldric-Realm" }))
    eq(ev.author, "Raidlead-Realm"); eq(ev.ts, h:serverTime()); eq(ev.seq, 2)
    local _, err = c:CreateList("main", "Again"); eq(err, "exists")
    local _, err2 = c:Append("nope", "AddMember", {}); eq(err2, "nolist")
end)
test("a rebuilt engine restores the same chain from storage (simulated /reload)", function()
    local h = newClient()
    local c = Engine.New(h)
    c:CreateList("main", "Main")
    for _, n in ipairs { "A-Realm", "B-Realm", "C-Realm" } do c:Append("main", "AddMember", { member = n }) end
    c:Append("main", "Award", { member = "A-Realm", item = "Sword" })
    local head = c:Get("main").head
    h:reload()
    local c2 = Engine.New(h)
    eq(c2:Get("main").head, head)
    eq(table.concat(c2:Get("main").state.order, ","), "B-Realm,C-Realm,A-Realm")
    local ev = assert(c2:Append("main", "AddMember", { member = "D-Realm" }))
    eq(ev.seq, 6)
end)
test("tampered storage is reported and left untouched", function()
    local h = newClient()
    local c = Engine.New(h)
    c:CreateList("main", "Main"); c:Append("main", "AddMember", { member = "A-Realm" })
    h:storage().account.lists.main.events[2].data.member = "Evil-Realm"
    h:reload()
    local c2 = Engine.New(h)
    eq(c2:Get("main"), nil); eq(c2.problems.main.reason, "badhash"); eq(c2.problems.main.index, 2)
    eq(h:storage().account.lists.main.events[2].data.member, "Evil-Realm", "storage must not be repaired silently")
    assert(#h.printed == 1)
    local _, err = c2:CreateList("main", "Replacement"); eq(err, "exists")
end)
test("engines are isolated (no shared module state)", function()
    local a, b = Engine.New(newClient("Raidlead")), Engine.New(newClient("Other"))
    a:CreateList("main", "Main")
    eq(b:Get("main"), nil)
    assert(b:CreateList("main", "Main"))
    eq(#a:Get("main").events, 1); eq(#b:Get("main").events, 1)
    assert(a:Get("main") ~= b:Get("main"))
end)
