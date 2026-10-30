-- Randomized loot-session test: random raids, drops and bot behaviour. For every seed the session
-- must finish, and the ledger it writes must satisfy invariants checked independently of the
-- session's own code. A failing seed is reproducible: it is the only input.
local H = ...
local SK, test, eq = H.SK, H.test, H.eq
local Sim, Standings = SK.modules.Sim, SK.modules.Standings

local function rng(seed)
    local s = (seed * 104729 + 7) % 2147483647 + 0.0
    return function(n)
        s = (s * 16807) % 2147483647
        return n and (math.floor(s / 2147483647 * n) + 1) or (s / 2147483647)
    end
end

local NAMES = { "Aldric", "Brann", "Cass", "Dara", "Eira", "Fenn", "Garo", "Hale", "Ilsa", "Jory" }
local ITEMS = { "Helm", "Cloak", "Ring", "Staff", "Boots", "Belt" }

local function short(n) return (n:gsub("%-.*$", "")) end

local function moveToBottom(order, name)
    for i = 1, #order do
        if order[i] == name then table.remove(order, i); break end
    end
    order[#order + 1] = name
end

local function run(seed)
    local r = rng(seed)
    local count = 3 + r(7) - 1 -- 3..9 players besides You
    local members = {}
    for i = 1, count do members[i] = NAMES[i] end
    local nitems = r(4)
    local links = {}
    for i = 1, nitems do links[i] = ITEMS[i] end

    local sim = Sim.NewRaid({ members = members, seed = seed, learner = "You", shuffle = r() < 0.5 })
    sim.autoLearner = true
    for _, name in ipairs(members) do
        local p = { bid = {}, claim = r() < 0.4, skip = r() < 0.2 }
        if r() < 0.5 then p.pick = { links[r(nitems)] } end
        for _, link in ipairs(links) do
            local x = r()
            if x < 0.30 then p.bid[link] = "need"
            elseif x < 0.45 then p.bid[link] = "off"
            elseif x < 0.52 then
                local target = members[r(count)]
                p.bid[link] = (target ~= name) and { "gift", to = target } or "need"
            elseif x < 0.58 then p.bid[link] = { "pass", passKind = "upgrade" }
            else p.bid[link] = "pass" end
        end
        sim.policies[name] = p
    end
    sim.policies["You"] = { claim = r() < 0.3 }

    local startOrder = sim:order()
    assert(sim:drop(links), "session did not start")
    assert(sim:runUntil("review", 600), "session never reached review (stuck in " .. sim.session.phase .. ")")
    local session = sim.session

    -- Independent expectation of the new order, from the pending awards alone.
    local expectMain, expectOff = {}, nil
    for i, n in ipairs(sim.engine:Get("main").state.order) do expectMain[i] = n end
    local offBefore = sim.engine:Get("off")
    expectOff = offBefore and { table.unpack and table.unpack(offBefore.state.order) } or nil
    local awards, des, enrolls = {}, {}, {}
    for _, a in ipairs(session.pending) do
        if a.type == "award" then awards[#awards + 1] = a
        elseif a.type == "disenchant" then des[#des + 1] = a
        elseif a.type == "enroll" then enrolls[#enrolls + 1] = a end
    end

    local ok, failures = session:confirm()
    assert(ok, "confirm refused")
    eq(#failures, 0, "no hand-out failures expected (every drop is open to the whole raid)")

    -- 1. every item ends in exactly one terminal state
    local nAwarded, nDe = 0, 0
    for _, it in ipairs(session.items) do
        assert(it.status == "awarded" or it.status == "de", "item " .. it.link .. " ended " .. tostring(it.status))
        if it.status == "awarded" then nAwarded = nAwarded + 1 else nDe = nDe + 1 end
    end
    eq(#awards, nAwarded, "one pending award per awarded item"); eq(#des, nDe, "one disenchant per unwanted item")

    -- 2. the ledger recorded exactly those events
    local main, off = sim.engine:Get("main"), sim.engine:Get("off")
    local mainAwards, offAwards = {}, {}
    for _, ev in ipairs(main.events) do if ev.type == "Award" then mainAwards[#mainAwards + 1] = ev end end
    if off then for _, ev in ipairs(off.events) do if ev.type == "Award" then offAwards[#offAwards + 1] = ev end end end
    local wantMain, wantOff = {}, {}
    for _, a in ipairs(awards) do if a.list == "main" then wantMain[#wantMain + 1] = a else wantOff[#wantOff + 1] = a end end
    eq(#mainAwards, #wantMain, "main Award events"); eq(#offAwards, #wantOff, "off Award events")

    -- 3. positions: only winners moved, each to the bottom in award order
    local expect = {}
    for i, n in ipairs(startOrder) do expect[i] = n .. "-Realm" end
    for _, a in ipairs(wantMain) do moveToBottom(expect, a.member) end
    local actual = main.state.order
    eq(#actual, #expect, "main list membership unchanged")
    for i = 1, #expect do eq(actual[i], expect[i], "main position " .. i) end

    -- 4. the off list: enrolled newcomers in main order, winners moved to the bottom
    if off then
        local eo = {}
        for _, e in ipairs(enrolls) do eo[#eo + 1] = e.member end
        for _, a in ipairs(wantOff) do moveToBottom(eo, a.member) end
        eq(#off.state.order, #eo, "off list size")
        for i = 1, #eo do eq(off.state.order[i], eo[i], "off position " .. i) end
    else
        eq(#wantOff, 0, "no off-spec awards without an off list")
    end

    -- 5. every award was handed to its recipient, and no item twice
    local given = {}
    for _, g in ipairs(sim.client.given) do
        assert(not given[g.slot], "slot " .. g.slot .. " given twice"); given[g.slot] = g.to
    end
    for _, a in ipairs(awards) do eq(given[a.item.slot], a.to, "hand-out of " .. a.item.link) end
    for _, d in ipairs(des) do eq(given[d.item.slot], d.to, "disenchant hand-out of " .. d.item.link) end

    -- 6. replaying the stored events gives the live standings
    for _, chain in ipairs(off and { main, off } or { main }) do
        local replayed = SK.modules.Ledger.View(sim.engine.store).lists[chain.id]
        eq(Standings.Digest(replayed), Standings.Digest(chain.state), "replay matches live state")
    end
    return sim.engine:Get("main").head
end

H.fuzzLootRun = run
H.section("Fuzz: loot sessions under random raids and bot behaviour")
local SEEDS = 60
for seed = 1, SEEDS do
    test("seed " .. seed .. ": session finishes and the ledger obeys the rules", function()
        local a = run(seed)
        eq(a, run(seed), "same seed, same ledger")
    end)
end
