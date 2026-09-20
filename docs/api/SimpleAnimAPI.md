# SimpleAnimAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**36** functions · **0** events · **0** types

## Functions

### SimpleAnimAPI.GetDuration

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

### SimpleAnimAPI.GetElapsed

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

### SimpleAnimAPI.GetEndDelay

```lua
delaySec = GetEndDelay()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delaySec` | number | no |  |

**Example**

```lua
local delaySec = GetEndDelay()
```

### SimpleAnimAPI.GetOrder

```lua
order = GetOrder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `order` | number | no |  |

**Example**

```lua
local order = GetOrder()
```

### SimpleAnimAPI.GetProgress

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

### SimpleAnimAPI.GetRegionParent

```lua
region = GetRegionParent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `region` | CScriptObject | no |  |

**Example**

```lua
local region = GetRegionParent()
```

### SimpleAnimAPI.GetScript

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

### SimpleAnimAPI.GetSmoothing

```lua
weights = GetSmoothing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weights` | SmoothingType | no |  |

**Example**

```lua
local weights = GetSmoothing()
```

### SimpleAnimAPI.GetSmoothProgress

```lua
progress = GetSmoothProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |

**Example**

```lua
local progress = GetSmoothProgress()
```

### SimpleAnimAPI.GetStartDelay

```lua
delaySec = GetStartDelay()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delaySec` | number | no |  |

**Example**

```lua
local delaySec = GetStartDelay()
```

### SimpleAnimAPI.GetTarget

```lua
target = GetTarget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | CScriptObject | no |  |

**Example**

```lua
local target = GetTarget()
```

### SimpleAnimAPI.HasScript

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

### SimpleAnimAPI.HookScript

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

### SimpleAnimAPI.IsDelaying

```lua
isDelaying = IsDelaying()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDelaying` | bool | no |  |

**Example**

```lua
local isDelaying = IsDelaying()
```

### SimpleAnimAPI.IsDone

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

### SimpleAnimAPI.IsPaused

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

### SimpleAnimAPI.IsPlaying

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

### SimpleAnimAPI.IsStopped

```lua
isStopped = IsStopped()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isStopped` | bool | no |  |

**Example**

```lua
local isStopped = IsStopped()
```

### SimpleAnimAPI.Pause

```lua
Pause()
```

**Example**

```lua
Pause()
```

### SimpleAnimAPI.Play

```lua
Play()
```

**Example**

```lua
Play()
```

### SimpleAnimAPI.Restart

```lua
Restart()
```

**Example**

```lua
Restart()
```

### SimpleAnimAPI.SetChildKey

```lua
success = SetChildKey(childKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `childKey` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetChildKey("")
```

### SimpleAnimAPI.SetDuration

```lua
SetDuration(durationSec, recomputeGroupDuration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSec` | number | no |  |
| `recomputeGroupDuration` | bool | no | (default: True) |

**Example**

```lua
SetDuration(0, false)
```

### SimpleAnimAPI.SetEndDelay

```lua
SetEndDelay(delaySec, recomputeGroupDuration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delaySec` | number | no |  |
| `recomputeGroupDuration` | bool | no | (default: True) |

**Example**

```lua
SetEndDelay(0, false)
```

### SimpleAnimAPI.SetOrder

```lua
SetOrder(newOrder)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newOrder` | number | no |  |

**Example**

```lua
SetOrder(0)
```

### SimpleAnimAPI.SetParent

```lua
SetParent(parent, [order])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parent` | SimpleAnimGroup | no |  |
| `order` | number | yes |  |

**Example**

```lua
SetParent(parent)
```

### SimpleAnimAPI.SetPlaying

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

### SimpleAnimAPI.SetScript

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

### SimpleAnimAPI.SetSmoothing

```lua
SetSmoothing(weights)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weights` | SmoothingType | no |  |

**Example**

```lua
SetSmoothing(weights)
```

### SimpleAnimAPI.SetSmoothProgress

```lua
SetSmoothProgress(durationSec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSec` | number | no |  |

**Example**

```lua
SetSmoothProgress(0)
```

### SimpleAnimAPI.SetStartDelay

```lua
SetStartDelay(delaySec, recomputeGroupDuration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delaySec` | number | no |  |
| `recomputeGroupDuration` | bool | no | (default: True) |

**Example**

```lua
SetStartDelay(0, false)
```

### SimpleAnimAPI.SetTarget

```lua
success = SetTarget(target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | CScriptObject | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetTarget(target)
```

### SimpleAnimAPI.SetTargetKey

```lua
success = SetTargetKey(key)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetTargetKey("")
```

### SimpleAnimAPI.SetTargetName

```lua
success = SetTargetName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetTargetName("")
```

### SimpleAnimAPI.SetTargetParent

```lua
success = SetTargetParent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetTargetParent()
```

### SimpleAnimAPI.Stop

```lua
Stop()
```

**Example**

```lua
Stop()
```

