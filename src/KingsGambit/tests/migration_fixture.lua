-- A SIMULATED breaking change to the ledger, used to evaluate the migration strategy (tests/test_migration.lua). It is a fixture: it is never
-- shipped, and there is no real format 3. It describes a hypothetical next release whose format differs from format 2 in the two ways
-- real changes do:
--
--   structural: Award's `member` and `to` are renamed `winner` and `recipient`;
--   semantic:   a new member with no stated position goes to the TOP of the list (format 2: the bottom).
--
-- A correct migration keeps both honest: an old Award means what it always meant, and an old AddMember with no position still lands at the
-- bottom, because its upcaster makes the old default explicit. Variants break that on purpose, to check the migration notices.
local SK = ...
local Standings, Migrations = SK.modules.Standings, SK.modules.Migrations

local function copy(t) local o = {} for k, v in pairs(t) do o[k] = v end return o end

-- variant: nil (correct), "forgetdefault" (the upcaster forgets to make the old default explicit), "dropawards" (it refuses old awards)
return function(variant)
    local base = Standings.HANDLERS
    local handlers = copy(base)

    -- format 3's own reading of the two events that changed
    handlers.Award = function(s, ev, d)
        local d2 = copy(d)
        d2.member, d2.to = d.winner, d.recipient
        d2.winner, d2.recipient = nil, nil
        return base.Award(s, ev, d2)
    end
    handlers.AddMember = function(s, ev, d)
        if d.to == nil and d.above == nil then d = copy(d); d.to = "top" end
        return base.AddMember(s, ev, d)
    end

    -- format 2 -> 3: same meaning, new shape; the old default is written down
    local function up2(ev)
        local d = copy(ev.data)
        if ev.type == "Award" then
            if variant == "dropawards" then return nil, "refused" end
            d.winner, d.recipient = d.member, d.to
            d.member, d.to = nil, nil
        elseif ev.type == "AddMember" and d.to == nil and d.above == nil and variant ~= "forgetdefault" then
            d.to = "bottom"
        end
        return Migrations.Derive(ev, { data = d })
    end

    -- format 3 -> 2: to write the old format while the ledger has not moved yet
    local function down3(ev)
        local d = copy(ev.data)
        if ev.type == "Award" then
            d.member, d.to = d.winner, d.recipient
            d.winner, d.recipient = nil, nil
        elseif ev.type == "AddMember" and d.to == nil and d.above == nil then
            d.to = "top" -- format 3's default, made explicit for readers who only know format 2
        end
        return Migrations.Derive(ev, { data = d })
    end

    return { current = 3, read = { [2] = true, [3] = true }, upcast = { [2] = up2 }, downcast = { [3] = down3 }, handlers = handlers,
        name = "simulated format 3" .. (variant and (" (" .. variant .. ")") or "") }
end
