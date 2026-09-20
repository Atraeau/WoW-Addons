# C_CombatLogSecure

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**9** functions · **3** events · **0** types

## Functions

### C_CombatLogSecure.AddEventFilter

```lua
C_CombatLogSecure.AddEventFilter()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLogSecure.AddEventFilter()
```

### C_CombatLogSecure.ClearEventFilters

```lua
C_CombatLogSecure.ClearEventFilters()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLogSecure.ClearEventFilters()
```

### C_CombatLogSecure.CreateCombatLogMessage

```lua
C_CombatLogSecure.CreateCombatLogMessage(message, colorR, colorG, colorB, order)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | string | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `order` | CombatLogMessageOrder | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLogSecure.CreateCombatLogMessage("", 0, 0, 0, order)
```

### C_CombatLogSecure.GetCurrentEntryInfo

```lua
C_CombatLogSecure.GetCurrentEntryInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLogSecure.GetCurrentEntryInfo()
```

### C_CombatLogSecure.GetCurrentEventInfo

```lua
C_CombatLogSecure.GetCurrentEventInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLogSecure.GetCurrentEventInfo()
```

### C_CombatLogSecure.GetEntryCount

```lua
count = C_CombatLogSecure.GetEntryCount(ignoreFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreFilter` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_CombatLogSecure.GetEntryCount("HELPFUL")
```

### C_CombatLogSecure.SeekToNewestEntry

```lua
isValidEntry = C_CombatLogSecure.SeekToNewestEntry(ignoreFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreFilter` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidEntry` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValidEntry = C_CombatLogSecure.SeekToNewestEntry("HELPFUL")
```

### C_CombatLogSecure.SeekToPreviousEntry

```lua
isValidEntry = C_CombatLogSecure.SeekToPreviousEntry(ignoreFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreFilter` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidEntry` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValidEntry = C_CombatLogSecure.SeekToPreviousEntry("HELPFUL")
```

### C_CombatLogSecure.ShouldShowCurrentEntry

```lua
shouldShow = C_CombatLogSecure.ShouldShowCurrentEntry()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_CombatLogSecure.ShouldShowCurrentEntry()
```

## Events

### COMBAT_LOG_APPLY_FILTER_SETTINGS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterSettings` | LuaValueVariant | no |  |

### COMBAT_LOG_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | string | no | A preformatted combat log message protected by a \|K string wrapper. |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `order` | CombatLogMessageOrder | no |  |

### COMBAT_LOG_REFILTER_ENTRIES

