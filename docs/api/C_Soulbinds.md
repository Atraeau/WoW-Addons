# C_Soulbinds

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**39** functions · **13** events · **6** types

## Functions

### C_Soulbinds.ActivateSoulbind

```lua
C_Soulbinds.ActivateSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.ActivateSoulbind(0)
```

### C_Soulbinds.CanActivateSoulbind

```lua
result, errorDescription = C_Soulbinds.CanActivateSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |
| `errorDescription` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, errorDescription = C_Soulbinds.CanActivateSoulbind(0)
```

### C_Soulbinds.CanModifySoulbind

```lua
result = C_Soulbinds.CanModifySoulbind()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.CanModifySoulbind()
```

### C_Soulbinds.CanResetConduitsInSoulbind

```lua
result, errorDescription = C_Soulbinds.CanResetConduitsInSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |
| `errorDescription` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result, errorDescription = C_Soulbinds.CanResetConduitsInSoulbind(0)
```

### C_Soulbinds.CanSwitchActiveSoulbindTreeBranch

```lua
result = C_Soulbinds.CanSwitchActiveSoulbindTreeBranch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.CanSwitchActiveSoulbindTreeBranch()
```

### C_Soulbinds.CloseUI

```lua
C_Soulbinds.CloseUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.CloseUI()
```

### C_Soulbinds.CommitPendingConduitsInSoulbind

```lua
C_Soulbinds.CommitPendingConduitsInSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.CommitPendingConduitsInSoulbind(0)
```

### C_Soulbinds.FindNodeIDActuallyInstalled

```lua
nodeID = C_Soulbinds.FindNodeIDActuallyInstalled(soulbindID, conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nodeID = C_Soulbinds.FindNodeIDActuallyInstalled(0, 0)
```

### C_Soulbinds.FindNodeIDAppearingInstalled

```lua
nodeID = C_Soulbinds.FindNodeIDAppearingInstalled(soulbindID, conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nodeID = C_Soulbinds.FindNodeIDAppearingInstalled(0, 0)
```

### C_Soulbinds.FindNodeIDPendingInstall

```lua
nodeID = C_Soulbinds.FindNodeIDPendingInstall(soulbindID, conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nodeID = C_Soulbinds.FindNodeIDPendingInstall(0, 0)
```

### C_Soulbinds.FindNodeIDPendingUninstall

```lua
nodeID = C_Soulbinds.FindNodeIDPendingUninstall(soulbindID, conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nodeID = C_Soulbinds.FindNodeIDPendingUninstall(0, 0)
```

### C_Soulbinds.GetActiveSoulbindID

```lua
soulbindID = C_Soulbinds.GetActiveSoulbindID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local soulbindID = C_Soulbinds.GetActiveSoulbindID()
```

### C_Soulbinds.GetConduitCollection

```lua
collectionData = C_Soulbinds.GetConduitCollection(conduitType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitType` | SoulbindConduitType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionData` | ConduitCollectionData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectionData = C_Soulbinds.GetConduitCollection(conduitType)
```

### C_Soulbinds.GetConduitCollectionCount

```lua
count = C_Soulbinds.GetConduitCollectionCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_Soulbinds.GetConduitCollectionCount()
```

### C_Soulbinds.GetConduitCollectionData

```lua
collectionData = C_Soulbinds.GetConduitCollectionData(conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionData` | ConduitCollectionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectionData = C_Soulbinds.GetConduitCollectionData(0)
```

### C_Soulbinds.GetConduitCollectionDataAtCursor

```lua
collectionData = C_Soulbinds.GetConduitCollectionDataAtCursor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionData` | ConduitCollectionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectionData = C_Soulbinds.GetConduitCollectionDataAtCursor()
```

### C_Soulbinds.GetConduitCollectionDataByVirtualID

```lua
collectionData = C_Soulbinds.GetConduitCollectionDataByVirtualID(virtualID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `virtualID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionData` | ConduitCollectionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local collectionData = C_Soulbinds.GetConduitCollectionDataByVirtualID(0)
```

### C_Soulbinds.GetConduitDisplayed

```lua
conduitID = C_Soulbinds.GetConduitDisplayed(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local conduitID = C_Soulbinds.GetConduitDisplayed(0)
```

### C_Soulbinds.GetConduitHyperlink

```lua
link = C_Soulbinds.GetConduitHyperlink(conduitID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local link = C_Soulbinds.GetConduitHyperlink(0, 1)
```

### C_Soulbinds.GetConduitIDPendingInstall

```lua
conduitID = C_Soulbinds.GetConduitIDPendingInstall(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local conduitID = C_Soulbinds.GetConduitIDPendingInstall(0)
```

### C_Soulbinds.GetConduitQuality

```lua
quality = C_Soulbinds.GetConduitQuality(conduitID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local quality = C_Soulbinds.GetConduitQuality(0, 1)
```

### C_Soulbinds.GetConduitRank

```lua
conduitRank = C_Soulbinds.GetConduitRank(conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitRank` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local conduitRank = C_Soulbinds.GetConduitRank(0)
```

### C_Soulbinds.GetConduitSpellID

```lua
spellID = C_Soulbinds.GetConduitSpellID(conduitID, conduitRank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `conduitRank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_Soulbinds.GetConduitSpellID(0, 1)
```

### C_Soulbinds.GetInstalledConduitID

```lua
conduitID = C_Soulbinds.GetInstalledConduitID(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local conduitID = C_Soulbinds.GetInstalledConduitID(0)
```

### C_Soulbinds.GetNode

```lua
node = C_Soulbinds.GetNode(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `node` | SoulbindNode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local node = C_Soulbinds.GetNode(0)
```

### C_Soulbinds.GetSoulbindData

```lua
data = C_Soulbinds.GetSoulbindData(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | SoulbindData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_Soulbinds.GetSoulbindData(0)
```

### C_Soulbinds.GetSpecsAssignedToSoulbind

```lua
specIDs = C_Soulbinds.GetSpecsAssignedToSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specIDs = C_Soulbinds.GetSpecsAssignedToSoulbind(0)
```

### C_Soulbinds.GetTree

```lua
tree = C_Soulbinds.GetTree(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tree` | SoulbindTree | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tree = C_Soulbinds.GetTree(0)
```

### C_Soulbinds.HasAnyInstalledConduitInSoulbind

```lua
result = C_Soulbinds.HasAnyInstalledConduitInSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.HasAnyInstalledConduitInSoulbind(0)
```

### C_Soulbinds.HasAnyPendingConduits

```lua
result = C_Soulbinds.HasAnyPendingConduits()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.HasAnyPendingConduits()
```

### C_Soulbinds.HasPendingConduitsInSoulbind

```lua
result = C_Soulbinds.HasPendingConduitsInSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.HasPendingConduitsInSoulbind(0)
```

### C_Soulbinds.IsConduitInstalled

```lua
result = C_Soulbinds.IsConduitInstalled(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.IsConduitInstalled(0)
```

### C_Soulbinds.IsConduitInstalledInSoulbind

```lua
result = C_Soulbinds.IsConduitInstalledInSoulbind(soulbindID, conduitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |
| `conduitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.IsConduitInstalledInSoulbind(0, 0)
```

### C_Soulbinds.IsItemConduitByItemInfo

```lua
result = C_Soulbinds.IsItemConduitByItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.IsItemConduitByItemInfo(6948)
```

### C_Soulbinds.IsNodePendingModify

```lua
result = C_Soulbinds.IsNodePendingModify(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.IsNodePendingModify(0)
```

### C_Soulbinds.IsUnselectedConduitPendingInSoulbind

```lua
result = C_Soulbinds.IsUnselectedConduitPendingInSoulbind(soulbindID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Soulbinds.IsUnselectedConduitPendingInSoulbind(0)
```

### C_Soulbinds.ModifyNode

```lua
C_Soulbinds.ModifyNode(nodeID, conduitID, type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `conduitID` | number | no |  |
| `type` | SoulbindConduitTransactionType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.ModifyNode(0, 0, type)
```

### C_Soulbinds.SelectNode

```lua
C_Soulbinds.SelectNode(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.SelectNode(0)
```

### C_Soulbinds.UnmodifyNode

```lua
C_Soulbinds.UnmodifyNode(nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Soulbinds.UnmodifyNode(0)
```

## Events

### SOULBIND_ACTIVATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soulbindID` | number | no |  |

### SOULBIND_CONDUIT_COLLECTION_CLEARED

### SOULBIND_CONDUIT_COLLECTION_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |

### SOULBIND_CONDUIT_COLLECTION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionData` | ConduitCollectionData | no |  |

### SOULBIND_CONDUIT_INSTALLED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `data` | SoulbindConduitData | no |  |

### SOULBIND_CONDUIT_UNINSTALLED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `data` | SoulbindConduitData | no |  |

### SOULBIND_FORGE_INTERACTION_ENDED

### SOULBIND_FORGE_INTERACTION_STARTED

### SOULBIND_NODE_LEARNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

### SOULBIND_NODE_UNLEARNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

### SOULBIND_NODE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

### SOULBIND_PATH_CHANGED

### SOULBIND_PENDING_CONDUIT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `conduitID` | number | no |  |

## Types

### ConduitCollectionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `conduitRank` | number | no |  |
| `conduitItemLevel` | number | no |  |
| `conduitType` | SoulbindConduitType | no |  |
| `conduitSpecSetID` | number | no |  |
| `conduitSpecIDs` | number[] | no |  |
| `conduitSpecName` | cstring | yes |  |
| `covenantID` | number | yes |  |
| `conduitItemID` | number | no |  |

### SoulbindConduitData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `conduitRank` | number | no |  |

### SoulbindData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `covenantID` | number | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `textureKit` | textureKit | no |  |
| `unlocked` | bool | no |  |
| `cvarIndex` | luaIndex | no |  |
| `tree` | SoulbindTree | no |  |
| `modelSceneData` | SoulbindModelSceneData | no |  |
| `activationSoundKitID` | number | no |  |
| `playerConditionReason` | cstring | yes |  |

### SoulbindModelSceneData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | no |  |
| `modelSceneActorID` | number | no |  |

### SoulbindNode (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `row` | number | no |  |
| `column` | number | no |  |
| `icon` | fileID | no |  |
| `spellID` | number | no |  |
| `playerConditionReason` | cstring | yes |  |
| `conduitID` | number | no |  |
| `conduitRank` | number | no |  |
| `state` | SoulbindNodeState | no |  |
| `conduitType` | SoulbindConduitType | yes |  |
| `parentNodeIDs` | number[] | no |  |
| `failureRenownRequirement` | number | yes |  |
| `socketEnhanced` | bool | yes |  |

### SoulbindTree (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editable` | bool | no |  |
| `nodes` | SoulbindNode[] | no |  |

