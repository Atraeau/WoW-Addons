# C_ToyBoxInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **2** events · **0** types

## Functions

### C_ToyBoxInfo.ClearFanfare

```lua
C_ToyBoxInfo.ClearFanfare(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ToyBoxInfo.ClearFanfare(6948)
```

### C_ToyBoxInfo.HasAnyToy

```lua
hasToy = C_ToyBoxInfo.HasAnyToy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasToy` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasToy = C_ToyBoxInfo.HasAnyToy()
```

### C_ToyBoxInfo.IsToySourceValid

```lua
isToySourceValid = C_ToyBoxInfo.IsToySourceValid(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isToySourceValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isToySourceValid = C_ToyBoxInfo.IsToySourceValid(1)
```

### C_ToyBoxInfo.IsUsingDefaultFilters

```lua
isUsingDefaultFilters = C_ToyBoxInfo.IsUsingDefaultFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultFilters` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsingDefaultFilters = C_ToyBoxInfo.IsUsingDefaultFilters()
```

### C_ToyBoxInfo.NeedsFanfare

```lua
needsFanfare = C_ToyBoxInfo.NeedsFanfare(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `needsFanfare` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local needsFanfare = C_ToyBoxInfo.NeedsFanfare(6948)
```

### C_ToyBoxInfo.SetDefaultFilters

```lua
C_ToyBoxInfo.SetDefaultFilters()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ToyBoxInfo.SetDefaultFilters()
```

## Events

### NEW_TOY_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### TOYS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |
| `isNew` | bool | yes |  |
| `hasFanfare` | bool | yes |  |

