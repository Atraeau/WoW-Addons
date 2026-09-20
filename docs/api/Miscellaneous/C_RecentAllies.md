# C_RecentAllies

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**15** functions · **5** events · **7** types

## Functions

### C_RecentAllies.CanSetRecentAllyNote

```lua
canSetNote = C_RecentAllies.CanSetRecentAllyNote(characterGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSetNote` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSetNote = C_RecentAllies.CanSetRecentAllyNote(UnitGUID("player"))
```

### C_RecentAllies.GetRecentAllies

```lua
recentAlliesData = C_RecentAllies.GetRecentAllies()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentAlliesData` | RecentAllyData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentAlliesData = C_RecentAllies.GetRecentAllies()
```

### C_RecentAllies.GetRecentAllyByFullName

```lua
recentAllyData = C_RecentAllies.GetRecentAllyByFullName(fullCharacterName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullCharacterName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentAllyData` | RecentAllyData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentAllyData = C_RecentAllies.GetRecentAllyByFullName("")
```

### C_RecentAllies.GetRecentAllyByGUID

```lua
recentAllyData = C_RecentAllies.GetRecentAllyByGUID(characterGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentAllyData` | RecentAllyData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentAllyData = C_RecentAllies.GetRecentAllyByGUID(UnitGUID("player"))
```

### C_RecentAllies.IsInteractionCategoryFilterSupportedForCurrentGameType

```lua
isInteractionCategoryFilterSupportedForCurrentGameType = C_RecentAllies.IsInteractionCategoryFilterSupportedForCurrentGameType(interactionCategoryFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interactionCategoryFilter` | RecentAlliesInteractionCategoryFilter | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInteractionCategoryFilterSupportedForCurrentGameType` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInteractionCategoryFilterSupportedForCurrentGameType = C_RecentAllies.IsInteractionCategoryFilterSupportedForCurrentGameType("HELPFUL")
```

### C_RecentAllies.IsRecentAllyByFullName

```lua
isRecentAlly = C_RecentAllies.IsRecentAllyByFullName(fullCharacterName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullCharacterName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecentAlly` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRecentAlly = C_RecentAllies.IsRecentAllyByFullName("")
```

### C_RecentAllies.IsRecentAllyByGUID

```lua
isRecentAlly = C_RecentAllies.IsRecentAllyByGUID(characterGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecentAlly` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRecentAlly = C_RecentAllies.IsRecentAllyByGUID(UnitGUID("player"))
```

### C_RecentAllies.IsRecentAllyDataReady

```lua
isReady = C_RecentAllies.IsRecentAllyDataReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isReady = C_RecentAllies.IsRecentAllyDataReady()
```

### C_RecentAllies.IsRecentAllyPinned

```lua
isPinned = C_RecentAllies.IsRecentAllyPinned(characterGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPinned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPinned = C_RecentAllies.IsRecentAllyPinned(UnitGUID("player"))
```

### C_RecentAllies.IsSystemEnabled

```lua
isRecentAllySystemEnabled = C_RecentAllies.IsSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecentAllySystemEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRecentAllySystemEnabled = C_RecentAllies.IsSystemEnabled()
```

### C_RecentAllies.IsSystemSupported

```lua
isRecentAllySystemSupported = C_RecentAllies.IsSystemSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecentAllySystemSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRecentAllySystemSupported = C_RecentAllies.IsSystemSupported()
```

### C_RecentAllies.SearchRecentAllies

```lua
recentAlliesData = C_RecentAllies.SearchRecentAllies(searchInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchInfo` | RecentAlliesSearchInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentAlliesData` | RecentAllyData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recentAlliesData = C_RecentAllies.SearchRecentAllies(searchInfo)
```

### C_RecentAllies.SetRecentAllyNote

```lua
C_RecentAllies.SetRecentAllyNote(characterGUID, note)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |
| `note` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_RecentAllies.SetRecentAllyNote(UnitGUID("player"), "")
```

### C_RecentAllies.SetRecentAllyPinned

```lua
C_RecentAllies.SetRecentAllyPinned(characterGUID, isPinned)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |
| `isPinned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_RecentAllies.SetRecentAllyPinned(UnitGUID("player"), false)
```

### C_RecentAllies.TryRequestRecentAlliesData

```lua
C_RecentAllies.TryRequestRecentAlliesData()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_RecentAllies.TryRequestRecentAlliesData()
```

## Events

### LET_RECENT_ALLIES_SEE_LOCATION_SETTING_UPDATED

### RECENT_ALLIES_CACHE_UPDATE

### RECENT_ALLIES_DATA_READY

### RECENT_ALLIES_SYSTEM_STATUS_UPDATED

### RECENT_ALLY_DATA_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |

## Types

### RecentAlliesSearchInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchText` | string | no |  |
| `isOnline` | bool | no |  |
| `isDND` | bool | no |  |
| `isAFK` | bool | no |  |
| `isOffline` | bool | no |  |
| `interactionCategoryFilters` | RecentAlliesInteractionCategoryFilter[] | no |  |

### RecentAllyCharacterData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `name` | string | no |  |
| `fullName` | string | no |  |
| `realmName` | string | no |  |
| `level` | number | no |  |
| `classID` | number | no |  |
| `raceID` | number | no |  |
| `sex` | UnitSex | no |  |

### RecentAllyData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stateData` | RecentAllyStateData | no |  |
| `characterData` | RecentAllyCharacterData | no |  |
| `interactionData` | RecentAllyInteractionData | no |  |

### RecentAllyInteraction (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | RolodexType | no |  |
| `description` | cstring | no |  |
| `timestamp` | time_t | no |  |
| `contextData` | RecentAllyInteractionContextData | no |  |

### RecentAllyInteractionContextData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |
| `locationName` | cstring | yes |  |
| `activityDifficultyID` | number | yes |  |
| `activityDifficultyLevel` | number | yes |  |

### RecentAllyInteractionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interactions` | RecentAllyInteraction[] | no |  |
| `note` | string | yes |  |

### RecentAllyStateData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOnline` | bool | no |  |
| `isDND` | bool | no |  |
| `isAFK` | bool | no |  |
| `isConvertedLegacyFriend` | bool | no |  |
| `pinExpirationDate` | time_t | yes |  |
| `friendRequestSentThisSession` | bool | no |  |
| `currentLocation` | string | yes |  |

