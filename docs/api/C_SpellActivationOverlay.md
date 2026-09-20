# C_SpellActivationOverlay

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

```lua
local isSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed(12345)
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

