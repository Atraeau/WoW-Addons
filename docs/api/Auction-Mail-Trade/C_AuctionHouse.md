# C_AuctionHouse

[← API index](../README.md) · group: [Auction, Mail & Trade](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**85** functions · **47** events · **16** types

## Functions

### C_AuctionHouse.CalculateCommodityDeposit

```lua
depositCost = C_AuctionHouse.CalculateCommodityDeposit(itemID, duration, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `depositCost` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local depositCost = C_AuctionHouse.CalculateCommodityDeposit(6948, 1, 0)
```

### C_AuctionHouse.CalculateItemDeposit

```lua
depositCost = C_AuctionHouse.CalculateItemDeposit(item, duration, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `depositCost` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local depositCost = C_AuctionHouse.CalculateItemDeposit(6948, 1, 0)
```

### C_AuctionHouse.CanCancelAuction

```lua
canCancelAuction = C_AuctionHouse.CanCancelAuction(ownedAuctionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCancelAuction` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canCancelAuction = C_AuctionHouse.CanCancelAuction(0)
```

### C_AuctionHouse.CancelAuction

```lua
C_AuctionHouse.CancelAuction(ownedAuctionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.CancelAuction(0)
```

### C_AuctionHouse.CancelCommoditiesPurchase

```lua
C_AuctionHouse.CancelCommoditiesPurchase()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.CancelCommoditiesPurchase()
```

### C_AuctionHouse.CancelSell

```lua
C_AuctionHouse.CancelSell()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.CancelSell()
```

### C_AuctionHouse.CloseAuctionHouse

```lua
C_AuctionHouse.CloseAuctionHouse()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.CloseAuctionHouse()
```

### C_AuctionHouse.ConfirmCommoditiesPurchase

```lua
C_AuctionHouse.ConfirmCommoditiesPurchase(itemID, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quantity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.ConfirmCommoditiesPurchase(6948, 0)
```

### C_AuctionHouse.ConfirmPostCommodity

```lua
C_AuctionHouse.ConfirmPostCommodity(item, duration, quantity, unitPrice)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |
| `unitPrice` | BigUInteger | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.ConfirmPostCommodity(6948, 1, 0, "player")
```

### C_AuctionHouse.ConfirmPostItem

```lua
C_AuctionHouse.ConfirmPostItem(item, duration, quantity, [bid], [buyout])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |
| `bid` | BigUInteger | yes |  |
| `buyout` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.ConfirmPostItem(6948, 1, 0)
```

### C_AuctionHouse.FavoritesAreAvailable

```lua
favoritesAreAvailable = C_AuctionHouse.FavoritesAreAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `favoritesAreAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local favoritesAreAvailable = C_AuctionHouse.FavoritesAreAvailable()
```

### C_AuctionHouse.GetAuctionInfoByID

```lua
priceInfo = C_AuctionHouse.GetAuctionInfoByID(auctionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `priceInfo` | AuctionInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local priceInfo = C_AuctionHouse.GetAuctionInfoByID(0)
```

### C_AuctionHouse.GetAuctionItemSubClasses

```lua
subClasses = C_AuctionHouse.GetAuctionItemSubClasses(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subClasses` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local subClasses = C_AuctionHouse.GetAuctionItemSubClasses(0)
```

### C_AuctionHouse.GetAvailablePostCount

```lua
listCount = C_AuctionHouse.GetAvailablePostCount(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local listCount = C_AuctionHouse.GetAvailablePostCount(6948)
```

### C_AuctionHouse.GetBidInfo

```lua
bid = C_AuctionHouse.GetBidInfo(bidIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bidIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bid` | BidInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bid = C_AuctionHouse.GetBidInfo(1)
```

### C_AuctionHouse.GetBids

```lua
bids = C_AuctionHouse.GetBids()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bids` | BidInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bids = C_AuctionHouse.GetBids()
```

### C_AuctionHouse.GetBidType

```lua
typeItemKey = C_AuctionHouse.GetBidType(bidTypeIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bidTypeIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeItemKey` | ItemKey | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local typeItemKey = C_AuctionHouse.GetBidType(1)
```

### C_AuctionHouse.GetBrowseResults

```lua
browseResults = C_AuctionHouse.GetBrowseResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `browseResults` | BrowseResultInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local browseResults = C_AuctionHouse.GetBrowseResults()
```

### C_AuctionHouse.GetCancelCost

```lua
cancelCost = C_AuctionHouse.GetCancelCost(ownedAuctionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cancelCost` | BigUInteger | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cancelCost = C_AuctionHouse.GetCancelCost(0)
```

### C_AuctionHouse.GetCommoditySearchResultInfo

```lua
result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, commoditySearchResultIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `commoditySearchResultIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CommoditySearchResultInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_AuctionHouse.GetCommoditySearchResultInfo(6948, 1)
```

### C_AuctionHouse.GetCommoditySearchResultsQuantity

```lua
totalQuantity = C_AuctionHouse.GetCommoditySearchResultsQuantity(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalQuantity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalQuantity = C_AuctionHouse.GetCommoditySearchResultsQuantity(6948)
```

### C_AuctionHouse.GetExtraBrowseInfo

```lua
extraInfo = C_AuctionHouse.GetExtraBrowseInfo(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `extraInfo` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local extraInfo = C_AuctionHouse.GetExtraBrowseInfo(6948)
```

### C_AuctionHouse.GetFilterGroups

```lua
filterGroups = C_AuctionHouse.GetFilterGroups()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterGroups` | AuctionHouseFilterGroup[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local filterGroups = C_AuctionHouse.GetFilterGroups()
```

### C_AuctionHouse.GetItemCommodityStatus

```lua
isCommodity = C_AuctionHouse.GetItemCommodityStatus(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCommodity` | ItemCommodityStatus | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCommodity = C_AuctionHouse.GetItemCommodityStatus(6948)
```

### C_AuctionHouse.GetItemKeyFromItem

```lua
itemKey = C_AuctionHouse.GetItemKeyFromItem(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemKey = C_AuctionHouse.GetItemKeyFromItem(6948)
```

### C_AuctionHouse.GetItemKeyInfo

```lua
itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(itemKey, restrictQualityToFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `restrictQualityToFilter` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKeyInfo` | ItemKeyInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(6948, "HELPFUL")
```

### C_AuctionHouse.GetItemKeyRequiredLevel

```lua
requiredLevel = C_AuctionHouse.GetItemKeyRequiredLevel(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requiredLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requiredLevel = C_AuctionHouse.GetItemKeyRequiredLevel(6948)
```

### C_AuctionHouse.GetItemSearchResultInfo

```lua
result = C_AuctionHouse.GetItemSearchResultInfo(itemKey, itemSearchResultIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `itemSearchResultIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ItemSearchResultInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_AuctionHouse.GetItemSearchResultInfo(6948, 1)
```

### C_AuctionHouse.GetItemSearchResultsQuantity

```lua
totalQuantity = C_AuctionHouse.GetItemSearchResultsQuantity(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalQuantity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalQuantity = C_AuctionHouse.GetItemSearchResultsQuantity(6948)
```

### C_AuctionHouse.GetMaxBidItemBid

```lua
maxBid = C_AuctionHouse.GetMaxBidItemBid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBid` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBid = C_AuctionHouse.GetMaxBidItemBid()
```

### C_AuctionHouse.GetMaxBidItemBuyout

```lua
maxBuyout = C_AuctionHouse.GetMaxBidItemBuyout()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBuyout` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBuyout = C_AuctionHouse.GetMaxBidItemBuyout()
```

### C_AuctionHouse.GetMaxCommoditySearchResultPrice

```lua
maxUnitPrice = C_AuctionHouse.GetMaxCommoditySearchResultPrice(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxUnitPrice` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxUnitPrice = C_AuctionHouse.GetMaxCommoditySearchResultPrice(6948)
```

### C_AuctionHouse.GetMaxItemSearchResultBid

```lua
maxBid = C_AuctionHouse.GetMaxItemSearchResultBid(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBid` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBid = C_AuctionHouse.GetMaxItemSearchResultBid(6948)
```

### C_AuctionHouse.GetMaxItemSearchResultBuyout

```lua
maxBuyout = C_AuctionHouse.GetMaxItemSearchResultBuyout(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBuyout` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBuyout = C_AuctionHouse.GetMaxItemSearchResultBuyout(6948)
```

### C_AuctionHouse.GetMaxOwnedAuctionBid

```lua
maxBid = C_AuctionHouse.GetMaxOwnedAuctionBid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBid` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBid = C_AuctionHouse.GetMaxOwnedAuctionBid()
```

### C_AuctionHouse.GetMaxOwnedAuctionBuyout

```lua
maxBuyout = C_AuctionHouse.GetMaxOwnedAuctionBuyout()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBuyout` | BigUInteger | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBuyout = C_AuctionHouse.GetMaxOwnedAuctionBuyout()
```

### C_AuctionHouse.GetNumBids

```lua
numBids = C_AuctionHouse.GetNumBids()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numBids` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numBids = C_AuctionHouse.GetNumBids()
```

### C_AuctionHouse.GetNumBidTypes

```lua
numBidTypes = C_AuctionHouse.GetNumBidTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numBidTypes` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numBidTypes = C_AuctionHouse.GetNumBidTypes()
```

### C_AuctionHouse.GetNumCommoditySearchResults

```lua
numSearchResults = C_AuctionHouse.GetNumCommoditySearchResults(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSearchResults` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSearchResults = C_AuctionHouse.GetNumCommoditySearchResults(6948)
```

### C_AuctionHouse.GetNumItemSearchResults

```lua
numItemSearchResults = C_AuctionHouse.GetNumItemSearchResults(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numItemSearchResults` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numItemSearchResults = C_AuctionHouse.GetNumItemSearchResults(6948)
```

### C_AuctionHouse.GetNumOwnedAuctions

```lua
numOwnedAuctions = C_AuctionHouse.GetNumOwnedAuctions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numOwnedAuctions` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numOwnedAuctions = C_AuctionHouse.GetNumOwnedAuctions()
```

### C_AuctionHouse.GetNumOwnedAuctionTypes

```lua
numOwnedAuctionTypes = C_AuctionHouse.GetNumOwnedAuctionTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numOwnedAuctionTypes` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numOwnedAuctionTypes = C_AuctionHouse.GetNumOwnedAuctionTypes()
```

### C_AuctionHouse.GetNumReplicateItems

```lua
numReplicateItems = C_AuctionHouse.GetNumReplicateItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numReplicateItems` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numReplicateItems = C_AuctionHouse.GetNumReplicateItems()
```

### C_AuctionHouse.GetOwnedAuctionInfo

```lua
ownedAuction = C_AuctionHouse.GetOwnedAuctionInfo(ownedAuctionIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctionIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuction` | OwnedAuctionInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ownedAuction = C_AuctionHouse.GetOwnedAuctionInfo(1)
```

### C_AuctionHouse.GetOwnedAuctions

```lua
ownedAuctions = C_AuctionHouse.GetOwnedAuctions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctions` | OwnedAuctionInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ownedAuctions = C_AuctionHouse.GetOwnedAuctions()
```

### C_AuctionHouse.GetOwnedAuctionType

```lua
typeItemKey = C_AuctionHouse.GetOwnedAuctionType(ownedAuctionTypeIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedAuctionTypeIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeItemKey` | ItemKey | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local typeItemKey = C_AuctionHouse.GetOwnedAuctionType(1)
```

### C_AuctionHouse.GetQuoteDurationRemaining

```lua
quoteDurationSeconds = C_AuctionHouse.GetQuoteDurationRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quoteDurationSeconds` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local quoteDurationSeconds = C_AuctionHouse.GetQuoteDurationRemaining()
```

### C_AuctionHouse.GetReplicateItemBattlePetInfo

```lua
creatureID, displayID = C_AuctionHouse.GetReplicateItemBattlePetInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |
| `displayID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureID, displayID = C_AuctionHouse.GetReplicateItemBattlePetInfo(1)
```

### C_AuctionHouse.GetReplicateItemInfo

```lua
name, texture, count, qualityID, usable, level, levelType, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemID, hasAllInfo = C_AuctionHouse.GetReplicateItemInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `texture` | fileID | yes |  |
| `count` | number | no |  |
| `qualityID` | number | no |  |
| `usable` | bool | yes |  |
| `level` | number | no |  |
| `levelType` | string | yes |  |
| `minBid` | BigUInteger | no |  |
| `minIncrement` | BigUInteger | no |  |
| `buyoutPrice` | BigUInteger | no |  |
| `bidAmount` | BigUInteger | no |  |
| `highBidder` | string | yes |  |
| `bidderFullName` | string | yes |  |
| `owner` | string | yes |  |
| `ownerFullName` | string | yes |  |
| `saleStatus` | number | no |  |
| `itemID` | number | no |  |
| `hasAllInfo` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, texture, count, qualityID, usable, level, levelType, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemID, hasAllInfo = C_AuctionHouse.GetReplicateItemInfo(1)
```

### C_AuctionHouse.GetReplicateItemLink

```lua
itemLink = C_AuctionHouse.GetReplicateItemLink(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemLink = C_AuctionHouse.GetReplicateItemLink(1)
```

### C_AuctionHouse.GetReplicateItemTimeLeft

```lua
timeLeft = C_AuctionHouse.GetReplicateItemTimeLeft(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeft` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeLeft = C_AuctionHouse.GetReplicateItemTimeLeft(1)
```

### C_AuctionHouse.GetTimeLeftBandInfo

```lua
timeLeftMinSeconds, timeLeftMaxSeconds = C_AuctionHouse.GetTimeLeftBandInfo(timeLeftBand)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeftBand` | AuctionHouseTimeLeftBand | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeftMinSeconds` | number | no |  |
| `timeLeftMaxSeconds` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeLeftMinSeconds, timeLeftMaxSeconds = C_AuctionHouse.GetTimeLeftBandInfo(timeLeftBand)
```

### C_AuctionHouse.HasFavorites

```lua
hasFavorites = C_AuctionHouse.HasFavorites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFavorites` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFavorites = C_AuctionHouse.HasFavorites()
```

### C_AuctionHouse.HasFullBidResults

```lua
hasFullBidResults = C_AuctionHouse.HasFullBidResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullBidResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullBidResults = C_AuctionHouse.HasFullBidResults()
```

### C_AuctionHouse.HasFullBrowseResults

```lua
hasFullBrowseResults = C_AuctionHouse.HasFullBrowseResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullBrowseResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullBrowseResults = C_AuctionHouse.HasFullBrowseResults()
```

### C_AuctionHouse.HasFullCommoditySearchResults

```lua
hasFullResults = C_AuctionHouse.HasFullCommoditySearchResults(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullResults = C_AuctionHouse.HasFullCommoditySearchResults(6948)
```

### C_AuctionHouse.HasFullItemSearchResults

```lua
hasFullResults = C_AuctionHouse.HasFullItemSearchResults(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullResults = C_AuctionHouse.HasFullItemSearchResults(6948)
```

### C_AuctionHouse.HasFullOwnedAuctionResults

```lua
hasFullOwnedAuctionResults = C_AuctionHouse.HasFullOwnedAuctionResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullOwnedAuctionResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullOwnedAuctionResults = C_AuctionHouse.HasFullOwnedAuctionResults()
```

### C_AuctionHouse.HasMaxFavorites

```lua
hasMaxFavorites = C_AuctionHouse.HasMaxFavorites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxFavorites` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMaxFavorites = C_AuctionHouse.HasMaxFavorites()
```

### C_AuctionHouse.HasSearchResults

```lua
hasSearchResults = C_AuctionHouse.HasSearchResults(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSearchResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSearchResults = C_AuctionHouse.HasSearchResults(6948)
```

### C_AuctionHouse.IsFavoriteItem

```lua
isFavorite = C_AuctionHouse.IsFavoriteItem(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFavorite = C_AuctionHouse.IsFavoriteItem(6948)
```

### C_AuctionHouse.IsSellItemValid

```lua
valid = C_AuctionHouse.IsSellItemValid(item, displayError)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `displayError` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_AuctionHouse.IsSellItemValid(6948, false)
```

### C_AuctionHouse.IsThrottledMessageSystemReady

```lua
canSendThrottledMessage = C_AuctionHouse.IsThrottledMessageSystemReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSendThrottledMessage` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSendThrottledMessage = C_AuctionHouse.IsThrottledMessageSystemReady()
```

### C_AuctionHouse.MakeItemKey

```lua
itemKey = C_AuctionHouse.MakeItemKey(itemID, itemLevel, itemSuffix, battlePetSpeciesID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemLevel` | number | no | (default: 0) |
| `itemSuffix` | number | no | (default: 0) |
| `battlePetSpeciesID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemKey = C_AuctionHouse.MakeItemKey(6948, 6948, 6948, 0)
```

### C_AuctionHouse.PlaceBid

```lua
C_AuctionHouse.PlaceBid(auctionID, bidAmount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |
| `bidAmount` | BigUInteger | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.PlaceBid(0, bidAmount)
```

### C_AuctionHouse.PostCommodity

```lua
needsConfirmation = C_AuctionHouse.PostCommodity(item, duration, quantity, unitPrice)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |
| `unitPrice` | BigUInteger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `needsConfirmation` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local needsConfirmation = C_AuctionHouse.PostCommodity(6948, 1, 0, "player")
```

### C_AuctionHouse.PostItem

```lua
needsConfirmation = C_AuctionHouse.PostItem(item, duration, quantity, [bid], [buyout])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `duration` | luaIndex | no |  |
| `quantity` | number | no |  |
| `bid` | BigUInteger | yes |  |
| `buyout` | BigUInteger | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `needsConfirmation` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local needsConfirmation = C_AuctionHouse.PostItem(6948, 1, 0)
```

### C_AuctionHouse.QueryBids

```lua
C_AuctionHouse.QueryBids(sorts, auctionIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sorts` | AuctionHouseSortType[] | no |  |
| `auctionIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.QueryBids(sorts, auctionIDs)
```

### C_AuctionHouse.QueryOwnedAuctions

```lua
C_AuctionHouse.QueryOwnedAuctions(sorts)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sorts` | AuctionHouseSortType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.QueryOwnedAuctions(sorts)
```

### C_AuctionHouse.RefreshCommoditySearchResults

```lua
C_AuctionHouse.RefreshCommoditySearchResults(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.RefreshCommoditySearchResults(6948)
```

### C_AuctionHouse.RefreshItemSearchResults

```lua
C_AuctionHouse.RefreshItemSearchResults(itemKey, [minLevelFilter], [maxLevelFilter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `minLevelFilter` | number | yes |  |
| `maxLevelFilter` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.RefreshItemSearchResults(6948)
```

### C_AuctionHouse.ReplicateItems

This function should be used in place of an 'allItem' QueryAuctionItems call to query the entire auction house.

```lua
C_AuctionHouse.ReplicateItems()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.ReplicateItems()
```

### C_AuctionHouse.RequestMoreBrowseResults

```lua
C_AuctionHouse.RequestMoreBrowseResults()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.RequestMoreBrowseResults()
```

### C_AuctionHouse.RequestMoreCommoditySearchResults

```lua
hasFullResults = C_AuctionHouse.RequestMoreCommoditySearchResults(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullResults = C_AuctionHouse.RequestMoreCommoditySearchResults(6948)
```

### C_AuctionHouse.RequestMoreItemSearchResults

```lua
hasFullResults = C_AuctionHouse.RequestMoreItemSearchResults(itemKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFullResults` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFullResults = C_AuctionHouse.RequestMoreItemSearchResults(6948)
```

### C_AuctionHouse.RequestOwnedAuctionBidderInfo

```lua
bidderName = C_AuctionHouse.RequestOwnedAuctionBidderInfo(auctionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bidderName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bidderName = C_AuctionHouse.RequestOwnedAuctionBidderInfo(0)
```

### C_AuctionHouse.SearchForFavorites

```lua
C_AuctionHouse.SearchForFavorites(sorts)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sorts` | AuctionHouseSortType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SearchForFavorites(sorts)
```

### C_AuctionHouse.SearchForItemKeys

```lua
C_AuctionHouse.SearchForItemKeys(itemKeys, sorts)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKeys` | ItemKey[] | no |  |
| `sorts` | AuctionHouseSortType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SearchForItemKeys(6948, sorts)
```

### C_AuctionHouse.SendBrowseQuery

```lua
C_AuctionHouse.SendBrowseQuery(query)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `query` | AuctionHouseBrowseQuery | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SendBrowseQuery(query)
```

### C_AuctionHouse.SendSearchQuery

Search queries are restricted to 100 calls per minute. These should not be used to query the entire auction house. See ReplicateItems

```lua
C_AuctionHouse.SendSearchQuery(itemKey, sorts, separateOwnerItems, minLevelFilter, maxLevelFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `sorts` | AuctionHouseSortType[] | no |  |
| `separateOwnerItems` | bool | no |  |
| `minLevelFilter` | number | no | (default: 0) |
| `maxLevelFilter` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SendSearchQuery(6948, sorts, 6948, "HELPFUL", "HELPFUL")
```

### C_AuctionHouse.SendSellSearchQuery

Search queries are restricted to 100 calls per minute. These should not be used to query the entire auction house. See ReplicateItems. ItemKey should have its iLVL and suffix cleared before calling.

```lua
C_AuctionHouse.SendSellSearchQuery(itemKey, sorts, separateOwnerItems)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `sorts` | AuctionHouseSortType[] | no |  |
| `separateOwnerItems` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SendSellSearchQuery(6948, sorts, 6948)
```

### C_AuctionHouse.SetFavoriteItem

```lua
C_AuctionHouse.SetFavoriteItem(itemKey, setFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `setFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.SetFavoriteItem(6948, false)
```

### C_AuctionHouse.ShouldAutoPopulatePrice

```lua
shouldAutoPopulatePrice = C_AuctionHouse.ShouldAutoPopulatePrice()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldAutoPopulatePrice` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldAutoPopulatePrice = C_AuctionHouse.ShouldAutoPopulatePrice()
```

### C_AuctionHouse.StartCommoditiesPurchase

```lua
C_AuctionHouse.StartCommoditiesPurchase(itemID, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quantity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AuctionHouse.StartCommoditiesPurchase(6948, 0)
```

### C_AuctionHouse.SupportsCopperValues

```lua
supportsCopperValues = C_AuctionHouse.SupportsCopperValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `supportsCopperValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local supportsCopperValues = C_AuctionHouse.SupportsCopperValues()
```

## Events

### AUCTION_CANCELED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

### AUCTION_HOUSE_AUCTION_CREATED

This signal is not used in the base UI but is included for AddOn ease-of-use.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

### AUCTION_HOUSE_AUCTIONS_EXPIRED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

### AUCTION_HOUSE_BROWSE_FAILURE

### AUCTION_HOUSE_BROWSE_RESULTS_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `addedBrowseResults` | BrowseResultInfo[] | no |  |

### AUCTION_HOUSE_BROWSE_RESULTS_UPDATED

### AUCTION_HOUSE_CLOSED

### AUCTION_HOUSE_DISABLED

### AUCTION_HOUSE_FAVORITES_UPDATED

### AUCTION_HOUSE_ITEM_DELIVERY_DELAY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `purchasedItemDeliveryDelay` | number | no |  |
| `cancelledItemDeliveryDelay` | number | no |  |

### AUCTION_HOUSE_NEW_BID_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

### AUCTION_HOUSE_NEW_RESULTS_RECEIVED

This signal is not used in the base UI but is included for AddOn ease-of-use. Payload is nil for browse queries.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | yes |  |

### AUCTION_HOUSE_POST_ERROR

### AUCTION_HOUSE_POST_WARNING

### AUCTION_HOUSE_PURCHASE_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |

### AUCTION_HOUSE_SCRIPT_DEPRECATED

### AUCTION_HOUSE_SHOW

### AUCTION_HOUSE_SHOW_COMMODITY_WON_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `commodityName` | string | no |  |
| `commodityQuantity` | number | no |  |

### AUCTION_HOUSE_SHOW_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | AuctionHouseError | no |  |

### AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `notification` | AuctionHouseNotification | no |  |
| `text` | string | no |  |
| `auctionID` | number | yes |  |

### AUCTION_HOUSE_SHOW_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `notification` | AuctionHouseNotification | no |  |

### AUCTION_HOUSE_THROTTLED_MESSAGE_DROPPED

### AUCTION_HOUSE_THROTTLED_MESSAGE_QUEUED

### AUCTION_HOUSE_THROTTLED_MESSAGE_RESPONSE_RECEIVED

### AUCTION_HOUSE_THROTTLED_MESSAGE_SENT

### AUCTION_HOUSE_THROTTLED_SYSTEM_READY

### AUCTION_MULTISELL_FAILURE

### AUCTION_MULTISELL_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRepetitions` | number | no |  |

### AUCTION_MULTISELL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `createdCount` | number | no |  |
| `totalToCreate` | number | no |  |

### BID_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bidID` | number | no |  |

### BIDS_UPDATED

### COMMODITY_PRICE_UNAVAILABLE

### COMMODITY_PRICE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updatedUnitPrice` | BigUInteger | no |  |
| `updatedTotalPrice` | BigUInteger | no |  |

### COMMODITY_PURCHASED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quantity` | number | no |  |

### COMMODITY_PURCHASE_FAILED

### COMMODITY_PURCHASE_SUCCEEDED

### COMMODITY_SEARCH_RESULTS_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### COMMODITY_SEARCH_RESULTS_RECEIVED

### COMMODITY_SEARCH_RESULTS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### EXTRA_BROWSE_INFO_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### ITEM_KEY_ITEM_INFO_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### ITEM_PURCHASED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### ITEM_SEARCH_RESULTS_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |

### ITEM_SEARCH_RESULTS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `newAuctionID` | number | yes |  |

### OWNED_AUCTION_BIDDER_INFO_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |
| `bidderName` | cstring | no |  |

### OWNED_AUCTIONS_UPDATED

### REPLICATE_ITEM_LIST_UPDATE

## Types

### AuctionHouseBrowseQuery (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchString` | string | no |  |
| `sorts` | AuctionHouseSortType[] | no |  |
| `minLevel` | number | yes |  |
| `maxLevel` | number | yes |  |
| `filters` | AuctionHouseFilter[] | yes |  |
| `itemClassFilters` | AuctionHouseItemClassFilter[] | yes |  |

### AuctionHouseFilterCategory (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Uncategorized` | AuctionHouseFilterCategory | no |  |
| `Equipment` | AuctionHouseFilterCategory | no |  |
| `Rarity` | AuctionHouseFilterCategory | no |  |

### AuctionHouseFilterGroup (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | AuctionHouseFilterCategory | no |  |
| `filters` | AuctionHouseFilter[] | no |  |

### AuctionHouseItemClassFilter (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |
| `subClassID` | number | yes |  |
| `inventoryType` | InventoryType | yes |  |

### AuctionHouseSortType (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortOrder` | AuctionHouseSortOrder | no |  |
| `reverseSort` | bool | no |  |

### AuctionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `itemLink` | string | yes |  |
| `minBid` | WOWMONEY | yes |  |
| `bidAmount` | WOWMONEY | yes |  |
| `buyoutAmount` | WOWMONEY | yes |  |
| `bidder` | WOWGUID | yes |  |

### AuctionStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Active` | AuctionStatus | no |  |
| `Sold` | AuctionStatus | no |  |

### BidInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |
| `itemKey` | ItemKey | no |  |
| `itemLink` | string | yes |  |
| `timeLeft` | AuctionHouseTimeLeftBand | no |  |
| `minBid` | BigUInteger | yes |  |
| `bidAmount` | BigUInteger | yes |  |
| `buyoutAmount` | BigUInteger | yes |  |
| `bidder` | WOWGUID | yes |  |

### BrowseResultInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `appearanceLink` | string | yes |  |
| `totalQuantity` | number | no |  |
| `minPrice` | BigUInteger | no |  |
| `containsOwnerItem` | bool | no |  |

### CommoditySearchResultInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quantity` | number | no |  |
| `unitPrice` | BigUInteger | no |  |
| `auctionID` | number | no |  |
| `owners` | string[] | no |  |
| `totalNumberOfOwners` | number | no |  |
| `timeLeftSeconds` | number | yes |  |
| `numOwnerItems` | number | no |  |
| `containsOwnerItem` | bool | no |  |
| `containsAccountItem` | bool | no |  |

### ItemCommodityStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Unknown` | ItemCommodityStatus | no |  |
| `Item` | ItemCommodityStatus | no |  |
| `Commodity` | ItemCommodityStatus | no |  |

### ItemKey (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemLevel` | number | no | (default: 0) |
| `itemSuffix` | number | no | (default: 0) |
| `battlePetSpeciesID` | number | no | (default: 0) |

### ItemKeyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `battlePetSpeciesID` | number | no |  |
| `itemName` | string | no |  |
| `battlePetLink` | string | yes |  |
| `appearanceLink` | string | yes |  |
| `quality` | ItemQuality | no |  |
| `iconFileID` | number | no |  |
| `isPet` | bool | no |  |
| `isCommodity` | bool | no |  |
| `isEquipment` | bool | no |  |

### ItemSearchResultInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemKey` | ItemKey | no |  |
| `owners` | string[] | no |  |
| `totalNumberOfOwners` | number | no |  |
| `timeLeft` | AuctionHouseTimeLeftBand | no |  |
| `auctionID` | number | no |  |
| `quantity` | number | no |  |
| `itemLink` | string | yes |  |
| `containsOwnerItem` | bool | no |  |
| `containsAccountItem` | bool | no |  |
| `containsSocketedItem` | bool | no |  |
| `bidder` | WOWGUID | yes |  |
| `minBid` | BigUInteger | yes |  |
| `bidAmount` | BigUInteger | yes |  |
| `buyoutAmount` | BigUInteger | yes |  |
| `timeLeftSeconds` | number | yes |  |

### OwnedAuctionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auctionID` | number | no |  |
| `itemKey` | ItemKey | no |  |
| `itemLink` | string | yes |  |
| `status` | AuctionStatus | no |  |
| `quantity` | number | no |  |
| `timeLeftSeconds` | number | yes |  |
| `timeLeft` | AuctionHouseTimeLeftBand | yes |  |
| `bidAmount` | BigUInteger | yes |  |
| `buyoutAmount` | BigUInteger | yes |  |
| `bidder` | string | yes |  |

### ReplicateItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `texture` | fileID | yes |  |
| `count` | number | no |  |
| `qualityID` | number | no |  |
| `usable` | bool | yes |  |
| `level` | number | no |  |
| `levelType` | string | yes |  |
| `minBid` | BigUInteger | no |  |
| `minIncrement` | BigUInteger | no |  |
| `buyoutPrice` | BigUInteger | no |  |
| `bidAmount` | BigUInteger | no |  |
| `highBidder` | string | yes |  |
| `bidderFullName` | string | yes |  |
| `owner` | string | yes |  |
| `ownerFullName` | string | yes |  |
| `saleStatus` | number | no |  |
| `itemID` | number | no |  |
| `hasAllInfo` | bool | yes |  |

