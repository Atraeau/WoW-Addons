# C_EventScheduler

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **1** events · **3** types

## Functions

### C_EventScheduler.CanShowEvents

Returns true if there are any events eligible to show for the player.

```lua
canShow = C_EventScheduler.CanShowEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canShow = C_EventScheduler.CanShowEvents()
```

### C_EventScheduler.ClearReminder

Clears reminder on a scheduled event. Must use endTime to identify which specific instance in the case of repeating ones.

```lua
C_EventScheduler.ClearReminder(eventKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventKey` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EventScheduler.ClearReminder("")
```

### C_EventScheduler.GetActiveContinentName

Returns the name of the continent with current events

```lua
name = C_EventScheduler.GetActiveContinentName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_EventScheduler.GetActiveContinentName()
```

### C_EventScheduler.GetEventUiMapID

Will try to figure out a UiMap for an areaPOI.

```lua
uiMapID = C_EventScheduler.GetEventUiMapID(areaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapID = C_EventScheduler.GetEventUiMapID(0)
```

### C_EventScheduler.GetEventZoneName

Will try to figure out a map zone name for an areaPOI

```lua
name = C_EventScheduler.GetEventZoneName(areaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_EventScheduler.GetEventZoneName(0)
```

### C_EventScheduler.GetOngoingEvents

Will request data from the server on a throttle

```lua
events = C_EventScheduler.GetOngoingEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | OngoingEventInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local events = C_EventScheduler.GetOngoingEvents()
```

### C_EventScheduler.GetScheduledEvents

Will request data from the server on a throttle

```lua
events = C_EventScheduler.GetScheduledEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | ScheduledEventInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local events = C_EventScheduler.GetScheduledEvents()
```

### C_EventScheduler.HasData

True if the server sent a list, even if the list had 0 events.

```lua
hasData = C_EventScheduler.HasData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasData` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasData = C_EventScheduler.HasData()
```

### C_EventScheduler.HasSavedReminders

Returns whether there are any event reminders saved. Can include reminders that have expired since set and haven't gotten removed yet. Has to be called after cvars are loaded.

```lua
hasSavedReminders = C_EventScheduler.HasSavedReminders()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSavedReminders` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSavedReminders = C_EventScheduler.HasSavedReminders()
```

### C_EventScheduler.RequestEvents

Requests events from the server, subject to throttle

```lua
C_EventScheduler.RequestEvents()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EventScheduler.RequestEvents()
```

### C_EventScheduler.SetReminder

Sets reminder on a scheduled event. Must use endTime to identify which specific instance in the case of repeating ones.

```lua
C_EventScheduler.SetReminder(eventKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventKey` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EventScheduler.SetReminder("")
```

## Events

### EVENT_SCHEDULER_UPDATE

## Types

### EventDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hideTimeLeft` | bool | no | (default: False) |
| `hideDescription` | bool | no | (default: False) |
| `overrideAtlas` | textureAtlas | yes |  |
| `overrideTooltipWidgetSetID` | number | yes |  |

### OngoingEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `rewardsClaimed` | bool | no | (default: False) |
| `displayInfo` | EventDisplayInfo | no |  |

### ScheduledEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventKey` | string | no |  |
| `eventID` | number | no |  |
| `areaPoiID` | number | no |  |
| `startTime` | time_t | no |  |
| `endTime` | time_t | no |  |
| `duration` | time_t | no |  |
| `hasReminder` | bool | no | (default: False) |
| `rewardsClaimed` | bool | no | (default: False) |
| `displayInfo` | EventDisplayInfo | no |  |

