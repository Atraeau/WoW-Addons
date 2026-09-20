# C_ItemInteraction

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **2** events · **3** types

## Functions

### C_ItemInteraction.ClearPendingItem

```lua
C_ItemInteraction.ClearPendingItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ItemInteraction.ClearPendingItem()
```

### C_ItemInteraction.CloseUI

```lua
C_ItemInteraction.CloseUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ItemInteraction.CloseUI()
```

### C_ItemInteraction.GetChargeInfo

```lua
chargeInfo = C_ItemInteraction.GetChargeInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chargeInfo` | ItemInteractionChargeInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chargeInfo = C_ItemInteraction.GetChargeInfo()
```

### C_ItemInteraction.GetItemConversionCurrencyCost

```lua
conversionCost = C_ItemInteraction.GetItemConversionCurrencyCost(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conversionCost` | ConversionCurrencyCost | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local conversionCost = C_ItemInteraction.GetItemConversionCurrencyCost(6948)
```

### C_ItemInteraction.GetItemInteractionInfo

```lua
info = C_ItemInteraction.GetItemInteractionInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemInteractionFrameInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ItemInteraction.GetItemInteractionInfo()
```

### C_ItemInteraction.GetItemInteractionSpellId

```lua
spellId = C_ItemInteraction.GetItemInteractionSpellId()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellId = C_ItemInteraction.GetItemInteractionSpellId()
```

### C_ItemInteraction.InitializeFrame

```lua
C_ItemInteraction.InitializeFrame()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ItemInteraction.InitializeFrame()
```

### C_ItemInteraction.PerformItemInteraction

```lua
C_ItemInteraction.PerformItemInteraction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ItemInteraction.PerformItemInteraction()
```

### C_ItemInteraction.Reset

```lua
C_ItemInteraction.Reset()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ItemInteraction.Reset()
```

### C_ItemInteraction.SetPendingItem

```lua
success = C_ItemInteraction.SetPendingItem([item])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_ItemInteraction.SetPendingItem()
```

## Events

### ITEM_INTERACTION_CHARGE_INFO_UPDATED

### ITEM_INTERACTION_ITEM_SELECTION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | yes |  |

## Types

### ConversionCurrencyCost (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `amount` | number | no |  |

### ItemInteractionChargeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newChargeAmount` | number | no |  |
| `rechargeRate` | number | no |  |
| `timeToNextCharge` | number | no |  |

### ItemInteractionFrameInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `openSoundKitID` | number | no |  |
| `closeSoundKitID` | number | no |  |
| `titleText` | string | no |  |
| `tutorialText` | string | no |  |
| `buttonText` | string | no |  |
| `interactionType` | UIItemInteractionType | no |  |
| `flags` | UIItemInteractionFlags | no |  |
| `description` | string | yes |  |
| `buttonTooltip` | string | yes |  |
| `confirmationDescription` | string | yes |  |
| `slotTooltip` | string | yes |  |
| `cost` | number | yes |  |
| `currencyTypeId` | number | yes |  |
| `dropInSlotSoundKitId` | number | yes |  |

