# King's Gambit — Design Journal

*King's Gambit is derived from the classic Suicide Kings strategy and named for the chess gambit: a deliberate sacrifice of position for advantage. "Suicide" below still means dropping to the bottom after a win, and the player at the bottom is the "salvager".*

*A compressed record of the design conversation behind the SK loot addon: the
decisions we made, the alternatives we weighed, and why we landed where we did.
It exists so the work can be **resumed** without re-deriving everything, and so
the guild can **audit** how each rule came to be.*

**Status:** design phase (no addon code yet). Last updated **2026-10-28**.
**Companion docs:** [manifesto.md](manifesto.md) (values & principles) · the full
design plan (`structured-napping-pancake.md`, user-level `.claude/plans`) ·
API ground truth at <https://atraeau.github.io/WoW-Addons/>.

---

## The through-line (three theses)

1. **Loot distribution is gameplay.** The value is the live, in-the-moment,
   *empirical* call each player makes when something drops — spend my position?
   wait? gift it? The addon foregrounds that agency and never pre-commits it
   (no wishlists, no pre-rankings, no drop-table homework).
2. **The shared standings are a rock-solid distributed ledger.** We borrow the
   useful ideas from blockchain — append-only event log, hash-chaining,
   idempotent content-addressed events, proof-of-authority, gossip sync,
   deterministic fork resolution — and drop the irrelevant (proof-of-work,
   tokens, trustless global consensus, heavy crypto).
3. **Transparency is the enforcement.** Rules are pure and mechanical; fairness
   pressure comes from visibility, not penalties. The limitation is stated
   honestly: this is a *fair, transparent, agency-preserving process — not an
   authoritative loot optimizer.*

---

## Decision log

Each entry: **Decision** — the alternatives considered — **why** we chose it.

### Foundations

- **Event-sourced, append-only ledger; standings = deterministic replay.**
  (vs. storing standings directly.) Gives history, audit, and undo, and is what
  makes integrity-checking possible at all.
- **Hash-chained events; a head hash fingerprints the whole history.** Lets any
  two peers prove they agree (or detect desync/corruption) cheaply.
- **Trust model: trusted-officer + hash chain, no cryptography.** (vs. signed
  events / real crypto.) A guild isn't a bank; the chain reliably catches
  *mistakes, dropped messages, and desync* — it does not try to stop a
  determined bad-faith officer. Simplest thing that's fast in Lua.
- **Authority (who can write): raid leader + assistants** (proof-of-authority).
  Matches how guilds already delegate trust; multiple officers can run loot.

### Standings

- **Persistent, guild-wide standing.** (vs. per-raid reset.) Positions carry
  between raids; presence only gates *eligibility* for a given drop.
- **Identity: per-character now, recorded so per-main is a later layer.**
  (vs. per-main from day one.) Simple and unambiguous to start; alt-mapping
  slots in later without a rewrite.
- **Pure SK: your position changes *only* when you win.** No decay, no
  attendance bonus, no penalties. Predictable and drama-free.
- **Anti-hoarding by transparency, not mechanics.** We considered decay and
  pass-penalties and **rejected them** — they punish legitimate passes (an item
  that doesn't fit your playstyle shouldn't cost you). Instead we *surface*
  behavior: stat columns (last-win, passes-on-upgrades, raids-since-win,
  time-at-position), public passes, an officer "camp-watch" flag, a gentle nudge.
- **One list across all raids.** (vs. per-raid or per-tier lists.) Item value is
  **not baked in** — it's *revealed* by the clearing position (SK as a
  position-denominated market): minor items clear cheap, BiS clears dear. See
  the minor-upgrade debate below for the problem this created and how we solved
  it. (Core is multi-list-capable; we ship one "Main" and keep others as future
  config.)

### Bidding & resolution

- **Bid vocabulary: Need / Pass (not useful) / Gift→player / Off-spec.** Captures
  the real reasons people pass and feeds the transparency surfaces.
- **Multi-drop = priority draft over the boss's whole batch.** (vs.
  item-at-a-time in arbitrary order.) The top remaining needer live-picks any
  available item, claims it, suicides; the next steps up. First pick is an
  *earned* choice; no arbitrary-order advantage.
- **No per-batch cap.** Pure SK — you can win again from the bottom if the room
  passes. Position is the only arbiter; no special cases.
- **Off-spec: a persistent per-pool "off" list, lazy enrollment (first off-bid),
  and main *always* has priority** (the main tier drafts before the off tier).
  An off-win suicides only the off list. This makes off-bidding a real strategic
  gamble (it costs *something*, and always loses to a main bidder) rather than a
  free way to preserve your main position. This resolved the "no-cost roll gets
  gamed by passing" worry.
- **Resolution tiers: Main draft → Off draft → Backstop → DE handler.**
  The **backstop** offers items that got no main/off Need bids in **reverse
  order (lowest standing first)** with **no usability gate** ("the bottom is
  eligible for everything"); the claimer suicides (≈free at the bottom) and may
  keep or gift it up. High players are *last*, so they can't farm scraps.
- **The bottom claimant is a "salvager" with full agency:** use it / gift it up /
  sell for gold / disenchant for mats / donate to guild bank. Default is
  individual agency; an **optional guild-bank mode** (officer config) routes
  salvage value to the guild. Turns the bottom spot into a consolation role and
  captures otherwise-wasted value — a mild, self-limiting incentive (salvage ≪ a
  real position).
- **Final floor:** if *everyone* passes, the item goes to the Master Looter or a
  **designated DE person** (officer config) → disenchant → guild bank. Even the
  floor captures value for the guild.
- **No free-roll — rejected.** A costless roll is conspirable (collude to pass,
  then roll cheap). The **deterministic reverse-order backstop replaces it**:
  nothing to game, no RNG, and contested items never reach it.

### Gifting (and the make-or-break problem)

- **Gifting is redefined as a *win + transfer, in any direction* — not a pass.**
  You win the item (and pay the suicide), then hand it to anyone, **including
  upward**. The target is declared at bid time and is **correctable** (change the
  bid pre-resolve; a `Transfer` correction re-routes it post-award).
- **Why this shape:** it solves the **minor-upgrade waste problem**, which we
  flagged as *make-or-break* for the whole system. With one list across all
  raids, a slight upgrade can get disenchanted while a player who'd actually want
  it sits too high to bid economically. The fix: a **bottom player can proxy** —
  win the minor item cheaply from near the bottom and gift it up to the high
  player who wants it. Contested loot still goes at full price (you pay your
  suicide); generosity is recognized socially. We considered letting a bottom
  player **suicide to gift upward via a free roll** and rejected it (the
  free-roll collusion risk); the paid backstop + any-direction gift achieves the
  same good outcome without the exploit.

### Mistakes & regret-trades

- **Fix-forward, append-only corrections.** A *recent* award can be undone
  exactly and automatically; *older* ones use an officer-authored `MovePlayer`
  correction event (logged, with before/after). History is never silently
  rewritten — corrections are themselves visible events.
- **Regret-trades auto-detected** via trade events + the bound-tradeable window.
  **Default is a bid-test:** if the recipient had bid on the item, treat the
  trade as a *mistake correction* (reverse the giver, suicide the recipient); if
  they hadn't, treat it as a *gift* (standings unchanged). **Both are
  overridable** — a player can deliberately forfeit position instead. Not
  gameable: reclaiming a spot costs the recipient a real suicide.

### UI

- **Subtle, off-center, non-occluding bid popup** — must never block the center
  of the screen or occlude your character. All frames are movable, lockable,
  scalable, opacity-adjustable, and saved per character; keybind-first.
- **Timer ends early the moment every *eligible* player has bid.** It's bounded
  and ML-configurable per raid; an open-ended option exists but isn't the
  default. No-response counts as Pass (with a clear countdown; officers can
  extend).
- **Alert cue is modest and per-player tunable, including fully silent.**
- **Upgrade hints are informational and player-toggleable (default off)** — they
  preserve the self-evaluation skill and the surprise; precision isn't needed
  because nothing is penalized.

### Sync & external publishing

- **Guild-wide gossip over the GUILD channel; live loot over RAID.** Non-raiders
  still converge; offline members catch up on login. Head-hash heartbeat +
  block-range request/response for catch-up; 255-byte chunking; deterministic
  fork resolution (canonical order: timestamp → author-priority → hash, then
  replay); idempotent via event ids.
- **Companion exporter (out-of-game tooling).** Addons can't make web requests,
  so a companion tails SavedVariables and publishes: a Discord append-feed +
  pinned standings message, a GitHub Pages full-snapshot page, and a manual
  export string. Append (not re-dump) via a cursor + event-id dedupe.

---

### Testability, simulation & training (added 2026-10-28)

- **The WoW *API* is abstracted behind a `Client` interface; the UI is not.** The ledger,
  standings, draft engine and every other rule reach the game only through the Client:
  clock, RNG, timers, raid roster and ranks (leader/assistant), loot (Master Looter
  candidates, loot slots, `GiveMasterLoot`), addon comms, whispers, trades, and
  persistence. They never call WoW globals directly. Why: this is the only way to test
  the rules headlessly, and it makes simulation nearly free.
- **The UI is real, always.** We build the actual frames and use them for real raids,
  tests and training alike. We don't build a parallel mock UI. The UI talks to the
  engine, and the engine talks to a Client, so swapping the Client swaps where the data
  comes from without touching the UI.
- **Three Client implementations, one engine, one UI.**
  - **RealClient** talks to the WoW client.
  - **MockClient** is headless, with a scriptable clock, seeded RNG, fake roster and fake
    loot. It runs the rule tests under plain Lua 5.4 (CI) and inside the game.
  - **SimClient** is MockClient made interactive: a fake raid with bot raiders, driven live
    by the learner through the real UI. This is training mode.
- **In-game self-tests.** `/gambit test` runs the same suites inside the client (the
  test files load on demand so they cost nothing in normal play). This catches
  differences between Lua 5.4 and the client's Lua, such as the `bit` library. The real
  UI is checked here too, by driving it over a MockClient (open the popup, click Need,
  assert the resulting event), since UI code can't run outside the client.
- **Training / simulation mode, with the Master Looter as the first audience.**
  - A sandboxed list that is clearly labeled and **never synced or gossiped**; its
    events can't mix with the guild ledger.
  - **Scripted scenarios as data**, replayed deterministically: the minor-upgrade proxy,
    the backstop and salvager, everyone passes (DE person and guild bank), a mistaken
    award and its correction, a regret trade, a tie in the draft, a late bid.
  - **Coach mode** can explain why the system did what it did in plain language, drawing
    on the rationale doc, and can check what the learner chose against what the rules allow.
  - Because the ledger is event-sourced, a **real past session can be replayed** as a
    training scenario.
- **Synchronization is testable and teachable too.** Comms go through the Client, so we can
  simulate several engines at once, in two ways:
  - **Virtual engines in one process (automated tests).** Each virtual engine has its own
    engine instance and its own MockClient, joined by a **SimNetwork** that can add latency,
    drop, duplicate and reorder messages, and partition the group. The tests assert that
    every engine converges to the same head hash and standings. Cases: a late joiner, an
    officer who was offline and returns, two officers writing at once (a fork), a lost
    message, a corrupted event.
  - **Real people practicing together (training).** Several players each run the addon in
    training mode and sync over the real addon channel, but on a **separate training
    prefix and session code**, so they exercise the real RealClient comms path without
    touching the guild ledger. Training lists can't merge with guild lists.
  - **Confidence cues.** The UI shows a clear sync status (in sync / catching up / diverged),
    compares head hashes between participants, and training scenarios end with a check
    ("do all of you show the same head?"), so learners can see they did it right.
  - **Consequence for the code:** the engine must be instantiable (no module-level
    singletons such as `Ledger.chains`). Each engine, real or simulated, owns its own
    state and Client.
- **Field testing in a real dungeon (low stakes).** The mock can only be as right as our
  understanding of the client, so we validate against the real thing early and cheaply:
  - **RealClient first, then a field test.** RealClient is written right after MockClient, and
    the same contract suite runs against it in the game (`/gambit test`), starting solo in
    town. That catches wrong signatures and Secret Values surprises before anyone else is involved.
  - **A sandboxed field list**, never synced to the guild ledger, so a dungeon run can't
    pollute real standings.
  - **Dry-run and live modes.** Dry-run logs what the addon *would* hand out
    (`GiveMasterLoot` is not called). Live actually gives the items, fine in a normal dungeon.
  - **Record and replay.** Field mode records every Client call and event with timestamps
    into SavedVariables. We read the trace after the run, fix whatever differs from the mock,
    and turn each discovery into a permanent MockClient test, so real-world surprises become
    regression tests.
  - **What a run is for:** Master Looter setup in a dungeon group, the real order of
    `LOOT_OPENED` and `LOOT_SLOT_CLEARED`, `GiveMasterLoot` candidate indexing, async
    `GetItemInfo`, addon-message size and throttling, trade events and the bound-tradeable
    window, `C_EncodingUtil` and the `bit` library, and SavedVariables across a real logout.
  - **Known real-world constraint:** the client can restrict outgoing addon chat messages
    (`AreOutgoingAddonChatMessagesRestricted`, `AddonRestrictionStateChanged`), for example
    during boss encounters. The Client will report this (`send` returns `false, "restricted"`
    and a `comms.restrictionChanged` event), and sync must queue and retry afterward. A boss
    fight is a good field test for exactly this.
  - **Needs other players** for sync: a few people running the addon in the same party
    (a guildie or alts), with at least one player *without* it to exercise the whisper fallback.
- **Phasing change:** a new Phase 1.5 (Client abstraction, MockClient, shared test harness,
  CI) comes before the UI work, so the real UI is built against the Client from the start.
  Training mode (SimClient, scenarios, coach) follows the loot session. The multi-engine
  SimNetwork tests land with Phase 3 (sync), and the multi-player training sessions with
  Phase 4.5.

### Loot session engine: choices made while building it (2026-10-28)

The rules in the sections above left some details open. These are the choices the first
implementation (`Loot.lua`) makes, each one easy to change. Please review them.

- **A session is a state machine:** bidding, main draft, off-spec draft, backstop,
  review, done. It runs on any Client (real, mock or simulated), so it is fully testable.
- **Nothing is written to the ledger until the Master Looter confirms.** The draft runs
  on scratch copies of the standings (winners drop to the bottom of the copy), so live
  picks work while the real standings stay untouched. Confirm then writes the awards in
  order, which replays to exactly the same standings.
- **Hand out first, record second.** For items from a loot window the session calls
  `give` first and writes the `Award` only if that succeeded, so a failed hand-out never
  leaves a phantom win. Failures are reported to the Master Looter.
- **Early close:** bidding ends the moment every eligible player has answered every item.
  Eligible means online in the raid and on the main list. Unanswered at the timer's end
  counts as pass. A timer of 0 means open-ended (the Master Looter ends it).
- **Draft turns:** the top remaining player with a live bid goes next. If they bid on only
  one remaining item it is awarded automatically (no prompt); with a choice they pick.
  A **skip** (or a pick timeout) forfeits the rest of that tier for that player only, so
  the draft always finishes. There is no cap: a winner can win again from the bottom if
  nobody above wants what is left.
- **Gift bids** compete in the main tier at the gifter's own position. The gifter pays the
  position and `give` hands the item to the target.
- **Off-spec enrollment:** off-spec bidders not yet on the off list join its bottom (in
  main-list order among the newcomers) the first time they bid off. The enrollment is
  recorded at confirm. If the off list does not exist yet, it is created.
- **Backstop:** leftover items are offered one at a time, lowest position first, to every
  eligible player, whether or not they could use it. A claimer drops to the bottom like
  any winner. An offer that times out counts as a decline.
- **Disenchant floor:** if everyone declines, the item goes to the designated disenchanter
  (default: whoever runs the session), and a `Disenchant` event records it.
- **Recording passes:** only passes that carry a kind (for example `upgrade`) are written
  to the ledger, for the transparency stats. Plain passes are not, to keep the ledger small
  (a raid would otherwise write dozens of events per boss).
- **New ledger events:** `Disenchant` (item, recipient) and `Salvage` (which award, what the
  claimer did: keep, gift, sell, disenchant, bank), both for transparency only.
- **Unlisted raiders** are added to the bottom of the main list when a session starts
  (`autoEnroll`, on by default), so a newcomer can bid.

Not built yet: parsing whispered bids from players without the addon, a per-player
"pass on everything in the backstop" shortcut, and the upgrade heuristic that would label
passes automatically.

### Sync layer: choices made while building it (2026-10-28)

`Sync.lua` and `SimNetwork.lua` implement the gossip, catch-up and fork handling from the
Sync section above, tested with several simulated players over a network that drops,
duplicates, reorders and partitions messages.

- **Protocol:** live events are pushed as they are written (RAID while in a raid, otherwise
  GUILD); a small heartbeat (list sizes and head hashes) goes out every 30 seconds; range
  requests fetch what is missing; a probe (checkpoints at positions 1, 2, 4, 8, ...) finds
  where two histories split. Messages are split into frames under 255 bytes, and replies are
  capped near five frames so one lost frame costs little. A restricted or throttled send stays
  queued and retries when the restriction lifts.
- **Fork rule, changed from the plan: the longer chain wins.** The plan said to order by
  timestamp, then author priority, then hash. Two problems: author rank depends on the live
  roster, so peers could disagree; and "earliest wins" lets an officer who was offline for an
  hour overwrite everything the live group did since. The implemented rule uses only
  information inside the ledger, so every peer reaches the same answer: **the longer chain
  wins; on a tie, the earlier fork event wins, then the lower event id.**
- **The loser's events are not lost:** the losing branch is kept in `db.orphans` (list, time,
  events) for an officer to review and re-enter. Nothing is silently discarded.
- **A bug found by randomized testing.** The hand-written scenarios all passed, but a
  randomized test (random writes, splits, heals, loss, duplication and restrictions across 3 to 4
  peers, then everyone must agree on one valid ledger) failed in about half its seeds. Cause: after a
  probe, a peer replied with events from the last shared checkpoint, but the requester asked for more
  starting from its own tip, so it kept receiving the same events and never reached the point where the
  histories split. Fixed by continuing from the last event received and by anchoring probe checkpoints
  at the tip as well as the start. 600 seeds now converge; 40 run in CI on every push.
- **Decision for you (merge vs. winner-takes-branch).** The alternative is an automatic
  merge: take both branches' events, order them canonically, and re-chain them so nothing is
  orphaned. It loses less, but it rewrites event ids, needs duplicate detection by content,
  and drops events that no longer make sense after reordering (for example an award to
  someone removed on the other branch). Winner-takes-branch is simpler and easier to explain
  and audit. Forks should be rare, since normally one Master Looter writes at a time. Current
  choice: winner-takes-branch with orphan review. Say if you would rather have the merge.
- **Decision for you (who may write).** Sync currently accepts any well-formed chain: the
  trusted-officer model, with authorization enforced where events are written. It does not yet
  check at receive time that an author was a raid leader or assistant, because that depends on
  the roster at the time and can't be checked later when catching up. A clean fix is for the
  ledger itself to carry an officers list (an `SetOfficers` event written by the guild leader),
  which every peer can verify from the chain. That is a real design choice, so it is left open.

### Scaling: measured, not guessed (2026-10-28)

Measured with plain Lua 5.4 on a development machine (the game's Lua is slower, so treat these as
best cases). One event is about 280 bytes serialized.

| Ledger size | Append all | Full hash verification | Replay only | Saved size |
|---|---|---|---|---|
| 1,000 events | 0.12 s | 0.07 s | under 1 ms | 270 KB |
| 5,000 events | 0.65 s | 0.34 s | under 1 ms | 1.4 MB |
| 20,000 events | 2.7 s | 1.35 s | 40 ms | 5.6 MB |

- A guild writing about 30 events per raid night, twice a week, produces roughly 3,000 events a year.
  So even years of history stays in the range where verification is quick.
- **At login:** lists up to 2,000 events are fully verified immediately. Larger lists load at once (about
  20 ms for 20,000 events: the rules and linkage are checked and standings rebuilt) and the hashes are
  verified in the background, 100 events per 50 ms tick, so the game never stalls. A list that fails is
  reported and taken out of use; its saved data is left untouched.
- **Hash speed:** byte XOR is table-driven everywhere, 2.4x faster than the first version, and the
  algorithm is locked by golden-value tests so stored ledgers keep verifying.
- **Not solved yet:** SavedVariables size for very long histories (millions of bytes load at game start).
  If a guild ever gets there, the answer is a signed checkpoint that compacts old events into a snapshot.
  That is a design decision for later, not needed now.

## Still open (non-blocking)

- A crisp definition of **"eligible"** for early-resolve (on the relevant
  list(s) + present; how whisper-only users count).
- A **main-or-off single-bid** convenience option (deferred).
- **Per-main identity** and **per-spec off lists** (future layers).

---

## How we got here (process notes)

- We deliberately **planned extensively before writing code** — the manifesto
  and this journal are the "thinking on paper" that precedes Phase 0.
- The plan is phased MVP → full: (0) rationale doc + scaffold, (1) ledger core,
  **(1.5) Client API abstraction + MockClient + test harness + CI**, **(1.6) RealClient + in-game
  contract tests + dungeon field test**, (2) standings UI +
  manual ops, (3) sync, (4) loot session + draft, **(4.5) training / simulation mode**,
  (5) transparency + corrections/trades, (6) external sync, (7) polish.
- Verification leans on **deterministic replay unit checks** (replay a crafted
  event log, assert the standings), multi-engine convergence tests, and
  validating every WoW API call against the exported `docs/api.json`.
