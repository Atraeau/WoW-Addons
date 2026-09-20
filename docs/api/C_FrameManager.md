# C_FrameManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **2** events · **1** types

## Functions

### C_FrameManager.GetFrameVisibilityState

```lua
shouldShow = C_FrameManager.GetFrameVisibilityState(frameType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameType` | UIFrameType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_FrameManager.GetFrameVisibilityState(Enum.UIFrameType.JailersTowerBuffs)
```

## Events

### FRAME_MANAGER_UPDATE_ALL

### FRAME_MANAGER_UPDATE_FRAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | UIFrameType | no |  |
| `show` | bool | no |  |

## Types

### UIFrameType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `JailersTowerBuffs` | UIFrameType | no |  |
| `InterruptTutorial` | UIFrameType | no |  |

