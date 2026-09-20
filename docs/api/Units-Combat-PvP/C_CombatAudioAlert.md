# C_CombatAudioAlert

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**16** functions · **0** events · **0** types

## Functions

### C_CombatAudioAlert.AddToKnownTargetingList

```lua
added = C_CombatAudioAlert.AddToKnownTargetingList(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `added` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local added = C_CombatAudioAlert.AddToKnownTargetingList("player")
```

### C_CombatAudioAlert.GetCategoryVoice

```lua
voice = C_CombatAudioAlert.GetCategoryVoice(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | CombatAudioAlertCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voice` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local voice = C_CombatAudioAlert.GetCategoryVoice(category)
```

### C_CombatAudioAlert.GetCategoryVolume

```lua
volume = C_CombatAudioAlert.GetCategoryVolume(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | CombatAudioAlertCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local volume = C_CombatAudioAlert.GetCategoryVolume(category)
```

### C_CombatAudioAlert.GetFormatSetting

```lua
formatVal = C_CombatAudioAlert.GetFormatSetting(unit, alertType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | CombatAudioAlertUnit | no |  |
| `alertType` | CombatAudioAlertType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatVal` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local formatVal = C_CombatAudioAlert.GetFormatSetting("player", alertType)
```

### C_CombatAudioAlert.GetSpeakerSpeed

```lua
speed = C_CombatAudioAlert.GetSpeakerSpeed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speed` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local speed = C_CombatAudioAlert.GetSpeakerSpeed()
```

### C_CombatAudioAlert.GetSpecSetting

```lua
value = C_CombatAudioAlert.GetSpecSetting(setting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | CombatAudioAlertSpecSetting | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_CombatAudioAlert.GetSpecSetting(setting)
```

### C_CombatAudioAlert.GetThrottle

```lua
throttle = C_CombatAudioAlert.GetThrottle(throttleType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `throttleType` | CombatAudioAlertThrottle | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `throttle` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local throttle = C_CombatAudioAlert.GetThrottle(throttleType)
```

### C_CombatAudioAlert.IsEnabled

```lua
isEnabled = C_CombatAudioAlert.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_CombatAudioAlert.IsEnabled()
```

### C_CombatAudioAlert.RemoveFromKnownTargetingList

```lua
removed = C_CombatAudioAlert.RemoveFromKnownTargetingList(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local removed = C_CombatAudioAlert.RemoveFromKnownTargetingList("player")
```

### C_CombatAudioAlert.SetCategoryVoice

```lua
success = C_CombatAudioAlert.SetCategoryVoice(category, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | CombatAudioAlertCategory | no |  |
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetCategoryVoice(category, 0)
```

### C_CombatAudioAlert.SetCategoryVolume

```lua
success = C_CombatAudioAlert.SetCategoryVolume(category, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | CombatAudioAlertCategory | no |  |
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetCategoryVolume(category, 0)
```

### C_CombatAudioAlert.SetFormatSetting

```lua
success = C_CombatAudioAlert.SetFormatSetting(unit, alertType, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | CombatAudioAlertUnit | no |  |
| `alertType` | CombatAudioAlertType | no |  |
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetFormatSetting("player", alertType, 0)
```

### C_CombatAudioAlert.SetSpeakerSpeed

```lua
success = C_CombatAudioAlert.SetSpeakerSpeed(newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetSpeakerSpeed(0)
```

### C_CombatAudioAlert.SetSpecSetting

```lua
success = C_CombatAudioAlert.SetSpecSetting(setting, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | CombatAudioAlertSpecSetting | no |  |
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetSpecSetting(setting, 0)
```

### C_CombatAudioAlert.SetThrottle

```lua
success = C_CombatAudioAlert.SetThrottle(throttleType, newVal)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `throttleType` | CombatAudioAlertThrottle | no |  |
| `newVal` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_CombatAudioAlert.SetThrottle(throttleType, 0)
```

### C_CombatAudioAlert.SpeakText

```lua
utteranceID = C_CombatAudioAlert.SpeakText(text, category, allowOverlap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `category` | CombatAudioAlertCategory | no |  |
| `allowOverlap` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `utteranceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local utteranceID = C_CombatAudioAlert.SpeakText("", category, false)
```

