# C_SpellDiminish

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **1** events · **2** types

## Functions

### C_SpellDiminish.GetAllSpellDiminishCategories

```lua
categories = C_SpellDiminish.GetAllSpellDiminishCategories([ruleset])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ruleset` | SpellDiminishRuleset | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categories` | SpellDiminishCategoryInfo[] | no |  |

**Example**

```lua
local categories = C_SpellDiminish.GetAllSpellDiminishCategories()
```

### C_SpellDiminish.GetSpellDiminishCategoryInfo

```lua
categoryInfo = C_SpellDiminish.GetSpellDiminishCategoryInfo(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | SpellDiminishCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryInfo` | SpellDiminishCategoryInfo | yes |  |

**Example**

```lua
local categoryInfo = C_SpellDiminish.GetSpellDiminishCategoryInfo(category)
```

### C_SpellDiminish.IsSystemSupported

```lua
isSystemSupported = C_SpellDiminish.IsSystemSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSystemSupported` | bool | no |  |

**Example**

```lua
local isSystemSupported = C_SpellDiminish.IsSystemSupported()
```

### C_SpellDiminish.ShouldTrackSpellDiminishCategory

```lua
isTracked = C_SpellDiminish.ShouldTrackSpellDiminishCategory(category, ruleset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | SpellDiminishCategory | no |  |
| `ruleset` | SpellDiminishRuleset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTracked` | bool | no |  |

**Example**

```lua
local isTracked = C_SpellDiminish.ShouldTrackSpellDiminishCategory(category, ruleset)
```

## Events

### UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `trackerInfo` | SpellDiminishTrackerInfo | no |  |

## Types

### SpellDiminishCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | SpellDiminishCategory | no |  |
| `name` | cstring | no |  |
| `icon` | fileID | yes |  |

### SpellDiminishTrackerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | SpellDiminishCategory | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `showCountdown` | bool | no |  |
| `isImmune` | bool | no |  |

