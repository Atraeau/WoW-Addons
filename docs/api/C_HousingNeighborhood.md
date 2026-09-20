# C_HousingNeighborhood

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**30** functions · **13** events · **1** types

## Functions

### C_HousingNeighborhood.CancelInviteToNeighborhood

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.CancelInviteToNeighborhood(playerName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.CancelInviteToNeighborhood("")
```

### C_HousingNeighborhood.CanReturnAfterVisitingHouse

```lua
canReturn = C_HousingNeighborhood.CanReturnAfterVisitingHouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canReturn` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canReturn = C_HousingNeighborhood.CanReturnAfterVisitingHouse()
```

### C_HousingNeighborhood.DemoteToResident

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.DemoteToResident(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.DemoteToResident(UnitGUID("player"))
```

### C_HousingNeighborhood.GetCornerstoneHouseInfo

Only available when interacting with a cornerstone game object

```lua
houseInfo = C_HousingNeighborhood.GetCornerstoneHouseInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfo` | HouseInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local houseInfo = C_HousingNeighborhood.GetCornerstoneHouseInfo()
```

### C_HousingNeighborhood.GetCornerstoneNeighborhoodInfo

Only available when interacting with a cornerstone game object

```lua
neighborhoodInfo = C_HousingNeighborhood.GetCornerstoneNeighborhoodInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodInfo` | NeighborhoodInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodInfo = C_HousingNeighborhood.GetCornerstoneNeighborhoodInfo()
```

### C_HousingNeighborhood.GetCornerstonePurchaseMode

Only available when interacting with a cornerstone game object

```lua
purchaseMode = C_HousingNeighborhood.GetCornerstonePurchaseMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `purchaseMode` | CornerstonePurchaseMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local purchaseMode = C_HousingNeighborhood.GetCornerstonePurchaseMode()
```

### C_HousingNeighborhood.GetCurrentNeighborhoodTextureSuffix

```lua
neighborhoodTextureSuffix = C_HousingNeighborhood.GetCurrentNeighborhoodTextureSuffix()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodTextureSuffix` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodTextureSuffix = C_HousingNeighborhood.GetCurrentNeighborhoodTextureSuffix()
```

### C_HousingNeighborhood.GetDiscountedMovePrice

Only available when interacting with a cornerstone game object

```lua
movePrice = C_HousingNeighborhood.GetDiscountedMovePrice()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movePrice` | number | no | Can be negative if the refund from moving is more than the cost of the new house |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local movePrice = C_HousingNeighborhood.GetDiscountedMovePrice()
```

### C_HousingNeighborhood.GetMoveCooldownTime

Only available when interacting with a cornerstone game object

```lua
movecooldownTime = C_HousingNeighborhood.GetMoveCooldownTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movecooldownTime` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local movecooldownTime = C_HousingNeighborhood.GetMoveCooldownTime()
```

### C_HousingNeighborhood.GetNeighborhoodMapData

```lua
neighborhoodPlots = C_HousingNeighborhood.GetNeighborhoodMapData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodPlots` | NeighborhoodPlotMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodPlots = C_HousingNeighborhood.GetNeighborhoodMapData()
```

### C_HousingNeighborhood.GetNeighborhoodName

```lua
neighborhoodName = C_HousingNeighborhood.GetNeighborhoodName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodName = C_HousingNeighborhood.GetNeighborhoodName()
```

### C_HousingNeighborhood.GetNeighborhoodPlotName

```lua
neighborhoodName = C_HousingNeighborhood.GetNeighborhoodPlotName(plotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `plotIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodName = C_HousingNeighborhood.GetNeighborhoodPlotName(1)
```

### C_HousingNeighborhood.GetPreviousHouseIdentifier

Only available when interacting with a cornerstone game object

```lua
previousHouseIdentifier = C_HousingNeighborhood.GetPreviousHouseIdentifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previousHouseIdentifier` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local previousHouseIdentifier = C_HousingNeighborhood.GetPreviousHouseIdentifier()
```

### C_HousingNeighborhood.HasPermissionToPurchase

Only available when interacting with a cornerstone game object

```lua
cantPurchaseReason = C_HousingNeighborhood.HasPermissionToPurchase()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cantPurchaseReason` | PurchaseHouseDisabledReason | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cantPurchaseReason = C_HousingNeighborhood.HasPermissionToPurchase()
```

### C_HousingNeighborhood.InvitePlayerToNeighborhood

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.InvitePlayerToNeighborhood(playerName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.InvitePlayerToNeighborhood("")
```

### C_HousingNeighborhood.IsNeighborhoodManager

```lua
isManager = C_HousingNeighborhood.IsNeighborhoodManager()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isManager` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isManager = C_HousingNeighborhood.IsNeighborhoodManager()
```

### C_HousingNeighborhood.IsNeighborhoodOwner

```lua
isOwner = C_HousingNeighborhood.IsNeighborhoodOwner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOwner` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isOwner = C_HousingNeighborhood.IsNeighborhoodOwner()
```

### C_HousingNeighborhood.IsPlayerInOtherPlayersPlot

This returns true if the player is in a plot that is owned by another player

```lua
isInUnownedPlot = C_HousingNeighborhood.IsPlayerInOtherPlayersPlot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInUnownedPlot` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInUnownedPlot = C_HousingNeighborhood.IsPlayerInOtherPlayersPlot()
```

### C_HousingNeighborhood.IsPlotAvailableForPurchase

Only available when interacting with a cornerstone game object

```lua
isAvailable = C_HousingNeighborhood.IsPlotAvailableForPurchase()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailable = C_HousingNeighborhood.IsPlotAvailableForPurchase()
```

### C_HousingNeighborhood.IsPlotOwnedByPlayer

Only available when interacting with a cornerstone game object

```lua
isPlayerOwned = C_HousingNeighborhood.IsPlotOwnedByPlayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlayerOwned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlayerOwned = C_HousingNeighborhood.IsPlotOwnedByPlayer()
```

### C_HousingNeighborhood.OnBulletinBoardClosed

```lua
C_HousingNeighborhood.OnBulletinBoardClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.OnBulletinBoardClosed()
```

### C_HousingNeighborhood.OnCornerstoneClosed

```lua
C_HousingNeighborhood.OnCornerstoneClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.OnCornerstoneClosed()
```

### C_HousingNeighborhood.PromoteToManager

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.PromoteToManager(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.PromoteToManager(UnitGUID("player"))
```

### C_HousingNeighborhood.RequestNeighborhoodInfo

```lua
C_HousingNeighborhood.RequestNeighborhoodInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.RequestNeighborhoodInfo()
```

### C_HousingNeighborhood.RequestNeighborhoodRoster

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.RequestNeighborhoodRoster()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.RequestNeighborhoodRoster()
```

### C_HousingNeighborhood.RequestPendingNeighborhoodInvites

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.RequestPendingNeighborhoodInvites()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.RequestPendingNeighborhoodInvites()
```

### C_HousingNeighborhood.TransferNeighborhoodOwnership

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.TransferNeighborhoodOwnership(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.TransferNeighborhoodOwnership(UnitGUID("player"))
```

### C_HousingNeighborhood.TryEvictPlayer

Only available when interacting with a bulletin board game object

```lua
C_HousingNeighborhood.TryEvictPlayer(plotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `plotID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.TryEvictPlayer(0)
```

### C_HousingNeighborhood.TryMoveHouse

Only available when interacting with a cornerstone game object

```lua
C_HousingNeighborhood.TryMoveHouse()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.TryMoveHouse()
```

### C_HousingNeighborhood.TryPurchasePlot

Only available when interacting with a cornerstone game object

```lua
C_HousingNeighborhood.TryPurchasePlot()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingNeighborhood.TryPurchasePlot()
```

## Events

### CANCEL_NEIGHBORHOOD_INVITE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | NeighborhoodInviteResult | no |  |
| `playerName` | cstring | yes |  |

### CLOSE_PLOT_CORNERSTONE

### NEIGHBORHOOD_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodInfo` | NeighborhoodInfo | no |  |

### NEIGHBORHOOD_INVITE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | NeighborhoodInviteResult | no |  |

### NEIGHBORHOOD_MAP_DATA_UPDATED

### NEIGHBORHOOD_NAME_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGuid` | WOWGUID | no |  |
| `neighborhoodName` | cstring | no |  |

### OPEN_PLOT_CORNERSTONE

### PENDING_NEIGHBORHOOD_INVITES_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | NeighborhoodInviteResult | no |  |
| `pendingInviteList` | string[] | yes |  |

### PURCHASE_PLOT_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### SHOW_PLAYER_EVICTED_DIALOG

### UPDATE_BULLETIN_BOARD_MEMBER_TYPE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `player` | WOWGUID | no |  |
| `residentType` | ResidentType | no |  |

### UPDATE_BULLETIN_BOARD_ROSTER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodInfo` | NeighborhoodInfo | no |  |
| `rosterMemberList` | NeighborhoodRosterMemberInfo[] | no |  |

### UPDATE_BULLETIN_BOARD_ROSTER_STATUSES

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rosterMemberList` | NeighborhoodRosterMemberUpdateInfo[] | no |  |

## Types

### CornerstonePurchaseMode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Basic` | CornerstonePurchaseMode | no |  |
| `Import` | CornerstonePurchaseMode | no |  |
| `Move` | CornerstonePurchaseMode | no |  |

