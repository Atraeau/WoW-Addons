# C_HousingCatalog

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**34** functions · **8** events · **10** types

## Functions

### C_HousingCatalog.CreateCatalogSearcher

Creates a new instance of a HousingCatalog searcher; This can be used to asynchronously search/filter the HousingCatalog without affecting/being restricted by the filter state of other Housing Catalog UI displays

```lua
searcher = C_HousingCatalog.CreateCatalogSearcher()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searcher` | HousingCatalogSearcher | no |  |

**Example**

```lua
local searcher = C_HousingCatalog.CreateCatalogSearcher()
```

### C_HousingCatalog.DeletePreviewCartDecor

```lua
C_HousingCatalog.DeletePreviewCartDecor(decorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Example**

```lua
C_HousingCatalog.DeletePreviewCartDecor("Creature-0-0000-0-0-0-0")
```

### C_HousingCatalog.DestroyEntry

Attempt to delete the entry from storage

```lua
C_HousingCatalog.DestroyEntry(entryVariantID, destroyAll)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | no |  |
| `destroyAll` | bool | no | If true, deletes all entries within the stack; If false, will only delete one |

**Example**

```lua
C_HousingCatalog.DestroyEntry(entryVariantID, false)
```

### C_HousingCatalog.GetAllFilterTagGroups

```lua
filterTagGroups = C_HousingCatalog.GetAllFilterTagGroups()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterTagGroups` | HousingCatalogFilterTagGroupInfo[] | no |  |

**Example**

```lua
local filterTagGroups = C_HousingCatalog.GetAllFilterTagGroups()
```

### C_HousingCatalog.GetAllVariantInfosForEntry

Returns variant info for all variants of a given catalog entry; Variants represent different visual modifications of the same base entry (ex: dyed versions)

```lua
variantInfos = C_HousingCatalog.GetAllVariantInfosForEntry(entryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | HousingCatalogEntryID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `variantInfos` | HousingCatalogEntryVariantInfo[] | no |  |

**Example**

```lua
local variantInfos = C_HousingCatalog.GetAllVariantInfosForEntry(entryID)
```

### C_HousingCatalog.GetBundleInfo

```lua
bundleInfo = C_HousingCatalog.GetBundleInfo(bundleCatalogShopProductID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bundleCatalogShopProductID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bundleInfo` | HousingBundleInfo | yes |  |

**Example**

```lua
local bundleInfo = C_HousingCatalog.GetBundleInfo(0)
```

### C_HousingCatalog.GetCartSizeLimit

```lua
cartSizeLimit = C_HousingCatalog.GetCartSizeLimit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cartSizeLimit` | number | no |  |

**Example**

```lua
local cartSizeLimit = C_HousingCatalog.GetCartSizeLimit()
```

### C_HousingCatalog.GetCatalogCategoryAndSubcategoryNames

If found, returns the names of the parent category and the specified subcategory

```lua
categoryName, subcategoryName = C_HousingCatalog.GetCatalogCategoryAndSubcategoryNames(subcategoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryName` | string | no |  |
| `subcategoryName` | string | no |  |

**Example**

```lua
local categoryName, subcategoryName = C_HousingCatalog.GetCatalogCategoryAndSubcategoryNames(0)
```

### C_HousingCatalog.GetCatalogCategoryInfo

```lua
info = C_HousingCatalog.GetCatalogCategoryInfo(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogCategoryInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogCategoryInfo(0)
```

### C_HousingCatalog.GetCatalogEntryInfo

```lua
info = C_HousingCatalog.GetCatalogEntryInfo(entryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | HousingCatalogEntryID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogEntryInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogEntryInfo(entryID)
```

### C_HousingCatalog.GetCatalogEntryInfoByItem

```lua
info = C_HousingCatalog.GetCatalogEntryInfoByItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no | ItemID, name, or link of an item that grants/corresponds to a particular type of housing catalog object (ex: decor) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogEntryInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogEntryInfoByItem(6948)
```

### C_HousingCatalog.GetCatalogEntryInfoByRecordID

```lua
info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(entryType, recordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryType` | HousingCatalogEntryType | no |  |
| `recordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogEntryInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(entryType, 0)
```

### C_HousingCatalog.GetCatalogEntryRefundTimeStampByRecordID

```lua
refundTimeStamp = C_HousingCatalog.GetCatalogEntryRefundTimeStampByRecordID(entryType, recordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryType` | HousingCatalogEntryType | no |  |
| `recordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundTimeStamp` | time_t | yes |  |

**Example**

```lua
local refundTimeStamp = C_HousingCatalog.GetCatalogEntryRefundTimeStampByRecordID(entryType, 0)
```

### C_HousingCatalog.GetCatalogEntryVariantInfo

```lua
info = C_HousingCatalog.GetCatalogEntryVariantInfo(entryVariantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogEntryVariantInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogEntryVariantInfo(entryVariantID)
```

### C_HousingCatalog.GetCatalogSubcategoryInfo

```lua
info = C_HousingCatalog.GetCatalogSubcategoryInfo(subcategoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingCatalogSubcategoryInfo | yes |  |

**Example**

```lua
local info = C_HousingCatalog.GetCatalogSubcategoryInfo(0)
```

### C_HousingCatalog.GetDecorMaxOwnedCount

Returns the maximum total number of decor that can be in storage/in the house chest; Note that not all decor entries in storage count towards this limit (see GetDecorTotalOwnedCount)

```lua
maxOwnedCount = C_HousingCatalog.GetDecorMaxOwnedCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxOwnedCount` | number | no |  |

**Example**

```lua
local maxOwnedCount = C_HousingCatalog.GetDecorMaxOwnedCount()
```

### C_HousingCatalog.GetDecorTotalOwnedCount

```lua
totalOwnedCount, exemptDecorCount = C_HousingCatalog.GetDecorTotalOwnedCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalOwnedCount` | number | no | The total number of owned decor in storage, including both exempt and non-exempt decor |
| `exemptDecorCount` | number | no | The number of decor that do not count against the max storage limit |

**Example**

```lua
local totalOwnedCount, exemptDecorCount = C_HousingCatalog.GetDecorTotalOwnedCount()
```

### C_HousingCatalog.GetDestroyableInstanceCount

Returns the number of instances that can be to be destroyed in storage; These instances count towards the max storage limit

```lua
destroyableInstanceCount = C_HousingCatalog.GetDestroyableInstanceCount(entryVariantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `destroyableInstanceCount` | number | no |  |

**Example**

```lua
local destroyableInstanceCount = C_HousingCatalog.GetDestroyableInstanceCount(entryVariantID)
```

### C_HousingCatalog.GetFeaturedBundles

```lua
bundleInfos = C_HousingCatalog.GetFeaturedBundles()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bundleInfos` | HousingBundleInfo[] | no |  |

**Example**

```lua
local bundleInfos = C_HousingCatalog.GetFeaturedBundles()
```

### C_HousingCatalog.GetFeaturedSmallProducts

```lua
infos = C_HousingCatalog.GetFeaturedSmallProducts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infos` | HousingFeaturedSmallProductInfo[] | no |  |

**Example**

```lua
local infos = C_HousingCatalog.GetFeaturedSmallProducts()
```

### C_HousingCatalog.GetMarketInfoForDecor

Returns market info for a specific decor. This is decor-only for now but should be extended to support entry type and recordID generically

```lua
marketInfo = C_HousingCatalog.GetMarketInfoForDecor(decorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `marketInfo` | HousingMarketInfo | yes |  |

**Example**

```lua
local marketInfo = C_HousingCatalog.GetMarketInfoForDecor(0)
```

### C_HousingCatalog.HasFeaturedEntries

```lua
hasEntries = C_HousingCatalog.HasFeaturedEntries()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasEntries` | bool | no |  |

**Example**

```lua
local hasEntries = C_HousingCatalog.HasFeaturedEntries()
```

### C_HousingCatalog.HousingMarketActionAddToCart

```lua
C_HousingCatalog.HousingMarketActionAddToCart(productID, withPreview)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |
| `withPreview` | bool | no |  |

**Example**

```lua
C_HousingCatalog.HousingMarketActionAddToCart(0, false)
```

### C_HousingCatalog.HousingMarketActionClearCart

```lua
C_HousingCatalog.HousingMarketActionClearCart()
```

**Example**

```lua
C_HousingCatalog.HousingMarketActionClearCart()
```

### C_HousingCatalog.HousingMarketActionRemoveFromCart

```lua
C_HousingCatalog.HousingMarketActionRemoveFromCart(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Example**

```lua
C_HousingCatalog.HousingMarketActionRemoveFromCart(0)
```

### C_HousingCatalog.HousingMarketActionViewBundle

```lua
C_HousingCatalog.HousingMarketActionViewBundle(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Example**

```lua
C_HousingCatalog.HousingMarketActionViewBundle(0)
```

### C_HousingCatalog.HousingMarketActionViewInStore

```lua
C_HousingCatalog.HousingMarketActionViewInStore(productID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Example**

```lua
C_HousingCatalog.HousingMarketActionViewInStore(0)
```

### C_HousingCatalog.IsPreviewCartItemShown

```lua
isShown = C_HousingCatalog.IsPreviewCartItemShown(decorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isShown` | bool | no |  |

**Example**

```lua
local isShown = C_HousingCatalog.IsPreviewCartItemShown("Creature-0-0000-0-0-0-0")
```

### C_HousingCatalog.PromotePreviewDecor

```lua
success = C_HousingCatalog.PromotePreviewDecor(decorID, previewDecorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |
| `previewDecorGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_HousingCatalog.PromotePreviewDecor(0, "Creature-0-0000-0-0-0-0")
```

### C_HousingCatalog.RequestHousingMarketInfoRefresh

```lua
C_HousingCatalog.RequestHousingMarketInfoRefresh()
```

**Example**

```lua
C_HousingCatalog.RequestHousingMarketInfoRefresh()
```

### C_HousingCatalog.RequestHousingMarketRefundInfo

```lua
C_HousingCatalog.RequestHousingMarketRefundInfo()
```

**Example**

```lua
C_HousingCatalog.RequestHousingMarketRefundInfo()
```

### C_HousingCatalog.SearchCatalogCategories

```lua
categoryIDs = C_HousingCatalog.SearchCatalogCategories(searchParams)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchParams` | HousingCategorySearchInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryIDs` | number[] | no |  |

**Example**

```lua
local categoryIDs = C_HousingCatalog.SearchCatalogCategories(searchParams)
```

### C_HousingCatalog.SearchCatalogSubcategories

```lua
subcategoryIDs = C_HousingCatalog.SearchCatalogSubcategories(searchParams)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchParams` | HousingCategorySearchInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryIDs` | number[] | no |  |

**Example**

```lua
local subcategoryIDs = C_HousingCatalog.SearchCatalogSubcategories(searchParams)
```

### C_HousingCatalog.SetPreviewCartItemShown

```lua
C_HousingCatalog.SetPreviewCartItemShown(decorGUID, shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `shown` | bool | no |  |

**Example**

```lua
C_HousingCatalog.SetPreviewCartItemShown("Creature-0-0000-0-0-0-0", false)
```

## Events

### HOUSING_CATALOG_CATEGORY_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

### HOUSING_CATALOG_SUBCATEGORY_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryID` | number | no |  |

### HOUSING_DECOR_ADD_TO_PREVIEW_LIST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previewItemData` | HousingPreviewItemData | no |  |

### HOUSING_DECOR_PREVIEW_LIST_REMOVE_FROM_WORLD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

### HOUSING_DECOR_PREVIEW_LIST_UPDATED

### HOUSING_REFUND_LIST_UPDATED

### HOUSING_STORAGE_ENTRY_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | no |  |

### HOUSING_STORAGE_UPDATED

## Types

### HousingBundleDecorEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |
| `quantity` | number | no |  |

### HousingBundleInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |
| `price` | number | no |  |
| `originalPrice` | number | yes |  |
| `nonDecorProducts` | number[] | no |  |
| `decorEntries` | HousingBundleDecorEntryInfo[] | no |  |
| `canPreview` | bool | no | Bundles containing non-decor items cannot be previewed (default: True) |

### HousingCatalogCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `orderIndex` | number | no |  |
| `name` | cstring | yes |  |
| `icon` | textureAtlas | yes |  |
| `subcategoryIDs` | number[] | no |  |
| `anyStoredEntries` | bool | no | True if the player owns anything that falls under this category |

### HousingCatalogEntryInfo (Structure)

Base information about an object in the Catalog; For info for a specific owned stack of this object, see HousingCatalogEntryVariantInfo

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recordID` | number | no |  |
| `entryType` | HousingCatalogEntryType | no |  |
| `itemID` | number | yes |  |
| `name` | cstring | no |  |
| `asset` | ModelAsset | yes | 3D model asset for displaying in the UI; May be nil if the entry doesn't have a model, or has one that isn't supported by UI model scenes |
| `iconTexture` | FileAsset | yes | Entry icon in the form of a texture file; Catalog entries should have either this OR an iconAtlas set |
| `iconAtlas` | textureAtlas | yes | Entry icon in the form a texture atlas element; Catalog entries should have either this OR an iconTexture set |
| `uiModelSceneID` | number | yes | Specific UI model scene ID to use when previewing this entry's 3D model; If not set, the default catalog model scene is used |
| `categoryIDs` | number[] | no |  |
| `subcategoryIDs` | number[] | no |  |
| `dataTagsByID` | LuaValueVariant | no | Simple localized 'tag' strings that are primarily used for things like categorization and filtering |
| `size` | HousingCatalogEntrySize | no |  |
| `placementCost` | number | no | How much of the applicable budget placing this entry would cost (if any) |
| `totalNumStored` | number | no | The total number of instances of this entry that exist in storage across all variants; Does not include unredeemed instances (see remainingRedeemable) |
| `remainingRedeemable` | number | no | The number of unredeemed instances of this entry that exist in storage; Some auto-awarded housing objects are granted in this 'lazily-instantiated' way, and will be 'redeemed' on first being placed |
| `totalNumPlaced` | number | no | The total number of instances of this entry that have been placed across all of the player's houses and plots, across all variants |
| `destroyableInstanceCount` | number | no | The number of instances that can be destroyed for this entry. |
| `isUniqueTrophy` | bool | no | This decor is flagged to display as a unique trophy item. |
| `isAllowedOutdoors` | bool | no | True if this entry is something that is allowed to be placed outside, within a plot |
| `isAllowedIndoors` | bool | no | True if this entry is something that is allowed to be placed indoors, within a house interior |
| `canCustomize` | bool | no | True if this entry is something that can be customized; Kinds of customization vary depending on the entry type |
| `isPrefab` | bool | no |  |
| `quality` | ItemQuality | yes |  |
| `firstAcquisitionBonus` | number | no | House XP that can be gained upon acquiring this entry for the first time |
| `sourceText` | cstring | no | Describes specific sources this entry may be gained from; Faction-specific sources may or may not be included based on the current player's faction |

### HousingCatalogEntryVariantInfo (Structure)

Represents a single stack of instances of an object in the Catalog, that are all of a specific variation; For example, a stack of undyed chairs, or blue-dyed tables

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | no |  |
| `numStored` | number | no | The number of instances of this specific variant that exist in storage |
| `dyeSlots` | HousingDecorDyeSlot[] | no | Dye slot information for this variant; Empty for entries that can't be dyed |

### HousingCatalogSubcategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `orderIndex` | number | no |  |
| `parentCategoryID` | number | no |  |
| `name` | cstring | yes |  |
| `icon` | textureAtlas | yes |  |
| `anyStoredEntries` | bool | no | True if the player owns anything that falls under this subcategory |

### HousingCategorySearchInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `withStoredEntriesOnly` | bool | no | If true, search will only return categories/subcategories that the player has something stored under (default: False) |
| `includeFeaturedCategory` | bool | no | (default: False) |
| `editorModeContext` | HouseEditorMode | yes | If set, will restrict results to only categories associated with/used by this Editor Mode |

### HousingFeaturedSmallProductInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryVariantID` | HousingCatalogEntryVariantID | yes |  |
| `productID` | number | no |  |
| `price` | number | no |  |
| `originalPrice` | number | yes |  |
| `canPreview` | bool | no |  |

### HousingMarketInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `price` | number | no |  |
| `productID` | number | no |  |
| `bundleIDs` | number[] | no |  |

### HousingPreviewItemData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | yes |  |
| `productID` | number | yes |  |
| `bundleCatalogShopProductID` | number | yes |  |
| `isBundleParent` | bool | no |  |
| `isBundleChild` | bool | no |  |
| `id` | number | no |  |
| `decorID` | number | no |  |
| `name` | string | no |  |
| `icon` | number | no |  |
| `price` | number | no |  |
| `salePrice` | number | yes |  |

