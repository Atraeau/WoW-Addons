# C_CombatLog

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **4** events · **0** types

## Functions

### C_CombatLog.ApplyFilterSettings

```lua
C_CombatLog.ApplyFilterSettings(filterSettings)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterSettings` | LuaValueVariant | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.ApplyFilterSettings("HELPFUL")
```

### C_CombatLog.AreFilteredEventsEnabled

```lua
enabled = C_CombatLog.AreFilteredEventsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_CombatLog.AreFilteredEventsEnabled()
```

### C_CombatLog.ClearEntries

```lua
C_CombatLog.ClearEntries()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.ClearEntries()
```

### C_CombatLog.DoesObjectMatchFilter

```lua
matches = C_CombatLog.DoesObjectMatchFilter(mask, flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mask` | CombatLogObject | no |  |
| `flags` | CombatLogObject | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matches` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matches = C_CombatLog.DoesObjectMatchFilter(mask, flags)
```

### C_CombatLog.GetEntryRetentionTime

```lua
retentionTime = C_CombatLog.GetEntryRetentionTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `retentionTime` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local retentionTime = C_CombatLog.GetEntryRetentionTime()
```

### C_CombatLog.GetMessageLimit

```lua
messageLimit = C_CombatLog.GetMessageLimit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageLimit` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local messageLimit = C_CombatLog.GetMessageLimit()
```

### C_CombatLog.IsCombatLogRestricted

```lua
restricted = C_CombatLog.IsCombatLogRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restricted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restricted = C_CombatLog.IsCombatLogRestricted()
```

### C_CombatLog.RefilterEntries

```lua
C_CombatLog.RefilterEntries()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.RefilterEntries()
```

### C_CombatLog.SetEntryRetentionTime

```lua
C_CombatLog.SetEntryRetentionTime(retentionTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `retentionTime` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.SetEntryRetentionTime(0)
```

### C_CombatLog.SetFilteredEventsEnabled

```lua
C_CombatLog.SetFilteredEventsEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.SetFilteredEventsEnabled(false)
```

### C_CombatLog.SetMessageLimit

```lua
C_CombatLog.SetMessageLimit(messageLimit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageLimit` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatLog.SetMessageLimit(0)
```

## Events

### COMBAT_LOG_ENTRIES_CLEARED

### COMBAT_LOG_EVENT

### COMBAT_LOG_EVENT_UNFILTERED

### COMBAT_LOG_MESSAGE_LIMIT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageLimit` | number | no |  |

