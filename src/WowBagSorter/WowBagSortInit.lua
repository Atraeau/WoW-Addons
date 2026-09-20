--****************************************
--  Initialize bags, items and families
--  
--
--****************************************

local P = {};

BagSortInit = P;

function P.Init()

    -- Establish existing bags
    bags = P.ResolveBags();
    domains = {};
    for i,v in pairs(bags) do
        domains[i] = {};
    end
    
    -- Establish domains
    for domainName, bagsThisDomain in pairs(bags) do
        ----DEFAULT_CHAT_FRAME:AddMessage("initializing the "..domainName.." domain");
        domains[domainName].families = P.GetAllBagFamilies(bagsThisDomain)
        domains[domainName].items = P.ResolveItems(bagsThisDomain)
    end
    
    -- declare globals
    if (g_BagSorter_GlobalSettings == nil) then
        g_BagSorter_GlobalSettings = {SortQueue = {}, BagOrder = {}};
    end
    
    if (g_BagSorterSettings == nil) then
        g_BagSorterSettings = {SortQueue = {}, BagOrder = {}};
    end    
    
    
    return domains;  
end

function P.IsBankBag(bag)
    if (bag.bagIndex == BANK_CONTAINER) or (bag.bagIndex > NUM_BAG_SLOTS) then
        return true
    end
    return false
end

-- If the user does not have a bag order set in their
-- global variables, set the program defaults
-- could use this for a global reset defaults option

function P.GenerateDefaultBagOrder()
--DEFAULT_CHAT_FRAME:AddMessage("Start of P.GenerateDefaultBagOrder");
    bagOrder = {}
    
    table.insert(bagOrder, BANK_CONTAINER);
    for i=NUM_BAG_SLOTS+1, NUM_BANKBAGSLOTS+NUM_BAG_SLOTS+1 do
        --DEFAULT_CHAT_FRAME:AddMessage("Added bank bag"..i);
        table.insert(bagOrder, i);
    end
    
    for i=NUM_BAG_SLOTS, BACKPACK_CONTAINER, -1 do
        --DEFAULT_CHAT_FRAME:AddMessage("Added player bag"..i);
        table.insert(bagOrder, i);
    end
    
    return bagOrder    
end

-- if the user does not have a sort queue set in their
-- global variables, call this function.

function P.GenerateDefaultSortQueue()
    --DEFAULT_CHAT_FRAME:AddMessage("Start of P.GenerateDefaultSortQueue");
    
    local sortNames = {}
    table.insert(sortNames, {name="Rarity", order="Ascending"})
    table.insert(sortNames, {name="EquipLoc", order="Ascending"})
    table.insert(sortNames, {name="SubType", order="Ascending"})
    table.insert(sortNames, {name="Level", order="Ascending"})
    table.insert(sortNames, {name="Name", order="Descending"})
    return sortNames;
end

-- this function determines what are all the available bags and returns their properties
function P.ResolveBags ()
    --DEFAULT_CHAT_FRAME:AddMessage("Start of P.ResolveBags");
	-- Constants
	local GENERIC_BAG_FAMILY = 0;	
	local bagItemInfo = "INVTYPE_BAG";
	local slots = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS);
	
	-- Local variables
	local bagsByDomain = {};
	bagsByDomain["player"] = {};
	local bankClosed=true; --Assume the bank is closed unless proven otherwise
	
	-- set data on the backpack
	table.insert(bagsByDomain["player"], P.AddBag(BACKPACK_CONTAINER, GENERIC_BAG_FAMILY, nil));
	
	for i=1, slots do
		invID = ContainerIDToInventoryID(i);
		link = GetInventoryItemLink("player", invID);
		-- GetInventoryItemLink will return nil for empty bag slots or if bank is closed
		if link then
		    -- BUGBUG: if the bank has no bags, we'll never know when it's open (unless we find another test)
		    -- if the link is not null and higher than 67, the bank is open
		    _, _, itemString = string.find(link, "^|%x+|H(.+)|h%[.+%]");
		    
		    if (invID > 67) then
		        if (bankClosed) then
		            bagsByDomain["bank"] = {};
		            table.insert(bagsByDomain["bank"], P.AddBag(BANK_CONTAINER, GENERIC_BAG_FAMILY, nil));
		            bankClosed = false;
		            --DEFAULT_CHAT_FRAME:AddMessage("Bank is open");
		        end
		    -- Enumerate the itemstring for the bag and place into the bag info    
		        table.insert(bagsByDomain["bank"], P.AddBag(i, GetItemFamily(link), itemString));
		    else
		        table.insert(bagsByDomain["player"], P.AddBag(i, GetItemFamily(link), itemString));
		    end
		end
	end
		
	 ----Add all the iteminfo data 
	--for i,v in pairs(bagsByDomain) do
	    --for j,k in ipairs(v) do
	        --if k.itemInfo then
	            ----DEFAULT_CHAT_FRAME:AddMessage("domain: "..i.." Value: "..k.itemInfo["Link"]);
	        --end	    
	    ----DEFAULT_CHAT_FRAME:AddMessage("domain: "..i.." Size: "..k.bagSize.."Family"..k.family);
	    --end
	--end
	
	return bagsByDomain;

end

-- Add a new bag to a bag collection
function P.AddBag(bagIndex, bagFamily, itemString, isBankBag)
     -- bag contains all information about the bag
	local bag = {
	itemInfo, 
	bagIndex, 
	bagSize, 
	family,
	isBankBag
	};

	bag.bagIndex = bagIndex;
	bag.family = bagFamily;
	bag.bagSize = GetContainerNumSlots(bagIndex);
	bag.isBankBag = P.IsBankBag;
	
	if itemString then
	    bag.itemInfo = P.ResolveItemInfo(itemString);
	end
	
	return bag;
end

-- This function enumerates all items in the specified bags
function P.ResolveItems(bags)
    --DEFAULT_CHAT_FRAME:AddMessage("Start of P.ResolveItems Function");
    local items = {};
   
    for i,bag in pairs(bags) do     --Iterate over all bags in the collection
        for slot=1, bag.bagSize do         --Iterate over all slots in the current bag
            if (GetContainerItemLink(bag.bagIndex, slot)) then
                local item = P.AddItem(bag, slot);
                table.insert(items, item);
                ----DEFAULT_CHAT_FRAME:AddMessage("Added item:"..item.itemInfo["Link"]);
            end
        end
    end
    
    --for domainName, domainItems in pairs(itemsByDomain) do    
        --for i,item in pairs(domainItems) do
            ----DEFAULT_CHAT_FRAME:AddMessage("Domain"..domainName.." Item:"..item.itemInfo.Link);
        --end       
	--end
    return items
end

-- Add a new item to an item collection
function P.AddItem(bag, slot)
    --local location = {bag, slot};
    --local destination = {bag, slot};
        
	local item = {
	location = {bag, slot},
	destination = {bag, slot},
	itemInfo, 
	family
	};
	
    link = GetContainerItemLink(bag.bagIndex, slot);
	_, _, itemString = string.find(link, "^|%x+|H(.+)|h%[.+%]");

	item.location.bag = bag.bagIndex;
	item.location.slot = slot;
	
	item.itemInfo = P.ResolveItemInfo(itemString)
	item.family = GetItemFamily(link);
	
	return item;
end

-- Retrieve all the item info for the item string
function P.ResolveItemInfo(itemstring)

    local Name, Link, Rarity, Level, MinLevel, Type, SubType, StackCount, EquipLoc, Texture;
    Name, Link, Rarity, Level, MinLevel, Type, SubType, StackCount, EquipLoc, Texture = GetItemInfo(itemstring);
    
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

    return itemInfo;
end

-- Go through a collection of bags and output
-- the set of available families
function P.GetAllBagFamilies(bags)
--DEFAULT_CHAT_FRAME:AddMessage("Start of P.GetAllBagFamilies");
    
    local familyValues = {};
    local families = {};

    for i, bag in pairs(bags) do
        if (P.Exists(familyValues, bag.family) ~= true) then
            table.insert(familyValues, bag.family);
        end
    end
    
    table.sort(familyValues, function(a,b) return a>b end);
    
    function AddFamily(bags)
        return {value = bags[1].family, bags = bags}
    end     

    for i, familyValue in ipairs(familyValues) do
        local familyBagGroup = {}
        for _, bag in pairs(bags) do
            if (bag.family == familyValue) then
                table.insert(familyBagGroup, bag)
            end
        end
        table.insert(families, AddFamily(familyBagGroup));
    end
    
    ----Output the structure of the family
    --for i,v in ipairs(families) do
        --for j,k in ipairs(v.bags) do
            ----DEFAULT_CHAT_FRAME:AddMessage("FamilyIndex:"..i.."Family:"..v.value.."bagIndex:"..j.."bagSize"..k.bagSize)
        --end
    --end
    
    return families    
end

-- General test to see whether the value
-- provided P.exists in the table
function P.Exists(table, value)
    for _,v in pairs(table) do
        if (v == value) then 
            return true 
        end
    end
    return false
end

