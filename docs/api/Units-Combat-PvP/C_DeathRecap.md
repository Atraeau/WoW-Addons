# C_DeathRecap

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasEvents = C_DeathRecap.HasRecapEvents()
```

## Types

### DeathRecapEventInfo (Structure)

