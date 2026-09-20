# C_Discord

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**20** functions · **6** events · **0** types

## Functions

### C_Discord.Authorize

```lua
C_Discord.Authorize()
```

**Example**

```lua
C_Discord.Authorize()
```

### C_Discord.GetDiscordChannelName

```lua
name = C_Discord.GetDiscordChannelName(serverIndex, channelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serverIndex` | luaIndex | no |  |
| `channelIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example**

```lua
local name = C_Discord.GetDiscordChannelName(1, 1)
```

### C_Discord.GetDiscordUserID

```lua
userID = C_Discord.GetDiscordUserID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `userID` | DiscordID | no |  |

**Example**

```lua
local userID = C_Discord.GetDiscordUserID()
```

### C_Discord.GetDiscordUserName

```lua
userName = C_Discord.GetDiscordUserName(userID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `userID` | DiscordID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `userName` | KStringDiscordUserName | no |  |

**Example**

```lua
local userName = C_Discord.GetDiscordUserName(userID)
```

### C_Discord.GetDisplayNameType

```lua
type = C_Discord.GetDisplayNameType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | DiscordDisplayNameType | no |  |

**Example**

```lua
local type = C_Discord.GetDisplayNameType()
```

### C_Discord.GetGuildLinkStatus

```lua
isFullyLinked, linkedChannelName, linkedServerName = C_Discord.GetGuildLinkStatus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFullyLinked` | bool | no |  |
| `linkedChannelName` | string | no |  |
| `linkedServerName` | string | no |  |

**Example**

```lua
local isFullyLinked, linkedChannelName, linkedServerName = C_Discord.GetGuildLinkStatus()
```

### C_Discord.GetNumDiscordChannels

```lua
count, valid = C_Discord.GetNumDiscordChannels(serverIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serverIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |
| `valid` | bool | no |  |

**Example**

```lua
local count, valid = C_Discord.GetNumDiscordChannels(1)
```

### C_Discord.GetNumDiscordServers

```lua
count = C_Discord.GetNumDiscordServers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example**

```lua
local count = C_Discord.GetNumDiscordServers()
```

### C_Discord.GetServerLinkableChannels

```lua
C_Discord.GetServerLinkableChannels(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example**

```lua
C_Discord.GetServerLinkableChannels(1)
```

### C_Discord.GetServerName

```lua
name = C_Discord.GetServerName(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example**

```lua
local name = C_Discord.GetServerName(1)
```

### C_Discord.GuildLink

```lua
C_Discord.GuildLink(serverIndex, channelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serverIndex` | luaIndex | no |  |
| `channelIndex` | luaIndex | no |  |

**Example**

```lua
C_Discord.GuildLink(1, 1)
```

### C_Discord.GuildUnlink

```lua
C_Discord.GuildUnlink()
```

**Example**

```lua
C_Discord.GuildUnlink()
```

### C_Discord.IsEnabled

```lua
enabled = C_Discord.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_Discord.IsEnabled()
```

### C_Discord.IsGuildChannelLinked

```lua
isLinked = C_Discord.IsGuildChannelLinked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLinked` | bool | no |  |

**Example**

```lua
local isLinked = C_Discord.IsGuildChannelLinked()
```

### C_Discord.IsGuildSettingSet

```lua
isSet = C_Discord.IsGuildSettingSet(setting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | DiscordGuildSettings | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSet` | bool | no |  |

**Example**

```lua
local isSet = C_Discord.IsGuildSettingSet(setting)
```

### C_Discord.IsUserOAuthed

```lua
hasOAuth = C_Discord.IsUserOAuthed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasOAuth` | bool | no |  |

**Example**

```lua
local hasOAuth = C_Discord.IsUserOAuthed()
```

### C_Discord.RefreshAuth

```lua
C_Discord.RefreshAuth()
```

**Example**

```lua
C_Discord.RefreshAuth()
```

### C_Discord.SetGuildSetting

```lua
C_Discord.SetGuildSetting(setting, set)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | DiscordGuildSettings | no |  |
| `set` | bool | no |  |

**Example**

```lua
C_Discord.SetGuildSetting(setting, false)
```

### C_Discord.UpdateDiscordServers

```lua
C_Discord.UpdateDiscordServers()
```

**Example**

```lua
C_Discord.UpdateDiscordServers()
```

### C_Discord.UpdateGuildLobby

```lua
C_Discord.UpdateGuildLobby()
```

**Example**

```lua
C_Discord.UpdateGuildLobby()
```

## Events

### DISCORD_GUILD_ACHIEVEMENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

### DISCORD_GUILD_LOBBY_UPDATE

### DISCORD_GUILD_SETTINGS_UPDATE

### DISCORD_LINK_UPDATE

### DISCORD_SERVER_LIST_UPDATE

### DISCORD_STATUS_UPDATE

