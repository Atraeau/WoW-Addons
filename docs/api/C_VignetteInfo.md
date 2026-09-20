# C_VignetteInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **2** events · **1** types

## Functions

### C_VignetteInfo.FindBestUniqueVignette

```lua
bestUniqueVignetteIndex = C_VignetteInfo.FindBestUniqueVignette(vignetteGUIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUIDs` | WOWGUID[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bestUniqueVignetteIndex` | luaIndex | yes |  |

**Example**

```lua
local bestUniqueVignetteIndex = C_VignetteInfo.FindBestUniqueVignette("Creature-0-0000-0-0-0-0")
```

### C_VignetteInfo.GetHealthPercent

```lua
healthPct = C_VignetteInfo.GetHealthPercent(vignetteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healthPct` | number | yes |  |

**Example**

```lua
local healthPct = C_VignetteInfo.GetHealthPercent("Creature-0-0000-0-0-0-0")
```

### C_VignetteInfo.GetRecommendedGroupSize

```lua
minGroupSize, maxGroupSize = C_VignetteInfo.GetRecommendedGroupSize(vignetteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minGroupSize` | number | no |  |
| `maxGroupSize` | number | no |  |

**Example**

```lua
local minGroupSize, maxGroupSize = C_VignetteInfo.GetRecommendedGroupSize("Creature-0-0000-0-0-0-0")
```

### C_VignetteInfo.GetVignetteInfo

```lua
vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteInfo` | VignetteInfo | yes |  |

**Example**

```lua
local vignetteInfo = C_VignetteInfo.GetVignetteInfo("Creature-0-0000-0-0-0-0")
```

### C_VignetteInfo.GetVignettePosition

```lua
vignettePosition, vignetteFacing = C_VignetteInfo.GetVignettePosition(vignetteGUID, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignettePosition` | vector2 | no |  |
| `vignetteFacing` | number | yes |  |

**Example**

```lua
local vignettePosition, vignetteFacing = C_VignetteInfo.GetVignettePosition("Creature-0-0000-0-0-0-0", 0)
```

### C_VignetteInfo.GetVignettes

```lua
vignetteGUIDs = C_VignetteInfo.GetVignettes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUIDs` | WOWGUID[] | no |  |

**Example**

```lua
local vignetteGUIDs = C_VignetteInfo.GetVignettes()
```

## Events

### VIGNETTE_MINIMAP_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |
| `onMinimap` | bool | no |  |

### VIGNETTES_UPDATED

## Types

### VignetteInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |
| `objectGUID` | WOWGUID | no |  |
| `name` | cstring | no |  |
| `isDead` | bool | no |  |
| `onWorldMap` | bool | no |  |
| `zoneInfiniteAOI` | bool | no |  |
| `onMinimap` | bool | no |  |
| `isUnique` | bool | no |  |
| `inFogOfWar` | bool | no |  |
| `atlasName` | textureAtlas | no |  |
| `hasTooltip` | bool | no |  |
| `vignetteID` | number | no |  |
| `type` | VignetteType | no |  |
| `rewardQuestID` | number | no |  |
| `tooltipWidgetSet` | number | yes |  |
| `iconWidgetSet` | number | yes |  |
| `addPaddingAboveTooltipWidgets` | bool | yes |  |
| `mapPin` | UIMapPinInfo | yes |  |
| `objectiveType` | VignetteObjectiveType | yes |  |

