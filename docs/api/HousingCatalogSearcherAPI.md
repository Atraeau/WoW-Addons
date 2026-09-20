# HousingCatalogSearcherAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**46** functions · **0** events · **1** types

## Functions

### HousingCatalogSearcherAPI.GetAllSearchItems

Returns all catalog entries being searched (note these are NOT search results, this is the source collection of what's being searched)

```lua
matchingEntryVariantIDs = GetAllSearchItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchingEntryVariantIDs` | HousingCatalogEntryVariantID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matchingEntryVariantIDs = GetAllSearchItems()
```

### HousingCatalogSearcherAPI.GetCatalogSearchResults

Returns the most recent search result entries

```lua
matchingEntryVariantIDs = GetCatalogSearchResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchingEntryVariantIDs` | HousingCatalogEntryVariantID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matchingEntryVariantIDs = GetCatalogSearchResults()
```

### HousingCatalogSearcherAPI.GetEditorModeContext

```lua
editorModeContext = GetEditorModeContext()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editorModeContext` | HouseEditorMode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local editorModeContext = GetEditorModeContext()
```

### HousingCatalogSearcherAPI.GetFilteredCategoryID

```lua
categoryID = GetFilteredCategoryID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categoryID = GetFilteredCategoryID()
```

### HousingCatalogSearcherAPI.GetFilteredSubcategoryID

```lua
subcategoryID = GetFilteredSubcategoryID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local subcategoryID = GetFilteredSubcategoryID()
```

### HousingCatalogSearcherAPI.GetFilterTagStatus

```lua
active = GetFilterTagStatus(groupID, tagID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `tagID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = GetFilterTagStatus(0, 0)
```

### HousingCatalogSearcherAPI.GetNumSearchItems

Returns the total number of entries being searched through

```lua
numSearchItems = GetNumSearchItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSearchItems` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSearchItems = GetNumSearchItems()
```

### HousingCatalogSearcherAPI.GetSearchCount

Returns the total number of owned instances across all most recent search result entries

```lua
searchCount = GetSearchCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local searchCount = GetSearchCount()
```

### HousingCatalogSearcherAPI.GetSearchText

```lua
searchText = GetSearchText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchText` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local searchText = GetSearchText()
```

### HousingCatalogSearcherAPI.GetSortType

```lua
sortType = GetSortType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortType` | HousingCatalogSortType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sortType = GetSortType()
```

### HousingCatalogSearcherAPI.IsAllowedIndoorsActive

```lua
isActive = IsAllowedIndoorsActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsAllowedIndoorsActive()
```

### HousingCatalogSearcherAPI.IsAllowedOutdoorsActive

```lua
isActive = IsAllowedOutdoorsActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsAllowedOutdoorsActive()
```

### HousingCatalogSearcherAPI.IsBaseVariantOnlyActive

```lua
isActive = IsBaseVariantOnlyActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsBaseVariantOnlyActive()
```

### HousingCatalogSearcherAPI.IsCollectedActive

```lua
isActive = IsCollectedActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsCollectedActive()
```

### HousingCatalogSearcherAPI.IsCustomizableOnlyActive

```lua
isActive = IsCustomizableOnlyActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsCustomizableOnlyActive()
```

### HousingCatalogSearcherAPI.IsFirstAcquisitionBonusOnlyActive

```lua
isActive = IsFirstAcquisitionBonusOnlyActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsFirstAcquisitionBonusOnlyActive()
```

### HousingCatalogSearcherAPI.IsSearchInProgress

```lua
isSearchInProgress = IsSearchInProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSearchInProgress` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSearchInProgress = IsSearchInProgress()
```

### HousingCatalogSearcherAPI.IsStoredOnlyActive

```lua
isActive = IsStoredOnlyActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsStoredOnlyActive()
```

### HousingCatalogSearcherAPI.IsUncollectedActive

```lua
isActive = IsUncollectedActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = IsUncollectedActive()
```

### HousingCatalogSearcherAPI.RunSearch

Run search with all current param values

```lua
RunSearch()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RunSearch()
```

### HousingCatalogSearcherAPI.SetAllInFilterTagGroup

Set the toggle state of all filter tags within a specific group; If active, only entries that match Any of the tags in the group will be included in search results

```lua
SetAllInFilterTagGroup(groupID, active)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAllInFilterTagGroup(0, false)
```

### HousingCatalogSearcherAPI.SetAllowedIndoors

Search parameter; If true, entries that can be placed in house interiors will be included in the search; Note many decor objects can be placed both indoors and outdoors, so having only this toggled on may still include decor that can also be placed outdoors

```lua
SetAllowedIndoors(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAllowedIndoors(false)
```

### HousingCatalogSearcherAPI.SetAllowedOutdoors

Search parameter; If true, entries that can be placed outside in plots will be included in the search; Note many decor objects can be placed both indoors and outdoors, so having only this toggled on may still include decor that can also be placed indoors

```lua
SetAllowedOutdoors(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAllowedOutdoors(false)
```

### HousingCatalogSearcherAPI.SetAutoUpdateOnParamChanges

If true, searcher automatically updates results whenever search param values are changed

```lua
SetAutoUpdateOnParamChanges(autoUpdateActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoUpdateActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAutoUpdateOnParamChanges(false)
```

### HousingCatalogSearcherAPI.SetBaseVariantOnly

Search parameter; If true, only the base variant of each decor entry will be included

```lua
SetBaseVariantOnly(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBaseVariantOnly(false)
```

### HousingCatalogSearcherAPI.SetCollected

Search parameter; If true, includes all owned entries, including those that are in storage OR placed in an owned house or plot; See IsStoredOnlyActive for a more exclusive toggle

```lua
SetCollected(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCollected(false)
```

### HousingCatalogSearcherAPI.SetCustomizableOnly

Search parameter; If true, catalog entries that cannot be customized (ie dyed) will be excluded from the search

```lua
SetCustomizableOnly(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCustomizableOnly(false)
```

### HousingCatalogSearcherAPI.SetEditorModeContext

Search parameter; If set, limits search results to only entries that are used/valid in the specified editor mode

```lua
SetEditorModeContext([editorModeContext])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editorModeContext` | HouseEditorMode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEditorModeContext()
```

### HousingCatalogSearcherAPI.SetFilteredCategoryID

Search parameter; If set, limits search results to only those within the specified category

```lua
SetFilteredCategoryID([categoryID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFilteredCategoryID()
```

### HousingCatalogSearcherAPI.SetFilteredSubcategoryID

Search parameter; If set, limits search results to only those within the specified subcategory

```lua
SetFilteredSubcategoryID([subcategoryID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subcategoryID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFilteredSubcategoryID()
```

### HousingCatalogSearcherAPI.SetFilterTagStatus

Set the toggle state of a single filter tag within a specific group

```lua
SetFilterTagStatus(groupID, tagID, active)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `tagID` | number | no |  |
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFilterTagStatus(0, 0, false)
```

### HousingCatalogSearcherAPI.SetFirstAcquisitionBonusOnly

Search parameter; If true, excludes any entries that do not reward house xp when acquired for the first time

```lua
SetFirstAcquisitionBonusOnly(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFirstAcquisitionBonusOnly(false)
```

### HousingCatalogSearcherAPI.SetResultsUpdatedCallback

```lua
SetResultsUpdatedCallback(callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `callback` | HousingCatalogSearchResultsUpdatedCallback | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetResultsUpdatedCallback(callback)
```

### HousingCatalogSearcherAPI.SetSearchText

Search parameter; If set, multiple text fields are checked for instances of the text, including name, category, subcategory, and data tags

```lua
SetSearchText([searchText])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchText` | string | yes | Supports advanced search tokens ('"' '-' and '\|'), case and accent insensitive; Set nil to clear out the search text |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSearchText()
```

### HousingCatalogSearcherAPI.SetSortType

```lua
SetSortType(sortType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortType` | HousingCatalogSortType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSortType(sortType)
```

### HousingCatalogSearcherAPI.SetStoredOnly

Search parameter; If true, only entries that you have instances of available in storage will be included; This does not include entries that you own but have all been placed in a house; See IsCollectedActive for param that includes placed entries

```lua
SetStoredOnly(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStoredOnly(false)
```

### HousingCatalogSearcherAPI.SetUncollected

Search parameter; If true, includes entries that are not owned, meaning not available in storage nor placed in any owned houses or plots

```lua
SetUncollected(isActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUncollected(false)
```

### HousingCatalogSearcherAPI.ToggleAllowedIndoors

```lua
ToggleAllowedIndoors()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleAllowedIndoors()
```

### HousingCatalogSearcherAPI.ToggleAllowedOutdoors

```lua
ToggleAllowedOutdoors()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleAllowedOutdoors()
```

### HousingCatalogSearcherAPI.ToggleBaseVariantOnly

```lua
ToggleBaseVariantOnly()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleBaseVariantOnly()
```

### HousingCatalogSearcherAPI.ToggleCollected

```lua
ToggleCollected()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleCollected()
```

### HousingCatalogSearcherAPI.ToggleCustomizableOnly

```lua
ToggleCustomizableOnly()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleCustomizableOnly()
```

### HousingCatalogSearcherAPI.ToggleFilterTag

```lua
ToggleFilterTag(groupID, tagID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |
| `tagID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleFilterTag(0, 0)
```

### HousingCatalogSearcherAPI.ToggleFirstAcquisitionBonusOnly

```lua
ToggleFirstAcquisitionBonusOnly()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleFirstAcquisitionBonusOnly()
```

### HousingCatalogSearcherAPI.ToggleStoredOnly

```lua
ToggleStoredOnly()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleStoredOnly()
```

### HousingCatalogSearcherAPI.ToggleUncollected

```lua
ToggleUncollected()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ToggleUncollected()
```

## Types

### HousingCatalogSearchResultsUpdatedCallback (CallbackType)

