# King's Gambit — Client Interface (sketch)

*The seam between the engine and the WoW API. **"Client" means the WoW game client** (the Win32 app
that hosts the addon), not our own code; our own state-owning object is the **Engine**.
Status: MockClient and RealClient built; RealClient is verified against the documented signatures but not yet against the live client (see the field-test items below).*
*Rationale for the approach: [design journal](design-journal.md#testability-simulation--training-added-2026-10-28).*

## Principles

1. **API only, not UI.** The Client wraps WoW *API* (time, roster, loot, comms, trade,
   storage). The real UI is built with real frames and talks to the engine, never to
   WoW data directly.
2. **Engine instances take a Client.** `engine = Engine.New(client)`. No module-level
   singletons, so a test (or a training session) can run many engines in one process.
3. **Normalized, not raw.** The Client exposes our vocabulary (names as `Name-Realm`, rank
   as 0/1/2, events with plain-table payloads), not WoW's quirks. Translating is the
   RealClient's job.
4. **Failures are values.** Anything that can fail returns `nil, reason` (or `false, reason`).
   Clients never throw for expected conditions (player left, loot gone, throttled).
5. **A contract test suite** runs the same checks against MockClient headlessly and
   against RealClient in the game (method exists, argument/return shapes, events fire),
   so the mock can't silently drift from the real thing.

## Surface

Grouped by capability. `client.caps` is a table of booleans (`masterLoot`, `trade`, `comms`, …)
so a Sim can disable a capability and the engine can degrade gracefully.

### Time and randomness
| Method | Returns | Notes / real API |
|---|---|---|
| `now()` | seconds (float, monotonic) | `GetTime` — for timers, never stored in events |
| `serverTime()` | unix seconds (integer) | `GetServerTime` — the only clock that goes into events (`ts`) |
| `after(sec, fn)` | handle | `C_Timer.After` / `NewTimer` |
| `every(sec, fn)` | handle | `C_Timer.NewTicker` |
| `cancel(handle)` | | |
| `random(n)` / `random()` | integer 1..n / float | `math.random`; Mock/Sim is seeded for replayable tests |

### Identity and roster
| Method | Returns | Notes / real API |
|---|---|---|
| `me()` | `"Name-Realm"` | `UnitFullName("player")` |
| `normalize(name)` | `"Name-Realm"` | Adds the realm if missing; one canonical form everywhere |
| `inGroup()` / `inRaid()` | boolean | `IsInGroup` / `IsInRaid` |
| `roster()` | array of `{name, class, rank, online, subgroup}` | `GetRaidRosterInfo` over `GetNumGroupMembers`; rank 0 member / 1 assistant / 2 leader |
| `rankOf(name)` | 0/1/2 or nil | Backs the proof-of-authority check (leader and assistants may write) |
| `guildRoster()` | array of `{name, class, online}` | `GetGuildRosterInfo`; for seeding lists and offline lookups |

### Loot
| Method | Returns | Notes / real API |
|---|---|---|
| `lootMethod()` | `"master"`, `"group"`, … | `GetLootMethod` |
| `isMasterLooter()` | boolean | `IsMasterLooter` |
| `lootSlots()` | array of `{slot, link, itemId, quality, quantity}` | `GetNumLootItems`, `GetLootSlotInfo`, `GetLootSlotLink`; only while a loot window is open |
| `candidates(slot)` | array of names | `GetMasterLootCandidate` over the candidate indexes; the Client hides the index mapping |
| `give(slot, name)` | `true` or `false, reason` | `GiveMasterLoot`; reasons: `notml`, `gone`, `notcandidate`, `full` |
| `itemInfo(link)` | `{name, ilvl, equipLoc, bindType, class, subclass}` or nil | `GetItemInfo`; may be nil until cached, so the engine must tolerate it |
| `itemStats(link)` | `{stats = {str, agi, sp, heal, hit, ...}, classes = {"PRIEST", ...} or nil}` or nil | `GetItemStats` for base stats; the tooltip (`C_TooltipInfo.GetHyperlink`) for equip effects (English patterns) and the "Classes:" line (`ITEM_CLASSES_ALLOWED`, class names via `LOCALIZED_CLASS_NAMES_*`). Used by ItemFit |
| `itemCount(item, includeBank)` | number | `C_Item.GetItemCount`; `item` is an id, name or link. With `includeBank`, the game's cached bank count is included. Used for token readiness |
| `reputation(factionId)` | 1 (Hated) .. 8 (Exalted), or nil | `C_Reputation.GetFactionDataByID(id).reaction`. Used for token readiness |

### Communication
| Method | Returns | Notes / real API |
|---|---|---|
| `maxMessage` | number (255) | A constant, so chunking logic is testable |
| `registerPrefix(prefix)` | | `C_ChatInfo.RegisterAddonMessagePrefix` |
| `send(prefix, payload, channel, target)` | `true` or `false, reason` | `C_ChatInfo.SendAddonMessage`; channel `RAID`/`GUILD`/`WHISPER`; the Client owns throttling and queueing |
| `whisper(name, text)` | | `SendChatMessage(..., "WHISPER")` — the fallback for players without the addon |
| `announce(text, channel)` | | `SendChatMessage` to RAID / RAID_WARNING |
| `serialize(table)` / `deserialize(str)` | string / table or nil | `C_EncodingUtil` (CBOR + base64) in RealClient; canonical form in Mock |

### Trade and bound items
| Method | Returns | Notes / real API |
|---|---|---|
| `trade()` | `{partner, give = {links}, get = {links}, accepted}` or nil | `GetTradePlayerItemLink` and friends |
| `tradeableUntil(link)` | seconds remaining or nil | Bound-tradeable window (`C_TradeInfo`, `EndBoundTradeable`); makes regret-trade detection possible |

### Environment and storage
| Method | Returns | Notes / real API |
|---|---|---|
| `storage()` | `{ account = {...}, char = {...} }` | The SavedVariables tables, handed to the engine at startup (Real: `KingsGambitDB` / `KingsGambitCharDB`) |
| `playSound(kind)` | | `PlaySound`; the modest, tunable alert cue |
| `print(text)` | | User-facing chat line |
| `log(level, text)` | | Debug log; Mock collects it for assertions |

### Events (subscribe/emit)
`client.on(event, fn)` returns an unsubscribe handle. Events are normalized:

| Event | Payload | Source |
|---|---|---|
| `roster.changed` | none | `GROUP_ROSTER_UPDATE` |
| `lootMethod.changed` | `{method}` | `PARTY_LOOT_METHOD_CHANGED` |
| `loot.opened` | `{slots}` | `LOOT_OPENED` |
| `loot.slotCleared` | `{slot}` | `LOOT_SLOT_CLEARED` |
| `loot.closed` | none | `LOOT_CLOSED` |
| `comms.received` | `{prefix, payload, channel, sender}` | `CHAT_MSG_ADDON` |
| `whisper.received` | `{sender, text}` | `CHAT_MSG_WHISPER` |
| `trade.changed` / `trade.closed` | `{trade}` / `{completed, gave, got}` | `TRADE_ACCEPT_UPDATE`, `TRADE_CLOSED` |
| `encounter.ended` | `{id, name, success}` | `ENCOUNTER_END` — a natural boundary for a loot batch |
| `world.entered` | none | `PLAYER_ENTERING_WORLD` — the point to run startup verification |

Every method and event above is present on this client's exported API. The exact
signatures are checked against `docs/api.json` when RealClient is written.

## What is *not* in the Client

- **Frames and the UI toolkit.** The UI is real and uses the WoW frame API directly.
- **Pure logic.** Hashing, canonical serialization, standings replay and the draft rules
  never need the Client and stay in plain modules.

## Mock and Sim control surfaces

These are extra methods on MockClient/SimClient, not part of the Client contract. Tests and
training scenarios use them to play the part of the world:

- `mock:advance(sec)` — move the clock and fire due timers (no real waiting).
- `mock:setRaid(members, {leader=, assistants=, lootMethod=})`
- `mock:dropLoot(items)` — open a loot window with these items.
- `mock:receive(prefix, payload, channel, sender)` / `mock:whisperFrom(name, text)`
- `mock:completeTrade(partner, gave, got)`
- `mock:reload()` — simulate `/reload` (storage persists, in-memory state is rebuilt).
- `mock.sent` — everything the engine tried to send, for assertions.
- **SimNetwork:** `net = SimNetwork.new{seed=, latency=, dropRate=, duplicateRate=, reorder=}`;
  `net:attach(client, name)`; `net:partition{{a,b},{c}}`; `net:heal()`. Delivery is driven by
  the same fake clock, so multi-client runs are deterministic.
- **Sim bots:** a bot is a scripted fake raider with a policy (always Need, pass on
  upgrades, bid late, …) that answers a loot window through `mock:receive`/`whisperFrom`.

## Migration of the Phase 1 code

- `Hash`, `Standings`: unchanged (already pure).
- `Ledger`: `Ledger.chains` and `OnInit` move onto an engine object created with a Client;
  persistence goes through `client.storage()`.
- `Core.lua`: builds the RealClient, calls `Engine.New(client)`, and wires `/gambit`.
- Existing tests keep working; new tests build engines over a MockClient.

## Decisions (from the open questions)

1. **Throttling:** the Client exposes `pending()` (queue depth) so sync can pace itself. MockClient
   reports `pendingCount`, which tests can set.
2. **Names:** `normalize` only adds the realm when it's missing. No case folding.
3. **Item info:** `itemInfo(link)` may return nil until the item is cached; the Client then emits
   `item.info` (from `GET_ITEM_INFO_RECEIVED`). MockClient reproduces this with
   `setItemInfo(link, info, {delayed = true})` and `cacheItem(link)`.

## Conventions fixed while building MockClient

- Client methods use colon calls (`client:now()`), and `client:on(event, fn)` returns an
  **unsubscribe function**.
- Subscribing to or emitting an unknown event name is an error, so typos fail loudly.
- `Client.METHODS` / `Client.EVENTS` / `Client.Missing(client)` in `Client.lua` are the contract the
  contract tests check, and RealClient will be checked against them in game.
- Code that runs on both MockClient and the real client stays Lua 5.1-safe (no `//`, no bitwise
  operators), since the client's Lua is 5.1-based.

## RealClient: what the real API taught us

Checked against `docs/api.json` while writing `RealClient.lua`:

- `C_ChatInfo.SendAddonMessage` returns a **`SendAddonMessageResult` enum**, not a boolean.
  RealClient maps it to `true` or `false, <lowercased enum name>` (e.g. `addonmessagethrottle`).
  `RegisterAddonMessagePrefix` likewise returns an enum. The enum *values* are not in the
  export, so RealClient looks them up by name at runtime, and `/gambit check` records them.
- Loot method comes from **`C_PartyInfo.GetLootMethod()`** (returns an enum plus the master
  looter's party/raid id), not the old global.
- Item info is **`C_Item.GetItemInfo`** (a long return list); the old global is untyped.
- Serialization uses **`C_EncodingUtil`**: `SerializeCBOR`, `EncodeBase64(source, variant)`.
  Payloads are tagged `c` (CBOR + base64) or `k` (canonical text fallback).
- **Secret Values:** names, links and message senders are checked with `issecretvalue` and the
  item is skipped, never read.
- **Restrictions:** `send` checks `C_ChatInfo.AreOutgoingAddonChatMessagesRestricted()` first and
  returns `false, "restricted"`; `ADDON_RESTRICTION_STATE_CHANGED` becomes the
  `comms.restrictionChanged` event. Whispers and announcements honor
  `C_ChatInfo.InChatMessagingLockdown()`.
- `GET_ITEM_INFO_RECEIVED` gives an item **id**, so `item.info` carries `itemId` (and `link`
  when cached).

### Still to verify in the field test (marked `FIELD` in the code)

1. `IsMasterLooter()` semantics, and the `GiveMasterLoot` candidate-index mapping.
2. Trade flow: event order, whether items are still readable at `TRADE_CLOSED`, and whether
   `UI_INFO_MESSAGE` reports "Trade complete".
3. `tradeableUntil` is not implemented (needs a tooltip scan of the bound-tradeable line).
4. Which of the raw events RealClient registers this client rejects (`client.unregistered`).
5. Whether addon messages to yourself loop back (the `/gambit check` loopback probe).
6. Real enum names and values (recorded by `/gambit check`).
