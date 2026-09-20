--****************************************
--  Table sort functions for WoW items
--  
--  Each function sorts on unique item 
--  attributes
--
--****************************************

--[[
    local itemInfo = {
    ["Name"] = Name, 
    ["Link"] = Link, 
    ["Rarity"] = Rarity,
    ["Level"] = Level, 
    ["MinLevel"] = MinLevel, 
    ["Type"] = Type, 
    ["SubType"] = SubType,
    ["StackCount"] = StackCount,
    ["EquipLoc"] = EquipLoc, 
    ["Texture"] = Texture} 
--]]

local P = {}

SortFunctions = P;

function P.GenerateSortFunction (sortNames)
    ----DEFAULT_CHAT_FRAME:AddMessage("Start of GenerateSortFunction");
    ----DEFAULT_CHAT_FRAME:AddMessage("sortNames[1]="..sortNames[1].name.." n="..# sortNames);

    -- Test whether to generate the alternate or base function
    if (# sortNames > 1) then -- generate the alternate
        ----DEFAULT_CHAT_FRAME:AddMessage("Entered Alternate");
        altArg = {}
        
        for i,v in pairs(sortNames) do
            if (i ~= 1) then
                table.insert(altArg, v)
            end           
        end
        
        ----DEFAULT_CHAT_FRAME:AddMessage("Before defining function: "..sortNames[1].name.." n="..# sortNames);
        local Alternate = P.GenerateSortFunction(altArg)
        if (sortNames[1].order == "Descending") then
            local function Primary(itemA, itemB)
                if (itemA.itemInfo[sortNames[1].name] < itemB.itemInfo[sortNames[1].name]) then 
                    return true
                end
                if (itemA.itemInfo[sortNames[1].name] == itemB.itemInfo[sortNames[1].name]) then
                    return Alternate(itemA, itemB)
                end
            end
            ----DEFAULT_CHAT_FRAME:AddMessage("Returning Function for "..sortNames[1].name.." n="..# sortNames);
            return Primary
        else
            local function Primary(itemA, itemB)
                if (itemA.itemInfo[sortNames[1].name] > itemB.itemInfo[sortNames[1].name]) then 
                    return true
                end
                if (itemA.itemInfo[sortNames[1].name] == itemB.itemInfo[sortNames[1].name]) then
                    return Alternate(itemA, itemB)
                end
            end
            ----DEFAULT_CHAT_FRAME:AddMessage("Returning Function for "..sortNames[1].name.." n="..# sortNames);
            return Primary
        end        
    else -- Generate the base
        ----DEFAULT_CHAT_FRAME:AddMessage("Entered Base");
        if (sortNames[1].order == "Descending") then
            local function Base(itemA, itemB)
                if (itemA.itemInfo[sortNames[1].name] < itemB.itemInfo[sortNames[1].name]) then 
                    return true
                end
                return false
            end
            return Base
        else
            local function Base(itemA, itemB)
                if (itemA.itemInfo[sortNames[1].name] > itemB.itemInfo[sortNames[1].name]) then 
                    return true
                end
                return false
            end
            return Base
        end 
    end
end