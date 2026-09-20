# C_Bank

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**26** functions · **7** events · **3** types

## Functions

### C_Bank.AreAnyBankTypesViewable

```lua
areAnyBankTypesViewable = C_Bank.AreAnyBankTypesViewable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAnyBankTypesViewable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areAnyBankTypesViewable = C_Bank.AreAnyBankTypesViewable()
```

### C_Bank.AutoDepositItemsIntoBank

```lua
C_Bank.AutoDepositItemsIntoBank(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.AutoDepositItemsIntoBank(bankType)
```

### C_Bank.BankBagTypeAndIDToInvSlot

```lua
slot = C_Bank.BankBagTypeAndIDToInvSlot(bankType, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slot = C_Bank.BankBagTypeAndIDToInvSlot(bankType, 1)
```

### C_Bank.CanDepositMoney

```lua
canDepositMoney = C_Bank.CanDepositMoney(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDepositMoney` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canDepositMoney = C_Bank.CanDepositMoney(bankType)
```

### C_Bank.CanPurchaseBankTab

```lua
canPurchaseBankTab = C_Bank.CanPurchaseBankTab(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPurchaseBankTab` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canPurchaseBankTab = C_Bank.CanPurchaseBankTab(bankType)
```

### C_Bank.CanUseBank

```lua
canUseBank = C_Bank.CanUseBank(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseBank` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUseBank = C_Bank.CanUseBank(bankType)
```

### C_Bank.CanViewBank

```lua
canViewBank = C_Bank.CanViewBank(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canViewBank` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canViewBank = C_Bank.CanViewBank(bankType)
```

### C_Bank.CanWithdrawMoney

```lua
canWithdrawMoney = C_Bank.CanWithdrawMoney(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canWithdrawMoney` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canWithdrawMoney = C_Bank.CanWithdrawMoney(bankType)
```

### C_Bank.CloseBankFrame

```lua
C_Bank.CloseBankFrame()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.CloseBankFrame()
```

### C_Bank.DepositMoney

```lua
C_Bank.DepositMoney(bankType, amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.DepositMoney(bankType, 0)
```

### C_Bank.DoesBankTypeSupportAutoDeposit

```lua
doesBankTypeSupportAutoDeposit = C_Bank.DoesBankTypeSupportAutoDeposit(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesBankTypeSupportAutoDeposit` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doesBankTypeSupportAutoDeposit = C_Bank.DoesBankTypeSupportAutoDeposit(bankType)
```

### C_Bank.DoesBankTypeSupportMoneyTransfer

```lua
doesBankTypeSupportMoneyTransfer = C_Bank.DoesBankTypeSupportMoneyTransfer(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesBankTypeSupportMoneyTransfer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doesBankTypeSupportMoneyTransfer = C_Bank.DoesBankTypeSupportMoneyTransfer(bankType)
```

### C_Bank.FetchBankLockedReason

```lua
reason = C_Bank.FetchBankLockedReason(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | BankLockedReason | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reason = C_Bank.FetchBankLockedReason(bankType)
```

### C_Bank.FetchDepositedMoney

```lua
amount = C_Bank.FetchDepositedMoney(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount = C_Bank.FetchDepositedMoney(bankType)
```

### C_Bank.FetchMaxNumBankTabs

```lua
numPurchasedBankTabs = C_Bank.FetchMaxNumBankTabs(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPurchasedBankTabs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numPurchasedBankTabs = C_Bank.FetchMaxNumBankTabs(bankType)
```

### C_Bank.FetchNextPurchasableBankTabData

```lua
nextPurchasableTabData = C_Bank.FetchNextPurchasableBankTabData(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nextPurchasableTabData` | PurchasableBankTabData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nextPurchasableTabData = C_Bank.FetchNextPurchasableBankTabData(bankType)
```

### C_Bank.FetchNumPurchasedBankTabs

```lua
numPurchasedBankTabs = C_Bank.FetchNumPurchasedBankTabs(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPurchasedBankTabs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numPurchasedBankTabs = C_Bank.FetchNumPurchasedBankTabs(bankType)
```

### C_Bank.FetchPurchasedBankTabData

```lua
purchasedBankTabData = C_Bank.FetchPurchasedBankTabData(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `purchasedBankTabData` | BankTabData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local purchasedBankTabData = C_Bank.FetchPurchasedBankTabData(bankType)
```

### C_Bank.FetchPurchasedBankTabIDs

```lua
purchasedBankTabIDs = C_Bank.FetchPurchasedBankTabIDs(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `purchasedBankTabIDs` | BagIndex[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local purchasedBankTabIDs = C_Bank.FetchPurchasedBankTabIDs(bankType)
```

### C_Bank.FetchViewableBankTypes

```lua
viewableBankTypes = C_Bank.FetchViewableBankTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `viewableBankTypes` | BankType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local viewableBankTypes = C_Bank.FetchViewableBankTypes()
```

### C_Bank.HasMaxBankTabs

```lua
hasMaxBankTabs = C_Bank.HasMaxBankTabs(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxBankTabs` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMaxBankTabs = C_Bank.HasMaxBankTabs(bankType)
```

### C_Bank.IsItemAllowedInBankType

```lua
isItemAllowedInBankType = C_Bank.IsItemAllowedInBankType(bankType, itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemAllowedInBankType` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isItemAllowedInBankType = C_Bank.IsItemAllowedInBankType(bankType, 6948)
```

### C_Bank.PurchaseBankTab

```lua
C_Bank.PurchaseBankTab(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.PurchaseBankTab(bankType)
```

### C_Bank.ShouldUsePlayerBagsInBank

```lua
shouldUsePlayerBagsInBank = C_Bank.ShouldUsePlayerBagsInBank()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldUsePlayerBagsInBank` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldUsePlayerBagsInBank = C_Bank.ShouldUsePlayerBagsInBank()
```

### C_Bank.UpdateBankTabSettings

```lua
C_Bank.UpdateBankTabSettings(bankType, tabID, tabName, tabIcon, depositFlags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |
| `tabID` | BagIndex | no |  |
| `tabName` | cstring | no |  |
| `tabIcon` | cstring | no |  |
| `depositFlags` | BagSlotFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.UpdateBankTabSettings(bankType, Enum.BagIndex.Accountbanktab, "", "", depositFlags)
```

### C_Bank.WithdrawMoney

```lua
C_Bank.WithdrawMoney(bankType, amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Bank.WithdrawMoney(bankType, 0)
```

## Events

### BANK_BAG_SLOT_FLAGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |

### BANKFRAME_CLOSED

### BANKFRAME_OPENED

### BANK_TABS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

### BANK_TAB_SETTINGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

### PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |

### PLAYERBANKSLOTS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |

## Types

### BankLockedReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | BankLockedReason | no |  |
| `NoAccountInventoryLock` | BankLockedReason | no |  |
| `BankDisabled` | BankLockedReason | no |  |
| `BankConversionFailed` | BankLockedReason | no |  |

### BankTabData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `bankType` | BankType | no |  |
| `name` | cstring | no |  |
| `icon` | fileID | no |  |
| `depositFlags` | BagSlotFlags | no |  |
| `tabCleanupConfirmation` | cstring | no |  |
| `tabNameEditBoxHeader` | cstring | no |  |

### PurchasableBankTabData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabCost` | BigUInteger | no |  |
| `canAfford` | bool | no |  |
| `purchasePromptTitle` | cstring | no |  |
| `purchasePromptBody` | cstring | no |  |
| `purchasePromptConfirmation` | cstring | no |  |

