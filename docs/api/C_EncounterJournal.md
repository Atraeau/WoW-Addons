# C_EncounterJournal

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**22** functions · **3** events · **5** types

## Functions

### C_EncounterJournal.GetBaseDifficultyID

```lua
baseDifficultyID = C_EncounterJournal.GetBaseDifficultyID(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseDifficultyID` | number | no |  |

**Example**

```lua
local baseDifficultyID = C_EncounterJournal.GetBaseDifficultyID(0)
```

### C_EncounterJournal.GetDungeonEntrancesForMap

```lua
dungeonEntrances = C_EncounterJournal.GetDungeonEntrancesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonEntrances` | DungeonEntranceMapInfo[] | no |  |

**Example**

```lua
local dungeonEntrances = C_EncounterJournal.GetDungeonEntrancesForMap(0)
```

### C_EncounterJournal.GetEncounterJournalLink

```lua
link = C_EncounterJournal.GetEncounterJournalLink(linkType, ID, displayText, difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `linkType` | JournalLinkTypes | no |  |
| `ID` | number | no |  |
| `displayText` | string | no |  |
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | string | no |  |

**Example**

```lua
local link = C_EncounterJournal.GetEncounterJournalLink(linkType, 0, "", 0)
```

### C_EncounterJournal.GetEncountersOnMap

```lua
encounters = C_EncounterJournal.GetEncountersOnMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounters` | EncounterJournalMapEncounterInfo[] | no |  |

**Example**

```lua
local encounters = C_EncounterJournal.GetEncountersOnMap(0)
```

### C_EncounterJournal.GetInstanceForGameMap

GameMap as opposed to UIMap since we use a mapID not a uiMapID.

```lua
journalInstanceID = C_EncounterJournal.GetInstanceForGameMap(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `journalInstanceID` | number | yes |  |

**Example**

```lua
local journalInstanceID = C_EncounterJournal.GetInstanceForGameMap(0)
```

### C_EncounterJournal.GetLootInfo

```lua
itemInfo = C_EncounterJournal.GetLootInfo(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | EncounterJournalItemInfo | no |  |

**Example**

```lua
local itemInfo = C_EncounterJournal.GetLootInfo(0)
```

### C_EncounterJournal.GetLootInfoByIndex

```lua
itemInfo = C_EncounterJournal.GetLootInfoByIndex(index, [encounterIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `encounterIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | EncounterJournalItemInfo | no |  |

**Example**

```lua
local itemInfo = C_EncounterJournal.GetLootInfoByIndex(1)
```

### C_EncounterJournal.GetSectionIconFlags

Represents the icon indices for this EJ section.  An icon index can be used to arrive at texture coordinates for specific encounter types, e.g.: EncounterJournal_SetFlagIcon

```lua
iconFlags = C_EncounterJournal.GetSectionIconFlags(sectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFlags` | number[] | yes |  |

**Example**

```lua
local iconFlags = C_EncounterJournal.GetSectionIconFlags(0)
```

### C_EncounterJournal.GetSectionInfo

```lua
info = C_EncounterJournal.GetSectionInfo(sectionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sectionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | EncounterJournalSectionInfo | no |  |

**Example**

```lua
local info = C_EncounterJournal.GetSectionInfo(0)
```

### C_EncounterJournal.GetSlotFilter

```lua
filter = C_EncounterJournal.GetSlotFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filter` | ItemSlotFilterType | no |  |

**Example**

```lua
local filter = C_EncounterJournal.GetSlotFilter()
```

### C_EncounterJournal.InitalizeSelectedTier

```lua
C_EncounterJournal.InitalizeSelectedTier()
```

**Example**

```lua
C_EncounterJournal.InitalizeSelectedTier()
```

### C_EncounterJournal.InstanceHasDifficultyID

```lua
hasDifficultyID = C_EncounterJournal.InstanceHasDifficultyID(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasDifficultyID` | bool | no |  |

**Example**

```lua
local hasDifficultyID = C_EncounterJournal.InstanceHasDifficultyID(0)
```

### C_EncounterJournal.InstanceHasLoot

```lua
hasLoot = C_EncounterJournal.InstanceHasLoot([instanceID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `instanceID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasLoot` | bool | no |  |

**Example**

```lua
local hasLoot = C_EncounterJournal.InstanceHasLoot()
```

### C_EncounterJournal.IsEncounterComplete

```lua
isEncounterComplete = C_EncounterJournal.IsEncounterComplete(journalEncounterID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `journalEncounterID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEncounterComplete` | bool | no |  |

**Example**

```lua
local isEncounterComplete = C_EncounterJournal.IsEncounterComplete(0)
```

### C_EncounterJournal.OnClose

```lua
C_EncounterJournal.OnClose()
```

**Example**

```lua
C_EncounterJournal.OnClose()
```

### C_EncounterJournal.OnOpen

```lua
C_EncounterJournal.OnOpen()
```

**Example**

```lua
C_EncounterJournal.OnOpen()
```

### C_EncounterJournal.ResetSlotFilter

```lua
C_EncounterJournal.ResetSlotFilter()
```

**Example**

```lua
C_EncounterJournal.ResetSlotFilter()
```

### C_EncounterJournal.SetPreviewMythicPlusLevel

```lua
C_EncounterJournal.SetPreviewMythicPlusLevel(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example**

```lua
C_EncounterJournal.SetPreviewMythicPlusLevel(0)
```

### C_EncounterJournal.SetPreviewPvpTier

```lua
C_EncounterJournal.SetPreviewPvpTier(tier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tier` | number | no |  |

**Example**

```lua
C_EncounterJournal.SetPreviewPvpTier(0)
```

### C_EncounterJournal.SetSlotFilter

```lua
C_EncounterJournal.SetSlotFilter(filterSlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterSlot` | ItemSlotFilterType | no |  |

**Example**

```lua
C_EncounterJournal.SetSlotFilter(1)
```

### C_EncounterJournal.SetTab

```lua
C_EncounterJournal.SetTab(tabIdx)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabIdx` | number | no |  |

**Example**

```lua
C_EncounterJournal.SetTab(0)
```

### C_EncounterJournal.StartArathiRPE

```lua
C_EncounterJournal.StartArathiRPE()
```

**Example**

```lua
C_EncounterJournal.StartArathiRPE()
```

## Events

### EJ_DIFFICULTY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

### EJ_LOOT_DATA_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

### SHOW_JOURNEYS_UI

Signaled when the UI needs to display the journeys dashboard at a specific faction.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

## Types

### DungeonEntranceMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `atlasName` | string | no |  |
| `journalInstanceID` | number | no |  |

### EncounterJournalItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `encounterID` | number | yes |  |
| `name` | string | yes |  |
| `itemQuality` | string | yes |  |
| `filterType` | ItemSlotFilterType | yes |  |
| `icon` | fileID | yes |  |
| `slot` | string | yes |  |
| `armorType` | string | yes |  |
| `link` | string | yes |  |
| `handError` | bool | yes |  |
| `weaponTypeError` | bool | yes |  |
| `displayAsPerPlayerLoot` | bool | yes |  |
| `displayAsVeryRare` | bool | yes |  |
| `displayAsExtremelyRare` | bool | yes |  |
| `displaySeasonID` | number | yes |  |

### EncounterJournalMapEncounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `mapX` | number | no |  |
| `mapY` | number | no |  |

### EncounterJournalSectionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `title` | cstring | no |  |
| `description` | string | yes |  |
| `headerType` | number | no |  |
| `abilityIcon` | fileID | no |  |
| `creatureDisplayID` | number | no |  |
| `uiModelSceneID` | number | no |  |
| `siblingSectionID` | number | yes |  |
| `firstChildSectionID` | number | yes |  |
| `filteredByDifficulty` | bool | no |  |
| `link` | string | no |  |
| `startsOpen` | bool | no |  |

### ItemSlotFilterType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Head` | ItemSlotFilterType | no |  |
| `Neck` | ItemSlotFilterType | no |  |
| `Shoulder` | ItemSlotFilterType | no |  |
| `Cloak` | ItemSlotFilterType | no |  |
| `Chest` | ItemSlotFilterType | no |  |
| `Wrist` | ItemSlotFilterType | no |  |
| `Hand` | ItemSlotFilterType | no |  |
| `Waist` | ItemSlotFilterType | no |  |
| `Legs` | ItemSlotFilterType | no |  |
| `Feet` | ItemSlotFilterType | no |  |
| `MainHand` | ItemSlotFilterType | no |  |
| `OffHand` | ItemSlotFilterType | no |  |
| `Finger` | ItemSlotFilterType | no |  |
| `Trinket` | ItemSlotFilterType | no |  |
| `Other` | ItemSlotFilterType | no |  |
| `NoFilter` | ItemSlotFilterType | no |  |

