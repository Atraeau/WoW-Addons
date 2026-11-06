-- Which list a raid plays on: an officer names it when the raid opens (the first choice stands), the ledger owner can require every raid to
-- have a list of its own, and a Master Looter writes only to their raid's list (and its off-spec list). Design journal: "a raid chooses its
-- list when it opens". The ledger rules first, then the engine, the loot session and the commands on top of them.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Ledger, MockClient, Engine, Loot, Commands = SK.modules.Ledger, SK.modules.MockClient, SK.modules.Engine, SK.modules.Loot, SK.modules.Commands

local function reasons(view)
    local out = {}
    for _, c in ipairs(view.conflicts) do out[#out + 1] = c.type .. ":" .. c.reason end
    return table.concat(out, " ")
end
local function has(view, what) return reasons(view):find(what, 1, true) ~= nil end

-- The usual guild (GM, officer Off, main = A..E) with a raid "r1" opened by Off for Looter at t=200.
local function raidWorld(policy)
    local w = H.ledgerGuild()
    if policy then w:write("GM", "SetListPolicy", { mode = policy }, 150) end
    w:write("Off", "Elevate", { raid = "r1", ml = "Looter", minutes = 240 }, 200)
    return w
end
local function award(w, list, ts) w:write("Looter", "Award", { member = "A", item = "Sword" }, ts or 300, list) end

H.section("Lists: a raid plays on one list")
test("a raid with no list named plays on main, and its Master Looter can't write to another list", function()
    local w = raidWorld()
    w:write("GM", "CreateList", { name = "Twenty" }, 160, "20man")
    award(w, "main")
    w:write("Looter", "AddMember", { member = "Z" }, 301, "20man")
    local v = w:view()
    assert(has(v, "AddMember:wronglist"), reasons(v))
    eq(v.lists.main.members.A.wins, 1); eq(v.lists["20man"].members.Z, nil)
end)

test("an officer names the list when the raid opens; then the Master Looter writes there and to its off-spec list, and nowhere else", function()
    local w = raidWorld()
    w:write("Off", "SetRaidList", { raid = "r1", list = "20man" }, 201)
    w:write("Looter", "CreateList", { name = "Twenty" }, 202, "20man")
    w:write("Looter", "AddMember", { member = "A" }, 203, "20man")
    w:write("Looter", "CreateList", { name = "Off-spec" }, 204, "20man-off")
    award(w, "20man", 300)
    award(w, "main", 301)
    w:write("Looter", "AddMember", { member = "Q" }, 302, "off")
    local v = w:view()
    eq(v.lists["20man"].members.A.wins, 1)
    eq(v.lists.main.members.A.wins, 0, "the award aimed at main was refused")
    assert(has(v, "Award:wronglist") and has(v, "AddMember:wronglist"), reasons(v))
    assert(v.lists["20man-off"], "the raid's own off-spec list is allowed")
    eq(v.auth.raids.r1.list, "20man")
end)

test("the first list named stands: a raid never changes list part-way through", function()
    local w = raidWorld()
    w:write("Off", "SetRaidList", { raid = "r1", list = "20man" }, 201)
    w:write("Off", "SetRaidList", { raid = "r1", list = "other" }, 202)
    local v = w:view()
    assert(has(v, "SetRaidList:listset"), reasons(v)); eq(v.auth.raids.r1.list, "20man")
end)

test("only an officer names a raid's list, for a raid that is running, with a valid id", function()
    local w = raidWorld()
    w:write("Looter", "SetRaidList", { raid = "r1", list = "mine" }, 201)
    w:write("Off", "SetRaidList", { raid = "nope", list = "mc" }, 202)
    for i, bad in ipairs { "Has Space", "UPPER", "off", "a-b", string.rep("x", 25) } do
        w:write("Off", "SetRaidList", { raid = "r1", list = bad }, 203 + i)
    end
    local v = w:view()
    assert(has(v, "SetRaidList:notofficer") and has(v, "SetRaidList:notactive") and has(v, "SetRaidList:badlistid"), reasons(v))
    eq(v.auth.raids.r1.list, nil, "none of them took effect")
end)

test("an officer outside a raid is not held to a list", function()
    local w = raidWorld()
    w:write("Off", "SetRaidList", { raid = "r1", list = "20man" }, 201)
    w:write("Off", "Revoke", { raid = "r1" }, 250)
    w:write("Off", "AddMember", { member = "Y" }, 260, "main")
    eq(w:view().lists.main.members.Y.active, true)
end)

H.section("Lists: the ledger owner can require one list per raid")
test("under the per-raid policy a raid has no default list, and its Master Looter can't write until one is named", function()
    local w = raidWorld("perraid")
    award(w, "main", 205)
    local v = w:view()
    assert(has(v, "Award:nolistchosen"), reasons(v))
    w:write("Off", "SetRaidList", { raid = "r1", list = "main" }, 206)
    assert(has(w:view(), "SetRaidList:needsownlist"))
    w:write("Off", "SetRaidList", { raid = "r1", list = "mc" }, 207)
    w:write("Looter", "CreateList", { name = "MC" }, 208, "mc")
    w:write("Looter", "AddMember", { member = "A" }, 209, "mc")
    award(w, "mc", 300)
    v = w:view()
    eq(v.lists.mc.members.A.wins, 1); eq(v.auth.raids.r1.list, "mc")
end)

test("only the ledger owner sets the policy, and only to a policy that exists", function()
    local w = raidWorld()
    w:write("Off", "SetListPolicy", { mode = "perraid" }, 210)
    w:write("GM", "SetListPolicy", { mode = "everything" }, 211)
    local v = w:view()
    assert(has(v, "SetListPolicy:notguildmaster") and has(v, "SetListPolicy:badpolicy"), reasons(v))
    eq(v.auth.policy, "choose")
end)

test("a raid keeps the policy it was opened under: changing it later never rewrites an earlier raid", function()
    local w = raidWorld()               -- r1 opened under "choose"
    w:write("GM", "SetListPolicy", { mode = "perraid" }, 210)
    award(w, "main", 300)               -- r1 still plays on main
    w:write("Off", "Elevate", { raid = "r2", ml = "Other", minutes = 240 }, 220)
    w:write("Other", "Award", { member = "B", item = "Axe" }, 301, "main")
    local v = w:view()
    eq(v.lists.main.members.A.wins, 1, "the earlier raid's award stands")
    assert(has(v, "Award:nolistchosen"), "the later raid needs its own list: " .. reasons(v))
    eq(v.auth.raids.r1.dedicated, nil); eq(v.auth.raids.r2.dedicated, true)
end)

H.section("Lists: the engine, a loot session and the commands")
local function solo()
    local client = MockClient.New({ name = "Raidlead" })
    local engine = Engine.New(client)
    engine:CreateList("main", "Main")
    for _, n in ipairs { "A", "B", "C", "D", "E" } do engine:Append("main", "AddMember", { member = n, class = "WARRIOR" }) end
    client:setRaid({ "A", "B", "C", "D", "E" }, { leader = "A", lootMethod = "master", masterLooter = "Raidlead" })
    return engine, client
end

test("a new list is created in the order of main when its raid's first session starts, and the session plays on it", function()
    local engine, client = solo()
    assert(engine:Append("main", "MovePlayer", { member = "E", to = "top", reason = "test" }))
    assert(engine:Write("Elevate", { raid = "r1", ml = "Raidlead", minutes = 240 }))
    assert(engine:Write("SetRaidList", { raid = "r1", list = "20man" }))
    eq(engine:RaidList(), "20man"); eq(engine:Get("20man"), nil, "not created yet")
    client:dropLoot({ { link = "item:1" } })
    local s = Loot.NewSession(engine)
    assert(s:start({ { link = "item:1", slot = 1 } }))
    eq(table.concat(engine:Get("20man").state.order, ","), "E,A,B,C,D", "seeded in main's order, wins and passes level")
    assert(s:bid("E", 1, "need")); for _, n in ipairs { "A", "B", "C", "D" } do assert(s:bid(n, 1, "pass")) end
    assert(s:confirm())
    eq(table.concat(engine:Get("20man").state.order, ","), "A,B,C,D,E", "the winner drops to the bottom of THIS list")
    eq(table.concat(engine:Get("main").state.order, ","), "E,A,B,C,D", "main is untouched")
    eq(engine:Get("20man").state.members.E.wins, 1); eq(engine:Get("main").state.members.E.wins, 0)
end)

test("a session under the per-raid policy won't start until the raid has a list", function()
    local engine, client = solo()
    assert(engine:Write("SetListPolicy", { mode = "perraid" }))
    assert(engine:Write("Elevate", { raid = "r1", ml = "Raidlead", minutes = 240 }))
    client:dropLoot({ { link = "item:1" } })
    local ok, why = Loot.NewSession(engine):start({ { link = "item:1", slot = 1 } })
    eq(ok, false); eq(why, "nolistchosen")
    assert(engine:Write("SetRaidList", { raid = "r1", list = "mc" }))
    assert(Loot.NewSession(engine):start({ { link = "item:1", slot = 1 } }))
end)

test("raid open ... list <id> opens the raid on that list; policy and list commands", function()
    local engine, client = solo()
    local cmd = Commands.New({ client = client, engine = engine })
    local function run(line) client.printed = {}; cmd.handle(line); return table.concat(client.printed, "\n") end
    local out = run("raid open Raidlead 2 list 20man")
    assert(out:find("20man"), out)
    eq(engine:RaidList(), "20man")
    assert(run("raid list"):find("20man"))
    assert(run("raid list other"):find("already"), "the list can't change once named")
    run("raid close")
    assert(run("raid policy perraid"):find("own"), "the ledger owner sets the policy")
    assert(run("raid open Raidlead 2"):find("requires a list"), "a raid can't be opened without a list now")
    assert(run("raid open Raidlead 2 list main"):find("main"), "a raid on main is refused under the policy")
    assert(run("raid policy"):find("perraid"))
end)

test("list use picks the list manual commands change; the default follows your raid", function()
    local engine, client = solo()
    local cmd = Commands.New({ client = client, engine = engine })
    local function run(line) client.printed = {}; cmd.handle(line); return table.concat(client.printed, "\n") end
    engine:CreateList("20man"); engine:Append("20man", "AddMember", { member = "A" })
    assert(run("list use 20man"):find("Working on 20man"))
    run("add Z bottom")
    assert(engine:Get("20man").state.members.Z, "added to the working list")
    eq(engine:Get("main").state.members.Z, nil)
    assert(run("list use"):find("main"))
end)
