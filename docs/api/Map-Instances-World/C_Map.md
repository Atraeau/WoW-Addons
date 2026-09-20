# C_Map

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**40** functions · **7** events · **6** types

## Functions

### C_Map.CanSetUserWaypointOnMap

```lua
canSet = C_Map.CanSetUserWaypointOnMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSet = C_Map.CanSetUserWaypointOnMap(0)
```

### C_Map.ClearUserWaypoint

```lua
C_Map.ClearUserWaypoint()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Map.ClearUserWaypoint()
```

### C_Map.CloseWorldMapInteraction

```lua
C_Map.CloseWorldMapInteraction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Map.CloseWorldMapInteraction()
```

### C_Map.GetAreaInfo

```lua
name = C_Map.GetAreaInfo(areaID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_Map.GetAreaInfo(0)
```

### C_Map.GetBestMapForUnit

Only works for the player and party members.

```lua
uiMapID = C_Map.GetBestMapForUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

**Example**

```lua
local mapID = C_Map.GetBestMapForUnit("player")
print("Current mapID:", mapID)
```

### C_Map.GetBountySetMaps

```lua
mapIDs = C_Map.GetBountySetMaps(bountySetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bountySetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapIDs = C_Map.GetBountySetMaps(0)
```

### C_Map.GetFallbackWorldMapID

```lua
uiMapID = C_Map.GetFallbackWorldMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapID = C_Map.GetFallbackWorldMapID()
```

### C_Map.GetMapArtBackgroundAtlas

```lua
atlasName = C_Map.GetMapArtBackgroundAtlas(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlasName` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlasName = C_Map.GetMapArtBackgroundAtlas(0)
```

### C_Map.GetMapArtHelpTextPosition

```lua
position = C_Map.GetMapArtHelpTextPosition(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | MapCanvasPosition | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local position = C_Map.GetMapArtHelpTextPosition(0)
```

### C_Map.GetMapArtID

```lua
uiMapArtID = C_Map.GetMapArtID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapArtID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapArtID = C_Map.GetMapArtID(0)
```

### C_Map.GetMapArtLayers

```lua
layerInfo = C_Map.GetMapArtLayers(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layerInfo` | UiMapLayerInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layerInfo = C_Map.GetMapArtLayers(0)
```

### C_Map.GetMapArtLayerTextures

```lua
textures = C_Map.GetMapArtLayerTextures(uiMapID, layerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `layerIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textures` | fileID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textures = C_Map.GetMapArtLayerTextures(0, 1)
```

### C_Map.GetMapArtZoneTextPosition

```lua
position = C_Map.GetMapArtZoneTextPosition(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | MapCanvasPosition | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local position = C_Map.GetMapArtZoneTextPosition(0)
```

### C_Map.GetMapBannersForMap

```lua
mapBanners = C_Map.GetMapBannersForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapBanners` | MapBannerInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapBanners = C_Map.GetMapBannersForMap(0)
```

### C_Map.GetMapChildrenInfo

```lua
info = C_Map.GetMapChildrenInfo(uiMapID, [mapType], [allDescendants])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `mapType` | UIMapType | yes |  |
| `allDescendants` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UiMapDetails[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Map.GetMapChildrenInfo(0)
```

### C_Map.GetMapDisplayInfo

```lua
hideIcons = C_Map.GetMapDisplayInfo(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hideIcons` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hideIcons = C_Map.GetMapDisplayInfo(0)
```

### C_Map.GetMapGroupID

```lua
uiMapGroupID = C_Map.GetMapGroupID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapGroupID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapGroupID = C_Map.GetMapGroupID(0)
```

### C_Map.GetMapGroupMembersInfo

```lua
info = C_Map.GetMapGroupMembersInfo(uiMapGroupID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapGroupID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UiMapGroupMemberInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Map.GetMapGroupMembersInfo(0)
```

### C_Map.GetMapHighlightInfoAtPosition

```lua
fileDataID, atlasID, texturePercentageX, texturePercentageY, textureX, textureY, scrollChildX, scrollChildY = C_Map.GetMapHighlightInfoAtPosition(uiMapID, x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `x` | number | no |  |
| `y` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileDataID` | fileID | no |  |
| `atlasID` | textureAtlas | no |  |
| `texturePercentageX` | number | no |  |
| `texturePercentageY` | number | no |  |
| `textureX` | number | no |  |
| `textureY` | number | no |  |
| `scrollChildX` | number | no |  |
| `scrollChildY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fileDataID, atlasID, texturePercentageX, texturePercentageY, textureX, textureY, scrollChildX, scrollChildY = C_Map.GetMapHighlightInfoAtPosition(0, 0, 0)
```

### C_Map.GetMapHighlightPulseInfo

```lua
fileDataID, atlasID, texturePercentageX, texturePercentageY, textureX, textureY, scrollChildX, scrollChildY = C_Map.GetMapHighlightPulseInfo(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileDataID` | fileID | no |  |
| `atlasID` | textureAtlas | no |  |
| `texturePercentageX` | number | no |  |
| `texturePercentageY` | number | no |  |
| `textureX` | number | no |  |
| `textureY` | number | no |  |
| `scrollChildX` | number | no |  |
| `scrollChildY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fileDataID, atlasID, texturePercentageX, texturePercentageY, textureX, textureY, scrollChildX, scrollChildY = C_Map.GetMapHighlightPulseInfo(0)
```

### C_Map.GetMapInfo

```lua
info = C_Map.GetMapInfo(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UiMapDetails | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Map.GetMapInfo(0)
```

### C_Map.GetMapInfoAtPosition

```lua
info = C_Map.GetMapInfoAtPosition(uiMapID, x, y, [ignoreZoneMapPositionData])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `x` | number | no |  |
| `y` | number | no |  |
| `ignoreZoneMapPositionData` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UiMapDetails | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Map.GetMapInfoAtPosition(0, 0, 0)
```

### C_Map.GetMapLevels

```lua
playerMinLevel, playerMaxLevel, petMinLevel, petMaxLevel = C_Map.GetMapLevels(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerMinLevel` | number | no |  |
| `playerMaxLevel` | number | no |  |
| `petMinLevel` | number | no | (default: 0) |
| `petMaxLevel` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local playerMinLevel, playerMaxLevel, petMinLevel, petMaxLevel = C_Map.GetMapLevels(0)
```

### C_Map.GetMapLinksForMap

```lua
mapLinks = C_Map.GetMapLinksForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapLinks` | MapLinkInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapLinks = C_Map.GetMapLinksForMap(0)
```

### C_Map.GetMapPosFromWorldPos

```lua
uiMapID, mapPosition = C_Map.GetMapPosFromWorldPos(continentID, worldPosition, [overrideUiMapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `continentID` | number | no |  |
| `worldPosition` | vector2 | no |  |
| `overrideUiMapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `mapPosition` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapID, mapPosition = C_Map.GetMapPosFromWorldPos(0, worldPosition)
```

### C_Map.GetMapRectOnMap

```lua
minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(uiMapID, topUiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `topUiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minX` | number | no |  |
| `maxX` | number | no |  |
| `minY` | number | no |  |
| `maxY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(0, 0)
```

### C_Map.GetMapWorldSize

Returns the size in yards of the area represented by the map.

```lua
width, height = C_Map.GetMapWorldSize(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | number | no |  |
| `height` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local width, height = C_Map.GetMapWorldSize(0)
```

### C_Map.GetPlayerMapPosition

Only works for the player and party members.

```lua
position = C_Map.GetPlayerMapPosition(uiMapID, unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | vector2 | yes |  |

**Example**

```lua
local mapID = C_Map.GetBestMapForUnit("player")
local pos = C_Map.GetPlayerMapPosition(mapID, "player")
if pos then
    local x, y = pos:GetXY()
    print(("%.1f, %.1f"):format(x * 100, y * 100))
end
```

### C_Map.GetUserWaypoint

```lua
point = C_Map.GetUserWaypoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | UiMapPoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = C_Map.GetUserWaypoint()
```

### C_Map.GetUserWaypointFromHyperlink

```lua
point = C_Map.GetUserWaypointFromHyperlink(hyperlink)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | UiMapPoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = C_Map.GetUserWaypointFromHyperlink("")
```

### C_Map.GetUserWaypointHyperlink

```lua
hyperlink = C_Map.GetUserWaypointHyperlink()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hyperlink = C_Map.GetUserWaypointHyperlink()
```

### C_Map.GetUserWaypointPositionForMap

```lua
mapPosition = C_Map.GetUserWaypointPositionForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapPosition` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapPosition = C_Map.GetUserWaypointPositionForMap(0)
```

### C_Map.GetWorldPosFromMapPos

```lua
continentID, worldPosition = C_Map.GetWorldPosFromMapPos(uiMapID, mapPosition)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `mapPosition` | vector2 | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `continentID` | number | no |  |
| `worldPosition` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local continentID, worldPosition = C_Map.GetWorldPosFromMapPos(0, mapPosition)
```

### C_Map.HasUserWaypoint

```lua
hasUserWaypoint = C_Map.HasUserWaypoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUserWaypoint` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasUserWaypoint = C_Map.HasUserWaypoint()
```

### C_Map.IsCityMap

```lua
isCityMap = C_Map.IsCityMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCityMap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCityMap = C_Map.IsCityMap(0)
```

### C_Map.IsMapValidForNavBarDropdown

```lua
isValid = C_Map.IsMapValidForNavBarDropdown(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_Map.IsMapValidForNavBarDropdown(0)
```

### C_Map.MapHasArt

```lua
hasArt = C_Map.MapHasArt(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasArt` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasArt = C_Map.MapHasArt(0)
```

### C_Map.OpenWorldMap

```lua
C_Map.OpenWorldMap([uiMapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Map.OpenWorldMap()
```

### C_Map.RequestPreloadMap

```lua
C_Map.RequestPreloadMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Map.RequestPreloadMap(0)
```

### C_Map.SetUserWaypoint

```lua
wasSet = C_Map.SetUserWaypoint(point)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | UiMapPoint | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasSet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wasSet = C_Map.SetUserWaypoint(point)
```

## Events

### NEW_WMO_CHUNK

### PLAYER_MAP_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldMapID` | number | no |  |
| `newMapID` | number | no |  |

### USER_WAYPOINT_UPDATED

### WORLD_MAP_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

### ZONE_CHANGED

### ZONE_CHANGED_INDOORS

### ZONE_CHANGED_NEW_AREA

## Types

### MapBannerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `name` | cstring | no |  |
| `atlasName` | string | no |  |
| `uiTextureKit` | textureKit | yes |  |

### MapLinkInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `atlasName` | string | no |  |
| `linkedUiMapID` | number | no |  |

### UiMapDetails (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `name` | cstring | no |  |
| `mapType` | UIMapType | no |  |
| `parentMapID` | number | no |  |
| `flags` | UIMapFlag | no |  |

### UiMapGroupMemberInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `relativeHeightIndex` | number | no |  |
| `name` | cstring | no |  |

### UiMapHighlightInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileDataID` | fileID | no |  |
| `atlasID` | textureAtlas | no |  |
| `texturePercentageX` | number | no |  |
| `texturePercentageY` | number | no |  |
| `textureX` | number | no |  |
| `textureY` | number | no |  |
| `scrollChildX` | number | no |  |
| `scrollChildY` | number | no |  |

### UiMapLayerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layerWidth` | number | no |  |
| `layerHeight` | number | no |  |
| `tileWidth` | number | no |  |
| `tileHeight` | number | no |  |
| `minScale` | number | no |  |
| `maxScale` | number | no |  |
| `additionalZoomSteps` | number | no |  |

