# C_FogOfWar

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **1** events · **1** types

## Functions

### C_FogOfWar.GetFogOfWarForMap

```lua
fogOfWarID = C_FogOfWar.GetFogOfWarForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogOfWarID` | number | yes |  |

**Example**

```lua
local fogOfWarID = C_FogOfWar.GetFogOfWarForMap(0)
```

### C_FogOfWar.GetFogOfWarInfo

```lua
fogOfWarInfo = C_FogOfWar.GetFogOfWarInfo(fogOfWarID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogOfWarID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogOfWarInfo` | FogOfWarInfo | yes |  |

**Example**

```lua
local fogOfWarInfo = C_FogOfWar.GetFogOfWarInfo(0)
```

## Events

### FOG_OF_WAR_UPDATED

## Types

### FogOfWarInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogOfWarID` | number | no |  |
| `backgroundAtlas` | textureAtlas | no |  |
| `maskAtlas` | textureAtlas | no |  |
| `maskScalar` | number | no |  |

