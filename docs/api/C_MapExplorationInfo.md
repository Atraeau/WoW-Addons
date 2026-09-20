# C_MapExplorationInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **1** events · **2** types

## Functions

### C_MapExplorationInfo.GetExploredAreaIDsAtPosition

```lua
areaID = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(uiMapID, normalizedPosition)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `normalizedPosition` | vector2 | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaID` | number[] | yes |  |

**Example**

```lua
local areaID = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(0, normalizedPosition)
```

### C_MapExplorationInfo.GetExploredMapTextures

```lua
overlayInfo = C_MapExplorationInfo.GetExploredMapTextures(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overlayInfo` | UiMapExplorationInfo[] | no |  |

**Example**

```lua
local overlayInfo = C_MapExplorationInfo.GetExploredMapTextures(0)
```

## Events

### MAP_EXPLORATION_UPDATED

## Types

### UiMapExplorationHitRect (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `top` | number | no |  |
| `bottom` | number | no |  |
| `left` | number | no |  |
| `right` | number | no |  |

### UiMapExplorationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureWidth` | number | no |  |
| `textureHeight` | number | no |  |
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |
| `isShownByMouseOver` | bool | no |  |
| `isDrawOnTopLayer` | bool | no |  |
| `fileDataIDs` | number[] | no |  |
| `hitRect` | UiMapExplorationHitRect | no |  |

