# C_EncounterWarnings

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **1** events · **1** types

## Functions

### C_EncounterWarnings.GetColorForSeverity

```lua
color = C_EncounterWarnings.GetColorForSeverity(severity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `severity` | EncounterEventSeverity | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |

**Example**

```lua
local color = C_EncounterWarnings.GetColorForSeverity(severity)
```

### C_EncounterWarnings.GetEditModeWarningInfo

```lua
warningInfo = C_EncounterWarnings.GetEditModeWarningInfo(severity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `severity` | EncounterEventSeverity | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warningInfo` | EncounterWarningInfo | no |  |

**Example**

```lua
local warningInfo = C_EncounterWarnings.GetEditModeWarningInfo(severity)
```

### C_EncounterWarnings.GetPlayCustomSoundsWhenHidden

Returns true if custom sound alerts are allowed to play for hidden warning messages.

```lua
play = C_EncounterWarnings.GetPlayCustomSoundsWhenHidden()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `play` | bool | no |  |

**Example**

```lua
local play = C_EncounterWarnings.GetPlayCustomSoundsWhenHidden()
```

### C_EncounterWarnings.GetSoundKitForSeverity

```lua
soundKitID = C_EncounterWarnings.GetSoundKitForSeverity(severity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `severity` | EncounterEventSeverity | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundKitID` | number | no |  |

**Example**

```lua
local soundKitID = C_EncounterWarnings.GetSoundKitForSeverity(severity)
```

### C_EncounterWarnings.GetWarningsShown

Returns true if text messages for encounter events are allowed to be shown.

```lua
shown = C_EncounterWarnings.GetWarningsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no |  |

**Example**

```lua
local shown = C_EncounterWarnings.GetWarningsShown()
```

### C_EncounterWarnings.IsFeatureAvailable

```lua
isAvailable = C_EncounterWarnings.IsFeatureAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example**

```lua
local isAvailable = C_EncounterWarnings.IsFeatureAvailable()
```

### C_EncounterWarnings.IsFeatureEnabled

```lua
isAvailableAndEnabled = C_EncounterWarnings.IsFeatureEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailableAndEnabled` | bool | no |  |

**Example**

```lua
local isAvailableAndEnabled = C_EncounterWarnings.IsFeatureEnabled()
```

### C_EncounterWarnings.PlaySound

```lua
soundHandle = C_EncounterWarnings.PlaySound(severity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `severity` | EncounterEventSeverity | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundHandle` | number | no |  |

**Example**

```lua
local soundHandle = C_EncounterWarnings.PlaySound(severity)
```

### C_EncounterWarnings.SetPlayCustomSoundsWhenHidden

Controls whether custom sound alerts for encounter events are allowed to play for warning messages that are hidden.

```lua
C_EncounterWarnings.SetPlayCustomSoundsWhenHidden(play)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `play` | bool | no | If true, allow playing custom sound alerts. Note that sound alerts will not be played if the encounter warnings feature has been disabled. |

**Example**

```lua
C_EncounterWarnings.SetPlayCustomSoundsWhenHidden(false)
```

### C_EncounterWarnings.SetWarningsShown

Controls whether text messages for encounter events are allowed to be shown.

```lua
C_EncounterWarnings.SetWarningsShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no | If false, hides all warning messages in the default UI. |

**Example**

```lua
C_EncounterWarnings.SetWarningsShown(false)
```

## Events

### ENCOUNTER_WARNING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterWarningInfo` | EncounterWarningInfo | no |  |

## Types

### EncounterWarningInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `casterGUID` | WOWGUID | no |  |
| `casterName` | cstring | no |  |
| `targetGUID` | WOWGUID | no |  |
| `targetName` | cstring | no |  |
| `iconFileID` | number | no |  |
| `tooltipSpellID` | number | no |  |
| `isDeadly` | bool | no |  |
| `color` | colorRGBA | no |  |
| `duration` | Seconds | no |  |
| `severity` | EncounterEventSeverity | no |  |
| `shouldPlaySound` | bool | no |  |
| `shouldShowChatMessage` | bool | no |  |
| `shouldShowWarning` | bool | no |  |

