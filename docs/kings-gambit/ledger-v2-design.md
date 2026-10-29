# King's Gambit — Ledger v2: one chain per writer

*Design for review. Status: **proposed, not built.** Replaces the single shared chain and its
"longer chain wins" fork rule. Background: the decision of 2026-10-29 in the
[design journal](design-journal.md).*

## 1. The problem, and the fact that solves it

Two raids can run at the same time, each with its own Master Looter writing to the ledger. With one shared
chain, every pair of near-simultaneous writes is a fork, so parallel raids would fork constantly.

The fact that makes this solvable: **a character can't be in both raids at once.** Each raid's events only
concern its own players. And every normal ledger operation moves a player to the bottom or top of the list
(or adds one at the bottom). Moving one player to the end of the list **never changes the order of everyone
else**. So whatever order the two raids' events are interleaved in, the order *among raid A's players* is
decided by raid A's events alone, and the same for raid B. Different merge orders only change where A's and
B's winners land relative to each other at the bottom, and a fixed merge rule settles that the same way for
everyone.

## 2. The shape of the ledger

- Each writer keeps **their own append-only, hash-chained log** (a *chain*). Nobody else ever appends to it, so a
  chain can't fork (except in one rare case, section 7).
- A chain's id is `Name-Realm#epoch`, where `epoch` is 8 random hex characters chosen when the chain starts. If
  a writer loses their saved data and starts over, that is a **new chain**, not a conflicting copy of the old one.
- One chain carries events for **all lists** (`main`, `off`, ...); each event names its list.
- The whole ledger has a **ledger id**: the hash of its first event (the genesis, section 4). Events from a different
  ledger (another guild, a training session) can never mix in.
- **Standings are a replay of every chain's events merged into one order** that every peer computes identically:

  > sort by **time**, then **chain id**, then **position in the chain**

  Time is the server time (whole seconds). Within one chain, time may never go backwards (an event with an earlier
  time than its predecessor is invalid), so sorting never reorders a writer's own events.
- **One fingerprint:** the ledger's state is identified by the hash of all `(chain id, head)` pairs, sorted. Two peers with the
  same fingerprint have exactly the same history. The UI shows this the way it shows the head hash today.

### Events that arrive late

An event that arrives late (the other raid's award, delayed by a lost message) simply takes its place in the merge order,
and the standings are recomputed. Replay is cheap (20,000 events replay in about 40 ms), so this is done in full each
time; a cached checkpoint can come later if it is ever needed.

### Events that are no longer valid in the merged order

A writer checks an event against the standings they can see before writing it. After merging, it can occasionally fail
(an award to a player that another writer removed a moment earlier). Such an event is **not removed from its chain**
(the chain is that writer's record and stays intact). Replay **skips it** and lists it as a *conflict* with its reason.
Every peer skips exactly the same events, so standings still agree. Conflicts are shown to officers to resolve, the
way orphans were before. With the authority rules below, conflicts should be very rare.

## 3. Operations that stay correct when merged

The section 1 argument holds for "move to the bottom", "move to the top" and "add at the bottom". Two operations need to change
so they keep that property:

- **`MovePlayer` uses an anchor, not a number.** Instead of "to position 7" it records "to just above *Name*" (or top or
  bottom). The interface still lets you type a number; it is turned into "above whoever is at 7 now" when written. A
  numbered position would mean different things depending on which other raid's events had arrived.
- **`Revert` (undo) uses an anchor too.** When an award is replayed, the player who was directly below the winner is
  remembered. Undoing that award puts the winner back directly above that player. Because moves to the bottom don't change
  anyone else's relative order, this restores the original order among everyone, whatever the other raid did in between.
  The current rule "only while nothing has shifted positions" becomes "only the writer's own most recent awards, in order,
  while that writer has made no other position change since". If the remembered player has left the list, the winner goes
  back above the next player who was below them.

All other events (`Award`, `Pass`, `Transfer`, `Disenchant`, `Salvage`, `AddMember` at the bottom, `RemoveMember`)
already have the property.

## 4. Who may write, checked by every peer

Authority is recorded in the ledger itself, so any peer (and the audit tool) can check it from the chains alone, without
knowing who was in which raid.

- **Genesis.** The first event of the ledger is written by the **owner** (the guild leader): it names the ledger and its
  owner. The owner can **set the officers** (`SetOfficers { names }`) and **hand ownership on** (`SetOwner`). The owner
  counts as an officer.
- **Raids.** An officer opens a raid with `RaidOpen { raid, ml }`, naming its Master Looter (themselves or anyone else),
  and the Master Looter closes it with `RaidClose { raid }`. A raid that is never closed closes itself **8 hours** after
  it opened, so a crashed Master Looter can't lock the ledger.
- **The rule**, applied in replay to every event at its time *t*:

  | Who wrote it | Allowed at time *t* if |
  |---|---|
  | A raid's Master Looter | that raid is open at *t* (they write for their raid) |
  | An officer | **no** raid is open at *t* |
  | Anyone else | never |

  Events that break the rule are skipped as conflicts ("written during a raid by someone other than its Master Looter").
- **Officers during a raid** send the Master Looter an **adjustment request** (move a player, undo an award, add or remove
  someone, with a reason). It is a message, not a ledger event. The Master Looter sees it and accepts or declines; an
  accepted request is written by the Master Looter with `requestedBy` in the event, so the history shows who asked and who
  approved.
- **Reconciled.** A raid is reconciled when its close is in the ledger and the peers' fingerprints agree. The interface only
  offers officers direct editing when no raid is open and the ledger is reconciled. (The replay rule above is the real
  enforcement; this just keeps officers from writing events that would be skipped.)

This also settles two questions left open earlier: who may write (now recorded and verifiable), and who runs a loot
session when there is no Master Looter (only a raid's Master Looter runs sessions; outside a raid, officers can record a
manual award).

## 5. Sync

Simpler than today, because a chain can't fork:

- The heartbeat lists every chain the peer knows: `{ chain id → count, head }`.
- A peer that is missing events from a chain asks for that chain from the next position. A peer that sees a chain it has never
  heard of asks for all of it.
- Live events go to the raid channel **and** the guild channel, so the other raid's Master Looter sees each award within a
  fraction of a second, not at the next heartbeat.
- The "probe" and fork-resolution machinery go away, except for the rare case in section 7.

## 6. What the rest of the system sees

- **The loot session** draws its draft order from the merged standings, exactly as now. During a raid, its players' relative
  order is decided only by that raid's events (section 1), so another raid's awards can't change who drafts first.
- **The audit tool** verifies every chain, applies the merge and the authority rule, and lists any conflicts.
- **The format spec** gets a v2 section. Events gain `chain` and `ledger` fields; `seq` and `prev` become per chain.
- **The simulator's Sync lab** becomes two raids with two Master Looters writing at once, plus an officer.
- **No migration is needed.** No real ledger exists yet (the game isn't playable until Nov 4); v1 is retired.

## 7. The one remaining way to fork

If a writer runs the same chain from two machines with stale saved data (logs in on a second PC that has an old copy), they
can write two different events at the same position of their own chain. Peers detect this (same chain, same position,
different event). The rule: the longer branch of that chain is kept; ties go to the lower id; the other branch's events
are kept aside for review and the writer is told. This is the old rule, but now only for this rare accident, not for normal
parallel play. To make it rarer still, a client catches up on its own chain from peers before its first write after login.

## 8. Testing

- Existing randomized convergence test, rewritten for v2: random writes by several writers, splits, loss, duplication and late
  delivery; all peers must reach the same fingerprint and the same standings.
- A new property test of section 1: two raids with disjoint players, events interleaved in every random order; the relative
  order of each raid's players must be the same in every interleaving.
- Authority: events by the wrong writer at the wrong time are skipped identically everywhere, and listed as conflicts.
- Undo by anchor: an award, other raid's awards in between, then the undo, restores the original relative order.

## Questions for you

1. **Can the Master Looter be someone who isn't an officer?** The design allows it (an officer opens the raid and names the
   Master Looter). Or should only officers be Master Looters?
2. **Is 8 hours right** for a raid that is never closed to close itself?
3. **Is the guild leader the right owner** (the one who appoints officers)? Or should any officer be able to change the
   officer list?
4. **Declined adjustment requests:** should they be recorded in the ledger too (more transparency), or only accepted ones?
