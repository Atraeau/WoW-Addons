# C_WarbandScene

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **2** events · **2** types

## Functions

### C_WarbandScene.GetRandomEntryID

```lua
warbandSceneID = C_WarbandScene.GetRandomEntryID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warbandSceneID = C_WarbandScene.GetRandomEntryID()
```

### C_WarbandScene.GetWarbandSceneEntry

```lua
warbandSceneEntry = C_WarbandScene.GetWarbandSceneEntry(warbandSceneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneEntry` | WarbandSceneEntry | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warbandSceneEntry = C_WarbandScene.GetWarbandSceneEntry(0)
```

### C_WarbandScene.HasWarbandScene

```lua
owned = C_WarbandScene.HasWarbandScene(warbandSceneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `owned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local owned = C_WarbandScene.HasWarbandScene(0)
```

### C_WarbandScene.IsFavorite

```lua
favorite = C_WarbandScene.IsFavorite(warbandSceneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `favorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local favorite = C_WarbandScene.IsFavorite(0)
```

### C_WarbandScene.SearchWarbandSceneEntries

```lua
matchingEntryIDs = C_WarbandScene.SearchWarbandSceneEntries(searchParams)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchParams` | WarbandSceneSearchInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchingEntryIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matchingEntryIDs = C_WarbandScene.SearchWarbandSceneEntries(searchParams)
```

### C_WarbandScene.SetFavorite

```lua
C_WarbandScene.SetFavorite(warbandSceneID, favorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no |  |
| `favorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WarbandScene.SetFavorite(0, false)
```

### C_WarbandScene.WarbandScenesAvailable

```lua
areWarbandScenesAvailable = C_WarbandScene.WarbandScenesAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areWarbandScenesAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areWarbandScenesAvailable = C_WarbandScene.WarbandScenesAvailable()
```

## Events

### NEW_WARBAND_SCENE_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandScenID` | number | no |  |

### WARBAND_SCENE_FAVORITES_UPDATED

## Types

### WarbandSceneEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warbandSceneID` | number | no | (default: 0) |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `source` | cstring | no |  |
| `quality` | number | no |  |
| `textureKit` | textureKit | no |  |
| `isFavorite` | bool | no | (default: False) |
| `hasFanfare` | bool | no | (default: False) |
| `sourceType` | number | no | (default: 0) |

### WarbandSceneSearchInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedOnly` | bool | no | (default: False) |
| `favoritesOnly` | bool | no | (default: False) |

