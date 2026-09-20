# C_HousingDecor

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**35** functions · **11** events · **2** types

## Functions

### C_HousingDecor.AnyDecorPlacedInRoom

Returns true if any decor objects are placed in a given room

```lua
isPlaced = C_HousingDecor.AnyDecorPlacedInRoom(roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlaced` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlaced = C_HousingDecor.AnyDecorPlacedInRoom(UnitGUID("player"))
```

### C_HousingDecor.CancelActiveEditing

Cancels all in-progress editing of the selected target, which will reset any unsaved changes and deselect the active target

```lua
C_HousingDecor.CancelActiveEditing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.CancelActiveEditing()
```

### C_HousingDecor.CommitDecorMovement

Attempt to save the changes made to the currently selected decor instance

```lua
C_HousingDecor.CommitDecorMovement()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.CommitDecorMovement()
```

### C_HousingDecor.EnterPreviewState

```lua
C_HousingDecor.EnterPreviewState()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.EnterPreviewState()
```

### C_HousingDecor.ExitPreviewState

```lua
C_HousingDecor.ExitPreviewState()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.ExitPreviewState()
```

### C_HousingDecor.GetAllMaxPlacementBudgets

Returns the interior and exterior max decor placement budgets for the current owned house interior or plot; Can be increased via house level

```lua
interiorMaxBudgets, exteriorMaxBudgets = C_HousingDecor.GetAllMaxPlacementBudgets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interiorMaxBudgets` | number[] | yes | Map of budget type to max budget amount; Will be nil if not in an owned House or Plot |
| `exteriorMaxBudgets` | number[] | yes | Map of budget type to max budget amount; Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interiorMaxBudgets, exteriorMaxBudgets = C_HousingDecor.GetAllMaxPlacementBudgets()
```

### C_HousingDecor.GetAllPlacedDecor

Placed Decor List APIs currently restricted due to being potentially very expensive operations, may be reworked & opened up in the future

```lua
placedDecor = C_HousingDecor.GetAllPlacedDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `placedDecor` | HousingDecorInstanceListEntry[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local placedDecor = C_HousingDecor.GetAllPlacedDecor()
```

### C_HousingDecor.GetAllSpentPlacementBudgets

Returns how much of the interior and exterior placement budgets for the current owned house interior or plot's decor budget have been spent

```lua
interiorSpentBudgets, exteriorSpentBudgets = C_HousingDecor.GetAllSpentPlacementBudgets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interiorSpentBudgets` | number[] | yes | Map of budget type to spent budget amount; Will be nil if not in an owned House or Plot |
| `exteriorSpentBudgets` | number[] | yes | Map of budget type to spent budget amount; Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interiorSpentBudgets, exteriorSpentBudgets = C_HousingDecor.GetAllSpentPlacementBudgets()
```

### C_HousingDecor.GetDecorAssignedPetName

Returns pet name for the placed decor instance associated with the passed Decor GUID, if there is one

```lua
name = C_HousingDecor.GetDecorAssignedPetName(decorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_HousingDecor.GetDecorAssignedPetName(UnitGUID("player"))
```

### C_HousingDecor.GetDecorCanAttachPet

```lua
canAttachPet = C_HousingDecor.GetDecorCanAttachPet(decorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAttachPet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAttachPet = C_HousingDecor.GetDecorCanAttachPet(0)
```

### C_HousingDecor.GetDecorHyperlink

```lua
hyperLink = C_HousingDecor.GetDecorHyperlink(decorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperLink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hyperLink = C_HousingDecor.GetDecorHyperlink(0)
```

### C_HousingDecor.GetDecorIcon

```lua
icon = C_HousingDecor.GetDecorIcon(decorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local icon = C_HousingDecor.GetDecorIcon(0)
```

### C_HousingDecor.GetDecorInstanceInfoForGUID

Returns info for the placed decor instance associated with the passed Decor GUID, if there is one

```lua
info = C_HousingDecor.GetDecorInstanceInfoForGUID(decorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingDecor.GetDecorInstanceInfoForGUID(UnitGUID("player"))
```

### C_HousingDecor.GetDecorName

```lua
name = C_HousingDecor.GetDecorName(decorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_HousingDecor.GetDecorName(0)
```

### C_HousingDecor.GetHoveredDecorInfo

Returns info for the placed decor instance currently being hovered, if there is one

```lua
info = C_HousingDecor.GetHoveredDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingDecor.GetHoveredDecorInfo()
```

### C_HousingDecor.GetMaxPetPlacementBudget

Returns the max pet decor placement budget for the current owned house interior or plot

```lua
maxBudget = C_HousingDecor.GetMaxPetPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBudget` | number | yes | Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBudget = C_HousingDecor.GetMaxPetPlacementBudget()
```

### C_HousingDecor.GetMaxPlacementBudget

Returns the max decor placement budget for the current owned house interior or plot; Can be increased via house level

```lua
maxBudget = C_HousingDecor.GetMaxPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBudget` | number | yes | Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxBudget = C_HousingDecor.GetMaxPlacementBudget()
```

### C_HousingDecor.GetNumDecorPlaced

Returns the number of individual decor objects placed in the current house or plot; This is NOT the value used in placement budget calculations, see GetSpentPlacementBudget for that

```lua
numPlaced = C_HousingDecor.GetNumDecorPlaced()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPlaced` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numPlaced = C_HousingDecor.GetNumDecorPlaced()
```

### C_HousingDecor.GetNumPreviewDecor

```lua
numDecor = C_HousingDecor.GetNumPreviewDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDecor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numDecor = C_HousingDecor.GetNumPreviewDecor()
```

### C_HousingDecor.GetSelectedDecorInfo

Returns info for the placed decor instance that's currently selected, if there is one

```lua
info = C_HousingDecor.GetSelectedDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingDecor.GetSelectedDecorInfo()
```

### C_HousingDecor.GetSpentPetPlacementBudget

Returns how much of the current owned house interior or plot's pet decor placement budget has been spent

```lua
totalCost = C_HousingDecor.GetSpentPetPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalCost` | number | yes | Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalCost = C_HousingDecor.GetSpentPetPlacementBudget()
```

### C_HousingDecor.GetSpentPlacementBudget

Returns how much of the current owned house interior or plot's decor placement budget has been spent; Different kinds of decor take up different budget amounts, so this value isn't an individual decor count, see GetNumDecorPlaced for that

```lua
totalCost = C_HousingDecor.GetSpentPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalCost` | number | yes | Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalCost = C_HousingDecor.GetSpentPlacementBudget()
```

### C_HousingDecor.HasMaxPlacementBudget

Returns whether there's a max decor placement budget available and active for the current player, in the current house interior or plot

```lua
hasMaxBudget = C_HousingDecor.HasMaxPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxBudget` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMaxBudget = C_HousingDecor.HasMaxPlacementBudget()
```

### C_HousingDecor.IsDecorSelected

Returns true if a placed decor instance is currently selected

```lua
hasSelectedDecor = C_HousingDecor.IsDecorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedDecor = C_HousingDecor.IsDecorSelected()
```

### C_HousingDecor.IsGridVisible

```lua
gridVisible = C_HousingDecor.IsGridVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gridVisible = C_HousingDecor.IsGridVisible()
```

### C_HousingDecor.IsHouseExteriorDoorHovered

Returns true if the entry door of the house's exterior is currently being hovered

```lua
isHouseExteriorDoorHovered = C_HousingDecor.IsHouseExteriorDoorHovered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorDoorHovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorDoorHovered = C_HousingDecor.IsHouseExteriorDoorHovered()
```

### C_HousingDecor.IsHouseExteriorHovered

Returns true if the house's exterior is currently being hovered

```lua
isHouseExteriorHovered = C_HousingDecor.IsHouseExteriorHovered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorHovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorHovered = C_HousingDecor.IsHouseExteriorHovered()
```

### C_HousingDecor.IsHoveringDecor

Returns true if a placed decor instance is currently being hovered

```lua
isHoveringDecor = C_HousingDecor.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingDecor.IsHoveringDecor()
```

### C_HousingDecor.IsModeDisabledForPreviewState

```lua
isModeDisabled = C_HousingDecor.IsModeDisabledForPreviewState(mode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mode` | HouseEditorMode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isModeDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isModeDisabled = C_HousingDecor.IsModeDisabledForPreviewState(mode)
```

### C_HousingDecor.IsPreviewState

```lua
isPreviewState = C_HousingDecor.IsPreviewState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPreviewState` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPreviewState = C_HousingDecor.IsPreviewState()
```

### C_HousingDecor.RemovePlacedDecorEntry

Placed Decor List APIs currently restricted due to being potentially very expensive operations, may be reworked & opened up in the future

```lua
C_HousingDecor.RemovePlacedDecorEntry(decorGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.RemovePlacedDecorEntry(UnitGUID("player"))
```

### C_HousingDecor.RemoveSelectedDecor

Attempt to return the currently selected decor instance back to the house chest

```lua
C_HousingDecor.RemoveSelectedDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.RemoveSelectedDecor()
```

### C_HousingDecor.SetGridVisible

```lua
C_HousingDecor.SetGridVisible(gridVisible)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.SetGridVisible(false)
```

### C_HousingDecor.SetPlacedDecorEntryHovered

Placed Decor List APIs currently restricted due to being potentially very expensive operations, may be reworked & opened up in the future

```lua
C_HousingDecor.SetPlacedDecorEntryHovered(decorGUID, hovered)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `hovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.SetPlacedDecorEntryHovered(UnitGUID("player"), false)
```

### C_HousingDecor.SetPlacedDecorEntrySelected

Placed Decor List APIs currently restricted due to being potentially very expensive operations, may be reworked & opened up in the future

```lua
C_HousingDecor.SetPlacedDecorEntrySelected(decorGUID, selected)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `selected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingDecor.SetPlacedDecorEntrySelected(UnitGUID("player"), false)
```

## Events

### HOUSE_DECOR_ADDED_TO_CHEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `decorID` | number | no |  |

### HOUSE_EXTERIOR_POSITION_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `housingResult` | HousingResult | no |  |

### HOUSE_EXTERIOR_POSITION_SUCCESS

### HOUSING_DECOR_GRID_VISIBILITY_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGridVisible` | bool | no |  |

### HOUSING_DECOR_PLACE_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `housingResult` | HousingResult | no |  |

### HOUSING_DECOR_PLACE_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `size` | HousingCatalogEntrySize | no |  |
| `isNew` | bool | no | Will be true if the decor is newly placed from storage, false if it was already placed and just moved |
| `isPreview` | bool | no |  |

### HOUSING_DECOR_PREVIEW_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPreviewState` | bool | no |  |

### HOUSING_DECOR_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

### HOUSING_DECOR_SELECT_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_NEW_DECOR_PLACE_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

### HOUSING_NUM_DECOR_PLACED_CHANGED

## Types

### HousingDecorInstanceListEntry (Structure)

Smaller structs with the minimum fields from HousingDecorInstanceInfo needed to identify/display a slim list of placed decor

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `name` | cstring | no |  |

### LightRadiusIndicatorType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Always` | LightRadiusIndicatorType | no |  |
| `Overlap` | LightRadiusIndicatorType | no |  |
| `Never` | LightRadiusIndicatorType | no |  |

