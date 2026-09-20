# C_StorePublic

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_StorePublic.DoesGroupHavePurchaseableProducts

```lua
hasPurchaseableProducts = C_StorePublic.DoesGroupHavePurchaseableProducts(groupID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPurchaseableProducts` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPurchaseableProducts = C_StorePublic.DoesGroupHavePurchaseableProducts(0)
```

### C_StorePublic.EventStoreUISetShown

```lua
C_StorePublic.EventStoreUISetShown(newShown, [contextKey])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newShown` | bool | no |  |
| `contextKey` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StorePublic.EventStoreUISetShown(false)
```

### C_StorePublic.IsEnabled

```lua
enabled = C_StorePublic.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_StorePublic.IsEnabled()
```

