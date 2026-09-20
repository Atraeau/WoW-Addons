# C_ClientScene

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **2** events · **1** types

## Functions

### C_ClientScene.IsSceneTypeActive

```lua
isPlaying = C_ClientScene.IsSceneTypeActive([desiredSceneType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desiredSceneType` | ClientSceneType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlaying` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlaying = C_ClientScene.IsSceneTypeActive()
```

## Events

### CLIENT_SCENE_CLOSED

### CLIENT_SCENE_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sceneType` | ClientSceneType | no |  |

## Types

### ClientSceneType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `DefaultSceneType` | ClientSceneType | no |  |
| `MinigameSceneType` | ClientSceneType | no |  |

