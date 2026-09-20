# C_CooldownViewer

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **3** events · **2** types

## Functions

### C_CooldownViewer.GetCooldownViewerCategorySet

```lua
cooldownIDs = C_CooldownViewer.GetCooldownViewerCategorySet(category, allowUnlearned)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | CooldownViewerCategory | no |  |
| `allowUnlearned` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownIDs` | number[] | no |  |

**Example**

```lua
local cooldownIDs = C_CooldownViewer.GetCooldownViewerCategorySet(category, false)
```

### C_CooldownViewer.GetCooldownViewerCooldownInfo

```lua
cooldownInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownInfo` | CooldownViewerCooldown | no |  |

**Example**

```lua
local cooldownInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(0)
```

### C_CooldownViewer.GetGroupBuffItems

```lua
groupBuffItems = C_CooldownViewer.GetGroupBuffItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupBuffItems` | GroupBuffItem[] | no |  |

**Example**

```lua
local groupBuffItems = C_CooldownViewer.GetGroupBuffItems()
```

### C_CooldownViewer.GetLayoutData

```lua
data = C_CooldownViewer.GetLayoutData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | cstring | no |  |

**Example**

```lua
local data = C_CooldownViewer.GetLayoutData()
```

### C_CooldownViewer.GetValidAlertTypes

```lua
validAlertTypes = C_CooldownViewer.GetValidAlertTypes(cooldownID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `validAlertTypes` | CooldownViewerAlertEventType[] | no |  |

**Example**

```lua
local validAlertTypes = C_CooldownViewer.GetValidAlertTypes(0)
```

### C_CooldownViewer.IsCooldownViewerAvailable

```lua
isAvailable, failureReason = C_CooldownViewer.IsCooldownViewerAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |
| `failureReason` | string | no |  |

**Example**

```lua
local isAvailable, failureReason = C_CooldownViewer.IsCooldownViewerAvailable()
```

### C_CooldownViewer.SetLayoutData

```lua
C_CooldownViewer.SetLayoutData(data)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | cstring | no |  |

**Example**

```lua
C_CooldownViewer.SetLayoutData("")
```

## Events

### COOLDOWN_VIEWER_DATA_LOADED

### COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseSpellID` | number | no | The base spell that is either being overridden or losing its override spell. |
| `overrideSpellID` | number | yes | The spell overriding the base spell. A nil value indicates that the override spell is being removed from the base spell. |

### COOLDOWN_VIEWER_TABLE_HOTFIXED

## Types

### CooldownViewerCooldown (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownID` | number | no |  |
| `spellID` | number | yes |  |
| `spellCategoryID` | number | yes |  |
| `overrideSpellID` | number | yes |  |
| `overrideTooltipSpellID` | number | yes |  |
| `equipSlot` | luaIndex | yes |  |
| `buffSlot` | luaIndex | yes |  |
| `linkedSpellIDs` | number[] | no |  |
| `selfAura` | bool | no |  |
| `hasAura` | bool | no |  |
| `charges` | bool | no |  |
| `isKnown` | bool | no |  |
| `isInvisible` | bool | no |  |
| `flags` | CooldownSetSpellFlags | no |  |
| `category` | CooldownViewerCategory | no |  |

### GroupBuffItem (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `name` | cstring | no |  |
| `iconID` | fileID | no |  |
| `flags` | GroupBuffItemFlags | no |  |
| `isKnown` | bool | no |  |

