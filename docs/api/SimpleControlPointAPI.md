# SimpleControlPointAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### SimpleControlPointAPI.GetOffset

```lua
offsetX, offsetY = GetOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offsetX, offsetY = GetOffset()
```

### SimpleControlPointAPI.GetOrder

```lua
order = GetOrder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `order` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local order = GetOrder()
```

### SimpleControlPointAPI.SetOffset

```lua
SetOffset(offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetOffset(1, 1)
```

### SimpleControlPointAPI.SetOrder

```lua
SetOrder(order)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `order` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetOrder(0)
```

### SimpleControlPointAPI.SetParent

```lua
SetParent(parent, [order])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parent` | SimplePathAnim | no |  |
| `order` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetParent(parent)
```

