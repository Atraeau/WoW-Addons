# C_UIFileAsset

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_UIFileAsset.GetFileID

Returns the numeric file ID associated with a file asset.

```lua
assetFileID = C_UIFileAsset.GetFileID(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `assetFileID` | fileID | yes | The file ID corresponding to the given asset. If the asset is already a file ID, it is returned unchanged; otherwise returns nil if the file path is not known to the client. |

**Example**

```lua
local assetFileID = C_UIFileAsset.GetFileID(asset)
```

### C_UIFileAsset.IsKnownFile

Determines whether a file asset is known to the client, either as a shipped asset or a locally existing loose file.

```lua
isValid = C_UIFileAsset.IsKnownFile(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no | True if the asset is shipped with the client or refers to a known loose file. Existence or openability of loose files is not verified. |

**Example**

```lua
local isValid = C_UIFileAsset.IsKnownFile(asset)
```

### C_UIFileAsset.IsLooseFile

Determines whether a file asset refers to a known loose (local) file.

```lua
isLooseFile = C_UIFileAsset.IsLooseFile(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLooseFile` | bool | no | True if the asset refers to a loose file known to the client. |

**Example**

```lua
local isLooseFile = C_UIFileAsset.IsLooseFile(asset)
```

