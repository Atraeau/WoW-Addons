# King's Gambit — Ledger format (v2)

*A specification precise enough to verify a ledger with your own code, without ours. The reference
implementation is `src/` (`Hash.lua`, `Ledger.lua`, `Standings.lua`); the audit tool is
[`tools/`](../tools/README.md). The worked example below is checked by the test suite, so it cannot
drift from the code. Why it is shaped this way: [ledger-v2-design.md](ledger-v2-design.md).*

## 1. What a ledger is

A ledger is a set of **chains, one per writer**. Each chain is append-only and only its writer adds to it. Each event
includes the hash of the previous event in its chain, so changing or removing a past event breaks every hash after it.

Standings are never stored. They are what you get by replaying every chain's events in **two passes** (section 5):

1. **Authority events** in **write order**: by `ts`, then `chain` (as text), then `seq`.
2. **List events** (and `Declined`, `ItemClasses`, `ItemSuits`) in **sort-key order**: by key, then `chain`, then `seq`.

An event's **key** is when its loot became visible: `data.seen` if the event has a valid one, otherwise `ts`, but
never less than the key of the previous event in the same chain. So a raid that hands loot out at a break is
ordered by when the loot dropped, not when it was handed out, and a writer's own events never swap places.
`seen` is valid when it is a number no later than `ts` and no more than 24 hours (86,400 s) before it; an event
whose `seen` is invalid is skipped (`badseen`), and its key falls back to `ts`.

## 2. An event

| Field | Type | Meaning |
|---|---|---|
| `v` | number | Format version. Currently `2`. |
| `ledger` | string | The `id` of the ledger's Genesis event; `""` on the Genesis event itself. |
| `chain` | string | `author .. "#" .. epoch`, where `epoch` is 8 hex characters chosen when the chain starts. |
| `seq` | number | Position in its chain, starting at `1`. |
| `prev` | string | The previous event's `id` in the same chain; `0000000000000000` for the first. |
| `ts` | number | Server time in whole seconds. Never lower than the previous event in the chain. |
| `author` | string | `Name-Realm` of the writer. |
| `type` | string | One of the event types in section 5. |
| `list` | string, optional | The list a list event belongs to (`main`, `off`, ...). Absent on ledger-wide events. |
| `data` | table | The fields for that type. |
| `id` | string | The event's hash (section 4). |

## 3. Canonical text

To hash an event we need one exact text for it. `Canon(value)`:

- string: `s` + byte length + `:` + the bytes, e.g. `s4:Main`
- number: `n` + the number written as an integer if it is whole (no exponent, no decimal point), otherwise 17 significant
  digits; `0` is `n0`
- `true` / `false`: `T` / `F`;  nil: `~` (a key whose value is nil is simply absent)
- table: `{`, then for each key in sorted order (numbers before strings, each group ascending): `Canon(key)` `=`
  `Canon(value)` `,`, then `}`

## 4. The hash

`id = Sum( prev .. "|" .. Canon{ v, ledger, chain, seq, ts, author, type, list, data } )`

(`prev` is joined in front as text; `id` is never part of what is hashed.)

`Sum(text)` is two passes of 32-bit **FNV-1a** over the bytes, each written as 8 lowercase hex digits:

- pass 1 starts at `2166136261` (`0x811C9DC5`); pass 2 starts at `2654435761` (`0x9E3779B1`)
- for each byte: `h = ((h XOR byte) * 16777619) mod 2^32`
- `id` = pass 1 hex, then pass 2 hex (16 characters)

This is **not cryptographic**. The chains catch mistakes, lost messages and accidental damage; they do not stop a
determined bad-faith officer (see the [manifesto](manifesto.md)).

Test vectors: `Sum("")` = `811c9dc59e3779b1`, `Sum("abc")` = `1a47e90bdf63f96f`.

The **fingerprint** of a whole ledger is `Sum(Canon(list))`, where `list` holds `{ chain, count, head }` for every
chain, sorted by chain id. Equal fingerprints mean identical histories.

## 5. Replay: event types, rules and authority

Pass 1 applies the authority events in write order and records every change. Pass 2 applies the list events in key
order; each is checked against the authority **in effect when it was written** (every authority change earlier in
write order), whatever its key. A raid's window is its final one (after any extensions). An event that breaks a rule is **skipped** and reported as a *conflict*; it
stays in its chain. Every verifier skips exactly the same events, so everyone gets the same standings.

### Who may write

The ledger-wide state is: the guild master, the set of officers, and raids (`{ id, ml, opened by, expires,
ended by }`). A raid is **active for an event** when the event comes after the `Elevate` that opened it in write order,
its `ts` is before `expires`, and it comes before the `RaidClose` or `Revoke` that ended it (if any).

A list event, `Declined`, `ItemClasses` or `ItemSuits` is allowed when:

- its author is the Master Looter of a raid active for it, or
- its author was an officer (or the guild master) when it was written and **no** raid is active for it.

Otherwise it is skipped (`duringraid`, `expired` or `notauthorized`).

### Ledger-wide events (no `list`)

| Type | `data` | Rule and effect |
|---|---|---|
| `Genesis` | `name` | First event of the ledger, `seq` 1 of its chain, `ledger = ""`. Its author is the guild master. Only one. |
| `SetGuildMaster` | `name` | By the guild master only. Hands the role on. |
| `SetOfficers` | `names` (list) | By the guild master only. Replaces the officer list (mirrored from the game's guild ranks). |
| `Elevate` | `raid`, `ml`, `minutes` (1 to 1440) | By an officer. Opens raid `raid` with Master Looter `ml` until `ts + minutes*60`. For a running raid with the same `ml`, extends it (never shortens). Skipped for an ended raid or a different `ml`. |
| `Revoke` | `raid` | By an officer, for an active raid: it ends at `ts`. |
| `RaidClose` | `raid` | By the raid's Master Looter, while active: it ends at `ts`. |
| `Declined` | `request`, `requestedBy`, `declineReason` | A declined adjustment request. No effect; recorded for transparency. |
| `ItemSuits` | `item` (item id), `roles` (tank, melee, hunter, caster, healer; empty = back to the heuristic), `reason`, `name?` | An officer's override of who an item suits (a suggestion, not a rule). |
| `ItemClasses` | `item` (item id), `classes` (class tokens, empty = any class), `reason`, `name?` | The guild's rule for who may bid on an item in the drafts; it overrides the item's own "Classes:" line. The latest rule for an item wins. |

### List events (with `list`)

Order is top of the list first. Positions are never numbers: they are an end (`to = "top"` or `"bottom"`) or an anchor
(`above = Name`, an active member).

| Type | `data` | Effect and rules |
|---|---|---|
| `CreateList` | `name` | Creates the list. Only once per list. |
| `AddMember` | `member`, `class?`, `to?` / `above?` | Adds the player (default bottom). Skipped if already an active member. |
| `RemoveMember` | `member` | Removes an active member. |
| `Award` | `member`, `item`, `to?` | The member wins and moves to the bottom. `to` is who actually received the item (a gift). |
| `Pass` | `member`, `item`, `kind?` | Counts toward pass statistics (`kind = "upgrade"` counts as an upgrade pass). |
| `Transfer` | `award`, `to` | Re-routes where an earlier award went. |
| `MovePlayer` | `member`, `reason`, `to` / `above` | A correction. `reason` is required. |
| `Revert` | `target` | Undoes this writer's most recent `Award` (and, one by one, the ones before it), as long as this writer has made no `MovePlayer` or `RemoveMember` since. The winner goes back directly above the highest-placed of the players who were below them when they won. |
| `Disenchant` | `item`, `to` | Nobody wanted the item. |
| `Salvage` | `award`, `action` | What the claimer of a backstop item did: `keep`, `gift`, `sell`, `disenchant` or `bank`. |

## 6. Verifying

For each chain: `seq` counts up from 1; `prev` is the previous `id` (or the zero value); `ts` never goes down; `chain`
starts with `author .. "#"` followed by 8 characters; `v` is 2; `ledger` is the Genesis `id` (or `""` on the Genesis);
and the recomputed `id` matches. Then merge all chains and replay (section 5).

## 7. Worked example

The guild master starts the ledger, creates `main`, adds two players and elevates a Master Looter, who awards an item.

| Chain | seq | ts | type | data | `id` |
|---|---|---|---|---|---|
| `Guildmaster-Realm#1a2b3c4d` | 1 | 1760000000 | `Genesis` | `name = "Guild ledger"` | `89cf69b1d9689705` |
| `Guildmaster-Realm#1a2b3c4d` | 2 | 1760000010 | `CreateList` (list `main`) | `name = "Main"` | `2e3878a6c2111092` |
| `Guildmaster-Realm#1a2b3c4d` | 3 | 1760000020 | `AddMember` (list `main`) | `member = "Aldric-Realm"` | `46c60894660959a8` |
| `Guildmaster-Realm#1a2b3c4d` | 4 | 1760000030 | `AddMember` (list `main`) | `member = "Brann-Realm"` | `f4594a4cd28c07e0` |
| `Guildmaster-Realm#1a2b3c4d` | 5 | 1760000100 | `Elevate` | `raid = "thu-1"`, `ml = "Looter-Realm"`, `minutes = 360` | `dc646491b3a302e5` |
| `Looter-Realm#5e6f7a8b` | 1 | 1760000200 | `Award` (list `main`) | `member = "Aldric-Realm"`, `item = "Gauntlets of the Ashen Vow"` | `07c2ae4df2d4dc39` |

Every event except the Genesis has `ledger = "89cf69b1d9689705"`. The text hashed for the Genesis is
`0000000000000000|` followed by:

```
{s6:author=s17:Guildmaster-Realm,s5:chain=s26:Guildmaster-Realm#1a2b3c4d,s4:data={s4:name=s12:Guild ledger,},s6:ledger=s0:,s3:seq=n1,s2:ts=n1760000000,s4:type=s7:Genesis,s1:v=n2,}
```

After replay the order is `Brann-Realm`, `Aldric-Realm`, and the fingerprint is `2cc0444c8382fd78`.

## 8. How peers stay in step

Peers exchange chains over addon messages: each heartbeat lists every chain's count and head, and a peer asks for what
it is missing. A chain can only fork if its writer wrote from two machines with stale saved data; then the longer branch
is kept (ties: the lower `id` at the split) and the other events are kept aside for review.

## 9. Saved data

`KingsGambitDB` (account-wide): `schema = 2`, `ledger = { chains = { [chainId] = { events = { ... } } } }`,
`mine = { [Name-Realm] = chainId }` (each character's own chain), `config`, and `orphans` (events kept aside by a chain
fork).
