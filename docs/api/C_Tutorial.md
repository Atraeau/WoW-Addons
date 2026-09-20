# C_Tutorial

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **6** events · **1** types

## Functions

### C_Tutorial.AbandonTutorialArea

```lua
C_Tutorial.AbandonTutorialArea()
```

**Example**

```lua
C_Tutorial.AbandonTutorialArea()
```

### C_Tutorial.GetCombatEventInfo

```lua
C_Tutorial.GetCombatEventInfo()
```

**Example**

```lua
C_Tutorial.GetCombatEventInfo()
```

### C_Tutorial.ReturnToTutorialArea

```lua
C_Tutorial.ReturnToTutorialArea()
```

**Example**

```lua
C_Tutorial.ReturnToTutorialArea()
```

## Events

### LEAVING_TUTORIAL_AREA

### NPE_TUTORIAL_UPDATE

### TUTORIAL_COMBAT_EVENT

### TUTORIAL_HIGHLIGHT_SPELL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `tutorialGlobalStringTag` | cstring | no |  |

### TUTORIAL_TRIGGER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tutorialIndex` | number | no |  |
| `forceShow` | bool | no |  |

### TUTORIAL_UNHIGHLIGHT_SPELL

## Types

### FrameTutorialAccount (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `HudRevampBagChanges` | FrameTutorialAccount | no |  |
| `PerksProgramActivitiesIntro` | FrameTutorialAccount | no |  |
| `EditModeManager` | FrameTutorialAccount | no |  |
| `TransmogSetsTab` | FrameTutorialAccount | no |  |
| `MountCollectionDragonriding` | FrameTutorialAccount | no |  |
| `LFGList` | FrameTutorialAccount | no |  |
| `HeirloomJournalLevel` | FrameTutorialAccount | no |  |
| `TimerunnersAdvantage` | FrameTutorialAccount | no |  |
| `AccountWideReputation` | FrameTutorialAccount | no |  |
| `TransferableCurrencies` | FrameTutorialAccount | no |  |
| `BindToAccountUntilEquip` | FrameTutorialAccount | no |  |
| `CompletedQuestsFilter` | FrameTutorialAccount | no |  |
| `CompletedQuestsFilterSeen` | FrameTutorialAccount | no |  |
| `ConcentrationCurrency` | FrameTutorialAccount | no |  |
| `MapLegendOpened` | FrameTutorialAccount | no |  |
| `NpcCraftingOrders` | FrameTutorialAccount | no |  |
| `NpcCraftingOrderCreateButton` | FrameTutorialAccount | no |  |
| `NpcCraftingOrderTabNew` | FrameTutorialAccount | no |  |
| `LocalStoriesFilterSeen` | FrameTutorialAccount | no |  |
| `EventSchedulerTabSeen` | FrameTutorialAccount | no |  |
| `AssistedCombatRotationDragSpell` | FrameTutorialAccount | no |  |
| `AssistedCombatRotationActionButton` | FrameTutorialAccount | no |  |
| `HousingDecorCleanup` | FrameTutorialAccount | no |  |
| `HousingDecorPlace` | FrameTutorialAccount | no |  |
| `HousingDecorClippingGrid` | FrameTutorialAccount | no |  |
| `HousingDecorCustomization` | FrameTutorialAccount | no |  |
| `HousingDecorLayout` | FrameTutorialAccount | no |  |
| `HousingHouseFinderMap` | FrameTutorialAccount | no |  |
| `HousingHouseFinderVisitHouse` | FrameTutorialAccount | no |  |
| `HousingItemAcquisition` | FrameTutorialAccount | no |  |
| `HousingNewPip` | FrameTutorialAccount | no |  |
| `PerksProgramActivitiesOpen` | FrameTutorialAccount | no |  |
| `EnconterJournalTutorialsTabSeen` | FrameTutorialAccount | no |  |
| `HousingMarketTab` | FrameTutorialAccount | no |  |
| `HousingTeleportButton` | FrameTutorialAccount | no |  |
| `RPETalentStarterBuild` | FrameTutorialAccount | no |  |
| `HousingInvalidCollision` | FrameTutorialAccount | no |  |
| `HousingModesUnlocked` | FrameTutorialAccount | no |  |
| `HousingExpertMode` | FrameTutorialAccount | no |  |
| `HousingCleanupMode` | FrameTutorialAccount | no |  |
| `TransmogOutfits` | FrameTutorialAccount | no |  |
| `TransmogSets` | FrameTutorialAccount | no |  |
| `TransmogCustomSets` | FrameTutorialAccount | no |  |
| `TransmogSituations` | FrameTutorialAccount | no |  |
| `TransmogWeaponOptions` | FrameTutorialAccount | no |  |
| `TransmogTrialOfStyle` | FrameTutorialAccount | no |  |
| `TransmogCustomSetsMigration` | FrameTutorialAccount | no |  |
| `HousingEndeavorsTabSeen` | FrameTutorialAccount | no |  |
| `RunesOfPower` | FrameTutorialAccount | no |  |
| `HousingPetBeds` | FrameTutorialAccount | no |  |

