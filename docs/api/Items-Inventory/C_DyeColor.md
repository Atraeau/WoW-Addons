# C_DyeColor

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**8** functions · **2** events · **0** types

## Functions

### C_DyeColor.GetAllDyeColorCategories

```lua
dyeColorCategoryIDs = C_DyeColor.GetAllDyeColorCategories()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorCategoryIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorCategoryIDs = C_DyeColor.GetAllDyeColorCategories()
```

### C_DyeColor.GetAllDyeColors

```lua
dyeColorIDs = C_DyeColor.GetAllDyeColors(ownedColorsOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedColorsOnly` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorIDs = C_DyeColor.GetAllDyeColors(false)
```

### C_DyeColor.GetDyeColorCategoryInfo

```lua
dyeColorCategoryInfo = C_DyeColor.GetDyeColorCategoryInfo(dyeColorCategoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorCategoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorCategoryInfo` | DyeColorCategoryDisplayInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorCategoryInfo = C_DyeColor.GetDyeColorCategoryInfo(0)
```

### C_DyeColor.GetDyeColorInfo

```lua
dyeColorInfo = C_DyeColor.GetDyeColorInfo(dyeColorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorInfo` | DyeColorDisplayInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorInfo = C_DyeColor.GetDyeColorInfo(0)
```

### C_DyeColor.GetDyeColorsForItem

```lua
dyeColorIDs = C_DyeColor.GetDyeColorsForItem(itemLinkOrID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLinkOrID` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorIDs = C_DyeColor.GetDyeColorsForItem(6948)
```

### C_DyeColor.GetDyeColorsForItemLocation

```lua
dyeColorIDs = C_DyeColor.GetDyeColorsForItemLocation(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorIDs = C_DyeColor.GetDyeColorsForItemLocation(6948)
```

### C_DyeColor.GetDyeColorsInCategory

```lua
dyeColorIDs = C_DyeColor.GetDyeColorsInCategory(dyeColorCategory, ownedColorsOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorCategory` | number | no |  |
| `ownedColorsOnly` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dyeColorIDs = C_DyeColor.GetDyeColorsInCategory(0, false)
```

### C_DyeColor.IsDyeColorOwned

True if the player owns any of the consumable item used to apply the specified dye

```lua
isOwned = C_DyeColor.IsDyeColorOwned(dyeColorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOwned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isOwned = C_DyeColor.IsDyeColorOwned(0)
```

## Events

### DYE_COLOR_CATEGORY_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorCategoryID` | number | no |  |

### DYE_COLOR_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dyeColorID` | number | no |  |

