# LuaColorCurveObjectAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **0** events · **1** types

## Functions

### LuaColorCurveObjectAPI.AddPoint

Adds a single point to the curve.

```lua
AddPoint(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddPoint(0, y)
```

### LuaColorCurveObjectAPI.ClearPoints

Removes all points from the curve. Evaluating an empty curve always yields a zero value.

```lua
ClearPoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearPoints()
```

### LuaColorCurveObjectAPI.Copy

Returns a new copy of this curve.

```lua
curve = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaColorCurveObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curve = Copy()
```

### LuaColorCurveObjectAPI.Evaluate

Returns a calculated color value from the configured curve points.

```lua
y = Evaluate(x)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `y` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local y = Evaluate(0)
```

### LuaColorCurveObjectAPI.EvaluateUnpacked

Returns an unpacked calculated color value from the configured curve points.

```lua
yR, yG, yB, yA = EvaluateUnpacked(x)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `yR` | number | no |  |
| `yG` | number | no |  |
| `yB` | number | no |  |
| `yA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local yR, yG, yB, yA = EvaluateUnpacked(0)
```

### LuaColorCurveObjectAPI.GetPoint

Returns the vector for an individual point index on the curve.

```lua
point = GetPoint(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | LuaColorCurvePoint | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = GetPoint(1)
```

### LuaColorCurveObjectAPI.GetPointCount

Returns the total number of points on the curve.

```lua
count = GetPointCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | size | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = GetPointCount()
```

### LuaColorCurveObjectAPI.GetPoints

Returns the vectors for all points on the curve.

```lua
point = GetPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | LuaColorCurvePoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = GetPoints()
```

### LuaColorCurveObjectAPI.RemovePoint

Removes a single point from the curve. Raises an error if the supplied point index is out of range.

```lua
RemovePoint(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RemovePoint(1)
```

### LuaColorCurveObjectAPI.SetPoints

Replaces all points on the curve.

```lua
SetPoints(point)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | LuaColorCurvePoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPoints(point)
```

### LuaColorCurveObjectAPI.SetToDefaults

Resets all state on the curve, and clears the secret values flag.

```lua
SetToDefaults()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToDefaults()
```

## Types

### LuaColorCurvePoint (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | colorRGBA | no |  |

