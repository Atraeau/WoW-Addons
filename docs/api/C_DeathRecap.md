# C_DeathRecap

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **1** types

## Functions

### C_DeathRecap.GetRecapEvents

```lua
events = C_DeathRecap.GetRecapEvents([recapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | DeathRecapEventInfo[] | no |  |

**Example**

```lua
local events = C_DeathRecap.GetRecapEvents()
```

### C_DeathRecap.GetRecapLink

```lua
link = C_DeathRecap.GetRecapLink([recapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | string | no |  |

**Example**

```lua
local link = C_DeathRecap.GetRecapLink()
```

### C_DeathRecap.GetRecapMaxHealth

Returns the max health for the unit that died in the provided death recap.

```lua
maxHealth = C_DeathRecap.GetRecapMaxHealth([recapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxHealth` | number | no |  |

**Example**

```lua
local maxHealth = C_DeathRecap.GetRecapMaxHealth()
```

### C_DeathRecap.HasRecapEvents

```lua
hasEvents = C_DeathRecap.HasRecapEvents([recapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasEvents` | bool | no |  |

**Example**

```lua
local hasEvents = C_DeathRecap.HasRecapEvents()
```

## Types

### DeathRecapEventInfo (Structure)

