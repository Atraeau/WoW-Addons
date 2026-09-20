# C_ChatInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**45** functions · **102** events · **2** types

## Functions

### C_ChatInfo.AreOutgoingAddonChatMessagesRestricted

Returns false if addons are allowed to send outgoing chat messages. This is controlled on a realm-by-realm basis (tournament realms allow it), and the ability for addons to receive comms is controlled separately.

```lua
isRestricted = C_ChatInfo.AreOutgoingAddonChatMessagesRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRestricted` | bool | no |  |

**Example**

```lua
local isRestricted = C_ChatInfo.AreOutgoingAddonChatMessagesRestricted()
```

### C_ChatInfo.CancelEmote

```lua
C_ChatInfo.CancelEmote()
```

**Example**

```lua
C_ChatInfo.CancelEmote()
```

### C_ChatInfo.CanPlayerSpeakLanguage

```lua
canSpeakLanguage = C_ChatInfo.CanPlayerSpeakLanguage(languageId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `languageId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSpeakLanguage` | bool | no |  |

**Example**

```lua
local canSpeakLanguage = C_ChatInfo.CanPlayerSpeakLanguage(0)
```

### C_ChatInfo.DropCautionaryChatMessage

```lua
C_ChatInfo.DropCautionaryChatMessage(confirmNumber)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `confirmNumber` | number | no |  |

**Example**

```lua
C_ChatInfo.DropCautionaryChatMessage(0)
```

### C_ChatInfo.GetChannelInfoFromIdentifier

```lua
info = C_ChatInfo.GetChannelInfoFromIdentifier(channelIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelIdentifier` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ChatChannelInfo | yes |  |

**Example**

```lua
local info = C_ChatInfo.GetChannelInfoFromIdentifier("")
```

### C_ChatInfo.GetChannelRosterInfo

```lua
name, owner, moderator, guid = C_ChatInfo.GetChannelRosterInfo(channelIndex, rosterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelIndex` | luaIndex | no |  |
| `rosterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `owner` | bool | no |  |
| `moderator` | bool | no |  |
| `guid` | WOWGUID | no |  |

**Example**

```lua
local name, owner, moderator, guid = C_ChatInfo.GetChannelRosterInfo(1, 1)
```

### C_ChatInfo.GetChannelRuleset

```lua
ruleset = C_ChatInfo.GetChannelRuleset(channelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ruleset` | ChatChannelRuleset | no |  |

**Example**

```lua
local ruleset = C_ChatInfo.GetChannelRuleset(1)
```

### C_ChatInfo.GetChannelRulesetForChannelID

```lua
ruleset = C_ChatInfo.GetChannelRulesetForChannelID(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ruleset` | ChatChannelRuleset | no |  |

**Example**

```lua
local ruleset = C_ChatInfo.GetChannelRulesetForChannelID(0)
```

### C_ChatInfo.GetChannelShortcut

```lua
shortcut = C_ChatInfo.GetChannelShortcut(channelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shortcut` | cstring | no |  |

**Example**

```lua
local shortcut = C_ChatInfo.GetChannelShortcut(1)
```

### C_ChatInfo.GetChannelShortcutForChannelID

```lua
shortcut = C_ChatInfo.GetChannelShortcutForChannelID(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shortcut` | cstring | no |  |

**Example**

```lua
local shortcut = C_ChatInfo.GetChannelShortcutForChannelID(0)
```

### C_ChatInfo.GetChatLineSenderGUID

```lua
guid = C_ChatInfo.GetChatLineSenderGUID(chatLine)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Example**

```lua
local guid = C_ChatInfo.GetChatLineSenderGUID(0)
```

### C_ChatInfo.GetChatLineSenderName

```lua
name = C_ChatInfo.GetChatLineSenderName(chatLine)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example**

```lua
local name = C_ChatInfo.GetChatLineSenderName(0)
```

### C_ChatInfo.GetChatLineText

```lua
text = C_ChatInfo.GetChatLineText(chatLine)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_ChatInfo.GetChatLineText(0)
```

### C_ChatInfo.GetChatTypeName

```lua
name = C_ChatInfo.GetChatTypeName(typeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example**

```lua
local name = C_ChatInfo.GetChatTypeName(0)
```

### C_ChatInfo.GetClubStreamIDs

```lua
ids = C_ChatInfo.GetClubStreamIDs(clubID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubID` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ids` | ClubStreamId[] | no |  |

**Example**

```lua
local ids = C_ChatInfo.GetClubStreamIDs(clubID)
```

### C_ChatInfo.GetColorForChatType

```lua
color = C_ChatInfo.GetColorForChatType(chatType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatType` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | yes |  |

**Example**

```lua
local color = C_ChatInfo.GetColorForChatType("")
```

### C_ChatInfo.GetGeneralChannelID

```lua
channelID = C_ChatInfo.GetGeneralChannelID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example**

```lua
local channelID = C_ChatInfo.GetGeneralChannelID()
```

### C_ChatInfo.GetGeneralChannelLocalID

```lua
localID = C_ChatInfo.GetGeneralChannelLocalID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localID` | number | yes |  |

**Example**

```lua
local localID = C_ChatInfo.GetGeneralChannelLocalID()
```

### C_ChatInfo.GetMentorChannelID

```lua
channelID = C_ChatInfo.GetMentorChannelID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example**

```lua
local channelID = C_ChatInfo.GetMentorChannelID()
```

### C_ChatInfo.GetNumActiveChannels

```lua
numChannels = C_ChatInfo.GetNumActiveChannels()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numChannels` | number | no |  |

**Example**

```lua
local numChannels = C_ChatInfo.GetNumActiveChannels()
```

### C_ChatInfo.GetNumReservedChatWindows

```lua
numReserved = C_ChatInfo.GetNumReservedChatWindows()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numReserved` | number | no |  |

**Example**

```lua
local numReserved = C_ChatInfo.GetNumReservedChatWindows()
```

### C_ChatInfo.GetRegisteredAddonMessagePrefixes

```lua
registeredPrefixes = C_ChatInfo.GetRegisteredAddonMessagePrefixes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registeredPrefixes` | cstring[] | no |  |

**Example**

```lua
local registeredPrefixes = C_ChatInfo.GetRegisteredAddonMessagePrefixes()
```

### C_ChatInfo.InChatMessagingLockdown

Returns true if API security restrictions regarding chat messaging are in effect.

```lua
isRestricted = C_ChatInfo.InChatMessagingLockdown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRestricted` | bool | no |  |

**Example**

```lua
local isRestricted = C_ChatInfo.InChatMessagingLockdown()
```

### C_ChatInfo.IsAddonMessagePrefixRegistered

```lua
isRegistered = C_ChatInfo.IsAddonMessagePrefixRegistered(prefix)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRegistered` | bool | no |  |

**Example**

```lua
local isRegistered = C_ChatInfo.IsAddonMessagePrefixRegistered("")
```

### C_ChatInfo.IsChannelRegional

```lua
isRegional = C_ChatInfo.IsChannelRegional(channelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRegional` | bool | no |  |

**Example**

```lua
local isRegional = C_ChatInfo.IsChannelRegional(1)
```

### C_ChatInfo.IsChannelRegionalForChannelID

```lua
isRegional = C_ChatInfo.IsChannelRegionalForChannelID(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRegional` | bool | no |  |

**Example**

```lua
local isRegional = C_ChatInfo.IsChannelRegionalForChannelID(0)
```

### C_ChatInfo.IsChatLineCensored

```lua
isCensored = C_ChatInfo.IsChatLineCensored(chatLine)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCensored` | bool | no |  |

**Example**

```lua
local isCensored = C_ChatInfo.IsChatLineCensored(0)
```

### C_ChatInfo.IsLoggingChat

```lua
enabled = C_ChatInfo.IsLoggingChat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_ChatInfo.IsLoggingChat()
```

### C_ChatInfo.IsLoggingCombat

```lua
enabled, advanced = C_ChatInfo.IsLoggingCombat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |
| `advanced` | bool | no |  |

**Example**

```lua
local enabled, advanced = C_ChatInfo.IsLoggingCombat()
```

### C_ChatInfo.IsPartyChannelType

```lua
isPartyChannelType = C_ChatInfo.IsPartyChannelType(channelType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPartyChannelType` | bool | no |  |

**Example**

```lua
local isPartyChannelType = C_ChatInfo.IsPartyChannelType(channelType)
```

### C_ChatInfo.IsRegionalServiceAvailable

```lua
available = C_ChatInfo.IsRegionalServiceAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `available` | bool | no |  |

**Example**

```lua
local available = C_ChatInfo.IsRegionalServiceAvailable()
```

### C_ChatInfo.IsTimerunningPlayer

```lua
isTimerunning = C_ChatInfo.IsTimerunningPlayer(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTimerunning` | bool | no |  |

**Example**

```lua
local isTimerunning = C_ChatInfo.IsTimerunningPlayer("Creature-0-0000-0-0-0-0")
```

### C_ChatInfo.IsValidChatLine

```lua
isValid = C_ChatInfo.IsValidChatLine([chatLine])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = C_ChatInfo.IsValidChatLine()
```

### C_ChatInfo.IsValidCombatFilterName

```lua
isApproved = C_ChatInfo.IsValidCombatFilterName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApproved` | bool | no |  |

**Example**

```lua
local isApproved = C_ChatInfo.IsValidCombatFilterName("")
```

### C_ChatInfo.PerformEmote

```lua
success = C_ChatInfo.PerformEmote(emoteName, [targetName], suppressMoveError)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `emoteName` | cstring | no |  |
| `targetName` | cstring | yes |  |
| `suppressMoveError` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ChatInfo.PerformEmote("", false)
```

### C_ChatInfo.RegisterAddonMessagePrefix

Registers interest in addon messages with this prefix, cannot be an empty string.

```lua
result = C_ChatInfo.RegisterAddonMessagePrefix(prefix)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | RegisterAddonMessagePrefixResult | no |  |

**Example**

```lua
local result = C_ChatInfo.RegisterAddonMessagePrefix("")
```

### C_ChatInfo.ReplaceIconAndGroupExpressions

```lua
output = C_ChatInfo.ReplaceIconAndGroupExpressions(input, [noIconReplacement], [noGroupReplacement])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `input` | string | no |  |
| `noIconReplacement` | bool | yes |  |
| `noGroupReplacement` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `output` | string | no |  |

**Example**

```lua
local output = C_ChatInfo.ReplaceIconAndGroupExpressions("")
```

### C_ChatInfo.RequestCanLocalWhisperTarget

```lua
C_ChatInfo.RequestCanLocalWhisperTarget(whisperTarget)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `whisperTarget` | WOWGUID | no |  |

**Example**

```lua
C_ChatInfo.RequestCanLocalWhisperTarget(whisperTarget)
```

### C_ChatInfo.ResetDefaultZoneChannels

```lua
C_ChatInfo.ResetDefaultZoneChannels()
```

**Example**

```lua
C_ChatInfo.ResetDefaultZoneChannels()
```

### C_ChatInfo.SendAddonMessage

Sends a text payload to other clients specified by chatChannel and target which are registered to listen for prefix.

```lua
result = C_ChatInfo.SendAddonMessage(prefix, message, [chatType], [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `message` | cstring | no |  |
| `chatType` | cstring | yes | ChatType, defaults to SLASH_CMD_PARTY. |
| `target` | cstring | yes | Only applies for targeted channels |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendAddonMessageResult | no |  |

**Example**

```lua
local result = C_ChatInfo.SendAddonMessage("", "")
```

### C_ChatInfo.SendAddonMessageLogged

Sends a text payload to other clients specified by chatChannel and target which are registered to listen for prefix. Intended for plain text payloads; logged and throttled.

```lua
result = C_ChatInfo.SendAddonMessageLogged(prefix, message, [chatType], [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `message` | cstring | no |  |
| `chatType` | cstring | yes | ChatType, defaults to SLASH_CMD_PARTY. |
| `target` | cstring | yes | Only applies for targeted channels |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendAddonMessageResult | yes |  |

**Example**

```lua
local result = C_ChatInfo.SendAddonMessageLogged("", "")
```

### C_ChatInfo.SendCautionaryChatMessage

```lua
C_ChatInfo.SendCautionaryChatMessage(confirmNumber)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `confirmNumber` | number | no |  |

**Example**

```lua
C_ChatInfo.SendCautionaryChatMessage(0)
```

### C_ChatInfo.SendChatMessage

```lua
C_ChatInfo.SendChatMessage(message, [chatType], [languageID], [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | cstring | no |  |
| `chatType` | SendChatMessageType | yes | Chat type string ('SAY', 'EMOTE', etc.). Defaults to 'SAY' if not specified. |
| `languageID` | number | yes | Language to send the message in. |
| `target` | cstring | yes | Name of the player to send a message to. Only applies to chat types that support targeted messages. |

**Example**

```lua
C_ChatInfo.SendChatMessage("")
```

### C_ChatInfo.SwapChatChannelsByChannelIndex

```lua
C_ChatInfo.SwapChatChannelsByChannelIndex(firstChannelIndex, secondChannelIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `firstChannelIndex` | luaIndex | no |  |
| `secondChannelIndex` | luaIndex | no |  |

**Example**

```lua
C_ChatInfo.SwapChatChannelsByChannelIndex(1, 1)
```

### C_ChatInfo.UncensorChatLine

```lua
C_ChatInfo.UncensorChatLine(chatLine)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLine` | number | no |  |

**Example**

```lua
C_ChatInfo.UncensorChatLine(0)
```

## Events

### ALTERNATIVE_DEFAULT_LANGUAGE_CHANGED

### BN_CHAT_MSG_ADDON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `text` | cstring | no |  |
| `channel` | cstring | no |  |
| `senderID` | number | no |  |

### CAN_LOCAL_WHISPER_TARGET_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `whisperTarget` | WOWGUID | no |  |
| `status` | ChatWhisperTargetStatus | no |  |

### CAN_PLAYER_SPEAK_LANGUAGE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `languageId` | number | no |  |
| `canSpeakLanguage` | bool | no |  |

### CAUTIONARY_CHANNEL_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `confirmNumber` | number | no |  |

### CAUTIONARY_CHAT_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatLineID` | number | no |  |
| `confirmNumber` | number | no |  |

### CHANNEL_COUNT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | number | no |  |
| `count` | number | no |  |

### CHANNEL_FLAGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | number | no |  |

### CHANNEL_INVITE_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | cstring | no |  |
| `name` | cstring | no |  |

### CHANNEL_LEFT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatChannelID` | number | no |  |
| `name` | cstring | no |  |

### CHANNEL_PASSWORD_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | cstring | no |  |

### CHANNEL_ROSTER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | number | no |  |
| `count` | number | no |  |

### CHANNEL_UI_UPDATE

### CHAT_COMBAT_MSG_ARENA_POINTS_GAIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_LOGGING_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `whichLog` | number | no |  |
| `isEnabled` | bool | no |  |

### CHAT_MSG_ACHIEVEMENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_ADDON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `text` | cstring | no |  |
| `channel` | cstring | no |  |
| `sender` | cstring | no |  |
| `target` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `localID` | number | no |  |
| `name` | cstring | no |  |
| `instanceID` | number | no |  |

### CHAT_MSG_ADDON_LOGGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `text` | cstring | no |  |
| `channel` | cstring | no |  |
| `sender` | cstring | no |  |
| `target` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `localID` | number | no |  |
| `name` | cstring | no |  |
| `instanceID` | number | no |  |

### CHAT_MSG_AFK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BG_SYSTEM_ALLIANCE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BG_SYSTEM_HORDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BG_SYSTEM_NEUTRAL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_INLINE_TOAST_ALERT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_INLINE_TOAST_BROADCAST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_INLINE_TOAST_CONVERSATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_WHISPER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_WHISPER_INFORM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_BN_WHISPER_PLAYER_OFFLINE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL_JOIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL_LEAVE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL_LEAVE_PREVENTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelName` | cstring | no |  |

### CHAT_MSG_CHANNEL_LIST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL_NOTICE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CHANNEL_NOTICE_USER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COLLECTED_APPEARANCE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COMBAT_FACTION_CHANGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COMBAT_HONOR_GAIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COMBAT_MISC_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COMBAT_XP_GAIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_COMMUNITIES_CHANNEL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_CURRENCY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_DND

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_FILTERED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_GUILD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_GUILD_ACHIEVEMENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_GUILD_DISCORD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_GUILD_ITEM_LOOTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_IGNORED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_INSTANCE_CHAT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_INSTANCE_CHAT_LEADER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_LOOT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONEY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONSTER_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONSTER_PARTY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONSTER_SAY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONSTER_WHISPER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_MONSTER_YELL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_OFFICER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_OPENING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PARTY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PARTY_LEADER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PET_BATTLE_COMBAT_LOG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PET_BATTLE_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PET_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_PING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RAID

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RAID_BOSS_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RAID_BOSS_WHISPER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RAID_LEADER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RAID_WARNING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_RESTRICTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_SAY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_SKILL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_SYSTEM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_TARGETICONS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_TEXT_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_TRADESKILLS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_VOICE_TEXT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_WHISPER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_WHISPER_INFORM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_MSG_YELL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### CHAT_REGIONAL_SEND_FAILED

### CHAT_REGIONAL_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isServiceAvailable` | bool | no |  |

### CHAT_SERVER_DISCONNECTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInitialMessage` | bool | yes |  |

### CHAT_SERVER_RECONNECTED

### CLEAR_BOSS_EMOTES

### DAILY_RESET_INSTANCE_WELCOME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapname` | cstring | no |  |
| `timeLeft` | number | no |  |

### INSTANCE_RESET_WARNING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warningMessage` | cstring | no |  |
| `timeLeft` | number | no |  |

### LANGUAGE_LIST_CHANGED

### NOTIFY_CHAT_SUPPRESSED

### QUEST_BOSS_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `displayTime` | number | no |  |
| `enableBossEmoteWarningSound` | bool | no |  |

### RAID_BOSS_EMOTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `displayTime` | number | no |  |
| `enableBossEmoteWarningSound` | bool | no |  |

### RAID_BOSS_WHISPER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `displayTime` | number | no |  |
| `enableBossEmoteWarningSound` | bool | no |  |

### RAID_INSTANCE_WELCOME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapname` | cstring | no |  |
| `timeLeft` | number | no |  |
| `locked` | number | no |  |
| `extended` | number | no |  |

### UPDATE_CHAT_COLOR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `r` | number | no |  |
| `g` | number | no |  |
| `b` | number | no |  |

### UPDATE_CHAT_COLOR_NAME_BY_CLASS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `colorNameByClass` | bool | no |  |

### UPDATE_CHAT_WINDOWS

### UPDATE_FLOATING_CHAT_WINDOWS

## Types

### ChatMessageEventParams (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `playerName` | cstring | no |  |
| `languageName` | cstring | no |  |
| `channelName` | cstring | no |  |
| `playerName2` | cstring | no |  |
| `specialFlags` | cstring | no |  |
| `zoneChannelID` | number | no |  |
| `channelIndex` | number | no |  |
| `channelBaseName` | cstring | no |  |
| `languageID` | number | no |  |
| `lineID` | number | no |  |
| `guid` | WOWGUID | no |  |
| `bnSenderID` | number | no |  |
| `isMobile` | bool | no |  |
| `isSubtitle` | bool | no |  |
| `hideSenderInLetterbox` | bool | no |  |
| `suppressRaidIcons` | bool | no |  |
| `discordInfo` | DiscordChatInfo | no |  |

### SendChatMessageParams (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | cstring | no |  |
| `chatType` | SendChatMessageType | yes | Chat type string ('SAY', 'EMOTE', etc.). Defaults to 'SAY' if not specified. |
| `languageID` | number | yes | Language to send the message in. |
| `target` | cstring | yes | Name of the player to send a message to. Only applies to chat types that support targeted messages. |

