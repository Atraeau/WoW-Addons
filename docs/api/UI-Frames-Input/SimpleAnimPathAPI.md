# SimpleAnimPathAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **0** events · **0** types

## Functions

### SimpleAnimPathAPI.CreateControlPoint

```lua
point = CreateControlPoint([name], [templateName], [order])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `templateName` | cstring | yes |  |
| `order` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | SimpleControlPoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point = CreateControlPoint()
```

### SimpleAnimPathAPI.GetControlPoints

```lua
points = GetControlPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `points` | SimpleControlPoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local points = GetControlPoints()
```

### SimpleAnimPathAPI.GetCurveType

```lua
curveType = GetCurveType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curveType` | CurveType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curveType = GetCurveType()
```

### SimpleAnimPathAPI.GetMaxControlPointOrder

```lua
maxOrder = GetMaxControlPointOrder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxOrder` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxOrder = GetMaxControlPointOrder()
```

### SimpleAnimPathAPI.SetCurveType

```lua
SetCurveType(curveType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curveType` | CurveType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCurveType(curveType)
```

