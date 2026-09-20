# C_DamageMeter

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **3** events · **6** types

## Functions

### C_DamageMeter.GetAvailableCombatSessions

Returns a list of combat sessions currently being tracked.

```lua
availableSessions = C_DamageMeter.GetAvailableCombatSessions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `availableSessions` | DamageMeterAvailableCombatSession[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local availableSessions = C_DamageMeter.GetAvailableCombatSessions()
```

### C_DamageMeter.GetCombatSessionFromID

Returns the data for the player's combat session with the specified ID.

```lua
session = C_DamageMeter.GetCombatSessionFromID(sessionID, type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionID` | number | no |  |
| `type` | DamageMeterType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `session` | DamageMeterCombatSession | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local session = C_DamageMeter.GetCombatSessionFromID(0, type)
```

### C_DamageMeter.GetCombatSessionFromType

Returns the data for the player's current combat session.

```lua
session = C_DamageMeter.GetCombatSessionFromType(sessionType, type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionType` | DamageMeterSessionType | no |  |
| `type` | DamageMeterType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `session` | DamageMeterCombatSession | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local session = C_DamageMeter.GetCombatSessionFromType(sessionType, type)
```

### C_DamageMeter.GetCombatSessionSourceFromID

Returns the data for a single source (unit) in the player's current combat session with the specified ID.

```lua
sessionSource = C_DamageMeter.GetCombatSessionSourceFromID(sessionID, type, [sourceGUID], [sourceCreatureID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionID` | number | no |  |
| `type` | DamageMeterType | no |  |
| `sourceGUID` | WOWGUID | yes |  |
| `sourceCreatureID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionSource` | DamageMeterCombatSessionSource | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sessionSource = C_DamageMeter.GetCombatSessionSourceFromID(0, type)
```

### C_DamageMeter.GetCombatSessionSourceFromType

Returns the data for a single source (unit) in the player's current combat session.

```lua
sessionSource = C_DamageMeter.GetCombatSessionSourceFromType(sessionType, type, [sourceGUID], [sourceCreatureID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionType` | DamageMeterSessionType | no |  |
| `type` | DamageMeterType | no |  |
| `sourceGUID` | WOWGUID | yes |  |
| `sourceCreatureID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionSource` | DamageMeterCombatSessionSource | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sessionSource = C_DamageMeter.GetCombatSessionSourceFromType(sessionType, type)
```

### C_DamageMeter.GetSessionDurationSeconds

Returns the amount of time a combat session has lasted

```lua
durationSeconds = C_DamageMeter.GetSessionDurationSeconds(sessionType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionType` | DamageMeterSessionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSeconds` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSeconds = C_DamageMeter.GetSessionDurationSeconds(sessionType)
```

### C_DamageMeter.IsDamageMeterAvailable

Returns whether the player can enable and use the Damage Meter.

```lua
isAvailable, failureReason = C_DamageMeter.IsDamageMeterAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailable, failureReason = C_DamageMeter.IsDamageMeterAvailable()
```

### C_DamageMeter.ResetAllCombatSessions

Clears the data for all the player's combat sessions.

```lua
C_DamageMeter.ResetAllCombatSessions()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_DamageMeter.ResetAllCombatSessions()
```

## Events

### DAMAGE_METER_COMBAT_SESSION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | DamageMeterType | no |  |
| `sessionID` | number | no |  |

### DAMAGE_METER_CURRENT_SESSION_UPDATED

### DAMAGE_METER_RESET

## Types

### DamageMeterAvailableCombatSession (Structure)

Data for a combat session currently being tracked.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sessionID` | number | no |  |
| `name` | cstring | no |  |
| `durationSeconds` | number | yes |  |

### DamageMeterCombatSession (Structure)

Aggregated data for all sources (units) in a damage meter combat session.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `combatSources` | DamageMeterCombatSource[] | no |  |
| `maxAmount` | number | no | (default: 0) |
| `totalAmount` | number | no | (default: 0) |
| `durationSeconds` | number | yes |  |

### DamageMeterCombatSessionSource (Structure)

Data for a single source (unit) in a combat session.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `combatSpells` | DamageMeterCombatSpell[] | no |  |
| `maxAmount` | number | no | (default: 0) |
| `totalAmount` | number | no | (default: 0) |

### DamageMeterCombatSource (Structure)

Aggregated data for a single source (unit) in a damage meter combat session.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceGUID` | WOWGUID | yes |  |
| `sourceCreatureID` | number | yes |  |
| `name` | cstring | no |  |
| `classFilename` | cstring | no |  |
| `specIconID` | fileID | no |  |
| `totalAmount` | number | no |  |
| `amountPerSecond` | number | no |  |
| `isLocalPlayer` | bool | no |  |
| `deathRecapID` | number | no |  |
| `deathTimeSeconds` | number | no |  |
| `classification` | cstring | no |  |
| `sourceDisplayType` | DamageMeterSourceDisplayType | no |  |
| `factionGroup` | cstring | yes |  |

### DamageMeterCombatSpell (Structure)

Aggregated data for all spells of the same ID cast by a single source (unit) in a combat session.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `totalAmount` | number | no |  |
| `amountPerSecond` | number | no |  |
| `creatureName` | cstring | no |  |
| `overkillAmount` | number | no |  |
| `isAvoidable` | bool | no |  |
| `isDeadly` | bool | no |  |
| `combatSpellDetails` | DamageMeterCombatSpellUnitDetails | no |  |

### DamageMeterCombatSpellUnitDetails (Structure)

Amount for a single target for all casts of the same spellID by a single source (unit) in a combat session.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `unitClassFilename` | cstring | no |  |
| `classification` | cstring | no |  |
| `isPet` | bool | no |  |
| `isMob` | bool | no |  |
| `amount` | number | no |  |
| `specIconID` | fileID | no |  |

