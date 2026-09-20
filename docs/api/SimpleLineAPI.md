# SimpleLineAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **0** events · **0** types

## Functions

### SimpleLineAPI.ClearAllPoints

```lua
ClearAllPoints()
```

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
SetEndPoint(relativePoint, relativeTo, offsetX, offsetY)
```

### SimpleLineAPI.SetHitRectThickness

```lua
SetHitRectThickness(thickness)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example**

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

**Example**

```lua
SetStartPoint(relativePoint, relativeTo, offsetX, offsetY)
```

### SimpleLineAPI.SetThickness

```lua
SetThickness(thickness)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thickness` | uiUnit | no |  |

**Example**

```lua
SetThickness(thickness)
```

