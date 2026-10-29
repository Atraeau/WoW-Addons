# King's Gambit — Ledger format

*A specification precise enough to verify a ledger with your own code, without ours. The reference
implementation is `src/KingsGambit/` (`Hash.lua`, `Ledger.lua`, `Standings.lua`); the audit tool is
[`tools/`](../../tools/README.md). The worked example below is checked by the test suite, so it cannot
drift from the code.*

## 1. What a ledger is

Each **list** (for example `main`, `off`) is an **append-only chain of events**. Standings are never
stored on their own: they are what you get by replaying the events in order. Each event includes the
hash of the event before it, so changing or removing any past event changes every hash after it.

## 2. An event

| Field | Type | Meaning |
|---|---|---|
| `v` | number | Format version. Currently `1`. |
| `list` | string | The list id this event belongs to. |
| `seq` | number | Position in the chain, starting at `1`. |
| `prev` | string | The previous event's `id`; the first event uses `0000000000000000`. |
| `ts` | number | Server time in whole seconds when it was written. |
| `author` | string | `Name-Realm` of whoever wrote it. |
| `type` | string | One of the event types in section 5. |
| `data` | table | The fields for that type. |
| `id` | string | The event's hash (section 4). |

## 3. Canonical text

To hash an event we need one exact text for it, whatever order its fields were created in.
`Canon(value)`:

- string: `s` + byte length + `:` + the bytes, e.g. `s4:Main`
- number: `n` + the number written as an integer if it is whole (no exponent, no decimal point), otherwise 17 significant digits; `0` is `n0`
- `true` / `false`: `T` / `F`;  nil: `~`
- table: `{`, then for each key in sorted order (numbers before strings, each group ascending): `Canon(key)` `=` `Canon(value)` `,`, then `}`

## 4. The hash

`id = Sum( prev .. "|" .. Canon{ v, list, seq, ts, author, type, data } )`, where the table has exactly
the seven keys `v`, `list`, `seq`, `ts`, `author`, `type` and `data`. (`prev` is joined in front as text,
and `id` is never part of what is hashed.)

`Sum(text)` is two passes of 32-bit **FNV-1a** over the bytes, written as 8 lowercase hex digits each:

- pass 1: start at `2166136261` (`0x811C9DC5`); pass 2: start at `2654435761` (`0x9E3779B1`)
- for each byte: `h = ((h XOR byte) * 16777619) mod 2^32`
- `id` = pass 1 hex, then pass 2 hex (16 characters)

This is **not cryptographic**. The trust model is trusted officers; the chain exists to catch mistakes,
lost messages and tampering by accident, not to stop a determined bad-faith officer (see the
[manifesto](manifesto.md)).

Test vectors: `Sum("")` = `811c9dc59e3779b1`, `Sum("abc")` = `1a47e90bdf63f96f`.

## 5. Event types and their rules

An event is **rejected** (never added) if it breaks its rules or the standings it would apply to. Rules
are checked against the standings built from all earlier events. Order below is the top of the list
first; "bottom" means the last position.

| Type | `data` | Effect and rules |
|---|---|---|
| `CreateList` | `name` | Must be the first event of the list, and only once. |
| `AddMember` | `member`, `class?`, `pos?` | Adds the player (default bottom; `pos` is `"top"`, `"bottom"` or a whole number from 1 to the new size). Rejected if already an active member. |
| `RemoveMember` | `member` | Removes an active member. |
| `Award` | `member`, `item`, `to?` | The member wins and moves to the bottom. `to` is who actually received the item (a gift); default the member. |
| `Pass` | `member`, `item`, `kind?` | No position change; counts toward the member's pass statistics (`kind = "upgrade"` counts as an upgrade pass). |
| `Transfer` | `award`, `to` | Re-routes where an earlier award went. No position change. The award must exist and not be reverted. |
| `MovePlayer` | `member`, `pos`, `reason` | An officer's correction. `reason` is required. |
| `Revert` | `target` | Exactly undoes the most recent `Award`, and the ones before it in order, as long as nothing has shifted positions since. |
| `Disenchant` | `item`, `to` | Nobody wanted the item. No position change. |
| `Salvage` | `award`, `action` | What the claimer of a backstop item did: `keep`, `gift`, `sell`, `disenchant` or `bank`. |

Every event also needs a numeric `ts`, a non-empty `author`, a `data` table and the right `seq`.

## 6. Verifying a chain

For each event in order: `seq` is one more than the last (starting at 1); `prev` equals the last `id`
(or the zero value); `v` is 1; the recomputed `id` matches; and the event passes its type's rules against
the standings so far. The first event that fails is where the chain is broken. The last event's `id` is
the chain's **head**: two ledgers with the same head have the same history.

## 7. Worked example

Four events by `Raidlead-Realm`, list `main`:

| seq | ts | type | data | `id` |
|---|---|---|---|---|
| 1 | 1760000000 | `CreateList` | `name = "Main"` | `afd137672323aec3` |
| 2 | 1760000010 | `AddMember` | `member = "Aldric-Realm"`, `class = "MAGE"` | `9290606d89d766d1` |
| 3 | 1760000020 | `AddMember` | `member = "Brann-Realm"` | `2e846a527f771216` |
| 4 | 1760000100 | `Award` | `member = "Aldric-Realm"`, `item = "Gauntlets of the Ashen Vow"` | `1364c5f42bad9da8` |

The text hashed for event 1 is `0000000000000000|` followed by:

```
{s6:author=s14:Raidlead-Realm,s4:data={s4:name=s4:Main,},s4:list=s4:main,s3:seq=n1,s2:ts=n1760000000,s4:type=s10:CreateList,s1:v=n1,}
```

After event 4 the order is `Brann-Realm`, `Aldric-Realm` (Aldric won, so he dropped to the bottom).

## 8. How peers stay in step

Peers exchange events over addon messages and compare chain heads; see the sync section of the
[design journal](design-journal.md). If two histories split, the **longer chain wins** (ties: the earlier
fork event, then the lower id), and the losing branch is kept for review. Nothing is silently discarded.

## 9. Saved data

`KingsGambitDB` (account-wide): `schema`, `lists = { [listId] = { events = { ... } } }`, `config`,
`orphans = { { list, at, events } }` (events set aside by a fork).
