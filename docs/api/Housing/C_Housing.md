# C_Housing

[← API index](../README.md) · group: [Housing](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**62** functions · **39** events · **2** types

## Functions

### C_Housing.AcceptNeighborhoodOwnership

```lua
C_Housing.AcceptNeighborhoodOwnership()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.AcceptNeighborhoodOwnership()
```

### C_Housing.CanEditCharter

```lua
canEditCharter = C_Housing.CanEditCharter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEditCharter` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canEditCharter = C_Housing.CanEditCharter()
```

### C_Housing.CanTakeReportScreenshot

```lua
reason = C_Housing.CanTakeReportScreenshot(plotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `plotIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | InvalidPlotScreenshotReason | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reason = C_Housing.CanTakeReportScreenshot(1)
```

### C_Housing.CreateGuildNeighborhood

```lua
C_Housing.CreateGuildNeighborhood(neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.CreateGuildNeighborhood("")
```

### C_Housing.CreateNeighborhoodCharter

```lua
C_Housing.CreateNeighborhoodCharter(neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.CreateNeighborhoodCharter("")
```

### C_Housing.DeclineNeighborhoodOwnership

```lua
C_Housing.DeclineNeighborhoodOwnership()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.DeclineNeighborhoodOwnership()
```

### C_Housing.DoesFactionMatchNeighborhood

```lua
factionMatches = C_Housing.DoesFactionMatchNeighborhood(neighborhoodGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionMatches` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local factionMatches = C_Housing.DoesFactionMatchNeighborhood(UnitGUID("player"))
```

### C_Housing.EditNeighborhoodCharter

```lua
C_Housing.EditNeighborhoodCharter(neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.EditNeighborhoodCharter("")
```

### C_Housing.GetCurrentHouseInfo

```lua
houseInfo = C_Housing.GetCurrentHouseInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfo` | HouseInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local houseInfo = C_Housing.GetCurrentHouseInfo()
```

### C_Housing.GetCurrentHouseLevelFavor

```lua
C_Housing.GetCurrentHouseLevelFavor(houseGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseGuid` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.GetCurrentHouseLevelFavor(UnitGUID("player"))
```

### C_Housing.GetCurrentHouseRefundAmount

```lua
refundAmount = C_Housing.GetCurrentHouseRefundAmount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundAmount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local refundAmount = C_Housing.GetCurrentHouseRefundAmount()
```

### C_Housing.GetCurrentNeighborhoodGUID

```lua
neighborhoodGUID = C_Housing.GetCurrentNeighborhoodGUID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodGUID = C_Housing.GetCurrentNeighborhoodGUID()
```

### C_Housing.GetHouseLevelFavorForLevel

```lua
houseFavor = C_Housing.GetHouseLevelFavorForLevel(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseFavor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local houseFavor = C_Housing.GetHouseLevelFavorForLevel(0)
```

### C_Housing.GetHouseLevelRewardsForLevel

```lua
C_Housing.GetHouseLevelRewardsForLevel(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.GetHouseLevelRewardsForLevel(0)
```

### C_Housing.GetHousingAccessFlags

```lua
accessFlags = C_Housing.GetHousingAccessFlags()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accessFlags` | HouseSettingFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accessFlags = C_Housing.GetHousingAccessFlags()
```

### C_Housing.GetMaxHouseLevel

```lua
level = C_Housing.GetMaxHouseLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local level = C_Housing.GetMaxHouseLevel()
```

### C_Housing.GetNeighborhoodTextureSuffix

```lua
neighborhoodTextureSuffix = C_Housing.GetNeighborhoodTextureSuffix(neighborhoodGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodTextureSuffix` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local neighborhoodTextureSuffix = C_Housing.GetNeighborhoodTextureSuffix(UnitGUID("player"))
```

### C_Housing.GetOthersOwnedHouses

```lua
C_Housing.GetOthersOwnedHouses([playerGUID], [bnetID], isInPlayersGuild)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | yes |  |
| `bnetID` | number | yes |  |
| `isInPlayersGuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.GetOthersOwnedHouses(false)
```

### C_Housing.GetPlayerOwnedHouses

```lua
C_Housing.GetPlayerOwnedHouses()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.GetPlayerOwnedHouses()
```

### C_Housing.GetTrackedHouseGuid

```lua
trackedHouse = C_Housing.GetTrackedHouseGuid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedHouse` | WOWGUID | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trackedHouse = C_Housing.GetTrackedHouseGuid()
```

### C_Housing.GetUIMapIDForNeighborhood

```lua
uiMapID = C_Housing.GetUIMapIDForNeighborhood(neighborhoodGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGuid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiMapID = C_Housing.GetUIMapIDForNeighborhood(UnitGUID("player"))
```

### C_Housing.GetVisitCooldownInfo

```lua
spellCooldownInfo = C_Housing.GetVisitCooldownInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCooldownInfo` | SpellCooldownInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellCooldownInfo = C_Housing.GetVisitCooldownInfo()
```

### C_Housing.HasHousingExpansionAccess

```lua
hasAccess = C_Housing.HasHousingExpansionAccess()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAccess` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAccess = C_Housing.HasHousingExpansionAccess()
```

### C_Housing.HouseFinderDeclineNeighborhoodInvitation

```lua
C_Housing.HouseFinderDeclineNeighborhoodInvitation()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.HouseFinderDeclineNeighborhoodInvitation()
```

### C_Housing.HouseFinderIgnoreNeighborhood

```lua
C_Housing.HouseFinderIgnoreNeighborhood(neighborhoodGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGuid` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.HouseFinderIgnoreNeighborhood(UnitGUID("player"))
```

### C_Housing.HouseFinderRequestNeighborhoods

```lua
C_Housing.HouseFinderRequestNeighborhoods()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.HouseFinderRequestNeighborhoods()
```

### C_Housing.HouseFinderRequestReservationAndPort

```lua
C_Housing.HouseFinderRequestReservationAndPort(neighborhoodGuid, plotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGuid` | WOWGUID | no |  |
| `plotID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.HouseFinderRequestReservationAndPort(UnitGUID("player"), 0)
```

### C_Housing.IsHousingMarketCartFullRemoveEnabled

```lua
isHousingMarketCartFullRemoveEnabled = C_Housing.IsHousingMarketCartFullRemoveEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHousingMarketCartFullRemoveEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHousingMarketCartFullRemoveEnabled = C_Housing.IsHousingMarketCartFullRemoveEnabled()
```

### C_Housing.IsHousingMarketEnabled

```lua
isHousingMarketEnabled = C_Housing.IsHousingMarketEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHousingMarketEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHousingMarketEnabled = C_Housing.IsHousingMarketEnabled()
```

### C_Housing.IsHousingMarketShopEnabled

```lua
isHousingMarketShopEnabled = C_Housing.IsHousingMarketShopEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHousingMarketShopEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHousingMarketShopEnabled = C_Housing.IsHousingMarketShopEnabled()
```

### C_Housing.IsHousingServiceEnabled

```lua
isAvailable = C_Housing.IsHousingServiceEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailable = C_Housing.IsHousingServiceEnabled()
```

### C_Housing.IsInsideHouse

```lua
isInside = C_Housing.IsInsideHouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInside` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInside = C_Housing.IsInsideHouse()
```

### C_Housing.IsInsideHouseOrPlot

```lua
isInside = C_Housing.IsInsideHouseOrPlot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInside` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInside = C_Housing.IsInsideHouseOrPlot()
```

### C_Housing.IsInsideOwnedHouse

```lua
isInsideOwnedHouse = C_Housing.IsInsideOwnedHouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInsideOwnedHouse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInsideOwnedHouse = C_Housing.IsInsideOwnedHouse()
```

### C_Housing.IsInsideOwnedHouseOrPlot

```lua
isInsideOwnedHouseOrPlot = C_Housing.IsInsideOwnedHouseOrPlot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInsideOwnedHouseOrPlot` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInsideOwnedHouseOrPlot = C_Housing.IsInsideOwnedHouseOrPlot()
```

### C_Housing.IsInsideOwnedPlot

```lua
isInside = C_Housing.IsInsideOwnedPlot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInside` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInside = C_Housing.IsInsideOwnedPlot()
```

### C_Housing.IsInsidePlot

```lua
isInside = C_Housing.IsInsidePlot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInside` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInside = C_Housing.IsInsidePlot()
```

### C_Housing.IsOnNeighborhoodMap

```lua
isOnNeighborhoodMap = C_Housing.IsOnNeighborhoodMap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOnNeighborhoodMap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isOnNeighborhoodMap = C_Housing.IsOnNeighborhoodMap()
```

### C_Housing.LeaveHouse

```lua
C_Housing.LeaveHouse()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.LeaveHouse()
```

### C_Housing.OnCharterConfirmationAccepted

```lua
C_Housing.OnCharterConfirmationAccepted()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnCharterConfirmationAccepted()
```

### C_Housing.OnCharterConfirmationClosed

```lua
C_Housing.OnCharterConfirmationClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnCharterConfirmationClosed()
```

### C_Housing.OnCreateCharterNeighborhoodClosed

```lua
C_Housing.OnCreateCharterNeighborhoodClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnCreateCharterNeighborhoodClosed()
```

### C_Housing.OnCreateGuildNeighborhoodClosed

```lua
C_Housing.OnCreateGuildNeighborhoodClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnCreateGuildNeighborhoodClosed()
```

### C_Housing.OnHouseFinderClickPlot

```lua
C_Housing.OnHouseFinderClickPlot(plotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `plotID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnHouseFinderClickPlot(0)
```

### C_Housing.OnRequestSignatureClicked

```lua
C_Housing.OnRequestSignatureClicked()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnRequestSignatureClicked()
```

### C_Housing.OnSignCharterClicked

```lua
C_Housing.OnSignCharterClicked(charterOwnerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `charterOwnerGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.OnSignCharterClicked(UnitGUID("player"))
```

### C_Housing.RelinquishHouse

```lua
C_Housing.RelinquishHouse(houseGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseGuid` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.RelinquishHouse(UnitGUID("player"))
```

### C_Housing.RequestCurrentHouseInfo

```lua
C_Housing.RequestCurrentHouseInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.RequestCurrentHouseInfo()
```

### C_Housing.RequestHouseFinderNeighborhoodData

```lua
C_Housing.RequestHouseFinderNeighborhoodData(neighborhoodGuid, neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGuid` | WOWGUID | no |  |
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.RequestHouseFinderNeighborhoodData(UnitGUID("player"), "")
```

### C_Housing.RequestPlayerCharacterList

```lua
C_Housing.RequestPlayerCharacterList()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.RequestPlayerCharacterList()
```

### C_Housing.ResetHouse

Resets all contents of the house, based on the provided scope; API restricted to ensure this can't be triggered without the player getting ample notice and confirmation

```lua
C_Housing.ResetHouse(resetScope)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resetScope` | HousingHouseScope | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.ResetHouse(resetScope)
```

### C_Housing.ReturnAfterVisitingHouse

```lua
C_Housing.ReturnAfterVisitingHouse()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.ReturnAfterVisitingHouse()
```

### C_Housing.SaveHouseSettings

```lua
C_Housing.SaveHouseSettings(playerGUID, accessFlags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |
| `accessFlags` | HouseSettingFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.SaveHouseSettings(UnitGUID("player"), accessFlags)
```

### C_Housing.SearchBNetFriendNeighborhoods

```lua
isValidBnetFriend = C_Housing.SearchBNetFriendNeighborhoods(bnetName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bnetName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidBnetFriend` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValidBnetFriend = C_Housing.SearchBNetFriendNeighborhoods("")
```

### C_Housing.SearchBNetFriendNeighborhoodsByID

```lua
isValidBnetFriend = C_Housing.SearchBNetFriendNeighborhoodsByID(bnetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bnetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidBnetFriend` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValidBnetFriend = C_Housing.SearchBNetFriendNeighborhoodsByID(0)
```

### C_Housing.SetTrackedHouseGuid

```lua
C_Housing.SetTrackedHouseGuid([trackedHouse])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedHouse` | WOWGUID | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.SetTrackedHouseGuid()
```

### C_Housing.StartTutorial

```lua
C_Housing.StartTutorial()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.StartTutorial()
```

### C_Housing.TeleportHome

```lua
C_Housing.TeleportHome(neighborhoodGUID, houseGUID, plotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |
| `houseGUID` | WOWGUID | no |  |
| `plotID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.TeleportHome(UnitGUID("player"), UnitGUID("player"), 0)
```

### C_Housing.TryRenameNeighborhood

```lua
C_Housing.TryRenameNeighborhood(neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.TryRenameNeighborhood("")
```

### C_Housing.ValidateCreateGuildNeighborhoodSize

```lua
C_Housing.ValidateCreateGuildNeighborhoodSize()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.ValidateCreateGuildNeighborhoodSize()
```

### C_Housing.ValidateNeighborhoodName

```lua
C_Housing.ValidateNeighborhoodName(neighborhoodName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.ValidateNeighborhoodName("")
```

### C_Housing.VisitHouse

```lua
C_Housing.VisitHouse(neighborhoodGUID, houseGUID, plotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |
| `houseGUID` | WOWGUID | no |  |
| `plotID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Housing.VisitHouse(UnitGUID("player"), UnitGUID("player"), 0)
```

## Events

### ADD_NEIGHBORHOOD_CHARTER_SIGNATURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `signature` | cstring | no |  |

### B_NET_NEIGHBORHOOD_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |
| `neighborhoodInfos` | NeighborhoodInfo[] | yes |  |

### CLOSE_CHARTER_CONFIRMATION_UI

### CLOSE_CREATE_CHARTER_NEIGHBORHOOD_UI

### CLOSE_CREATE_GUILD_NEIGHBORHOOD_UI

### CREATE_NEIGHBORHOOD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |
| `neighborhoodName` | cstring | yes |  |

### CURRENT_HOUSE_INFO_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfo` | HouseInfo | no |  |

### CURRENT_HOUSE_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfo` | HouseInfo | no |  |

### DECLINE_NEIGHBORHOOD_INVITATION_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### FORCE_REFRESH_HOUSE_FINDER

### HOUSE_FINDER_NEIGHBORHOOD_DATA_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodPlots` | NeighborhoodPlotMapInfo[] | no |  |

### HOUSE_INFO_UPDATED

### HOUSE_LEVEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newHouseLevelInfo` | HouseLevelInfo | yes |  |

### HOUSE_LEVEL_FAVOR_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseLevelFavor` | HouseLevelFavor | no |  |

### HOUSE_PLOT_ENTERED

### HOUSE_PLOT_EXITED

### HOUSE_RESERVATION_RESPONSE_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSE_RESET_COMPLETED

### HOUSE_RESET_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_MARKET_AVAILABILITY_UPDATED

### HOUSING_SERVICES_AVAILABILITY_UPDATED

### IGNORE_NEIGHBORHOOD_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `neighborhoodGuid` | WOWGUID | no |  |

### MOVE_OUT_RESERVATION_UPDATED

### NEIGHBORHOOD_GUILD_SIZE_VALIDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `approved` | bool | no |  |

### NEIGHBORHOOD_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |
| `neighborhoodInfos` | NeighborhoodInfo[] | yes |  |

### NEIGHBORHOOD_NAME_VALIDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `approved` | bool | no |  |

### NEW_HOUSING_ITEM_ACQUIRED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemType` | HousingItemToastType | no |  |
| `itemName` | cstring | no |  |
| `icon` | fileID | yes |  |

### OPEN_CHARTER_CONFIRMATION_UI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | string | no |  |
| `locationName` | string | no |  |

### OPEN_CREATE_CHARTER_NEIGHBORHOOD_UI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationName` | cstring | no |  |

### OPEN_CREATE_GUILD_NEIGHBORHOOD_UI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationName` | cstring | no |  |

### OPEN_NEIGHBORHOOD_CHARTER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodInfo` | NeighborhoodInfo | no |  |
| `signatures` | string[] | no |  |
| `requiredSignatures` | number | no |  |

### OPEN_NEIGHBORHOOD_CHARTER_SIGNATURE_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodInfo` | NeighborhoodInfo | no |  |

### PLAYER_CHARACTER_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterInfos` | HouseOwnerCharacterInfo[] | no |  |
| `ownerListIndex` | number | no |  |

### PLAYER_HOUSE_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfos` | HouseInfo[] | no |  |

### RECEIVED_HOUSE_LEVEL_REWARDS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |
| `rewards` | HouseLevelReward[] | no |  |

### REMOVE_NEIGHBORHOOD_CHARTER_SIGNATURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `signature` | cstring | no |  |

### SHOW_NEIGHBORHOOD_OWNERSHIP_TRANSFER_DIALOG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodName` | cstring | no |  |
| `cosmeticOwnerName` | cstring | no |  |

### TRACKED_HOUSE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedHouse` | WOWGUID | yes |  |

### VIEW_HOUSES_LIST_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseInfos` | HouseInfo[] | no |  |

## Types

### CreateNeighborhoodErrorType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | CreateNeighborhoodErrorType | no |  |
| `Profanity` | CreateNeighborhoodErrorType | no |  |
| `UndersizedGuild` | CreateNeighborhoodErrorType | no |  |
| `OversizedGuild` | CreateNeighborhoodErrorType | no |  |

### HousingItemToastType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Room` | HousingItemToastType | no |  |
| `Fixture` | HousingItemToastType | no |  |
| `Customization` | HousingItemToastType | no |  |
| `Decor` | HousingItemToastType | no |  |
| `HouseType` | HousingItemToastType | no |  |

