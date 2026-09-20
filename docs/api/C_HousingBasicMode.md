# C_HousingBasicMode

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**22** functions · **6** events · **1** types

## Functions

### C_HousingBasicMode.CancelActiveEditing

Cancels all in-progress editing of the selected target, which will reset any unsaved changes and deselect the active target; Un-placed decor will be returned to the house chest

```lua
C_HousingBasicMode.CancelActiveEditing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.CancelActiveEditing()
```

### C_HousingBasicMode.CommitDecorMovement

Attempt to save the changes made to the currently selected decor instance

```lua
C_HousingBasicMode.CommitDecorMovement()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.CommitDecorMovement()
```

### C_HousingBasicMode.CommitHouseExteriorPosition

Attempt to save the changes made to the House Exterior's position within the plot

```lua
C_HousingBasicMode.CommitHouseExteriorPosition()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.CommitHouseExteriorPosition()
```

### C_HousingBasicMode.FinishPlacingNewDecor

```lua
C_HousingBasicMode.FinishPlacingNewDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.FinishPlacingNewDecor()
```

### C_HousingBasicMode.GetHoveredDecorInfo

Returns info for the placed decor instance currently being hovered, if there is one

```lua
info = C_HousingBasicMode.GetHoveredDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingBasicMode.GetHoveredDecorInfo()
```

### C_HousingBasicMode.GetSelectedDecorInfo

Returns info for the decor instance that's currently selected, if there is one

```lua
info = C_HousingBasicMode.GetSelectedDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingBasicMode.GetSelectedDecorInfo()
```

### C_HousingBasicMode.IsDecorSelected

Returns true if a decor instance is currently selected and being dragged

```lua
hasSelectedDecor = C_HousingBasicMode.IsDecorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedDecor = C_HousingBasicMode.IsDecorSelected()
```

### C_HousingBasicMode.IsFreePlaceEnabled

When free place is enabled, collision checks while dragging decor/the house exterior are ignored

```lua
freePlaceEnabled = C_HousingBasicMode.IsFreePlaceEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `freePlaceEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local freePlaceEnabled = C_HousingBasicMode.IsFreePlaceEnabled()
```

### C_HousingBasicMode.IsGridSnapEnabled

```lua
isGridSnapEnabled = C_HousingBasicMode.IsGridSnapEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGridSnapEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isGridSnapEnabled = C_HousingBasicMode.IsGridSnapEnabled()
```

### C_HousingBasicMode.IsGridVisible

```lua
gridVisible = C_HousingBasicMode.IsGridVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gridVisible = C_HousingBasicMode.IsGridVisible()
```

### C_HousingBasicMode.IsHouseExteriorHovered

Returns true if the house's exterior is currently being hovered

```lua
isHouseExteriorHovered = C_HousingBasicMode.IsHouseExteriorHovered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorHovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorHovered = C_HousingBasicMode.IsHouseExteriorHovered()
```

### C_HousingBasicMode.IsHouseExteriorSelected

Returns true if the house's exterior is currently selected and being moved

```lua
isHouseExteriorSelected = C_HousingBasicMode.IsHouseExteriorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorSelected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorSelected = C_HousingBasicMode.IsHouseExteriorSelected()
```

### C_HousingBasicMode.IsHoveringDecor

Returns true if a placed decor instance is currently being hovered

```lua
isHoveringDecor = C_HousingBasicMode.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingBasicMode.IsHoveringDecor()
```

### C_HousingBasicMode.IsPlacingNewDecor

```lua
hasPendingDecor = C_HousingBasicMode.IsPlacingNewDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPendingDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPendingDecor = C_HousingBasicMode.IsPlacingNewDecor()
```

### C_HousingBasicMode.RemoveSelectedDecor

Attempt to return the currently selected decor instance back to the house chest

```lua
C_HousingBasicMode.RemoveSelectedDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.RemoveSelectedDecor()
```

### C_HousingBasicMode.RotateDecor

Rotates the currently selected decor along a single axis; For wall decor, rotates such that the object stays flat against its current wall; For all other decor, rotates around the Z (vertical) axis

```lua
C_HousingBasicMode.RotateDecor(rotDegrees)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotDegrees` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.RotateDecor(0)
```

### C_HousingBasicMode.RotateHouseExterior

Rotates the House Exterior around the Z (vertical) axis

```lua
C_HousingBasicMode.RotateHouseExterior(rotDegrees)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotDegrees` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.RotateHouseExterior(0)
```

### C_HousingBasicMode.SetFreePlaceEnabled

Set whether free place is enabled; When free place is enabled, collision checks while dragging decor/the house exterior are ignored

```lua
C_HousingBasicMode.SetFreePlaceEnabled(freePlaceEnabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `freePlaceEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.SetFreePlaceEnabled(false)
```

### C_HousingBasicMode.SetGridSnapEnabled

```lua
C_HousingBasicMode.SetGridSnapEnabled(isGridSnapEnabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGridSnapEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.SetGridSnapEnabled(false)
```

### C_HousingBasicMode.SetGridVisible

```lua
C_HousingBasicMode.SetGridVisible(gridVisible)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.SetGridVisible(false)
```

### C_HousingBasicMode.StartPlacingNewDecor

```lua
C_HousingBasicMode.StartPlacingNewDecor(catalogEntryVariantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `catalogEntryVariantID` | HousingCatalogEntryVariantID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.StartPlacingNewDecor(catalogEntryVariantID)
```

### C_HousingBasicMode.StartPlacingPreviewDecor

```lua
C_HousingBasicMode.StartPlacingPreviewDecor(decorRecordID, [bundleCatalogShopProductID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorRecordID` | number | no |  |
| `bundleCatalogShopProductID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingBasicMode.StartPlacingPreviewDecor(0)
```

## Events

### HOUSING_BASIC_MODE_HOVERED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasHoveredTarget` | bool | no |  |
| `targetType` | HousingBasicModeTargetType | no |  |

### HOUSING_BASIC_MODE_PLACEMENT_FLAGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetType` | HousingBasicModeTargetType | no |  |
| `activeFlags` | HousingDecorPlacementRestriction | no |  |

### HOUSING_BASIC_MODE_SELECTED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedTarget` | bool | no |  |
| `targetType` | HousingBasicModeTargetType | no |  |
| `isPreview` | bool | no |  |

### HOUSING_DECOR_FREE_PLACE_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFreePlaceEnabled` | bool | no |  |

### HOUSING_DECOR_GRID_SNAP_OCCURRED

### HOUSING_DECOR_GRID_SNAP_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGridSnapEnabled` | bool | no |  |

## Types

### HousingBasicModeTargetType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HousingBasicModeTargetType | no |  |
| `Decor` | HousingBasicModeTargetType | no |  |
| `House` | HousingBasicModeTargetType | no |  |

