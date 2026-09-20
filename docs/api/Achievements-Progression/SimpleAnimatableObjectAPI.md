# SimpleAnimatableObjectAPI

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**3** functions · **0** events · **0** types

## Functions

### SimpleAnimatableObjectAPI.CreateAnimationGroup

```lua
group = CreateAnimationGroup([name], [templateName])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `templateName` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `group` | SimpleAnimGroup | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local group = CreateAnimationGroup()
```

### SimpleAnimatableObjectAPI.GetAnimationGroups

```lua
groups = GetAnimationGroups()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groups` | SimpleAnimGroup | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groups = GetAnimationGroups()
```

### SimpleAnimatableObjectAPI.StopAnimating

```lua
StopAnimating()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopAnimating()
```

