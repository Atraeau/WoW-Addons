# SimpleLineAPI

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**9** functions · **0** events · **0** types

## Functions

### SimpleLineAPI.ClearAllPoints

```lua
ClearAllPoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearAllPoints()
```

### SimpleLineAPI.GetEndPoint

```lua
relativePoint, relativeTo, offsetX, offsetY = GetEndPoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativePoint` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local relativePoint, relativeTo, offsetX, offsetY = GetEndPoint()
```

### SimpleLineAPI.GetHitRectThickness

```lua
thickness = GetHitRectThickness()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local thickness = GetHitRectThickness()
```

### SimpleLineAPI.GetStartPoint

```lua
relativePoint, relativeTo, offsetX, offsetY = GetStartPoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativePoint` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local relativePoint, relativeTo, offsetX, offsetY = GetStartPoint()
```

### SimpleLineAPI.GetThickness

```lua
thickness = GetThickness()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local thickness = GetThickness()
```

### SimpleLineAPI.SetEndPoint

```lua
SetEndPoint(relativePoint, relativeTo, offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativePoint` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `offsetX` | uiUnit | no | (default: 0) |
| `offsetY` | uiUnit | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEndPoint(relativePoint, relativeTo, 1, 1)
```

### SimpleLineAPI.SetHitRectThickness

```lua
SetHitRectThickness(thickness)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHitRectThickness(thickness)
```

### SimpleLineAPI.SetStartPoint

```lua
SetStartPoint(relativePoint, relativeTo, offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativePoint` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `offsetX` | uiUnit | no | (default: 0) |
| `offsetY` | uiUnit | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStartPoint(relativePoint, relativeTo, 1, 1)
```

### SimpleLineAPI.SetThickness

```lua
SetThickness(thickness)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetThickness(thickness)
```

