# SimpleAnimGroupAPI

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**28** functions · **0** events · **0** types

## Functions

### SimpleAnimGroupAPI.CreateAnimation

```lua
anim = CreateAnimation([animationType], [name], [templateName])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animationType` | cstring | yes |  |
| `name` | cstring | yes |  |
| `templateName` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anim` | SimpleAnim | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local anim = CreateAnimation()
```

### SimpleAnimGroupAPI.Finish

```lua
Finish()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Finish()
```

### SimpleAnimGroupAPI.GetAnimations

```lua
anims = GetAnimations()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anims` | SimpleAnim | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local anims = GetAnimations()
```

### SimpleAnimGroupAPI.GetAnimationSpeedMultiplier

```lua
animationSpeedMultiplier = GetAnimationSpeedMultiplier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animationSpeedMultiplier` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local animationSpeedMultiplier = GetAnimationSpeedMultiplier()
```

### SimpleAnimGroupAPI.GetDuration

```lua
durationSec = GetDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSec` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSec = GetDuration()
```

### SimpleAnimGroupAPI.GetElapsed

```lua
elapsedSec = GetElapsed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elapsedSec` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local elapsedSec = GetElapsed()
```

### SimpleAnimGroupAPI.GetLooping

```lua
loopType = GetLooping()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loopType` | LoopType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loopType = GetLooping()
```

### SimpleAnimGroupAPI.GetLoopState

```lua
loopState = GetLoopState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loopState` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loopState = GetLoopState()
```

### SimpleAnimGroupAPI.GetProgress

```lua
progress = GetProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local progress = GetProgress()
```

### SimpleAnimGroupAPI.GetScript

```lua
script = GetScript(scriptTypeName, bindingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `bindingType` | ScriptBindingType | no | (default: Extrinsic) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `script` | LuaFunctionReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local script = GetScript(scriptTypeName, bindingType)
```

### SimpleAnimGroupAPI.HasScript

```lua
hasScript = HasScript(scriptName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasScript` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasScript = HasScript("")
```

### SimpleAnimGroupAPI.HookScript

```lua
success = HookScript(scriptTypeName, script, bindingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `script` | LuaFunctionReference | no |  |
| `bindingType` | ScriptBindingType | no | (default: Extrinsic) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = HookScript(scriptTypeName, script, bindingType)
```

### SimpleAnimGroupAPI.IsDone

```lua
isDone = IsDone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDone` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDone = IsDone()
```

### SimpleAnimGroupAPI.IsPaused

```lua
isPaused = IsPaused()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPaused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPaused = IsPaused()
```

### SimpleAnimGroupAPI.IsPendingFinish

```lua
isPendingFinish = IsPendingFinish()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPendingFinish` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPendingFinish = IsPendingFinish()
```

### SimpleAnimGroupAPI.IsPlaying

```lua
isPlaying = IsPlaying()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlaying` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlaying = IsPlaying()
```

### SimpleAnimGroupAPI.IsReverse

```lua
isReverse = IsReverse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReverse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isReverse = IsReverse()
```

### SimpleAnimGroupAPI.IsSetToFinalAlpha

```lua
isSetToFinalAlpha = IsSetToFinalAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSetToFinalAlpha` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSetToFinalAlpha = IsSetToFinalAlpha()
```

### SimpleAnimGroupAPI.Pause

```lua
Pause()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Pause()
```

### SimpleAnimGroupAPI.Play

```lua
Play(reverse, offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |
| `offset` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
Play(false, 1)
```

### SimpleAnimGroupAPI.RemoveAnimations

```lua
RemoveAnimations()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RemoveAnimations()
```

### SimpleAnimGroupAPI.Restart

```lua
Restart(reverse, offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |
| `offset` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
Restart(false, 1)
```

### SimpleAnimGroupAPI.SetAnimationSpeedMultiplier

```lua
SetAnimationSpeedMultiplier(animationSpeedMultiplier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animationSpeedMultiplier` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAnimationSpeedMultiplier(0)
```

### SimpleAnimGroupAPI.SetLooping

```lua
SetLooping(loopType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loopType` | LoopType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLooping(loopType)
```

### SimpleAnimGroupAPI.SetPlaying

```lua
SetPlaying(play)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `play` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPlaying(false)
```

### SimpleAnimGroupAPI.SetScript

```lua
SetScript(scriptTypeName, [script])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `script` | LuaFunctionReference | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetScript(scriptTypeName)
```

### SimpleAnimGroupAPI.SetToFinalAlpha

```lua
SetToFinalAlpha(setToFinalAlpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setToFinalAlpha` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToFinalAlpha(false)
```

### SimpleAnimGroupAPI.Stop

```lua
Stop()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Stop()
```

