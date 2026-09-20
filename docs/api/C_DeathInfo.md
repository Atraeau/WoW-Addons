# C_DeathInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **14** events · **3** types

## Functions

### C_DeathInfo.GetCorpseMapPosition

```lua
position = C_DeathInfo.GetCorpseMapPosition(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | vector2 | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local position = C_DeathInfo.GetCorpseMapPosition(0)
```

### C_DeathInfo.GetDeathReleasePosition

```lua
position = C_DeathInfo.GetDeathReleasePosition(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `position` | vector2 | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local position = C_DeathInfo.GetDeathReleasePosition(0)
```

### C_DeathInfo.GetGraveyardsForMap

```lua
graveyards = C_DeathInfo.GetGraveyardsForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `graveyards` | GraveyardMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local graveyards = C_DeathInfo.GetGraveyardsForMap(0)
```

### C_DeathInfo.GetSelfResurrectOptions

```lua
options = C_DeathInfo.GetSelfResurrectOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | SelfResurrectOption[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local options = C_DeathInfo.GetSelfResurrectOptions()
```

### C_DeathInfo.UseSelfResurrectOption

```lua
C_DeathInfo.UseSelfResurrectOption(optionType, id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionType` | SelfResurrectOptionType | no |  |
| `id` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_DeathInfo.UseSelfResurrectOption(Enum.SelfResurrectOptionType.Spell, 0)
```

## Events

### AREA_SPIRIT_HEALER_IN_RANGE

### AREA_SPIRIT_HEALER_OUT_OF_RANGE

### CEMETERY_PREFERENCE_UPDATED

### CONFIRM_XP_LOSS

### CORPSE_IN_INSTANCE

### CORPSE_IN_RANGE

### CORPSE_OUT_OF_RANGE

### PLAYER_ALIVE

### PLAYER_DEAD

### PLAYER_SKINNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFreeRepop` | number | no |  |

### PLAYER_UNGHOST

### REQUEST_CEMETERY_LIST_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGossipTriggered` | bool | no |  |

### RESURRECT_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviter` | cstring | no |  |

### SELF_RES_SPELL_CHANGED

## Types

### GraveyardMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `textureIndex` | number | no |  |
| `graveyardID` | number | no |  |
| `isGraveyardSelectable` | bool | no |  |

### SelfResurrectOption (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `optionType` | SelfResurrectOptionType | no |  |
| `id` | number | no |  |
| `canUse` | bool | no |  |
| `isLimited` | bool | no |  |
| `priority` | number | no |  |

### SelfResurrectOptionType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Spell` | SelfResurrectOptionType | no |  |
| `Item` | SelfResurrectOptionType | no |  |

