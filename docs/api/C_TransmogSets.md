# C_TransmogSets

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**42** functions · **0** events · **2** types

## Functions

### C_TransmogSets.ClearLatestSource

```lua
C_TransmogSets.ClearLatestSource()
```

**Example**

```lua
C_TransmogSets.ClearLatestSource()
```

### C_TransmogSets.ClearNewSource

```lua
C_TransmogSets.ClearNewSource(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Example**

```lua
C_TransmogSets.ClearNewSource(0)
```

### C_TransmogSets.ClearSetNewSourcesForSlot

```lua
C_TransmogSets.ClearSetNewSourcesForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | luaIndex | no |  |

**Example**

```lua
C_TransmogSets.ClearSetNewSourcesForSlot(0, 1)
```

### C_TransmogSets.GetAllSets

```lua
sets = C_TransmogSets.GetAllSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sets` | TransmogSetInfo[] | no |  |

**Example**

```lua
local sets = C_TransmogSets.GetAllSets()
```

### C_TransmogSets.GetAllSourceIDs

```lua
sources = C_TransmogSets.GetAllSourceIDs(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | number[] | no |  |

**Example**

```lua
local sources = C_TransmogSets.GetAllSourceIDs(0)
```

### C_TransmogSets.GetAvailableSets

```lua
sets = C_TransmogSets.GetAvailableSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sets` | TransmogSetInfo[] | no |  |

**Example**

```lua
local sets = C_TransmogSets.GetAvailableSets()
```

### C_TransmogSets.GetBaseSetID

```lua
baseTransmogSetID = C_TransmogSets.GetBaseSetID(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseTransmogSetID` | number | no |  |

**Example**

```lua
local baseTransmogSetID = C_TransmogSets.GetBaseSetID(0)
```

### C_TransmogSets.GetBaseSets

```lua
sets = C_TransmogSets.GetBaseSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sets` | TransmogSetInfo[] | no |  |

**Example**

```lua
local sets = C_TransmogSets.GetBaseSets()
```

### C_TransmogSets.GetBaseSetsFilter

```lua
isChecked = C_TransmogSets.GetBaseSetsFilter(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example**

```lua
local isChecked = C_TransmogSets.GetBaseSetsFilter(1)
```

### C_TransmogSets.GetCameraIDs

```lua
detailsCameraID, vendorCameraID = C_TransmogSets.GetCameraIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `detailsCameraID` | number | yes |  |
| `vendorCameraID` | number | yes |  |

**Example**

```lua
local detailsCameraID, vendorCameraID = C_TransmogSets.GetCameraIDs()
```

### C_TransmogSets.GetFilteredBaseSetsCounts

```lua
numCollected, numTotal = C_TransmogSets.GetFilteredBaseSetsCounts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numCollected` | number | no |  |
| `numTotal` | number | no |  |

**Example**

```lua
local numCollected, numTotal = C_TransmogSets.GetFilteredBaseSetsCounts()
```

### C_TransmogSets.GetFullBaseSetsCounts

```lua
numCollected, numTotal = C_TransmogSets.GetFullBaseSetsCounts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numCollected` | number | no |  |
| `numTotal` | number | no |  |

**Example**

```lua
local numCollected, numTotal = C_TransmogSets.GetFullBaseSetsCounts()
```

### C_TransmogSets.GetIsFavorite

```lua
isFavorite, isGroupFavorite = C_TransmogSets.GetIsFavorite(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |
| `isGroupFavorite` | bool | no |  |

**Example**

```lua
local isFavorite, isGroupFavorite = C_TransmogSets.GetIsFavorite(0)
```

### C_TransmogSets.GetLatestSource

```lua
sourceID = C_TransmogSets.GetLatestSource()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Example**

```lua
local sourceID = C_TransmogSets.GetLatestSource()
```

### C_TransmogSets.GetSetInfo

```lua
set = C_TransmogSets.GetSetInfo(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `set` | TransmogSetInfo | no |  |

**Example**

```lua
local set = C_TransmogSets.GetSetInfo(0)
```

### C_TransmogSets.GetSetNewSources

```lua
sourceIDs = C_TransmogSets.GetSetNewSources(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceIDs` | number[] | no |  |

**Example**

```lua
local sourceIDs = C_TransmogSets.GetSetNewSources(0)
```

### C_TransmogSets.GetSetPrimaryAppearances

```lua
apppearances = C_TransmogSets.GetSetPrimaryAppearances(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `apppearances` | TransmogSetPrimaryAppearanceInfo[] | no |  |

**Example**

```lua
local apppearances = C_TransmogSets.GetSetPrimaryAppearances(0)
```

### C_TransmogSets.GetSetsContainingSourceID

```lua
setIDs = C_TransmogSets.GetSetsContainingSourceID(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setIDs` | number[] | no |  |

**Example**

```lua
local setIDs = C_TransmogSets.GetSetsContainingSourceID(0)
```

### C_TransmogSets.GetSetsFilter

```lua
isChecked = C_TransmogSets.GetSetsFilter(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example**

```lua
local isChecked = C_TransmogSets.GetSetsFilter(1)
```

### C_TransmogSets.GetSourceIDsForSlot

```lua
sources = C_TransmogSets.GetSourceIDsForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | number[] | no |  |

**Example**

```lua
local sources = C_TransmogSets.GetSourceIDsForSlot(0, 1)
```

### C_TransmogSets.GetSourcesForSlot

```lua
sources = C_TransmogSets.GetSourcesForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sources` | AppearanceSourceInfo[] | no |  |

**Example**

```lua
local sources = C_TransmogSets.GetSourcesForSlot(0, 1)
```

### C_TransmogSets.GetTransmogSetsClassFilter

```lua
classID = C_TransmogSets.GetTransmogSetsClassFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Example**

```lua
local classID = C_TransmogSets.GetTransmogSetsClassFilter()
```

### C_TransmogSets.GetUsableSets

```lua
sets = C_TransmogSets.GetUsableSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sets` | TransmogSetInfo[] | no |  |

**Example**

```lua
local sets = C_TransmogSets.GetUsableSets()
```

### C_TransmogSets.GetValidBaseSetsCountsForCharacter

```lua
numCollected, numTotal = C_TransmogSets.GetValidBaseSetsCountsForCharacter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numCollected` | number | no |  |
| `numTotal` | number | no |  |

**Example**

```lua
local numCollected, numTotal = C_TransmogSets.GetValidBaseSetsCountsForCharacter()
```

### C_TransmogSets.GetValidClassForSet

```lua
classID = C_TransmogSets.GetValidClassForSet(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | yes |  |

**Example**

```lua
local classID = C_TransmogSets.GetValidClassForSet(0)
```

### C_TransmogSets.GetVariantSets

```lua
sets = C_TransmogSets.GetVariantSets(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sets` | TransmogSetInfo[] | no |  |

**Example**

```lua
local sets = C_TransmogSets.GetVariantSets(0)
```

### C_TransmogSets.HasAnyValidSets

```lua
hasAnyValidSets = C_TransmogSets.HasAnyValidSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyValidSets` | bool | no |  |

**Example**

```lua
local hasAnyValidSets = C_TransmogSets.HasAnyValidSets()
```

### C_TransmogSets.HasAvailableSets

```lua
hasAvailableSets = C_TransmogSets.HasAvailableSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAvailableSets` | bool | no |  |

**Example**

```lua
local hasAvailableSets = C_TransmogSets.HasAvailableSets()
```

### C_TransmogSets.HasUsableSets

```lua
hasUsableSets = C_TransmogSets.HasUsableSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUsableSets` | bool | no |  |

**Example**

```lua
local hasUsableSets = C_TransmogSets.HasUsableSets()
```

### C_TransmogSets.IsBaseSetCollected

```lua
isCollected = C_TransmogSets.IsBaseSetCollected(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCollected` | bool | no |  |

**Example**

```lua
local isCollected = C_TransmogSets.IsBaseSetCollected(0)
```

### C_TransmogSets.IsNewSource

```lua
isNew = C_TransmogSets.IsNewSource(sourceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNew` | bool | no |  |

**Example**

```lua
local isNew = C_TransmogSets.IsNewSource(0)
```

### C_TransmogSets.IsSetVisible

```lua
isVisible = C_TransmogSets.IsSetVisible(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example**

```lua
local isVisible = C_TransmogSets.IsSetVisible(0)
```

### C_TransmogSets.IsUsingDefaultBaseSetsFilters

```lua
isUsingDefaultBaseSetsFilters = C_TransmogSets.IsUsingDefaultBaseSetsFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultBaseSetsFilters` | bool | no |  |

**Example**

```lua
local isUsingDefaultBaseSetsFilters = C_TransmogSets.IsUsingDefaultBaseSetsFilters()
```

### C_TransmogSets.IsUsingDefaultSetsFilters

```lua
isUsingDefaultSetsFilters = C_TransmogSets.IsUsingDefaultSetsFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultSetsFilters` | bool | no |  |

**Example**

```lua
local isUsingDefaultSetsFilters = C_TransmogSets.IsUsingDefaultSetsFilters()
```

### C_TransmogSets.SetBaseSetsFilter

```lua
C_TransmogSets.SetBaseSetsFilter(index, isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `isChecked` | bool | no |  |

**Example**

```lua
C_TransmogSets.SetBaseSetsFilter(1, false)
```

### C_TransmogSets.SetDefaultBaseSetsFilters

```lua
C_TransmogSets.SetDefaultBaseSetsFilters()
```

**Example**

```lua
C_TransmogSets.SetDefaultBaseSetsFilters()
```

### C_TransmogSets.SetDefaultSetsFilters

```lua
C_TransmogSets.SetDefaultSetsFilters()
```

**Example**

```lua
C_TransmogSets.SetDefaultSetsFilters()
```

### C_TransmogSets.SetHasNewSources

```lua
hasNewSources = C_TransmogSets.SetHasNewSources(transmogSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasNewSources` | bool | no |  |

**Example**

```lua
local hasNewSources = C_TransmogSets.SetHasNewSources(0)
```

### C_TransmogSets.SetHasNewSourcesForSlot

```lua
hasNewSources = C_TransmogSets.SetHasNewSourcesForSlot(transmogSetID, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasNewSources` | bool | no |  |

**Example**

```lua
local hasNewSources = C_TransmogSets.SetHasNewSourcesForSlot(0, 1)
```

### C_TransmogSets.SetIsFavorite

```lua
C_TransmogSets.SetIsFavorite(transmogSetID, isFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogSetID` | number | no |  |
| `isFavorite` | bool | no |  |

**Example**

```lua
C_TransmogSets.SetIsFavorite(0, false)
```

### C_TransmogSets.SetSetsFilter

```lua
C_TransmogSets.SetSetsFilter(index, isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `isChecked` | bool | no |  |

**Example**

```lua
C_TransmogSets.SetSetsFilter(1, false)
```

### C_TransmogSets.SetTransmogSetsClassFilter

```lua
C_TransmogSets.SetTransmogSetsClassFilter(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Example**

```lua
C_TransmogSets.SetTransmogSetsClassFilter(0)
```

## Types

### TransmogSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |
| `name` | string | no |  |
| `baseSetID` | number | yes |  |
| `description` | cstring | yes |  |
| `label` | cstring | yes |  |
| `expansionID` | number | no |  |
| `patchID` | number | no |  |
| `uiOrder` | number | no |  |
| `classMask` | number | no |  |
| `hiddenUntilCollected` | bool | no |  |
| `requiredFaction` | cstring | yes |  |
| `collected` | bool | no |  |
| `favorite` | bool | no |  |
| `limitedTimeSet` | bool | no |  |
| `validForCharacter` | bool | no |  |
| `grantAsPrecedingVariant` | bool | no |  |

### TransmogSetPrimaryAppearanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |
| `collected` | bool | no |  |

