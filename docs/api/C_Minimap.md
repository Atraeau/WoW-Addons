# C_Minimap

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**23** functions · **4** events · **2** types

## Functions

### C_Minimap.CanTrackBattlePets

```lua
CanTrackBattlePets = C_Minimap.CanTrackBattlePets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `CanTrackBattlePets` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local CanTrackBattlePets = C_Minimap.CanTrackBattlePets()
```

### C_Minimap.ClearAllTracking

```lua
C_Minimap.ClearAllTracking()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.ClearAllTracking()
```

### C_Minimap.ClearMinimapInsetInfo

```lua
C_Minimap.ClearMinimapInsetInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.ClearMinimapInsetInfo()
```

### C_Minimap.GetDefaultTrackingValue

```lua
defaultValue = C_Minimap.GetDefaultTrackingValue(filterType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterType` | MinimapTrackingFilter | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultValue` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local defaultValue = C_Minimap.GetDefaultTrackingValue("HELPFUL")
```

### C_Minimap.GetDrawGroundTextures

```lua
draw = C_Minimap.GetDrawGroundTextures()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `draw` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local draw = C_Minimap.GetDrawGroundTextures()
```

### C_Minimap.GetNumQuestPOIWorldEffects

```lua
worldEffectCount = C_Minimap.GetNumQuestPOIWorldEffects()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `worldEffectCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local worldEffectCount = C_Minimap.GetNumQuestPOIWorldEffects()
```

### C_Minimap.GetNumTrackingTypes

```lua
numTrackingTypes = C_Minimap.GetNumTrackingTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numTrackingTypes` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numTrackingTypes = C_Minimap.GetNumTrackingTypes()
```

### C_Minimap.GetPOITextureCoords

```lua
textureCoordsX, textureCoordsY, textureCoordsZ, textureCoordsW = C_Minimap.GetPOITextureCoords([index])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureCoordsX` | number | no |  |
| `textureCoordsY` | number | no |  |
| `textureCoordsZ` | number | no |  |
| `textureCoordsW` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureCoordsX, textureCoordsY, textureCoordsZ, textureCoordsW = C_Minimap.GetPOITextureCoords()
```

### C_Minimap.GetTrackingFilter

```lua
trackingType = C_Minimap.GetTrackingFilter(spellIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackingType` | MinimapScriptTrackingFilter | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackingType = C_Minimap.GetTrackingFilter(1)
```

### C_Minimap.GetTrackingInfo

```lua
trackingInfo = C_Minimap.GetTrackingInfo(spellIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackingInfo` | MinimapScriptTrackingInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackingInfo = C_Minimap.GetTrackingInfo(1)
```

### C_Minimap.GetUiMapID

```lua
uiMapID = C_Minimap.GetUiMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapID = C_Minimap.GetUiMapID()
```

### C_Minimap.GetViewRadius

```lua
yards = C_Minimap.GetViewRadius()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `yards` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local yards = C_Minimap.GetViewRadius()
```

### C_Minimap.IsFilteredOut

```lua
isFiltered = C_Minimap.IsFilteredOut(filterType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterType` | MinimapTrackingFilter | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFiltered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFiltered = C_Minimap.IsFilteredOut("HELPFUL")
```

### C_Minimap.IsInsideQuestBlob

```lua
isInside = C_Minimap.IsInsideQuestBlob(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInside` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInside = C_Minimap.IsInsideQuestBlob(0)
```

### C_Minimap.IsRotateMinimapIgnored

```lua
isIgnored = C_Minimap.IsRotateMinimapIgnored()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnored` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnored = C_Minimap.IsRotateMinimapIgnored()
```

### C_Minimap.IsTrackingAccountCompletedQuests

```lua
IsTrackingAccountCompletedQuests = C_Minimap.IsTrackingAccountCompletedQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `IsTrackingAccountCompletedQuests` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local IsTrackingAccountCompletedQuests = C_Minimap.IsTrackingAccountCompletedQuests()
```

### C_Minimap.IsTrackingBattlePets

```lua
isTrackingBattlePets = C_Minimap.IsTrackingBattlePets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrackingBattlePets` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrackingBattlePets = C_Minimap.IsTrackingBattlePets()
```

### C_Minimap.IsTrackingHiddenQuests

```lua
isTrackingHiddenQuests = C_Minimap.IsTrackingHiddenQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrackingHiddenQuests` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrackingHiddenQuests = C_Minimap.IsTrackingHiddenQuests()
```

### C_Minimap.SetDrawGroundTextures

```lua
C_Minimap.SetDrawGroundTextures(draw)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `draw` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.SetDrawGroundTextures(false)
```

### C_Minimap.SetIgnoreRotateMinimap

```lua
C_Minimap.SetIgnoreRotateMinimap(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.SetIgnoreRotateMinimap(false)
```

### C_Minimap.SetMinimapInsetInfo

```lua
C_Minimap.SetMinimapInsetInfo(minAngle, maxAngle, scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minAngle` | number | no |  |
| `maxAngle` | number | no |  |
| `scalar` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.SetMinimapInsetInfo(0, 0, 0)
```

### C_Minimap.SetTracking

```lua
C_Minimap.SetTracking(index, on)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `on` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Minimap.SetTracking(1, false)
```

### C_Minimap.ShouldUseHybridMinimap

```lua
shouldUse = C_Minimap.ShouldUseHybridMinimap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldUse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldUse = C_Minimap.ShouldUseHybridMinimap()
```

## Events

### MINIMAP_PING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `y` | number | no |  |
| `x` | number | no |  |

### MINIMAP_UPDATE_TRACKING

### MINIMAP_UPDATE_ZOOM

### PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `isInside` | bool | no |  |

## Types

### MinimapScriptTrackingFilter (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |
| `filterID` | MinimapTrackingFilter | yes |  |

### MinimapScriptTrackingInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `texture` | fileID | no |  |
| `active` | bool | no |  |
| `type` | cstring | no |  |
| `subType` | number | no |  |
| `spellID` | number | yes |  |

