-- King's Gambit: the module registry, with dependency injection. Loaded first (the only file whose place in the
-- TOC matters); every other file may load in any order.
--
-- A module names what it uses, and receives it once every file has loaded:
--
--   local Hash, Standings
--   local M = SK:NewModule("Ledger", { "Hash", "Standings" }, function(d) Hash, Standings = d.Hash, d.Standings end)
--
-- A name ending in "?" is optional (e.g. raid data, "AQ40?"): it is injected if loaded, nil otherwise.
-- SK:Resolve() injects every module, each after the modules it depends on, and stops with a clear error on a
-- missing dependency or a cycle. It is called by whoever composes the addon: Core at login, the test harness,
-- the simulator page. Modules never read SK.modules themselves.
-- Keep this file Lua 5.1-safe.
local _, SK = ...
SK.modules = SK.modules or {}
local defs = {}

function SK:NewModule(name, deps, inject)
    assert(type(name) == "string" and name ~= "", "a module needs a name")
    assert(not self.modules[name], "module defined twice: " .. name)
    local m = { name = name }
    self.modules[name] = m
    defs[name] = { deps = deps or {}, inject = inject }
    return m
end

-- Inject every module's dependencies. Returns the names in the order they were injected.
function SK:Resolve()
    local state, order = {}, {}
    local names = {}
    for name in pairs(defs) do names[#names + 1] = name end
    table.sort(names) -- the same order on every run
    local function visit(name, path)
        if state[name] == "done" then return end
        if state[name] == "visiting" then error("module dependency cycle: " .. table.concat(path, " -> ") .. " -> " .. name, 0) end
        local def = defs[name]
        state[name] = "visiting"
        path[#path + 1] = name
        local given = {}
        for _, dep in ipairs(def.deps) do
            local dname, optional = dep:match("^(.-)(%??)$")
            if defs[dname] then
                visit(dname, path)
                given[dname] = self.modules[dname]
            elseif optional == "" then
                error(("module %s needs %s, which is not loaded"):format(name, dname), 0)
            end
        end
        path[#path] = nil
        if def.inject then def.inject(given) end
        state[name] = "done"
        order[#order + 1] = name
    end
    for _, name in ipairs(names) do visit(name, {}) end
    self.resolved = true
    return order
end
