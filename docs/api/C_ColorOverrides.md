# C_ColorOverrides

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **2** events · **1** types

## Functions

### C_ColorOverrides.ClearColorOverrides

```lua
C_ColorOverrides.ClearColorOverrides()
```

**Example**

```lua
C_ColorOverrides.ClearColorOverrides()
```

### C_ColorOverrides.GetColorForQuality

```lua
color = C_ColorOverrides.GetColorForQuality(quality)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | ItemQuality | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |

**Example**

```lua
local color = C_ColorOverrides.GetColorForQuality(quality)
```

### C_ColorOverrides.GetColorOverrideInfo

```lua
overrideInfo = C_ColorOverrides.GetColorOverrideInfo(overrideType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideType` | ColorOverride | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideInfo` | ColorOverrideInfo | yes |  |

**Example**

```lua
local overrideInfo = C_ColorOverrides.GetColorOverrideInfo(overrideType)
```

### C_ColorOverrides.GetDefaultColorForQuality

```lua
color = C_ColorOverrides.GetDefaultColorForQuality(quality)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | ItemQuality | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |

**Example**

```lua
local color = C_ColorOverrides.GetDefaultColorForQuality(quality)
```

### C_ColorOverrides.RemoveColorOverride

```lua
C_ColorOverrides.RemoveColorOverride(overrideType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideType` | ColorOverride | no |  |

**Example**

```lua
C_ColorOverrides.RemoveColorOverride(overrideType)
```

### C_ColorOverrides.SetColorOverride

```lua
C_ColorOverrides.SetColorOverride(overrideType, color)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideType` | ColorOverride | no |  |
| `color` | colorRGBA | no |  |

**Example**

```lua
C_ColorOverrides.SetColorOverride(overrideType, color)
```

## Events

### COLOR_OVERRIDES_RESET

### COLOR_OVERRIDE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideType` | ColorOverride | no |  |

## Types

### ColorOverrideInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideType` | ColorOverride | no |  |
| `overrideColor` | colorRGB | no |  |
| `overrideColorString` | string | no |  |

