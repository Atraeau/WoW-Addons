# C_WowEntitlementInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**0** functions · **2** events · **1** types

## Events

### ENTITLEMENT_DELIVERED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entitlementType` | WoWEntitlementType | no |  |
| `textureID` | number | no |  |
| `name` | string | no |  |
| `payloadID` | number | yes |  |
| `showFancyToast` | bool | no |  |

### RAF_ENTITLEMENT_DELIVERED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entitlementType` | WoWEntitlementType | no |  |
| `textureID` | number | no |  |
| `name` | string | no |  |
| `payloadID` | number | yes |  |
| `showFancyToast` | bool | no |  |
| `rafVersion` | RecruitAFriendRewardsVersion | no |  |

## Types

### WoWEntitlementType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Item` | WoWEntitlementType | no |  |
| `Mount` | WoWEntitlementType | no |  |
| `Battlepet` | WoWEntitlementType | no |  |
| `Toy` | WoWEntitlementType | no |  |
| `Appearance` | WoWEntitlementType | no |  |
| `AppearanceSet` | WoWEntitlementType | no |  |
| `GameTime` | WoWEntitlementType | no |  |
| `Title` | WoWEntitlementType | no |  |
| `Illusion` | WoWEntitlementType | no |  |
| `Invalid` | WoWEntitlementType | no |  |

