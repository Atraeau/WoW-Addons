# C_ContentTracking

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**18** functions · **5** events · **0** types

## Functions

### C_ContentTracking.GetBestMapForTrackable

```lua
result, mapID = C_ContentTracking.GetBestMapForTrackable(trackableType, trackableID, ignoreWaypoint)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |
| `ignoreWaypoint` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ContentTrackingResult | no |  |
| `mapID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, mapID = C_ContentTracking.GetBestMapForTrackable(trackableType, 0, false)
```

### C_ContentTracking.GetCollectableSourceTrackingEnabled

```lua
isEnabled = C_ContentTracking.GetCollectableSourceTrackingEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_ContentTracking.GetCollectableSourceTrackingEnabled()
```

### C_ContentTracking.GetCollectableSourceTypes

```lua
collectableSourceTypes = C_ContentTracking.GetCollectableSourceTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectableSourceTypes` | ContentTrackingType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectableSourceTypes = C_ContentTracking.GetCollectableSourceTypes()
```

### C_ContentTracking.GetCurrentTrackingTarget

```lua
targetType, targetID = C_ContentTracking.GetCurrentTrackingTarget(type, id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetType` | ContentTrackingTargetType | no |  |
| `targetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local targetType, targetID = C_ContentTracking.GetCurrentTrackingTarget(type, 0)
```

### C_ContentTracking.GetEncounterTrackingInfo

```lua
trackingInfo = C_ContentTracking.GetEncounterTrackingInfo(journalEncounterID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `journalEncounterID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackingInfo` | EncounterTrackingInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackingInfo = C_ContentTracking.GetEncounterTrackingInfo(0)
```

### C_ContentTracking.GetNextWaypointForTrackable

```lua
result, mapInfo = C_ContentTracking.GetNextWaypointForTrackable(trackableType, trackableID, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ContentTrackingResult | no |  |
| `mapInfo` | ContentTrackingMapInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, mapInfo = C_ContentTracking.GetNextWaypointForTrackable(trackableType, 0, 0)
```

### C_ContentTracking.GetObjectiveText

```lua
objectiveText = C_ContentTracking.GetObjectiveText(targetType, targetID, includeHyperlinks)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetType` | ContentTrackingTargetType | no |  |
| `targetID` | number | no |  |
| `includeHyperlinks` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectiveText` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local objectiveText = C_ContentTracking.GetObjectiveText(targetType, 0, false)
```

### C_ContentTracking.GetTitle

```lua
title = C_ContentTracking.GetTitle(trackableType, trackableID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local title = C_ContentTracking.GetTitle(trackableType, 0)
```

### C_ContentTracking.GetTrackablesOnMap

```lua
result, trackableMapInfos = C_ContentTracking.GetTrackablesOnMap(trackableType, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ContentTrackingResult | no |  |
| `trackableMapInfos` | ContentTrackingMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, trackableMapInfos = C_ContentTracking.GetTrackablesOnMap(trackableType, 0)
```

### C_ContentTracking.GetTrackedIDs

```lua
entryIDs = C_ContentTracking.GetTrackedIDs(trackableType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local entryIDs = C_ContentTracking.GetTrackedIDs(trackableType)
```

### C_ContentTracking.GetVendorTrackingInfo

```lua
vendorTrackingInfo = C_ContentTracking.GetVendorTrackingInfo(collectableEntryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectableEntryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorTrackingInfo` | VendorTrackingInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vendorTrackingInfo = C_ContentTracking.GetVendorTrackingInfo(0)
```

### C_ContentTracking.GetWaypointText

```lua
waypointText = C_ContentTracking.GetWaypointText(trackableType, trackableID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `waypointText` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local waypointText = C_ContentTracking.GetWaypointText(trackableType, 0)
```

### C_ContentTracking.IsNavigable

If successful, returns if the trackable is either on your current map, or if we're able to determine a route to that map from your location via waypoints.

```lua
result, isNavigable = C_ContentTracking.IsNavigable(trackableType, trackableID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackableType` | ContentTrackingType | no |  |
| `trackableID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ContentTrackingResult | no |  |
| `isNavigable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, isNavigable = C_ContentTracking.IsNavigable(trackableType, 0)
```

### C_ContentTracking.IsTrackable

```lua
isTrackable = C_ContentTracking.IsTrackable(type, id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrackable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrackable = C_ContentTracking.IsTrackable(type, 0)
```

### C_ContentTracking.IsTracking

```lua
isTracking = C_ContentTracking.IsTracking(type, id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTracking` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTracking = C_ContentTracking.IsTracking(type, 0)
```

### C_ContentTracking.StartTracking

```lua
error = C_ContentTracking.StartTracking(type, id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | ContentTrackingError | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local error = C_ContentTracking.StartTracking(type, 0)
```

### C_ContentTracking.StopTracking

```lua
C_ContentTracking.StopTracking(type, id, stopType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |
| `stopType` | ContentTrackingStopType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ContentTracking.StopTracking(type, 0, stopType)
```

### C_ContentTracking.ToggleTracking

```lua
error = C_ContentTracking.ToggleTracking(type, id, stopType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |
| `stopType` | ContentTrackingStopType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | ContentTrackingError | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local error = C_ContentTracking.ToggleTracking(type, 0, stopType)
```

## Events

### CONTENT_TRACKING_IS_ENABLED_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

### CONTENT_TRACKING_LIST_UPDATE

### CONTENT_TRACKING_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |
| `isTracked` | bool | no |  |

### TRACKABLE_INFO_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ContentTrackingType | no |  |
| `id` | number | no |  |

### TRACKING_TARGET_INFO_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetType` | ContentTrackingTargetType | no |  |
| `targetID` | number | no |  |

