# C_GMTicketInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**0** functions · **8** events · **0** types

## Events

### GM_PLAYER_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `info` | cstring | no |  |

### ITEM_RESTORATION_BUTTON_STATUS

### PETITION_CLOSED

### PETITION_SHOW

### PLAYER_REPORT_SUBMITTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitedByGUID` | WOWGUID | no |  |

### QUICK_TICKET_SYSTEM_STATUS

### QUICK_TICKET_THROTTLE_CHANGED

### UPDATE_WEB_TICKET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTicket` | bool | no |  |
| `numTickets` | number | yes |  |
| `ticketStatus` | number | yes |  |
| `caseIndex` | number | yes |  |
| `waitTimeMinutes` | number | yes |  |
| `waitMessage` | cstring | yes |  |
| `caseTitle` | cstring | yes |  |
| `caseDescription` | cstring | yes |  |

