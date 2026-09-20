# C_ConsoleScriptCollection

[← API index](../README.md) · group: [Pets, Mounts & Collections](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **0** events · **4** types

## Functions

### C_ConsoleScriptCollection.GetCollectionDataByID

```lua
data = C_ConsoleScriptCollection.GetCollectionDataByID(collectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | ConsoleScriptCollectionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_ConsoleScriptCollection.GetCollectionDataByID(0)
```

### C_ConsoleScriptCollection.GetCollectionDataByTag

```lua
data = C_ConsoleScriptCollection.GetCollectionDataByTag(collectionTag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionTag` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | ConsoleScriptCollectionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_ConsoleScriptCollection.GetCollectionDataByTag("")
```

### C_ConsoleScriptCollection.GetElements

```lua
elementIDs = C_ConsoleScriptCollection.GetElements(collectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elementIDs` | ConsoleScriptCollectionElementData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local elementIDs = C_ConsoleScriptCollection.GetElements(0)
```

### C_ConsoleScriptCollection.GetScriptData

```lua
data = C_ConsoleScriptCollection.GetScriptData(consoleScriptID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `consoleScriptID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | ConsoleScriptData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_ConsoleScriptCollection.GetScriptData(0)
```

## Types

### ConsoleScriptCollectionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `name` | cstring | no |  |

### ConsoleScriptCollectionElementData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionID` | number | yes |  |
| `consoleScriptID` | number | yes |  |

### ConsoleScriptData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `name` | cstring | no |  |
| `help` | cstring | no |  |
| `script` | cstring | no |  |
| `params` | cstring | no |  |
| `isLuaScript` | bool | no |  |

### ConsoleScriptParameter (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |

