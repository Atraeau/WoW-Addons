# C_EndOfMatchUI

[← API index](../README.md) · group: [UI Systems & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**1** functions · **1** events · **4** types

## Functions

### C_EndOfMatchUI.GetEndOfMatchDetails

```lua
matchDetails = C_EndOfMatchUI.GetEndOfMatchDetails()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchDetails` | MatchDetails | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matchDetails = C_EndOfMatchUI.GetEndOfMatchDetails()
```

## Events

### SHOW_END_OF_MATCH_UI

## Types

### EndOfMatchType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | EndOfMatchType | no |  |
| `Plunderstorm` | EndOfMatchType | no |  |

### MatchDetail (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | MatchDetailType | no |  |
| `value` | number | no |  |

### MatchDetails (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchType` | EndOfMatchType | no |  |
| `matchEnded` | bool | no |  |
| `detailsList` | MatchDetail[] | no |  |

### MatchDetailType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Placement` | MatchDetailType | no |  |
| `Kills` | MatchDetailType | no |  |
| `PlunderAcquired` | MatchDetailType | no |  |

