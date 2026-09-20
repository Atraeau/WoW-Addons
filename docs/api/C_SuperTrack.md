# C_SuperTrack

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**20** functions · **2** events · **0** types

## Functions

### C_SuperTrack.ClearAllSuperTracked

```lua
C_SuperTrack.ClearAllSuperTracked()
```

**Example**

```lua
C_SuperTrack.ClearAllSuperTracked()
```

### C_SuperTrack.ClearSuperTrackedContent

```lua
C_SuperTrack.ClearSuperTrackedContent()
```

**Example**

```lua
C_SuperTrack.ClearSuperTrackedContent()
```

### C_SuperTrack.ClearSuperTrackedMapPin

```lua
C_SuperTrack.ClearSuperTrackedMapPin()
```

**Example**

```lua
C_SuperTrack.ClearSuperTrackedMapPin()
```

### C_SuperTrack.GetHighestPrioritySuperTrackingType

```lua
type = C_SuperTrack.GetHighestPrioritySuperTrackingType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | SuperTrackingType | yes |  |

**Example**

```lua
local type = C_SuperTrack.GetHighestPrioritySuperTrackingType()
```

### C_SuperTrack.GetSuperTrackedContent

```lua
trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |

**Example**

```lua
local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
```

### C_SuperTrack.GetSuperTrackedItemName

```lua
name, description = C_SuperTrack.GetSuperTrackedItemName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |

**Example**

```lua
local name, description = C_SuperTrack.GetSuperTrackedItemName()
```

### C_SuperTrack.GetSuperTrackedMapPin

```lua
type, typeID = C_SuperTrack.GetSuperTrackedMapPin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | SuperTrackingMapPinType | no |  |
| `typeID` | number | no |  |

**Example**

```lua
local type, typeID = C_SuperTrack.GetSuperTrackedMapPin()
```

### C_SuperTrack.GetSuperTrackedQuestID

```lua
questID = C_SuperTrack.GetSuperTrackedQuestID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example**

```lua
local questID = C_SuperTrack.GetSuperTrackedQuestID()
```

### C_SuperTrack.GetSuperTrackedVignette

```lua
vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | yes |  |

**Example**

```lua
local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
```

### C_SuperTrack.IsSuperTrackingAnything

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
```

### C_SuperTrack.IsSuperTrackingContent

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingContent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingContent()
```

### C_SuperTrack.IsSuperTrackingCorpse

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingCorpse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingCorpse()
```

### C_SuperTrack.IsSuperTrackingMapPin

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingMapPin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingMapPin()
```

### C_SuperTrack.IsSuperTrackingQuest

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingQuest()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingQuest()
```

### C_SuperTrack.IsSuperTrackingUserWaypoint

```lua
isSuperTracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuperTracking` | bool | no |  |

**Example**

```lua
local isSuperTracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
```

### C_SuperTrack.SetSuperTrackedContent

```lua
C_SuperTrack.SetSuperTrackedContent(trackableType, trackableID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |

**Example**

```lua
C_SuperTrack.SetSuperTrackedContent(trackableType, 0)
```

### C_SuperTrack.SetSuperTrackedMapPin

```lua
C_SuperTrack.SetSuperTrackedMapPin(type, typeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | SuperTrackingMapPinType | no |  |
| `typeID` | number | no |  |

**Example**

```lua
C_SuperTrack.SetSuperTrackedMapPin(type, 0)
```

### C_SuperTrack.SetSuperTrackedQuestID

```lua
C_SuperTrack.SetSuperTrackedQuestID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
C_SuperTrack.SetSuperTrackedQuestID(0)
```

### C_SuperTrack.SetSuperTrackedUserWaypoint

```lua
C_SuperTrack.SetSuperTrackedUserWaypoint(superTracked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `superTracked` | bool | no |  |

**Example**

```lua
C_SuperTrack.SetSuperTrackedUserWaypoint(false)
```

### C_SuperTrack.SetSuperTrackedVignette

```lua
C_SuperTrack.SetSuperTrackedVignette(vignetteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vignetteGUID` | WOWGUID | no |  |

**Example**

```lua
C_SuperTrack.SetSuperTrackedVignette("Creature-0-0000-0-0-0-0")
```

## Events

### SUPER_TRACKING_CHANGED

### SUPER_TRACKING_PATH_UPDATED

