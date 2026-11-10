-- King's Gambit: a small event emitter, shared by the loot network (LootNet) and requests (Requests). Keep this file Lua 5.1-safe.
--   local ev = Emitter.New()
--   local off = ev.on("phase", function(payload) ... end)   -- returns a function that stops listening
--   ev.emit("phase", payload)                               -- calls the listeners that were registered when it started and are still active
local _, SK = ...
local M = SK:NewModule("Emitter")

function M.New()
    local handlers = {}
    local e = {}
    function e.on(event, fn)
        local list = handlers[event]
        if not list then list = {}; handlers[event] = list end
        local entry = { fn = fn, active = true }
        list[#list + 1] = entry
        return function() entry.active = false end
    end
    function e.emit(event, payload)
        local snapshot = {}
        for i, x in ipairs(handlers[event] or {}) do snapshot[i] = x end
        for _, x in ipairs(snapshot) do
            if x.active then x.fn(payload) end
        end
    end
    return e
end
