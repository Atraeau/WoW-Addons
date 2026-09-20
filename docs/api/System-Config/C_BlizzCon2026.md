# C_BlizzCon2026

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **2** events · **1** types

## Functions

### C_BlizzCon2026.GetExperience

```lua
experience = C_BlizzCon2026.GetExperience()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `experience` | Bc26Experience | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local experience = C_BlizzCon2026.GetExperience()
```

### C_BlizzCon2026.IsActive

```lua
isActive = C_BlizzCon2026.IsActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = C_BlizzCon2026.IsActive()
```

### C_BlizzCon2026.IsColdSwapFeatureEnabled

```lua
isEnabled = C_BlizzCon2026.IsColdSwapFeatureEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_BlizzCon2026.IsColdSwapFeatureEnabled()
```

### C_BlizzCon2026.SetExperience

```lua
C_BlizzCon2026.SetExperience(experience)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `experience` | Bc26Experience | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BlizzCon2026.SetExperience(Enum.Bc26Experience.Skyborne)
```

## Events

### BC_26_COLD_SWAP_FEATURE_ENABLED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newEnabled` | bool | no |  |
| `oldEnabled` | bool | no |  |

### BC_26_EXPERIENCE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newExperience` | Bc26Experience | no |  |
| `oldExperience` | Bc26Experience | no |  |

## Types

### Bc26Experience (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Skyborne` | Bc26Experience | no |  |
| `Dungeon` | Bc26Experience | no |  |

