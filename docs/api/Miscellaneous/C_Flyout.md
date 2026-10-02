# C_Flyout

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**6** functions · **0** events · **2** types

## Functions

### C_Flyout.FlyoutHasSpell

```lua
hasSpell = C_Flyout.FlyoutHasSpell(flyoutID, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSpell` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSpell = C_Flyout.FlyoutHasSpell(0, 2050)
```

### C_Flyout.GetFlyoutID

```lua
flyoutID = C_Flyout.GetFlyoutID(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flyoutID = C_Flyout.GetFlyoutID(1)
```

### C_Flyout.GetFlyoutInfo

```lua
info = C_Flyout.GetFlyoutInfo(flyoutID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | FlyoutInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Flyout.GetFlyoutInfo(0)
```

### C_Flyout.GetFlyoutSlotInfo

```lua
slotInfo = C_Flyout.GetFlyoutSlotInfo(flyoutID, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotInfo` | FlyoutSlotInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotInfo = C_Flyout.GetFlyoutSlotInfo(0, 1)
```

### C_Flyout.GetFlyoutTexture

```lua
textureID = C_Flyout.GetFlyoutTexture(flyoutID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureID` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureID = C_Flyout.GetFlyoutTexture(0)
```

### C_Flyout.GetNumFlyouts

```lua
numFlyouts = C_Flyout.GetNumFlyouts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFlyouts` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numFlyouts = C_Flyout.GetNumFlyouts()
```

## Types

### FlyoutInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |
| `numSlots` | number | no |  |
| `isKnown` | bool | no |  |

### FlyoutSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `overrideSpellID` | number | no |  |
| `isKnown` | bool | no |  |
| `name` | string | yes |  |
| `specID` | number | yes |  |

