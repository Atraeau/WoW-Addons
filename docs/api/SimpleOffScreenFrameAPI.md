# SimpleOffScreenFrameAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **0** events · **0** types

## Functions

### SimpleOffScreenFrameAPI.ApplySnapshot

```lua
success = ApplySnapshot(texture, snapshotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `snapshotID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = ApplySnapshot(texture, 0)
```

### SimpleOffScreenFrameAPI.Flush

```lua
Flush()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Flush()
```

### SimpleOffScreenFrameAPI.GetMaxSnapshots

```lua
maxSnapshots = GetMaxSnapshots()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxSnapshots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxSnapshots = GetMaxSnapshots()
```

### SimpleOffScreenFrameAPI.IsSnapshotValid

```lua
isValid = IsSnapshotValid(snapshotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `snapshotID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = IsSnapshotValid(0)
```

### SimpleOffScreenFrameAPI.SetMaxSnapshots

```lua
SetMaxSnapshots(maxSnapshots)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxSnapshots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMaxSnapshots(0)
```

### SimpleOffScreenFrameAPI.TakeSnapshot

```lua
snapshotID = TakeSnapshot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `snapshotID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local snapshotID = TakeSnapshot()
```

### SimpleOffScreenFrameAPI.TestPrintToFile

Unavailable in public builds

```lua
success = TestPrintToFile(snapshotID, filename)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `snapshotID` | number | no |  |
| `filename` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = TestPrintToFile(0, "")
```

### SimpleOffScreenFrameAPI.UsesNPOT

```lua
usesNPOT = UsesNPOT()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usesNPOT` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local usesNPOT = UsesNPOT()
```

