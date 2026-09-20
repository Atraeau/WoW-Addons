# FrameAPICinematicModel

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**18** functions · **0** events · **0** types

## Functions

### FrameAPICinematicModel.EquipItem

```lua
EquipItem(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EquipItem(6948)
```

### FrameAPICinematicModel.InitializeCamera

```lua
InitializeCamera(scaleFactor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaleFactor` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
InitializeCamera(0)
```

### FrameAPICinematicModel.InitializePanCamera

```lua
InitializePanCamera(scaleFactor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaleFactor` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
InitializePanCamera(0)
```

### FrameAPICinematicModel.RefreshCamera

```lua
RefreshCamera()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RefreshCamera()
```

### FrameAPICinematicModel.SetAnimOffset

```lua
SetAnimOffset(offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAnimOffset(1)
```

### FrameAPICinematicModel.SetCameraPosition

```lua
SetCameraPosition(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraPosition(0, 0, 0)
```

### FrameAPICinematicModel.SetCameraTarget

```lua
SetCameraTarget(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraTarget(0, 0, 0)
```

### FrameAPICinematicModel.SetCreatureData

```lua
SetCreatureData(creatureID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCreatureData(0)
```

### FrameAPICinematicModel.SetFacingLeft

```lua
SetFacingLeft(isFacingLeft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFacingLeft` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFacingLeft(false)
```

### FrameAPICinematicModel.SetFadeTimes

```lua
SetFadeTimes(fadeInSeconds, fadeOutSeconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fadeInSeconds` | number | no |  |
| `fadeOutSeconds` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFadeTimes(0, 0)
```

### FrameAPICinematicModel.SetHeightFactor

```lua
SetHeightFactor(factor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHeightFactor(0)
```

### FrameAPICinematicModel.SetJumpInfo

```lua
SetJumpInfo(jumpLength, jumpHeight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `jumpLength` | number | no |  |
| `jumpHeight` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetJumpInfo(0, 0)
```

### FrameAPICinematicModel.SetPanDistance

```lua
SetPanDistance(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPanDistance(0)
```

### FrameAPICinematicModel.SetSpellVisualKit

```lua
SetSpellVisualKit(visualKitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualKitID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSpellVisualKit(0)
```

### FrameAPICinematicModel.SetTargetDistance

```lua
SetTargetDistance(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTargetDistance(0)
```

### FrameAPICinematicModel.StartPan

```lua
StartPan(panType, durationSeconds, doFade, visKitID, startPositionScale, speedMultiplier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `panType` | luaIndex | no |  |
| `durationSeconds` | number | no |  |
| `doFade` | bool | no | (default: False) |
| `visKitID` | number | no | (default: 0) |
| `startPositionScale` | number | no | (default: 0) |
| `speedMultiplier` | number | no | (default: 1) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
StartPan(1, 0, false, 0, 0, 0)
```

### FrameAPICinematicModel.StopPan

```lua
StopPan()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopPan()
```

### FrameAPICinematicModel.UnequipItems

```lua
UnequipItems()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UnequipItems()
```

