-- King's Gambit: the text commands for item rules: which classes and roles an item is for, your spec, and fit hints. Keep this file Lua 5.1-safe.
-- Commands.New builds the shared pieces (see Commands.lua) and calls Install here, which adds these commands to `cmds`.
local _, SK = ...
local ItemFit
local M = SK:NewModule("CmdRules", { "ItemFit" }, function(d) ItemFit = d.ItemFit end)

-- c: the command set being built; cmds: its table of commands; h: the helpers Commands.New shares (and what the earlier files exported).
function M.Install(c, cmds, h)
    local engine, out, why, name, short, list, mls = h.engine, h.out, h.why, h.name, h.short, h.list, h.mls
    local char, myClass, myFit = h.char, h.myClass, h.myFit

    local CLASS_WORDS = {}
    for token, n in pairs(ItemFit.CLASS_NAMES) do CLASS_WORDS[n:lower()] = token end

    local function ruleText(id, rule, name)
        local names = ItemFit.ClassList({ classes = rule.classes }) or "any class"
        return ("%s: %s. Set by %s: %s"):format(name or ("item " .. id), names, short(rule.by), rule.reason)
    end
    local function ruleName(rule)
        local ev = engine.store.byId[rule.id]
        return ev and ev.data.name
    end

    -- eligible                                  every rule
    -- eligible <item>                           the rule for one item
    -- eligible <item> <classes|any> <reason>    set it (classes joined with commas: warrior,rogue,hunter)
    function cmds.eligible(args)
        if args == "" then
            local ids = {}
            for id in pairs(engine:ItemRules()) do ids[#ids + 1] = id end
            table.sort(ids)
            if #ids == 0 then return out("No item rules yet. Set one with: eligible <item> <classes|any> <reason>") end
            for _, id in ipairs(ids) do
                local rule = engine:ItemRule(id)
                out("  " .. ruleText(id, rule, ruleName(rule)))
            end
            return
        end
        local link, rest = args:match("^(|c.-|r)%s*(.-)$")
        if not link then link, rest = args:match("^(%S+)%s*(.-)$") end
        local id = ItemFit.ItemId(link)
        if not id then return out("Which item? Shift-click it into the command, or give its item id.") end
        local itemName = link:match("%[(.-)%]")
        if rest == "" then
            local rule = engine:ItemRule(id)
            if not rule then return out("No rule for item " .. id .. ": the item itself decides (its 'Classes:' line, if any).") end
            return out(ruleText(id, rule, ruleName(rule)))
        end
        local list, reason = rest:match("^(%S+)%s+(.+)$")
        if not list then return out("eligible <item> <classes|any> <reason>  (a reason is required: it goes in the record)") end
        local classes = {}
        if list:lower() ~= "any" then
            for word in list:gmatch("[^,]+") do
                local token = CLASS_WORDS[word:lower()]
                if not token then return out("Unknown class '" .. word .. "'. Classes: warrior, paladin, hunter, rogue, priest, shaman, mage, warlock, druid, or any.") end
                classes[#classes + 1] = token
            end
        end
        local ok, reasonWhy = engine:MayWrite()
        if not ok then
            if reasonWhy == "duringraid" then
                return out(("A raid is running: only its Master Looter (%s) writes now. Set the rule after the raid, or ask them."):format(mls()))
            end
            return out("Not recorded: " .. why(reasonWhy))
        end
        local ev, err = engine:Write("ItemClasses", { item = id, classes = classes, reason = reason, name = itemName })
        if not ev then return out("Not recorded: " .. why(err)) end
        out("Recorded. " .. ruleText(id, engine:ItemRule(id), itemName) .. ". When it drops, only these classes can bid in the drafts.")
    end

    -- suits <item> <roles|auto> <reason>: override the heuristic's judgment of who an item suits (officers),
    -- e.g. "suits 18820 caster the Talisman is for damage casters". "auto" goes back to the heuristic.
    -- suits <item>: what the heuristic says, and any override.
    local ROLE_WORDS = { tank = true, melee = true, hunter = true, caster = true, healer = true }
    function cmds.suits(args)
        local link, rest = args:match("^(|c.-|r)%s*(.-)$")
        if not link then link, rest = args:match("^(%S+)%s*(.-)$") end
        local id = ItemFit.ItemId(link)
        if not id then return out("suits <item> <roles|auto> <reason>  (item: a link or an item id)") end
        local itemName = link:match("%[(.-)%]")
        if rest == "" then
            local o = engine:ItemSuits(id)
            if o then out(("Officer's call for %s: %s. Set by %s: %s"):format(itemName or ("item " .. id), table.concat(o.roles, ", "), short(o.by), o.reason)) end
            local fit = myFit(link)
            local text = fit and ItemFit.SuitsText(fit)
            if not o then out(("The addon's judgment for %s: %s."):format(itemName or ("item " .. id), text or "its stats say nothing (an officer can say: suits <item> <roles> <reason>)")) end
            return
        end
        local list, reason = rest:match("^(%S+)%s+(.+)$")
        if not list then return out("suits <item> <roles|auto> <reason>  (a reason is required: it goes in the record)") end
        local roles = {}
        if list:lower() ~= "auto" then
            for word in list:gmatch("[^,]+") do
                if not ROLE_WORDS[word:lower()] then return out("Unknown role '" .. word .. "'. Roles: tank, melee, hunter, caster, healer, or auto.") end
                roles[#roles + 1] = word:lower()
            end
        end
        local ok, reasonWhy = engine:MayWrite()
        if not ok then
            if reasonWhy == "duringraid" then
                return out(("A raid is running: only its Master Looter (%s) writes now. Set it after the raid, or ask them."):format(mls()))
            end
            return out("Not recorded: " .. why(reasonWhy))
        end
        local ev, err = engine:Write("ItemSuits", { item = id, roles = roles, reason = reason, name = itemName })
        if not ev then return out("Not recorded: " .. why(err)) end
        out(#roles > 0 and ("Recorded: %s suits %s (officer's call, over the addon's judgment)."):format(itemName or ("item " .. id), table.concat(roles, ", "))
            or ("Recorded: %s is judged by the addon again."):format(itemName or ("item " .. id)))
    end

    function cmds.spec(args)
        local main, off = args:match("^(%S+)%s*(%S*)$")
        if not main then
            local s = char.spec
            return out(s and ("Your specs: %s%s."):format(s.main, s.off and (", off-spec " .. s.off) or "") or "No spec set. spec <main> [off]")
        end
        local class = myClass()
        if not class then return out("Your class isn't known yet (join a group, or try again in a moment).") end
        local function find(word)
            word = word:lower()
            for _, s in ipairs(ItemFit.SPECS[class]) do
                if s.name:lower():find(word, 1, true) == 1 or s.name:lower():find("(" .. word, 1, true) then return s.name end
            end
        end
        local m, o = find(main), off ~= "" and find(off) or nil
        if not m or (off ~= "" and not o) then
            local names = {}
            for i, s in ipairs(ItemFit.SPECS[class]) do names[i] = s.name end
            return out("Specs for your class: " .. table.concat(names, ", ") .. ".")
        end
        char.spec = { main = m, off = o }
        out(("Your specs: %s%s. Used for hints only (hints on)."):format(m, o and (", off-spec " .. o) or ""))
    end

    function cmds.hints(args)
        local a = args:lower()
        if a == "on" then char.hints = true elseif a == "off" then char.hints = nil end
        out(char.hints and "Hints are on: items show who they suit and how they fit you. A suggestion, never a rule."
            or "Hints are off: you judge items yourself (hints on to see suggestions).")
    end
end
