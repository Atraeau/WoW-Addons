# C_AuraContainerUtil

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **0** events · **15** types

## Functions

### C_AuraContainerUtil.ProcessAuraTooltipBackdropOptions

```lua
result = C_AuraContainerUtil.ProcessAuraTooltipBackdropOptions(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | AuraContainerTooltipBackdropOptions | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | AuraContainerTooltipBackdropOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessAuraTooltipBackdropOptions(options)
```

### C_AuraContainerUtil.ProcessAuraTooltipNineSliceOptions

```lua
result = C_AuraContainerUtil.ProcessAuraTooltipNineSliceOptions(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | AuraContainerTooltipNineSliceOptions | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | AuraContainerTooltipNineSliceOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessAuraTooltipNineSliceOptions(options)
```

### C_AuraContainerUtil.ProcessAuraTooltipTextureSliceOptions

```lua
result = C_AuraContainerUtil.ProcessAuraTooltipTextureSliceOptions(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | AuraContainerTooltipTextureSliceOptions | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | AuraContainerTooltipTextureSliceOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessAuraTooltipTextureSliceOptions(options)
```

### C_AuraContainerUtil.ProcessCustomAuraButtonApplicationBarOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonApplicationBarOptions(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonApplicationBarOptions | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonApplicationBarOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonApplicationBarOptions(options)
```

### C_AuraContainerUtil.ProcessCustomAuraButtonApplicationCountOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonApplicationCountOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonApplicationCountOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonApplicationCountOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonApplicationCountOptions()
```

### C_AuraContainerUtil.ProcessCustomAuraButtonCasterNameOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonCasterNameOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonCasterNameOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonCasterNameOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonCasterNameOptions()
```

### C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonDispelTypeTextOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonDispelTypeTextOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextOptions()
```

### C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextureOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextureOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonDispelTypeTextureOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonDispelTypeTextureOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonDispelTypeTextureOptions()
```

### C_AuraContainerUtil.ProcessCustomAuraButtonDurationBarOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonDurationBarOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonDurationBarOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonDurationBarOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonDurationBarOptions()
```

### C_AuraContainerUtil.ProcessCustomAuraButtonDurationTextOptions

```lua
result = C_AuraContainerUtil.ProcessCustomAuraButtonDurationTextOptions([options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CustomAuraButtonDurationTextOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CustomAuraButtonDurationTextOptions | no |  |

**Example**

```lua
local result = C_AuraContainerUtil.ProcessCustomAuraButtonDurationTextOptions()
```

## Types

### AuraContainerTooltipAnchorOffsets (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no | (default: 0) |
| `right` | number | no | (default: 0) |
| `top` | number | no | (default: 0) |
| `bottom` | number | no | (default: 0) |

### AuraContainerTooltipBackdropInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bgFile` | TextureAssetDisk | yes | Optional background texture asset. |
| `edgeFile` | TextureAssetDisk | yes | Optional edge texture asset. |
| `edgeSize` | number | yes | Optional edge size. |
| `insets` | AuraContainerTooltipBackdropInsets | yes | Optional backdrop insets. |
| `tile` | bool | yes | If true, tiles the background texture. |
| `tileEdge` | bool | yes | If true, tiles the edge texture. |
| `tileSize` | number | yes | Optional tile size used when tiling the background texture. |

### AuraContainerTooltipBackdropInsets (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no | (default: 0) |
| `right` | number | no | (default: 0) |
| `top` | number | no | (default: 0) |
| `bottom` | number | no | (default: 0) |

### AuraContainerTooltipBackdropOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `backdropInfo` | AuraContainerTooltipBackdropInfo | no | Backdrop information used to construct the tooltip backdrop. |
| `borderColor` | colorRGBA | yes | Optional color applied to the backdrop border. |
| `centerColor` | colorRGBA | yes | Optional color applied to the backdrop background. |
| `anchorOffsets` | AuraContainerTooltipAnchorOffsets | yes | Optional offsets applied to the backdrop's TOPLEFT and BOTTOMRIGHT anchor points. |

### AuraContainerTooltipNineSliceOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutName` | cstring | no | Name of the NineSlice layout template to apply, such as 'TooltipDefaultLayout'. |
| `borderColor` | colorRGBA | yes | Optional color applied to the NineSlice border. |
| `centerColor` | colorRGBA | yes | Optional color applied to the NineSlice center region. |
| `anchorOffsets` | AuraContainerTooltipAnchorOffsets | yes | Optional offsets applied to the NineSlice's TOPLEFT and BOTTOMRIGHT anchor points. |

### AuraContainerTooltipTextureSliceOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAssetDisk | no | Texture asset (file path or atlas name) displayed by the slice. |
| `sliceMargins` | UITextureSliceMargins | yes | Optional texture slice margins. See Texture:SetTextureSliceMargins. |
| `sliceMode` | UITextureSliceMode | yes | Optional texture slice mode. See Texture:SetTextureSliceMode. |
| `color` | colorRGBA | yes | Optional vertex color applied to the texture. |
| `anchorOffsets` | AuraContainerTooltipAnchorOffsets | yes | Optional offsets applied to the slice's TOPLEFT and BOTTOMRIGHT anchor points. |
| `drawLayer` | DrawLayer | yes | Draw layer used when displaying the texture. |
| `drawLayerSublevel` | number | no | Draw layer sublevel used when displaying the texture. (default: 0) |

### CustomAuraButtonApplicationBarOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxApplications` | number | no | The maximum number of aura applications represented by the bar. |
| `minApplications` | number | no | The minimum number of aura applications represented by the bar. (default: 0) |
| `interpolation` | StatusBarInterpolation | yes | Optional interpolation method used when updating the bar value. |

### CustomAuraButtonApplicationCountOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | yes | Optional formatter used to display aura application counts. |

### CustomAuraButtonCasterNameOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showRealmName` | bool | no | If true, append realm names to the displayed string. (default: False) |
| `useClassColors` | bool | no | If true, apply class coloring to the text. (default: False) |

### CustomAuraButtonDispelTypeTextOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showWhenHarmful` | bool | no | Shows the dispel type text for harmful auras. (default: True) |
| `showWhenHelpful` | bool | no | Shows the dispel type text for helpful auras. (default: False) |
| `showWithoutDispelType` | bool | no | Shows the dispel type text for auras that do not have a dispel type. (default: False) |
| `customDispelTextMap` | stringView[] | yes | Optional map of dispel type names to custom texts. An empty key can be used for auras without a dispel type. |

### CustomAuraButtonDispelTypeTextureAsset (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAssetDisk | no | The texture file or atlas to use. |
| `useAtlasSize` | bool | no | Resizes the texture to the atlas dimensions. Ignored when asset does not name an atlas. (default: False) |
| `texCoords` | CustomAuraButtonDispelTypeTextureTexCoords | yes | Optional texture coordinates used when asset does not name an atlas. |

### CustomAuraButtonDispelTypeTextureOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showAlways` | bool | no | Shows the dispel type texture always, ignoring all other criteria. (default: False) |
| `showWhenHarmful` | bool | no | Shows the dispel type texture for harmful auras. (default: True) |
| `showWhenHelpful` | bool | no | Shows the dispel type texture for helpful auras. (default: False) |
| `showWithoutDispelType` | bool | no | Shows the dispel type texture for auras that do not have a dispel type. (default: False) |
| `stealableFilter` | CustomAuraButtonDispelTypeStealableFilter | yes | Restricts display of the dispel type texture to either stealable or non-stealable auras. If omitted, the dispel type texture may be shown for both. |
| `style` | CustomAuraButtonDispelTypeTextureStyle | no | The texture style to use. (default: BorderWithIcon) |
| `customDispelAssetMap` | CustomAuraButtonDispelTypeTextureAsset[] | yes | Optional map of dispel type names to custom texture assets. The "None" key represents auras without a dispel type. Only applies when using the CustomAsset style. |
| `customDispelColorMap` | colorRGB[] | yes | Optional map of dispel type names to custom vertex colors. The "None" key represents auras without a dispel type. |
| `customDispelColorCurve` | LuaColorCurveObject | yes | Optional curve used to determine vertex colors from the aura's dispel type. |

### CustomAuraButtonDispelTypeTextureTexCoords (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no | (default: 0) |
| `right` | number | no | (default: 1) |
| `top` | number | no | (default: 0) |
| `bottom` | number | no | (default: 1) |

### CustomAuraButtonDurationBarOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interpolation` | StatusBarInterpolation | yes | The interpolation method used when updating the duration bar. |
| `direction` | StatusBarTimerDirection | yes | The direction in which the duration bar progresses. |

### CustomAuraButtonDurationTextOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `binding` | DurationTextBinding | yes | Optional duration text binding to use. The binding is copied before being associated with the aura button. |
| `textFormatter` | NumericFormatter | yes | Optional formatter used to display remaining duration values. Ignored if textFormat is specified. |
| `textFormat` | DurationTextBindingFormatOptions | yes | Optional text format configuration applied to the duration text binding. Overrides textFormatter when specified. |
| `textColor` | DurationTextBindingColorOptions | yes | Optional text color configuration applied to the duration text binding. |

