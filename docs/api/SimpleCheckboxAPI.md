# SimpleCheckboxAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **0** events · **0** types

## Functions

### SimpleCheckboxAPI.GetChecked

```lua
checked = GetChecked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example**

```lua
local checked = GetChecked()
```

### SimpleCheckboxAPI.GetCheckedTexture

```lua
texture = GetCheckedTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example**

```lua
local texture = GetCheckedTexture()
```

### SimpleCheckboxAPI.GetDisabledCheckedTexture

```lua
texture = GetDisabledCheckedTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example**

```lua
local texture = GetDisabledCheckedTexture()
```

### SimpleCheckboxAPI.SetChecked

```lua
SetChecked(checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no | (default: False) |

**Example**

```lua
SetChecked(false)
```

### SimpleCheckboxAPI.SetCheckedTexture

```lua
SetCheckedTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetCheckedTexture(asset)
```

### SimpleCheckboxAPI.SetDisabledCheckedTexture

```lua
SetDisabledCheckedTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetDisabledCheckedTexture(asset)
```

