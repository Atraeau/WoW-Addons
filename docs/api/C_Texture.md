# C_Texture

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **1** events · **4** types

## Functions

### C_Texture.ClearTitleIconTexture

```lua
C_Texture.ClearTitleIconTexture(texture)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Texture.ClearTitleIconTexture(texture)
```

### C_Texture.GetAtlasElementID

```lua
elementID = C_Texture.GetAtlasElementID(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elementID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local elementID = C_Texture.GetAtlasElementID(atlas)
```

### C_Texture.GetAtlasElements

```lua
atlases = C_Texture.GetAtlasElements()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlases` | textureAtlas[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlases = C_Texture.GetAtlasElements()
```

### C_Texture.GetAtlasExists

```lua
atlasExists = C_Texture.GetAtlasExists(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlasExists` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlasExists = C_Texture.GetAtlasExists(atlas)
```

### C_Texture.GetAtlasID

```lua
atlasID = C_Texture.GetAtlasID(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlasID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlasID = C_Texture.GetAtlasID(atlas)
```

### C_Texture.GetAtlasInfo

```lua
info = C_Texture.GetAtlasInfo(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AtlasInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Texture.GetAtlasInfo(atlas)
```

### C_Texture.GetFilenameFromFileDataID

```lua
filename = C_Texture.GetFilenameFromFileDataID(fileDataID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileDataID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filename` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local filename = C_Texture.GetFilenameFromFileDataID(0)
```

### C_Texture.GetTitleIconTexture

```lua
C_Texture.GetTitleIconTexture(titleID, version, callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleID` | string | no |  |
| `version` | TitleIconVersion | no |  |
| `callback` | GetTitleIconTextureCallback | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Texture.GetTitleIconTexture("", Enum.TitleIconVersion.Small, callback)
```

### C_Texture.IsTitleIconTextureReady

```lua
ready = C_Texture.IsTitleIconTextureReady(titleID, version)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleID` | string | no |  |
| `version` | TitleIconVersion | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ready` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ready = C_Texture.IsTitleIconTextureReady("", Enum.TitleIconVersion.Small)
```

### C_Texture.SetTitleIconTexture

```lua
C_Texture.SetTitleIconTexture(texture, titleID, version)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `titleID` | string | no |  |
| `version` | TitleIconVersion | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Texture.SetTitleIconTexture(texture, "", Enum.TitleIconVersion.Small)
```

### C_Texture.SetURLTexture

```lua
C_Texture.SetURLTexture(texture, url)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `url` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Texture.SetURLTexture(texture, "")
```

## Events

### URL_TEXTURE_REQUEST_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `result` | UrlTextureResult | no |  |

## Types

### AtlasInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elementName` | cstring | no |  |
| `width` | number | no |  |
| `height` | number | no |  |
| `rawSize` | vector2 | no |  |
| `leftTexCoord` | number | no |  |
| `rightTexCoord` | number | no |  |
| `topTexCoord` | number | no |  |
| `bottomTexCoord` | number | no |  |
| `tilesHorizontally` | bool | no |  |
| `tilesVertically` | bool | no |  |
| `file` | fileID | yes |  |
| `filename` | string | yes |  |
| `sliceData` | UITextureSliceData | yes |  |

### GetTitleIconTextureCallback (CallbackType)

### TitleIconVersion (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Small` | TitleIconVersion | no |  |
| `Medium` | TitleIconVersion | no |  |
| `Large` | TitleIconVersion | no |  |

### UrlTextureResult (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Found` | UrlTextureResult | no |  |
| `NotFound` | UrlTextureResult | no |  |
| `Requested` | UrlTextureResult | no |  |
| `NotAllowed` | UrlTextureResult | no |  |

