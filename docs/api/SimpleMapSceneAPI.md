# SimpleMapSceneAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### SimpleMapSceneAPI.GetMaxCharacterSlotCount

```lua
maxCharacterSlotCount = GetMaxCharacterSlotCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxCharacterSlotCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxCharacterSlotCount = GetMaxCharacterSlotCount()
```

### SimpleMapSceneAPI.GetModelDrawLayer

```lua
layer, sublayer = GetModelDrawLayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `sublayer` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layer, sublayer = GetModelDrawLayer()
```

### SimpleMapSceneAPI.GetViewInsets

```lua
left, right, top, bottom = GetViewInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = GetViewInsets()
```

### SimpleMapSceneAPI.SetModelDrawLayer

```lua
SetModelDrawLayer(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetModelDrawLayer(layer)
```

### SimpleMapSceneAPI.SetViewInsets

```lua
SetViewInsets(left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetViewInsets(left, right, top, bottom)
```

