# C_LoreText

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**1** functions · **1** events · **1** types

## Functions

### C_LoreText.RequestLoreTextForCampaignID

```lua
C_LoreText.RequestLoreTextForCampaignID(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LoreText.RequestLoreTextForCampaignID(0)
```

## Events

### LORE_TEXT_UPDATED_CAMPAIGN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |
| `textEntries` | LoreTextEntry[] | no |  |

## Types

### LoreTextEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `isHeader` | bool | no |  |

