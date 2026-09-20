# FrameAPIFogOfWarFrame

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**12** functions · **0** events · **0** types

## Functions

### FrameAPIFogOfWarFrame.GetFogOfWarBackgroundAtlas

```lua
atlas = GetFogOfWarBackgroundAtlas()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
local atlas = GetFogOfWarBackgroundAtlas()
```

### FrameAPIFogOfWarFrame.GetFogOfWarBackgroundTexture

```lua
asset = GetFogOfWarBackgroundTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | yes |  |

**Example**

```lua
local asset = GetFogOfWarBackgroundTexture()
```

### FrameAPIFogOfWarFrame.GetFogOfWarMaskAtlas

```lua
atlas = GetFogOfWarMaskAtlas()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
local atlas = GetFogOfWarMaskAtlas()
```

### FrameAPIFogOfWarFrame.GetFogOfWarMaskTexture

```lua
asset = GetFogOfWarMaskTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | yes |  |

**Example**

```lua
local asset = GetFogOfWarMaskTexture()
```

### FrameAPIFogOfWarFrame.GetMaskScalar

```lua
scalar = GetMaskScalar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
local scalar = GetMaskScalar()
```

### FrameAPIFogOfWarFrame.GetUiMapID

```lua
uiMapID = GetUiMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
local uiMapID = GetUiMapID()
```

### FrameAPIFogOfWarFrame.SetFogOfWarBackgroundAtlas

```lua
SetFogOfWarBackgroundAtlas(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
SetFogOfWarBackgroundAtlas(atlas)
```

### FrameAPIFogOfWarFrame.SetFogOfWarBackgroundTexture

```lua
SetFogOfWarBackgroundTexture(asset, horizontalTile, verticalTile)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |
| `horizontalTile` | bool | no |  |
| `verticalTile` | bool | no |  |

**Example**

```lua
SetFogOfWarBackgroundTexture(asset, false, false)
```

### FrameAPIFogOfWarFrame.SetFogOfWarMaskAtlas

```lua
SetFogOfWarMaskAtlas(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example**

```lua
SetFogOfWarMaskAtlas(atlas)
```

### FrameAPIFogOfWarFrame.SetFogOfWarMaskTexture

```lua
SetFogOfWarMaskTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Example**

```lua
SetFogOfWarMaskTexture(asset)
```

### FrameAPIFogOfWarFrame.SetMaskScalar

```lua
SetMaskScalar(scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
SetMaskScalar(0)
```

### FrameAPIFogOfWarFrame.SetUiMapID

```lua
SetUiMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
SetUiMapID(0)
```

