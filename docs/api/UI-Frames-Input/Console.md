# Console

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **7** events · **4** types

## Functions

### Console.CalculateStringEditDistance

```lua
distance = CalculateStringEditDistance(firstString, secondString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `firstString` | stringView | no |  |
| `secondString` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local distance = CalculateStringEditDistance(firstString, secondString)
```

### Console.ConsoleEcho

```lua
result = ConsoleEcho(command, addToHistory, [prefix])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `command` | cstring | no |  |
| `addToHistory` | bool | no | (default: False) |
| `prefix` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ConsoleEcho("", false)
```

### Console.ConsoleExec

```lua
result = ConsoleExec(command, addToHistory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `command` | cstring | no |  |
| `addToHistory` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ConsoleExec("", false)
```

### Console.ConsoleGetAllCommands

```lua
commands = ConsoleGetAllCommands()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `commands` | ConsoleCommandInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local commands = ConsoleGetAllCommands()
```

### Console.ConsoleGetColorFromType

```lua
color = ConsoleGetColorFromType(colorType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorType` | ConsoleColorType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local color = ConsoleGetColorFromType(Enum.ConsoleColorType.DefaultColor)
```

### Console.ConsoleGetFontHeight

```lua
fontHeightInPixels = ConsoleGetFontHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontHeightInPixels` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fontHeightInPixels = ConsoleGetFontHeight()
```

### Console.ConsoleIsActive

```lua
consoleIsActive = ConsoleIsActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `consoleIsActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local consoleIsActive = ConsoleIsActive()
```

### Console.ConsolePrintAllMatchingCommands

```lua
ConsolePrintAllMatchingCommands(partialCommandText)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `partialCommandText` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ConsolePrintAllMatchingCommands("")
```

### Console.ConsoleSetFontHeight

```lua
ConsoleSetFontHeight(fontHeightInPixels)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontHeightInPixels` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ConsoleSetFontHeight(0)
```

### Console.SetConsoleKey

```lua
SetConsoleKey(keystring)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keystring` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetConsoleKey("")
```

## Events

### CONSOLE_CLEAR

### CONSOLE_COLORS_CHANGED

### CONSOLE_FONT_SIZE_CHANGED

### CONSOLE_LOG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | cstring | no |  |

### CONSOLE_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | cstring | no |  |
| `colorType` | number | no |  |

### CVAR_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `value` | cstring | no |  |

### TOGGLE_CONSOLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showConsole` | bool | yes |  |

## Types

### ConsoleCategory (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Debug` | ConsoleCategory | no |  |
| `Graphics` | ConsoleCategory | no |  |
| `Console` | ConsoleCategory | no |  |
| `Combat` | ConsoleCategory | no |  |
| `Game` | ConsoleCategory | no |  |
| `Default` | ConsoleCategory | no |  |
| `Net` | ConsoleCategory | no |  |
| `Sound` | ConsoleCategory | no |  |
| `Gm` | ConsoleCategory | no |  |
| `Reveal` | ConsoleCategory | no |  |
| `None` | ConsoleCategory | no |  |

### ConsoleColorType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `DefaultColor` | ConsoleColorType | no |  |
| `InputColor` | ConsoleColorType | no |  |
| `EchoColor` | ConsoleColorType | no |  |
| `ErrorColor` | ConsoleColorType | no |  |
| `WarningColor` | ConsoleColorType | no |  |
| `GlobalColor` | ConsoleColorType | no |  |
| `AdminColor` | ConsoleColorType | no |  |
| `HighlightColor` | ConsoleColorType | no |  |
| `BackgroundColor` | ConsoleColorType | no |  |
| `ClickbufferColor` | ConsoleColorType | no |  |
| `PrivateColor` | ConsoleColorType | no |  |
| `DefaultGreen` | ConsoleColorType | no |  |

### ConsoleCommandInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `command` | cstring | no |  |
| `help` | cstring | no |  |
| `category` | ConsoleCategory | no |  |
| `commandType` | ConsoleCommandType | no |  |
| `scriptContents` | cstring | no |  |
| `scriptParameters` | cstring | no |  |

### ConsoleCommandType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Cvar` | ConsoleCommandType | no |  |
| `Command` | ConsoleCommandType | no |  |
| `Macro` | ConsoleCommandType | no |  |
| `Script` | ConsoleCommandType | no |  |

