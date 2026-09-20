# C_CatalogShop

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**38** functions · **18** events · **13** types

## Functions

### C_CatalogShop.BulkPurchaseProducts

```lua
canPurchaseProducts = C_CatalogShop.BulkPurchaseProducts(productIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIDs` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPurchaseProducts` | bool | no |  |

**Example**

```lua
local canPurchaseProducts = C_CatalogShop.BulkPurchaseProducts(productIDs)
```

### C_CatalogShop.BulkRefundDecors

```lua
C_CatalogShop.BulkRefundDecors(decorGUIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUIDs` | WOWGUID[] | no |  |

**Example**

```lua
C_CatalogShop.BulkRefundDecors("Creature-0-0000-0-0-0-0")
```

### C_CatalogShop.CloseCatalogShopInteraction

```lua
C_CatalogShop.CloseCatalogShopInteraction()
```

**Example**

```lua
C_CatalogShop.CloseCatalogShopInteraction()
```

### C_CatalogShop.ConfirmHousingPurchase

```lua
C_CatalogShop.ConfirmHousingPurchase(productIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIDs` | number[] | no |  |

**Example**

```lua
C_CatalogShop.ConfirmHousingPurchase(productIDs)
```

### C_CatalogShop.FindBestCurrencyProductForNeededAmount

```lua
vcProductID = C_CatalogShop.FindBestCurrencyProductForNeededAmount(vcCurrencyCode, amountNeeded)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vcCurrencyCode` | string | no |  |
| `amountNeeded` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vcProductID` | number | yes |  |

**Example**

```lua
local vcProductID = C_CatalogShop.FindBestCurrencyProductForNeededAmount("", 0)
```

### C_CatalogShop.GetAvailableCategoryIDs

```lua
categoryIDs = C_CatalogShop.GetAvailableCategoryIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryIDs` | number[] | no |  |

**Example**

```lua
local categoryIDs = C_CatalogShop.GetAvailableCategoryIDs()
```

### C_CatalogShop.GetAvailableTransmogRaceInfos

```lua
raceIDs = C_CatalogShop.GetAvailableTransmogRaceInfos()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceIDs` | AvailableRaceInfo[] | no |  |

**Example**

```lua
local raceIDs = C_CatalogShop.GetAvailableTransmogRaceInfos()
```

### C_CatalogShop.GetCatalogShopProductDisplayInfo

```lua
item = C_CatalogShop.GetCatalogShopProductDisplayInfo(catalogShopProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `catalogShopProductID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | CatalogShopProductDisplayInfo | no |  |

**Example**

```lua
local item = C_CatalogShop.GetCatalogShopProductDisplayInfo(0)
```

### C_CatalogShop.GetCategoryInfo

```lua
categoryInfo = C_CatalogShop.GetCategoryInfo(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryInfo` | CatalogShopCategoryInfo | no |  |

**Example**

```lua
local categoryInfo = C_CatalogShop.GetCategoryInfo(0)
```

### C_CatalogShop.GetCategorySectionInfo

```lua
sectionInfo = C_CatalogShop.GetCategorySectionInfo(categoryID, sectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `sectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sectionInfo` | CatalogShopSectionInfo | no |  |

**Example**

```lua
local sectionInfo = C_CatalogShop.GetCategorySectionInfo(0, 0)
```

### C_CatalogShop.GetFailureInfo

```lua
errorResultEnum, errorResultRaw = C_CatalogShop.GetFailureInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorResultEnum` | StoreError | yes |  |
| `errorResultRaw` | number | yes |  |

**Example**

```lua
local errorResultEnum, errorResultRaw = C_CatalogShop.GetFailureInfo()
```

### C_CatalogShop.GetFirstCategoryByProductID

```lua
categoryInfo = C_CatalogShop.GetFirstCategoryByProductID(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryInfo` | CatalogShopCategoryInfo | yes |  |

**Example**

```lua
local categoryInfo = C_CatalogShop.GetFirstCategoryByProductID(0)
```

### C_CatalogShop.GetNewProducts

```lua
newProducts = C_CatalogShop.GetNewProducts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newProducts` | number[] | no |  |

**Example**

```lua
local newProducts = C_CatalogShop.GetNewProducts()
```

### C_CatalogShop.GetProductAvailabilityTimeRemainingSecs

```lua
timeRemainingSecs = C_CatalogShop.GetProductAvailabilityTimeRemainingSecs(catalogShopProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `catalogShopProductID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeRemainingSecs` | number | yes |  |

**Example**

```lua
local timeRemainingSecs = C_CatalogShop.GetProductAvailabilityTimeRemainingSecs(0)
```

### C_CatalogShop.GetProductIDsForBundle

```lua
childIDs = C_CatalogShop.GetProductIDsForBundle(bundleProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bundleProductID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `childIDs` | CatalogShopBundleChildInfo[] | no |  |

**Example**

```lua
local childIDs = C_CatalogShop.GetProductIDsForBundle(0)
```

### C_CatalogShop.GetProductIDsForCategory

```lua
productIDs = C_CatalogShop.GetProductIDsForCategory(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIDs` | number[] | no |  |

**Example**

```lua
local productIDs = C_CatalogShop.GetProductIDsForCategory(0)
```

### C_CatalogShop.GetProductIDsForCategorySection

```lua
productIDs = C_CatalogShop.GetProductIDsForCategorySection(categoryID, sectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `sectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIDs` | number[] | no |  |

**Example**

```lua
local productIDs = C_CatalogShop.GetProductIDsForCategorySection(0, 0)
```

### C_CatalogShop.GetProductInfo

```lua
productInfo = C_CatalogShop.GetProductInfo(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productInfo` | CatalogShopProductInfo | yes |  |

**Example**

```lua
local productInfo = C_CatalogShop.GetProductInfo(0)
```

### C_CatalogShop.GetProductSortOrder

```lua
sortOrder = C_CatalogShop.GetProductSortOrder(categoryID, sectionID, productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `sectionID` | number | no |  |
| `productID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortOrder` | number | yes |  |

**Example**

```lua
local sortOrder = C_CatalogShop.GetProductSortOrder(0, 0, 0)
```

### C_CatalogShop.GetRefundableDecors

```lua
refundableDecorInfos, minTimeRemainingSeconds = C_CatalogShop.GetRefundableDecors([productIdFilterOpt])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIdFilterOpt` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundableDecorInfos` | RefundableDecorInfo[] | no |  |
| `minTimeRemainingSeconds` | time_t | no |  |

**Example**

```lua
local refundableDecorInfos, minTimeRemainingSeconds = C_CatalogShop.GetRefundableDecors()
```

### C_CatalogShop.GetSectionIDsForCategory

```lua
sectionIDs = C_CatalogShop.GetSectionIDsForCategory(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sectionIDs` | number[] | no |  |

**Example**

```lua
local sectionIDs = C_CatalogShop.GetSectionIDsForCategory(0)
```

### C_CatalogShop.GetSpellVisualInfoForMount

```lua
spellVisualInfo = C_CatalogShop.GetSpellVisualInfoForMount(spellVisualID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellVisualID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellVisualInfo` | CatalogShopSpellVisualInfo | no |  |

**Example**

```lua
local spellVisualInfo = C_CatalogShop.GetSpellVisualInfoForMount(12345)
```

### C_CatalogShop.GetVCProductInfos

```lua
vcProductInfos = C_CatalogShop.GetVCProductInfos()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vcProductInfos` | CatalogShopVCProductInfo[] | no |  |

**Example**

```lua
local vcProductInfos = C_CatalogShop.GetVCProductInfos()
```

### C_CatalogShop.GetVirtualCurrencyBalance

```lua
balance = C_CatalogShop.GetVirtualCurrencyBalance(currencyCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyCode` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `balance` | string | yes |  |

**Example**

```lua
local balance = C_CatalogShop.GetVirtualCurrencyBalance("")
```

### C_CatalogShop.HasNewProducts

```lua
hasNewProducts = C_CatalogShop.HasNewProducts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasNewProducts` | bool | no |  |

**Example**

```lua
local hasNewProducts = C_CatalogShop.HasNewProducts()
```

### C_CatalogShop.IsProductIncludedInAnyBundle

```lua
isIncludedInAnyBundle = C_CatalogShop.IsProductIncludedInAnyBundle(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIncludedInAnyBundle` | bool | no |  |

**Example**

```lua
local isIncludedInAnyBundle = C_CatalogShop.IsProductIncludedInAnyBundle(0)
```

### C_CatalogShop.IsShop2Enabled

```lua
value = C_CatalogShop.IsShop2Enabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | yes |  |

**Example**

```lua
local value = C_CatalogShop.IsShop2Enabled()
```

### C_CatalogShop.OnLegalDisclaimerClicked

```lua
C_CatalogShop.OnLegalDisclaimerClicked(catalogShopProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `catalogShopProductID` | number | no |  |

**Example**

```lua
C_CatalogShop.OnLegalDisclaimerClicked(0)
```

### C_CatalogShop.OnLegalPersonalizedOptOutClicked

```lua
C_CatalogShop.OnLegalPersonalizedOptOutClicked()
```

**Example**

```lua
C_CatalogShop.OnLegalPersonalizedOptOutClicked()
```

### C_CatalogShop.OpenCatalogShopInteractionFromHouse

```lua
shoppingSessionUUIDStr = C_CatalogShop.OpenCatalogShopInteractionFromHouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shoppingSessionUUIDStr` | string | no |  |

**Example**

```lua
local shoppingSessionUUIDStr = C_CatalogShop.OpenCatalogShopInteractionFromHouse()
```

### C_CatalogShop.OpenCatalogShopInteractionFromShop

```lua
shoppingSessionUUIDStr = C_CatalogShop.OpenCatalogShopInteractionFromShop()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shoppingSessionUUIDStr` | string | no |  |

**Example**

```lua
local shoppingSessionUUIDStr = C_CatalogShop.OpenCatalogShopInteractionFromShop()
```

### C_CatalogShop.ProductDisplayedTelemetry

```lua
C_CatalogShop.ProductDisplayedTelemetry(categoryId, sectionId, catalogShopProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryId` | number | no |  |
| `sectionId` | number | no |  |
| `catalogShopProductID` | number | no |  |

**Example**

```lua
C_CatalogShop.ProductDisplayedTelemetry(0, 0, 0)
```

### C_CatalogShop.ProductSelectedTelemetry

```lua
C_CatalogShop.ProductSelectedTelemetry(categoryId, sectionId, catalogShopProductID, wasCodeSelection)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryId` | number | no |  |
| `sectionId` | number | no |  |
| `catalogShopProductID` | number | no |  |
| `wasCodeSelection` | bool | no |  |

**Example**

```lua
C_CatalogShop.ProductSelectedTelemetry(0, 0, 0, false)
```

### C_CatalogShop.PurchaseProduct

```lua
canPurchase = C_CatalogShop.PurchaseProduct(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPurchase` | bool | no |  |

**Example**

```lua
local canPurchase = C_CatalogShop.PurchaseProduct(0)
```

### C_CatalogShop.RefreshRefundableDecors

```lua
C_CatalogShop.RefreshRefundableDecors()
```

**Example**

```lua
C_CatalogShop.RefreshRefundableDecors()
```

### C_CatalogShop.RefreshVirtualCurrencyBalance

```lua
C_CatalogShop.RefreshVirtualCurrencyBalance(currencyCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyCode` | string | no |  |

**Example**

```lua
C_CatalogShop.RefreshVirtualCurrencyBalance("")
```

### C_CatalogShop.ShouldShowHousingWarning

```lua
shouldShowHousingWarning = C_CatalogShop.ShouldShowHousingWarning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShowHousingWarning` | bool | no |  |

**Example**

```lua
local shouldShowHousingWarning = C_CatalogShop.ShouldShowHousingWarning()
```

### C_CatalogShop.StartHousingVCPurchaseConfirmation

```lua
C_CatalogShop.StartHousingVCPurchaseConfirmation(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Example**

```lua
C_CatalogShop.StartHousingVCPurchaseConfirmation(0)
```

## Events

### BULK_PURCHASE_RESULT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | BulkPurchaseResult | no |  |
| `productResults` | BulkPurchaseIndividualProductResult[] | no |  |
| `bestTopUpProductID` | number | yes |  |
| `totalCost` | number | yes |  |

### BULK_REFUND_RESULT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | BulkRefundResult | no |  |

### CATALOG_SHOP_ADD_PENDING_PRODUCT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

### CATALOG_SHOP_DATA_REFRESH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shoppingSessionUUIDStr` | string | yes |  |

### CATALOG_SHOP_DISABLED

### CATALOG_SHOP_FETCH_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shoppingSessionUUIDStr` | string | yes |  |

### CATALOG_SHOP_FETCH_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shoppingSessionUUIDStr` | string | yes |  |

### CATALOG_SHOP_OPEN_SIMPLE_CHECKOUT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checkoutID` | number | no |  |

### CATALOG_SHOP_PURCHASE_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

### CATALOG_SHOP_REBUILD_SCROLL_BOX

### CATALOG_SHOP_REFUNDABLE_DECORS_UPDATED

### CATALOG_SHOP_REMOVE_PENDING_PRODUCT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

### CATALOG_SHOP_RESULT_ERROR

### CATALOG_SHOP_SPECIFIC_PRODUCT_REFRESH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

### CATALOG_SHOP_VIRTUAL_CURRENCY_BALANCE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyCode` | string | no |  |
| `balance` | string | no |  |

### CATALOG_SHOP_VIRTUAL_CURRENCY_BALANCE_UPDATE_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyCode` | string | no |  |

### SET_SEEN_PRODUCTS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productIds` | number[] | no |  |

### SHOW_NEW_PRODUCT_NOTIFICATION

## Types

### AvailableRaceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |
| `displayName` | string | no |  |

### BulkPurchaseIndividualProductResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recordId` | number | no |  |
| `parentProductId` | number | yes |  |
| `entitlementId` | string | no |  |
| `externalTransactionId` | string | no |  |
| `status` | SimpleOrderStatus | no |  |

### CatalogShopBundleChildInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `childProductID` | number | no |  |
| `displayOrder` | number | no |  |
| `quantityInBundle` | number | no |  |

### CatalogShopCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `displayName` | string | no |  |
| `iconTexture` | string | no |  |
| `linkTag` | string | no |  |
| `isDisabled` | bool | no |  |
| `showPersistentRefundButton` | bool | no |  |

### CatalogShopProductDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultPreviewModelSceneID` | number | no |  |
| `defaultCardModelSceneID` | number | no |  |
| `defaultWideCardModelSceneID` | number | no |  |
| `itemID` | number | no |  |
| `overridePreviewModelSceneID` | number | yes |  |
| `overrideCardModelSceneID` | number | yes |  |
| `overrideWideCardModelSceneID` | number | yes |  |
| `creatureDisplayInfoIDs` | number[] | no |  |
| `spellVisualIDs` | number[] | no |  |
| `mainHandItemModifiedAppearanceID` | number | yes |  |
| `offHandItemModifiedAppearanceID` | number | yes |  |
| `itemModifiedAppearanceIDs` | number[] | no |  |
| `iconFileDataID` | number | yes |  |
| `iconTextureKit` | textureKit | yes |  |
| `productType` | string | yes |  |
| `itemDescription` | string | yes |  |
| `hasUnknownLicense` | bool | no |  |
| `productPMTURL` | string | yes |  |
| `additionalProductPMTURLs` | string[] | no |  |
| `otherProductImageAtlasName` | string | yes |  |
| `otherProductGameTitleBaseTag` | string | yes |  |
| `otherProductGameType` | string | yes |  |
| `customLoopingSoundStart` | number | yes |  |
| `customLoopingSoundMiddle` | number | yes |  |
| `customLoopingSoundEnd` | number | yes |  |
| `specialActorID_1` | string | yes |  |
| `specialActorID_2` | string | yes |  |
| `specialActorID_3` | string | yes |  |
| `specialActorID_4` | string | yes |  |
| `specialActorID_5` | string | yes |  |
| `gameFlavorID` | number | yes |  |
| `decorFileDataID` | number | yes |  |
| `quantity` | number | yes |  |
| `houseTextureAtlas` | textureAtlas | yes |  |

### CatalogShopProductInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `catalogShopProductID` | number | no |  |
| `name` | string | no |  |
| `type` | string | yes |  |
| `description` | string | no |  |
| `iconTexture` | string | no |  |
| `isFullyOwned` | bool | no |  |
| `isPurchasePending` | bool | no |  |
| `refundable` | bool | no |  |
| `price` | string | no |  |
| `originalPrice` | string | no |  |
| `discountPercentage` | number | no |  |
| `itemID` | number | no |  |
| `mountID` | number | no |  |
| `mountTypeName` | string | no |  |
| `speciesID` | number | no |  |
| `transmogSetID` | number | no |  |
| `itemModifiedAppearanceID` | number | no |  |
| `subItems` | CatalogShopSubItemInfo[] | no |  |
| `subItemsLoaded` | bool | no |  |
| `backgroundTexture` | string | no |  |
| `foregroundTexture` | string | yes |  |
| `smallCardBGTexture` | string | yes |  |
| `smallCardFGTexture` | string | yes |  |
| `wideCardBGTexture` | string | yes |  |
| `wideCardFGTexture` | string | yes |  |
| `previewIconTexture` | string | yes |  |
| `optionalWideCardBackgroundTexture` | string | yes |  |
| `isBundle` | bool | no |  |
| `bundleChildrenSize` | number | no |  |
| `licenseTermType` | number | no |  |
| `licenseTermDuration` | number | no |  |
| `virtualCurrencies` | CatalogShopVirtualCurrency[] | no |  |
| `isHidden` | bool | no |  |
| `isMystery` | bool | no |  |
| `hasPendingOrders` | bool | no |  |
| `numBundleDetailCards` | number | no |  |
| `isDynamicallyDiscounted` | bool | no |  |
| `shouldShowOriginalPrice` | bool | no |  |
| `wideCardBGOverrideProductURL` | string | yes |  |
| `previewBGOverrideProductURL` | string | yes |  |
| `previewSmallBGOverrideProductURL` | string | yes |  |
| `decorQuantity` | DecorQuantity | yes |  |
| `isVCProduct` | bool | no |  |
| `containsHousingItem` | bool | no |  |
| `deferredGameTimeDays` | number | no |  |

### CatalogShopSectionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `displayName` | string | no |  |
| `parentCatalogShopCategoryInfoID` | number | yes |  |
| `cardType` | string | yes |  |
| `scrollGridSize` | number | yes |  |
| `shouldShowRecommendationOptOutDisclaimer` | bool | no |  |

### CatalogShopSpellVisualInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animID` | number | yes |  |
| `spellVisualKitID` | number | yes |  |

### CatalogShopSubItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `itemID` | number | no |  |
| `itemAppearanceID` | number | no |  |
| `invType` | string | no |  |
| `quality` | ItemQuality | no |  |

### CatalogShopVCProductInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vcProductID` | number | no |  |

### CatalogShopVirtualCurrency (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |
| `currencyCode` | string | no |  |

### DecorQuantity (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `placedQuantity` | number | no |  |
| `storedQuantity` | number | no |  |

### RefundableDecorInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `timeRemainingSeconds` | time_t | no |  |
| `name` | string | no |  |
| `price` | string | no |  |

