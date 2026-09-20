# C_EncounterInfo

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**0** functions · **10** events · **1** types

## Events

### BOSS_KILL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `encounterName` | cstring | no |  |

### DISABLE_LOW_LEVEL_RAID

### ENABLE_LOW_LEVEL_RAID

### ENCOUNTER_END

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `encounterName` | cstring | no |  |
| `difficultyID` | number | no |  |
| `groupSize` | number | no |  |
| `success` | number | no |  |
| `encounterUnitStatus` | EncounterUnitStatus[] | no | List of all boss units engaged during this encounter. |

### ENCOUNTER_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `encounterName` | cstring | no |  |
| `difficultyID` | number | no |  |
| `groupSize` | number | no |  |

### INSTANCE_LOCK_START

### INSTANCE_LOCK_STOP

### INSTANCE_LOCK_WARNING

### RAID_TARGET_UPDATE

### UPDATE_INSTANCE_INFO

## Types

### EncounterUnitStatus (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |
| `creatureName` | string | no |  |
| `remainingHealthPercent` | number | no |  |

