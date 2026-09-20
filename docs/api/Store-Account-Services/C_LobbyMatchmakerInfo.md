# C_LobbyMatchmakerInfo

[← API index](../README.md) · group: [Store, Account & Services](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**8** functions · **5** events · **2** types

## Functions

### C_LobbyMatchmakerInfo.AbandonQueue

```lua
C_LobbyMatchmakerInfo.AbandonQueue()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LobbyMatchmakerInfo.AbandonQueue()
```

### C_LobbyMatchmakerInfo.EnterQueue

```lua
C_LobbyMatchmakerInfo.EnterQueue(playlistEntry)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playlistEntry` | PartyPlaylistEntry | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LobbyMatchmakerInfo.EnterQueue(playlistEntry)
```

### C_LobbyMatchmakerInfo.GetCurrQueuePlaylistEntry

```lua
playlistEntry = C_LobbyMatchmakerInfo.GetCurrQueuePlaylistEntry()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playlistEntry` | PartyPlaylistEntry | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local playlistEntry = C_LobbyMatchmakerInfo.GetCurrQueuePlaylistEntry()
```

### C_LobbyMatchmakerInfo.GetCurrQueueState

```lua
queueState = C_LobbyMatchmakerInfo.GetCurrQueueState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `queueState` | PlunderstormQueueState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local queueState = C_LobbyMatchmakerInfo.GetCurrQueueState()
```

### C_LobbyMatchmakerInfo.GetQueueFromMainlineEnabled

```lua
queueFromMainlineEnabled = C_LobbyMatchmakerInfo.GetQueueFromMainlineEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `queueFromMainlineEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local queueFromMainlineEnabled = C_LobbyMatchmakerInfo.GetQueueFromMainlineEnabled()
```

### C_LobbyMatchmakerInfo.GetQueueStartTime

```lua
queueStartTime = C_LobbyMatchmakerInfo.GetQueueStartTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `queueStartTime` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local queueStartTime = C_LobbyMatchmakerInfo.GetQueueStartTime()
```

### C_LobbyMatchmakerInfo.IsInQueue

```lua
isInQueue = C_LobbyMatchmakerInfo.IsInQueue()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInQueue` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInQueue = C_LobbyMatchmakerInfo.IsInQueue()
```

### C_LobbyMatchmakerInfo.RespondToQueuePop

```lua
C_LobbyMatchmakerInfo.RespondToQueuePop(acceptQueue)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `acceptQueue` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LobbyMatchmakerInfo.RespondToQueuePop(false)
```

## Events

### LOBBY_MATCHMAKER_QUEUE_ABANDONED

### LOBBY_MATCHMAKER_QUEUE_ERROR

### LOBBY_MATCHMAKER_QUEUE_EXPIRED

### LOBBY_MATCHMAKER_QUEUE_POPPED

### LOBBY_MATCHMAKER_QUEUE_STATUS_UPDATE

## Types

### LobbyMatchmakerQueueInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isQueueActive` | bool | no | (default: False) |
| `playlistEntryID` | PartyPlaylistEntry | no |  |
| `queueState` | PlunderstormQueueState | no |  |
| `queueStartTime` | number | no |  |

### PlunderstormQueueState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | PlunderstormQueueState | no |  |
| `Queued` | PlunderstormQueueState | no |  |
| `Proposed` | PlunderstormQueueState | no |  |
| `Suspended` | PlunderstormQueueState | no |  |

