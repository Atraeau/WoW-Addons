# C_EncounterTimeline

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**34** functions · **11** events · **4** types

## Functions

### C_EncounterTimeline.AddEditModeEvents

Adds a predefined set of events to the timeline for display in Edit Mode.

```lua
loopTimerDuration = C_EncounterTimeline.AddEditModeEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loopTimerDuration` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loopTimerDuration = C_EncounterTimeline.AddEditModeEvents()
```

### C_EncounterTimeline.AddScriptEvent

Adds a custom event to the timeline.

```lua
eventID = C_EncounterTimeline.AddScriptEvent(eventInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventInfo` | EncounterTimelineScriptEventRequest | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local eventID = C_EncounterTimeline.AddScriptEvent(eventInfo)
```

### C_EncounterTimeline.CancelAllScriptEvents

Cancels all custom timeline events, removing them from the timeline.

```lua
C_EncounterTimeline.CancelAllScriptEvents()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.CancelAllScriptEvents()
```

### C_EncounterTimeline.CancelEditModeEvents

Removes all Edit Mode events from the timeline.

```lua
C_EncounterTimeline.CancelEditModeEvents()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.CancelEditModeEvents()
```

### C_EncounterTimeline.CancelScriptEvent

Cancels a custom timeline event, removing it from the timeline.

```lua
C_EncounterTimeline.CancelScriptEvent(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.CancelScriptEvent(eventID)
```

### C_EncounterTimeline.FinishScriptEvent

Finishes a custom timeline event, removing it from the timeline.

```lua
C_EncounterTimeline.FinishScriptEvent(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.FinishScriptEvent(eventID)
```

### C_EncounterTimeline.GetCurrentTime

Returns the current timestamp used for rendering the timeline display.

```lua
currentTime = C_EncounterTimeline.GetCurrentTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentTime` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentTime = C_EncounterTimeline.GetCurrentTime()
```

### C_EncounterTimeline.GetEventColor

Returns the current color used to render timeline event.

```lua
color = C_EncounterTimeline.GetEventColor(eventID, [overrideTrigger])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |
| `overrideTrigger` | EncounterEventColorTrigger | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local color = C_EncounterTimeline.GetEventColor(eventID)
```

### C_EncounterTimeline.GetEventCountBySource

Returns the number of present events in the timeline by their source type.

```lua
count = C_EncounterTimeline.GetEventCountBySource(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | EncounterTimelineEventSource | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_EncounterTimeline.GetEventCountBySource(source)
```

### C_EncounterTimeline.GetEventHighlightTime

Returns the duration at which timeline events will be highlighted for imminency.

```lua
highlightTime = C_EncounterTimeline.GetEventHighlightTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `highlightTime` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local highlightTime = C_EncounterTimeline.GetEventHighlightTime()
```

### C_EncounterTimeline.GetEventInfo

Returns information about a timeline event. This data is generally expected to be static for the lifetime of an event.

```lua
info = C_EncounterTimeline.GetEventInfo(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | EncounterTimelineEventInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_EncounterTimeline.GetEventInfo(eventID)
```

### C_EncounterTimeline.GetEventList

Returns an unsorted list of event IDs present in the timeline.

```lua
events = C_EncounterTimeline.GetEventList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | EncounterTimelineEventID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local events = C_EncounterTimeline.GetEventList()
```

### C_EncounterTimeline.GetEventState

Returns the current state of a timeline event.

```lua
state = C_EncounterTimeline.GetEventState(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | EncounterTimelineEventState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_EncounterTimeline.GetEventState(eventID)
```

### C_EncounterTimeline.GetEventTimeElapsed

Returns the elapsed duration of a timeline event.

```lua
timeElapsed = C_EncounterTimeline.GetEventTimeElapsed(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeElapsed` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeElapsed = C_EncounterTimeline.GetEventTimeElapsed(eventID)
```

### C_EncounterTimeline.GetEventTimer

Returns a Duration object that tracks the elapsed duration of a timeline event. This object tracks the range [0, duration] of the event and automatically pauses its progression based on event state.

```lua
duration = C_EncounterTimeline.GetEventTimer(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_EncounterTimeline.GetEventTimer(eventID)
```

### C_EncounterTimeline.GetEventTimeRemaining

Returns the remaining duration of a timeline event.

```lua
timeRemaining = C_EncounterTimeline.GetEventTimeRemaining(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeRemaining` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeRemaining = C_EncounterTimeline.GetEventTimeRemaining(eventID)
```

### C_EncounterTimeline.GetEventTrack

Returns information about the position of an event on the timeline.

```lua
track, trackSortIndex = C_EncounterTimeline.GetEventTrack(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `track` | EncounterTimelineTrack | no |  |
| `trackSortIndex` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local track, trackSortIndex = C_EncounterTimeline.GetEventTrack(eventID)
```

### C_EncounterTimeline.GetSortedEventList

Returns a sorted list of event IDs present in the timeline from shortest to longest remaining durations, meeting the requirements of the specified filters.

```lua
events = C_EncounterTimeline.GetSortedEventList([maxEventCount], [maxEventDuration], excludeTerminalStates, excludeHiddenEvents)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxEventCount` | number | yes | Maximum number of sorted events to return. |
| `maxEventDuration` | Seconds | yes | Maximum duration of sorted events to return. |
| `excludeTerminalStates` | bool | no | If false, include events that are terminal states such as Canceled or Finished. (default: True) |
| `excludeHiddenEvents` | bool | no | If false, include events that should be hidden by user configuration, such as events on long tracks when the user has opted to not show long countdowns. (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | EncounterTimelineEventID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local events = C_EncounterTimeline.GetSortedEventList(false, false)
```

### C_EncounterTimeline.GetTrackInfo

Returns information for a single timeline track.

```lua
trackInfo = C_EncounterTimeline.GetTrackInfo(track)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `track` | EncounterTimelineTrack | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackInfo` | EncounterTimelineTrackInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackInfo = C_EncounterTimeline.GetTrackInfo(track)
```

### C_EncounterTimeline.GetTrackList

Returns information about all timeline tracks.

```lua
tracks = C_EncounterTimeline.GetTrackList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tracks` | EncounterTimelineTrackInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tracks = C_EncounterTimeline.GetTrackList()
```

### C_EncounterTimeline.GetTrackMaxEventDuration

Returns the maximum permitted event duration on a single timeline track.

```lua
maxEventDuration = C_EncounterTimeline.GetTrackMaxEventDuration(track)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `track` | EncounterTimelineTrack | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxEventDuration` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxEventDuration = C_EncounterTimeline.GetTrackMaxEventDuration(track)
```

### C_EncounterTimeline.GetTrackType

Returns the type of a single timeline track.

```lua
trackType = C_EncounterTimeline.GetTrackType(track)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `track` | EncounterTimelineTrack | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackType` | EncounterTimelineTrackType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackType = C_EncounterTimeline.GetTrackType(track)
```

### C_EncounterTimeline.GetViewType

Returns the current view type of the timeline.

```lua
viewType = C_EncounterTimeline.GetViewType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `viewType` | EncounterTimelineViewType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local viewType = C_EncounterTimeline.GetViewType()
```

### C_EncounterTimeline.HasActiveEvents

Returns true if the timeline contains any events in the active state.

```lua
hasActiveEvents = C_EncounterTimeline.HasActiveEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasActiveEvents` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasActiveEvents = C_EncounterTimeline.HasActiveEvents()
```

### C_EncounterTimeline.HasAnyEvents

Returns true if the timeline contains any events in any state.

```lua
hasAnyEvents = C_EncounterTimeline.HasAnyEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyEvents` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnyEvents = C_EncounterTimeline.HasAnyEvents()
```

### C_EncounterTimeline.HasPausedEvents

Returns true if the timeline contains any events in the paused state.

```lua
hasPausedEvents = C_EncounterTimeline.HasPausedEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPausedEvents` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPausedEvents = C_EncounterTimeline.HasPausedEvents()
```

### C_EncounterTimeline.HasVisibleEvents

Returns true if the timeline contains any events that are on visible tracks.

```lua
hasVisibleEvents = C_EncounterTimeline.HasVisibleEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasVisibleEvents` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasVisibleEvents = C_EncounterTimeline.HasVisibleEvents()
```

### C_EncounterTimeline.IsEventBlocked

Returns true if the event is in a 'blocked' state, where the cast for this event may not occur due to encounter conditions not being met.

```lua
blocked = C_EncounterTimeline.IsEventBlocked(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local blocked = C_EncounterTimeline.IsEventBlocked(eventID)
```

### C_EncounterTimeline.IsFeatureAvailable

Returns true if the encounter timeline feature is available on this client.

```lua
isAvailable = C_EncounterTimeline.IsFeatureAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailable = C_EncounterTimeline.IsFeatureAvailable()
```

### C_EncounterTimeline.IsFeatureEnabled

Returns true if the encounter timeline feature has been enabled by the player. This function will always return false if the feature is not available.

```lua
isAvailableAndEnabled = C_EncounterTimeline.IsFeatureEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailableAndEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailableAndEnabled = C_EncounterTimeline.IsFeatureEnabled()
```

### C_EncounterTimeline.PauseScriptEvent

Pauses a custom timeline event, hiding it from the timeline. A paused event can later be resumed to show it again, or canceled.

```lua
C_EncounterTimeline.PauseScriptEvent(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.PauseScriptEvent(eventID)
```

### C_EncounterTimeline.ResumeScriptEvent

Resumes a custom timeline event, showing it on the timeline again if it is currently paused.

```lua
C_EncounterTimeline.ResumeScriptEvent(eventID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.ResumeScriptEvent(eventID)
```

### C_EncounterTimeline.SetEventIconTextures

Updates a given vector of texture objects to reference art assets for icons associated with an event.

```lua
C_EncounterTimeline.SetEventIconTextures(eventID, includeIcons, textures)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |
| `includeIcons` | EncounterEventIconmask | no | Mask to apply to candidate icons. Any icon bits not present in this set will not be assigned to textures. |
| `textures` | SimpleTexture[] | no | Array of texture objects to update. This will change the assigned atlases and alpha values of the region, applying secret aspects to protect the data. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.SetEventIconTextures(eventID, includeIcons, textures)
```

### C_EncounterTimeline.SetViewType

Changes the view type for the timeline. This adjusts track layouts to be more appropriate for a specific mode and optimizes event processing.

```lua
C_EncounterTimeline.SetViewType(viewType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `viewType` | EncounterTimelineViewType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EncounterTimeline.SetViewType(viewType)
```

## Events

### ENCOUNTER_TIMELINE_EVENT_ADDED

Fired when an event has been added to the timeline.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventInfo` | EncounterTimelineEventInfo | no |  |

### ENCOUNTER_TIMELINE_EVENT_BLOCK_STATE_CHANGED

Fired when an event has transitioned into or out of a 'blocked' status.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_EVENT_COLOR_CHANGED

Fired when an event has met a condition that should trigger a color change.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_EVENT_HIGHLIGHT

Fired when an event has met a condition that should trigger its highlight glow animation.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_EVENT_REMOVED

Fired when an event has been removed from the timeline. This is guaranteed to fire after an event has transitioned to a 'final' state such as Canceled or Finished, and will be delayed at least one game tick to allow for API queries to still access event data in OnUpdate scripts. This is fired post-removal of the event, and so queries using the supplied event ID will return nil.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED

Fired when an event has changed state.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_EVENT_TRACK_CHANGED

Fired when an event has changed track, or has been re-ordered within its existing track.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | EncounterTimelineEventID | no |  |

### ENCOUNTER_TIMELINE_LAYOUT_UPDATED

Fired when the layout of tracks on the timeline has been updated. This can include changes to the minimum or maximum durations of tracks.

### ENCOUNTER_TIMELINE_STATE_UPDATED

Signaled when conditions controlling the visibility of the encounter timeline are updated.

### ENCOUNTER_TIMELINE_VIEW_ACTIVATED

Fired when a new timeline view is being activated. This is fired after a full layout and timeline data update, allowing the UI to immediately query the API and get usable results.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `viewType` | EncounterTimelineViewType | no |  |

### ENCOUNTER_TIMELINE_VIEW_DEACTIVATED

Fired when the current timeline view is being deactivated. The UI should clear all stored timeline event data and release all frames back to pools during this event.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `viewType` | EncounterTimelineViewType | no |  |

## Types

### EncounterTimelineEventFilter (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxEventCount` | number | yes | Maximum number of sorted events to return. |
| `maxEventDuration` | Seconds | yes | Maximum duration of sorted events to return. |
| `excludeTerminalStates` | bool | no | If false, include events that are terminal states such as Canceled or Finished. (default: True) |
| `excludeHiddenEvents` | bool | no | If false, include events that should be hidden by user configuration, such as events on long tracks when the user has opted to not show long countdowns. (default: True) |

### EncounterTimelineEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | EncounterTimelineEventID | no | Instance ID for this event. |
| `source` | EncounterTimelineEventSource | no | Source that this event came from. |
| `spellName` | string | no | Spell name associated with this event. For script events, this may instead be the contents of the 'overrideName' field if it wasn't empty. |
| `spellID` | number | no | Spell ID associated with this event. |
| `iconFileID` | fileID | no | Icon file ID associated with this event. |
| `duration` | Seconds | no | Base duration of this event at the point that it was queued onto the timeline. |
| `maxQueueDuration` | Seconds | no | Hold duration for this event after it reaches the end of the timeline. During this period, the event will sit in the queued track of the timeline until manually finished or this added duration expires. |
| `icons` | EncounterEventIconmask | no | Bitmask of active icon states for this event. |
| `severity` | EncounterEventSeverity | no | Severity of this event. |
| `isApproximate` | bool | no | If true, this event is an approximation and may not occur exactly when the timeline suggests it will. |

### EncounterTimelineScriptEventRequest (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `iconFileID` | fileID | no |  |
| `duration` | Seconds | no |  |
| `maxQueueDuration` | Seconds | no | (default: 0) |
| `overrideName` | stringView | no |  |
| `icons` | EncounterEventIconmask | yes |  |
| `severity` | EncounterEventSeverity | no | (default: Medium) |
| `paused` | bool | no | (default: False) |

### EncounterTimelineTrackInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | EncounterTimelineTrack | no |  |
| `type` | EncounterTimelineTrackType | no |  |
| `minimumDuration` | Seconds | yes | The exclusive lower bound of durations for events on this track. If zero, this should be treated as an inclusive lower bound. This bound is ignored by the timeline sequence in circumstances where an adjacent Sorted track would exceed its maximum event count, requiring events be pushed 'to the left' by one track. |
| `maximumDuration` | Seconds | yes | The inclusive upper bound of durations for events on this track. |
| `minimumEventIntroDuration` | Seconds | yes | Lower duration bound for events that want to transition onto this track from an Indeterminate position. Events below this duration are artificially kept in the indeterminate track state until they can transition into a later track in the timeline sequence. |
| `minimumEventGapDuration` | Seconds | yes | Minimum duration gap that must exist between two sequential candidate events for this track. If two event durations have a distance under this figure, the later of the two events will be artifically kept in the indeterminate track state until it can transition into a later track in the timeline sequence. |
| `maximumEventCount` | number | yes | The maximum number of events permitted within this track. This only applies to Sorted tracks. |
| `sortDirection` | EncounterTimelineEventSortDirection | yes | Sort ordering for events within this track. This only applies to Sorted tracks. |

