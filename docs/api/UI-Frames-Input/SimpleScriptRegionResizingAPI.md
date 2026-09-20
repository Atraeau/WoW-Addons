# SimpleScriptRegionResizingAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
AdjustPointsOffset(x, y)
```

### SimpleScriptRegionResizingAPI.ClearAllPoints

Clears all points and immediately invalidates the rect. (Prior to 11.2.0, this would only invalidate rect immediately for AnchoringRestricted regions.)

```lua
ClearAllPoints()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearPoint(point)
```

### SimpleScriptRegionResizingAPI.ClearPointsOffset

```lua
ClearPointsOffset()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPoint(point, relativeTo, relativePoint, 1, 1)
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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetWidth(width)
```

