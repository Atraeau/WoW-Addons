# C_HousingCustomizeMode

[← API index](../README.md) · group: [Housing](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**32** functions · **6** events · **4** types

## Functions

### C_HousingCustomizeMode.ApplyDyeToSelectedDecor

If a dyeable decor is selected, applies a specific dye color in a specific slot as a preview; See CommitDyesForSelectedDecor to actually save applied dye changes

```lua
C_HousingCustomizeMode.ApplyDyeToSelectedDecor(dyeSlotID, [dyeColorID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeSlotID` | number | no |  |
| `dyeColorID` | number | yes | If not provided, clears the dye from the specified dye slot, returning that part of the decor asset to its default color |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyDyeToSelectedDecor(1)
```

### C_HousingCustomizeMode.ApplyPetToSelectedDecor

If a decor is selected that supports pets, applies a specific petID to be shown on that decor

```lua
C_HousingCustomizeMode.ApplyPetToSelectedDecor([petID], petBehavior)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | yes |  |
| `petBehavior` | HousingPetBehaviorType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyPetToSelectedDecor(petBehavior)
```

### C_HousingCustomizeMode.ApplyThemeToRoom

Attempt to apply a specific theme set (aka style) to all applicable room components in the current room

```lua
C_HousingCustomizeMode.ApplyThemeToRoom(themeSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `themeSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyThemeToRoom(0)
```

### C_HousingCustomizeMode.ApplyThemeToSelectedRoomComponent

Attempt to apply a specific theme set (aka style) to the currently selected room component only

```lua
C_HousingCustomizeMode.ApplyThemeToSelectedRoomComponent(themeSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `themeSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyThemeToSelectedRoomComponent(0)
```

### C_HousingCustomizeMode.ApplyWallpaperToAllWalls

Attempt to apply a specific wallpaper (aka material/texture) to all applicable room components in the current room

```lua
C_HousingCustomizeMode.ApplyWallpaperToAllWalls(roomComponentTextureRecID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomComponentTextureRecID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyWallpaperToAllWalls(0)
```

### C_HousingCustomizeMode.ApplyWallpaperToSelectedRoomComponent

Attempt to apply a specific wallpaper (aka material/texture) to the currently selected room component only

```lua
C_HousingCustomizeMode.ApplyWallpaperToSelectedRoomComponent(roomComponentTextureRecID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomComponentTextureRecID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ApplyWallpaperToSelectedRoomComponent(0)
```

### C_HousingCustomizeMode.CancelActiveEditing

Cancels all in-progress editing of the selected target, which will reset any unapplied customization changes and deselect the active target

```lua
C_HousingCustomizeMode.CancelActiveEditing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.CancelActiveEditing()
```

### C_HousingCustomizeMode.ClearDyesForSelectedDecor

Clears all previewed dye changes on the selected decor; Does not clear any already saved dyes that were previously applied

```lua
C_HousingCustomizeMode.ClearDyesForSelectedDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ClearDyesForSelectedDecor()
```

### C_HousingCustomizeMode.ClearTargetRoomComponent

Deselect the currently selected room component, if there is one

```lua
C_HousingCustomizeMode.ClearTargetRoomComponent()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.ClearTargetRoomComponent()
```

### C_HousingCustomizeMode.CommitDyesForSelectedDecor

Attempt to save all previewed dye changes made to the selected decor

```lua
hasChanges = C_HousingCustomizeMode.CommitDyesForSelectedDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasChanges` | bool | no | True if there were any changes to save |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasChanges = C_HousingCustomizeMode.CommitDyesForSelectedDecor()
```

### C_HousingCustomizeMode.GetHoveredDecorInfo

Returns info for the placed decor instance currently being hovered, if there is one

```lua
info = C_HousingCustomizeMode.GetHoveredDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingCustomizeMode.GetHoveredDecorInfo()
```

### C_HousingCustomizeMode.GetHoveredRoomComponentInfo

Returns info for the room component currently being hovered, if there is one

```lua
info = C_HousingCustomizeMode.GetHoveredRoomComponentInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingRoomComponentInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingCustomizeMode.GetHoveredRoomComponentInfo()
```

### C_HousingCustomizeMode.GetNumDyesToRemoveOnSelectedDecor

If a dyeable decor instance is selected, returns how many dye slots would be cleared on applying all currently previewed dye changes

```lua
numDyesToRemove = C_HousingCustomizeMode.GetNumDyesToRemoveOnSelectedDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDyesToRemove` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numDyesToRemove = C_HousingCustomizeMode.GetNumDyesToRemoveOnSelectedDecor()
```

### C_HousingCustomizeMode.GetNumDyesToSpendOnSelectedDecor

If a dyeable decor instance is selected, returns how many dye items would be spent on applying all currently previewed dye changes

```lua
numDyesToSpend = C_HousingCustomizeMode.GetNumDyesToSpendOnSelectedDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDyesToSpend` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numDyesToSpend = C_HousingCustomizeMode.GetNumDyesToSpendOnSelectedDecor()
```

### C_HousingCustomizeMode.GetPreviewDyesOnSelectedDecor

If a dyeable decor instance is selected, returns info structs for each new/changed dye currently being previewed

```lua
previewDyes = C_HousingCustomizeMode.GetPreviewDyesOnSelectedDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previewDyes` | PreviewDyeSlotInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local previewDyes = C_HousingCustomizeMode.GetPreviewDyesOnSelectedDecor()
```

### C_HousingCustomizeMode.GetRecentlyUsedDyes

Returns a list of ids for the dyes most recently applied by the player, if any

```lua
recentDyes = C_HousingCustomizeMode.GetRecentlyUsedDyes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentDyes` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentDyes = C_HousingCustomizeMode.GetRecentlyUsedDyes()
```

### C_HousingCustomizeMode.GetRecentlyUsedThemeSets

Returns a list of ids for the theme sets (aka styles) most recently applied by the player, if any

```lua
recentThemeSets = C_HousingCustomizeMode.GetRecentlyUsedThemeSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentThemeSets` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentThemeSets = C_HousingCustomizeMode.GetRecentlyUsedThemeSets()
```

### C_HousingCustomizeMode.GetRecentlyUsedWallpapers

Returns a list of ids for the wallpapers most recently applied by the player, if any

```lua
recentWallpapers = C_HousingCustomizeMode.GetRecentlyUsedWallpapers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentWallpapers` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentWallpapers = C_HousingCustomizeMode.GetRecentlyUsedWallpapers()
```

### C_HousingCustomizeMode.GetSelectedDecorInfo

Returns info for the decor instance that's currently selected, if there is one

```lua
info = C_HousingCustomizeMode.GetSelectedDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingCustomizeMode.GetSelectedDecorInfo()
```

### C_HousingCustomizeMode.GetSelectedDecorPetInfo

If a decor is selected that supports pets, gets petID and behavior type from decor

```lua
petID, petBehavior = C_HousingCustomizeMode.GetSelectedDecorPetInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | yes |  |
| `petBehavior` | HousingPetBehaviorType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local petID, petBehavior = C_HousingCustomizeMode.GetSelectedDecorPetInfo()
```

### C_HousingCustomizeMode.GetSelectedRoomComponentInfo

Returns info for the currently selected room component, if there is one

```lua
info = C_HousingCustomizeMode.GetSelectedRoomComponentInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingRoomComponentInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingCustomizeMode.GetSelectedRoomComponentInfo()
```

### C_HousingCustomizeMode.GetThemeSetInfo

Returns the name of the specified theme set (aka style) if it exists

```lua
name = C_HousingCustomizeMode.GetThemeSetInfo(themeSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `themeSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_HousingCustomizeMode.GetThemeSetInfo(0)
```

### C_HousingCustomizeMode.GetWallpapersForRoomComponentType

Get all wallpapers (aka materials/textures) available for the selected room component type, if any

```lua
availableWallpapers = C_HousingCustomizeMode.GetWallpapersForRoomComponentType(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingRoomComponentType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `availableWallpapers` | RoomComponentWallpaper[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local availableWallpapers = C_HousingCustomizeMode.GetWallpapersForRoomComponentType(type)
```

### C_HousingCustomizeMode.IsDecorSelected

Returns true if a decor instance is currently selected for customization

```lua
hasSelectedDecor = C_HousingCustomizeMode.IsDecorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedDecor = C_HousingCustomizeMode.IsDecorSelected()
```

### C_HousingCustomizeMode.IsHouseExteriorDoorHovered

Returns true if the entry door of the house's exterior is currently being hovered

```lua
isHouseExteriorDoorHovered = C_HousingCustomizeMode.IsHouseExteriorDoorHovered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorDoorHovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorDoorHovered = C_HousingCustomizeMode.IsHouseExteriorDoorHovered()
```

### C_HousingCustomizeMode.IsHoveringDecor

Returns true if a placed decor instance is currently being hovered

```lua
isHoveringDecor = C_HousingCustomizeMode.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingCustomizeMode.IsHoveringDecor()
```

### C_HousingCustomizeMode.IsHoveringRoomComponent

Returns true if a room component is currently being hovered

```lua
isHovering = C_HousingCustomizeMode.IsHoveringRoomComponent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHovering` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHovering = C_HousingCustomizeMode.IsHoveringRoomComponent()
```

### C_HousingCustomizeMode.IsRoomComponentSelected

Returns true if a room component is currently selected for customization

```lua
hasSelectedComponent = C_HousingCustomizeMode.IsRoomComponentSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedComponent` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedComponent = C_HousingCustomizeMode.IsRoomComponentSelected()
```

### C_HousingCustomizeMode.RoomComponentSupportsVariant

Check whether a specific room component supports a particular variant; What kind of id or enum 'variant' equates to is complicated, as it depends on the component type

```lua
variantSupported = C_HousingCustomizeMode.RoomComponentSupportsVariant(componentID, variant)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `componentID` | number | no |  |
| `variant` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `variantSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local variantSupported = C_HousingCustomizeMode.RoomComponentSupportsVariant(0, 0)
```

### C_HousingCustomizeMode.RoomConnectionSupportsDoorType

Check whether a specific room component, within a specific room, supports a particular doorType

```lua
doorTypeSupported = C_HousingCustomizeMode.RoomConnectionSupportsDoorType(roomGUID, componentID, newDoortype)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `newDoortype` | HousingRoomComponentDoorType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doorTypeSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doorTypeSupported = C_HousingCustomizeMode.RoomConnectionSupportsDoorType(UnitGUID("player"), 0, newDoortype)
```

### C_HousingCustomizeMode.SetRoomComponentCeilingType

Attempt to set a specific ceiling component, within a specific room, to a specific new ceiling type

```lua
C_HousingCustomizeMode.SetRoomComponentCeilingType(roomGUID, componentID, ceilingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `ceilingType` | HousingRoomComponentCeilingType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.SetRoomComponentCeilingType(UnitGUID("player"), 0, ceilingType)
```

### C_HousingCustomizeMode.SetRoomComponentDoorType

Attempt to set a specific door component, within a specific room, to a specific new door type

```lua
C_HousingCustomizeMode.SetRoomComponentDoorType(roomGUID, componentID, newDoortype)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `newDoortype` | HousingRoomComponentDoorType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCustomizeMode.SetRoomComponentDoorType(UnitGUID("player"), 0, newDoortype)
```

## Events

### HOUSING_CUSTOMIZE_MODE_HOVERED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasHoveredTarget` | bool | no |  |
| `targetType` | HousingCustomizeModeTargetType | no |  |

### HOUSING_CUSTOMIZE_MODE_SELECTED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedTarget` | bool | no |  |
| `targetType` | HousingCustomizeModeTargetType | no |  |

### HOUSING_DECOR_CUSTOMIZATION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

### HOUSING_DECOR_DYE_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |
| `housingResult` | HousingResult | no |  |

### HOUSING_ROOM_COMPONENT_CUSTOMIZATION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |

### HOUSING_ROOM_COMPONENT_CUSTOMIZATION_CHANGE_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `housingResult` | HousingResult | no |  |

## Types

### HousingCustomizeModeTargetType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HousingCustomizeModeTargetType | no |  |
| `Decor` | HousingCustomizeModeTargetType | no |  |
| `RoomComponent` | HousingCustomizeModeTargetType | no |  |
| `ExteriorHouse` | HousingCustomizeModeTargetType | no |  |

### HousingRoomComponentInstanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `type` | HousingRoomComponentType | no |  |
| `componentID` | number | no |  |
| `canBeCustomized` | bool | no |  |
| `currentThemeSet` | number | yes |  |
| `availableThemeSets` | number[] | no |  |
| `currentWallpaper` | number | yes |  |
| `currentRoomComponentTextureRecID` | number | yes |  |
| `ceilingType` | HousingRoomComponentCeilingType | no |  |
| `doorType` | HousingRoomComponentDoorType | no |  |

### PreviewDyeSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorID` | number | no |  |
| `dyeSlotID` | number | no |  |

### RoomComponentWallpaper (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `roomComponentTextureRecID` | number | no |  |

