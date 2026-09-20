# C_ZoneAbility

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **1** types

## Functions

### C_ZoneAbility.GetActiveAbilities

```lua
zoneAbilities = C_ZoneAbility.GetActiveAbilities()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoneAbilities` | ZoneAbilityInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local zoneAbilities = C_ZoneAbility.GetActiveAbilities()
```

### C_ZoneAbility.GetZoneAbilityIcon

```lua
zoneAbilityIconID = C_ZoneAbility.GetZoneAbilityIcon(zoneAbilitySpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoneAbilitySpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoneAbilityIconID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local zoneAbilityIconID = C_ZoneAbility.GetZoneAbilityIcon(2050)
```

## Types

### ZoneAbilityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoneAbilityID` | number | no |  |
| `uiPriority` | number | no |  |
| `spellID` | number | no |  |
| `textureKit` | textureKit | no |  |
| `tutorialText` | cstring | yes |  |

