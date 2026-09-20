# C_Cursor

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **4** events · **0** types

## Functions

### C_Cursor.GetCursorItem

```lua
item = C_Cursor.GetCursorItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local item = C_Cursor.GetCursorItem()
```

## Events

### BATTLE_PET_CURSOR_CLEAR

### CURSOR_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDefault` | bool | no |  |
| `newCursorType` | UICursorType | no |  |
| `oldCursorType` | UICursorType | no |  |
| `oldCursorVirtualID` | number | no |  |

### MOUNT_CURSOR_CLEAR

### WORLD_CURSOR_TOOLTIP_UPDATE

Sends an update when the mouse enters or leaves something in-world (object, unit, etc) that should display a tooltip

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchorType` | WorldCursorAnchorType | no |  |

