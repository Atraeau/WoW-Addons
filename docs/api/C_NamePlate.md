# C_NamePlate

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **0** types

## Functions

### C_NamePlate.GetNamePlateForUnit

```lua
nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, includeForbidden)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenNamePlate | no |  |
| `includeForbidden` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nameplate` | NamePlateFrame | no |  |

**Example**

```lua
local nameplate = C_NamePlate.GetNamePlateForUnit("player", false)
```

### C_NamePlate.GetNamePlates

```lua
nameplates = C_NamePlate.GetNamePlates()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nameplates` | NamePlateFrame[] | no |  |

**Example**

```lua
local nameplates = C_NamePlate.GetNamePlates()
```

### C_NamePlate.GetNamePlateSize

```lua
width, height = C_NamePlate.GetNamePlateSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example**

```lua
local width, height = C_NamePlate.GetNamePlateSize()
```

### C_NamePlate.SetNamePlateSize

```lua
C_NamePlate.SetNamePlateSize(width, height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example**

```lua
C_NamePlate.SetNamePlateSize(width, height)
```

