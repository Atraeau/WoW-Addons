# C_TTSSettings

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**19** functions · **0** events · **0** types

## Functions

### C_TTSSettings.GetChannelEnabled

```lua
enabled = C_TTSSettings.GetChannelEnabled(channelInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelInfo` | ChatChannelInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_TTSSettings.GetChannelEnabled(channelInfo)
```

### C_TTSSettings.GetCharacterSettingsSaved

```lua
settingsBeenSaved = C_TTSSettings.GetCharacterSettingsSaved()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `settingsBeenSaved` | bool | no |  |

**Example**

```lua
local settingsBeenSaved = C_TTSSettings.GetCharacterSettingsSaved()
```

### C_TTSSettings.GetChatTypeEnabled

```lua
enabled = C_TTSSettings.GetChatTypeEnabled(chatName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_TTSSettings.GetChatTypeEnabled("")
```

### C_TTSSettings.GetSetting

```lua
enabled = C_TTSSettings.GetSetting(setting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | TtsBoolSetting | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_TTSSettings.GetSetting(setting)
```

### C_TTSSettings.GetSpeechRate

```lua
rate = C_TTSSettings.GetSpeechRate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rate` | number | no |  |

**Example**

```lua
local rate = C_TTSSettings.GetSpeechRate()
```

### C_TTSSettings.GetSpeechVolume

```lua
volume = C_TTSSettings.GetSpeechVolume()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | no |  |

**Example**

```lua
local volume = C_TTSSettings.GetSpeechVolume()
```

### C_TTSSettings.GetVoiceOptionID

```lua
voiceID = C_TTSSettings.GetVoiceOptionID(voiceType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceType` | TtsVoiceType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceID` | number | no |  |

**Example**

```lua
local voiceID = C_TTSSettings.GetVoiceOptionID(voiceType)
```

### C_TTSSettings.GetVoiceOptionName

```lua
voiceName = C_TTSSettings.GetVoiceOptionName(voiceType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceType` | TtsVoiceType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceName` | cstring | no |  |

**Example**

```lua
local voiceName = C_TTSSettings.GetVoiceOptionName(voiceType)
```

### C_TTSSettings.MarkCharacterSettingsSaved

```lua
C_TTSSettings.MarkCharacterSettingsSaved()
```

**Example**

```lua
C_TTSSettings.MarkCharacterSettingsSaved()
```

### C_TTSSettings.SetChannelEnabled

```lua
C_TTSSettings.SetChannelEnabled(channelInfo, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelInfo` | ChatChannelInfo | no |  |
| `newVal` | bool | no | (default: False) |

**Example**

```lua
C_TTSSettings.SetChannelEnabled(channelInfo, false)
```

### C_TTSSettings.SetChannelKeyEnabled

```lua
C_TTSSettings.SetChannelKeyEnabled(channelKey, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelKey` | string | no |  |
| `newVal` | bool | no | (default: False) |

**Example**

```lua
C_TTSSettings.SetChannelKeyEnabled("", false)
```

### C_TTSSettings.SetChatTypeEnabled

```lua
C_TTSSettings.SetChatTypeEnabled(chatName, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatName` | cstring | no |  |
| `newVal` | bool | no | (default: False) |

**Example**

```lua
C_TTSSettings.SetChatTypeEnabled("", false)
```

### C_TTSSettings.SetDefaultSettings

```lua
C_TTSSettings.SetDefaultSettings()
```

**Example**

```lua
C_TTSSettings.SetDefaultSettings()
```

### C_TTSSettings.SetSetting

```lua
C_TTSSettings.SetSetting(setting, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | TtsBoolSetting | no |  |
| `newVal` | bool | no | (default: False) |

**Example**

```lua
C_TTSSettings.SetSetting(setting, false)
```

### C_TTSSettings.SetSpeechRate

```lua
C_TTSSettings.SetSpeechRate(newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newVal` | number | no |  |

**Example**

```lua
C_TTSSettings.SetSpeechRate(0)
```

### C_TTSSettings.SetSpeechVolume

```lua
C_TTSSettings.SetSpeechVolume(newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newVal` | number | no |  |

**Example**

```lua
C_TTSSettings.SetSpeechVolume(0)
```

### C_TTSSettings.SetVoiceOption

```lua
C_TTSSettings.SetVoiceOption(voiceType, voiceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceType` | TtsVoiceType | no |  |
| `voiceID` | number | no |  |

**Example**

```lua
C_TTSSettings.SetVoiceOption(voiceType, 0)
```

### C_TTSSettings.SetVoiceOptionName

```lua
C_TTSSettings.SetVoiceOptionName(voiceType, voiceName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceType` | TtsVoiceType | no |  |
| `voiceName` | string | no |  |

**Example**

```lua
C_TTSSettings.SetVoiceOptionName(voiceType, "")
```

### C_TTSSettings.ShouldOverrideMessage

```lua
overrideMessage = C_TTSSettings.ShouldOverrideMessage(language, messageText)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `language` | number | no |  |
| `messageText` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideMessage` | bool | no |  |

**Example**

```lua
local overrideMessage = C_TTSSettings.ShouldOverrideMessage(0, "")
```

