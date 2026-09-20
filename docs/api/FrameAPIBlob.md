# FrameAPIBlob

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**14** functions · **0** events · **0** types

## Functions

### FrameAPIBlob.DrawAll

```lua
DrawAll()
```

**Example**

```lua
DrawAll()
```

### FrameAPIBlob.DrawBlob

```lua
DrawBlob(questID, draw)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `draw` | bool | no | (default: False) |

**Example**

```lua
DrawBlob(0, false)
```

### FrameAPIBlob.DrawNone

```lua
DrawNone()
```

**Example**

```lua
DrawNone()
```

### FrameAPIBlob.EnableMerging

```lua
EnableMerging(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
EnableMerging(false)
```

### FrameAPIBlob.EnableSmoothing

```lua
EnableSmoothing(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
EnableSmoothing(false)
```

### FrameAPIBlob.GetMapID

```lua
uiMapID = GetMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
local uiMapID = GetMapID()
```

### FrameAPIBlob.SetBorderAlpha

```lua
SetBorderAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetBorderAlpha(0)
```

### FrameAPIBlob.SetBorderScalar

```lua
SetBorderScalar(scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
SetBorderScalar(0)
```

### FrameAPIBlob.SetBorderTexture

```lua
SetBorderTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Example**

```lua
SetBorderTexture(asset)
```

### FrameAPIBlob.SetFillAlpha

```lua
SetFillAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetFillAlpha(0)
```

### FrameAPIBlob.SetFillTexture

```lua
SetFillTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Example**

```lua
SetFillTexture(asset)
```

### FrameAPIBlob.SetMapID

```lua
SetMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
SetMapID(0)
```

### FrameAPIBlob.SetMergeThreshold

```lua
SetMergeThreshold(threshold)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `threshold` | number | no |  |

**Example**

```lua
SetMergeThreshold(0)
```

### FrameAPIBlob.SetNumSplinePoints

```lua
SetNumSplinePoints(numSplinePoints)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSplinePoints` | number | no |  |

**Example**

```lua
SetNumSplinePoints(0)
```

