# C_LootJournal

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **1** events · **2** types

## Functions

### C_LootJournal.GetItemSetItems

```lua
items = C_LootJournal.GetItemSetItems(setID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `items` | LootJournalItemInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local items = C_LootJournal.GetItemSetItems(0)
```

### C_LootJournal.GetItemSets

```lua
itemSets = C_LootJournal.GetItemSets([classID], [specID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | yes |  |
| `specID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemSets` | LootJournalItemSetInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemSets = C_LootJournal.GetItemSets()
```

## Events

### LOOT_JOURNAL_ITEM_UPDATE

## Types

### LootJournalItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `icon` | fileID | no |  |
| `invType` | luaIndex | no |  |

### LootJournalItemSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |
| `itemLevel` | number | no |  |
| `name` | cstring | no |  |

