# C_AzeriteEmpoweredItem

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**18** functions · **2** events · **5** types

## Functions

### C_AzeriteEmpoweredItem.CanSelectPower

```lua
canSelect = C_AzeriteEmpoweredItem.CanSelectPower(azeriteEmpoweredItemLocation, powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSelect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSelect = C_AzeriteEmpoweredItem.CanSelectPower(6948, 0)
```

### C_AzeriteEmpoweredItem.ConfirmAzeriteEmpoweredItemRespec

```lua
C_AzeriteEmpoweredItem.ConfirmAzeriteEmpoweredItemRespec(azeriteEmpoweredItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEmpoweredItem.ConfirmAzeriteEmpoweredItemRespec(6948)
```

### C_AzeriteEmpoweredItem.GetAllTierInfo

```lua
tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo(azeriteEmpoweredItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierInfo` | AzeriteEmpoweredItemTierInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo(6948)
```

### C_AzeriteEmpoweredItem.GetAllTierInfoByItemID

```lua
tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemInfo, [classID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `classID` | number | yes | Specify a class ID to get tier information about that class, otherwise uses the player's class if left nil |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierInfo` | AzeriteEmpoweredItemTierInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(6948)
```

### C_AzeriteEmpoweredItem.GetAzeriteEmpoweredItemRespecCost

```lua
cost = C_AzeriteEmpoweredItem.GetAzeriteEmpoweredItemRespecCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cost = C_AzeriteEmpoweredItem.GetAzeriteEmpoweredItemRespecCost()
```

### C_AzeriteEmpoweredItem.GetPowerInfo

```lua
powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerInfo` | AzeriteEmpoweredItemPowerInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(0)
```

### C_AzeriteEmpoweredItem.GetPowerText

```lua
powerText = C_AzeriteEmpoweredItem.GetPowerText(azeriteEmpoweredItemLocation, powerID, level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |
| `powerID` | number | no |  |
| `level` | AzeritePowerLevel | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerText` | AzeriteEmpoweredItemPowerText | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerText = C_AzeriteEmpoweredItem.GetPowerText(6948, 0, Enum.AzeritePowerLevel.Base)
```

### C_AzeriteEmpoweredItem.GetSpecsForPower

```lua
specInfo = C_AzeriteEmpoweredItem.GetSpecsForPower(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specInfo` | AzeriteSpecInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specInfo = C_AzeriteEmpoweredItem.GetSpecsForPower(0)
```

### C_AzeriteEmpoweredItem.HasAnyUnselectedPowers

```lua
hasAnyUnselectedPowers = C_AzeriteEmpoweredItem.HasAnyUnselectedPowers(azeriteEmpoweredItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyUnselectedPowers` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnyUnselectedPowers = C_AzeriteEmpoweredItem.HasAnyUnselectedPowers(6948)
```

### C_AzeriteEmpoweredItem.HasBeenViewed

```lua
hasBeenViewed = C_AzeriteEmpoweredItem.HasBeenViewed(azeriteEmpoweredItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBeenViewed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasBeenViewed = C_AzeriteEmpoweredItem.HasBeenViewed(6948)
```

### C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem

```lua
isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAzeriteEmpoweredItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(6948)
```

### C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID

```lua
isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAzeriteEmpoweredItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(6948)
```

### C_AzeriteEmpoweredItem.IsAzeritePreviewSourceDisplayable

```lua
isAzeritePreviewSourceDisplayable = C_AzeriteEmpoweredItem.IsAzeritePreviewSourceDisplayable(itemInfo, [classID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `classID` | number | yes | Specify a class ID to determine if its displayable for that class, otherwise uses the player's class if left nil |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAzeritePreviewSourceDisplayable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAzeritePreviewSourceDisplayable = C_AzeriteEmpoweredItem.IsAzeritePreviewSourceDisplayable(6948)
```

### C_AzeriteEmpoweredItem.IsHeartOfAzerothEquipped

```lua
isHeartOfAzerothEquipped = C_AzeriteEmpoweredItem.IsHeartOfAzerothEquipped()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHeartOfAzerothEquipped` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHeartOfAzerothEquipped = C_AzeriteEmpoweredItem.IsHeartOfAzerothEquipped()
```

### C_AzeriteEmpoweredItem.IsPowerAvailableForSpec

```lua
isPowerAvailableForSpec = C_AzeriteEmpoweredItem.IsPowerAvailableForSpec(powerID, specID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |
| `specID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPowerAvailableForSpec` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPowerAvailableForSpec = C_AzeriteEmpoweredItem.IsPowerAvailableForSpec(0, 0)
```

### C_AzeriteEmpoweredItem.IsPowerSelected

```lua
isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(azeriteEmpoweredItemLocation, powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSelected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(6948, 0)
```

### C_AzeriteEmpoweredItem.SelectPower

```lua
success = C_AzeriteEmpoweredItem.SelectPower(azeriteEmpoweredItemLocation, powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_AzeriteEmpoweredItem.SelectPower(6948, 0)
```

### C_AzeriteEmpoweredItem.SetHasBeenViewed

```lua
C_AzeriteEmpoweredItem.SetHasBeenViewed(azeriteEmpoweredItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEmpoweredItem.SetHasBeenViewed(6948)
```

## Events

### AZERITE_EMPOWERED_ITEM_EQUIPPED_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHeartEquipped` | bool | no |  |

### AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteEmpoweredItemLocation` | AzeriteEmpoweredItemLocation | no |  |

## Types

### AzeriteEmpoweredItemPowerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeritePowerID` | number | no |  |
| `spellID` | number | no |  |

### AzeriteEmpoweredItemPowerText (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |

### AzeriteEmpoweredItemTierInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeritePowerIDs` | number[] | no |  |
| `unlockLevel` | number | no |  |

### AzeritePowerLevel (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Base` | AzeritePowerLevel | no |  |
| `Upgraded` | AzeritePowerLevel | no |  |
| `Downgraded` | AzeritePowerLevel | no |  |

### AzeriteSpecInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |
| `specID` | number | no |  |

