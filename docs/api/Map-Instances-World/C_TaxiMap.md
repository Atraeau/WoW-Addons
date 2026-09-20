# C_TaxiMap

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**3** functions · **3** events · **4** types

## Functions

### C_TaxiMap.GetAllTaxiNodes

Returns information on taxi nodes at the current flight master.

```lua
taxiNodes = C_TaxiMap.GetAllTaxiNodes(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `taxiNodes` | TaxiNodeInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local taxiNodes = C_TaxiMap.GetAllTaxiNodes(0)
```

### C_TaxiMap.GetTaxiNodesForMap

Returns information on taxi nodes for a given map, without considering the current flight master.

```lua
mapTaxiNodes = C_TaxiMap.GetTaxiNodesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapTaxiNodes` | MapTaxiNodeInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapTaxiNodes = C_TaxiMap.GetTaxiNodesForMap(0)
```

### C_TaxiMap.ShouldMapShowTaxiNodes

```lua
shouldShowNodes = C_TaxiMap.ShouldMapShowTaxiNodes(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShowNodes` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShowNodes = C_TaxiMap.ShouldMapShowTaxiNodes(0)
```

## Events

### TAXIMAP_CLOSED

### TAXIMAP_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `system` | number | no |  |

### TAXI_NODE_STATUS_CHANGED

## Types

### FlightPathFaction (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Neutral` | FlightPathFaction | no |  |
| `Horde` | FlightPathFaction | no |  |
| `Alliance` | FlightPathFaction | no |  |

### FlightPathState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Current` | FlightPathState | no |  |
| `Reachable` | FlightPathState | no |  |
| `Unreachable` | FlightPathState | no |  |

### MapTaxiNodeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `atlasName` | cstring | no |  |
| `faction` | FlightPathFaction | no |  |
| `textureKit` | textureKit | no |  |
| `isUndiscovered` | bool | no |  |

### TaxiNodeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `state` | FlightPathState | no |  |
| `slotIndex` | luaIndex | no |  |
| `textureKit` | textureKit | no |  |
| `useSpecialIcon` | bool | no |  |
| `specialIconCostString` | string | yes |  |
| `isMapLayerTransition` | bool | no |  |

