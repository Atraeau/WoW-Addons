-- BagSorter
-- Created by: Kirk Lennstrom
-- Created date: 11/2/2008
-- All rights reserved

-- Description
-- This addon will sort items in the user's bags, and bank

-- Static declarations:
BagSorter_UpdateInterval = 0.5; -- How often the OnUpdate code will run (in seconds)
switchOn = false
timer = 0
TimeSinceLastUpdate = 0
--g_BagSorterSettings = 0
--g_BagSorter_GlobalSettings = 0
--g_BagSorterSettings["SortQueue"] = 0


-- OnLoad Event Handler
function WowBagSorter_OnLoad()
    DEFAULT_CHAT_FRAME:AddMessage("BagSorter Loaded: Type /bs to sort your bags.")
    SlashCmdList["BAGSORTER"] = BagSort;
    SLASH_BAGSORTER1 = "/BagSort";
    SLASH_BAGSORTER2 = "/BS";
    TimeSinceLastUpdate = 0;

--g_BagSorterSettings = {SortQueue = {}, BagOrder = {}}
--g_BagSorter_GlobalSettings = {SortQueue = {}, BagOrder = {}}
--g_BagSorterSettings["SortQueue"] = GenerateDefaultSortQueue()

end


-- OnUpdate Event Handler
function WowBagSorter_OnUpdate(self, elapsed)
  --DEFAULT_CHAT_FRAME:AddMessage("OnUpdate")
  TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 

	if (switchOn) then
		if (TimeSinceLastUpdate > BagSorter_UpdateInterval) then
			--DEFAULT_CHAT_FRAME:AddMessage(timer)
			timer = timer + 1
			TimeSinceLastUpdate = 0;
		end
	end
	
	if (timer == 1) then
	coroutine.resume(swaper)
	timer = 0
	end
end


-- Functions

-- This is the main function call
function BagSort()
    --DEFAULT_CHAT_FRAME:AddMessage("Executed BagSort()");
    
    local domains = BagSortInit.Init();
    sortQueue = ObtainSortQueue();
    bagOrder = ObtainBagPriority();
    
    itemPlacementGroupings = {}
    
    for domainName, domain in pairs(domains) do -- for each item domain (bank, player)
        --DEFAULT_CHAT_FRAME:AddMessage("Walking the "..domainName.." domain");
        for i,family in ipairs(domain.families) do  -- for each family in this domain
            --DEFAULT_CHAT_FRAME:AddMessage("Walking the "..family.value.." family");
            
            -- Calculate the total family bag size for this group
            local familySlotCount = CalculateFamilySlotCount(family.bags)
            
            local itemsThisFamily = {}
            local itemsToRemove = {}
            -- Go through each item and see if it fits in the family
            for j,item in ipairs(domain.items) do
                if (ItemMatchesBag(item, family.value)) then
                    ----DEFAULT_CHAT_FRAME:AddMessage("adding: "..domain.items[j].location.bag..":"..domain.items[j].location.slot.." to family: "..family.value);
                    table.insert(itemsThisFamily, domain.items[j])
                    table.insert(itemsToRemove, item.location);
                end
            end
            
            -- Remove the items just added from the main group so we don't sort it multiple times.
            for _,itemlocation in ipairs (itemsToRemove) do 
                local indexToRemove = FindItem(domain.items, itemlocation)
                assert(indexToRemove ~= nil);
                --DEFAULT_CHAT_FRAME:AddMessage("removing: "..domain.items[indexToRemove].location.bag..":"..domain.items[indexToRemove].location.slot.." from main item group");
                table.remove(domain.items, indexToRemove)
            end
            
            
            -- sort the itemgroup so we can re-add overflowing items
            --DEFAULT_CHAT_FRAME:AddMessage("Sorting the "..family.value.." family");
            sorteditemgroup = SortItems(itemsThisFamily, sortQueue)
            -- Remove overflowing itemgroup
            -- add the overflowing itemgroup back to the itemgroup table to be re-sorted  
            while (# sorteditemgroup > familySlotCount) do
                local lastItem = # sorteditemgroup
                --DEFAULT_CHAT_FRAME:AddMessage(lastItem.." is the last index "..sorteditemgroup[lastItem].itemInfo.Link);
                local removedItem = sorteditemgroup[lastItem];
                table.remove(sorteditemgroup);
                --DEFAULT_CHAT_FRAME:AddMessage("Removing "..removedItem.itemInfo.Link.."from the "..family.value.." family");
                table.insert(domain.items, removedItem)
            end
            orderedBags= {}
            for i,v in ipairs(bagOrder) do
                bagsIndex = FindBag(family.bags, v);
                table.insert(orderedBags, family.bags[bagsIndex])
            end
            
            SetItemDestinations(sorteditemgroup, orderedBags);

            table.insert(itemPlacementGroupings, sorteditemgroup);
        end
    end
    -- now that we know where everything goes, move the items
	 swaper = coroutine.create(MoveItems);
	 coroutine.resume(swaper, itemPlacementGroupings);
	--MoveItems(itemPlacementGroupings);
    
end

-- this function returns the index in the specified items table where the item is located
function FindItem (items, location)
    for i,item in pairs(items) do
        if ((item.location.bag == location.bag) and (item.location.slot == location.slot)) then
            --DEFAULT_CHAT_FRAME:AddMessage("Item at "..item.location.bag..":"..item.location.slot.." was found in the table at index "..i);
            return i
        end
    end
    --DEFAULT_CHAT_FRAME:AddMessage("couldnt find item at "..location.bag..":"..location.slot);
end

function CalculateFamilySlotCount(family)
local familySlotCount = 0

    for _,bag in ipairs(family) do
        if (IsBagExcluded(bag)~= true) then
            familySlotCount = familySlotCount + bag.bagSize;
        end           
    end        
    --DEFAULT_CHAT_FRAME:AddMessage("FamilySize="..familySlotCount);
    
    return familySlotCount
end

-- The sort queue is a collection of sort functions to sort the items over
-- The order of the queue is the order in which the sorts are performed on the objects
-- The available sort queues should be saved as user variables.
-- If no queues are defined, a default will be provided
function ObtainSortQueue()
--DEFAULT_CHAT_FRAME:AddMessage("Start of ObtainSortQueue");
    local sortQueue;
    
    if (# g_BagSorterSettings.SortQueue > 0) then
        sortQueue = g_BagSorterSettings.SortQueue
        --DEFAULT_CHAT_FRAME:AddMessage("Hit player global sortQueue");
    else 
        if (# g_BagSorterSettings.SortQueue > 0) then
            sortQueue = g_BagSorter_GlobalSettings.SortQueue
            --DEFAULT_CHAT_FRAME:AddMessage("Hit global sortQueue");
        else
            sortQueue = BagSortInit.GenerateDefaultSortQueue()
            --DEFAULT_CHAT_FRAME:AddMessage("Hit generate sortQueue");
        end
    end
    
    return sortQueue
end

function FindBag (bags, bagIndex)
    for i,bag in pairs(bags) do
        if (bag.bagIndex == bagIndex) then
            --DEFAULT_CHAT_FRAME:AddMessage("Bag at "..bag.bagIndex.." was found in the table at index "..i);
            return i
        end
    end
    --DEFAULT_CHAT_FRAME:AddMessage("couldnt find bag at "..bagIndex);
end

-- Once the items are sorted, they need to be placed in bags. The locations where the items go
-- depend on what the user wants (may want to place bag exclusions here as well).
function ObtainBagPriority()
    local bagOrder;
    
    if (# g_BagSorterSettings.BagOrder > 0) then
        bagOrder = g_BagSorterSettings.BagOrder
    else 
        if (# g_BagSorter_GlobalSettings.BagOrder > 0) then
            bagOrder = g_BagSorter_GlobalSettings.BagOrder
        else
            bagOrder = BagSortInit.GenerateDefaultBagOrder()
        end
    end    
    
    return bagOrder 
end

function IsBagExcluded(bag)
    return false
end

-- use the bag priority to determine which bag gets which item
-- make sure to not include excluded bags
function SetItemDestinations(sortedItems, bags)
    --the bags provided must be a sorted list with the highest priority bag on top.
    local orderedItemLocations = {}
    
    for index, bag in pairs(bags) do
        for slot=1, bag.bagSize do -- for each slot in the bag
            local location = {bag, slot};
            location.bag = bag.bagIndex;
            location.slot = slot;
            table.insert(orderedItemLocations, location)
        end
    end
    
    for index, item in ipairs(sortedItems) do
        item.destination.bag = orderedItemLocations[index].bag;
        item.destination.slot = orderedItemLocations[index].slot;
        --DEFAULT_CHAT_FRAME:AddMessage("Moving item "..item.itemInfo.Link.." from "..item.location.bag..":"..item.location.slot.." to "..item.destination.bag..":"..item.destination.slot)
    end
    
    return sortedItems
end

-- sort all the items for the given family
function SortItems(items, sortQueue)

    local customSortFunction = SortFunctions.GenerateSortFunction(sortQueue);
    table.sort(items, customSortFunction);
    
    for i,item in ipairs(items) do
        --DEFAULT_CHAT_FRAME:AddMessage(item.itemInfo.MinLevel..item.itemInfo.Link..item.itemInfo.Level..item.itemInfo.Type..item.itemInfo.EquipLoc..item.itemInfo.SubType);
    end
    
    return items;
    
end

-- Determine whether an item can go into the family
function ItemMatchesBag(item, family)

    if(family == bit.band(item.family, family)) then
        return true
    end
    
    return false
end

function MoveItems (itemPlacementGroupings)

	for idxGroupings, sortedItemGroup in ipairs(itemPlacementGroupings) do
	    --DEFAULT_CHAT_FRAME:AddMessage("sortedGroupIndex: "..idxGroupings);
	    for idxitem, item in ipairs(sortedItemGroup) do
	        --DEFAULT_CHAT_FRAME:AddMessage("Item: "..item.itemInfo.Link.." at "..item.location.bag..":"..item.location.slot.." Is headed to "..item.destination.bag..":"..item.destination.slot);

		    local notInSpot = ((item.location.bag ~= item.destination.bag) or (item.location.slot ~= item.destination.slot))
		    local locked1, locked2
    		
		    if (notInSpot) then  --make sure the item needs to be swapped before swapping it
		    
			    _, _, locked1 = GetContainerItemInfo(item.location.bag, item.location.slot)
			    _, _, locked2 = GetContainerItemInfo(item.destination.bag, item.destination.slot)
    	
    	        --DEFAULT_CHAT_FRAME:AddMessage("Checking for lock");
			    while locked1 or locked2 do
					    switchOn = true
					    coroutine.yield()
					    switchOn = false
				    _, _, locked1 = GetContainerItemInfo(item.location.bag, item.location.slot)
				    _, _, locked2 = GetContainerItemInfo(item.destination.bag, item.destination.slot)			
			    end -- if locked bit			
    			--DEFAULT_CHAT_FRAME:AddMessage("Swapping now");
			    succeeded = SwapItems(item.location.bag, item.location.slot, item.destination.bag, item.destination.slot)	
			        
			    -- If it succedded, then check if there is a new item in the spot, if there is, make sure that item's position gets updated
			    if (succeeded) then
			    
				    if (GetContainerItemLink(item.destination.bag, item.destination.slot)~=nil) then
				        --DEFAULT_CHAT_FRAME:AddMessage(GetContainerItemLink(item.destination.bag, item.destination.slot).." existed in that slot");
				        --DEFAULT_CHAT_FRAME:AddMessage("Item previously existed at location "..item.destination.bag..":"..item.destination.slot..". Updating that item's location")
				        
				        local oldLocation = {bag = item.destination.bag, slot = item.destination.slot};     -- where item existed
				        local newLocation = {bag = item.location.bag, slot = item.location.slot};           -- where the item is now located
    				    itemPlacementGroupings = UpdateItemLocation(itemPlacementGroupings, oldLocation, newLocation);
    				    
				    end -- checking whether another item was swapped if statment
				    
				    -- update the item's location to it's destination (since it's there now)
			        item.location.bag = item.destination.bag;
			        item.location.slot = item.destination.slot;				    
			    else
				    --DEFAULT_CHAT_FRAME:AddMessage(idxitem.." failed swapping")
				    failed = true
			    end -- checking whether swap succeeded
			    else
			        --DEFAULT_CHAT_FRAME:AddMessage("Item already in spot")
		    end -- checking whether item is in spot or not
		end
	end -- swap loop
--DEFAULT_CHAT_FRAME:AddMessage("done moving")
end

function UpdateItemLocation (itemGroupings, oldLocation, newLocation)
    --DEFAULT_CHAT_FRAME:AddMessage("Entered UpdateItemLocation")
    
    for i, items in pairs(itemGroupings) do
        for j,v in pairs(items) do
            --DEFAULT_CHAT_FRAME:AddMessage("Item "..v.itemInfo.Link.." existed at "..j.." in this table, and has a location of ".. v.location.bag..":"..v.location.slot)
        end
    end
    
    for i, items in pairs(itemGroupings) do
        local index = FindItem(items, oldLocation);
        if (index ~= nil) then
            items[index].location = newLocation;
            break;
        end
    end

    for i, items in ipairs(itemGroupings) do
        for j,v in ipairs(items) do
            --DEFAULT_CHAT_FRAME:AddMessage("Item "..v.itemInfo.Link.." at "..j.." in this table, now has a location of ".. v.location.bag..":"..v.location.slot)
        end
    end
    
    return itemGroupings;
end

function SwapItems(bag1, slot1, bag2, slot2)
    ClearCursor()
	
    local _, _, locked1 = GetContainerItemInfo(bag1, slot1)
    local _, _, locked2 = GetContainerItemInfo(bag2, slot2)
	
    if locked1 or locked2 then
   		return false
	else
		PickupContainerItem(bag1, slot1)
		PickupContainerItem(bag2, slot2)
		--DEFAULT_CHAT_FRAME:AddMessage("swap succedded")
		return true
	end
end