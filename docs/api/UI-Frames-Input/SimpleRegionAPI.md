# SimpleRegionAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**16** functions · **0** events · **0** types

## Functions

### SimpleRegionAPI.GetAlpha

```lua
alpha = GetAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local alpha = GetAlpha()
```

### SimpleRegionAPI.GetDrawLayer

```lua
layer, sublayer = GetDrawLayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `sublayer` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layer, sublayer = GetDrawLayer()
```

### SimpleRegionAPI.GetEffectiveScale

```lua
effectiveScale = GetEffectiveScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveScale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveScale = GetEffectiveScale()
```

### SimpleRegionAPI.GetScale

```lua
scale = GetScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scale = GetScale()
```

### SimpleRegionAPI.GetVertexColor

```lua
colorR, colorG, colorB, colorA = GetVertexColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetVertexColor()
```

### SimpleRegionAPI.IsIgnoringParentAlpha

```lua
isIgnoring = IsIgnoringParentAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnoring` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnoring = IsIgnoringParentAlpha()
```

### SimpleRegionAPI.IsIgnoringParentScale

```lua
isIgnoring = IsIgnoringParentScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnoring` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnoring = IsIgnoringParentScale()
```

### SimpleRegionAPI.IsObjectLoaded

```lua
isLoaded = IsObjectLoaded()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoaded` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLoaded = IsObjectLoaded()
```

### SimpleRegionAPI.SetAlpha

```lua
SetAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlpha(alpha)
```

### SimpleRegionAPI.SetAlphaFromBoolean

```lua
SetAlphaFromBoolean(value, alphaIfTrue, alphaIfFalse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | no |  |
| `alphaIfTrue` | SingleColorValue | no | (default: 255) |
| `alphaIfFalse` | SingleColorValue | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlphaFromBoolean(false, alphaIfTrue, alphaIfFalse)
```

### SimpleRegionAPI.SetDrawLayer

```lua
SetDrawLayer(layer, sublevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `sublevel` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawLayer(layer, 0)
```

### SimpleRegionAPI.SetIgnoreParentAlpha

```lua
SetIgnoreParentAlpha(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIgnoreParentAlpha(false)
```

### SimpleRegionAPI.SetIgnoreParentScale

```lua
SetIgnoreParentScale(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIgnoreParentScale(false)
```

### SimpleRegionAPI.SetScale

```lua
SetScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetScale(0)
```

### SimpleRegionAPI.SetVertexColor

```lua
SetVertexColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetVertexColor(0, 0, 0)
```

### SimpleRegionAPI.SetVertexColorFromBoolean

```lua
SetVertexColorFromBoolean(value, colorIfTrue, colorIfFalse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | no |  |
| `colorIfTrue` | colorRGBA | no |  |
| `colorIfFalse` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetVertexColorFromBoolean(false, colorIfTrue, colorIfFalse)
```

