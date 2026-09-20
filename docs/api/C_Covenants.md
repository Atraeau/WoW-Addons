# C_Covenants

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **1** events · **1** types

## Functions

### C_Covenants.GetActiveCovenantID

```lua
covenantID = C_Covenants.GetActiveCovenantID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number | no |  |

**Example**

```lua
local covenantID = C_Covenants.GetActiveCovenantID()
```

### C_Covenants.GetCovenantData

```lua
data = C_Covenants.GetCovenantData(covenantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | CovenantData | yes |  |

**Example**

```lua
local data = C_Covenants.GetCovenantData(0)
```

### C_Covenants.GetCovenantIDs

```lua
covenantID = C_Covenants.GetCovenantIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number[] | no |  |

**Example**

```lua
local covenantID = C_Covenants.GetCovenantIDs()
```

## Events

### COVENANT_CHOSEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number | no |  |

## Types

### CovenantData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `textureKit` | textureKit | no |  |
| `celebrationSoundKit` | number | no |  |
| `animaChannelSelectSoundKit` | number | no |  |
| `animaChannelActiveSoundKit` | number | no |  |
| `animaGemsFullSoundKit` | number | no |  |
| `animaNewGemSoundKit` | number | no |  |
| `animaReinforceSelectSoundKit` | number | no |  |
| `upgradeTabSelectSoundKitID` | number | no |  |
| `reservoirFullSoundKitID` | number | no |  |
| `beginResearchSoundKitID` | number | no |  |
| `renownFanfareSoundKitID` | number | no |  |
| `factionID` | number | no |  |
| `name` | cstring | no |  |
| `soulbindIDs` | number[] | no |  |

