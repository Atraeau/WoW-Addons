# C_CraftingOrders

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**36** functions · **24** events · **2** types

## Functions

### C_CraftingOrders.AreOrderNotesDisabled

```lua
areNotesDisabled = C_CraftingOrders.AreOrderNotesDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areNotesDisabled` | bool | no |  |

**Example**

```lua
local areNotesDisabled = C_CraftingOrders.AreOrderNotesDisabled()
```

### C_CraftingOrders.CalculateCraftingOrderPostingFee

```lua
deposit = C_CraftingOrders.CalculateCraftingOrderPostingFee(skillLineAbilityID, orderType, orderDuration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAbilityID` | number | no |  |
| `orderType` | CraftingOrderType | no |  |
| `orderDuration` | CraftingOrderDuration | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deposit` | WOWMONEY | no |  |

**Example**

```lua
local deposit = C_CraftingOrders.CalculateCraftingOrderPostingFee(0, orderType, orderDuration)
```

### C_CraftingOrders.CancelOrder

```lua
C_CraftingOrders.CancelOrder(orderID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |

**Example**

```lua
C_CraftingOrders.CancelOrder(orderID)
```

### C_CraftingOrders.CanOrderSkillAbility

```lua
canOrder = C_CraftingOrders.CanOrderSkillAbility(skillLineAbilityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAbilityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canOrder` | bool | no |  |

**Example**

```lua
local canOrder = C_CraftingOrders.CanOrderSkillAbility(0)
```

### C_CraftingOrders.ClaimOrder

```lua
C_CraftingOrders.ClaimOrder(orderID, profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |
| `profession` | Profession | no |  |

**Example**

```lua
C_CraftingOrders.ClaimOrder(orderID, profession)
```

### C_CraftingOrders.CloseCrafterCraftingOrders

```lua
C_CraftingOrders.CloseCrafterCraftingOrders()
```

**Example**

```lua
C_CraftingOrders.CloseCrafterCraftingOrders()
```

### C_CraftingOrders.CloseCustomerCraftingOrders

```lua
C_CraftingOrders.CloseCustomerCraftingOrders()
```

**Example**

```lua
C_CraftingOrders.CloseCustomerCraftingOrders()
```

### C_CraftingOrders.FulfillOrder

```lua
C_CraftingOrders.FulfillOrder(orderID, crafterNote, profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |
| `crafterNote` | string | no |  |
| `profession` | Profession | no |  |

**Example**

```lua
C_CraftingOrders.FulfillOrder(orderID, "", profession)
```

### C_CraftingOrders.GetClaimedOrder

```lua
order = C_CraftingOrders.GetClaimedOrder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `order` | CraftingOrderInfo | yes |  |

**Example**

```lua
local order = C_CraftingOrders.GetClaimedOrder()
```

### C_CraftingOrders.GetCrafterBuckets

```lua
buckets = C_CraftingOrders.GetCrafterBuckets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buckets` | CraftingOrderBucketInfo[] | no |  |

**Example**

```lua
local buckets = C_CraftingOrders.GetCrafterBuckets()
```

### C_CraftingOrders.GetCrafterOrders

```lua
orders = C_CraftingOrders.GetCrafterOrders()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orders` | CraftingOrderInfo[] | no |  |

**Example**

```lua
local orders = C_CraftingOrders.GetCrafterOrders()
```

### C_CraftingOrders.GetCraftingOrderTime

```lua
time = C_CraftingOrders.GetCraftingOrderTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | BigUInteger | no |  |

**Example**

```lua
local time = C_CraftingOrders.GetCraftingOrderTime()
```

### C_CraftingOrders.GetCustomerCategories

```lua
categories = C_CraftingOrders.GetCustomerCategories()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categories` | CraftingOrderCustomerCategory[] | no |  |

**Example**

```lua
local categories = C_CraftingOrders.GetCustomerCategories()
```

### C_CraftingOrders.GetCustomerOptions

```lua
results = C_CraftingOrders.GetCustomerOptions(params)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `params` | CraftingOrderCustomerSearchParams | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `results` | CraftingOrderCustomerSearchResults | no |  |

**Example**

```lua
local results = C_CraftingOrders.GetCustomerOptions(params)
```

### C_CraftingOrders.GetCustomerOrders

```lua
customerOrders = C_CraftingOrders.GetCustomerOrders()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customerOrders` | CraftingOrderInfo[] | no |  |

**Example**

```lua
local customerOrders = C_CraftingOrders.GetCustomerOrders()
```

### C_CraftingOrders.GetDefaultOrdersSkillLine

```lua
skillLineID = C_CraftingOrders.GetDefaultOrdersSkillLine()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | yes |  |

**Example**

```lua
local skillLineID = C_CraftingOrders.GetDefaultOrdersSkillLine()
```

### C_CraftingOrders.GetMyOrders

```lua
myOrders = C_CraftingOrders.GetMyOrders()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `myOrders` | CraftingOrderInfo[] | no |  |

**Example**

```lua
local myOrders = C_CraftingOrders.GetMyOrders()
```

### C_CraftingOrders.GetNumFavoriteCustomerOptions

```lua
numFavorites = C_CraftingOrders.GetNumFavoriteCustomerOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFavorites` | BigUInteger | no |  |

**Example**

```lua
local numFavorites = C_CraftingOrders.GetNumFavoriteCustomerOptions()
```

### C_CraftingOrders.GetOrderClaimInfo

```lua
claimInfo = C_CraftingOrders.GetOrderClaimInfo(profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `claimInfo` | CraftingOrderClaimsRemainingInfo | no |  |

**Example**

```lua
local claimInfo = C_CraftingOrders.GetOrderClaimInfo(profession)
```

### C_CraftingOrders.GetPersonalOrdersInfo

```lua
infos = C_CraftingOrders.GetPersonalOrdersInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infos` | CraftingOrderPersonalOrdersInfo[] | no |  |

**Example**

```lua
local infos = C_CraftingOrders.GetPersonalOrdersInfo()
```

### C_CraftingOrders.HasFavoriteCustomerOptions

```lua
hasFavorites = C_CraftingOrders.HasFavoriteCustomerOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFavorites` | bool | no |  |

**Example**

```lua
local hasFavorites = C_CraftingOrders.HasFavoriteCustomerOptions()
```

### C_CraftingOrders.IsCustomerOptionFavorited

```lua
favorited = C_CraftingOrders.IsCustomerOptionFavorited(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `favorited` | bool | no |  |

**Example**

```lua
local favorited = C_CraftingOrders.IsCustomerOptionFavorited(0)
```

### C_CraftingOrders.ListMyOrders

```lua
C_CraftingOrders.ListMyOrders(request)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `request` | CraftingOrderRequestMyOrdersInfo | no |  |

**Example**

```lua
C_CraftingOrders.ListMyOrders(request)
```

### C_CraftingOrders.OpenCrafterCraftingOrders

```lua
C_CraftingOrders.OpenCrafterCraftingOrders()
```

**Example**

```lua
C_CraftingOrders.OpenCrafterCraftingOrders()
```

### C_CraftingOrders.OpenCustomerCraftingOrders

```lua
C_CraftingOrders.OpenCustomerCraftingOrders()
```

**Example**

```lua
C_CraftingOrders.OpenCustomerCraftingOrders()
```

### C_CraftingOrders.OrderCanBeRecrafted

```lua
recraftable = C_CraftingOrders.OrderCanBeRecrafted(orderID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recraftable` | bool | no |  |

**Example**

```lua
local recraftable = C_CraftingOrders.OrderCanBeRecrafted(orderID)
```

### C_CraftingOrders.ParseCustomerOptions

```lua
C_CraftingOrders.ParseCustomerOptions()
```

**Example**

```lua
C_CraftingOrders.ParseCustomerOptions()
```

### C_CraftingOrders.PlaceNewOrder

```lua
C_CraftingOrders.PlaceNewOrder(orderInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderInfo` | NewCraftingOrderInfo | no |  |

**Example**

```lua
C_CraftingOrders.PlaceNewOrder(orderInfo)
```

### C_CraftingOrders.RejectOrder

```lua
C_CraftingOrders.RejectOrder(orderID, crafterNote, profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |
| `crafterNote` | string | no |  |
| `profession` | Profession | no |  |

**Example**

```lua
C_CraftingOrders.RejectOrder(orderID, "", profession)
```

### C_CraftingOrders.ReleaseOrder

```lua
C_CraftingOrders.ReleaseOrder(orderID, profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |
| `profession` | Profession | no |  |

**Example**

```lua
C_CraftingOrders.ReleaseOrder(orderID, profession)
```

### C_CraftingOrders.RequestCrafterOrders

```lua
C_CraftingOrders.RequestCrafterOrders(request)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `request` | CraftingOrderRequestInfo | no |  |

**Example**

```lua
C_CraftingOrders.RequestCrafterOrders(request)
```

### C_CraftingOrders.RequestCustomerOrders

```lua
C_CraftingOrders.RequestCustomerOrders(request)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `request` | CraftingOrderRequestInfo | no |  |

**Example**

```lua
C_CraftingOrders.RequestCustomerOrders(request)
```

### C_CraftingOrders.SetCustomerOptionFavorited

```lua
C_CraftingOrders.SetCustomerOptionFavorited(recipeID, favorited)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `favorited` | bool | no |  |

**Example**

```lua
C_CraftingOrders.SetCustomerOptionFavorited(0, false)
```

### C_CraftingOrders.ShouldShowCraftingOrderTab

```lua
showTab = C_CraftingOrders.ShouldShowCraftingOrderTab()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showTab` | bool | no |  |

**Example**

```lua
local showTab = C_CraftingOrders.ShouldShowCraftingOrderTab()
```

### C_CraftingOrders.SkillLineHasOrders

```lua
hasOrders = C_CraftingOrders.SkillLineHasOrders(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasOrders` | bool | no |  |

**Example**

```lua
local hasOrders = C_CraftingOrders.SkillLineHasOrders(0)
```

### C_CraftingOrders.UpdateIgnoreList

```lua
C_CraftingOrders.UpdateIgnoreList()
```

**Example**

```lua
C_CraftingOrders.UpdateIgnoreList()
```

## Events

### CRAFTING_HOUSE_DISABLED

### CRAFTINGORDERS_CAN_REQUEST

### CRAFTINGORDERS_CLAIMED_ORDER_ADDED

### CRAFTINGORDERS_CLAIMED_ORDER_REMOVED

### CRAFTINGORDERS_CLAIMED_ORDER_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_CLAIM_ORDER_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_CRAFT_ORDER_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_CUSTOMER_FAVORITES_CHANGED

### CRAFTINGORDERS_CUSTOMER_OPTIONS_PARSED

### CRAFTINGORDERS_DISPLAY_CRAFTER_FULFILLED_MSG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderTypeString` | cstring | no |  |
| `itemNameString` | cstring | no |  |
| `playerNameString` | cstring | no |  |
| `tipAmount` | WOWMONEY | no |  |
| `quantityCrafted` | number | no |  |

### CRAFTINGORDERS_FULFILL_ORDER_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_HIDE_CRAFTER

### CRAFTINGORDERS_HIDE_CUSTOMER

### CRAFTINGORDERS_ORDER_CANCEL_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |

### CRAFTINGORDERS_ORDER_PLACEMENT_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |

### CRAFTINGORDERS_REJECT_ORDER_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_RELEASE_ORDER_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CraftingOrderResult | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_SHOW_CRAFTER

### CRAFTINGORDERS_SHOW_CUSTOMER

### CRAFTINGORDERS_UNEXPECTED_ERROR

### CRAFTINGORDERS_UPDATE_CUSTOMER_NAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customerName` | cstring | no |  |
| `orderID` | BigUInteger | no |  |

### CRAFTINGORDERS_UPDATE_ORDER_COUNT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderType` | CraftingOrderType | no |  |
| `numOrders` | number | no |  |

### CRAFTINGORDERS_UPDATE_PERSONAL_ORDER_COUNTS

### CRAFTINGORDERS_UPDATE_REWARDS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `npcOrderRewards` | CraftingOrderRewardInfo[] | no |  |
| `orderID` | BigUInteger | no |  |

## Types

### CraftingOrderRequestInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderType` | CraftingOrderType | no |  |
| `selectedSkillLineAbility` | number | yes |  |
| `searchFavorites` | bool | no |  |
| `initialNonPublicSearch` | bool | no |  |
| `primarySort` | CraftingOrderSortInfo | no |  |
| `secondarySort` | CraftingOrderSortInfo | no |  |
| `forCrafter` | bool | no |  |
| `offset` | number | no |  |
| `callback` | CraftingOrderRequestCallback | no |  |
| `profession` | Profession | yes |  |

### CraftingOrderRequestMyOrdersInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `primarySort` | CraftingOrderSortInfo | no |  |
| `secondarySort` | CraftingOrderSortInfo | no |  |
| `offset` | number | no |  |
| `callback` | CraftingOrderRequestMyOrdersCallback | no |  |

