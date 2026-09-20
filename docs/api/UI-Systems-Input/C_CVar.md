# C_CVar

[← API index](../README.md) · group: [UI Systems & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**12** functions · **0** events · **1** types

## Functions

### C_CVar.AreCVarsLoaded

```lua
loaded = C_CVar.AreCVarsLoaded()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loaded` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loaded = C_CVar.AreCVarsLoaded()
```

### C_CVar.GetCVar

```lua
value = C_CVar.GetCVar(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_CVar.GetCVar("")
```

### C_CVar.GetCVarBitfield

```lua
value = C_CVar.GetCVarBitfield(name, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_CVar.GetCVarBitfield("", 1)
```

### C_CVar.GetCVarBool

```lua
value = C_CVar.GetCVarBool(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_CVar.GetCVarBool("")
```

### C_CVar.GetCVarDefault

```lua
defaultValue = C_CVar.GetCVarDefault(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultValue` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local defaultValue = C_CVar.GetCVarDefault("")
```

### C_CVar.GetCVarInfo

```lua
value, defaultValue, isStoredServerAccount, isStoredServerCharacter, isLockedFromUser, isSecure, isReadOnly = C_CVar.GetCVarInfo(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | cstring | no |  |
| `defaultValue` | cstring | no |  |
| `isStoredServerAccount` | bool | no |  |
| `isStoredServerCharacter` | bool | no |  |
| `isLockedFromUser` | bool | no |  |
| `isSecure` | bool | no |  |
| `isReadOnly` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value, defaultValue, isStoredServerAccount, isStoredServerCharacter, isLockedFromUser, isSecure, isReadOnly = C_CVar.GetCVarInfo("")
```

### C_CVar.RegisterCVar

```lua
C_CVar.RegisterCVar(name, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `value` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CVar.RegisterCVar("")
```

### C_CVar.RemoveTempCVar

```lua
C_CVar.RemoveTempCVar(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CVar.RemoveTempCVar("")
```

### C_CVar.ResetTestCVars

```lua
C_CVar.ResetTestCVars()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CVar.ResetTestCVars()
```

### C_CVar.SetCVar

```lua
success = C_CVar.SetCVar(name, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `value` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CVar.SetCVar("")
```

### C_CVar.SetCVarBitfield

```lua
success = C_CVar.SetCVarBitfield(name, index, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `index` | luaIndex | no |  |
| `value` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CVar.SetCVarBitfield("", 1, false)
```

### C_CVar.SetTempCVar

```lua
C_CVar.SetTempCVar(name, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `value` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CVar.SetTempCVar("")
```

## Types

### CVarInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | cstring | no |  |
| `defaultValue` | cstring | no |  |
| `isStoredServerAccount` | bool | no |  |
| `isStoredServerCharacter` | bool | no |  |
| `isLockedFromUser` | bool | no |  |
| `isSecure` | bool | no |  |
| `isReadOnly` | bool | no |  |

