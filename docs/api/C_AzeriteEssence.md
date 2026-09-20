# C_AzeriteEssence

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**21** functions · **8** events · **2** types

## Functions

### C_AzeriteEssence.ActivateEssence

```lua
C_AzeriteEssence.ActivateEssence(essenceID, milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |
| `milestoneID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEssence.ActivateEssence(0, 0)
```

### C_AzeriteEssence.CanActivateEssence

```lua
canActivate = C_AzeriteEssence.CanActivateEssence(essenceID, milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |
| `milestoneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canActivate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canActivate = C_AzeriteEssence.CanActivateEssence(0, 0)
```

### C_AzeriteEssence.CanDeactivateEssence

```lua
canDeactivate = C_AzeriteEssence.CanDeactivateEssence(milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDeactivate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canDeactivate = C_AzeriteEssence.CanDeactivateEssence(0)
```

### C_AzeriteEssence.CanOpenUI

```lua
canOpen = C_AzeriteEssence.CanOpenUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canOpen` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canOpen = C_AzeriteEssence.CanOpenUI()
```

### C_AzeriteEssence.ClearPendingActivationEssence

```lua
C_AzeriteEssence.ClearPendingActivationEssence()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEssence.ClearPendingActivationEssence()
```

### C_AzeriteEssence.CloseForge

```lua
C_AzeriteEssence.CloseForge()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEssence.CloseForge()
```

### C_AzeriteEssence.GetEssenceHyperlink

```lua
link = C_AzeriteEssence.GetEssenceHyperlink(essenceID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local link = C_AzeriteEssence.GetEssenceHyperlink(0, 1)
```

### C_AzeriteEssence.GetEssenceInfo

```lua
info = C_AzeriteEssence.GetEssenceInfo(essenceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AzeriteEssenceInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AzeriteEssence.GetEssenceInfo(0)
```

### C_AzeriteEssence.GetEssences

```lua
essences = C_AzeriteEssence.GetEssences()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essences` | AzeriteEssenceInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local essences = C_AzeriteEssence.GetEssences()
```

### C_AzeriteEssence.GetMilestoneEssence

```lua
essenceID = C_AzeriteEssence.GetMilestoneEssence(milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local essenceID = C_AzeriteEssence.GetMilestoneEssence(0)
```

### C_AzeriteEssence.GetMilestoneInfo

```lua
info = C_AzeriteEssence.GetMilestoneInfo(milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AzeriteMilestoneInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AzeriteEssence.GetMilestoneInfo(0)
```

### C_AzeriteEssence.GetMilestones

```lua
milestones = C_AzeriteEssence.GetMilestones()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestones` | AzeriteMilestoneInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local milestones = C_AzeriteEssence.GetMilestones()
```

### C_AzeriteEssence.GetMilestoneSpell

```lua
spellID = C_AzeriteEssence.GetMilestoneSpell(milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_AzeriteEssence.GetMilestoneSpell(0)
```

### C_AzeriteEssence.GetNumUnlockedEssences

```lua
numUnlockedEssences = C_AzeriteEssence.GetNumUnlockedEssences()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numUnlockedEssences` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numUnlockedEssences = C_AzeriteEssence.GetNumUnlockedEssences()
```

### C_AzeriteEssence.GetNumUsableEssences

```lua
numUsableEssences = C_AzeriteEssence.GetNumUsableEssences()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numUsableEssences` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numUsableEssences = C_AzeriteEssence.GetNumUsableEssences()
```

### C_AzeriteEssence.GetPendingActivationEssence

```lua
essenceID = C_AzeriteEssence.GetPendingActivationEssence()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local essenceID = C_AzeriteEssence.GetPendingActivationEssence()
```

### C_AzeriteEssence.HasNeverActivatedAnyEssences

```lua
hasNeverActivatedAnyEssences = C_AzeriteEssence.HasNeverActivatedAnyEssences()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasNeverActivatedAnyEssences` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasNeverActivatedAnyEssences = C_AzeriteEssence.HasNeverActivatedAnyEssences()
```

### C_AzeriteEssence.HasPendingActivationEssence

```lua
hasEssence = C_AzeriteEssence.HasPendingActivationEssence()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasEssence` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasEssence = C_AzeriteEssence.HasPendingActivationEssence()
```

### C_AzeriteEssence.IsAtForge

```lua
isAtForge = C_AzeriteEssence.IsAtForge()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtForge` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAtForge = C_AzeriteEssence.IsAtForge()
```

### C_AzeriteEssence.SetPendingActivationEssence

```lua
C_AzeriteEssence.SetPendingActivationEssence(essenceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEssence.SetPendingActivationEssence(0)
```

### C_AzeriteEssence.UnlockMilestone

```lua
C_AzeriteEssence.UnlockMilestone(milestoneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AzeriteEssence.UnlockMilestone(0)
```

## Events

### AZERITE_ESSENCE_ACTIVATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | AzeriteEssenceSlot | no |  |
| `essenceID` | number | no |  |

### AZERITE_ESSENCE_ACTIVATION_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | AzeriteEssenceSlot | no |  |
| `essenceID` | number | no |  |

### AZERITE_ESSENCE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |
| `newRank` | number | no |  |

### AZERITE_ESSENCE_FORGE_CLOSE

### AZERITE_ESSENCE_FORGE_OPEN

### AZERITE_ESSENCE_MILESTONE_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneID` | number | no |  |

### AZERITE_ESSENCE_UPDATE

### PENDING_AZERITE_ESSENCE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | yes |  |

## Types

### AzeriteEssenceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `name` | cstring | no |  |
| `rank` | number | no |  |
| `unlocked` | bool | no |  |
| `valid` | bool | no |  |
| `icon` | fileID | no |  |

### AzeriteMilestoneInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `requiredLevel` | number | no |  |
| `canUnlock` | bool | no |  |
| `unlocked` | bool | no |  |
| `rank` | number | yes |  |
| `slot` | AzeriteEssenceSlot | yes |  |

