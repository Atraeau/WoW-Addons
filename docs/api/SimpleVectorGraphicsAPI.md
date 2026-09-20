# SimpleVectorGraphicsAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **0** types

## Functions

### SimpleVectorGraphicsAPI.ClearSVG

```lua
ClearSVG()
```

**Example**

```lua
ClearSVG()
```

### SimpleVectorGraphicsAPI.GetSVGFileID

```lua
svgFile = GetSVGFileID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `svgFile` | fileID | no |  |

**Example**

```lua
local svgFile = GetSVGFileID()
```

### SimpleVectorGraphicsAPI.HasSVG

```lua
hasSVG = HasSVG()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSVG` | bool | no |  |

**Example**

```lua
local hasSVG = HasSVG()
```

### SimpleVectorGraphicsAPI.SetSVG

```lua
success = SetSVG(svgAsset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `svgAsset` | FileAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetSVG(svgAsset)
```

