# SimpleAnimRotationAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **0** events · **0** types

## Functions

### SimpleAnimRotationAPI.GetDegrees

```lua
angle = GetDegrees()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
local angle = GetDegrees()
```

### SimpleAnimRotationAPI.GetOrigin

```lua
point, originX, originY = GetOrigin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `originX` | number | no |  |
| `originY` | number | no |  |

**Example**

```lua
local point, originX, originY = GetOrigin()
```

### SimpleAnimRotationAPI.GetRadians

```lua
angle = GetRadians()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
local angle = GetRadians()
```

### SimpleAnimRotationAPI.SetDegrees

```lua
SetDegrees(angle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
SetDegrees(0)
```

### SimpleAnimRotationAPI.SetOrigin

```lua
SetOrigin(point, originX, originY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `originX` | number | no |  |
| `originY` | number | no |  |

**Example**

```lua
SetOrigin(point, 0, 0)
```

### SimpleAnimRotationAPI.SetRadians

```lua
SetRadians(angle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
SetRadians(0)
```

