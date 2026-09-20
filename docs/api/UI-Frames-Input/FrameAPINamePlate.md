# FrameAPINamePlate

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**6** functions · **0** events · **0** types

## Functions

### FrameAPINamePlate.CanChangeHitTestPoints

Returns true if this nameplate permits changes to its hit-test points. Updates are normally blocked for tainted code during combat, except on the tick a unit is first assigned or when untainted code updates hit-test points on the same tick.

```lua
canChangeHitTestPoints = CanChangeHitTestPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChangeHitTestPoints` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canChangeHitTestPoints = CanChangeHitTestPoints()
```

### FrameAPINamePlate.ClearAllHitTestPoints

Clears the anchor points that determine where the mouse interacts with the nameplate.

```lua
ClearAllHitTestPoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearAllHitTestPoints()
```

### FrameAPINamePlate.GetHitTestPoints

Returns the anchor points that determine where the mouse interacts with the nameplate.

```lua
anchors = GetHitTestPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchors` | AnchorBinding[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local anchors = GetHitTestPoints()
```

### FrameAPINamePlate.SetAllHitTestPoints

Sets the anchor points that determine where the mouse interacts with the nameplate to fully encompass the target region.

```lua
SetAllHitTestPoints(relativeTo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relativeTo` | ScriptRegion | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAllHitTestPoints(relativeTo)
```

### FrameAPINamePlate.SetHitTestPoints

Sets the anchor points that determine where the mouse interacts with the nameplate.

```lua
SetHitTestPoints(anchors)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchors` | AnchorBinding[] | no | List of anchor points to use for hit testing. All existing points will be cleared. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHitTestPoints(anchors)
```

### FrameAPINamePlate.SetStackingBoundsFrame

```lua
SetStackingBoundsFrame(frame)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frame` | SimpleFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStackingBoundsFrame(frame)
```

