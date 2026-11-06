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
| `v` | number | The format the event was written in. Currently `2`; see "Migrating the ledger" below for how a new one is introduced. An event keeps its `v` for ever. |
| `ledger` | string | The `id` of the ledger's Genesis event; `""` on the Genesis event itself. |
| `chain` | string | `author .. "#" .. epoch`, where `epoch` is 8 hex characters chosen when the chain starts. |
| `seq` | number | Position in its chain, starting at `1`. |
| `prev` | string | The previous event's `id` in the same chain; `0000000000000000` for the first. |
| `ts` | number | Server time in whole seconds. Never lower than the previous event in the chain. |
| `author` | string | The writer's identity: `First_Last` (a character's first and last name; WoW: Forever has no realms). An entry keeps whatever name string it was written with, so a ledger written with older spellings still verifies. |
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

- its author is the Master Looter of a raid active for it **and**, if it is about a list, that list is the raid's list or the raid's off-spec list
  (see `SetRaidList`; a raid with none named plays on `main`), or
- its author was an officer (or the guild master) when it was written and **no** raid is active for it.

Otherwise it is skipped (`duringraid`, `expired`, `notauthorized`, `wronglist`, or `nolistchosen` when the guild requires a raid to have a list of its
own and none is named yet). A raid's off-spec list is `off` for the list `main` and `<list>-off` for any other.

### Ledger-wide events (no `list`)

| Type | `data` | Rule and effect |
|---|---|---|
| `Genesis` | `name` | First event of the ledger, `seq` 1 of its chain, `ledger = ""`. Its author is the guild master. Only one. |
| `SetGuildMaster` | `name` | By the guild master only. Hands the role on. |
| `SetOfficers` | `names` (list) | By the guild master only. Replaces the officer list (mirrored from the game's guild ranks). |
| `Elevate` | `raid`, `ml`, `minutes` (1 to 1440) | By an officer. Opens raid `raid` with Master Looter `ml` until `ts + minutes*60`. For a running raid with the same `ml`, extends it (never shortens). Skipped for an ended raid or a different `ml`. |
| `Revoke` | `raid` | By an officer, for an active raid: it ends at `ts`. |
| `RaidClose` | `raid` | By the raid's Master Looter, while active: it ends at `ts`. |
| `SetDisenchanter` | `raid`, `name` | By the raid's Master Looter, while the raid is active. Designates who disenchants what nobody wants, for that raid. The latest choice stands. Loot is not handed out until one is set. |
| `SetRaidList` | `raid`, `list` | By an officer, for an active raid: the list the raid plays on. **The first one stands** (`listset` after that). `list` is lower-case letters, digits and `_`, up to 24, not `off` (`badlistid`); under the per-raid policy it can't be `main` (`needsownlist`). A list that does not exist yet is created by the raid's Master Looter, in the order of `main`, when the first session starts. |
| `SetListPolicy` | `mode` (`choose` or `perraid`) | By the guild master only (`badpolicy` otherwise). `perraid`: every raid opened **after** this entry must have a list of its own, and is a `dedicated` raid for good; `choose` (the default) lets a raid play on `main`. Changing it never changes a raid already open. |
| `Declined` | `request`, `requestedBy`, `declineReason` | A declined adjustment request. No effect; recorded for transparency. |
| `Migrate` | `from`, `to`, `cut`, `digest`, `reason` | The cutover to a new format (see "Migrating the ledger"). By the guild master only, written in the NEW format (`v == to`), `to == from + 1`, `from` the ledger's current format. `cut` is `{ [chain] = n }`: how many events of each chain are before the change. `digest` is the standings those events produce. |
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
| `Award` | `member`, `item`, `to?`, `replaces?` | The member wins and moves to the bottom. `to` is who actually received the item (a gift). `replaces` is the id of one of this writer's earlier awards: a regret-trade, where that award is undone (same rule as `Revert`) and `member`, who really has the item, pays as if they had won it. One entry, atomic: if either half is refused, nothing changes (`notmember`, `samewinner`, `notrevertible`). |
| `Pass` | `member`, `item`, `kind?` | Counts toward pass statistics (`kind = "upgrade"` counts as an upgrade pass). |
| `Transfer` | `award`, `to` | Re-routes where an earlier award went. |
| `MovePlayer` | `member`, `reason`, `to` / `above` | A correction. `reason` is required. |
| `Revert` | `target` | Undoes one of this writer's own `Award`s, the latest or an earlier one, as long as this writer has made no `MovePlayer` or `RemoveMember` since. Later awards stay as they are. The winner goes back directly above the highest-placed of the players who were below them when they won or have won since, so the list ends as if that award had never been made. If the same player won again later (a draft pick, then a salvage claim), that later win already put them at the bottom, so nobody moves: the later win takes over remembering who was below them, and the player just loses one win. |
| `Disenchant` | `item`, `to` | Nobody wanted the item: it was given to `to` to disenchant. |
| `DisenchantResult` | `disenchant`, `results`, `requestedBy?` | What disenchanting that item actually gave (added in 0.5.0). `disenchant` is the id of the `Disenchant` event; `results` is 1 to 8 entries `{ name, count (1 to 200), item? }`. Valid only if the player who disenchanted (`requestedBy`, else the author) is the `to` of that `Disenchant`, and once. Written by the Master Looter, who is told by the disenchanter; it moves nobody and never changes the `Disenchant` event. |
| `Salvage` | `award`, `action` | What the claimer of a salvage item did: `keep`, `gift`, `sell`, `disenchant` or `bank`. Written by the Master Looter (`salvaged <name> <action>`); for transparency, it moves nobody. |

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

(The worked example uses the older `Name-Realm` spelling, which is just an opaque string to the ledger.) After replay the order is `Brann-Realm`, `Aldric-Realm`, and the fingerprint is `2cc0444c8382fd78`.

## 8. How peers stay in step

Peers exchange chains over addon messages: each heartbeat lists every chain's count and head (and says which sync protocol and
addon build the sender runs, see "Versions" below), and a peer asks for what
it is missing. A chain can only fork if its writer wrote from two machines with stale saved data; then the longer branch
is kept (ties: the lower `id` at the split) and the other events are kept aside for review.

## 9. Saved data

`KingsGambitDB` (account-wide): `schema = 2`, `ledger = { chains = { [chainId] = { events = { ... } } } }`,
`mine = { [identity] = chainId }` (each character's own chain), `config`, and `orphans` (events kept aside by a chain
fork).

## Versions

The addon's version is [Semantic Versioning](https://semver.org): `MAJOR.MINOR.PATCH`, optionally `-prerelease` and `+build`
(`0.1.0+84`: the release build stamps `+<run number>` into the TOC; build metadata never affects which versions work together).

**Who works with whom.** Players do not have to run the same version. They work together when they are on the same **line**:
the same `MAJOR`, or, while `MAJOR` is `0` (initial development, where SemVer allows anything to change), the same
`MAJOR.MINOR`. So `0.1.0` and `0.1.7` share a ledger; `0.1.7` and `0.2.0` do not; from `1.0.0` on, `1.2.0` and `1.9.4` do and
`1.9.4` and `2.0.0` do not. Within a line a newer `MINOR` or `PATCH` has features and fixes the older one lacks, and the older
one keeps working.

**What puts a change on a new line** (a `MAJOR` bump, or `MINOR` while 0.x): anything an older client on the same line could not
live with. For a shared ledger that means the entries and rules: a new or changed event type, a changed meaning of an existing
one, a change to the ledger format (`v`, currently `2`) or to how standings follow from entries, or to the addon messages. An
older client rejects an event type or message it doesn't know, so its standings would silently differ; that is why adding one is
**not** a compatible change here, even though it would be a "feature" elsewhere. A fix, a UI change, a new command or an optional
message field older clients ignore bumps `MINOR` or `PATCH` only.

**How it's enforced.** `tests/compat_baseline.lua` records the ledger-facing surface (ledger format, every event type, request kind
and message type) and the line. `tests/test_compat.lua` fails, listing exactly what was added or removed, when the code no longer
matches, and also checks that the TOC version is valid SemVer on the recorded line. Changing the surface therefore forces a decision:
start a new line (bump the TOC version and the baseline's `line`), or say why it is compatible and update the lists. A change to what an
existing event *does* isn't visible to that test and needs the same decision by hand.

**What the addon does.** Every addon message carries the sender's version (`a`). A player on another line is announced once
("X runs King's Gambit 0.2.0, which this version can't work with: update"), the one on the older line is the one that must update,
and nothing they send is acted on, so neither side applies what it may misread. A newer version on the same line is announced once as
an optional update. A sender whose version can't be read (a development copy, an older build) is let through, and the ledger's own
checks (`v`, hashes, rules) still refuse what it cannot read. `/gambit version` lists the players seen and how each compares. The
loot session start (`LS`) is judged the same way; a raider on another line than the Master Looter ignores the session and is told.

**Not decided yet:** how a ledger written on one line is read after everyone moves to the next (a migration). Today a different `v` is
rejected, which is safe, but nothing converts old entries; that is needed before the first breaking change to the format itself.

## Migrating the ledger

The ledger is never rewritten, so a change to what events look like or mean can't edit old entries (that would break every hash and the tamper-evidence
that is the point). Instead:

- **Every event keeps its format.** `v` is the format it was written in, for ever. Hashes and chains stay valid however old.
- **Every published event type has a schema** (`src/Schemas.lua`): the fields of each type in each format, which are required, and their types. A published
  (format, type) schema is frozen: `tests/schema_baseline.lua` holds a hash of each, and a test fails if one changes or disappears. To change an event, make a new
  format and an **upcaster** from the old one.
- **Upcasters read old ledgers** (`src/Migrations.lua`). For each old format there is a pure function mapping an event to the next format's equivalent; replaying
  a ledger runs every event through the chain to the newest format, so current code reads any old ledger. An upcaster makes the old *meaning* explicit where the new
  rules would differ (a changed default becomes an explicit value), so a past outcome is never re-decided.
- **A golden ledger per published format** (`tests/ledgers/format_2.lua`, 41 real events covering every event type) must always load, verify and replay to the
  standings it was frozen with. This is the proof that "any ledger, however old" still works; it also catches a wrong upcaster before release.
- **The cutover is a ledger entry** (`Migrate`, guild master only). Until it, everyone writes the ledger's current format, even a release that knows the next
  (a *downcaster* writes the old shape). `cut` names exactly which events are before the change, the same on every machine whatever order they arrive in. After the
  cut, an event in the old format is recorded as a conflict (`staleformat`: its writer needs to update), never silently applied. The entry itself is in the new
  format, so a client that cannot read it learns the ledger has moved on when it arrives (`unreadable`).
- **The migration proves itself on every machine.** `digest` is the standings (orders, wins, passes, awards and where an undo would put each winner back) the cut's
  history produces. Each client replays that history under its own code and compares. A client that gets a different answer is *frozen*: it refuses to write, and says why.
- **Rollout.** A release that adds a format reads both and keeps writing the old one, advertising the formats it reads in heartbeats (`f`); `migrate status` shows the
  guild master who is ready, and `migrate <format> <reason>` writes the cutover. It is a ledger decision, not a download, so players update on their own schedule;
  only those who cannot read the new format must update after it.

This strategy is evaluated against a simulated breaking change (`tests/migration_fixture.lua`, `tests/test_migration.lua`): `KG_SCORECARD=1 lua tests/run.lua` prints every check.
