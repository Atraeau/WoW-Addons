# C_Secrets

[← API index](../README.md) · group: [Miscellaneous](README.md)

'How is it a secret if we can C it?'

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**27** functions · **0** events · **0** types

## Functions

### C_Secrets.CanCompareUnitTokens

Returns true if queries to compare two input unit tokens are permitted. If this returns false, APIs guarded by the RequiresComparableUnitTokens predicate will fail.

```lua
isUnitComparisonPermitted = C_Secrets.CanCompareUnitTokens(unit1, unit2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit1` | UnitToken | no |  |
| `unit2` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitComparisonPermitted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitComparisonPermitted = C_Secrets.CanCompareUnitTokens("player", "player")
```

### C_Secrets.GetPowerTypeSecrecy

Queries the base secrecy for a power type.

```lua
secrecy = C_Secrets.GetPowerTypeSecrecy(powerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerType` | PowerType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secrecy` | SecrecyLevel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local secrecy = C_Secrets.GetPowerTypeSecrecy(powerType)
```

### C_Secrets.GetSpellAuraSecrecy

Queries the base secrecy for a spell if queried as an aura.

```lua
secrecy = C_Secrets.GetSpellAuraSecrecy(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secrecy` | SecrecyLevel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local secrecy = C_Secrets.GetSpellAuraSecrecy(2050)
```

### C_Secrets.GetSpellCastSecrecy

Queries the base secrecy for a spell if queried as a cast.

```lua
secrecy = C_Secrets.GetSpellCastSecrecy(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secrecy` | SecrecyLevel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local secrecy = C_Secrets.GetSpellCastSecrecy(2050)
```

### C_Secrets.GetSpellCooldownSecrecy

Queries the base secrecy for a spell if queried as a cooldown.

```lua
secrecy = C_Secrets.GetSpellCooldownSecrecy(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secrecy` | SecrecyLevel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local secrecy = C_Secrets.GetSpellCooldownSecrecy(2050)
```

### C_Secrets.HasSecretRestrictions

Returns true if this client build has secret value restrictions enabled. If false, all APIs that are tagged as potentially returning secrets will never do so.

```lua
hasSecretRestrictions = C_Secrets.HasSecretRestrictions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretRestrictions` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretRestrictions = C_Secrets.HasSecretRestrictions()
```

### C_Secrets.ShouldActionCooldownBeSecret

Returns true if a given action bar slot ID will produce secret values for cooldowns if queried.

```lua
isCooldownSecret = C_Secrets.ShouldActionCooldownBeSecret(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCooldownSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCooldownSecret = C_Secrets.ShouldActionCooldownBeSecret(1)
```

### C_Secrets.ShouldAurasBeSecret

Returns true if queries for aura data will generally produce secret values.

```lua
hasSecretAuras = C_Secrets.ShouldAurasBeSecret()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretAuras` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretAuras = C_Secrets.ShouldAurasBeSecret()
```

### C_Secrets.ShouldCooldownsBeSecret

Returns true if queries for cooldown data will generally produce secret values.

```lua
hasSecretCooldowns = C_Secrets.ShouldCooldownsBeSecret()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretCooldowns` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretCooldowns = C_Secrets.ShouldCooldownsBeSecret()
```

### C_Secrets.ShouldSpellAuraBeSecret

Returns true if a given spell identifier would, if applied as an aura, produce secret values when queried.

```lua
isAuraSecret = C_Secrets.ShouldSpellAuraBeSecret(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAuraSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAuraSecret = C_Secrets.ShouldSpellAuraBeSecret(2050)
```

### C_Secrets.ShouldSpellBookItemCooldownBeSecret

Returns true if a given spellbook item will produce secret values for cooldowns if queried.

```lua
isCooldownSecret = C_Secrets.ShouldSpellBookItemCooldownBeSecret(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCooldownSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCooldownSecret = C_Secrets.ShouldSpellBookItemCooldownBeSecret(1, 2050)
```

### C_Secrets.ShouldSpellCooldownBeSecret

Returns true if a given spell identifier will produce secret values for cooldowns if queried.

```lua
isCooldownSecret = C_Secrets.ShouldSpellCooldownBeSecret(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCooldownSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCooldownSecret = C_Secrets.ShouldSpellCooldownBeSecret(2050)
```

### C_Secrets.ShouldTotemSlotBeSecret

Returns true if information about a totem slot will produce secret values if queried.

```lua
isTotemSecret = C_Secrets.ShouldTotemSlotBeSecret(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTotemSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTotemSecret = C_Secrets.ShouldTotemSlotBeSecret(1)
```

### C_Secrets.ShouldTotemSpellBeSecret

Returns true if information about a spell when associated with a totem slot will produce secret values if queried.

```lua
isTotemSecret = C_Secrets.ShouldTotemSpellBeSecret(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTotemSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTotemSecret = C_Secrets.ShouldTotemSpellBeSecret(2050)
```

### C_Secrets.ShouldUnitAuraIndexBeSecret

Returns true if a given aura index will produce secret values if queried.

```lua
isAuraSecret = C_Secrets.ShouldUnitAuraIndexBeSecret(unit, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAuraSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAuraSecret = C_Secrets.ShouldUnitAuraIndexBeSecret("player", 1)
```

### C_Secrets.ShouldUnitAuraInstanceBeSecret

Returns true if a given aura instance ID will produce secret values if queried.

```lua
isAuraSecret = C_Secrets.ShouldUnitAuraInstanceBeSecret(unit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAuraSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAuraSecret = C_Secrets.ShouldUnitAuraInstanceBeSecret("player", 0)
```

### C_Secrets.ShouldUnitAuraSlotBeSecret

Returns true if a given aura slot ID will produce secret values if queried.

```lua
isAuraSecret = C_Secrets.ShouldUnitAuraSlotBeSecret(unit, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `slot` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAuraSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAuraSecret = C_Secrets.ShouldUnitAuraSlotBeSecret("player", 1)
```

### C_Secrets.ShouldUnitComparisonBeSecret

Returns true if queries that compare units will produce secret values.

```lua
isUnitComparisonSecret = C_Secrets.ShouldUnitComparisonBeSecret(unit1, unit2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit1` | UnitToken | no |  |
| `unit2` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitComparisonSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitComparisonSecret = C_Secrets.ShouldUnitComparisonBeSecret("player", "player")
```

### C_Secrets.ShouldUnitHealthMaxBeSecret

Returns true if queries for maximum unit health will produce secret values.

```lua
isUnitHealthMaxSecret = C_Secrets.ShouldUnitHealthMaxBeSecret(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitHealthMaxSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitHealthMaxSecret = C_Secrets.ShouldUnitHealthMaxBeSecret("player")
```

### C_Secrets.ShouldUnitIdentityBeSecret

Returns true if queries for unit identity (such as name or GUID) will produce secret values.

```lua
isUnitIdentitySecret = C_Secrets.ShouldUnitIdentityBeSecret(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitIdentitySecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitIdentitySecret = C_Secrets.ShouldUnitIdentityBeSecret("player")
```

### C_Secrets.ShouldUnitPowerBeSecret

Returns true if queries for unit power will produce secret values.

```lua
isUnitPowerSecret = C_Secrets.ShouldUnitPowerBeSecret(unit, [powerType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `powerType` | PowerType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitPowerSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitPowerSecret = C_Secrets.ShouldUnitPowerBeSecret("player")
```

### C_Secrets.ShouldUnitPowerMaxBeSecret

Returns true if queries for maximum unit power will produce secret values.

```lua
isUnitPowerMaxSecret = C_Secrets.ShouldUnitPowerMaxBeSecret(unit, [powerType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `powerType` | PowerType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitPowerMaxSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitPowerMaxSecret = C_Secrets.ShouldUnitPowerMaxBeSecret("player")
```

### C_Secrets.ShouldUnitSpellCastBeSecret

Returns true if queries for spell casting information for a unit would produce secret values when queried.

```lua
isSpellCastSecret = C_Secrets.ShouldUnitSpellCastBeSecret(unit, spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpellCastSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSpellCastSecret = C_Secrets.ShouldUnitSpellCastBeSecret("player", 2050)
```

### C_Secrets.ShouldUnitSpellCastingBeSecret

Returns true if queries for spell casting information for a specific unit will generally produce secret values.

```lua
isSpellCastingSecret = C_Secrets.ShouldUnitSpellCastingBeSecret(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpellCastingSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSpellCastingSecret = C_Secrets.ShouldUnitSpellCastingBeSecret("player")
```

### C_Secrets.ShouldUnitStatsBeSecret

Returns true if queries for unit statistics will produce secret values.

```lua
hasSecretStats = C_Secrets.ShouldUnitStatsBeSecret()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretStats` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretStats = C_Secrets.ShouldUnitStatsBeSecret()
```

### C_Secrets.ShouldUnitThreatStateBeSecret

Returns true if queries for unit threat status will produce secret values.

```lua
isUnitThreatSecret = C_Secrets.ShouldUnitThreatStateBeSecret(unit, [mobUnit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobUnit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitThreatSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitThreatSecret = C_Secrets.ShouldUnitThreatStateBeSecret("player")
```

### C_Secrets.ShouldUnitThreatValuesBeSecret

Returns true if queries for unit threat values will produce secret values.

```lua
isUnitThreatSecret = C_Secrets.ShouldUnitThreatValuesBeSecret(unit, mobUnit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobUnit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnitThreatSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnitThreatSecret = C_Secrets.ShouldUnitThreatValuesBeSecret("player", "player")
```

