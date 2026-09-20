# C_TransmogCollection

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**84** functions · **0** events · **8** types

## Functions

### C_TransmogCollection.AccountCanCollectSource

```lua
hasItemData, canCollect = C_TransmogCollection.AccountCanCollectSource(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasItemData` | bool | no |  |
| `canCollect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasItemData, canCollect = C_TransmogCollection.AccountCanCollectSource(0)
```

### C_TransmogCollection.AreAllCollectionTypeFiltersChecked

```lua
areAllCollectionTypeFiltersChecked = C_TransmogCollection.AreAllCollectionTypeFiltersChecked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAllCollectionTypeFiltersChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areAllCollectionTypeFiltersChecked = C_TransmogCollection.AreAllCollectionTypeFiltersChecked()
```

### C_TransmogCollection.AreAllSourceTypeFiltersChecked

```lua
areAllSourceTypeFiltersChecked = C_TransmogCollection.AreAllSourceTypeFiltersChecked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAllSourceTypeFiltersChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areAllSourceTypeFiltersChecked = C_TransmogCollection.AreAllSourceTypeFiltersChecked()
```

### C_TransmogCollection.CanAppearanceHaveIllusion

```lua
canHaveIllusion = C_TransmogCollection.CanAppearanceHaveIllusion(appearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canHaveIllusion` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canHaveIllusion = C_TransmogCollection.CanAppearanceHaveIllusion(0)
```

### C_TransmogCollection.ClearNewAppearance

```lua
C_TransmogCollection.ClearNewAppearance(visualID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.ClearNewAppearance(0)
```

### C_TransmogCollection.ClearSearch

```lua
completed = C_TransmogCollection.ClearSearch(searchType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `completed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local completed = C_TransmogCollection.ClearSearch(searchType)
```

### C_TransmogCollection.DeleteCustomSet

```lua
C_TransmogCollection.DeleteCustomSet(customSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.DeleteCustomSet(0)
```

### C_TransmogCollection.EndSearch

```lua
C_TransmogCollection.EndSearch()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.EndSearch()
```

### C_TransmogCollection.GetAllAppearanceSources

```lua
itemModifiedAppearanceIDs = C_TransmogCollection.GetAllAppearanceSources(itemAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemModifiedAppearanceIDs = C_TransmogCollection.GetAllAppearanceSources(6948)
```

### C_TransmogCollection.GetAllFactionsShown

```lua
shown = C_TransmogCollection.GetAllFactionsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shown = C_TransmogCollection.GetAllFactionsShown()
```

### C_TransmogCollection.GetAllRacesShown

```lua
shown = C_TransmogCollection.GetAllRacesShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shown = C_TransmogCollection.GetAllRacesShown()
```

### C_TransmogCollection.GetAppearanceCameraID

```lua
cameraID = C_TransmogCollection.GetAppearanceCameraID(itemAppearanceID, [variation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |
| `variation` | TransmogCameraVariation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cameraID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cameraID = C_TransmogCollection.GetAppearanceCameraID(6948)
```

### C_TransmogCollection.GetAppearanceCameraIDBySource

```lua
cameraID = C_TransmogCollection.GetAppearanceCameraIDBySource(itemModifiedAppearanceID, [variation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |
| `variation` | TransmogCameraVariation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cameraID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cameraID = C_TransmogCollection.GetAppearanceCameraIDBySource(6948)
```

### C_TransmogCollection.GetAppearanceInfoBySource

```lua
info = C_TransmogCollection.GetAppearanceInfoBySource(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | TransmogAppearanceInfoBySourceData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TransmogCollection.GetAppearanceInfoBySource(6948)
```

### C_TransmogCollection.GetAppearanceSourceDrops

```lua
encounterInfo = C_TransmogCollection.GetAppearanceSourceDrops(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterInfo` | TransmogAppearanceJournalEncounterInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local encounterInfo = C_TransmogCollection.GetAppearanceSourceDrops(6948)
```

### C_TransmogCollection.GetAppearanceSourceInfo

```lua
info = C_TransmogCollection.GetAppearanceSourceInfo(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | TransmogAppearanceSourceInfoData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TransmogCollection.GetAppearanceSourceInfo(6948)
```

### C_TransmogCollection.GetAppearanceSources

```lua
sources = C_TransmogCollection.GetAppearanceSources(appearanceID, [categoryType], [transmogLocation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |
| `categoryType` | TransmogCollectionType | yes |  |
| `transmogLocation` | TransmogLocation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | AppearanceSourceInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sources = C_TransmogCollection.GetAppearanceSources(0)
```

### C_TransmogCollection.GetArtifactAppearanceStrings

```lua
name, hyperlink = C_TransmogCollection.GetArtifactAppearanceStrings(appearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `hyperlink` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, hyperlink = C_TransmogCollection.GetArtifactAppearanceStrings(0)
```

### C_TransmogCollection.GetCategoryAppearances

```lua
appearances = C_TransmogCollection.GetCategoryAppearances(category, [transmogLocation], [option])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |
| `transmogLocation` | TransmogLocation | yes |  |
| `option` | TransmogOutfitSlotOption | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearances` | TransmogCategoryAppearanceInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local appearances = C_TransmogCollection.GetCategoryAppearances(category)
```

### C_TransmogCollection.GetCategoryCollectedCount

```lua
count = C_TransmogCollection.GetCategoryCollectedCount(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_TransmogCollection.GetCategoryCollectedCount(category)
```

### C_TransmogCollection.GetCategoryForItem

```lua
collectionCategory = C_TransmogCollection.GetCategoryForItem(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionCategory` | TransmogCollectionType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectionCategory = C_TransmogCollection.GetCategoryForItem(6948)
```

### C_TransmogCollection.GetCategoryInfo

```lua
name, isWeapon, canHaveIllusions, canMainHand, canOffHand, canRanged = C_TransmogCollection.GetCategoryInfo(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `isWeapon` | bool | no | (default: False) |
| `canHaveIllusions` | bool | no | (default: False) |
| `canMainHand` | bool | no | (default: False) |
| `canOffHand` | bool | no | (default: False) |
| `canRanged` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, isWeapon, canHaveIllusions, canMainHand, canOffHand, canRanged = C_TransmogCollection.GetCategoryInfo(category)
```

### C_TransmogCollection.GetCategoryTotal

```lua
total = C_TransmogCollection.GetCategoryTotal(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `total` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local total = C_TransmogCollection.GetCategoryTotal(category)
```

### C_TransmogCollection.GetClassFilter

```lua
classID = C_TransmogCollection.GetClassFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local classID = C_TransmogCollection.GetClassFilter()
```

### C_TransmogCollection.GetCollectedShown

```lua
shown = C_TransmogCollection.GetCollectedShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shown = C_TransmogCollection.GetCollectedShown()
```

### C_TransmogCollection.GetCustomSetHyperlinkFromItemTransmogInfoList

```lua
hyperlink = C_TransmogCollection.GetCustomSetHyperlinkFromItemTransmogInfoList(itemTransmogInfoList)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemTransmogInfoList` | ItemTransmogInfo[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hyperlink = C_TransmogCollection.GetCustomSetHyperlinkFromItemTransmogInfoList(6948)
```

### C_TransmogCollection.GetCustomSetInfo

```lua
name, icon = C_TransmogCollection.GetCustomSetInfo(customSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, icon = C_TransmogCollection.GetCustomSetInfo(0)
```

### C_TransmogCollection.GetCustomSetItemTransmogInfoList

```lua
list = C_TransmogCollection.GetCustomSetItemTransmogInfoList(customSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `list` | ItemTransmogInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local list = C_TransmogCollection.GetCustomSetItemTransmogInfoList(0)
```

### C_TransmogCollection.GetCustomSets

```lua
customSetID = C_TransmogCollection.GetCustomSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local customSetID = C_TransmogCollection.GetCustomSets()
```

### C_TransmogCollection.GetFallbackWeaponAppearance

```lua
appearanceID = C_TransmogCollection.GetFallbackWeaponAppearance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local appearanceID = C_TransmogCollection.GetFallbackWeaponAppearance()
```

### C_TransmogCollection.GetFilteredCategoryCollectedCount

```lua
count = C_TransmogCollection.GetFilteredCategoryCollectedCount(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_TransmogCollection.GetFilteredCategoryCollectedCount(category)
```

### C_TransmogCollection.GetFilteredCategoryTotal

```lua
total = C_TransmogCollection.GetFilteredCategoryTotal(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `total` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local total = C_TransmogCollection.GetFilteredCategoryTotal(category)
```

### C_TransmogCollection.GetIllusionInfo

```lua
info = C_TransmogCollection.GetIllusionInfo(illusionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `illusionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | TransmogIllusionInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TransmogCollection.GetIllusionInfo(0)
```

### C_TransmogCollection.GetIllusions

```lua
illusions = C_TransmogCollection.GetIllusions([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `illusions` | TransmogIllusionInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local illusions = C_TransmogCollection.GetIllusions()
```

### C_TransmogCollection.GetIllusionStrings

```lua
name, hyperlink, sourceText = C_TransmogCollection.GetIllusionStrings(illusionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `illusionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `hyperlink` | string | no |  |
| `sourceText` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, hyperlink, sourceText = C_TransmogCollection.GetIllusionStrings(0)
```

### C_TransmogCollection.GetInspectItemTransmogInfoList

```lua
list = C_TransmogCollection.GetInspectItemTransmogInfoList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `list` | ItemTransmogInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local list = C_TransmogCollection.GetInspectItemTransmogInfoList()
```

### C_TransmogCollection.GetIsAppearanceFavorite

```lua
isFavorite = C_TransmogCollection.GetIsAppearanceFavorite(itemAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFavorite = C_TransmogCollection.GetIsAppearanceFavorite(6948)
```

### C_TransmogCollection.GetItemInfo

```lua
itemAppearanceID, itemModifiedAppearanceID = C_TransmogCollection.GetItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |
| `itemModifiedAppearanceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemAppearanceID, itemModifiedAppearanceID = C_TransmogCollection.GetItemInfo(6948)
```

### C_TransmogCollection.GetItemTransmogInfoListFromCustomSetHyperlink

```lua
list = C_TransmogCollection.GetItemTransmogInfoListFromCustomSetHyperlink(hyperlink)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `list` | ItemTransmogInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local list = C_TransmogCollection.GetItemTransmogInfoListFromCustomSetHyperlink("")
```

### C_TransmogCollection.GetLatestAppearance

```lua
visualID, category = C_TransmogCollection.GetLatestAppearance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualID` | number | no |  |
| `category` | TransmogCollectionType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local visualID, category = C_TransmogCollection.GetLatestAppearance()
```

### C_TransmogCollection.GetNumMaxCustomSets

```lua
maxCustomSets = C_TransmogCollection.GetNumMaxCustomSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxCustomSets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxCustomSets = C_TransmogCollection.GetNumMaxCustomSets()
```

### C_TransmogCollection.GetNumTransmogSources

```lua
count = C_TransmogCollection.GetNumTransmogSources()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_TransmogCollection.GetNumTransmogSources()
```

### C_TransmogCollection.GetPairedArtifactAppearance

```lua
pairedItemModifiedAppearanceID = C_TransmogCollection.GetPairedArtifactAppearance(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pairedItemModifiedAppearanceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pairedItemModifiedAppearanceID = C_TransmogCollection.GetPairedArtifactAppearance(6948)
```

### C_TransmogCollection.GetSourceIcon

```lua
icon = C_TransmogCollection.GetSourceIcon(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local icon = C_TransmogCollection.GetSourceIcon(6948)
```

### C_TransmogCollection.GetSourceInfo

```lua
sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceInfo` | AppearanceSourceInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sourceInfo = C_TransmogCollection.GetSourceInfo(0)
```

### C_TransmogCollection.GetSourceItemID

```lua
itemID = C_TransmogCollection.GetSourceItemID(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID = C_TransmogCollection.GetSourceItemID(6948)
```

### C_TransmogCollection.GetSourceRequiredHoliday

```lua
holidayName = C_TransmogCollection.GetSourceRequiredHoliday(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `holidayName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local holidayName = C_TransmogCollection.GetSourceRequiredHoliday(6948)
```

### C_TransmogCollection.GetUncollectedShown

```lua
shown = C_TransmogCollection.GetUncollectedShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shown = C_TransmogCollection.GetUncollectedShown()
```

### C_TransmogCollection.GetValidAppearanceSourcesForClass

```lua
sources = C_TransmogCollection.GetValidAppearanceSourcesForClass(appearanceID, classID, [categoryType], [transmogLocation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |
| `classID` | number | no |  |
| `categoryType` | TransmogCollectionType | yes |  |
| `transmogLocation` | TransmogLocation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | AppearanceSourceInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sources = C_TransmogCollection.GetValidAppearanceSourcesForClass(0, 0)
```

### C_TransmogCollection.HasAnyAppearance

```lua
hasAnyAppearance = C_TransmogCollection.HasAnyAppearance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyAppearance` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnyAppearance = C_TransmogCollection.HasAnyAppearance()
```

### C_TransmogCollection.HasFavorites

```lua
hasFavorites = C_TransmogCollection.HasFavorites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFavorites` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFavorites = C_TransmogCollection.HasFavorites()
```

### C_TransmogCollection.IsAppearanceHiddenVisual

```lua
isHiddenVisual = C_TransmogCollection.IsAppearanceHiddenVisual(appearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHiddenVisual` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHiddenVisual = C_TransmogCollection.IsAppearanceHiddenVisual(0)
```

### C_TransmogCollection.IsCategoryValidForItem

```lua
isValid = C_TransmogCollection.IsCategoryValidForItem(category, itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_TransmogCollection.IsCategoryValidForItem(category, 6948)
```

### C_TransmogCollection.IsNewAppearance

```lua
isNew = C_TransmogCollection.IsNewAppearance(visualID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNew` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isNew = C_TransmogCollection.IsNewAppearance(0)
```

### C_TransmogCollection.IsSearchDBLoading

```lua
isLoading = C_TransmogCollection.IsSearchDBLoading()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoading` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLoading = C_TransmogCollection.IsSearchDBLoading()
```

### C_TransmogCollection.IsSearchInProgress

```lua
inProgress = C_TransmogCollection.IsSearchInProgress(searchType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inProgress` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inProgress = C_TransmogCollection.IsSearchInProgress(searchType)
```

### C_TransmogCollection.IsSourceTypeFilterChecked

```lua
checked = C_TransmogCollection.IsSourceTypeFilterChecked(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local checked = C_TransmogCollection.IsSourceTypeFilterChecked(1)
```

### C_TransmogCollection.IsSpellItemEnchantmentHiddenVisual

```lua
isHiddenVisual = C_TransmogCollection.IsSpellItemEnchantmentHiddenVisual(spellItemEnchantmentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellItemEnchantmentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHiddenVisual` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHiddenVisual = C_TransmogCollection.IsSpellItemEnchantmentHiddenVisual(2050)
```

### C_TransmogCollection.IsUsingDefaultFilters

```lua
isUsingDefaultFilters = C_TransmogCollection.IsUsingDefaultFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultFilters` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsingDefaultFilters = C_TransmogCollection.IsUsingDefaultFilters()
```

### C_TransmogCollection.IsValidCustomSetName

```lua
isApproved = C_TransmogCollection.IsValidCustomSetName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApproved` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isApproved = C_TransmogCollection.IsValidCustomSetName("")
```

### C_TransmogCollection.IsValidTransmogSource

```lua
valid = C_TransmogCollection.IsValidTransmogSource(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | TransmogSource | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_TransmogCollection.IsValidTransmogSource(source)
```

### C_TransmogCollection.ModifyCustomSet

```lua
C_TransmogCollection.ModifyCustomSet(customSetID, itemTransmogInfoList)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | no |  |
| `itemTransmogInfoList` | ItemTransmogInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.ModifyCustomSet(0, 6948)
```

### C_TransmogCollection.NewCustomSet

```lua
customSetID = C_TransmogCollection.NewCustomSet(name, icon, itemTransmogInfoList)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | no |  |
| `itemTransmogInfoList` | ItemTransmogInfo[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local customSetID = C_TransmogCollection.NewCustomSet("", 0, 6948)
```

### C_TransmogCollection.PlayerCanCollectSource

```lua
hasItemData, canCollect = C_TransmogCollection.PlayerCanCollectSource(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasItemData` | bool | no |  |
| `canCollect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasItemData, canCollect = C_TransmogCollection.PlayerCanCollectSource(0)
```

### C_TransmogCollection.PlayerHasTransmog

```lua
hasTransmog = C_TransmogCollection.PlayerHasTransmog(itemID, itemAppearanceModID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemAppearanceModID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTransmog` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasTransmog = C_TransmogCollection.PlayerHasTransmog(6948, 6948)
```

### C_TransmogCollection.PlayerHasTransmogByItemInfo

```lua
hasTransmog = C_TransmogCollection.PlayerHasTransmogByItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTransmog` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasTransmog = C_TransmogCollection.PlayerHasTransmogByItemInfo(6948)
```

### C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance

```lua
hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTransmog` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(6948)
```

### C_TransmogCollection.PlayerKnowsSource

```lua
isKnown = C_TransmogCollection.PlayerKnowsSource(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKnown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isKnown = C_TransmogCollection.PlayerKnowsSource(0)
```

### C_TransmogCollection.RenameCustomSet

```lua
C_TransmogCollection.RenameCustomSet(customSetID, name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customSetID` | number | no |  |
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.RenameCustomSet(0, "")
```

### C_TransmogCollection.SearchProgress

```lua
progress = C_TransmogCollection.SearchProgress(searchType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local progress = C_TransmogCollection.SearchProgress(searchType)
```

### C_TransmogCollection.SearchSize

```lua
size = C_TransmogCollection.SearchSize(searchType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `size` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local size = C_TransmogCollection.SearchSize(searchType)
```

### C_TransmogCollection.SetAllCollectionTypeFilters

```lua
C_TransmogCollection.SetAllCollectionTypeFilters(checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetAllCollectionTypeFilters(false)
```

### C_TransmogCollection.SetAllFactionsShown

```lua
C_TransmogCollection.SetAllFactionsShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetAllFactionsShown(false)
```

### C_TransmogCollection.SetAllRacesShown

```lua
C_TransmogCollection.SetAllRacesShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetAllRacesShown(false)
```

### C_TransmogCollection.SetAllSourceTypeFilters

```lua
C_TransmogCollection.SetAllSourceTypeFilters(checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetAllSourceTypeFilters(false)
```

### C_TransmogCollection.SetClassFilter

```lua
C_TransmogCollection.SetClassFilter(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetClassFilter(0)
```

### C_TransmogCollection.SetCollectedShown

```lua
C_TransmogCollection.SetCollectedShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetCollectedShown(false)
```

### C_TransmogCollection.SetDefaultFilters

```lua
C_TransmogCollection.SetDefaultFilters()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetDefaultFilters()
```

### C_TransmogCollection.SetIsAppearanceFavorite

```lua
C_TransmogCollection.SetIsAppearanceFavorite(itemAppearanceID, isFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetIsAppearanceFavorite(6948, false)
```

### C_TransmogCollection.SetSearch

```lua
completed = C_TransmogCollection.SetSearch(searchType, searchText)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |
| `searchText` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `completed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local completed = C_TransmogCollection.SetSearch(searchType, "")
```

### C_TransmogCollection.SetSearchAndFilterCategory

```lua
C_TransmogCollection.SetSearchAndFilterCategory(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetSearchAndFilterCategory(category)
```

### C_TransmogCollection.SetSourceTypeFilter

```lua
C_TransmogCollection.SetSourceTypeFilter(index, checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetSourceTypeFilter(1, false)
```

### C_TransmogCollection.SetUncollectedShown

```lua
C_TransmogCollection.SetUncollectedShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.SetUncollectedShown(false)
```

### C_TransmogCollection.UpdateUsableAppearances

```lua
C_TransmogCollection.UpdateUsableAppearances()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TransmogCollection.UpdateUsableAppearances()
```

## Types

### TransmogAppearanceInfoBySourceData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |
| `appearanceIsCollected` | bool | no |  |
| `sourceIsCollected` | bool | no |  |
| `sourceIsCollectedPermanent` | bool | no |  |
| `sourceIsCollectedConditional` | bool | no |  |
| `meetsTransmogPlayerCondition` | bool | no |  |
| `appearanceHasAnyNonLevelRequirements` | bool | no |  |
| `appearanceMeetsNonLevelRequirements` | bool | no |  |
| `appearanceIsUsable` | bool | no |  |
| `appearanceNumSources` | number | no |  |
| `sourceIsKnown` | bool | no |  |
| `canDisplayOnPlayer` | bool | no |  |
| `isAnySourceValidForPlayer` | bool | no |  |

### TransmogAppearanceJournalEncounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `instance` | string | no |  |
| `instanceType` | number | no |  |
| `tiers` | string[] | no |  |
| `encounter` | string | no |  |
| `difficulties` | string[] | no |  |

### TransmogAppearanceSourceInfoData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | TransmogCollectionType | no |  |
| `itemAppearanceID` | number | no |  |
| `canHaveIllusion` | bool | no |  |
| `icon` | fileID | no |  |
| `isCollected` | bool | no |  |
| `itemLink` | string | no |  |
| `transmoglink` | string | no |  |
| `sourceType` | luaIndex | yes |  |
| `itemSubclass` | number | no |  |
| `ignoreModelAttachmentChecksForIllusion` | bool | no |  |

### TransmogCameraVariation (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | TransmogCameraVariation | no |  |
| `RightShoulder` | TransmogCameraVariation | no |  |
| `CloakBackpack` | TransmogCameraVariation | no |  |

### TransmogCategoryAppearanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualID` | number | no |  |
| `isCollected` | bool | no |  |
| `isFavorite` | bool | no |  |
| `isHideVisual` | bool | no |  |
| `canDisplayOnPlayer` | bool | no |  |
| `uiOrder` | number | no |  |
| `exclusions` | number | no |  |
| `isUsable` | bool | no |  |
| `hasRequiredHoliday` | bool | no |  |
| `hasActiveRequiredHoliday` | bool | no |  |
| `minIlvl` | number | no |  |
| `isValidForEquippedItem` | bool | no |  |
| `alwaysShowItem` | bool | yes | For internal testing only |

### TransmogCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `isWeapon` | bool | no | (default: False) |
| `canHaveIllusions` | bool | no | (default: False) |
| `canMainHand` | bool | no | (default: False) |
| `canOffHand` | bool | no | (default: False) |
| `canRanged` | bool | no | (default: False) |

### TransmogCustomSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

### TransmogIllusionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualID` | number | no |  |
| `sourceID` | number | no |  |
| `icon` | fileID | no |  |
| `isCollected` | bool | no |  |
| `isUsable` | bool | no |  |
| `isHideVisual` | bool | no |  |

