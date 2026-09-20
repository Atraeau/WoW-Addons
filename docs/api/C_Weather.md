# C_Weather

Cloudy, with a chance of documentation.

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **1** events · **1** types

## Functions

### C_Weather.GetCurrentWeather

C_Weather the outlook is favorable.

```lua
info = C_Weather.GetCurrentWeather()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | WeatherInfo | no |  |

**Example**

```lua
local info = C_Weather.GetCurrentWeather()
```

## Events

### WEATHER_CHANGED

The weather has taken a turn.

## Types

### WeatherInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | WeatherType | no | (default: Clear) |
| `intensity` | number | no |  |

