# C_MountJournal

[← API index](../README.md) · group: [Pets, Mounts & Collections](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**50** functions · **4** events · **3** types

## Functions

### C_MountJournal.ApplyMountEquipment

```lua
canContinue = C_MountJournal.ApplyMountEquipment(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canContinue` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canContinue = C_MountJournal.ApplyMountEquipment(6948)
```

### C_MountJournal.AreMountEquipmentEffectsSuppressed

```lua
areEffectsSuppressed = C_MountJournal.AreMountEquipmentEffectsSuppressed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areEffectsSuppressed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areEffectsSuppressed = C_MountJournal.AreMountEquipmentEffectsSuppressed()
```

### C_MountJournal.ClearFanfare

```lua
C_MountJournal.ClearFanfare(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.ClearFanfare(0)
```

### C_MountJournal.ClearRecentFanfares

```lua
C_MountJournal.ClearRecentFanfares()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.ClearRecentFanfares()
```

### C_MountJournal.Dismiss

```lua
C_MountJournal.Dismiss()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.Dismiss()
```

### C_MountJournal.GetAllCreatureDisplayIDsForMountID

```lua
creatureDisplayIDs = C_MountJournal.GetAllCreatureDisplayIDsForMountID(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureDisplayIDs = C_MountJournal.GetAllCreatureDisplayIDsForMountID(0)
```

### C_MountJournal.GetAppliedMountEquipmentID

```lua
itemID = C_MountJournal.GetAppliedMountEquipmentID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID = C_MountJournal.GetAppliedMountEquipmentID()
```

### C_MountJournal.GetCollectedDragonridingMounts

```lua
mountIDs = C_MountJournal.GetCollectedDragonridingMounts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountIDs = C_MountJournal.GetCollectedDragonridingMounts()
```

### C_MountJournal.GetCollectedFilterSetting

```lua
isChecked = C_MountJournal.GetCollectedFilterSetting(filterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isChecked = C_MountJournal.GetCollectedFilterSetting(1)
```

### C_MountJournal.GetDisplayedMountAllCreatureDisplayInfo

```lua
allDisplayInfo = C_MountJournal.GetDisplayedMountAllCreatureDisplayInfo(mountIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allDisplayInfo` | MountCreatureDisplayInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allDisplayInfo = C_MountJournal.GetDisplayedMountAllCreatureDisplayInfo(1)
```

### C_MountJournal.GetDisplayedMountID

```lua
mountID = C_MountJournal.GetDisplayedMountID(displayIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountID = C_MountJournal.GetDisplayedMountID(1)
```

### C_MountJournal.GetDisplayedMountInfo

```lua
name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight = C_MountJournal.GetDisplayedMountInfo(displayIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `spellID` | number | no |  |
| `icon` | fileID | no |  |
| `isActive` | bool | no |  |
| `isUsable` | bool | no |  |
| `sourceType` | number | no |  |
| `isFavorite` | bool | no |  |
| `isFactionSpecific` | bool | no |  |
| `faction` | PvPFaction | yes |  |
| `shouldHideOnChar` | bool | no |  |
| `isCollected` | bool | no |  |
| `mountID` | number | no |  |
| `isSteadyFlight` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight = C_MountJournal.GetDisplayedMountInfo(1)
```

### C_MountJournal.GetDisplayedMountInfoExtra

```lua
creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetDisplayedMountInfoExtra(mountIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | yes |  |
| `description` | cstring | no |  |
| `source` | cstring | no |  |
| `isSelfMount` | bool | no |  |
| `mountTypeID` | number | no |  |
| `uiModelSceneID` | number | no |  |
| `animID` | number | no |  |
| `spellVisualKitID` | number | no |  |
| `disablePlayerMountPreview` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetDisplayedMountInfoExtra(1)
```

### C_MountJournal.GetDynamicFlightModeSpellID

```lua
spellID = C_MountJournal.GetDynamicFlightModeSpellID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_MountJournal.GetDynamicFlightModeSpellID()
```

### C_MountJournal.GetIsFavorite

```lua
isFavorite, canSetFavorite = C_MountJournal.GetIsFavorite(mountIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |
| `canSetFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFavorite, canSetFavorite = C_MountJournal.GetIsFavorite(1)
```

### C_MountJournal.GetMountAllCreatureDisplayInfoByID

```lua
allDisplayInfo = C_MountJournal.GetMountAllCreatureDisplayInfoByID(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allDisplayInfo` | MountCreatureDisplayInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allDisplayInfo = C_MountJournal.GetMountAllCreatureDisplayInfoByID(0)
```

### C_MountJournal.GetMountEquipmentUnlockLevel

```lua
level = C_MountJournal.GetMountEquipmentUnlockLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local level = C_MountJournal.GetMountEquipmentUnlockLevel()
```

### C_MountJournal.GetMountFromItem

```lua
mountID = C_MountJournal.GetMountFromItem(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountID = C_MountJournal.GetMountFromItem(6948)
```

### C_MountJournal.GetMountFromSpell

```lua
mountID = C_MountJournal.GetMountFromSpell(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountID = C_MountJournal.GetMountFromSpell(2050)
```

### C_MountJournal.GetMountIDs

```lua
mountIDs = C_MountJournal.GetMountIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountIDs = C_MountJournal.GetMountIDs()
```

### C_MountJournal.GetMountInfoByID

```lua
name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `spellID` | number | no |  |
| `icon` | fileID | no |  |
| `isActive` | bool | no |  |
| `isUsable` | bool | no |  |
| `sourceType` | number | no |  |
| `isFavorite` | bool | no |  |
| `isFactionSpecific` | bool | no |  |
| `faction` | PvPFaction | yes |  |
| `shouldHideOnChar` | bool | no |  |
| `isCollected` | bool | no |  |
| `mountID` | number | no |  |
| `isSteadyFlight` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(0)
```

### C_MountJournal.GetMountInfoExtraByID

```lua
creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | yes |  |
| `description` | cstring | no |  |
| `source` | cstring | no |  |
| `isSelfMount` | bool | no |  |
| `mountTypeID` | number | no |  |
| `uiModelSceneID` | number | no |  |
| `animID` | number | no |  |
| `spellVisualKitID` | number | no |  |
| `disablePlayerMountPreview` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(0)
```

### C_MountJournal.GetMountLink

```lua
mountCreatureDisplayInfoLink = C_MountJournal.GetMountLink(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountCreatureDisplayInfoLink` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mountCreatureDisplayInfoLink = C_MountJournal.GetMountLink(2050)
```

### C_MountJournal.GetMountUsabilityByID

```lua
isUsable, useError = C_MountJournal.GetMountUsabilityByID(mountID, checkIndoors)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |
| `checkIndoors` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsable` | bool | no |  |
| `useError` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsable, useError = C_MountJournal.GetMountUsabilityByID(0, false)
```

### C_MountJournal.GetNumDisplayedMounts

```lua
numMounts = C_MountJournal.GetNumDisplayedMounts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numMounts` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numMounts = C_MountJournal.GetNumDisplayedMounts()
```

### C_MountJournal.GetNumMounts

```lua
numMounts = C_MountJournal.GetNumMounts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numMounts` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numMounts = C_MountJournal.GetNumMounts()
```

### C_MountJournal.GetNumMountsNeedingFanfare

```lua
numMountsNeedingFanfare = C_MountJournal.GetNumMountsNeedingFanfare()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numMountsNeedingFanfare` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numMountsNeedingFanfare = C_MountJournal.GetNumMountsNeedingFanfare()
```

### C_MountJournal.HasDisplayableMount

```lua
hasMount = C_MountJournal.HasDisplayableMount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMount` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMount = C_MountJournal.HasDisplayableMount()
```

### C_MountJournal.IsDragonridingUnlocked

Returns whether the player has unlocked the ability to switch between Skyriding and steady flight styles for flying mounts .

```lua
isUnlocked = C_MountJournal.IsDragonridingUnlocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnlocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnlocked = C_MountJournal.IsDragonridingUnlocked()
```

### C_MountJournal.IsItemMountEquipment

Determines if the item is mount equipment based on its class and subclass.

```lua
isMountEquipment = C_MountJournal.IsItemMountEquipment(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMountEquipment` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMountEquipment = C_MountJournal.IsItemMountEquipment(6948)
```

### C_MountJournal.IsMountEquipmentApplied

```lua
isApplied = C_MountJournal.IsMountEquipmentApplied()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApplied` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isApplied = C_MountJournal.IsMountEquipmentApplied()
```

### C_MountJournal.IsSourceChecked

```lua
isChecked = C_MountJournal.IsSourceChecked(filterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isChecked = C_MountJournal.IsSourceChecked(1)
```

### C_MountJournal.IsTypeChecked

```lua
isChecked = C_MountJournal.IsTypeChecked(filterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isChecked = C_MountJournal.IsTypeChecked(1)
```

### C_MountJournal.IsUsingDefaultFilters

```lua
isUsingDefaultFilters = C_MountJournal.IsUsingDefaultFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultFilters` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsingDefaultFilters = C_MountJournal.IsUsingDefaultFilters()
```

### C_MountJournal.IsValidSourceFilter

```lua
isValid = C_MountJournal.IsValidSourceFilter(filterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_MountJournal.IsValidSourceFilter(1)
```

### C_MountJournal.IsValidTypeFilter

```lua
isValid = C_MountJournal.IsValidTypeFilter(filterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_MountJournal.IsValidTypeFilter(1)
```

### C_MountJournal.MountEquipmentAvailable

```lua
isMountEquipmentAvailable = C_MountJournal.MountEquipmentAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMountEquipmentAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMountEquipmentAvailable = C_MountJournal.MountEquipmentAvailable()
```

### C_MountJournal.NeedsFanfare

```lua
needsFanfare = C_MountJournal.NeedsFanfare(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `needsFanfare` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local needsFanfare = C_MountJournal.NeedsFanfare(0)
```

### C_MountJournal.Pickup

```lua
C_MountJournal.Pickup(displayIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.Pickup(1)
```

### C_MountJournal.PickupDynamicFlightMode

```lua
C_MountJournal.PickupDynamicFlightMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.PickupDynamicFlightMode()
```

### C_MountJournal.SetAllSourceFilters

```lua
C_MountJournal.SetAllSourceFilters(isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetAllSourceFilters(false)
```

### C_MountJournal.SetAllTypeFilters

```lua
C_MountJournal.SetAllTypeFilters(isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetAllTypeFilters(false)
```

### C_MountJournal.SetCollectedFilterSetting

```lua
C_MountJournal.SetCollectedFilterSetting(filterIndex, isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetCollectedFilterSetting(1, false)
```

### C_MountJournal.SetDefaultFilters

```lua
C_MountJournal.SetDefaultFilters()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetDefaultFilters()
```

### C_MountJournal.SetIsFavorite

```lua
C_MountJournal.SetIsFavorite(mountIndex, isFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountIndex` | luaIndex | no |  |
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetIsFavorite(1, false)
```

### C_MountJournal.SetSearch

```lua
C_MountJournal.SetSearch(searchValue)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchValue` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetSearch("")
```

### C_MountJournal.SetSourceFilter

```lua
C_MountJournal.SetSourceFilter(filterIndex, isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetSourceFilter(1, false)
```

### C_MountJournal.SetTypeFilter

```lua
C_MountJournal.SetTypeFilter(filterIndex, isChecked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterIndex` | luaIndex | no |  |
| `isChecked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SetTypeFilter(1, false)
```

### C_MountJournal.SummonByID

```lua
C_MountJournal.SummonByID(mountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SummonByID(0)
```

### C_MountJournal.SwapDynamicFlightMode

```lua
C_MountJournal.SwapDynamicFlightMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MountJournal.SwapDynamicFlightMode()
```

## Events

### MOUNT_EQUIPMENT_APPLY_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### MOUNT_JOURNAL_SEARCH_UPDATED

### MOUNT_JOURNAL_USABILITY_CHANGED

### NEW_MOUNT_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mountID` | number | no |  |

## Types

### MountCreatureDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayID` | number | no |  |
| `isVisible` | bool | no |  |

### MountInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `spellID` | number | no |  |
| `icon` | fileID | no |  |
| `isActive` | bool | no |  |
| `isUsable` | bool | no |  |
| `sourceType` | number | no |  |
| `isFavorite` | bool | no |  |
| `isFactionSpecific` | bool | no |  |
| `faction` | PvPFaction | yes |  |
| `shouldHideOnChar` | bool | no |  |
| `isCollected` | bool | no |  |
| `mountID` | number | no |  |
| `isSteadyFlight` | bool | no |  |

### MountInfoExtra (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | yes |  |
| `description` | cstring | no |  |
| `source` | cstring | no |  |
| `isSelfMount` | bool | no |  |
| `mountTypeID` | number | no |  |
| `uiModelSceneID` | number | no |  |
| `animID` | number | no |  |
| `spellVisualKitID` | number | no |  |
| `disablePlayerMountPreview` | bool | no |  |

