# C_AreaPoiInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **1** events · **1** types

## Functions

### C_AreaPoiInfo.GetAreaPOIForMap

```lua
areaPoiIDs = C_AreaPoiInfo.GetAreaPOIForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiIDs` | number[] | no |  |

**Example**

```lua
local areaPoiIDs = C_AreaPoiInfo.GetAreaPOIForMap(0)
```

### C_AreaPoiInfo.GetAreaPOIInfo

```lua
poiInfo = C_AreaPoiInfo.GetAreaPOIInfo([uiMapID], areaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |
| `areaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `poiInfo` | AreaPOIInfo | no |  |

**Example**

```lua
local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(0)
```

### C_AreaPoiInfo.GetAreaPOISecondsLeft

Returns the number of seconds until the POI expires.

```lua
secondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secondsLeft` | number | no |  |

**Example**

```lua
local secondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft(0)
```

### C_AreaPoiInfo.GetDelvesForMap

Returns all area POIInfos flagged as delves for the given map.

```lua
areaPoiIDs = C_AreaPoiInfo.GetDelvesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiIDs` | number[] | no |  |

**Example**

```lua
local areaPoiIDs = C_AreaPoiInfo.GetDelvesForMap(0)
```

### C_AreaPoiInfo.GetDragonridingRacesForMap

Returns all area POIInfos flagged as dragonriding races for the given map.

```lua
areaPoiIDs = C_AreaPoiInfo.GetDragonridingRacesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiIDs` | number[] | no |  |

**Example**

```lua
local areaPoiIDs = C_AreaPoiInfo.GetDragonridingRacesForMap(0)
```

### C_AreaPoiInfo.GetEventsForMap

Returns all area POIInfos flagged as events for the given map.

```lua
areaPoiIDs = C_AreaPoiInfo.GetEventsForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiIDs` | number[] | no |  |

**Example**

```lua
local areaPoiIDs = C_AreaPoiInfo.GetEventsForMap(0)
```

### C_AreaPoiInfo.GetQuestHubsForMap

Returns all area POIInfos flagged as quest hubs for the given map.

```lua
areaPoiIDs = C_AreaPoiInfo.GetQuestHubsForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiIDs` | number[] | no |  |

**Example**

```lua
local areaPoiIDs = C_AreaPoiInfo.GetQuestHubsForMap(0)
```

### C_AreaPoiInfo.IsAreaPOITimed

This statically determines if the POI is timed, GetAreaPOITimeLeft retrieves the value from the server and may return nothing for long intervals

```lua
isTimed, hideTimerInTooltip = C_AreaPoiInfo.IsAreaPOITimed(areaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTimed` | bool | no |  |
| `hideTimerInTooltip` | bool | yes |  |

**Example**

```lua
local isTimed, hideTimerInTooltip = C_AreaPoiInfo.IsAreaPOITimed(0)
```

## Events

### AREA_POIS_UPDATED

## Types

### AreaPOIInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `description` | cstring | yes |  |
| `linkedUiMapID` | number | yes |  |
| `textureIndex` | number | yes |  |
| `tooltipWidgetSet` | number | yes |  |
| `iconWidgetSet` | number | yes |  |
| `atlasName` | string | yes |  |
| `uiTextureKit` | textureKit | yes |  |
| `shouldGlow` | bool | no |  |
| `factionID` | number | yes |  |
| `isPrimaryMapForPOI` | bool | no |  |
| `isAlwaysOnFlightmap` | bool | no |  |
| `addPaddingAboveTooltipWidgets` | bool | yes |  |
| `highlightWorldQuestsOnHover` | bool | no |  |
| `highlightVignettesOnHover` | bool | no |  |
| `isCurrentEvent` | bool | no |  |
| `isSuppressible` | bool | no |  |
| `isLocked` | bool | no | (default: False) |

