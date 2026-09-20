# GameCursor

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**19** functions · **0** events · **0** types

## Functions

### GameCursor.ClearCursor

```lua
ClearCursor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearCursor()
```

### GameCursor.ClearCursorHoveredItem

```lua
ClearCursorHoveredItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearCursorHoveredItem()
```

### GameCursor.CursorHasItem

```lua
result = CursorHasItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CursorHasItem()
```

### GameCursor.CursorHasMacro

```lua
result = CursorHasMacro()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CursorHasMacro()
```

### GameCursor.CursorHasMoney

```lua
result = CursorHasMoney()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CursorHasMoney()
```

### GameCursor.CursorHasSpell

```lua
result = CursorHasSpell()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CursorHasSpell()
```

### GameCursor.DeleteCursorItem

```lua
DeleteCursorItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
DeleteCursorItem()
```

### GameCursor.DropCursorMoney

```lua
DropCursorMoney()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
DropCursorMoney()
```

### GameCursor.EquipCursorItem

```lua
EquipCursorItem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EquipCursorItem(1)
```

### GameCursor.GetCursorInfo

```lua
GetCursorInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
GetCursorInfo()
```

### GameCursor.GetCursorMoney

```lua
amount = GetCursorMoney()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount = GetCursorMoney()
```

### GameCursor.PickupPlayerMoney

```lua
PickupPlayerMoney(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
PickupPlayerMoney(0)
```

### GameCursor.ResetCursor

```lua
ResetCursor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetCursor()
```

### GameCursor.SellCursorItem

```lua
SellCursorItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SellCursorItem()
```

### GameCursor.SetCursor

```lua
result = SetCursor([name])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = SetCursor()
```

### GameCursor.SetCursorByMode

```lua
result = SetCursorByMode(mode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mode` | Cursormode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = SetCursorByMode(mode)
```

### GameCursor.SetCursorHoveredItem

```lua
SetCursorHoveredItem(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCursorHoveredItem(6948)
```

### GameCursor.SetCursorHoveredItemTradeItem

```lua
SetCursorHoveredItemTradeItem(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCursorHoveredItemTradeItem(false)
```

### GameCursor.SetCursorVirtualItem

```lua
SetCursorVirtualItem(itemInfo, cursorType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `cursorType` | UICursorType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCursorVirtualItem(6948, cursorType)
```

