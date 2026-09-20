# C_SwingTimer

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **2** events · **1** types

## Functions

### C_SwingTimer.EnableRangeCheck

Used in conjunction with PlayerSwingRangeUpdate to inform the UI when the current target goes in or out of auto attack range.

```lua
C_SwingTimer.EnableRangeCheck(swingType, enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `swingType` | PlayerSwingType | no |  |
| `enable` | bool | no | True if changes in range for the swing type should dispatch PlayerSwingRangeUpdate. False if the swing type no longer needs the event. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SwingTimer.EnableRangeCheck(Enum.PlayerSwingType.MainHand, false)
```

### C_SwingTimer.IsTargetWithinSwingRange

Whether the current target is within range of the player's auto attack for the given swing type. Auto attacks only ever apply to the current target, so no other unit can be queried.

```lua
isInRange = C_SwingTimer.IsTargetWithinSwingRange(swingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `swingType` | PlayerSwingType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInRange` | bool | yes | Nil when no range check could be made, for example there is no target, the target cannot be attacked, or no weapon is equipped for the swing type. Nil must not be treated as out of range. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInRange = C_SwingTimer.IsTargetWithinSwingRange(Enum.PlayerSwingType.MainHand)
```

## Events

### PLAYER_SWING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `swingDuration` | number | no |  |
| `swingType` | PlayerSwingType | no |  |

### PLAYER_SWING_RANGE_UPDATE

Only signaled for swing types that have an active range check. See C_SwingTimer.EnableRangeCheck.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `swingType` | PlayerSwingType | no |  |
| `isInRange` | bool | no | Whether the current target is within auto attack range. Should not be used if the 'checksRange' parameter is false. |
| `checksRange` | bool | no | Can be false if a range check was not made for any reason, for example there is not a current target. |

## Types

### PlayerSwingType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `MainHand` | PlayerSwingType | no |  |
| `OffHand` | PlayerSwingType | no |  |
| `Ranged` | PlayerSwingType | no |  |

