# SimpleTextureAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **0** types

## Functions

### SimpleTextureAPI.AddMaskTexture

```lua
AddMaskTexture(mask)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mask` | SimpleMaskTexture | no |  |

**Example**

```lua
AddMaskTexture(mask)
```

### SimpleTextureAPI.GetMaskTexture

```lua
mask = GetMaskTexture(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mask` | SimpleMaskTexture | no |  |

**Example**

```lua
local mask = GetMaskTexture(1)
```

### SimpleTextureAPI.GetNumMaskTextures

```lua
count = GetNumMaskTextures()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | size | no |  |

**Example**

```lua
local count = GetNumMaskTextures()
```

### SimpleTextureAPI.RemoveMaskTexture

```lua
RemoveMaskTexture(mask)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mask` | SimpleMaskTexture | no |  |

**Example**

```lua
RemoveMaskTexture(mask)
```

