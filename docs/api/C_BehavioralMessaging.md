# C_BehavioralMessaging

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **1** events · **0** types

## Functions

### C_BehavioralMessaging.SendNotificationReceipt

```lua
C_BehavioralMessaging.SendNotificationReceipt(dbId, openTimeSeconds, readTimeSeconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dbId` | NotificationDbId | no |  |
| `openTimeSeconds` | number | no |  |
| `readTimeSeconds` | number | no |  |

**Example**

```lua
C_BehavioralMessaging.SendNotificationReceipt(dbId, 0, 0)
```

## Events

### BEHAVIORAL_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `notificationType` | string | no |  |
| `dbId` | NotificationDbId | no |  |

