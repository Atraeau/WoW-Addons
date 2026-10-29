# King's Gambit — Host Interface (sketch)

*The seam between the engine and the WoW API. Status: **draft for review**, no code yet.
Rationale for the approach is in the [design journal](design-journal.md#testability-simulation--training-added-2026-10-28).*

## Principles

1. **API only, not UI.** The Host wraps WoW *API* (time, roster, loot, comms, trade,
   storage). The real UI is built with real frames and talks to the engine, never to
   WoW data directly.
2. **Engine instances take a Host.** `client = KG.NewClient(host)`. No module-level
   singletons, so a test (or a training session) can run many clients in one process.
3. **Normalized, not raw.** The Host exposes our vocabulary (names as `Name-Realm`, rank
   as 0/1/2, events with plain-table payloads), not WoW's quirks. Translating is the
   RealHost's job.
4. **Failures are values.** Anything that can fail returns `nil, reason` (or `false, reason`).
   Hosts never throw for expected conditions (player left, loot gone, throttled).
5. **A contract test suite** runs the same checks against MockHost headlessly and
   against RealHost in the game (method exists, argument/return shapes, events fire),
   so the mock can't silently drift from the real thing.

## Surface

Grouped by capability. `host.caps` is a table of booleans (`masterLoot`, `trade`, `comms`, …)
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
| `candidates(slot)` | array of names | `GetMasterLootCandidate` over the candidate indexes; the Host hides the index mapping |
| `give(slot, name)` | `true` or `false, reason` | `GiveMasterLoot`; reasons: `notml`, `gone`, `notcandidate`, `full` |
| `itemInfo(link)` | `{name, ilvl, equipLoc, bindType, class, subclass}` or nil | `GetItemInfo`; may be nil until cached, so the engine must tolerate it |

### Communication
| Method | Returns | Notes / real API |
|---|---|---|
| `maxMessage` | number (255) | A constant, so chunking logic is testable |
| `registerPrefix(prefix)` | | `C_ChatInfo.RegisterAddonMessagePrefix` |
| `send(prefix, payload, channel, target)` | `true` or `false, reason` | `C_ChatInfo.SendAddonMessage`; channel `RAID`/`GUILD`/`WHISPER`; the Host owns throttling and queueing |
| `whisper(name, text)` | | `SendChatMessage(..., "WHISPER")` — the fallback for players without the addon |
| `announce(text, channel)` | | `SendChatMessage` to RAID / RAID_WARNING |
| `serialize(table)` / `deserialize(str)` | string / table or nil | `C_EncodingUtil` (CBOR + base64) in RealHost; canonical form in Mock |

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
`host.on(event, fn)` returns an unsubscribe handle. Events are normalized:

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
signatures are checked against `docs/api.json` when RealHost is written.

## What is *not* in the Host

- **Frames and the UI toolkit.** The UI is real and uses the WoW frame API directly.
- **Pure logic.** Hashing, canonical serialization, standings replay and the draft rules
  never need the Host and stay in plain modules.

## Mock and Sim control surfaces

These are extra methods on MockHost/SimHost, not part of the Host contract. Tests and
training scenarios use them to play the part of the world:

- `mock:advance(sec)` — move the clock and fire due timers (no real waiting).
- `mock:setRaid(members, {leader=, assistants=, lootMethod=})`
- `mock:dropLoot(items)` — open a loot window with these items.
- `mock:receive(prefix, payload, channel, sender)` / `mock:whisperFrom(name, text)`
- `mock:completeTrade(partner, gave, got)`
- `mock:reload()` — simulate `/reload` (storage persists, in-memory state is rebuilt).
- `mock.sent` — everything the client tried to send, for assertions.
- **SimNetwork:** `net = SimNetwork.new{seed=, latency=, dropRate=, duplicateRate=, reorder=}`;
  `net:attach(host, name)`; `net:partition{{a,b},{c}}`; `net:heal()`. Delivery is driven by
  the same fake clock, so multi-client runs are deterministic.
- **Sim bots:** a bot is a scripted fake raider with a policy (always Need, pass on
  upgrades, bid late, …) that answers a loot window through `mock:receive`/`whisperFrom`.

## Migration of the Phase 1 code

- `Hash`, `Standings`: unchanged (already pure).
- `Ledger`: `Ledger.chains` and `OnInit` move onto a client object created with a Host;
  persistence goes through `host.storage()`.
- `Core.lua`: builds the RealHost, calls `KG.NewClient(host)`, and wires `/gambit`.
- Existing tests keep working; new tests build clients over a MockHost.

## Decisions (from the open questions)

1. **Throttling:** the Host exposes `pending()` (queue depth) so sync can pace itself. MockHost
   reports `pendingCount`, which tests can set.
2. **Names:** `normalize` only adds the realm when it's missing. No case folding.
3. **Item info:** `itemInfo(link)` may return nil until the item is cached; the Host then emits
   `item.info` (from `GET_ITEM_INFO_RECEIVED`). MockHost reproduces this with
   `setItemInfo(link, info, {delayed = true})` and `cacheItem(link)`.

## Conventions fixed while building MockHost

- Host methods use colon calls (`host:now()`), and `host:on(event, fn)` returns an
  **unsubscribe function**.
- Subscribing to or emitting an unknown event name is an error, so typos fail loudly.
- `Host.METHODS` / `Host.EVENTS` / `Host.Missing(host)` in `Host.lua` are the contract the
  contract tests check, and RealHost will be checked against them in game.
- Code that runs on both MockHost and the client stays Lua 5.1-safe (no `//`, no bitwise
  operators), since the client's Lua is 5.1-based.
