# C_GameRules

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**29** functions · **6** events · **1** types

## Functions

### C_GameRules.AccountHasSDEnabled

```lua
isSDEnabled = C_GameRules.AccountHasSDEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSDEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSDEnabled = C_GameRules.AccountHasSDEnabled()
```

### C_GameRules.AutoConnectToGameModeRealm

```lua
C_GameRules.AutoConnectToGameModeRealm(gameModeRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GameRules.AutoConnectToGameModeRealm(0)
```

### C_GameRules.DoesGameModeHavePromo

```lua
hasPromo = C_GameRules.DoesGameModeHavePromo(gameModeRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPromo` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPromo = C_GameRules.DoesGameModeHavePromo(0)
```

### C_GameRules.GetActiveGameMode

```lua
gameMode = C_GameRules.GetActiveGameMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameMode` | GameMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameMode = C_GameRules.GetActiveGameMode()
```

### C_GameRules.GetCurrentEventRealmQueues

```lua
eventRealmQueues = C_GameRules.GetCurrentEventRealmQueues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventRealmQueues` | EventRealmQueues | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local eventRealmQueues = C_GameRules.GetCurrentEventRealmQueues()
```

### C_GameRules.GetCurrentGameModeDisplayInfo

```lua
info = C_GameRules.GetCurrentGameModeDisplayInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GameModeDisplayInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_GameRules.GetCurrentGameModeDisplayInfo()
```

### C_GameRules.GetCurrentGameModeRecordID

```lua
gameModeRecordID = C_GameRules.GetCurrentGameModeRecordID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameModeRecordID = C_GameRules.GetCurrentGameModeRecordID()
```

### C_GameRules.GetDisplayedGameModeRecordIDAtIndex

```lua
gameModeRecordID = C_GameRules.GetDisplayedGameModeRecordIDAtIndex(displayIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameModeRecordID = C_GameRules.GetDisplayedGameModeRecordIDAtIndex(1)
```

### C_GameRules.GetGameModeDisplayInfoByRecordID

```lua
info = C_GameRules.GetGameModeDisplayInfoByRecordID(gameModeRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GameModeDisplayInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_GameRules.GetGameModeDisplayInfoByRecordID(0)
```

### C_GameRules.GetGameModeGlueScreenName

```lua
screenName = C_GameRules.GetGameModeGlueScreenName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `screenName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local screenName = C_GameRules.GetGameModeGlueScreenName()
```

### C_GameRules.GetGameModePromoGlobalString

```lua
promoGlobalString = C_GameRules.GetGameModePromoGlobalString(gameModeRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `promoGlobalString` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local promoGlobalString = C_GameRules.GetGameModePromoGlobalString(0)
```

### C_GameRules.GetGameRuleAsFloat

Returns the numeric value specified in the Game Rule, multiplied by 0.1 for every decimal place requested

```lua
value = C_GameRules.GetGameRuleAsFloat(gameRule, decimalPlaces)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameRule` | GameRule | no |  |
| `decimalPlaces` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = C_GameRules.GetGameRuleAsFloat(gameRule, 0)
```

### C_GameRules.GetGameRuleAsFrameStrata

Returns the value specified in the Game Rule converted to a frame strata

```lua
frameStrata = C_GameRules.GetGameRuleAsFrameStrata(gameRule)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameRule` | GameRule | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameStrata` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frameStrata = C_GameRules.GetGameRuleAsFrameStrata(gameRule)
```

### C_GameRules.GetNumDisplayedGameModes

```lua
numDisplayedGameModes = C_GameRules.GetNumDisplayedGameModes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDisplayedGameModes` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numDisplayedGameModes = C_GameRules.GetNumDisplayedGameModes()
```

### C_GameRules.IsCharacterlessLoginActive

```lua
active = C_GameRules.IsCharacterlessLoginActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsCharacterlessLoginActive()
```

### C_GameRules.IsClassAllowedForGameMode

```lua
valid = C_GameRules.IsClassAllowedForGameMode(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_GameRules.IsClassAllowedForGameMode(0)
```

### C_GameRules.IsGameModeEnabled

```lua
enabled = C_GameRules.IsGameModeEnabled(gameModeRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GameRules.IsGameModeEnabled(0)
```

### C_GameRules.IsGameRuleActive

```lua
isActive = C_GameRules.IsGameRuleActive(gameRule)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameRule` | GameRule | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = C_GameRules.IsGameRuleActive(gameRule)
```

### C_GameRules.IsHardcoreActive

```lua
active = C_GameRules.IsHardcoreActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsHardcoreActive()
```

### C_GameRules.IsMultiActionBarVisibilityForced

```lua
valid = C_GameRules.IsMultiActionBarVisibilityForced()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_GameRules.IsMultiActionBarVisibilityForced()
```

### C_GameRules.IsPersonalResourceDisplayEnabled

Checks the game rule as well as nameplateShowSelf

```lua
isPersonalResourceDisplayEnabled = C_GameRules.IsPersonalResourceDisplayEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPersonalResourceDisplayEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPersonalResourceDisplayEnabled = C_GameRules.IsPersonalResourceDisplayEnabled()
```

### C_GameRules.IsPlunderstorm

```lua
active = C_GameRules.IsPlunderstorm()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsPlunderstorm()
```

### C_GameRules.IsSDHDToggleEnabled

```lua
isEnabled = C_GameRules.IsSDHDToggleEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_GameRules.IsSDHDToggleEnabled()
```

### C_GameRules.IsSelfFoundAllowed

```lua
active = C_GameRules.IsSelfFoundAllowed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsSelfFoundAllowed()
```

### C_GameRules.IsStandard

```lua
active = C_GameRules.IsStandard()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsStandard()
```

### C_GameRules.IsWoWHack

```lua
active = C_GameRules.IsWoWHack()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_GameRules.IsWoWHack()
```

### C_GameRules.SelectClassicExperiencePreset

```lua
C_GameRules.SelectClassicExperiencePreset()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GameRules.SelectClassicExperiencePreset()
```

### C_GameRules.SelectModernExperiencePreset

```lua
C_GameRules.SelectModernExperiencePreset()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GameRules.SelectModernExperiencePreset()
```

### C_GameRules.SetSDHDToggleValue

```lua
C_GameRules.SetSDHDToggleValue(setToSD)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setToSD` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GameRules.SetSDHDToggleValue(false)
```

## Events

### ACTIVE_GAME_MODE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameMode` | GameMode | no |  |

### AVAILABLE_GAME_MODES_UPDATED

### EVENT_REALM_QUEUES_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventRealmQueues` | EventRealmQueues | no |  |

### GAME_MODE_DISPLAY_INFO_UPDATED

### GAME_MODE_DISPLAY_MODE_TOGGLE_DISABLED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameModeRecordID` | number | no |  |
| `disabled` | bool | no |  |

### GAME_RULES_CHANGED

## Types

### GameModeDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `logo` | fileID | no |  |
| `logoHeight` | number | no |  |
| `logoVerticalOffset` | number | no |  |
| `logoShrunkenHeight` | number | no |  |
| `logoUsesDarkBackdrop` | bool | no |  |
| `characterCreateExtraHeight` | number | no |  |
| `characterCreateOuterBorder` | fileID | no |  |

