-- King's Gambit: tokens and readiness (Phase 4.5).
-- Some raids (Ahn'Qiraj) drop tokens instead of gear: a class-group item that is turned in, with
-- materials and reputation, for a tier piece. Tokens are bid on like gear, under the same rules. What
-- this module adds is READINESS: can the bidder actually redeem it? Readiness is shown, never enforced
-- (taking a token you can't redeem yet is your call; mistakes are fixed by correction or by trade), and
-- it is shared with the raid as a hint only: materials in the bank can't be seen by anyone else.
--
-- A bid's readiness is one of:
--   "ready"     the bidder's addon found everything a turn-in for their class needs
--   "says"      the bidder says they are ready (e.g. materials in the bank, or no addon: "1 need ready")
--   "notready"  the bidder's addon looked and something is missing
--   nil         unknown (not a token, or its requirements aren't in our data yet)
-- Design: docs/kings-gambit/design-journal.md ("Tokens, readiness, materials, and list scope").
local _, SK = ...
local M = SK:NewModule("Tokens")

-- Raid data modules that may hold tokens (items with a `token` field).
M.SOURCES = { "AQ40" }

M.STATES = { ready = true, says = true, notready = true }
M.LABELS = { ready = "ready", says = "says ready", notready = "not ready (from bags)" }

-- Reputation standings, as the game numbers them (1 = Hated ... 8 = Exalted).
M.REACTIONS = { Hated = 1, Hostile = 2, Unfriendly = 3, Neutral = 4, Friendly = 5, Honored = 6, Revered = 7, Exalted = 8 }

local byId, byName
local function index()
    if byId then return end
    byId, byName = {}, {}
    for _, src in ipairs(M.SOURCES) do
        local data = SK.modules[src]
        for id, item in pairs(data and data.items or {}) do
            if item.token then byId[id] = item; byName[item.name:lower()] = item end
        end
    end
end

-- The token data for an item link ("|Hitem:20928:...|h[...]|h"), item id, or plain name; nil if not a token.
function M.Find(link)
    index()
    if type(link) == "number" then return byId[link] end
    if type(link) ~= "string" then return nil end
    local id = tonumber(link:match("item:(%d+)"))
    if id then return byId[id] end
    local name = link:match("%[(.-)%]") or link
    return byName[name:lower()]
end

-- Forget the index (tests and the simulator swap data in).
function M.Reset() byId, byName = nil, nil end

-- Can a player of `class` redeem `token` with what they have?
-- count(itemNameOrId) -> number held; reaction(factionId, factionName) -> 1..8 or nil.
-- Returns "ready", "notready", or nil when no turn-in for the class is known yet. Any one known turn-in
-- for the class (e.g. shoulders OR boots) being satisfied is enough. The token itself is not counted:
-- it is what the bid is for.
function M.Check(token, class, count, reaction)
    local turnIns = token and token.token and token.token.turnIns
    local options = turnIns and turnIns[class]
    if not options or #options == 0 then return nil end
    for _, t in ipairs(options) do
        local ok = true
        for _, need in ipairs(t.needs or {}) do
            local what, n = need[1], need[2] or 1
            if what ~= token.id and what ~= token.name and (count(what) or 0) < n then ok = false end
        end
        local rep = t.reputation
        if ok and rep then
            local at = reaction and reaction(rep.factionId, rep.faction)
            if not at or at < (M.REACTIONS[rep.standing] or 99) then ok = false end
        end
        if ok then return "ready" end
    end
    return "notready"
end

-- What the bid carries: the addon's finding, or the player's own word when the addon can't see it.
-- declared = true when the player says they are ready.
function M.Combine(computed, declared)
    if computed == "ready" then return "ready" end
    if declared then return "says" end
    return computed
end

-- Readiness for this client's own player, from bags and bank (the bank count is the game's cache).
function M.Mine(client, token, class, declared)
    local computed = M.Check(token, class,
        function(what) return client:itemCount(what, true) end,
        function(factionId, name) return client:reputation(factionId, name) end)
    return M.Combine(computed, declared)
end

function M.Label(state) return state and M.LABELS[state] or "unknown" end
