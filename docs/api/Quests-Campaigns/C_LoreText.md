# C_LoreText

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

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
