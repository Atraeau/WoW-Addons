# TargetScript

[← API index](../README.md) · group: [AddOns & Scripting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
AssistUnit("", false)
```

### TargetScript.AttackTarget

```lua
AttackTarget()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
AttackTarget()
```

### TargetScript.ClearFocus

```lua
ClearFocus()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetDirectionEnemy(0)
```

### TargetScript.TargetDirectionFinished

```lua
TargetDirectionFinished()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetDirectionFriend(0)
```

### TargetScript.TargetLastEnemy

```lua
TargetLastEnemy()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetLastEnemy()
```

### TargetScript.TargetLastFriend

```lua
TargetLastFriend()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetLastFriend()
```

### TargetScript.TargetLastTarget

```lua
TargetLastTarget()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetNearestRaidMember(false)
```

### TargetScript.TargetPriorityHighlightEnd

```lua
TargetPriorityHighlightEnd()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetPriorityHighlightStart(false)
```

### TargetScript.TargetToggle

```lua
TargetToggle()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetUnit("", false)
```

