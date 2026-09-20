# C_PaperDollInfo

[← API index](../README.md) · group: [Player & Character](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**21** functions · **23** events · **4** types

## Functions

### C_PaperDollInfo.AmmoNeeded

```lua
ammoNeeded = C_PaperDollInfo.AmmoNeeded()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ammoNeeded` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ammoNeeded = C_PaperDollInfo.AmmoNeeded()
```

### C_PaperDollInfo.CanAutoEquipCursorItem

```lua
canAutoEquip = C_PaperDollInfo.CanAutoEquipCursorItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAutoEquip` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAutoEquip = C_PaperDollInfo.CanAutoEquipCursorItem()
```

### C_PaperDollInfo.CancelTemporaryEnchantment

Cancels active temporary enchantments on inventory slot items.

```lua
C_PaperDollInfo.CancelTemporaryEnchantment(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | LuaInventorySlot | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PaperDollInfo.CancelTemporaryEnchantment(1)
```

### C_PaperDollInfo.CursorCanGoInSlot

```lua
canOccupySlot = C_PaperDollInfo.CursorCanGoInSlot(slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canOccupySlot` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canOccupySlot = C_PaperDollInfo.CursorCanGoInSlot(1)
```

### C_PaperDollInfo.GetArmorEffectiveness

```lua
effectiveness = C_PaperDollInfo.GetArmorEffectiveness(armor, attackerLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `armor` | number | no |  |
| `attackerLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveness` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveness = C_PaperDollInfo.GetArmorEffectiveness(0, 0)
```

### C_PaperDollInfo.GetArmorEffectivenessAgainstTarget

```lua
effectiveness = C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(armor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `armor` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveness` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveness = C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(0)
```

### C_PaperDollInfo.GetInspectAzeriteItemEmpoweredChoices

```lua
azeritePowerIDs = C_PaperDollInfo.GetInspectAzeriteItemEmpoweredChoices(unit, equipmentSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `equipmentSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeritePowerIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local azeritePowerIDs = C_PaperDollInfo.GetInspectAzeriteItemEmpoweredChoices("player", 1)
```

### C_PaperDollInfo.GetInspectGuildInfo

```lua
achievementPoints, numMembers, guildName, realmName = C_PaperDollInfo.GetInspectGuildInfo(unitString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitString` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementPoints` | number | no |  |
| `numMembers` | number | no |  |
| `guildName` | string | no |  |
| `realmName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local achievementPoints, numMembers, guildName, realmName = C_PaperDollInfo.GetInspectGuildInfo("player")
```

### C_PaperDollInfo.GetInspectItemLevel

```lua
equippedItemLevel = C_PaperDollInfo.GetInspectItemLevel(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equippedItemLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local equippedItemLevel = C_PaperDollInfo.GetInspectItemLevel("player")
```

### C_PaperDollInfo.GetInspectRatedBGBlitzData

```lua
ratedBGBlitzData = C_PaperDollInfo.GetInspectRatedBGBlitzData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratedBGBlitzData` | InspectPVPData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ratedBGBlitzData = C_PaperDollInfo.GetInspectRatedBGBlitzData()
```

### C_PaperDollInfo.GetInspectRatedBGData

```lua
ratedBGData = C_PaperDollInfo.GetInspectRatedBGData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratedBGData` | InspectRatedBGData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ratedBGData = C_PaperDollInfo.GetInspectRatedBGData()
```

### C_PaperDollInfo.GetInspectRatedSoloShuffleData

```lua
ratedSoloShuffleData = C_PaperDollInfo.GetInspectRatedSoloShuffleData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratedSoloShuffleData` | InspectPVPData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ratedSoloShuffleData = C_PaperDollInfo.GetInspectRatedSoloShuffleData()
```

### C_PaperDollInfo.GetInventorySlotInfo

```lua
invSlot, slotTexture, checkRelic = C_PaperDollInfo.GetInventorySlotInfo(slotName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlot` | number | no |  |
| `slotTexture` | fileID | no |  |
| `checkRelic` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invSlot, slotTexture, checkRelic = C_PaperDollInfo.GetInventorySlotInfo(1)
```

### C_PaperDollInfo.GetInventorySlotInfoForInvSlot

```lua
invSlot, slotTexture, checkRelic, slotName = C_PaperDollInfo.GetInventorySlotInfoForInvSlot(invSlotValue)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlotValue` | number | no | This is the Lua version of the INVSLOT enum, not a luaIndex |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlot` | number | no |  |
| `slotTexture` | fileID | no |  |
| `checkRelic` | bool | no |  |
| `slotName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invSlot, slotTexture, checkRelic, slotName = C_PaperDollInfo.GetInventorySlotInfoForInvSlot(1)
```

### C_PaperDollInfo.GetMinItemLevel

```lua
minItemLevel = C_PaperDollInfo.GetMinItemLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minItemLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minItemLevel = C_PaperDollInfo.GetMinItemLevel()
```

### C_PaperDollInfo.GetStaggerPercentage

```lua
stagger, staggerAgainstTarget = C_PaperDollInfo.GetStaggerPercentage(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stagger` | number | no |  |
| `staggerAgainstTarget` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local stagger, staggerAgainstTarget = C_PaperDollInfo.GetStaggerPercentage("player")
```

### C_PaperDollInfo.GetTemporaryEnchantmentInfo

Queries information about active temporary enchants on inventory slot items.

```lua
enchantInfo = C_PaperDollInfo.GetTemporaryEnchantmentInfo(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | LuaInventorySlot | no | An appropriate INVSLOT_ constant. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enchantInfo` | TemporaryItemEnchantInfo | no | Returns nothing if no temporary enchantment is active for this slot. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enchantInfo = C_PaperDollInfo.GetTemporaryEnchantmentInfo(1)
```

### C_PaperDollInfo.IsInventorySlotEnabled

```lua
isEnabled = C_PaperDollInfo.IsInventorySlotEnabled(slotName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotName` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_PaperDollInfo.IsInventorySlotEnabled(1)
```

### C_PaperDollInfo.IsRangedSlotShown

```lua
isShown = C_PaperDollInfo.IsRangedSlotShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isShown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isShown = C_PaperDollInfo.IsRangedSlotShown()
```

### C_PaperDollInfo.OffhandHasShield

```lua
offhandHasShield = C_PaperDollInfo.OffhandHasShield()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offhandHasShield` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offhandHasShield = C_PaperDollInfo.OffhandHasShield()
```

### C_PaperDollInfo.OffhandHasWeapon

```lua
offhandHasWeapon = C_PaperDollInfo.OffhandHasWeapon()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offhandHasWeapon` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offhandHasWeapon = C_PaperDollInfo.OffhandHasWeapon()
```

## Events

### AVOIDANCE_UPDATE

### CHARACTER_POINTS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `change` | number | no |  |

### CHARACTER_UPGRADE_SPELL_TIER_SET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierIndex` | number | no |  |

### COMBAT_RATING_UPDATE

### DISABLE_XP_GAIN

### ENABLE_XP_GAIN

### EQUIP_BIND_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |
| `itemLocation` | ItemLocation | no |  |

### INSPECT_HONOR_UPDATE

### INSPECT_READY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inspecteeGUID` | WOWGUID | no |  |

### LIFESTEAL_UPDATE

### MASTERY_UPDATE

### PET_STATS_UPDATE

### PLAYER_AVG_ITEM_LEVEL_UPDATE

### PLAYER_EQUIPMENT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSlot` | number | no |  |
| `hasCurrent` | bool | no |  |

### PROFESSION_EQUIPMENT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |
| `isTool` | bool | no |  |

### PVP_POWER_UPDATE

### SPEED_UPDATE

### SPELL_POWER_CHANGED

### STURDINESS_UPDATE

### UPDATE_FACTION

### UPDATE_INVENTORY_ALERTS

### UPDATE_INVENTORY_DURABILITY

### WEAPON_SLOT_CHANGED

## Types

### InspectGuildInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementPoints` | number | no |  |
| `numMembers` | number | no |  |
| `guildName` | string | no |  |
| `realmName` | string | no |  |

### InspectPVPData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rating` | number | no |  |
| `gamesWon` | number | no |  |
| `gamesPlayed` | number | no |  |
| `roundsWon` | number | no |  |
| `roundsPlayed` | number | no |  |

### InspectRatedBGData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rating` | number | no |  |
| `played` | number | no |  |
| `won` | number | no |  |

### TemporaryItemEnchantInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enchantID` | number | no |  |
| `remainingTimeMs` | number | no |  |
| `chargesRemaining` | number | no |  |
| `hasExpirationTime` | bool | no |  |

