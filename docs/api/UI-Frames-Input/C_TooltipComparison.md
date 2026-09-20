# C_TooltipComparison

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**3** functions · **1** events · **2** types

## Functions

### C_TooltipComparison.CompareItem

```lua
C_TooltipComparison.CompareItem(comparisonItem, tooltip, [anchorFrame])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparisonItem` | TooltipComparisonItem | no |  |
| `tooltip` | Tooltip | no |  |
| `anchorFrame` | SimpleFrame | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TooltipComparison.CompareItem(6948, tooltip)
```

### C_TooltipComparison.GetItemComparisonDelta

```lua
lines = C_TooltipComparison.GetItemComparisonDelta(comparisonItem, equippedItem, [pairedItem], [addPairedStats])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparisonItem` | TooltipComparisonItem | no |  |
| `equippedItem` | TooltipComparisonItem | no |  |
| `pairedItem` | TooltipComparisonItem | yes |  |
| `addPairedStats` | bool | yes | Whether the paired item's stats are added or subtracted |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lines` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lines = C_TooltipComparison.GetItemComparisonDelta(6948, 6948)
```

### C_TooltipComparison.GetItemComparisonInfo

```lua
info = C_TooltipComparison.GetItemComparisonInfo(comparisonItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparisonItem` | TooltipComparisonItem | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | TooltipItemComparisonInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TooltipComparison.GetItemComparisonInfo(6948)
```

## Events

### TOOLTIP_SHOW_ITEM_COMPARISON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparisonItem` | TooltipComparisonItem | no |  |
| `tooltip` | Tooltip | no |  |
| `anchorFrame` | SimpleFrame | yes |  |

## Types

### TooltipComparisonMethod (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Single` | TooltipComparisonMethod | no |  |
| `WithBothHands` | TooltipComparisonMethod | no |  |
| `WithBagMainHandItem` | TooltipComparisonMethod | no |  |
| `WithBagOffHandItem` | TooltipComparisonMethod | no |  |

### TooltipItemComparisonInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `method` | TooltipComparisonMethod | no | (default: Single) |
| `item` | TooltipComparisonItem | no |  |
| `additionalItems` | TooltipComparisonItem[] | no |  |

