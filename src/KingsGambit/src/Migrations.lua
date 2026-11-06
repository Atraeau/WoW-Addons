-- King's Gambit: migrating the ledger between formats. Pure Lua. Keep this file Lua 5.1-safe.
--
-- The ledger is never rewritten: every event keeps the format (`v`) it was written in, so every hash and every chain still verifies,
-- however old. A format change instead ships as code that can READ the old format: for each old format an UPCASTER maps an event of that
-- format to the equivalent event of the next, and the replay runs every event through the chain of upcasters to the newest
-- format before applying it. An upcaster is a pure function of one event. It must make the old MEANING explicit wherever the new rules
-- would decide differently (a default that changed becomes an explicit value), so a past outcome is never re-decided: nobody's place
-- moves because the rules did. The ledger itself carries the proof: the ledger keeper's `Migrate` entry (Ledger.lua) holds a digest of
-- the standings the old history produces, and every client checks that its own replay of that history, through its own upcasters,
-- produces the same digest.
--
-- While the ledger is still in an older format than a client's newest, the client WRITES the ledger's format: a downcaster maps what
-- the code builds (the newest shape) to the older one. A change a downcaster cannot express is refused until the cutover.
--
-- What this build understands is a RULESET:
--   current  = N                the newest format; the shape the code works in
--   read     = { [f] = true }   every format it can read: from the oldest it still keeps, up to `current`
--   upcast   = { [f] = fn }     event of format f -> event of format f+1, for every readable f below `current`
--   downcast = { [f] = fn }     event of format f -> event of format f-1 (only to write an older ledger; may be partial)
--   handlers = table | nil      the list-event handlers of format `current` (nil: Standings' own)
-- Both kinds of function take an event and return a NEW event (never touching the stored one): use Migrations.Derive. They return nil + why
-- for an event they cannot map.
local _, SK = ...
local Hash
local M = SK:NewModule("Migrations", { "Hash" }, function(d) Hash = d.Hash end)

M.BASE = 2 -- the first format there was; every ledger starts in it

-- What the released addon understands today: format 2, and nothing older or newer.
M.Default = { current = 2, read = { [2] = true }, upcast = {}, downcast = {}, name = "format 2" }

-- A copy of `ev` with some fields replaced (and `v` untouched: the caller says what it is).
function M.Derive(ev, changes)
    local out = {}
    for k, v in pairs(ev) do out[k] = v end
    for k, v in pairs(changes or {}) do out[k] = v end
    return out
end

-- Is a ruleset well formed? true, or nil + why. Every readable format below `current` needs an upcaster.
function M.Check(rules)
    if type(rules) ~= "table" or type(rules.current) ~= "number" then return nil, "nocurrent" end
    if type(rules.read) ~= "table" or not rules.read[rules.current] then return nil, "cannotreadcurrent" end
    for f in pairs(rules.read) do
        if f > rules.current then return nil, "readsnewerthancurrent" end
        if f < rules.current and type(rules.upcast[f]) ~= "function" then return nil, "noupcaster:" .. f end
        if f < rules.current and not rules.read[f + 1] then return nil, "gap:" .. f end
    end
    return true
end

-- The formats a ruleset can read, lowest first.
function M.Readable(rules)
    local out = {}
    for f in pairs(rules.read) do out[#out + 1] = f end
    table.sort(out)
    return out
end

-- Bring an event of any readable format up to `rules.current`. Returns the event in the current shape, or nil + why:
-- "unreadable" (a format this build does not read), "noupcast", or what the upcaster said.
function M.Up(rules, ev)
    if not rules.read[ev.v] then return nil, "unreadable" end
    local cur = ev
    for f = ev.v, rules.current - 1 do
        local up = rules.upcast[f]
        if not up then return nil, "noupcast" end
        local nxt, why = up(cur)
        if type(nxt) ~= "table" then return nil, why or "upcastfailed" end
        nxt.v = f + 1
        if nxt.id ~= ev.id then nxt.id = ev.id end -- a conflict refers to the stored event
        cur = nxt
    end
    return cur
end

-- Take an event in `rules.current` shape down to `format` (to write an older ledger). Returns the event, or nil + why.
function M.Down(rules, ev, format)
    local cur = ev
    for f = ev.v, format + 1, -1 do
        local down = rules.downcast[f]
        if not down then return nil, "nodowncast" end
        local nxt, why = down(cur)
        if type(nxt) ~= "table" then return nil, why or "unrepresentable" end
        nxt.v = f - 1
        cur = nxt
    end
    return cur
end

---------------------------------------------------------------- the cutover
-- A cut says how many events of each chain are BEFORE a migration: { [chainId] = n }. Which events are old and which are new is
-- then the same on every machine, whatever order they arrived in.
function M.InCut(cut, ev)
    local n = cut[ev.chain]
    return n ~= nil and ev.seq <= n
end

-- The format an event must be in, given the migrations in force (each { cut, to }, in order): the format of the last one it is
-- NOT inside the cut of, else the first format.
function M.FormatFor(migrations, ev)
    local fmt = M.BASE
    for _, m in ipairs(migrations) do
        if not M.InCut(m.cut, ev) then fmt = m.to end
    end
    return fmt
end

-- A fingerprint of everything a view says that outlives the moment: each list's order, each member's wins, passes and standing, each award
-- (who, what, whether undone), and where an undo would put each winner back. Equal digests mean everyone stands in the same place with the
-- same record AND the same corrections available, so a mistake in an upcaster can't hide behind a later move. The projection is the migration's
-- contract: it reads the replayed lists, never the events, so it means the same under every format.
function M.StandingsDigest(view)
    local lists = {}
    for id, s in pairs(view.lists) do
        local members, awards, undo = {}, {}, {}
        for name, m in pairs(s.members) do members[name] = { active = m.active, wins = m.wins, passes = m.passes } end
        for aid, a in pairs(s.awards) do awards[aid] = { member = a.member, item = a.item, reverted = a.reverted or false } end
        for chain, stack in pairs(s.undo) do
            local entries = {}
            for k, e in ipairs(stack) do entries[k] = { id = e.id, member = e.member, below = e.below } end
            undo[chain] = entries
        end
        lists[id] = { order = s.order, members = members, awards = awards, undo = undo }
    end
    return Hash.Sum(Hash.Canon(lists))
end
