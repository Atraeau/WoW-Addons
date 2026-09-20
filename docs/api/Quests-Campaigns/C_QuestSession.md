# C_QuestSession

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**14** functions · **8** events · **1** types

## Functions

### C_QuestSession.CanStart

```lua
allowed = C_QuestSession.CanStart()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowed = C_QuestSession.CanStart()
```

### C_QuestSession.CanStop

```lua
allowed = C_QuestSession.CanStop()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowed = C_QuestSession.CanStop()
```

### C_QuestSession.Exists

```lua
exists = C_QuestSession.Exists()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exists` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local exists = C_QuestSession.Exists()
```

### C_QuestSession.GetAvailableSessionCommand

```lua
command = C_QuestSession.GetAvailableSessionCommand()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `command` | QuestSessionCommand | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local command = C_QuestSession.GetAvailableSessionCommand()
```

### C_QuestSession.GetPendingCommand

```lua
command = C_QuestSession.GetPendingCommand()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `command` | QuestSessionCommand | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local command = C_QuestSession.GetPendingCommand()
```

### C_QuestSession.GetProposedMaxLevelForSession

```lua
proposedMaxLevel = C_QuestSession.GetProposedMaxLevelForSession()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `proposedMaxLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local proposedMaxLevel = C_QuestSession.GetProposedMaxLevelForSession()
```

### C_QuestSession.GetSessionBeginDetails

```lua
details = C_QuestSession.GetSessionBeginDetails()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `details` | QuestSessionPlayerDetails | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local details = C_QuestSession.GetSessionBeginDetails()
```

### C_QuestSession.GetSuperTrackedQuest

```lua
questID = C_QuestSession.GetSuperTrackedQuest()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questID = C_QuestSession.GetSuperTrackedQuest()
```

### C_QuestSession.HasJoined

```lua
hasJoined = C_QuestSession.HasJoined()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasJoined` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasJoined = C_QuestSession.HasJoined()
```

### C_QuestSession.HasPendingCommand

```lua
hasPendingCommand = C_QuestSession.HasPendingCommand()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPendingCommand` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPendingCommand = C_QuestSession.HasPendingCommand()
```

### C_QuestSession.RequestSessionStart

```lua
C_QuestSession.RequestSessionStart()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_QuestSession.RequestSessionStart()
```

### C_QuestSession.RequestSessionStop

```lua
C_QuestSession.RequestSessionStop()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_QuestSession.RequestSessionStop()
```

### C_QuestSession.SendSessionBeginResponse

```lua
C_QuestSession.SendSessionBeginResponse(beginSession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `beginSession` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_QuestSession.SendSessionBeginResponse(false)
```

### C_QuestSession.SetQuestIsSuperTracked

```lua
C_QuestSession.SetQuestIsSuperTracked(questID, superTrack)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `superTrack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_QuestSession.SetQuestIsSuperTracked(0, false)
```

## Events

### QUEST_SESSION_CREATED

### QUEST_SESSION_DESTROYED

### QUEST_SESSION_ENABLED_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

### QUEST_SESSION_JOINED

### QUEST_SESSION_LEFT

### QUEST_SESSION_MEMBER_CONFIRM

### QUEST_SESSION_MEMBER_START_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `response` | bool | no |  |

### QUEST_SESSION_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | QuestSessionResult | no |  |
| `guid` | WOWGUID | no |  |

## Types

### QuestSessionPlayerDetails (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `guid` | WOWGUID | no |  |

