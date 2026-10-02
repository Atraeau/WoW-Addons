# C_Weather

[← API index](../README.md) · group: [Map, Instances & World](README.md)

Cloudy, with a chance of documentation.

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

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

**Example** _(auto-generated from the signature — illustrative)_

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
