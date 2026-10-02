# C_SpellActivationOverlay

[← API index](../README.md) · group: [Spells, Auras & Talents](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**1** functions · **4** events · **0** types

## Functions

### C_SpellActivationOverlay.IsSpellOverlayed

```lua
isSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpellOverlayed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed(2050)
```

## Events

### SPELL_ACTIVATION_OVERLAY_GLOW_HIDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

### SPELL_ACTIVATION_OVERLAY_GLOW_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

### SPELL_ACTIVATION_OVERLAY_HIDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |

### SPELL_ACTIVATION_OVERLAY_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `overlayFileDataID` | number | no |  |
| `locationType` | ScreenLocationType | no |  |
| `scale` | number | no |  |
| `r` | number | no |  |
| `g` | number | no |  |
| `b` | number | no |  |
