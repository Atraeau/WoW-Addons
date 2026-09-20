# C_PhotoSharing

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **5** events · **0** types

## Functions

### C_PhotoSharing.BeginAuthorizationFlow

```lua
C_PhotoSharing.BeginAuthorizationFlow()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.BeginAuthorizationFlow()
```

### C_PhotoSharing.ClearAuthorization

```lua
C_PhotoSharing.ClearAuthorization()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.ClearAuthorization()
```

### C_PhotoSharing.CompleteAuthorizationFlow

```lua
C_PhotoSharing.CompleteAuthorizationFlow(callbackURL)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `callbackURL` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.CompleteAuthorizationFlow("")
```

### C_PhotoSharing.GetCropRatio

```lua
cropRatio = C_PhotoSharing.GetCropRatio()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cropRatio` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cropRatio = C_PhotoSharing.GetCropRatio()
```

### C_PhotoSharing.GetPhotoSharingAuthURL

```lua
authUrl = C_PhotoSharing.GetPhotoSharingAuthURL()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `authUrl` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local authUrl = C_PhotoSharing.GetPhotoSharingAuthURL()
```

### C_PhotoSharing.GetStatus

```lua
status = C_PhotoSharing.GetStatus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | PhotoSharingStatus | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_PhotoSharing.GetStatus()
```

### C_PhotoSharing.IsAuthorized

```lua
authorized = C_PhotoSharing.IsAuthorized()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `authorized` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local authorized = C_PhotoSharing.IsAuthorized()
```

### C_PhotoSharing.IsEnabled

```lua
enabled = C_PhotoSharing.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_PhotoSharing.IsEnabled()
```

### C_PhotoSharing.SetScreenshotPreviewTexture

```lua
C_PhotoSharing.SetScreenshotPreviewTexture(textureObject)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.SetScreenshotPreviewTexture(textureObject)
```

### C_PhotoSharing.TakePhoto

```lua
C_PhotoSharing.TakePhoto()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.TakePhoto()
```

### C_PhotoSharing.UploadPhotoToService

```lua
C_PhotoSharing.UploadPhotoToService(optionalTitle, optionalDescription)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionalTitle` | cstring | no |  |
| `optionalDescription` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PhotoSharing.UploadPhotoToService("", "")
```

## Events

### PHOTO_SHARING_AUTHORIZATION_NEEDED

### PHOTO_SHARING_AUTHORIZATION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showNotification` | bool | no |  |

### PHOTO_SHARING_PHOTO_UPLOAD_STATUS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uploadStatus` | PhotoSharingUploadStatus | no |  |

### PHOTO_SHARING_SCREENSHOT_READY

### PHOTO_SHARING_THIRD_PARTY_AUTHORIZATION_NEEDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `authUrl` | string | no |  |

