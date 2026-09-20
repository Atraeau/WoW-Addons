# C_AnimaDiversion

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **3** events · **4** types

## Functions

### C_AnimaDiversion.CloseUI

```lua
C_AnimaDiversion.CloseUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AnimaDiversion.CloseUI()
```

### C_AnimaDiversion.GetAnimaDiversionNodes

```lua
animaNodes = C_AnimaDiversion.GetAnimaDiversionNodes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animaNodes` | AnimaDiversionNodeInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local animaNodes = C_AnimaDiversion.GetAnimaDiversionNodes()
```

### C_AnimaDiversion.GetOriginPosition

```lua
normalizedPosition = C_AnimaDiversion.GetOriginPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `normalizedPosition` | vector2 | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local normalizedPosition = C_AnimaDiversion.GetOriginPosition()
```

### C_AnimaDiversion.GetReinforceProgress

```lua
progress = C_AnimaDiversion.GetReinforceProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local progress = C_AnimaDiversion.GetReinforceProgress()
```

### C_AnimaDiversion.GetTextureKit

```lua
textureKit = C_AnimaDiversion.GetTextureKit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureKit = C_AnimaDiversion.GetTextureKit()
```

### C_AnimaDiversion.OpenAnimaDiversionUI

```lua
C_AnimaDiversion.OpenAnimaDiversionUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AnimaDiversion.OpenAnimaDiversionUI()
```

### C_AnimaDiversion.SelectAnimaNode

```lua
C_AnimaDiversion.SelectAnimaNode(talentID, temporary)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `temporary` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AnimaDiversion.SelectAnimaNode(0, false)
```

## Events

### ANIMA_DIVERSION_CLOSE

### ANIMA_DIVERSION_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AnimaDiversionFrameInfo | no |  |

### ANIMA_DIVERSION_TALENT_UPDATED

## Types

### AnimaDiversionCostInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `quantity` | number | no |  |

### AnimaDiversionFrameInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `title` | string | no |  |
| `mapID` | number | no |  |

### AnimaDiversionNodeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `name` | string | no |  |
| `description` | string | no |  |
| `costs` | AnimaDiversionCostInfo[] | no |  |
| `currencyID` | number | no |  |
| `icon` | number | no |  |
| `normalizedPosition` | vector2 | no |  |
| `state` | AnimaDiversionNodeState | no |  |

### AnimaDiversionNodeState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Unavailable` | AnimaDiversionNodeState | no |  |
| `Available` | AnimaDiversionNodeState | no |  |
| `SelectedTemporary` | AnimaDiversionNodeState | no |  |
| `SelectedPermanent` | AnimaDiversionNodeState | no |  |
| `Cooldown` | AnimaDiversionNodeState | no |  |

