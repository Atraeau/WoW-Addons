# C_CurveUtil

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### C_CurveUtil.CreateColorCurve

Returns a new color curve object with no assigned points.

```lua
curve = C_CurveUtil.CreateColorCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaColorCurveObject | no |  |

**Example**

```lua
local curve = C_CurveUtil.CreateColorCurve()
```

### C_CurveUtil.CreateCurve

Returns a new curve object with no assigned points.

```lua
curve = C_CurveUtil.CreateCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | no |  |

**Example**

```lua
local curve = C_CurveUtil.CreateCurve()
```

### C_CurveUtil.EvaluateColorFromBoolean

Evaluates a potentially-secret boolean value and returns a color.

```lua
value = C_CurveUtil.EvaluateColorFromBoolean(boolean, valueIfTrue, valueIfFalse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `boolean` | bool | no |  |
| `valueIfTrue` | colorRGBA | no |  |
| `valueIfFalse` | colorRGBA | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | colorRGBA | no |  |

**Example**

```lua
local value = C_CurveUtil.EvaluateColorFromBoolean(false, valueIfTrue, valueIfFalse)
```

### C_CurveUtil.EvaluateColorValueFromBoolean

Evaluates a potentially-secret boolean value and returns a single color component (eg. alpha).

```lua
value = C_CurveUtil.EvaluateColorValueFromBoolean(boolean, valueIfTrue, valueIfFalse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `boolean` | bool | no |  |
| `valueIfTrue` | SingleColorValue | no |  |
| `valueIfFalse` | SingleColorValue | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | SingleColorValue | no |  |

**Example**

```lua
local value = C_CurveUtil.EvaluateColorValueFromBoolean(false, valueIfTrue, valueIfFalse)
```

### C_CurveUtil.EvaluateGameCurve

```lua
y = C_CurveUtil.EvaluateGameCurve(curveID, x)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curveID` | number | no |  |
| `x` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `y` | number | no |  |

**Example**

```lua
local y = C_CurveUtil.EvaluateGameCurve(0, 0)
```

