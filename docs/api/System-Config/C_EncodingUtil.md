# C_EncodingUtil

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **0** events · **5** types

## Functions

### C_EncodingUtil.CompressString

```lua
output = C_EncodingUtil.CompressString(source, method, level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |
| `method` | CompressionMethod | no | (default: Deflate) |
| `level` | CompressionLevel | no | (default: Default) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.CompressString(source, Enum.CompressionMethod.Deflate, Enum.CompressionLevel.Default)
```

### C_EncodingUtil.DecodeBase64

```lua
output = C_EncodingUtil.DecodeBase64(source, variant)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |
| `variant` | Base64Variant | no | (default: Standard) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.DecodeBase64(source, Enum.Base64Variant.Standard)
```

### C_EncodingUtil.DecodeHex

```lua
output = C_EncodingUtil.DecodeHex(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.DecodeHex("")
```

### C_EncodingUtil.DecompressString

```lua
output = C_EncodingUtil.DecompressString(source, method)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |
| `method` | CompressionMethod | no | (default: Deflate) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.DecompressString(source, Enum.CompressionMethod.Deflate)
```

### C_EncodingUtil.DeserializeCBOR

```lua
value = C_EncodingUtil.DeserializeCBOR(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueVariant | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_EncodingUtil.DeserializeCBOR(source)
```

### C_EncodingUtil.DeserializeJSON

```lua
value = C_EncodingUtil.DeserializeJSON(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueVariant | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_EncodingUtil.DeserializeJSON("")
```

### C_EncodingUtil.EncodeBase64

```lua
output = C_EncodingUtil.EncodeBase64(source, variant)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |
| `variant` | Base64Variant | no | (default: Standard) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.EncodeBase64(source, Enum.Base64Variant.Standard)
```

### C_EncodingUtil.EncodeHex

```lua
output = C_EncodingUtil.EncodeHex(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.EncodeHex(source)
```

### C_EncodingUtil.SerializeCBOR

```lua
output = C_EncodingUtil.SerializeCBOR([value], [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueVariant | yes |  |
| `options` | CBORSerializationOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.SerializeCBOR()
```

### C_EncodingUtil.SerializeJSON

```lua
output = C_EncodingUtil.SerializeJSON([value], [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueVariant | yes |  |
| `options` | JSONSerializationOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local output = C_EncodingUtil.SerializeJSON()
```

## Types

### Base64Variant (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Standard` | Base64Variant | no | Encodes with the alphabet defined in RFC 4648 (with potential padding bytes) |
| `StandardUrlSafe` | Base64Variant | no | Encodes with the 'URL and Filename Safe' alphabet from RFC 4648 (with potential padding bytes) |

### CBORSerializationOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreSerializationErrors` | bool | no | If true, attempt to ignore errors from unsupported values and instead replace them where applicable with 'undefined' CBOR items. (default: False) |

### CompressionLevel (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | CompressionLevel | no |  |
| `OptimizeForSpeed` | CompressionLevel | no |  |
| `OptimizeForSize` | CompressionLevel | no |  |

### CompressionMethod (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Deflate` | CompressionMethod | no |  |
| `Zlib` | CompressionMethod | no |  |
| `Gzip` | CompressionMethod | no |  |

### JSONSerializationOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreSerializationErrors` | bool | no | If true, attempt to ignore errors from unsupported values and instead replace them where applicable with 'null' JSON values. (default: False) |

