# C_Calendar

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**90** functions · **13** events · **12** types

## Functions

### C_Calendar.AddEvent

```lua
C_Calendar.AddEvent()
```

**Example**

```lua
C_Calendar.AddEvent()
```

### C_Calendar.AreNamesReady

```lua
ready = C_Calendar.AreNamesReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ready` | bool | no |  |

**Example**

```lua
local ready = C_Calendar.AreNamesReady()
```

### C_Calendar.CanAddEvent

```lua
canAddEvent = C_Calendar.CanAddEvent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAddEvent` | bool | no |  |

**Example**

```lua
local canAddEvent = C_Calendar.CanAddEvent()
```

### C_Calendar.CanSendInvite

```lua
canSendInvite = C_Calendar.CanSendInvite()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSendInvite` | bool | no |  |

**Example**

```lua
local canSendInvite = C_Calendar.CanSendInvite()
```

### C_Calendar.CloseEvent

```lua
C_Calendar.CloseEvent()
```

**Example**

```lua
C_Calendar.CloseEvent()
```

### C_Calendar.ContextMenuEventCanComplain

```lua
canComplain = C_Calendar.ContextMenuEventCanComplain(offsetMonths, monthDay, eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canComplain` | bool | no |  |

**Example**

```lua
local canComplain = C_Calendar.ContextMenuEventCanComplain(0, monthDay, 1)
```

### C_Calendar.ContextMenuEventCanEdit

```lua
canEdit = C_Calendar.ContextMenuEventCanEdit(offsetMonths, monthDay, eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEdit` | bool | no |  |

**Example**

```lua
local canEdit = C_Calendar.ContextMenuEventCanEdit(0, monthDay, 1)
```

### C_Calendar.ContextMenuEventCanRemove

```lua
canRemove = C_Calendar.ContextMenuEventCanRemove(offsetMonths, monthDay, eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRemove` | bool | no |  |

**Example**

```lua
local canRemove = C_Calendar.ContextMenuEventCanRemove(0, monthDay, 1)
```

### C_Calendar.ContextMenuEventClipboard

```lua
exists = C_Calendar.ContextMenuEventClipboard()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exists` | bool | no |  |

**Example**

```lua
local exists = C_Calendar.ContextMenuEventClipboard()
```

### C_Calendar.ContextMenuEventCopy

```lua
C_Calendar.ContextMenuEventCopy()
```

**Example**

```lua
C_Calendar.ContextMenuEventCopy()
```

### C_Calendar.ContextMenuEventGetCalendarType

```lua
calendarType = C_Calendar.ContextMenuEventGetCalendarType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `calendarType` | string | yes |  |

**Example**

```lua
local calendarType = C_Calendar.ContextMenuEventGetCalendarType()
```

### C_Calendar.ContextMenuEventPaste

```lua
C_Calendar.ContextMenuEventPaste(offsetMonths, monthDay)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |

**Example**

```lua
C_Calendar.ContextMenuEventPaste(0, monthDay)
```

### C_Calendar.ContextMenuEventRemove

```lua
C_Calendar.ContextMenuEventRemove()
```

**Example**

```lua
C_Calendar.ContextMenuEventRemove()
```

### C_Calendar.ContextMenuEventSignUp

```lua
C_Calendar.ContextMenuEventSignUp()
```

**Example**

```lua
C_Calendar.ContextMenuEventSignUp()
```

### C_Calendar.ContextMenuGetEventIndex

```lua
info = C_Calendar.ContextMenuGetEventIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarEventIndexInfo | no |  |

**Example**

```lua
local info = C_Calendar.ContextMenuGetEventIndex()
```

### C_Calendar.ContextMenuInviteAvailable

```lua
C_Calendar.ContextMenuInviteAvailable()
```

**Example**

```lua
C_Calendar.ContextMenuInviteAvailable()
```

### C_Calendar.ContextMenuInviteDecline

```lua
C_Calendar.ContextMenuInviteDecline()
```

**Example**

```lua
C_Calendar.ContextMenuInviteDecline()
```

### C_Calendar.ContextMenuInviteRemove

```lua
C_Calendar.ContextMenuInviteRemove()
```

**Example**

```lua
C_Calendar.ContextMenuInviteRemove()
```

### C_Calendar.ContextMenuInviteTentative

```lua
C_Calendar.ContextMenuInviteTentative()
```

**Example**

```lua
C_Calendar.ContextMenuInviteTentative()
```

### C_Calendar.ContextMenuSelectEvent

```lua
C_Calendar.ContextMenuSelectEvent(offsetMonths, monthDay, eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.ContextMenuSelectEvent(0, monthDay, 1)
```

### C_Calendar.CreateCommunitySignUpEvent

```lua
C_Calendar.CreateCommunitySignUpEvent()
```

**Example**

```lua
C_Calendar.CreateCommunitySignUpEvent()
```

### C_Calendar.CreateGuildAnnouncementEvent

```lua
C_Calendar.CreateGuildAnnouncementEvent()
```

**Example**

```lua
C_Calendar.CreateGuildAnnouncementEvent()
```

### C_Calendar.CreateGuildSignUpEvent

```lua
C_Calendar.CreateGuildSignUpEvent()
```

**Example**

```lua
C_Calendar.CreateGuildSignUpEvent()
```

### C_Calendar.CreatePlayerEvent

```lua
C_Calendar.CreatePlayerEvent()
```

**Example**

```lua
C_Calendar.CreatePlayerEvent()
```

### C_Calendar.EventAvailable

```lua
C_Calendar.EventAvailable()
```

**Example**

```lua
C_Calendar.EventAvailable()
```

### C_Calendar.EventCanEdit

```lua
canEdit = C_Calendar.EventCanEdit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEdit` | bool | no |  |

**Example**

```lua
local canEdit = C_Calendar.EventCanEdit()
```

### C_Calendar.EventClearAutoApprove

```lua
C_Calendar.EventClearAutoApprove()
```

**Example**

```lua
C_Calendar.EventClearAutoApprove()
```

### C_Calendar.EventClearLocked

```lua
C_Calendar.EventClearLocked()
```

**Example**

```lua
C_Calendar.EventClearLocked()
```

### C_Calendar.EventClearModerator

```lua
C_Calendar.EventClearModerator(inviteIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.EventClearModerator(1)
```

### C_Calendar.EventDecline

```lua
C_Calendar.EventDecline()
```

**Example**

```lua
C_Calendar.EventDecline()
```

### C_Calendar.EventGetCalendarType

```lua
calendarType = C_Calendar.EventGetCalendarType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `calendarType` | string | yes |  |

**Example**

```lua
local calendarType = C_Calendar.EventGetCalendarType()
```

### C_Calendar.EventGetClubId

```lua
info = C_Calendar.EventGetClubId()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubId | yes |  |

**Example**

```lua
local info = C_Calendar.EventGetClubId()
```

### C_Calendar.EventGetInvite

```lua
info = C_Calendar.EventGetInvite(eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarEventInviteInfo | no |  |

**Example**

```lua
local info = C_Calendar.EventGetInvite(1)
```

### C_Calendar.EventGetInviteResponseTime

```lua
time = C_Calendar.EventGetInviteResponseTime(eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | CalendarTime | no |  |

**Example**

```lua
local time = C_Calendar.EventGetInviteResponseTime(1)
```

### C_Calendar.EventGetInviteSortCriterion

```lua
criterion, reverse = C_Calendar.EventGetInviteSortCriterion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criterion` | string | no |  |
| `reverse` | bool | no |  |

**Example**

```lua
local criterion, reverse = C_Calendar.EventGetInviteSortCriterion()
```

### C_Calendar.EventGetSelectedInvite

```lua
inviteIndex = C_Calendar.EventGetSelectedInvite()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | yes |  |

**Example**

```lua
local inviteIndex = C_Calendar.EventGetSelectedInvite()
```

### C_Calendar.EventGetStatusOptions

```lua
options = C_Calendar.EventGetStatusOptions(eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CalendarEventStatusOption[] | no |  |

**Example**

```lua
local options = C_Calendar.EventGetStatusOptions(1)
```

### C_Calendar.EventGetTextures

```lua
textures = C_Calendar.EventGetTextures(eventType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventType` | CalendarEventType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textures` | CalendarEventTextureInfo[] | no |  |

**Example**

```lua
local textures = C_Calendar.EventGetTextures(eventType)
```

### C_Calendar.EventGetTypes

```lua
types = C_Calendar.EventGetTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `types` | string[] | no |  |

**Example**

```lua
local types = C_Calendar.EventGetTypes()
```

### C_Calendar.EventGetTypesDisplayOrdered

```lua
infos = C_Calendar.EventGetTypesDisplayOrdered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infos` | CalendarEventTypeDisplayInfo[] | no |  |

**Example**

```lua
local infos = C_Calendar.EventGetTypesDisplayOrdered()
```

### C_Calendar.EventHasPendingInvite

```lua
hasPendingInvite = C_Calendar.EventHasPendingInvite()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPendingInvite` | bool | no |  |

**Example**

```lua
local hasPendingInvite = C_Calendar.EventHasPendingInvite()
```

### C_Calendar.EventHaveSettingsChanged

```lua
haveSettingsChanged = C_Calendar.EventHaveSettingsChanged()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `haveSettingsChanged` | bool | no |  |

**Example**

```lua
local haveSettingsChanged = C_Calendar.EventHaveSettingsChanged()
```

### C_Calendar.EventInvite

```lua
C_Calendar.EventInvite(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example**

```lua
C_Calendar.EventInvite("")
```

### C_Calendar.EventRemoveInvite

```lua
C_Calendar.EventRemoveInvite(inviteIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.EventRemoveInvite(1)
```

### C_Calendar.EventRemoveInviteByGuid

```lua
C_Calendar.EventRemoveInviteByGuid(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Example**

```lua
C_Calendar.EventRemoveInviteByGuid("Creature-0-0000-0-0-0-0")
```

### C_Calendar.EventSelectInvite

```lua
C_Calendar.EventSelectInvite(inviteIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.EventSelectInvite(1)
```

### C_Calendar.EventSetAutoApprove

```lua
C_Calendar.EventSetAutoApprove()
```

**Example**

```lua
C_Calendar.EventSetAutoApprove()
```

### C_Calendar.EventSetClubId

```lua
C_Calendar.EventSetClubId([clubId])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | yes |  |

**Example**

```lua
C_Calendar.EventSetClubId()
```

### C_Calendar.EventSetDate

```lua
C_Calendar.EventSetDate(month, monthDay, year)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `month` | luaIndex | no |  |
| `monthDay` | luaIndex | no |  |
| `year` | number | no |  |

**Example**

```lua
C_Calendar.EventSetDate(month, monthDay, 0)
```

### C_Calendar.EventSetDescription

```lua
C_Calendar.EventSetDescription(description)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |

**Example**

```lua
C_Calendar.EventSetDescription("")
```

### C_Calendar.EventSetInviteStatus

```lua
C_Calendar.EventSetInviteStatus(eventIndex, status)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventIndex` | luaIndex | no |  |
| `status` | CalendarStatus | no |  |

**Example**

```lua
C_Calendar.EventSetInviteStatus(1, status)
```

### C_Calendar.EventSetLocked

```lua
C_Calendar.EventSetLocked()
```

**Example**

```lua
C_Calendar.EventSetLocked()
```

### C_Calendar.EventSetModerator

```lua
C_Calendar.EventSetModerator(inviteIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.EventSetModerator(1)
```

### C_Calendar.EventSetTextureID

```lua
C_Calendar.EventSetTextureID(textureIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureIndex` | luaIndex | no |  |

**Example**

```lua
C_Calendar.EventSetTextureID(1)
```

### C_Calendar.EventSetTime

```lua
C_Calendar.EventSetTime(hour, minute)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hour` | number | no |  |
| `minute` | number | no |  |

**Example**

```lua
C_Calendar.EventSetTime(0, 0)
```

### C_Calendar.EventSetTitle

```lua
C_Calendar.EventSetTitle(title)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | no |  |

**Example**

```lua
C_Calendar.EventSetTitle("")
```

### C_Calendar.EventSetType

```lua
C_Calendar.EventSetType(typeIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIndex` | CalendarEventType | no |  |

**Example**

```lua
C_Calendar.EventSetType(1)
```

### C_Calendar.EventSignUp

```lua
C_Calendar.EventSignUp()
```

**Example**

```lua
C_Calendar.EventSignUp()
```

### C_Calendar.EventSortInvites

```lua
C_Calendar.EventSortInvites(criterion, reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criterion` | cstring | no |  |
| `reverse` | bool | no |  |

**Example**

```lua
C_Calendar.EventSortInvites("", false)
```

### C_Calendar.EventTentative

```lua
C_Calendar.EventTentative()
```

**Example**

```lua
C_Calendar.EventTentative()
```

### C_Calendar.GetClubCalendarEvents

```lua
events = C_Calendar.GetClubCalendarEvents(clubId, startTime, endTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `startTime` | CalendarTime | no |  |
| `endTime` | CalendarTime | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | CalendarDayEvent[] | no |  |

**Example**

```lua
local events = C_Calendar.GetClubCalendarEvents(clubId, startTime, endTime)
```

### C_Calendar.GetDayEvent

```lua
event = C_Calendar.GetDayEvent(monthOffset, monthDay, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `monthOffset` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `event` | CalendarDayEvent | no |  |

**Example**

```lua
local event = C_Calendar.GetDayEvent(0, monthDay, 1)
```

### C_Calendar.GetDefaultGuildFilter

```lua
info = C_Calendar.GetDefaultGuildFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarGuildFilterInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetDefaultGuildFilter()
```

### C_Calendar.GetEventIndex

```lua
info = C_Calendar.GetEventIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarEventIndexInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetEventIndex()
```

### C_Calendar.GetEventIndexInfo

```lua
eventIndexInfo = C_Calendar.GetEventIndexInfo(eventID, [monthOffset], [monthDay])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | CalendarEventID | no |  |
| `monthOffset` | number | yes |  |
| `monthDay` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventIndexInfo` | CalendarEventIndexInfo | yes |  |

**Example**

```lua
local eventIndexInfo = C_Calendar.GetEventIndexInfo(eventID)
```

### C_Calendar.GetEventInfo

```lua
info = C_Calendar.GetEventInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarEventInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetEventInfo()
```

### C_Calendar.GetFirstPendingInvite

```lua
firstPendingInvite = C_Calendar.GetFirstPendingInvite(offsetMonths, monthDay)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `firstPendingInvite` | luaIndex | yes |  |

**Example**

```lua
local firstPendingInvite = C_Calendar.GetFirstPendingInvite(0, monthDay)
```

### C_Calendar.GetGuildEventInfo

```lua
info = C_Calendar.GetGuildEventInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarGuildEventInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetGuildEventInfo(1)
```

### C_Calendar.GetGuildEventSelectionInfo

```lua
info = C_Calendar.GetGuildEventSelectionInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarEventIndexInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetGuildEventSelectionInfo(1)
```

### C_Calendar.GetHolidayInfo

```lua
event = C_Calendar.GetHolidayInfo(monthOffset, monthDay, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `monthOffset` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `event` | CalendarHolidayInfo | no |  |

**Example**

```lua
local event = C_Calendar.GetHolidayInfo(0, monthDay, 1)
```

### C_Calendar.GetMaxCreateDate

```lua
maxCreateDate = C_Calendar.GetMaxCreateDate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxCreateDate` | CalendarTime | no |  |

**Example**

```lua
local maxCreateDate = C_Calendar.GetMaxCreateDate()
```

### C_Calendar.GetMinDate

```lua
minDate = C_Calendar.GetMinDate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minDate` | CalendarTime | no |  |

**Example**

```lua
local minDate = C_Calendar.GetMinDate()
```

### C_Calendar.GetMonthInfo

```lua
monthInfo = C_Calendar.GetMonthInfo(offsetMonths)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `monthInfo` | CalendarMonthInfo | no |  |

**Example**

```lua
local monthInfo = C_Calendar.GetMonthInfo(0)
```

### C_Calendar.GetNextClubId

```lua
clubId = C_Calendar.GetNextClubId()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | yes |  |

**Example**

```lua
local clubId = C_Calendar.GetNextClubId()
```

### C_Calendar.GetNumDayEvents

```lua
numDayEvents = C_Calendar.GetNumDayEvents(offsetMonths, monthDay)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDayEvents` | number | no |  |

**Example**

```lua
local numDayEvents = C_Calendar.GetNumDayEvents(0, monthDay)
```

### C_Calendar.GetNumGuildEvents

```lua
numGuildEvents = C_Calendar.GetNumGuildEvents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numGuildEvents` | number | no |  |

**Example**

```lua
local numGuildEvents = C_Calendar.GetNumGuildEvents()
```

### C_Calendar.GetNumInvites

```lua
num = C_Calendar.GetNumInvites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `num` | number | no |  |

**Example**

```lua
local num = C_Calendar.GetNumInvites()
```

### C_Calendar.GetNumPendingInvites

```lua
num = C_Calendar.GetNumPendingInvites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `num` | number | no |  |

**Example**

```lua
local num = C_Calendar.GetNumPendingInvites()
```

### C_Calendar.GetRaidInfo

```lua
info = C_Calendar.GetRaidInfo(offsetMonths, monthDay, eventIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CalendarRaidInfo | no |  |

**Example**

```lua
local info = C_Calendar.GetRaidInfo(0, monthDay, 1)
```

### C_Calendar.IsActionPending

```lua
actionPending = C_Calendar.IsActionPending()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionPending` | bool | no |  |

**Example**

```lua
local actionPending = C_Calendar.IsActionPending()
```

### C_Calendar.IsEventOpen

```lua
isOpen = C_Calendar.IsEventOpen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOpen` | bool | no |  |

**Example**

```lua
local isOpen = C_Calendar.IsEventOpen()
```

### C_Calendar.MassInviteCommunity

```lua
C_Calendar.MassInviteCommunity(clubId, minLevel, maxLevel, [maxRankOrder])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `maxRankOrder` | luaIndex | yes |  |

**Example**

```lua
C_Calendar.MassInviteCommunity(clubId, 0, 0)
```

### C_Calendar.MassInviteGuild

```lua
C_Calendar.MassInviteGuild(minLevel, maxLevel, maxRankOrder)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `maxRankOrder` | luaIndex | no |  |

**Example**

```lua
C_Calendar.MassInviteGuild(0, 0, 1)
```

### C_Calendar.OpenCalendar

```lua
C_Calendar.OpenCalendar()
```

**Example**

```lua
C_Calendar.OpenCalendar()
```

### C_Calendar.OpenEvent

```lua
success = C_Calendar.OpenEvent(offsetMonths, monthDay, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Calendar.OpenEvent(0, monthDay, 1)
```

### C_Calendar.RemoveEvent

```lua
C_Calendar.RemoveEvent()
```

**Example**

```lua
C_Calendar.RemoveEvent()
```

### C_Calendar.SetAbsMonth

```lua
C_Calendar.SetAbsMonth(month, year)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `month` | luaIndex | no |  |
| `year` | number | no |  |

**Example**

```lua
C_Calendar.SetAbsMonth(month, 0)
```

### C_Calendar.SetMonth

```lua
C_Calendar.SetMonth(offsetMonths)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |

**Example**

```lua
C_Calendar.SetMonth(0)
```

### C_Calendar.SetNextClubId

```lua
C_Calendar.SetNextClubId([clubId])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | yes |  |

**Example**

```lua
C_Calendar.SetNextClubId()
```

### C_Calendar.UpdateEvent

```lua
C_Calendar.UpdateEvent()
```

**Example**

```lua
C_Calendar.UpdateEvent()
```

## Events

### CALENDAR_ACTION_PENDING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pending` | bool | no |  |

### CALENDAR_CLOSE_EVENT

### CALENDAR_EVENT_ALARM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | no |  |
| `hour` | number | no |  |
| `minute` | number | no |  |

### CALENDAR_NEW_EVENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCopy` | bool | no |  |

### CALENDAR_OPEN_EVENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `calendarType` | cstring | no |  |

### CALENDAR_UPDATE_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorReason` | cstring | no |  |

### CALENDAR_UPDATE_ERROR_WITH_COUNT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorReason` | cstring | no |  |
| `count` | number | no |  |

### CALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorReason` | cstring | no |  |
| `playerName` | cstring | no |  |

### CALENDAR_UPDATE_EVENT

### CALENDAR_UPDATE_EVENT_LIST

### CALENDAR_UPDATE_GUILD_EVENTS

### CALENDAR_UPDATE_INVITE_LIST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCompleteList` | bool | yes |  |

### CALENDAR_UPDATE_PENDING_INVITES

## Types

### CalendarDayEvent (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | CalendarEventID | no |  |
| `title` | string | no |  |
| `isCustomTitle` | bool | no |  |
| `startTime` | CalendarTime | no |  |
| `endTime` | CalendarTime | no |  |
| `calendarType` | cstring | no |  |
| `sequenceType` | cstring | no |  |
| `eventType` | CalendarEventType | no |  |
| `iconTexture` | fileID | yes |  |
| `modStatus` | cstring | no |  |
| `inviteStatus` | CalendarStatus | no |  |
| `invitedBy` | string | no |  |
| `difficulty` | number | no |  |
| `inviteType` | CalendarInviteType | no |  |
| `sequenceIndex` | luaIndex | no |  |
| `numSequenceDays` | number | no |  |
| `difficultyName` | cstring | no |  |
| `dontDisplayBanner` | bool | no |  |
| `dontDisplayEnd` | bool | no |  |
| `clubID` | ClubId | no |  |
| `isLocked` | bool | no |  |

### CalendarEventIndexInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetMonths` | number | no |  |
| `monthDay` | luaIndex | no |  |
| `eventIndex` | luaIndex | no |  |

### CalendarEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `description` | string | no |  |
| `creator` | string | yes |  |
| `eventType` | CalendarEventType | no |  |
| `repeatOption` | CalendarEventRepeatOptions | no |  |
| `maxSize` | number | no |  |
| `textureIndex` | luaIndex | yes |  |
| `time` | CalendarTime | no |  |
| `lockoutTime` | CalendarTime | no |  |
| `isLocked` | bool | no |  |
| `isAutoApprove` | bool | no |  |
| `hasPendingInvite` | bool | no |  |
| `inviteStatus` | CalendarStatus | yes |  |
| `inviteType` | CalendarInviteType | yes |  |
| `calendarType` | string | no |  |
| `communityName` | string | yes |  |

### CalendarEventInviteInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `level` | number | no |  |
| `className` | string | yes |  |
| `classFilename` | string | yes |  |
| `inviteStatus` | CalendarStatus | yes |  |
| `modStatus` | string | yes |  |
| `inviteIsMine` | bool | no |  |
| `type` | CalendarInviteType | no |  |
| `notes` | string | no |  |
| `classID` | number | yes |  |
| `guid` | WOWGUID | no |  |

### CalendarEventStatusOption (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | CalendarStatus | no |  |
| `statusString` | string | no |  |

### CalendarEventTextureInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `iconTexture` | fileID | no |  |
| `expansionLevel` | number | no |  |
| `difficultyId` | number | yes |  |
| `mapId` | number | yes |  |
| `isLfr` | bool | yes |  |

### CalendarEventTypeDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayString` | string | no |  |
| `eventType` | CalendarEventType | no |  |

### CalendarGuildEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | CalendarEventID | no |  |
| `year` | number | no |  |
| `month` | luaIndex | no |  |
| `monthDay` | luaIndex | no |  |
| `weekday` | luaIndex | no |  |
| `hour` | number | no |  |
| `minute` | number | no |  |
| `eventType` | CalendarEventType | no |  |
| `title` | string | no |  |
| `calendarType` | string | no |  |
| `texture` | fileID | no |  |
| `inviteStatus` | CalendarStatus | no |  |
| `clubID` | ClubId | no |  |

### CalendarGuildFilterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `rank` | number | no |  |

### CalendarHolidayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `texture` | fileID | no |  |
| `startTime` | CalendarTime | yes |  |
| `endTime` | CalendarTime | yes |  |

### CalendarMonthInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `month` | luaIndex | no |  |
| `year` | number | no |  |
| `numDays` | number | no |  |
| `firstWeekday` | luaIndex | no |  |

### CalendarRaidInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `calendarType` | string | no |  |
| `raidID` | number | no |  |
| `time` | CalendarTime | no |  |
| `difficulty` | number | no |  |
| `difficultyName` | string | yes |  |

