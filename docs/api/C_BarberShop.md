# C_BarberShop

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**29** functions · **7** events · **0** types

## Functions

### C_BarberShop.ApplyCustomizationChoices

```lua
success = C_BarberShop.ApplyCustomizationChoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_BarberShop.ApplyCustomizationChoices()
```

### C_BarberShop.Cancel

```lua
C_BarberShop.Cancel()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.Cancel()
```

### C_BarberShop.ClearPreviewChoices

```lua
C_BarberShop.ClearPreviewChoices(clearSavedChoices)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clearSavedChoices` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.ClearPreviewChoices(false)
```

### C_BarberShop.GetAvailableCustomizations

```lua
categories = C_BarberShop.GetAvailableCustomizations()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categories` | CharCustomizationCategory[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categories = C_BarberShop.GetAvailableCustomizations()
```

### C_BarberShop.GetCurrentCameraZoom

```lua
zoomLevel = C_BarberShop.GetCurrentCameraZoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local zoomLevel = C_BarberShop.GetCurrentCameraZoom()
```

### C_BarberShop.GetCurrentCharacterData

```lua
characterData = C_BarberShop.GetCurrentCharacterData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterData` | PlayerInfoCharacterData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local characterData = C_BarberShop.GetCurrentCharacterData()
```

### C_BarberShop.GetCurrentCost

```lua
cost = C_BarberShop.GetCurrentCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cost = C_BarberShop.GetCurrentCost()
```

### C_BarberShop.GetViewingChrModel

```lua
chrModelID = C_BarberShop.GetViewingChrModel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chrModelID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chrModelID = C_BarberShop.GetViewingChrModel()
```

### C_BarberShop.HasAlteredForm

```lua
hasAlteredForm = C_BarberShop.HasAlteredForm()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAlteredForm` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAlteredForm = C_BarberShop.HasAlteredForm()
```

### C_BarberShop.HasAnyChanges

```lua
hasChanges = C_BarberShop.HasAnyChanges()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasChanges` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasChanges = C_BarberShop.HasAnyChanges()
```

### C_BarberShop.HasCustomizationFeature

```lua
hasCustomizationFeature = C_BarberShop.HasCustomizationFeature(featureMask)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `featureMask` | ChrModelFeatureFlags | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCustomizationFeature` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasCustomizationFeature = C_BarberShop.HasCustomizationFeature(featureMask)
```

### C_BarberShop.IsViewingAlteredForm

```lua
isViewingAlteredForm = C_BarberShop.IsViewingAlteredForm()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isViewingAlteredForm` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isViewingAlteredForm = C_BarberShop.IsViewingAlteredForm()
```

### C_BarberShop.MarkCustomizationChoiceAsSeen

```lua
C_BarberShop.MarkCustomizationChoiceAsSeen(choiceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `choiceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.MarkCustomizationChoiceAsSeen(0)
```

### C_BarberShop.MarkCustomizationOptionAsSeen

```lua
C_BarberShop.MarkCustomizationOptionAsSeen(optionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.MarkCustomizationOptionAsSeen(0)
```

### C_BarberShop.PreviewCustomizationChoice

```lua
C_BarberShop.PreviewCustomizationChoice(optionID, choiceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |
| `choiceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.PreviewCustomizationChoice(0, 0)
```

### C_BarberShop.RandomizeCustomizationChoices

```lua
C_BarberShop.RandomizeCustomizationChoices()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.RandomizeCustomizationChoices()
```

### C_BarberShop.ResetCameraRotation

```lua
C_BarberShop.ResetCameraRotation()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.ResetCameraRotation()
```

### C_BarberShop.ResetCustomizationChoices

```lua
C_BarberShop.ResetCustomizationChoices()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.ResetCustomizationChoices()
```

### C_BarberShop.RotateCamera

```lua
C_BarberShop.RotateCamera(diffDegrees)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `diffDegrees` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.RotateCamera(0)
```

### C_BarberShop.SaveSeenChoices

```lua
C_BarberShop.SaveSeenChoices()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SaveSeenChoices()
```

### C_BarberShop.SetCameraDistanceOffset

```lua
C_BarberShop.SetCameraDistanceOffset(offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetCameraDistanceOffset(1)
```

### C_BarberShop.SetCameraZoomLevel

```lua
C_BarberShop.SetCameraZoomLevel(zoomLevel, [keepCustomZoom])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomLevel` | number | no |  |
| `keepCustomZoom` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetCameraZoomLevel(0)
```

### C_BarberShop.SetCustomizationChoice

```lua
C_BarberShop.SetCustomizationChoice(optionID, choiceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |
| `choiceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetCustomizationChoice(0, 0)
```

### C_BarberShop.SetModelDressState

```lua
C_BarberShop.SetModelDressState(dressedState)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dressedState` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetModelDressState(false)
```

### C_BarberShop.SetSelectedSex

```lua
C_BarberShop.SetSelectedSex(sex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sex` | UnitSex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetSelectedSex(sex)
```

### C_BarberShop.SetViewingAlteredForm

```lua
C_BarberShop.SetViewingAlteredForm(isViewingAlteredForm)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isViewingAlteredForm` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetViewingAlteredForm(false)
```

### C_BarberShop.SetViewingChrModel

```lua
C_BarberShop.SetViewingChrModel([chrModelID], [spellShapeshiftFormID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chrModelID` | number | yes |  |
| `spellShapeshiftFormID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetViewingChrModel()
```

### C_BarberShop.SetViewingShapeshiftForm

```lua
C_BarberShop.SetViewingShapeshiftForm([shapeshiftFormID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shapeshiftFormID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.SetViewingShapeshiftForm()
```

### C_BarberShop.ZoomCamera

```lua
C_BarberShop.ZoomCamera(zoomAmount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomAmount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BarberShop.ZoomCamera(0)
```

## Events

### BARBER_SHOP_APPEARANCE_APPLIED

### BARBER_SHOP_CAMERA_VALUES_UPDATED

### BARBER_SHOP_CLOSE

### BARBER_SHOP_COST_UPDATE

### BARBER_SHOP_FORCE_CUSTOMIZATIONS_UPDATE

### BARBER_SHOP_OPEN

### BARBER_SHOP_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

