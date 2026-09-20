# C_VoiceChat

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**79** functions · **47** events · **9** types

## Functions

### C_VoiceChat.ActivateChannel

```lua
C_VoiceChat.ActivateChannel(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.ActivateChannel(0)
```

### C_VoiceChat.ActivateChannelTranscription

```lua
C_VoiceChat.ActivateChannelTranscription(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.ActivateChannelTranscription(0)
```

### C_VoiceChat.BeginLocalCapture

```lua
C_VoiceChat.BeginLocalCapture(listenToLocalUser)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listenToLocalUser` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.BeginLocalCapture(false)
```

### C_VoiceChat.CanAccessSettings

```lua
canAccess = C_VoiceChat.CanAccessSettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccess` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccess = C_VoiceChat.CanAccessSettings()
```

### C_VoiceChat.CanPlayerUseVoiceChat

```lua
canUseVoiceChat = C_VoiceChat.CanPlayerUseVoiceChat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseVoiceChat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUseVoiceChat = C_VoiceChat.CanPlayerUseVoiceChat()
```

### C_VoiceChat.CreateChannel

```lua
status = C_VoiceChat.CreateChannel(channelDisplayName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelDisplayName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_VoiceChat.CreateChannel("")
```

### C_VoiceChat.DeactivateChannel

```lua
C_VoiceChat.DeactivateChannel(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.DeactivateChannel(0)
```

### C_VoiceChat.DeactivateChannelTranscription

```lua
C_VoiceChat.DeactivateChannelTranscription(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.DeactivateChannelTranscription(0)
```

### C_VoiceChat.EndLocalCapture

```lua
C_VoiceChat.EndLocalCapture()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.EndLocalCapture()
```

### C_VoiceChat.GetActiveChannelID

```lua
channelID = C_VoiceChat.GetActiveChannelID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local channelID = C_VoiceChat.GetActiveChannelID()
```

### C_VoiceChat.GetActiveChannelType

```lua
channelType = C_VoiceChat.GetActiveChannelType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local channelType = C_VoiceChat.GetActiveChannelType()
```

### C_VoiceChat.GetAvailableInputDevices

```lua
inputDevices = C_VoiceChat.GetAvailableInputDevices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inputDevices` | VoiceAudioDevice[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inputDevices = C_VoiceChat.GetAvailableInputDevices()
```

### C_VoiceChat.GetAvailableOutputDevices

```lua
outputDevices = C_VoiceChat.GetAvailableOutputDevices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outputDevices` | VoiceAudioDevice[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local outputDevices = C_VoiceChat.GetAvailableOutputDevices()
```

### C_VoiceChat.GetChannel

```lua
channel = C_VoiceChat.GetChannel(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channel` | VoiceChatChannel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local channel = C_VoiceChat.GetChannel(0)
```

### C_VoiceChat.GetChannelForChannelType

```lua
channel = C_VoiceChat.GetChannelForChannelType(channelType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channel` | VoiceChatChannel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local channel = C_VoiceChat.GetChannelForChannelType(channelType)
```

### C_VoiceChat.GetChannelForCommunityStream

```lua
channel = C_VoiceChat.GetChannelForCommunityStream(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channel` | VoiceChatChannel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local channel = C_VoiceChat.GetChannelForCommunityStream(clubId, streamId)
```

### C_VoiceChat.GetCommunicationMode

```lua
communicationMode = C_VoiceChat.GetCommunicationMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `communicationMode` | CommunicationMode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local communicationMode = C_VoiceChat.GetCommunicationMode()
```

### C_VoiceChat.GetCurrentVoiceChatConnectionStatusCode

```lua
statusCode = C_VoiceChat.GetCurrentVoiceChatConnectionStatusCode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `statusCode` | VoiceChatStatusCode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local statusCode = C_VoiceChat.GetCurrentVoiceChatConnectionStatusCode()
```

### C_VoiceChat.GetInputVolume

```lua
volume = C_VoiceChat.GetInputVolume()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local volume = C_VoiceChat.GetInputVolume()
```

### C_VoiceChat.GetJoinClubVoiceChannelError

```lua
errorReason = C_VoiceChat.GetJoinClubVoiceChannelError(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorReason` | VoiceChannelErrorReason | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local errorReason = C_VoiceChat.GetJoinClubVoiceChannelError(clubId)
```

### C_VoiceChat.GetLocalPlayerActiveChannelMemberInfo

```lua
memberInfo = C_VoiceChat.GetLocalPlayerActiveChannelMemberInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberInfo` | VoiceChatMember | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberInfo = C_VoiceChat.GetLocalPlayerActiveChannelMemberInfo()
```

### C_VoiceChat.GetLocalPlayerMemberID

```lua
memberID = C_VoiceChat.GetLocalPlayerMemberID(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberID = C_VoiceChat.GetLocalPlayerMemberID(0)
```

### C_VoiceChat.GetMasterVolumeScale

```lua
scale = C_VoiceChat.GetMasterVolumeScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scale = C_VoiceChat.GetMasterVolumeScale()
```

### C_VoiceChat.GetMemberGUID

```lua
memberGUID = C_VoiceChat.GetMemberGUID(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberGUID = C_VoiceChat.GetMemberGUID(0, 0)
```

### C_VoiceChat.GetMemberID

```lua
memberID = C_VoiceChat.GetMemberID(channelID, memberGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `memberGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberID = C_VoiceChat.GetMemberID(0, UnitGUID("player"))
```

### C_VoiceChat.GetMemberInfo

```lua
memberInfo = C_VoiceChat.GetMemberInfo(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberInfo` | VoiceChatMember | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberInfo = C_VoiceChat.GetMemberInfo(0, 0)
```

### C_VoiceChat.GetMemberName

```lua
memberName = C_VoiceChat.GetMemberName(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberName` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local memberName = C_VoiceChat.GetMemberName(0, 0)
```

### C_VoiceChat.GetMemberVolume

```lua
volume = C_VoiceChat.GetMemberVolume(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local volume = C_VoiceChat.GetMemberVolume(playerLocation)
```

### C_VoiceChat.GetOutputVolume

```lua
volume = C_VoiceChat.GetOutputVolume()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local volume = C_VoiceChat.GetOutputVolume()
```

### C_VoiceChat.GetProcesses

```lua
processes = C_VoiceChat.GetProcesses()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `processes` | VoiceChatProcess[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local processes = C_VoiceChat.GetProcesses()
```

### C_VoiceChat.GetPTTButtonPressedState

```lua
isPressed = C_VoiceChat.GetPTTButtonPressedState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPressed` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPressed = C_VoiceChat.GetPTTButtonPressedState()
```

### C_VoiceChat.GetPushToTalkBinding

```lua
keys = C_VoiceChat.GetPushToTalkBinding()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keys` | string[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local keys = C_VoiceChat.GetPushToTalkBinding()
```

### C_VoiceChat.GetRemoteTtsVoices

```lua
ttsVoices = C_VoiceChat.GetRemoteTtsVoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ttsVoices` | VoiceTtsVoiceType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ttsVoices = C_VoiceChat.GetRemoteTtsVoices()
```

### C_VoiceChat.GetTtsVoices

```lua
ttsVoices = C_VoiceChat.GetTtsVoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ttsVoices` | VoiceTtsVoiceType[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ttsVoices = C_VoiceChat.GetTtsVoices()
```

### C_VoiceChat.GetVADSensitivity

```lua
sensitivity = C_VoiceChat.GetVADSensitivity()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sensitivity` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sensitivity = C_VoiceChat.GetVADSensitivity()
```

### C_VoiceChat.IsChannelJoinPending

```lua
isPending = C_VoiceChat.IsChannelJoinPending(channelType, [clubId], [streamId])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | no |  |
| `clubId` | ClubId | yes |  |
| `streamId` | ClubStreamId | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPending` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPending = C_VoiceChat.IsChannelJoinPending(channelType)
```

### C_VoiceChat.IsDeafened

```lua
isDeafened = C_VoiceChat.IsDeafened()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDeafened` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDeafened = C_VoiceChat.IsDeafened()
```

### C_VoiceChat.IsEnabled

```lua
isEnabled = C_VoiceChat.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_VoiceChat.IsEnabled()
```

### C_VoiceChat.IsLoggedIn

```lua
isLoggedIn = C_VoiceChat.IsLoggedIn()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoggedIn` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLoggedIn = C_VoiceChat.IsLoggedIn()
```

### C_VoiceChat.IsMemberLocalPlayer

```lua
isLocalPlayer = C_VoiceChat.IsMemberLocalPlayer(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocalPlayer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLocalPlayer = C_VoiceChat.IsMemberLocalPlayer(0, 0)
```

### C_VoiceChat.IsMemberMuted

```lua
mutedForMe = C_VoiceChat.IsMemberMuted(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mutedForMe` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mutedForMe = C_VoiceChat.IsMemberMuted(playerLocation)
```

### C_VoiceChat.IsMemberMutedForAll

```lua
mutedForAll = C_VoiceChat.IsMemberMutedForAll(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mutedForAll` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mutedForAll = C_VoiceChat.IsMemberMutedForAll(0, 0)
```

### C_VoiceChat.IsMemberSilenced

```lua
silenced = C_VoiceChat.IsMemberSilenced(memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `silenced` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local silenced = C_VoiceChat.IsMemberSilenced(0, 0)
```

### C_VoiceChat.IsMuted

```lua
isMuted = C_VoiceChat.IsMuted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMuted` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMuted = C_VoiceChat.IsMuted()
```

### C_VoiceChat.IsParentalDisabled

```lua
isParentalDisabled = C_VoiceChat.IsParentalDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isParentalDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isParentalDisabled = C_VoiceChat.IsParentalDisabled()
```

### C_VoiceChat.IsParentalMuted

```lua
isParentalMuted = C_VoiceChat.IsParentalMuted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isParentalMuted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isParentalMuted = C_VoiceChat.IsParentalMuted()
```

### C_VoiceChat.IsPlayerUsingVoice

```lua
isUsingVoice = C_VoiceChat.IsPlayerUsingVoice(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingVoice` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsingVoice = C_VoiceChat.IsPlayerUsingVoice(playerLocation)
```

### C_VoiceChat.IsSilenced

```lua
isSilenced = C_VoiceChat.IsSilenced()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSilenced` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSilenced = C_VoiceChat.IsSilenced()
```

### C_VoiceChat.IsSpeakForMeActive

```lua
isActive = C_VoiceChat.IsSpeakForMeActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = C_VoiceChat.IsSpeakForMeActive()
```

### C_VoiceChat.IsSpeakForMeAllowed

```lua
isAllowed = C_VoiceChat.IsSpeakForMeAllowed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAllowed = C_VoiceChat.IsSpeakForMeAllowed()
```

### C_VoiceChat.IsTranscribing

```lua
isTranscribing = C_VoiceChat.IsTranscribing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTranscribing` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTranscribing = C_VoiceChat.IsTranscribing()
```

### C_VoiceChat.IsTranscriptionAllowed

```lua
isAllowed = C_VoiceChat.IsTranscriptionAllowed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAllowed = C_VoiceChat.IsTranscriptionAllowed()
```

### C_VoiceChat.IsVoiceChatConnected

```lua
connected = C_VoiceChat.IsVoiceChatConnected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `connected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local connected = C_VoiceChat.IsVoiceChatConnected()
```

### C_VoiceChat.LeaveChannel

```lua
C_VoiceChat.LeaveChannel(channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.LeaveChannel(0)
```

### C_VoiceChat.Login

```lua
status = C_VoiceChat.Login()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_VoiceChat.Login()
```

### C_VoiceChat.Logout

```lua
status = C_VoiceChat.Logout()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_VoiceChat.Logout()
```

### C_VoiceChat.MarkChannelsDiscovered

Once the UI has enumerated all channels, use this to reset the channel discovery state, it will be updated again if appropriate

```lua
C_VoiceChat.MarkChannelsDiscovered()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.MarkChannelsDiscovered()
```

### C_VoiceChat.RequestJoinAndActivateCommunityStreamChannel

```lua
C_VoiceChat.RequestJoinAndActivateCommunityStreamChannel(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.RequestJoinAndActivateCommunityStreamChannel(clubId, streamId)
```

### C_VoiceChat.RequestJoinChannelByChannelType

```lua
C_VoiceChat.RequestJoinChannelByChannelType(channelType, [autoActivate])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | no |  |
| `autoActivate` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.RequestJoinChannelByChannelType(channelType)
```

### C_VoiceChat.SetCommunicationMode

```lua
C_VoiceChat.SetCommunicationMode(communicationMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `communicationMode` | CommunicationMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetCommunicationMode(Enum.CommunicationMode.PushToTalk)
```

### C_VoiceChat.SetDeafened

```lua
C_VoiceChat.SetDeafened(isDeafened)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDeafened` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetDeafened(false)
```

### C_VoiceChat.SetInputDevice

```lua
C_VoiceChat.SetInputDevice(deviceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetInputDevice("")
```

### C_VoiceChat.SetInputVolume

```lua
C_VoiceChat.SetInputVolume(volume)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetInputVolume(0)
```

### C_VoiceChat.SetMasterVolumeScale

```lua
C_VoiceChat.SetMasterVolumeScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetMasterVolumeScale(0)
```

### C_VoiceChat.SetMemberMuted

```lua
C_VoiceChat.SetMemberMuted(playerLocation, muted)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |
| `muted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetMemberMuted(playerLocation, false)
```

### C_VoiceChat.SetMemberVolume

Adjusts member volume across all channels

```lua
C_VoiceChat.SetMemberVolume(playerLocation, volume)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |
| `volume` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetMemberVolume(playerLocation, 0)
```

### C_VoiceChat.SetMuted

```lua
C_VoiceChat.SetMuted(isMuted)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMuted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetMuted(false)
```

### C_VoiceChat.SetOutputDevice

```lua
C_VoiceChat.SetOutputDevice(deviceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetOutputDevice("")
```

### C_VoiceChat.SetOutputVolume

```lua
C_VoiceChat.SetOutputVolume(volume)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `volume` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetOutputVolume(0)
```

### C_VoiceChat.SetPortraitTexture

```lua
C_VoiceChat.SetPortraitTexture(textureObject, memberID, channelID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |
| `memberID` | number | no |  |
| `channelID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetPortraitTexture(textureObject, 0, 0)
```

### C_VoiceChat.SetPushToTalkBinding

```lua
C_VoiceChat.SetPushToTalkBinding(keys)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keys` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetPushToTalkBinding(keys)
```

### C_VoiceChat.SetVADSensitivity

```lua
C_VoiceChat.SetVADSensitivity(sensitivity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sensitivity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SetVADSensitivity(0)
```

### C_VoiceChat.ShouldDiscoverChannels

Use this while loading to determine if the UI should attempt to rediscover the previously joined/active voice channels

```lua
shouldDiscoverChannels = C_VoiceChat.ShouldDiscoverChannels()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldDiscoverChannels` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldDiscoverChannels = C_VoiceChat.ShouldDiscoverChannels()
```

### C_VoiceChat.SpeakRemoteTextSample

```lua
C_VoiceChat.SpeakRemoteTextSample(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SpeakRemoteTextSample("")
```

### C_VoiceChat.SpeakText

SpeakText also supports XML TTS tags on Windows including bookmarks - see SAPI XML TTS Tutorial in Microsoft's online documentation for more information.

```lua
C_VoiceChat.SpeakText(voiceID, text, rate, volume, overlap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceID` | number | no |  |
| `text` | cstring | no |  |
| `rate` | number | no |  |
| `volume` | number | no |  |
| `overlap` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.SpeakText(0, "", 0, 0, false)
```

### C_VoiceChat.StopSpeakingText

```lua
C_VoiceChat.StopSpeakingText()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.StopSpeakingText()
```

### C_VoiceChat.ToggleDeafened

```lua
C_VoiceChat.ToggleDeafened()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.ToggleDeafened()
```

### C_VoiceChat.ToggleMemberMuted

```lua
C_VoiceChat.ToggleMemberMuted(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.ToggleMemberMuted(playerLocation)
```

### C_VoiceChat.ToggleMuted

```lua
C_VoiceChat.ToggleMuted()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VoiceChat.ToggleMuted()
```

## Events

### VOICE_CHAT_ACTIVE_INPUT_DEVICE_UPDATED

### VOICE_CHAT_ACTIVE_OUTPUT_DEVICE_UPDATED

### VOICE_CHAT_AUDIO_CAPTURE_ENERGY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpeaking` | bool | no |  |
| `energy` | number | no |  |

### VOICE_CHAT_AUDIO_CAPTURE_STARTED

### VOICE_CHAT_AUDIO_CAPTURE_STOPPED

### VOICE_CHAT_CHANNEL_ACTIVATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_DEACTIVATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_DISPLAY_NAME_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `channelDisplayName` | cstring | no |  |

### VOICE_CHAT_CHANNEL_JOINED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |
| `channelID` | number | no |  |
| `channelType` | ChatChannelType | no |  |
| `clubId` | ClubId | yes |  |
| `streamId` | ClubStreamId | yes |  |

### VOICE_CHAT_CHANNEL_MEMBER_ACTIVE_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `isActive` | bool | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_ENERGY_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `speakingEnergy` | number | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_GUID_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ALL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `isMutedForAll` | bool | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ME_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `isMutedForMe` | bool | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_SILENCED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `isSilenced` | bool | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_SPEAKING_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `isSpeaking` | bool | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_STT_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `message` | string | no |  |
| `language` | string | no |  |

### VOICE_CHAT_CHANNEL_MEMBER_VOLUME_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberID` | number | no |  |
| `channelID` | number | no |  |
| `volume` | number | no |  |

### VOICE_CHAT_CHANNEL_MUTE_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `isMuted` | bool | no |  |

### VOICE_CHAT_CHANNEL_PTT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `pushToTalkSetting` | cstring | no |  |

### VOICE_CHAT_CHANNEL_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |

### VOICE_CHAT_CHANNEL_TRANSCRIBING_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `isTranscribing` | bool | no |  |

### VOICE_CHAT_CHANNEL_TRANSMIT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `isTransmitting` | bool | no |  |

### VOICE_CHAT_CHANNEL_VOLUME_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelID` | number | no |  |
| `volume` | number | no |  |

### VOICE_CHAT_COMMUNICATION_MODE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `communicationMode` | CommunicationMode | no |  |

### VOICE_CHAT_CONNECTION_SUCCESS

### VOICE_CHAT_DEAFENED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDeafened` | bool | no |  |

### VOICE_CHAT_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `platformCode` | number | no |  |
| `statusCode` | VoiceChatStatusCode | no |  |

### VOICE_CHAT_INPUT_DEVICES_UPDATED

### VOICE_CHAT_LOGIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |

### VOICE_CHAT_LOGOUT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceChatStatusCode | no |  |

### VOICE_CHAT_MUTED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMuted` | bool | no |  |

### VOICE_CHAT_OUTPUT_DEVICES_UPDATED

### VOICE_CHAT_PENDING_CHANNEL_JOIN_STATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `channelType` | ChatChannelType | no |  |
| `clubId` | ClubId | yes |  |
| `streamId` | ClubStreamId | yes |  |
| `pendingJoin` | bool | no |  |

### VOICE_CHAT_PTT_BUTTON_PRESSED_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPressed` | bool | no |  |

### VOICE_CHAT_SILENCED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSilenced` | bool | no |  |

### VOICE_CHAT_SPEAK_FOR_ME_ACTIVE_STATUS_UPDATED

### VOICE_CHAT_SPEAK_FOR_ME_FEATURE_STATUS_UPDATED

### VOICE_CHAT_TTS_PLAYBACK_BOOKMARK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `utteranceID` | number | no |  |
| `bookmarkName` | cstring | no |  |

### VOICE_CHAT_TTS_PLAYBACK_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `utteranceID` | number | no |  |
| `status` | VoiceTtsStatusCode | no |  |

### VOICE_CHAT_TTS_PLAYBACK_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `utteranceID` | number | no |  |

### VOICE_CHAT_TTS_PLAYBACK_STARTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `utteranceID` | number | no |  |

### VOICE_CHAT_TTS_SPEAK_TEXT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | VoiceTtsStatusCode | no |  |
| `utteranceID` | number | no |  |

### VOICE_CHAT_TTS_VOICES_UPDATE

### VOICE_CHAT_VAD_SETTINGS_UPDATED

## Types

### CommunicationMode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `PushToTalk` | CommunicationMode | no |  |
| `OpenMic` | CommunicationMode | no |  |

### VoiceAudioDevice (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | string | no |  |
| `displayName` | string | no |  |
| `isActive` | bool | no |  |
| `isSystemDefault` | bool | no |  |
| `isCommsDefault` | bool | no |  |

### VoiceChannelErrorReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Unknown` | VoiceChannelErrorReason | no |  |
| `IsBattleNetChannel` | VoiceChannelErrorReason | no |  |

### VoiceChatChannel (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `channelID` | number | no |  |
| `channelType` | ChatChannelType | no |  |
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `volume` | number | no |  |
| `isActive` | bool | no |  |
| `isMuted` | bool | no |  |
| `isTransmitting` | bool | no |  |
| `isTranscribing` | bool | no |  |
| `members` | VoiceChatMember[] | no |  |

### VoiceChatMember (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `energy` | number | no |  |
| `memberID` | number | no |  |
| `isActive` | bool | no |  |
| `isSpeaking` | bool | no |  |
| `isMutedForAll` | bool | no |  |
| `isSilenced` | bool | no |  |

### VoiceChatProcess (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `channels` | VoiceChatChannel[] | no |  |

### VoiceChatStatusCode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Success` | VoiceChatStatusCode | no |  |
| `OperationPending` | VoiceChatStatusCode | no |  |
| `TooManyRequests` | VoiceChatStatusCode | no |  |
| `LoginProhibited` | VoiceChatStatusCode | no |  |
| `ClientNotInitialized` | VoiceChatStatusCode | no |  |
| `ClientNotLoggedIn` | VoiceChatStatusCode | no |  |
| `ClientAlreadyLoggedIn` | VoiceChatStatusCode | no |  |
| `ChannelNameTooShort` | VoiceChatStatusCode | no |  |
| `ChannelNameTooLong` | VoiceChatStatusCode | no |  |
| `ChannelAlreadyExists` | VoiceChatStatusCode | no |  |
| `AlreadyInChannel` | VoiceChatStatusCode | no |  |
| `TargetNotFound` | VoiceChatStatusCode | no |  |
| `Failure` | VoiceChatStatusCode | no |  |
| `ServiceLost` | VoiceChatStatusCode | no |  |
| `UnableToLaunchProxy` | VoiceChatStatusCode | no |  |
| `ProxyConnectionTimeOut` | VoiceChatStatusCode | no |  |
| `ProxyConnectionUnableToConnect` | VoiceChatStatusCode | no |  |
| `ProxyConnectionUnexpectedDisconnect` | VoiceChatStatusCode | no |  |
| `Disabled` | VoiceChatStatusCode | no |  |
| `UnsupportedChatChannelType` | VoiceChatStatusCode | no |  |
| `InvalidCommunityStream` | VoiceChatStatusCode | no |  |
| `PlayerSilenced` | VoiceChatStatusCode | no |  |
| `PlayerVoiceChatParentalDisabled` | VoiceChatStatusCode | no |  |
| `InvalidInputDevice` | VoiceChatStatusCode | no |  |
| `InvalidOutputDevice` | VoiceChatStatusCode | no |  |

### VoiceTtsStatusCode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Success` | VoiceTtsStatusCode | no |  |
| `InvalidEngineType` | VoiceTtsStatusCode | no |  |
| `EngineAllocationFailed` | VoiceTtsStatusCode | no |  |
| `NotSupported` | VoiceTtsStatusCode | no |  |
| `MaxCharactersExceeded` | VoiceTtsStatusCode | no |  |
| `UtteranceBelowMinimumDuration` | VoiceTtsStatusCode | no |  |
| `InputTextEnqueued` | VoiceTtsStatusCode | no |  |
| `SdkNotInitialized` | VoiceTtsStatusCode | no |  |
| `DestinationQueueFull` | VoiceTtsStatusCode | no |  |
| `EnqueueNotNecessary` | VoiceTtsStatusCode | no |  |
| `UtteranceNotFound` | VoiceTtsStatusCode | no |  |
| `ManagerNotFound` | VoiceTtsStatusCode | no |  |
| `InvalidArgument` | VoiceTtsStatusCode | no |  |
| `InternalError` | VoiceTtsStatusCode | no |  |

### VoiceTtsVoiceType (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `voiceID` | number | no |  |
| `name` | string | no |  |

