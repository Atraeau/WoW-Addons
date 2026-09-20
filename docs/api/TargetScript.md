# TargetScript

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**24** functions · **0** events · **0** types

## Functions

### TargetScript.AssistUnit

```lua
AssistUnit(name, exactMatch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `exactMatch` | bool | no | (default: False) |

**Example**

```lua
AssistUnit("", false)
```

### TargetScript.AttackTarget

```lua
AttackTarget()
```

**Example**

```lua
AttackTarget()
```

### TargetScript.ClearFocus

```lua
ClearFocus()
```

**Example**

```lua
ClearFocus()
```

### TargetScript.ClearTarget

```lua
willMakeChange = ClearTarget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `willMakeChange` | bool | no |  |

**Example**

```lua
local willMakeChange = ClearTarget()
```

### TargetScript.FocusUnit

```lua
FocusUnit(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example**

```lua
FocusUnit("")
```

### TargetScript.IsTargetLoose

```lua
isTargetLoose = IsTargetLoose()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTargetLoose` | bool | no |  |

**Example**

```lua
local isTargetLoose = IsTargetLoose()
```

### TargetScript.SetPreferredGamepadInteractTarget

```lua
SetPreferredGamepadInteractTarget([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Example**

```lua
SetPreferredGamepadInteractTarget()
```

### TargetScript.TargetDirectionEnemy

```lua
TargetDirectionEnemy(facing, [coneAngle])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `facing` | number | no |  |
| `coneAngle` | number | yes |  |

**Example**

```lua
TargetDirectionEnemy(0)
```

### TargetScript.TargetDirectionFinished

```lua
TargetDirectionFinished()
```

**Example**

```lua
TargetDirectionFinished()
```

### TargetScript.TargetDirectionFriend

```lua
TargetDirectionFriend(facing, [coneAngle])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `facing` | number | no |  |
| `coneAngle` | number | yes |  |

**Example**

```lua
TargetDirectionFriend(0)
```

### TargetScript.TargetLastEnemy

```lua
TargetLastEnemy()
```

**Example**

```lua
TargetLastEnemy()
```

### TargetScript.TargetLastFriend

```lua
TargetLastFriend()
```

**Example**

```lua
TargetLastFriend()
```

### TargetScript.TargetLastTarget

```lua
TargetLastTarget()
```

**Example**

```lua
TargetLastTarget()
```

### TargetScript.TargetNearest

```lua
TargetNearest(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearest(false)
```

### TargetScript.TargetNearestEnemy

```lua
TargetNearestEnemy(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestEnemy(false)
```

### TargetScript.TargetNearestEnemyPlayer

```lua
TargetNearestEnemyPlayer(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestEnemyPlayer(false)
```

### TargetScript.TargetNearestFriend

```lua
TargetNearestFriend(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestFriend(false)
```

### TargetScript.TargetNearestFriendPlayer

```lua
TargetNearestFriendPlayer(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestFriendPlayer(false)
```

### TargetScript.TargetNearestPartyMember

```lua
TargetNearestPartyMember(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestPartyMember(false)
```

### TargetScript.TargetNearestRaidMember

```lua
TargetNearestRaidMember(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example**

```lua
TargetNearestRaidMember(false)
```

### TargetScript.TargetPriorityHighlightEnd

```lua
TargetPriorityHighlightEnd()
```

**Example**

```lua
TargetPriorityHighlightEnd()
```

### TargetScript.TargetPriorityHighlightStart

```lua
TargetPriorityHighlightStart(useStartDelay)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useStartDelay` | bool | no | (default: False) |

**Example**

```lua
TargetPriorityHighlightStart(false)
```

### TargetScript.TargetToggle

```lua
TargetToggle()
```

**Example**

```lua
TargetToggle()
```

### TargetScript.TargetUnit

```lua
TargetUnit(name, exactMatch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `exactMatch` | bool | no | (default: False) |

**Example**

```lua
TargetUnit("", false)
```

