# SimpleScriptRegionResizingAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**13** functions · **0** events · **0** types

## Functions

### SimpleScriptRegionResizingAPI.AdjustPointsOffset

```lua
AdjustPointsOffset(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example**

```lua
AdjustPointsOffset(x, y)
```

### SimpleScriptRegionResizingAPI.ClearAllPoints

Clears all points and immediately invalidates the rect. (Prior to 11.2.0, this would only invalidate rect immediately for AnchoringRestricted regions.)

```lua
ClearAllPoints()
```

**Example**

```lua
ClearAllPoints()
```

### SimpleScriptRegionResizingAPI.ClearPoint

```lua
ClearPoint(point)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |

**Example**

```lua
ClearPoint(point)
```

### SimpleScriptRegionResizingAPI.ClearPointsOffset

```lua
ClearPointsOffset()
```

**Example**

```lua
ClearPointsOffset()
```

### SimpleScriptRegionResizingAPI.GetNumPoints

```lua
numPoints = GetNumPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPoints` | number | no |  |

**Example**

```lua
local numPoints = GetNumPoints()
```

### SimpleScriptRegionResizingAPI.GetPoint

```lua
point, relativeTo, relativePoint, offsetX, offsetY = GetPoint(anchorIndex, resolveCollapsed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchorIndex` | luaIndex | no | (default: 0) |
| `resolveCollapsed` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `relativePoint` | FramePoint | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example**

```lua
local point, relativeTo, relativePoint, offsetX, offsetY = GetPoint(1, false)
```

### SimpleScriptRegionResizingAPI.GetPointByName

```lua
point, relativeTo, relativePoint, offsetX, offsetY = GetPointByName(point, resolveCollapsed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `resolveCollapsed` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `relativePoint` | FramePoint | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example**

```lua
local point, relativeTo, relativePoint, offsetX, offsetY = GetPointByName(point, false)
```

### SimpleScriptRegionResizingAPI.SetAllPoints

```lua
SetAllPoints(relativeTo, doResize)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativeTo` | ScriptRegion | no |  |
| `doResize` | bool | no | (default: True) |

**Example**

```lua
SetAllPoints(relativeTo, false)
```

### SimpleScriptRegionResizingAPI.SetHeight

```lua
SetHeight(height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
SetHeight(height)
```

### SimpleScriptRegionResizingAPI.SetPoint

```lua
SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `relativeTo` | ScriptRegion | no |  |
| `relativePoint` | FramePoint | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example**

```lua
SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
```

### SimpleScriptRegionResizingAPI.SetPointsOffset

```lua
SetPointsOffset(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example**

```lua
SetPointsOffset(x, y)
```

### SimpleScriptRegionResizingAPI.SetSize

```lua
SetSize(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example**

```lua
SetSize(x, y)
```

### SimpleScriptRegionResizingAPI.SetWidth

```lua
SetWidth(width)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
SetWidth(width)
```

