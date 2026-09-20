# C_ResearchInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **8** events · **1** types

## Functions

### C_ResearchInfo.GetDigSitesForMap

```lua
digSites = C_ResearchInfo.GetDigSitesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `digSites` | DigSiteMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local digSites = C_ResearchInfo.GetDigSitesForMap(0)
```

## Events

### ARCHAEOLOGY_CLOSED

### ARCHAEOLOGY_FIND_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFindsCompleted` | number | no |  |
| `totalFinds` | number | no |  |
| `researchBranchID` | number | no |  |

### ARCHAEOLOGY_SURVEY_CAST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFindsCompleted` | number | no |  |
| `totalFinds` | number | no |  |
| `researchBranchID` | number | no |  |
| `successfulFind` | number | no |  |

### ARCHAEOLOGY_TOGGLE

### ARTIFACT_DIGSITE_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `researchBranchID` | number | no |  |

### RESEARCH_ARTIFACT_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### RESEARCH_ARTIFACT_DIG_SITE_UPDATED

### RESEARCH_ARTIFACT_UPDATE

## Types

### DigSiteMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `researchSiteID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `poiBlobID` | number | no |  |
| `textureIndex` | number | no |  |

