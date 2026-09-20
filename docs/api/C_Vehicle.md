# C_Vehicle

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**0** functions · **10** events · **0** types

## Events

### PLAYER_GAINS_VEHICLE_DATA

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `vehicleUIIndicatorID` | number | no |  |

### PLAYER_LOSES_VEHICLE_DATA

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_ENTERED_VEHICLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `showVehicleFrame` | bool | no |  |
| `isControlSeat` | bool | no |  |
| `vehicleUIIndicatorID` | number | no |  |
| `vehicleGUID` | WOWGUID | no |  |
| `mayChooseExit` | bool | no |  |
| `hasPitch` | bool | no |  |

### UNIT_ENTERING_VEHICLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `showVehicleFrame` | bool | no |  |
| `isControlSeat` | bool | no |  |
| `vehicleUIIndicatorID` | number | no |  |
| `vehicleGUID` | WOWGUID | no |  |
| `mayChooseExit` | bool | no |  |
| `hasPitch` | bool | no |  |

### UNIT_EXITED_VEHICLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_EXITING_VEHICLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### VEHICLE_ANGLE_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | number | yes |  |

### VEHICLE_PASSENGERS_CHANGED

### VEHICLE_POWER_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | number | yes |  |

### VEHICLE_UPDATE

