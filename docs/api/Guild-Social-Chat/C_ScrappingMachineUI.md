# C_ScrappingMachineUI

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **4** events · **0** types

## Functions

### C_ScrappingMachineUI.CloseScrappingMachine

```lua
C_ScrappingMachineUI.CloseScrappingMachine()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.CloseScrappingMachine()
```

### C_ScrappingMachineUI.DropPendingScrapItemFromCursor

```lua
C_ScrappingMachineUI.DropPendingScrapItemFromCursor(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.DropPendingScrapItemFromCursor(1)
```

### C_ScrappingMachineUI.GetCurrentPendingScrapItemLocationByIndex

```lua
itemLoc = C_ScrappingMachineUI.GetCurrentPendingScrapItemLocationByIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemLoc = C_ScrappingMachineUI.GetCurrentPendingScrapItemLocationByIndex(1)
```

### C_ScrappingMachineUI.GetScrappingMachineName

```lua
name = C_ScrappingMachineUI.GetScrappingMachineName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_ScrappingMachineUI.GetScrappingMachineName()
```

### C_ScrappingMachineUI.GetScrapSpellID

```lua
spellID = C_ScrappingMachineUI.GetScrapSpellID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_ScrappingMachineUI.GetScrapSpellID()
```

### C_ScrappingMachineUI.HasScrappableItems

```lua
hasScrappableItems = C_ScrappingMachineUI.HasScrappableItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasScrappableItems` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasScrappableItems = C_ScrappingMachineUI.HasScrappableItems()
```

### C_ScrappingMachineUI.RemoveAllScrapItems

```lua
C_ScrappingMachineUI.RemoveAllScrapItems()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.RemoveAllScrapItems()
```

### C_ScrappingMachineUI.RemoveCurrentScrappingItem

```lua
C_ScrappingMachineUI.RemoveCurrentScrappingItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.RemoveCurrentScrappingItem()
```

### C_ScrappingMachineUI.RemoveItemToScrap

```lua
C_ScrappingMachineUI.RemoveItemToScrap(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.RemoveItemToScrap(1)
```

### C_ScrappingMachineUI.ScrapItems

```lua
C_ScrappingMachineUI.ScrapItems()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.ScrapItems()
```

### C_ScrappingMachineUI.ValidateScrappingList

```lua
C_ScrappingMachineUI.ValidateScrappingList()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ScrappingMachineUI.ValidateScrappingList()
```

## Events

### SCRAPPING_MACHINE_ITEM_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

### SCRAPPING_MACHINE_ITEM_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

### SCRAPPING_MACHINE_PENDING_ITEM_CHANGED

### SCRAPPING_MACHINE_SCRAPPING_FINISHED

