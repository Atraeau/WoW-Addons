# C_SeasonInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_SeasonInfo.GetCurrentDisplaySeasonExpansion

```lua
expansionID = C_SeasonInfo.GetCurrentDisplaySeasonExpansion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionID` | number | yes |  |

**Example**

```lua
local expansionID = C_SeasonInfo.GetCurrentDisplaySeasonExpansion()
```

### C_SeasonInfo.GetCurrentDisplaySeasonID

```lua
seasonID = C_SeasonInfo.GetCurrentDisplaySeasonID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seasonID` | number | no |  |

**Example**

```lua
local seasonID = C_SeasonInfo.GetCurrentDisplaySeasonID()
```

### C_SeasonInfo.GetTimeUntilCurrentPVPSeasonEnd

```lua
timeInSeconds = C_SeasonInfo.GetTimeUntilCurrentPVPSeasonEnd()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeInSeconds` | number | no |  |

**Example**

```lua
local timeInSeconds = C_SeasonInfo.GetTimeUntilCurrentPVPSeasonEnd()
```

