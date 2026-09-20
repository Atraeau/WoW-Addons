# LuaCurveObjectAPI

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **0** events · **0** types

## Functions

### LuaCurveObjectAPI.AddPoint

Adds a single point to the curve.

```lua
AddPoint(pointX, pointY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointX` | number | no |  |
| `pointY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddPoint(0, 0)
```

### LuaCurveObjectAPI.ClearPoints

Removes all points from the curve. Evaluating an empty curve always yields a zero value.

```lua
ClearPoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearPoints()
```

### LuaCurveObjectAPI.Copy

Returns a new copy of this curve.

```lua
curve = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curve = Copy()
```

### LuaCurveObjectAPI.Evaluate

Returns a calculated 'y' value from the configured curve points.

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
| `y` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local y = Evaluate(0)
```

### LuaCurveObjectAPI.GetPoint

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
| `point` | vector2 | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = GetPoint(1)
```

### LuaCurveObjectAPI.GetPointCount

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

### LuaCurveObjectAPI.GetPoints

Returns the vectors for all points on the curve.

```lua
point = GetPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | vector2[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = GetPoints()
```

### LuaCurveObjectAPI.RemovePoint

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

### LuaCurveObjectAPI.SetPoints

Replaces all points on the curve.

```lua
SetPoints(point)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | vector2[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPoints(point)
```

### LuaCurveObjectAPI.SetToDefaults

Resets all state on the curve, and clears the secret values flag.

```lua
SetToDefaults()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToDefaults()
```

