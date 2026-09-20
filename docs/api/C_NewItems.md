# C_NewItems

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_NewItems.ClearAll

```lua
C_NewItems.ClearAll()
```

**Example**

```lua
C_NewItems.ClearAll()
```

### C_NewItems.IsNewItem

```lua
isNew = C_NewItems.IsNewItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNew` | bool | no |  |

**Example**

```lua
local isNew = C_NewItems.IsNewItem(1, 1)
```

### C_NewItems.RemoveNewItem

```lua
C_NewItems.RemoveNewItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Example**

```lua
C_NewItems.RemoveNewItem(1, 1)
```

