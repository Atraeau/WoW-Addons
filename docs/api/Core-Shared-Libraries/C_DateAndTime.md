# C_DateAndTime

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **1** events · **1** types

## Functions

### C_DateAndTime.AdjustTimeByDays

```lua
newDate = C_DateAndTime.AdjustTimeByDays(date, days)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `date` | CalendarTime | no |  |
| `days` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newDate` | CalendarTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newDate = C_DateAndTime.AdjustTimeByDays(date, 0)
```

### C_DateAndTime.AdjustTimeByMinutes

```lua
newDate = C_DateAndTime.AdjustTimeByMinutes(date, minutes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `date` | CalendarTime | no |  |
| `minutes` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newDate` | CalendarTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newDate = C_DateAndTime.AdjustTimeByMinutes(date, 0)
```

### C_DateAndTime.AdjustTimeByMonths

```lua
newDate = C_DateAndTime.AdjustTimeByMonths(date, months)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `date` | CalendarTime | no |  |
| `months` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newDate` | CalendarTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newDate = C_DateAndTime.AdjustTimeByMonths(date, 0)
```

### C_DateAndTime.CompareCalendarTime

```lua
comparison = C_DateAndTime.CompareCalendarTime(lhsCalendarTime, rhsCalendarTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lhsCalendarTime` | CalendarTime | no |  |
| `rhsCalendarTime` | CalendarTime | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparison` | number | no | -1 if rhsCalendarTime < lhsCalendarTime, 0 if rhsCalendarTime == lhsCalendarTime, 1 if rhsCalendarTime > lhsCalendarTime |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local comparison = C_DateAndTime.CompareCalendarTime(lhsCalendarTime, rhsCalendarTime)
```

### C_DateAndTime.GetCalendarTimeFromEpoch

```lua
date = C_DateAndTime.GetCalendarTimeFromEpoch(epoch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `epoch` | BigUInteger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `date` | CalendarTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local date = C_DateAndTime.GetCalendarTimeFromEpoch(epoch)
```

### C_DateAndTime.GetCurrentCalendarTime

```lua
date = C_DateAndTime.GetCurrentCalendarTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `date` | CalendarTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local date = C_DateAndTime.GetCurrentCalendarTime()
```

### C_DateAndTime.GetSecondsUntilDailyReset

```lua
seconds = C_DateAndTime.GetSecondsUntilDailyReset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = C_DateAndTime.GetSecondsUntilDailyReset()
```

### C_DateAndTime.GetSecondsUntilWeeklyReset

```lua
seconds = C_DateAndTime.GetSecondsUntilWeeklyReset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = C_DateAndTime.GetSecondsUntilWeeklyReset()
```

### C_DateAndTime.GetServerTimeLocal

```lua
serverTimeLocal = C_DateAndTime.GetServerTimeLocal()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serverTimeLocal` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local serverTimeLocal = C_DateAndTime.GetServerTimeLocal()
```

### C_DateAndTime.GetWeeklyResetStartTime

```lua
seconds = C_DateAndTime.GetWeeklyResetStartTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = C_DateAndTime.GetWeeklyResetStartTime()
```

### C_DateAndTime.IsDayTime

```lua
isDayTime = C_DateAndTime.IsDayTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDayTime` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDayTime = C_DateAndTime.IsDayTime()
```

## Events

### DIEL_CYCLE_CHANGED

Signaled when the game time transitions between day and night.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDayTime` | bool | no |  |

## Types

### TimeEventFlag (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `GlueScreenShortcut` | TimeEventFlag | no |  |
| `WeeklyReset` | TimeEventFlag | no |  |
| `GlobalLaunch` | TimeEventFlag | no |  |

