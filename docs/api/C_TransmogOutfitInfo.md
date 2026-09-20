# C_TransmogOutfitInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**67** functions · **8** events · **12** types

## Functions

### C_TransmogOutfitInfo.AddNewOutfit

```lua
C_TransmogOutfitInfo.AddNewOutfit(name, icon)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

**Example**

```lua
C_TransmogOutfitInfo.AddNewOutfit("", icon)
```

### C_TransmogOutfitInfo.CanPlayerTransmogSlot

```lua
valid = C_TransmogOutfitInfo.CanPlayerTransmogSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example**

```lua
local valid = C_TransmogOutfitInfo.CanPlayerTransmogSlot(1)
```

### C_TransmogOutfitInfo.ChangeDisplayedOutfit

```lua
C_TransmogOutfitInfo.ChangeDisplayedOutfit(outfitID, trigger, toggleLock, allowRemoveOutfit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |
| `trigger` | TransmogSituationTrigger | no |  |
| `toggleLock` | bool | no |  |
| `allowRemoveOutfit` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.ChangeDisplayedOutfit(0, trigger, false, false)
```

### C_TransmogOutfitInfo.ChangeToOutfit

```lua
C_TransmogOutfitInfo.ChangeToOutfit(playerFacingOutfitIndex, allowRemoveOutfit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerFacingOutfitIndex` | number | no |  |
| `allowRemoveOutfit` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.ChangeToOutfit(1, false)
```

### C_TransmogOutfitInfo.ChangeViewedOutfit

```lua
C_TransmogOutfitInfo.ChangeViewedOutfit(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Example**

```lua
C_TransmogOutfitInfo.ChangeViewedOutfit(0)
```

### C_TransmogOutfitInfo.ClearAllPendingSituations

```lua
C_TransmogOutfitInfo.ClearAllPendingSituations()
```

**Example**

```lua
C_TransmogOutfitInfo.ClearAllPendingSituations()
```

### C_TransmogOutfitInfo.ClearAllPendingTransmogs

```lua
C_TransmogOutfitInfo.ClearAllPendingTransmogs()
```

**Example**

```lua
C_TransmogOutfitInfo.ClearAllPendingTransmogs()
```

### C_TransmogOutfitInfo.ClearDisplayedOutfit

```lua
C_TransmogOutfitInfo.ClearDisplayedOutfit(trigger, toggleLock)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trigger` | TransmogSituationTrigger | no |  |
| `toggleLock` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.ClearDisplayedOutfit(trigger, false)
```

### C_TransmogOutfitInfo.ClearOutfit

```lua
C_TransmogOutfitInfo.ClearOutfit()
```

**Example**

```lua
C_TransmogOutfitInfo.ClearOutfit()
```

### C_TransmogOutfitInfo.CommitAndApplyAllPending

```lua
C_TransmogOutfitInfo.CommitAndApplyAllPending(useAvailableDiscount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useAvailableDiscount` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.CommitAndApplyAllPending(false)
```

### C_TransmogOutfitInfo.CommitOutfitInfo

```lua
C_TransmogOutfitInfo.CommitOutfitInfo(outfitID, name, icon)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

**Example**

```lua
C_TransmogOutfitInfo.CommitOutfitInfo(0, "", icon)
```

### C_TransmogOutfitInfo.CommitPendingSituations

```lua
C_TransmogOutfitInfo.CommitPendingSituations()
```

**Example**

```lua
C_TransmogOutfitInfo.CommitPendingSituations()
```

### C_TransmogOutfitInfo.GetActiveOutfitID

```lua
outfitID = C_TransmogOutfitInfo.GetActiveOutfitID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Example**

```lua
local outfitID = C_TransmogOutfitInfo.GetActiveOutfitID()
```

### C_TransmogOutfitInfo.GetAllSlotLocationInfo

```lua
appearanceSlotInfo, illusionSlotInfo = C_TransmogOutfitInfo.GetAllSlotLocationInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceSlotInfo` | TransmogOutfitSlotInfo[] | no |  |
| `illusionSlotInfo` | TransmogOutfitSlotInfo[] | no |  |

**Example**

```lua
local appearanceSlotInfo, illusionSlotInfo = C_TransmogOutfitInfo.GetAllSlotLocationInfo()
```

### C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo

```lua
categoryInfo = C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo(imaID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `imaID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryInfo` | TransmogOutfitOptionSheatheCategoryInfo[] | no |  |

**Example**

```lua
local categoryInfo = C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo(0)
```

### C_TransmogOutfitInfo.GetCollectionInfoForSlotAndOption

```lua
collectionInfo = C_TransmogOutfitInfo.GetCollectionInfoForSlotAndOption(slot, option, collectionType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `option` | TransmogOutfitSlotOption | no |  |
| `collectionType` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionInfo` | TransmogOutfitCollectionInfo | no |  |

**Example**

```lua
local collectionInfo = C_TransmogOutfitInfo.GetCollectionInfoForSlotAndOption(1, option, collectionType)
```

### C_TransmogOutfitInfo.GetCurrentlyViewedOutfitID

```lua
outfitID = C_TransmogOutfitInfo.GetCurrentlyViewedOutfitID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Example**

```lua
local outfitID = C_TransmogOutfitInfo.GetCurrentlyViewedOutfitID()
```

### C_TransmogOutfitInfo.GetEquippedSlotOptionFromTransmogSlot

```lua
option = C_TransmogOutfitInfo.GetEquippedSlotOptionFromTransmogSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `option` | TransmogOutfitSlotOption | no |  |

**Example**

```lua
local option = C_TransmogOutfitInfo.GetEquippedSlotOptionFromTransmogSlot(1)
```

### C_TransmogOutfitInfo.GetIllusionDefaultIMAIDForCollectionType

```lua
imaID = C_TransmogOutfitInfo.GetIllusionDefaultIMAIDForCollectionType(collectionType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionType` | TransmogCollectionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `imaID` | number | no |  |

**Example**

```lua
local imaID = C_TransmogOutfitInfo.GetIllusionDefaultIMAIDForCollectionType(collectionType)
```

### C_TransmogOutfitInfo.GetItemModifiedAppearanceEffectiveCategory

```lua
categoryID = C_TransmogOutfitInfo.GetItemModifiedAppearanceEffectiveCategory(imaID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `imaID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | TransmogCollectionType | no |  |

**Example**

```lua
local categoryID = C_TransmogOutfitInfo.GetItemModifiedAppearanceEffectiveCategory(0)
```

### C_TransmogOutfitInfo.GetLinkedSlotInfo

```lua
linkedSlotInfo = C_TransmogOutfitInfo.GetLinkedSlotInfo(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `linkedSlotInfo` | TransmogOutfitLinkedSlotInfo | no |  |

**Example**

```lua
local linkedSlotInfo = C_TransmogOutfitInfo.GetLinkedSlotInfo(1)
```

### C_TransmogOutfitInfo.GetMaxNumberOfTotalOutfitsForSource

```lua
maxOutfitCount = C_TransmogOutfitInfo.GetMaxNumberOfTotalOutfitsForSource(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | TransmogOutfitEntrySource | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxOutfitCount` | number | no |  |

**Example**

```lua
local maxOutfitCount = C_TransmogOutfitInfo.GetMaxNumberOfTotalOutfitsForSource(source)
```

### C_TransmogOutfitInfo.GetMaxNumberOfUsableOutfits

```lua
maxOutfitCount = C_TransmogOutfitInfo.GetMaxNumberOfUsableOutfits()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxOutfitCount` | number | no |  |

**Example**

```lua
local maxOutfitCount = C_TransmogOutfitInfo.GetMaxNumberOfUsableOutfits()
```

### C_TransmogOutfitInfo.GetNextOutfitCost

```lua
outfitCost = C_TransmogOutfitInfo.GetNextOutfitCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitCost` | BigUInteger | no |  |

**Example**

```lua
local outfitCost = C_TransmogOutfitInfo.GetNextOutfitCost()
```

### C_TransmogOutfitInfo.GetNumberOfOutfitsUnlockedForSource

```lua
unlockedOutfitCount = C_TransmogOutfitInfo.GetNumberOfOutfitsUnlockedForSource(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | TransmogOutfitEntrySource | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unlockedOutfitCount` | number | no |  |

**Example**

```lua
local unlockedOutfitCount = C_TransmogOutfitInfo.GetNumberOfOutfitsUnlockedForSource(source)
```

### C_TransmogOutfitInfo.GetOptionsForSlot

```lua
options, artifactOptions = C_TransmogOutfitInfo.GetOptionsForSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | TransmogOutfitOptionInfo[] | no |  |
| `artifactOptions` | TransmogOutfitOptionInfo[] | yes |  |

**Example**

```lua
local options, artifactOptions = C_TransmogOutfitInfo.GetOptionsForSlot(1)
```

### C_TransmogOutfitInfo.GetOutfitInfo

```lua
outfitInfo = C_TransmogOutfitInfo.GetOutfitInfo(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitInfo` | TransmogOutfitEntryInfo | no |  |

**Example**

```lua
local outfitInfo = C_TransmogOutfitInfo.GetOutfitInfo(0)
```

### C_TransmogOutfitInfo.GetOutfitInfoByName

```lua
outfitInfo = C_TransmogOutfitInfo.GetOutfitInfoByName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no | Case-insensitive outfit name to search for. If multiple exist with the same name, it is unspecified which outfit will be returned. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitInfo` | TransmogOutfitEntryInfo | no |  |

**Example**

```lua
local outfitInfo = C_TransmogOutfitInfo.GetOutfitInfoByName("")
```

### C_TransmogOutfitInfo.GetOutfitInfoByPlayerFacingIndex

```lua
outfitInfo = C_TransmogOutfitInfo.GetOutfitInfoByPlayerFacingIndex(playerFacingOutfitIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerFacingOutfitIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitInfo` | TransmogOutfitEntryInfo | no |  |

**Example**

```lua
local outfitInfo = C_TransmogOutfitInfo.GetOutfitInfoByPlayerFacingIndex(1)
```

### C_TransmogOutfitInfo.GetOutfitsInfo

```lua
outfitsInfo = C_TransmogOutfitInfo.GetOutfitsInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitsInfo` | TransmogOutfitEntryInfo[] | no |  |

**Example**

```lua
local outfitsInfo = C_TransmogOutfitInfo.GetOutfitsInfo()
```

### C_TransmogOutfitInfo.GetOutfitSituation

```lua
value = C_TransmogOutfitInfo.GetOutfitSituation(option)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `option` | TransmogSituationOption | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | no |  |

**Example**

```lua
local value = C_TransmogOutfitInfo.GetOutfitSituation(option)
```

### C_TransmogOutfitInfo.GetOutfitSituationsEnabled

```lua
enabled = C_TransmogOutfitInfo.GetOutfitSituationsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_TransmogOutfitInfo.GetOutfitSituationsEnabled()
```

### C_TransmogOutfitInfo.GetPendingTransmogCost

```lua
cost, modifierFlags = C_TransmogOutfitInfo.GetPendingTransmogCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | BigUInteger | no |  |
| `modifierFlags` | number | no |  |

**Example**

```lua
local cost, modifierFlags = C_TransmogOutfitInfo.GetPendingTransmogCost()
```

### C_TransmogOutfitInfo.GetSecondarySlotState

```lua
state = C_TransmogOutfitInfo.GetSecondarySlotState(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | bool | no |  |

**Example**

```lua
local state = C_TransmogOutfitInfo.GetSecondarySlotState(1)
```

### C_TransmogOutfitInfo.GetSetSourcesForSlot

```lua
sources = C_TransmogOutfitInfo.GetSetSourcesForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | AppearanceSourceInfo[] | no |  |

**Example**

```lua
local sources = C_TransmogOutfitInfo.GetSetSourcesForSlot(0, 1)
```

### C_TransmogOutfitInfo.GetSlotGroupInfo

```lua
slotGroups = C_TransmogOutfitInfo.GetSlotGroupInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotGroups` | TransmogOutfitSlotGroup[] | no |  |

**Example**

```lua
local slotGroups = C_TransmogOutfitInfo.GetSlotGroupInfo()
```

### C_TransmogOutfitInfo.GetSourceIDsForSlot

```lua
sources = C_TransmogOutfitInfo.GetSourceIDsForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | number[] | no |  |

**Example**

```lua
local sources = C_TransmogOutfitInfo.GetSourceIDsForSlot(0, 1)
```

### C_TransmogOutfitInfo.GetTransmogOutfitSlotForInventoryType

```lua
slot = C_TransmogOutfitInfo.GetTransmogOutfitSlotForInventoryType(inventoryType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryType` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Example**

```lua
local slot = C_TransmogOutfitInfo.GetTransmogOutfitSlotForInventoryType(inventoryType)
```

### C_TransmogOutfitInfo.GetTransmogOutfitSlotFromInventorySlot

```lua
slot = C_TransmogOutfitInfo.GetTransmogOutfitSlotFromInventorySlot(inventorySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlot` | InventorySlots | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Example**

```lua
local slot = C_TransmogOutfitInfo.GetTransmogOutfitSlotFromInventorySlot(1)
```

### C_TransmogOutfitInfo.GetUISituationCategoriesAndOptions

```lua
categoryData = C_TransmogOutfitInfo.GetUISituationCategoriesAndOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryData` | TransmogSituationCategory[] | no |  |

**Example**

```lua
local categoryData = C_TransmogOutfitInfo.GetUISituationCategoriesAndOptions()
```

### C_TransmogOutfitInfo.GetUnassignedAtlasForSlot

```lua
atlas = C_TransmogOutfitInfo.GetUnassignedAtlasForSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
local atlas = C_TransmogOutfitInfo.GetUnassignedAtlasForSlot(1)
```

### C_TransmogOutfitInfo.GetUnassignedDisplayAtlasForSlot

```lua
atlas = C_TransmogOutfitInfo.GetUnassignedDisplayAtlasForSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
local atlas = C_TransmogOutfitInfo.GetUnassignedDisplayAtlasForSlot(1)
```

### C_TransmogOutfitInfo.GetViewedOutfitSlotInfo

```lua
slotInfo = C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(slot, type, option)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `type` | TransmogType | no |  |
| `option` | TransmogOutfitSlotOption | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotInfo` | ViewedTransmogOutfitSlotInfo | no |  |

**Example**

```lua
local slotInfo = C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(1, type, option)
```

### C_TransmogOutfitInfo.HasPendingOutfitSituations

```lua
hasPending = C_TransmogOutfitInfo.HasPendingOutfitSituations()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPending` | bool | no |  |

**Example**

```lua
local hasPending = C_TransmogOutfitInfo.HasPendingOutfitSituations()
```

### C_TransmogOutfitInfo.HasPendingOutfitTransmogs

```lua
hasPending = C_TransmogOutfitInfo.HasPendingOutfitTransmogs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPending` | bool | no |  |

**Example**

```lua
local hasPending = C_TransmogOutfitInfo.HasPendingOutfitTransmogs()
```

### C_TransmogOutfitInfo.InTransmogEvent

```lua
inTransmogEvent = C_TransmogOutfitInfo.InTransmogEvent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inTransmogEvent` | bool | no |  |

**Example**

```lua
local inTransmogEvent = C_TransmogOutfitInfo.InTransmogEvent()
```

### C_TransmogOutfitInfo.IsEquippedGearOutfitDisplayed

```lua
isDisplayed = C_TransmogOutfitInfo.IsEquippedGearOutfitDisplayed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisplayed` | bool | no |  |

**Example**

```lua
local isDisplayed = C_TransmogOutfitInfo.IsEquippedGearOutfitDisplayed()
```

### C_TransmogOutfitInfo.IsEquippedGearOutfitLocked

```lua
isLocked = C_TransmogOutfitInfo.IsEquippedGearOutfitLocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocked` | bool | no |  |

**Example**

```lua
local isLocked = C_TransmogOutfitInfo.IsEquippedGearOutfitLocked()
```

### C_TransmogOutfitInfo.IsLockedOutfit

```lua
isLocked = C_TransmogOutfitInfo.IsLockedOutfit(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocked` | bool | no |  |

**Example**

```lua
local isLocked = C_TransmogOutfitInfo.IsLockedOutfit(0)
```

### C_TransmogOutfitInfo.IsSlotWeaponSlot

```lua
isWeaponSlot = C_TransmogOutfitInfo.IsSlotWeaponSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWeaponSlot` | bool | no |  |

**Example**

```lua
local isWeaponSlot = C_TransmogOutfitInfo.IsSlotWeaponSlot(1)
```

### C_TransmogOutfitInfo.IsTransmogEnabled

```lua
enabled = C_TransmogOutfitInfo.IsTransmogEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_TransmogOutfitInfo.IsTransmogEnabled()
```

### C_TransmogOutfitInfo.IsUsableDiscountAvailable

```lua
isAvailable = C_TransmogOutfitInfo.IsUsableDiscountAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example**

```lua
local isAvailable = C_TransmogOutfitInfo.IsUsableDiscountAvailable()
```

### C_TransmogOutfitInfo.IsValidTransmogOutfitName

```lua
isApproved = C_TransmogOutfitInfo.IsValidTransmogOutfitName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApproved` | bool | no |  |

**Example**

```lua
local isApproved = C_TransmogOutfitInfo.IsValidTransmogOutfitName("")
```

### C_TransmogOutfitInfo.PickupOutfit

```lua
C_TransmogOutfitInfo.PickupOutfit(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Example**

```lua
C_TransmogOutfitInfo.PickupOutfit(0)
```

### C_TransmogOutfitInfo.ResetOutfitSituations

```lua
C_TransmogOutfitInfo.ResetOutfitSituations()
```

**Example**

```lua
C_TransmogOutfitInfo.ResetOutfitSituations()
```

### C_TransmogOutfitInfo.RevertPendingTransmog

```lua
C_TransmogOutfitInfo.RevertPendingTransmog(slot, type, option)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `type` | TransmogType | no |  |
| `option` | TransmogOutfitSlotOption | no |  |

**Example**

```lua
C_TransmogOutfitInfo.RevertPendingTransmog(1, type, option)
```

### C_TransmogOutfitInfo.SetOutfitSituationsEnabled

```lua
C_TransmogOutfitInfo.SetOutfitSituationsEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetOutfitSituationsEnabled(false)
```

### C_TransmogOutfitInfo.SetOutfitToCustomSet

```lua
C_TransmogOutfitInfo.SetOutfitToCustomSet(transmogCustomSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogCustomSetID` | number | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetOutfitToCustomSet(0)
```

### C_TransmogOutfitInfo.SetOutfitToOutfit

```lua
C_TransmogOutfitInfo.SetOutfitToOutfit(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetOutfitToOutfit(0)
```

### C_TransmogOutfitInfo.SetOutfitToSet

```lua
C_TransmogOutfitInfo.SetOutfitToSet(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetOutfitToSet(0)
```

### C_TransmogOutfitInfo.SetPendingTransmog

```lua
C_TransmogOutfitInfo.SetPendingTransmog(slot, type, option, transmogID, displayType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `type` | TransmogType | no |  |
| `option` | TransmogOutfitSlotOption | no |  |
| `transmogID` | number | no |  |
| `displayType` | TransmogOutfitDisplayType | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetPendingTransmog(1, type, option, 0, displayType)
```

### C_TransmogOutfitInfo.SetPendingTransmogSheatheCategory

```lua
C_TransmogOutfitInfo.SetPendingTransmogSheatheCategory(slot, option, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `option` | TransmogOutfitSlotOption | no |  |
| `category` | TransmogOutfitSlotOptionSheatheCategory | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetPendingTransmogSheatheCategory(1, option, category)
```

### C_TransmogOutfitInfo.SetSecondarySlotState

```lua
C_TransmogOutfitInfo.SetSecondarySlotState(slot, state)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `state` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetSecondarySlotState(1, false)
```

### C_TransmogOutfitInfo.SetViewedOptionForSlot

```lua
C_TransmogOutfitInfo.SetViewedOptionForSlot(slot, option)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `option` | TransmogOutfitSlotOption | no |  |

**Example**

```lua
C_TransmogOutfitInfo.SetViewedOptionForSlot(1, option)
```

### C_TransmogOutfitInfo.SlotHasSecondary

```lua
hasSecondary = C_TransmogOutfitInfo.SlotHasSecondary(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecondary` | bool | no |  |

**Example**

```lua
local hasSecondary = C_TransmogOutfitInfo.SlotHasSecondary(1)
```

### C_TransmogOutfitInfo.TransmogEventActive

```lua
transmogEventActive = C_TransmogOutfitInfo.TransmogEventActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogEventActive` | bool | no |  |

**Example**

```lua
local transmogEventActive = C_TransmogOutfitInfo.TransmogEventActive()
```

### C_TransmogOutfitInfo.UpdatePendingSituation

```lua
C_TransmogOutfitInfo.UpdatePendingSituation(option, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `option` | TransmogSituationOption | no |  |
| `value` | bool | no |  |

**Example**

```lua
C_TransmogOutfitInfo.UpdatePendingSituation(option, false)
```

## Events

### TRANSMOG_DISPLAYED_OUTFIT_CHANGED

### TRANSMOG_OUTFITS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newOutfitID` | number | yes |  |

### VIEWED_TRANSMOG_OUTFIT_CHANGED

### VIEWED_TRANSMOG_OUTFIT_SECONDARY_SLOTS_CHANGED

### VIEWED_TRANSMOG_OUTFIT_SITUATIONS_CHANGED

### VIEWED_TRANSMOG_OUTFIT_SLOT_OPTION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `option` | TransmogOutfitSlotOption | no |  |

### VIEWED_TRANSMOG_OUTFIT_SLOT_REFRESH

### VIEWED_TRANSMOG_OUTFIT_SLOT_SAVE_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `type` | TransmogType | no |  |
| `option` | TransmogOutfitSlotOption | no |  |

## Types

### TransmogOutfitCollectionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `isWeapon` | bool | no |  |
| `canHaveIllusions` | bool | no |  |

### TransmogOutfitEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |
| `name` | string | no |  |
| `situationCategories` | cstring[] | no |  |
| `icon` | fileID | no |  |
| `isEventOutfit` | bool | no |  |
| `isDisabled` | bool | no |  |
| `playerFacingOutfitIndex` | number | no |  |

### TransmogOutfitLinkedSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `primarySlotInfo` | TransmogOutfitSlotInfo | no |  |
| `secondarySlotInfo` | TransmogOutfitSlotInfo | no |  |

### TransmogOutfitOptionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | TransmogOutfitSlotOption | no |  |
| `name` | cstring | no |  |
| `enabled` | bool | no |  |

### TransmogOutfitOptionSheatheCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sheatheCategory` | TransmogOutfitSlotOptionSheatheCategory | no |  |
| `categoryName` | cstring | no |  |

### TransmogOutfitSlotGroup (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | TransmogOutfitSlotPosition | no |  |
| `appearanceSlotInfo` | TransmogOutfitSlotInfo[] | no |  |
| `illusionSlotInfo` | TransmogOutfitSlotInfo[] | no |  |

### TransmogOutfitSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | TransmogOutfitSlot | no |  |
| `type` | TransmogType | no |  |
| `collectionType` | TransmogCollectionType | no |  |
| `slotName` | cstring | no |  |
| `isSecondary` | bool | no |  |

### TransmogSituationCategory (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `triggerID` | number | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `isRadioButton` | bool | no |  |
| `groupData` | TransmogSituationGroup[] | no |  |

### TransmogSituationGroup (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `secondaryID` | number | no |  |
| `optionData` | TransmogSituationOptionData[] | no |  |

### TransmogSituationOption (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `situationID` | number | no |  |
| `specID` | number | no |  |
| `loadoutID` | number | no |  |
| `equipmentSetID` | number | no |  |

### TransmogSituationOptionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `value` | bool | no |  |
| `option` | TransmogSituationOption | no |  |

### ViewedTransmogOutfitSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogID` | number | no |  |
| `displayType` | TransmogOutfitDisplayType | no |  |
| `isTransmogrified` | bool | no |  |
| `hasPending` | bool | no |  |
| `isPendingCollected` | bool | no |  |
| `canTransmogrify` | bool | no |  |
| `warning` | TransmogOutfitSlotWarning | no |  |
| `warningText` | cstring | no |  |
| `error` | TransmogOutfitSlotError | no |  |
| `errorText` | cstring | no |  |
| `texture` | fileID | yes |  |
| `sheatheCategory` | TransmogOutfitSlotOptionSheatheCategory | no |  |

