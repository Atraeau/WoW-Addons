# C_SocialQueue

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **3** events · **4** types

## Functions

### C_SocialQueue.GetAllGroups

```lua
groupGUIDs = C_SocialQueue.GetAllGroups(allowNonJoinable, allowNonQueuedGroups)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowNonJoinable` | bool | no | (default: False) |
| `allowNonQueuedGroups` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUIDs` | WOWGUID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groupGUIDs = C_SocialQueue.GetAllGroups(false, false)
```

### C_SocialQueue.GetConfig

```lua
config = C_SocialQueue.GetConfig()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `config` | SocialQueueConfig | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local config = C_SocialQueue.GetConfig()
```

### C_SocialQueue.GetGroupForPlayer

```lua
groupGUID, isSoloQueueParty = C_SocialQueue.GetGroupForPlayer(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |
| `isSoloQueueParty` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groupGUID, isSoloQueueParty = C_SocialQueue.GetGroupForPlayer(UnitGUID("player"))
```

### C_SocialQueue.GetGroupInfo

```lua
canJoin, numQueues, needTank, needHealer, needDamage, isSoloQueueParty, questSessionActive, leaderGUID = C_SocialQueue.GetGroupInfo(groupGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canJoin` | bool | no |  |
| `numQueues` | number | no |  |
| `needTank` | bool | no |  |
| `needHealer` | bool | no |  |
| `needDamage` | bool | no |  |
| `isSoloQueueParty` | bool | no |  |
| `questSessionActive` | bool | no |  |
| `leaderGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canJoin, numQueues, needTank, needHealer, needDamage, isSoloQueueParty, questSessionActive, leaderGUID = C_SocialQueue.GetGroupInfo(UnitGUID("player"))
```

### C_SocialQueue.GetGroupMembers

```lua
groupMembers = C_SocialQueue.GetGroupMembers(groupGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupMembers` | SocialQueuePlayerInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groupMembers = C_SocialQueue.GetGroupMembers(UnitGUID("player"))
```

### C_SocialQueue.GetGroupQueues

```lua
queues = C_SocialQueue.GetGroupQueues(groupGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `queues` | SocialQueueGroupQueueInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local queues = C_SocialQueue.GetGroupQueues(UnitGUID("player"))
```

### C_SocialQueue.IsSystemEnabled

```lua
isSystemEnabled = C_SocialQueue.IsSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSystemEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSystemEnabled = C_SocialQueue.IsSystemEnabled()
```

### C_SocialQueue.IsSystemSupported

```lua
isSystemSupported = C_SocialQueue.IsSystemSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSystemSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSystemSupported = C_SocialQueue.IsSystemSupported()
```

### C_SocialQueue.RequestToJoin

```lua
requestSuccessful = C_SocialQueue.RequestToJoin(groupGUID, applyAsTank, applyAsHealer, applyAsDamage)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |
| `applyAsTank` | bool | no | (default: False) |
| `applyAsHealer` | bool | no | (default: False) |
| `applyAsDamage` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requestSuccessful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requestSuccessful = C_SocialQueue.RequestToJoin(UnitGUID("player"), false, false, false)
```

### C_SocialQueue.SignalToastDisplayed

```lua
C_SocialQueue.SignalToastDisplayed(groupGUID, priority)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |
| `priority` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SocialQueue.SignalToastDisplayed(UnitGUID("player"), 0)
```

## Events

### SOCIAL_QUEUE_CONFIG_UPDATED

### SOCIAL_QUEUE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupGUID` | WOWGUID | no |  |
| `numAddedItems` | number | yes |  |

### SOCIAL_UI_SOCIAL_QUEUE_SYSTEM_STATUS_UPDATED

## Types

### SocialQueueConfig (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `TOASTS_DISABLED` | bool | no |  |
| `TOAST_DURATION` | number | no |  |
| `DELAY_DURATION` | number | no |  |
| `QUEUE_MULTIPLIER` | number | no |  |
| `PLAYER_MULTIPLIER` | number | no |  |
| `PLAYER_FRIEND_VALUE` | number | no |  |
| `PLAYER_GUILD_VALUE` | number | no |  |
| `THROTTLE_INITIAL_THRESHOLD` | number | no |  |
| `THROTTLE_DECAY_TIME` | number | no |  |
| `THROTTLE_PRIORITY_SPIKE` | number | no |  |
| `THROTTLE_MIN_THRESHOLD` | number | no |  |
| `THROTTLE_PVP_PRIORITY_NORMAL` | number | no |  |
| `THROTTLE_PVP_PRIORITY_LOW` | number | no |  |
| `THROTTLE_PVP_HONOR_THRESHOLD` | number | no |  |
| `THROTTLE_LFGLIST_PRIORITY_DEFAULT` | number | no |  |
| `THROTTLE_LFGLIST_PRIORITY_ABOVE` | number | no |  |
| `THROTTLE_LFGLIST_PRIORITY_BELOW` | number | no |  |
| `THROTTLE_LFGLIST_ILVL_SCALING_ABOVE` | number | no |  |
| `THROTTLE_LFGLIST_ILVL_SCALING_BELOW` | number | no |  |
| `THROTTLE_RF_PRIORITY_ABOVE` | number | no |  |
| `THROTTLE_RF_ILVL_SCALING_ABOVE` | number | no |  |
| `THROTTLE_DF_MAX_ITEM_LEVEL` | number | no |  |
| `THROTTLE_DF_BEST_PRIORITY` | number | no |  |

### SocialQueueGroupInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canJoin` | bool | no |  |
| `numQueues` | number | no |  |
| `needTank` | bool | no |  |
| `needHealer` | bool | no |  |
| `needDamage` | bool | no |  |
| `isSoloQueueParty` | bool | no |  |
| `questSessionActive` | bool | no |  |
| `leaderGUID` | WOWGUID | no |  |

### SocialQueueGroupQueueInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clientID` | number | no |  |
| `eligible` | bool | no |  |
| `needTank` | bool | no |  |
| `needHealer` | bool | no |  |
| `needDamage` | bool | no |  |
| `isAutoAccept` | bool | no |  |
| `queueData` | QueueSpecificInfo | no |  |

### SocialQueuePlayerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `clubId` | ClubId | yes |  |

