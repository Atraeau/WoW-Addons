# SimpleAnimGroupAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

```lua
local anim = CreateAnimation()
```

### SimpleAnimGroupAPI.Finish

```lua
Finish()
```

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
local isSetToFinalAlpha = IsSetToFinalAlpha()
```

### SimpleAnimGroupAPI.Pause

```lua
Pause()
```

**Example**

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

**Example**

```lua
Play(false, 0)
```

### SimpleAnimGroupAPI.RemoveAnimations

```lua
RemoveAnimations()
```

**Example**

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

**Example**

```lua
Restart(false, 0)
```

### SimpleAnimGroupAPI.SetAnimationSpeedMultiplier

```lua
SetAnimationSpeedMultiplier(animationSpeedMultiplier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animationSpeedMultiplier` | number | no |  |

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
SetToFinalAlpha(false)
```

### SimpleAnimGroupAPI.Stop

```lua
Stop()
```

**Example**

```lua
Stop()
```

