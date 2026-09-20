# C_WorldStateInfo

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**0** functions · **6** events · **0** types

## Events

### CANCEL_PLAYER_COUNTDOWN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiatedBy` | WOWGUID | no |  |
| `informChat` | bool | no |  |
| `initiatedByName` | string | yes |  |

### START_PLAYER_COUNTDOWN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiatedBy` | WOWGUID | no |  |
| `timeRemaining` | time_t | no |  |
| `totalTime` | time_t | no |  |
| `informChat` | bool | no |  |
| `initiatedByName` | string | yes |  |

### START_TIMER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerType` | StartTimerType | no |  |
| `timeRemaining` | time_t | no |  |
| `totalTime` | time_t | no |  |

### STOP_TIMER_OF_TYPE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerType` | StartTimerType | no |  |

### WORLD_STATE_TIMER_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerID` | number | no |  |

### WORLD_STATE_TIMER_STOP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerID` | number | no |  |

