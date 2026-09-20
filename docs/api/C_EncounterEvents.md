# C_EncounterEvents

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **0** events · **0** types

## Functions

### C_EncounterEvents.GetEventColor

Returns any custom color override applied for an encounter event.

```lua
color = C_EncounterEvents.GetEventColor(encounterEventID, trigger)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |
| `trigger` | EncounterEventColorTrigger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | yes |  |

**Example**

```lua
local color = C_EncounterEvents.GetEventColor(0, trigger)
```

### C_EncounterEvents.GetEventInfo

Returns information about an encounter event.

```lua
encounterEventInfo = C_EncounterEvents.GetEventInfo(encounterEventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventInfo` | EncounterEventInfo | no |  |

**Example**

```lua
local encounterEventInfo = C_EncounterEvents.GetEventInfo(0)
```

### C_EncounterEvents.GetEventList

Returns a list of all encounter event IDs.

```lua
encounterEventIDs = C_EncounterEvents.GetEventList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventIDs` | number[] | no |  |

**Example**

```lua
local encounterEventIDs = C_EncounterEvents.GetEventList()
```

### C_EncounterEvents.GetEventSound

Returns information on a custom sound file to be played when an encounter event trigger occurs.

```lua
sound = C_EncounterEvents.GetEventSound(encounterEventID, trigger)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |
| `trigger` | EncounterEventSoundTrigger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sound` | EncounterEventSoundInfo | no |  |

**Example**

```lua
local sound = C_EncounterEvents.GetEventSound(0, trigger)
```

### C_EncounterEvents.HasEventInfo

Returns true if an encounter event record with a specified ID exists.

```lua
exists = C_EncounterEvents.HasEventInfo(encounterEventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exists` | bool | no |  |

**Example**

```lua
local exists = C_EncounterEvents.HasEventInfo(0)
```

### C_EncounterEvents.PlayEventSound

Plays any registered custom sound file for a given encounter event trigger.

```lua
handle = C_EncounterEvents.PlayEventSound(encounterEventID, trigger)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |
| `trigger` | EncounterEventSoundTrigger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `handle` | SoundHandle | no |  |

**Example**

```lua
local handle = C_EncounterEvents.PlayEventSound(0, trigger)
```

### C_EncounterEvents.SetEventColor

Sets a custom color override for an encounter event. This can be used to colorize text or timer bars individually.

```lua
C_EncounterEvents.SetEventColor(encounterEventID, trigger, [color])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |
| `trigger` | EncounterEventColorTrigger | no |  |
| `color` | colorRGBA | yes |  |

**Example**

```lua
C_EncounterEvents.SetEventColor(0, trigger)
```

### C_EncounterEvents.SetEventSound

Sets a custom sound file to be played when an encounter event trigger occurs.

```lua
C_EncounterEvents.SetEventSound(encounterEventID, trigger, [sound])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterEventID` | number | no |  |
| `trigger` | EncounterEventSoundTrigger | no |  |
| `sound` | EncounterEventSoundInfo | yes |  |

**Example**

```lua
C_EncounterEvents.SetEventSound(0, trigger)
```

