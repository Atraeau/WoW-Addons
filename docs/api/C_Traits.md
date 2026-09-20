# C_Traits

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**53** functions · **15** events · **16** types

## Functions

### C_Traits.CanEditConfig

Returns whether the player can make changes to the specified talent config.

```lua
canEdit, errorMessage = C_Traits.CanEditConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEdit` | bool | no |  |
| `errorMessage` | cstring | no | If canEdit is false, this will be filled out with text explaining why the player can not make changes. |

**Example**

```lua
local canEdit, errorMessage = C_Traits.CanEditConfig(0)
```

### C_Traits.CanPurchaseRank

```lua
canPurchase = C_Traits.CanPurchaseRank(configID, nodeID, nodeEntryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `nodeEntryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPurchase` | bool | no |  |

**Example**

```lua
local canPurchase = C_Traits.CanPurchaseRank(0, 0, 0)
```

### C_Traits.CanRefundRank

```lua
canRefund = C_Traits.CanRefundRank(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRefund` | bool | no |  |

**Example**

```lua
local canRefund = C_Traits.CanRefundRank(0, 0)
```

### C_Traits.CascadeRepurchaseRanks

```lua
success = C_Traits.CascadeRepurchaseRanks(configID, nodeID, [entryID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `entryID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.CascadeRepurchaseRanks(0, 0)
```

### C_Traits.ClearCascadeRepurchaseHistory

```lua
C_Traits.ClearCascadeRepurchaseHistory(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Example**

```lua
C_Traits.ClearCascadeRepurchaseHistory(0)
```

### C_Traits.CloseTraitSystemInteraction

```lua
C_Traits.CloseTraitSystemInteraction()
```

**Example**

```lua
C_Traits.CloseTraitSystemInteraction()
```

### C_Traits.CommitConfig

```lua
success = C_Traits.CommitConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.CommitConfig(0)
```

### C_Traits.ConfigHasStagedChanges

```lua
hasChanges = C_Traits.ConfigHasStagedChanges(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasChanges` | bool | no |  |

**Example**

```lua
local hasChanges = C_Traits.ConfigHasStagedChanges(0)
```

### C_Traits.GenerateImportString

```lua
importString = C_Traits.GenerateImportString(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `importString` | string | no |  |

**Example**

```lua
local importString = C_Traits.GenerateImportString(0)
```

### C_Traits.GenerateInspectImportString

```lua
importString = C_Traits.GenerateInspectImportString(target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `importString` | string | no |  |

**Example**

```lua
local importString = C_Traits.GenerateInspectImportString("")
```

### C_Traits.GetConditionInfo

```lua
condInfo = C_Traits.GetConditionInfo(configID, condID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `condID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `condInfo` | TraitCondInfo | no |  |

**Example**

```lua
local condInfo = C_Traits.GetConditionInfo(0, 0)
```

### C_Traits.GetConfigIDBySystemID

```lua
configID = C_Traits.GetConfigIDBySystemID(systemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `systemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Example**

```lua
local configID = C_Traits.GetConfigIDBySystemID(0)
```

### C_Traits.GetConfigIDByTreeID

```lua
configID = C_Traits.GetConfigIDByTreeID(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Example**

```lua
local configID = C_Traits.GetConfigIDByTreeID(0)
```

### C_Traits.GetConfigInfo

```lua
configInfo = C_Traits.GetConfigInfo(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configInfo` | TraitConfigInfo | no |  |

**Example**

```lua
local configInfo = C_Traits.GetConfigInfo(0)
```

### C_Traits.GetConfigsByType

```lua
configIDs = C_Traits.GetConfigsByType(configType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configType` | TraitConfigType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configIDs` | number[] | no |  |

**Example**

```lua
local configIDs = C_Traits.GetConfigsByType(configType)
```

### C_Traits.GetConfigVariationID

```lua
variationID = C_Traits.GetConfigVariationID(systemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `systemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `variationID` | number | no |  |

**Example**

```lua
local variationID = C_Traits.GetConfigVariationID(0)
```

### C_Traits.GetDefinitionInfo

```lua
definitionInfo = C_Traits.GetDefinitionInfo(definitionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `definitionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `definitionInfo` | TraitDefinitionInfo | no |  |

**Example**

```lua
local definitionInfo = C_Traits.GetDefinitionInfo(0)
```

### C_Traits.GetEntryInfo

```lua
entryInfo = C_Traits.GetEntryInfo(configID, entryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `entryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryInfo` | TraitEntryInfo | no |  |

**Example**

```lua
local entryInfo = C_Traits.GetEntryInfo(0, 0)
```

### C_Traits.GetGroupCurrencyInfo

```lua
groupCurrencyInfos = C_Traits.GetGroupCurrencyInfo(configID, groupIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `groupIDs` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupCurrencyInfos` | GroupCurrencyInfo[] | no |  |

**Example**

```lua
local groupCurrencyInfos = C_Traits.GetGroupCurrencyInfo(0, groupIDs)
```

### C_Traits.GetGroupDisplayInfoByTreeID

```lua
displayInfos = C_Traits.GetGroupDisplayInfoByTreeID(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayInfos` | TraitGroupDisplayInfo[] | no |  |

**Example**

```lua
local displayInfos = C_Traits.GetGroupDisplayInfoByTreeID(0)
```

### C_Traits.GetIncreasedTraitData

```lua
itemName = C_Traits.GetIncreasedTraitData(nodeID, entryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `entryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | IncreasedTraitData[] | no |  |

**Example**

```lua
local itemName = C_Traits.GetIncreasedTraitData(0, 0)
```

### C_Traits.GetLoadoutSerializationVersion

```lua
serializationVersion = C_Traits.GetLoadoutSerializationVersion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serializationVersion` | number | no |  |

**Example**

```lua
local serializationVersion = C_Traits.GetLoadoutSerializationVersion()
```

### C_Traits.GetMaxAvailableTraitCurrency

```lua
maxAvailable = C_Traits.GetMaxAvailableTraitCurrency(traitCurrencyID, limitBySourcedMax)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitCurrencyID` | number | no |  |
| `limitBySourcedMax` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxAvailable` | number | no |  |

**Example**

```lua
local maxAvailable = C_Traits.GetMaxAvailableTraitCurrency(0, false)
```

### C_Traits.GetNodeCost

```lua
costs = C_Traits.GetNodeCost(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `costs` | TraitCurrencyCost[] | no |  |

**Example**

```lua
local costs = C_Traits.GetNodeCost(0, 0)
```

### C_Traits.GetNodeInfo

```lua
nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeInfo` | TraitNodeInfo | no |  |

**Example**

```lua
local nodeInfo = C_Traits.GetNodeInfo(0, 0)
```

### C_Traits.GetStagedChanges

Returns IDs of Trait Nodes with pending changes, grouped by the type of change; Returns nothing if there are no pending changes

```lua
nodeIDsWithPurchases, nodeIDsWithRefunds, nodeIDsWithSelectionSwaps = C_Traits.GetStagedChanges(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeIDsWithPurchases` | number[] | no |  |
| `nodeIDsWithRefunds` | number[] | no |  |
| `nodeIDsWithSelectionSwaps` | number[] | no | Selection nodes that had a previously committed selected entry, and now have a different selected entry pending |

**Example**

```lua
local nodeIDsWithPurchases, nodeIDsWithRefunds, nodeIDsWithSelectionSwaps = C_Traits.GetStagedChanges(0)
```

### C_Traits.GetStagedChangesCost

```lua
costs = C_Traits.GetStagedChangesCost(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `costs` | TraitCurrencyCost[] | no |  |

**Example**

```lua
local costs = C_Traits.GetStagedChangesCost(0)
```

### C_Traits.GetSubTreeInfo

```lua
subTreeInfo = C_Traits.GetSubTreeInfo(configID, subTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `subTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subTreeInfo` | TraitSubTreeInfo | no |  |

**Example**

```lua
local subTreeInfo = C_Traits.GetSubTreeInfo(0, 0)
```

### C_Traits.GetSystemIDByTreeID

```lua
systemID = C_Traits.GetSystemIDByTreeID(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `systemID` | number | no |  |

**Example**

```lua
local systemID = C_Traits.GetSystemIDByTreeID(0)
```

### C_Traits.GetTraitCurrencyForAchievement

```lua
amount = C_Traits.GetTraitCurrencyForAchievement(traitCurrencyID, achievementID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitCurrencyID` | number | no |  |
| `achievementID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
local amount = C_Traits.GetTraitCurrencyForAchievement(0, 0)
```

### C_Traits.GetTraitCurrencyInfo

```lua
flags, type, currencyTypesID, icon = C_Traits.GetTraitCurrencyInfo(traitCurrencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitCurrencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flags` | number | no |  |
| `type` | number | no |  |
| `currencyTypesID` | number | yes |  |
| `icon` | number | yes |  |

**Example**

```lua
local flags, type, currencyTypesID, icon = C_Traits.GetTraitCurrencyInfo(0)
```

### C_Traits.GetTraitDescription

```lua
description = C_Traits.GetTraitDescription(entryID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no |  |

**Example**

```lua
local description = C_Traits.GetTraitDescription(0, 1)
```

### C_Traits.GetTraitSystemFlags

```lua
flags = C_Traits.GetTraitSystemFlags(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flags` | number | no |  |

**Example**

```lua
local flags = C_Traits.GetTraitSystemFlags(0)
```

### C_Traits.GetTraitSystemWidgetSetID

```lua
uiWidgetSetID = C_Traits.GetTraitSystemWidgetSetID(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiWidgetSetID` | number | no |  |

**Example**

```lua
local uiWidgetSetID = C_Traits.GetTraitSystemWidgetSetID(0)
```

### C_Traits.GetTreeCurrencyInfo

```lua
treeCurrencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, excludeStagedChanges)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `treeID` | number | no |  |
| `excludeStagedChanges` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeCurrencyInfo` | TreeCurrencyInfo[] | no |  |

**Example**

```lua
local treeCurrencyInfo = C_Traits.GetTreeCurrencyInfo(0, 0, false)
```

### C_Traits.GetTreeHash

```lua
result = C_Traits.GetTreeHash(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number[] | no |  |

**Example**

```lua
local result = C_Traits.GetTreeHash(0)
```

### C_Traits.GetTreeInfo

```lua
treeInfo = C_Traits.GetTreeInfo(configID, treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeInfo` | TraitTreeInfo | no |  |

**Example**

```lua
local treeInfo = C_Traits.GetTreeInfo(0, 0)
```

### C_Traits.GetTreeNodes

Returns a list of nodeIDs, sorted ascending, for a given treeID. Contains nodes for all class specializations.

```lua
nodeIDs = C_Traits.GetTreeNodes(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeIDs` | number[] | no |  |

**Example**

```lua
local nodeIDs = C_Traits.GetTreeNodes(0)
```

### C_Traits.HasValidInspectData

```lua
hasValidInspectData = C_Traits.HasValidInspectData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasValidInspectData` | bool | no |  |

**Example**

```lua
local hasValidInspectData = C_Traits.HasValidInspectData()
```

### C_Traits.IsReadyForCommit

```lua
isReadyForCommit = C_Traits.IsReadyForCommit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReadyForCommit` | bool | no |  |

**Example**

```lua
local isReadyForCommit = C_Traits.IsReadyForCommit()
```

### C_Traits.PurchaseAllRanks

```lua
success = C_Traits.PurchaseAllRanks(configID, nodeID, ignoreCost)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `ignoreCost` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.PurchaseAllRanks(0, 0, false)
```

### C_Traits.PurchaseRank

```lua
success = C_Traits.PurchaseRank(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.PurchaseRank(0, 0)
```

### C_Traits.RefundAllRanks

```lua
success = C_Traits.RefundAllRanks(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.RefundAllRanks(0, 0)
```

### C_Traits.RefundRank

```lua
success = C_Traits.RefundRank(configID, nodeID, [clearEdges])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `clearEdges` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.RefundRank(0, 0)
```

### C_Traits.ResetTree

```lua
success = C_Traits.ResetTree(configID, treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.ResetTree(0, 0)
```

### C_Traits.ResetTreeByCurrency

```lua
success = C_Traits.ResetTreeByCurrency(configID, treeID, traitCurrencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `treeID` | number | no |  |
| `traitCurrencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.ResetTreeByCurrency(0, 0, 0)
```

### C_Traits.RollbackConfig

```lua
success = C_Traits.RollbackConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.RollbackConfig(0)
```

### C_Traits.SetSelection

```lua
success = C_Traits.SetSelection(configID, nodeID, [nodeEntryID], [clearEdges])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `nodeEntryID` | number | yes |  |
| `clearEdges` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.SetSelection(0, 0)
```

### C_Traits.StageConfig

```lua
success = C_Traits.StageConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.StageConfig(0)
```

### C_Traits.TalentTestUnlearnSpells

```lua
C_Traits.TalentTestUnlearnSpells()
```

**Example**

```lua
C_Traits.TalentTestUnlearnSpells()
```

### C_Traits.TryPurchaseAllRanks

```lua
success = C_Traits.TryPurchaseAllRanks(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.TryPurchaseAllRanks(0, 0)
```

### C_Traits.TryPurchaseToNode

```lua
success = C_Traits.TryPurchaseToNode(configID, nodeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.TryPurchaseToNode(0, 0)
```

### C_Traits.TryRefundToNode

```lua
success = C_Traits.TryRefundToNode(configID, nodeID, entryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `nodeID` | number | no |  |
| `entryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Traits.TryRefundToNode(0, 0, 0)
```

## Events

### CONFIG_COMMIT_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

### TRAIT_COND_INFO_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `condID` | number | no |  |

### TRAIT_CONFIG_CREATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configInfo` | TraitConfigInfo | no |  |

### TRAIT_CONFIG_DELETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

### TRAIT_CONFIG_LIST_UPDATED

### TRAIT_CONFIG_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

### TRAIT_NODE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

### TRAIT_NODE_CHANGED_PARTIAL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `info` | TraitNodeInfoPartial | no |  |

### TRAIT_NODE_ENTRY_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeEntryID` | number | no |  |

### TRAIT_SUB_TREE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subTreeID` | number | no |  |

### TRAIT_SYSTEM_INTERACTION_STARTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

### TRAIT_SYSTEM_NPC_CLOSED

### TRAIT_TREE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

### TRAIT_TREE_CURRENCY_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

### TRY_PURCHASE_TO_NODE_PARTIAL_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeFinishedOn` | number | no |  |

## Types

### GroupCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitNodeGroupID` | number | no |  |
| `currencyInfos` | TreeCurrencyInfo[] | no |  |

### IncreasedTraitData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemNameIncreasing` | string | no |  |
| `itemQualityIncreasing` | ItemQuality | no |  |
| `numPointsIncreased` | number | no |  |

### TraitCondInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `condID` | number | no |  |
| `ranksGranted` | number | yes |  |
| `isAlwaysMet` | bool | no |  |
| `isMet` | bool | no | True if the source for the condition has been fulfilled. |
| `isGate` | bool | no |  |
| `isSufficient` | bool | no | True if meeting the requirements for the condition means any nodes using this condition are considered fulfilled if the condition is met. |
| `type` | number | no | The value from the TraitConditionType enum the condition uses. |
| `questID` | number | yes |  |
| `achievementID` | number | yes |  |
| `specSetID` | number | yes |  |
| `playerLevel` | number | yes |  |
| `traitCurrencyID` | number | yes |  |
| `spentAmountRequired` | number | yes |  |
| `tooltipFormat` | string | yes |  |
| `traitCondAccountElementID` | number | yes |  |

### TraitConfigInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `type` | TraitConfigType | no |  |
| `name` | string | no |  |
| `treeIDs` | number[] | no |  |
| `usesSharedActionBars` | bool | no |  |

### TraitCurrencyCost (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `amount` | number | no |  |

### TraitDefinitionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |
| `overrideName` | string | yes |  |
| `overrideSubtext` | string | yes |  |
| `overrideDescription` | string | yes |  |
| `overrideIcon` | number | yes |  |
| `overriddenSpellID` | number | yes |  |
| `subType` | TraitDefinitionSubType | yes |  |

### TraitEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `definitionID` | number | yes | Nil on SubTreeSelection Node Entries |
| `subTreeID` | number | yes | Populated only on SubTreeSelection Node Entries; This is the SubTree that is activated if this Entry is chosen |
| `type` | TraitNodeEntryType | no |  |
| `maxRanks` | number | no |  |
| `isAvailable` | bool | no |  |
| `isDisplayError` | bool | no | True if this entry fails the TRAIT_CONDITION_TYPE_DISPLAY_ERROR condition check. Used to communicate a problem with the node to the player (e.g. A prerequisite node has not been purchased.) but will not prevent the player from spending points on the node. |
| `conditionIDs` | number[] | no |  |

### TraitEntryRankInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |
| `rank` | number | no |  |

### TraitGateInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `topLeftNodeID` | number | no |  |
| `conditionID` | number | no |  |

### TraitGroupDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `treeID` | number | no |  |
| `skillLineID` | number | no |  |
| `orderIndex` | number | no |  |
| `displayName` | cstring | no |  |
| `icon` | number | no |  |

### TraitNodeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `posX` | number | no |  |
| `posY` | number | no |  |
| `flags` | number | no |  |
| `entryIDs` | number[] | no |  |
| `entryIDsWithCommittedRanks` | number[] | no |  |
| `canPurchaseRank` | bool | no |  |
| `canRefundRank` | bool | no |  |
| `isAvailable` | bool | no |  |
| `isVisible` | bool | no |  |
| `isDisplayError` | bool | no | True if this node fails the TRAIT_CONDITION_TYPE_DISPLAY_ERROR condition check. Used to communicate a problem with the node to the player (e.g. A prerequisite node has not been purchased.) but will not prevent the player from spending points on the node. |
| `ranksPurchased` | number | no |  |
| `ranksIncreased` | number | no |  |
| `entryIDToRanksIncreased` | LuaValueVariant | no | A map of the entry IDs on this node to the number of ranks increased. This covers all entries on the node, which is important in the case of selection nodes where we have more than one option that could be increased. |
| `activeRank` | number | no |  |
| `currentRank` | number | no |  |
| `activeEntry` | TraitEntryRankInfo | yes |  |
| `nextEntry` | TraitEntryRankInfo | yes |  |
| `maxRanks` | number | no |  |
| `totalMaxRanks` | number | no |  |
| `type` | TraitNodeType | no |  |
| `visibleEdges` | TraitOutEdgeInfo[] | no |  |
| `meetsEdgeRequirements` | bool | no |  |
| `groupIDs` | number[] | no |  |
| `conditionIDs` | number[] | no |  |
| `isCascadeRepurchasable` | bool | no |  |
| `cascadeRepurchaseEntryID` | number | yes |  |
| `subTreeID` | number | yes | The SubTree this Node belongs to; Nil if it is not part of a SubTree |
| `subTreeActive` | bool | yes | True if this node has a SubTreeID, and the SubTree is chosen or staged; May be nil if not part of a SubTree at all |

### TraitNodeInfoPartial (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPurchaseRank` | bool | yes |  |
| `canRefundRank` | bool | yes |  |
| `isAvailable` | bool | yes |  |
| `isVisible` | bool | yes |  |
| `ranksPurchased` | number | yes |  |
| `activeRank` | number | yes |  |
| `currentRank` | number | yes |  |
| `meetsEdgeRequirements` | bool | yes |  |
| `isCascadeRepurchasable` | bool | yes |  |
| `activeEntryID` | number | yes |  |
| `subTreeActive` | bool | yes |  |

### TraitOutEdgeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetNode` | number | no |  |
| `type` | number | no |  |
| `visualStyle` | number | no |  |
| `isActive` | bool | no |  |

### TraitSubTreeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `name` | string | yes |  |
| `description` | string | yes |  |
| `iconElementID` | textureAtlas | yes |  |
| `traitCurrencyID` | number | yes |  |
| `isActive` | bool | no |  |
| `subTreeSelectionNodeIDs` | number[] | no | SubTreeSelectionNodes whose choice entries include this SubTree |
| `posX` | number | no | Center X node position calculated from the posX values of all of this subTree's nodes |
| `posY` | number | no | Topmost Y node position taken from the posY values of all of this subTree's nodes |

### TraitTreeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `gates` | TraitGateInfo[] | no |  |
| `hideSingleRankNumbers` | bool | no |  |
| `cannotRefund` | bool | no |  |
| `rootNodeID` | number | yes |  |
| `uiTextureKit` | textureKit | no |  |
| `titleText` | string | yes |  |

### TreeCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitCurrencyID` | number | no |  |
| `quantity` | number | no |  |
| `maxQuantity` | number | yes |  |
| `spent` | number | no |  |
| `spentInTree` | number | yes |  |

