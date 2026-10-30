# King's Gambit — Design Journal

*King's Gambit is derived from the classic Suicide Kings strategy and named for the chess gambit: a deliberate sacrifice of position for advantage. "Suicide" below still means dropping to the bottom after a win, and the player at the bottom is the "salvager".*

*A compressed record of the design conversation behind the SK loot addon: the
decisions we made, the alternatives we weighed, and why we landed where we did.
It exists so the work can be **resumed** without re-deriving everything, and so
the guild can **audit** how each rule came to be.*

**Status:** the engine, sync, loot session, disputes, item fit and simulator are built and tested (427 tests passing); no UI frames yet (the text interface is complete), and nothing has been field-tested in the game. Last updated **2026-10-30**.
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

### The live loot protocol and the text interface (2026-10-28)

`LootNet.lua` carries a loot session between the Master Looter's addon and everyone else's, and
`Commands.lua` is a complete text interface over slash commands, so the whole system can be used (and
field-tested in the game) before any frames exist.

- **Who is believed.** Players only accept a session from the client's reported Master Looter. The host
  applies every bid and draft action through the session's own rules **by the sender's name**, so a
  player can never answer or pick for someone else, and a forged start message from anyone else is
  ignored.
- **Public by design.** Everyone's answers are published to the raid (batched once a second), because
  transparency is how this system is enforced. Whispered answers from players without the addon work
  alongside, and get a plain reply.
- **Acknowledged.** Every bid and action gets a reply saying whether it was recorded and, if not, why
  ("bidding is closed", "it is not your turn", ...).
- **Catching up.** While a session runs, the host repeats its state every 10 seconds (the announcement,
  phase, whose turn it is, and every answer so far). A player who joined late, reloaded or missed the start
  picks it up; a repeat changes nothing for players who already have it. The repeats stop when the
  session ends.
- **Commands.** `standings`, `create`, `add`, `remove`, `move` (a reason is required), `undo`, `loot`,
  `announce`, `resolve`, `extend`, `confirm`, `cancel`, `need|off|pass|gift <n>`, `pick`, `skip`,
  `claim [name]`, `decline`, `sync`, `check`. Only the raid leader or an assistant can change a list when
  in a group, and only the Master Looter can start a session.
- **Verified without the game:** a boot test loads every file in TOC order into a stub WoW environment,
  fires the login event and runs slash commands; protocol tests run a Master Looter, addon users and a
  whisper-only raider over the simulated network.

Known gaps, for later or for you to decide:

- If the Master Looter's game crashes mid-session, the session's progress is lost (it lives in memory). The
  ledger is safe, since nothing is recorded until confirm.
- A session can only be started by the Master Looter. A manual put-up for items that are not in a loot
  window (a BoE, say, or a group with no Master Looter) needs a rule for who may run it.
- The start announcement is repeated rather than retried per player, so on a very lossy connection a player
  may see the session up to ten seconds late.

### Decision: one chain per writer, merged deterministically (2026-10-29)

**Decided by the guild leader.** Parallel raids are a real case: they used to run two raids at once, once a
week, to earn more loot per week. The same character can never be in both raids at the same time (the game
makes that impossible). So awards from the two raids always concern different players, and their effects
commute. Replaces the single-chain "longer chain wins" fork policy, which would fork routinely here.

Requirements and rules:

- **Each writer has their own append-only, hash-chained log.** A single-writer chain can't fork. Standings
  are the replay of all writers' events merged in one deterministic order that every peer computes the
  same way (timestamp, then writer, then position in that writer's chain). The fingerprint of the ledger
  becomes one head per writer.
- **Who may write.** During a raid, **only that raid's Master Looter writes to the ledger.** Officers do not
  write during a raid; they send the Master Looter an **adjustment request** (move a player, undo an
  award, add or remove a member), which the Master Looter accepts or declines. Once the raid is
  **reconciled** (every writer's events from it have been merged and agreed), officers may edit directly.
- **No orphans.** Nothing is set aside or thrown away. An event that arrives late slots into its place and
  the standings are recomputed (replay takes milliseconds).
- **Open details for the design pass:** how a raid is opened and closed, and what "reconciled" means precisely;
  how a writer's right to write is recorded so every peer can verify it (the question previously left
  open as the officers list); what happens to an undo (`Revert`) whose target is displaced by a late event
  from another writer; how the ledger-format spec, audit tool, simulator and Sync lab change.
- **Meanwhile:** live events should also go to the guild channel, not only the raid channel, so the other
  Master Looter sees each award almost at once.

Model note: this is a subtle correctness change, so the rework is done on Opus 5.5 (medium effort), with the
existing randomized convergence tests as the safety net.

### Batching, ranked choice, loot-visible ordering, and Molten Core for training (2026-10-29)

Decided by the guild leader:

- **Same rules whether loot is handed out per boss or at a break.** A session can hold any number of items, so
  a single boss and a whole evening's accumulated loot go through the identical draft.
- **Answers stay up front** (it's what makes a 20-item hand-out quick), **with ranked choice:** a player who
  wants several items ranks them, and on their turn the draft takes their highest-ranked item still available,
  with no prompt. If anything is unranked they are asked live, as before. A whispered answer is ranked in the
  order written ("need 3, need 1" means item 3 first). *Built.*
- **Merge by when the loot became visible, not when it was handed out.** Loot can't be handed out faster than it
  dropped, so ordering by drop time is the fair comparison between two raids, one handing out per boss and one
  batching at a break. Each award will carry `seen` (the loot window's time); the merge sorts by it, never
  earlier than the writer's previous event (so a writer's own events keep their order), and authority is
  checked at the real write time in a two-pass replay. *Agreed; not built yet.*
- **Still to confirm:** batching means the Master Looter takes the loot first and trades it out at the break,
  inside the 2-hour window for trading bound items (to verify in the game).
- **Built 2026-10-29:** merge by loot-visible time (`seen`, sort keys, two-pass replay with authority checked in exact write order). A same-second ordering bug was caught by the sync tests while building it: authority must compare exact write order, not whole seconds.

**Training uses Molten Core.** The simulator and scenarios now use the real raid: ten bosses in kill order, their
real epic drops (item ids, slots, armor and class restrictions, observed drop rates from Wowhead Classic,
collected 2026-10-29 into `simulator/data/mc-raw.json`), and a realistic 40-person Alliance roster whose bots want
what their class and role would want (tier by class; other items by role and armor type; hybrids take the other
role's gear as off-spec). The "who wants what" rules and role tags are deliberate simplifications, kept in one
place (`scripts/build-mc-data.ps1`, `Sim.Wants`) so they are easy to correct. Two numbers are estimates: drops per
kill for Majordomo's cache (Wowhead's cache figures are not per kill) and Ragnaros (3 from observed rates, which
looks low).

### Tokens, readiness, materials, and list scope (2026-10-29)

Prompted by Ahn'Qiraj, whose tier pieces come from **tokens**: class-group restricted, bind on pickup, and
redeemed only with materials and reputation (verified example: Qiraji Bindings of Command plus 2 Idols of Night,
5 Stone Scarabs, 5 Clay Scarabs and Neutral with the Brood of Nozdormu gives the warrior shoulders). Decided by the
guild leader:

- **Tokens are distributed like gear,** under the same rules.
- **Readiness is shown, never enforced.** A token shows what it needs, and the addon checks the player's own bags
  and reputation. Taking a token you can't redeem yet is your call; if it was a mistake, it is fixed like any other
  (a correction, or a gift by trade while the item is still tradeable).
- **Readiness is shared with the raid, as a hint.** Others see each bidder's readiness, but it can't be certain:
  materials kept in the bank aren't visible during a raid. So it shows as "ready", "not ready (from bags)" or
  "says ready" (the player's own declaration), never as a verdict.
- **Materials (idols, scarabs) stay outside the list.** They go to the guild bank; a player holding a token
  requests the materials from it, and an officer or the guild master decides who gets what, in what order. Not
  critical; dedicated players usually buy their own on the auction house.
- **List scope is a guild setting, decided as late as possible.** One list for everything keeps it simple to see
  where you stand, but raids have an intrinsic quality ceiling: once Naxxramas is out, spending your place on Molten
  Core loot is a poor trade, because every Naxx item beats every MC item. So the guild chooses, and can change, between:
  - **one list for all raids** (the default), or
  - **a list per raid** (a new list starts when a new raid is added).
  Which list a raid's loot goes to is recorded in the ledger (an officer sets it while no raid is active), so every
  peer and the audit tool agree, and a change of policy is itself visible.
  **Seeding (decided):** a new raid's list starts as a copy of the current list's order, so "who has waited longest" carries across raids.

**Built (tokens and readiness, 2026-10-29).**
- `AQ40.lua` holds the Temple of Ahn'Qiraj, generated by `scripts/build-aq-data.ps1` from the Wowhead data, with
  every token marked with what it makes and the turn-ins we know. `Tokens.lua` finds a token from an item link, id
  or name, and checks readiness from bags (and the game's bank cache) and reputation, through two new client
  calls, `itemCount` and `reputation`.
- A bid on a token carries the bidder's readiness: their own addon works it out; `need 1 ready` (or a whispered
  `1 need ready`) is the player's own word, for materials the addon can't see. Readiness travels with the bid to
  the Master Looter and out to the raid with the public answers. `ready <item#>` lists who wants a token, in list
  order, with their readiness. Passes and gear carry none.
- Never enforced: the draft ignores readiness completely. A test pins that a bidder who is not ready still wins
  when they are higher on the list.
- Readiness isn't written to the ledger. It's a hint at bid time, not a fact worth keeping forever.
- Ranked choice now travels over the network too (it only worked through whispers and locally before).
- The simulator has an **Ahn'Qiraj night**. Bots are ready, say ready or aren't, in proportions a dedicated guild
  might show. Found along the way and fixed:
  - A seed gave a different night in each new process, because bots were walked with `pairs()`. A test now runs
    the night in two processes and compares.
  - In the browser page, the learner's bid buttons lost the bid kind, and the boss buttons failed.
- **Still provisional:** item role tags (from names; to be replaced from real item stats), what each token makes
  (general knowledge, not yet checked against the quest pages), and turn-in requirements (only the warrior
  shoulders are verified, so readiness is "unknown" for the rest until the quest pages are read). AQ20 waits for
  its remaining bosses.

**Token data from a second source (2026-10-30).** Wowhead throttled us after about a dozen pages per session, so
the turn-in data now comes from the **CMaNGOS classic world database** (github.com/cmangos/classic-db, the open
source 1.12 server emulator, GPL-3.0). `scripts/extract-cmangos.lua` reads the dump (kept outside the repo) and
writes only the AQ facts to `simulator/data/aq-cmangos.json`: every quest that asks for an AQ20 or AQ40 drop, its
materials and rewards, and the items involved with their stats and equip spells.
- Wowhead stays the source for **drop rates**: they are observed in play, the emulator's loot tables are
  partly guessed.
- The two sources were checked against each other. The generator stops if the quest lists collected from Wowhead
  for seven tokens differ from CMaNGOS (they don't), and the hand-verified warrior shoulders match exactly.
- CMaNGOS doesn't record these quests' **reputation** requirement, so it comes from the wiki
  (warcraft.wiki.gg), in `aq-reputation.json`. 14 quests were checked, across five classes. The standing follows the
  slot, not the class:
  - Brood of Nozdormu: Neutral for shoulders and boots, Friendly for head and legs, Honored for chest.
  - Cenarion Circle (AQ20): Honored for rings, Revered for cloaks, Exalted for weapons.
  - None for the Imperial weapons, the Eye of C'Thun and the Head of Ossirian.
- Every token now has a turn-in for every class it is for (45 tier quests, and the open weapon and Eye quests), so
  readiness is known, not "unknown". Materials are matched by **item id**, not name, so a client in another
  language counts them correctly. What a token `makes` is now derived from its rewards' slots.
- **Disputed, left as CMaNGOS has it:** the Imperial Qiraji Armaments and Regalia quests ask for 3 Elementium Ore
  in CMaNGOS and 3 Elementium Ingot on the wiki. To check in game.
- Still provisional: role tags (the item stats are now in the extract; deriving roles from them is next). AQ20
  is not yet a raid module.

### Decision: no dependence on per-raid data; item fit by heuristic, with recorded overrides (2026-10-30)

**Decided by the guild leader.** The addon must not need an update every time new content comes out, so it does
not anticipate raids or dungeons. Focus is on functionality.
- **Item fit is worked out at drop time, from the item itself**, through the game: item class and subclass, armor
  type, slot, class restriction ("Classes: ..."), and stats and equip effects (`GetItemInfoInstant`,
  `GetItemStats`, the tooltip). A heuristic maps these to the classes and specs the item suits. It works for any
  item, including content the addon has never seen.
- **Officers or the guild master can override the fit for an item, durably**, e.g. "this trinket is for tanks
  too". An override is an event in the ledger (who, when, which item, what fit, why), so every peer applies it the
  same way and the change is visible in the history. It is guild-wide and lasts until changed again.
- Fit stays **informational**, as before: it feeds hints (player-toggleable, off by default), the after-the-fact
  camp-watch and the simulator's bots. It never decides who may bid.
- **Raid data modules (Molten Core, AQ40) are training data only**, for the simulator and tests, not something
  the addon needs to work. Token turn-in data becomes optional: where it's present, readiness is checked; where
  it isn't, a token falls back to the player's own word ("says ready"). Class restrictions on tokens are read from
  the item, like any other item.

### Built: the dispute path (2026-10-30)

The ledger already enforced who may write (one Master Looter per raid; officers only outside raids), but nothing in
the interface used it: no command opened a raid, so a Master Looter who wasn't an officer couldn't record anything,
and an officer's edit during a raid failed with a bare "duringraid".
- **Raid authority commands.** `raid open [name] [hours]` (officers; writes Elevate, default 4 hours),
  `raid extend`, `raid revoke [name]` (officers), `raid close` (the Master Looter), `raid` (who is Master Looter,
  for how long), `officers [set ...]` (the guild master). `loot` refuses to start a session its Master Looter
  couldn't record, and says who can open the raid.
- **Requests** (`Requests.lua`). During a raid, anyone, officer or raider, can ask the Master Looter for a change,
  always with a reason: move, undo, add, remove, award (a win that wasn't recorded) and gift (the item went to
  someone else). The Master Looter answers `accept <n>` or `decline <n> <reason>`.
  - **Accepted:** the change is written by the Master Looter, carrying `requestedBy`, the request id and the reason.
  - **Declined:** a `Declined` event, with the reason.
  - **Both are in the ledger**, so the outcome reaches the requester (and the player affected, who is told why
    their place changed) the way every event does. A lost whisper can't lose a decision.
- **Choice made while building it: raiders may send requests, not only officers.** The design only named officers,
  but a raider's dispute ("my need bid was missed") is the commonest conflict, and with this it is raised,
  answered and recorded, instead of argued in chat. The Master Looter still decides.
- **Protections:**
  - The requester's name is the whisper's sender as the game reports it, so it can't be forged.
  - Each player has at most 3 requests waiting at a time.
  - A request is re-sent until acknowledged, and repeats are ignored.
  - Waiting requests survive a /reload.
  - Closing a raid with requests waiting asks first, because once it is closed the Master Looter can't answer
    them.
- **Seen by everyone:** `history [N]` lists recent changes with who made them, why, and at whose request,
  declined requests included. `requests` shows the waiting ones and recent decisions.
- **Undo, as built:** only the Master Looter's own most recent award can be undone directly. If the list has moved
  since, the accept fails and the request stays waiting, so the Master Looter declines it and asks for a move
  instead. The "wrong winner" case is an undo followed by an award.
- **Bug found in the simulator's network** (not in the addon): re-attaching a player after a /reload stepped
  their clock twice per tick, so their messages left "in the future". Fixed; a test reloads a Master Looter
  mid-raid.
- **Tested** (`test_requests.lua`, 14 scenarios over the simulated network):
  - an officer pointed to requests during a raid;
  - an accepted request, a declined one, and the wrong winner put right;
  - an undo that came too late;
  - a gift correction;
  - lossy and duplicated messages;
  - a Master Looter's reload;
  - nobody to ask: no raid, no addon on the other end, or the wrong person;
  - flooding and forged requests;
  - closing a raid with requests waiting, and revoking a Master Looter;
  - two raids at once.
- **Still open:**
  - Officers taken from the game's guild ranks: `officers set` is the manual stand-in until the rank flag is
    checked in game (Nov 4).
  - Requests to an officer when no raid is running: today the requester is told to ask in chat.
  - Requests to other lists, once list scope exists.

### Decision: dependency injection for modules, not load order (2026-10-30)

**Decided by the guild leader.** Modules used to capture each other when their file loaded
(`local Hash = SK.modules.Hash`), so they only worked if the TOC listed them in the right order, and the same
ordered list was kept in four places (two TOCs, the test harness, the simulator build). Some also looked modules up
mid-function, which hid what they depended on.
- `Registry.lua` (loaded first: the only file whose place matters) holds the registry. A module declares what it
  uses, `SK:NewModule("Ledger", { "Hash", "Standings" }, function(d) ... end)`, and receives it from
  `SK:Resolve()`, each module after its own dependencies.
- **A missing dependency or a cycle stops startup with an error that names it**, instead of failing later as a nil.
- **A name ending in "?" is optional.** Raid data is: `Tokens`, `Loot` and `Sim` take `AQ40?` / `MoltenCore?`,
  in line with the decision that the addon must not depend on per-raid data.
- **Resolving happens only in the composition roots:** Core at login, the test harness, the simulator page and
  the audit tool. A test fails if any module reads `SK.modules` itself.
- Runtime objects were already injected through their constructors (`Engine.New(client)`,
  `Requests.New(sync, engine)`, `Commands.New(ctx)`), and stay so.
- **Tested:**
  - the modules load and work in reversed and shuffled order;
  - dependencies are injected first;
  - a missing dependency and a cycle are reported by name;
  - the addon works without the raid data.

### Built: item fit, the class rule, and the guild's item rules (2026-10-30)

**Decided by the guild leader:**
- **Default suggestions are baked in,** from the stats each class spec commonly values.
- **An item that names its classes may only be taken by those classes.** The salvager, the Master Looter and
  the disenchanter are the exceptions.
- **Officers (or the Master Looter) can set, before an item drops, which classes may bid on it,** so there is
  less room for a mistake in the moment.

**Built:**
- **`ItemFit.lua`:**
  - **Stat priorities** for all 27 specs (Druid Feral counts twice, as bear and as cat), each with a role.
  - **Armor and weapon proficiency** at 60, including shields and relics.
  - **Scoring:** a spec's score is the item's stats weighted by that spec's priorities. An item suits the specs
    within 70% of its best score.
  - **Armor of a lighter kind** counts for less, but only for tanks and physical damage. Hybrid casters and
    healers wear lighter armor all the time.
  - **No useful stats** (a trinket with only a use effect): nobody is suggested, and the raid judges it.
- **`client:itemStats(link)`** reads the game's stats (`GetItemStats`), the equip effects and the "Classes:" line
  (from the tooltip). The equip-effect patterns are English for now. The "Classes:" line uses the client's own
  format string and localized class names.
- **The class rule, in the loot session:**
  - Need, off-spec and gift bids on a restricted item are refused for other classes, and a gift can't go to
    them either. A whisperer is told who the item is for.
  - The backstop is not restricted (the salvager may take anything), nor is the disenchant floor (the Master
    Looter or disenchanter).
  - An item the game hasn't cached yet restricts nobody until it is known.
- **The guild's item rules:** a new global ledger event, `ItemClasses` (item id, classes, reason).
  - Set with `eligible <item link or id> <classes|any> <reason>`, and shown with `eligible [item]` and `history`.
  - A rule overrides the item's own "Classes:" line, and it applies even before the game has cached the item.
  - The ledger's usual authority applies: officers outside raids, the Master Looter during their raid.
  - This is the text form of the "UI" asked for; it can move to a panel when the addon has frames.
- **Hints** (`hints on`, off by default) and **`spec <main> [off]`**: an item shows who it suits, and how it
  fits you and your off-spec.
- **Still to do:**
  - ~~Officers' overrides of the *suggestions*~~ (done: `ItemSuits`, below).
  - Spec detection from talents (needs an in-game check).
  - Simulated raiders with a class, main spec and off-spec, deciding from real item stats. The raid data needs
    stats from the CMaNGOS extract for that.

### Built: simulated raiders with specs, deciding from real item stats (2026-10-30)

**Asked by the guild leader:** every simulated character gets a class, a specialization and an off-specialization,
so item affinity is really simulated and tested.
- **The 40-person roster.** Every raider has a class, a main spec (which sets their role) and, for hybrids, an
  off-spec. The learner is a Holy priest, with Shadow as off-spec.

  | Class | Main spec (off-spec), count |
  | --- | --- |
  | Warrior | Protection (Fury) 3, Fury (Protection) 5 |
  | Rogue | Combat 5 |
  | Hunter | Marksmanship 4 |
  | Mage | Frost (Fire) 3, Fire (Frost) 3 |
  | Warlock | Destruction (Affliction) 4 |
  | Priest | Holy (Shadow) 4 plus the learner, Shadow (Holy) 1 |
  | Druid | Restoration (Balance) 2, Feral bear (cat) 1 |
  | Paladin | Holy (Retribution) 3, Retribution (Holy) 1 |

- **Real stats for every raid item.** `scripts/extract-cmangos.lua` now covers the Molten Core drops as well as
  AQ, and converts each item into ItemFit's terms: slot, item class, stats, and equip effects read from their
  spell auras (spell damage by school, healing, hit, crit, mana per 5, attack power, defense, dodge, parry, block).
  - The generators embed this as `fit` in `MoltenCore.lua` and `AQ40.lua`. The extract is now
    `simulator/data/cmangos.json`, no longer AQ-only.
  - Spot checks match the items as players know them: Choker of Enlightenment, Band of Accuria, Onslaught
    Girdle, Robe of Volatile Power.
- **Bots decide from fit.** A raider needs an item that suits their main spec (ItemFit "good"), and takes as
  off-spec one that suits their off-spec. They leave alone items their class can't use, or whose stats aren't for
  them. Only items whose stats say nothing (quest items, use effects) fall back to the old hand-made role tags.
- **The simulated game client is taught each item,** with its slot, stats and named classes, so the loot session
  reads it exactly as it reads a real one, and the class rule applies in the simulator too.
- **Tuning found by listing who wants every item** (a check worth repeating whenever the weights change):
  - **Caster weapons went to melee,** because weapon damage dominated. A weapon whose stats are all for
    spellcasting now counts no weapon damage for anyone.
  - **Ranged weapons went to warriors and rogues.** Melee damage now counts only for melee specs, ranged damage
    for hunters, and wands for casters.
  - **Healer shields went to tanks,** through base armor. Base armor now counts only for bear druids: for
    everyone else it is set by the slot and armor type, which proficiency already covers.
  - **Hunters counted generic attack power twice.** In 1.12 "+X Attack Power" raises melee and ranged attack
    power alike, and CMaNGOS stores it as both, so hunters now value melee attack power at a tenth. The real
    client's tooltip reader treats "+X Attack Power" as both too, so the addon and the simulator agree.
- **Tested:**
  - the roster;
  - two full nights (Molten Core and AQ40) with no wrong-class bids, and every main-spec and off-spec win fitting
    the winner;
  - the class rule refusing a mage on warrior tier;
  - every raid item has stats.
- **Not modeled:** resistance gear (fire resistance for Ragnaros, nature for Huhuran). Those items rank on their
  other stats.

### Decision: item fit is a heuristic, never a list; officers override it (2026-10-30)

**Decided by the guild leader:** who an item suits comes from a heuristic, not a hardcoded list of items, and an
officer can override the heuristic.
- **Override.** A new global ledger event, `ItemSuits` (item, roles, reason; no roles = back to the heuristic),
  set with `suits <item> <roles|auto> <reason>`. Officers set it outside raids, the Master Looter during their
  raid, and it shows in `history`. An item with an override suits exactly the roles named, among the specs that
  can use it. Hints mark it "officer's call". It sits beside `ItemClasses`, which is a rule about who may bid;
  `ItemSuits` is only a suggestion.
- **The hand-made role tags are gone** from the raid data and the simulator. Every item is judged by heuristic:
  - **stats and equip effects**, as before;
  - **use and proc effects**, read from their spell auras (following a proc into the spell it triggers) and
    counted at 30% for uptime. Talisman of Ephemeral Power reads as spell damage; Jom Gabbar as attack power;
  - **what an item becomes:**
    - Tokens are judged by their quest rewards, and quest items by the first rewards along their quest chain.
      Bindings of the Windseeker (Garr and Baron Geddon) and Essence of the Firelord (Ragnaros) are judged as
      Thunderfury, which is no drop itself.
    - Reagents are judged by what is made from them: Eye of Sulfuras and Sulfuron Ingot by Sulfuras and the
      Sulfuron Hammer.
    - A spec counts as suited if it's among the best fits for any one of those things, each measured on its own
      scale. Raw scores of a caster staff and a melee mace can't be compared.
  - **relics** (libram, idol, totem) suit their one class.
- **What the heuristic can't judge** (effects that aren't stats: damage shields, absorbs, threat reduction, a
  summoned tentacle, armor penetration) gets no suggestion. In the simulated guild, its officers have made those
  calls (`simulator/data/officer-calls.json`: seven trinkets). The simulator writes them into its ledger before a
  night, through the same `ItemSuits` events a real officer's command writes.
- **Tuning found along the way:**
  - Attack power usable only in Cat or Bear form (the Blessed Qiraji War Hammer) counts for feral druids only.
  - A weapon made for forms, like a caster weapon, counts no weapon damage for anyone.
  - Base armor on cloaks and jewelry counts for nobody, because it's set by the slot.
- **The simulator page** shows every raider's class (in class colors), main spec and off-spec under their name, in
  the answers and the standings, and marks the bottom of the list as the salvager.
- **The Master Looter is a raider like any other.** In a raid night the learner now starts anywhere on the list,
  like everyone, and moves as they win. Only the training scenarios set their own layout.

### Eligibility follows armor type; raiders can ask to be eligible (2026-10-30)

**Decided by the guild leader:**
- Eligibility comes from a heuristic that is sensitive to armor type and to which classes can wear it.
- A raider can ask to be eligible for an item. If the Master Looter agrees, the item is eligible for that class
  from then on. If they decline, the decline is recorded with a reason.

Prompted by a report from the simulator page: a warlock needed and won Flamewaker Legplates (plate). Fifteen
simulated nights with the current code showed no such bid; the only wins by someone who can't wear an item were
backstop claims, as designed. Most likely the page was built before the fit changes. Either way it was allowed,
because proficiency was only a hint.

- **The rule in the drafts:** need, off-spec and gift bids are refused from a class that can't wear or wield the
  item (`cantequip`), as well as from one the item's "Classes:" line leaves out (`wrongclass`). Gifts to such a
  class are refused too.
  - Armor: cloth for every class; leather for all but priests, mages and warlocks; mail for warriors, paladins,
    hunters and shamans; plate for warriors and paladins.
  - Shields and relics go to the classes that use them, and weapons follow each class's proficiencies.
  - An officer's `eligible` rule overrides all of this: it's a deliberate guild call.
  - Not restricted: the backstop (the salvager may take anything, to sell or disenchant) and the disenchanter.
- **Requests: `request eligible <item, item id or item#> <reason>`.**
  - The requester's class (and spec, for the record) travels with the request.
  - **Accepting** writes the guild's rule for the item: its current classes plus the requester's, with
    `requestedBy` and the reason. It holds until an officer changes it.
  - **Declining** writes a `Declined` event carrying the item, class and reason.
  - **A request that can't be granted is explained, and stays waiting for a decline:** the class can't wear the
    item, the item isn't restricted, or the class is already eligible.
  - A refused bid now points the raider to the request.
- **Why by class, not spec:** spec is part of the record, but eligibility is by class. The game can check a
  class; a spec can't be checked, and can change at any time.
- **Anyone may gift, always (decided by the guild leader).** Gifting is winning an item to hand it on, so what
  matters is who ends up with it. The giver's class doesn't matter (a mage may win plate legs for a warrior), but
  the recipient must be eligible for the item (a warrior can't gift a priest's robe to a mage). Gift is offered for
  every item, on the page and in the text interface.
- **Not offered, rather than refused (asked by the guild leader).** A bot may still try, and the session refuses
  it. But a person isn't offered a bid they can't make:
  - **The simulator page** shows only Pass for such an item, with the reason ("Priests can't wear or wield
    this", or "Not for Priests (for: Warlock)"). For a class-rule item it adds "Make Priests eligible…": the
    learner is the Master Looter, so it writes the rule with their reason, like an accepted request.
  - **The text interface** doesn't send the bid. It says why, and how to ask (`request eligible <item#>
    <reason>`), and the loot announcement marks such items.
  - **Whisperers** get the denial, as before.
  - Once an item is made eligible, its bids are open.
- **Fixed on the way:** in the simulator, item "links" are plain names, so the session never found the item id,
  and the guild's rules weren't applied to simulated drops. A session item now carries its item id (the real
  game's loot link has one, and the simulator passes its own), and rules are looked up by it.

### Decision: King's Gambit is one self-contained folder (2026-10-30)

**Decided by the guild leader:** everything about King's Gambit lives in one folder of the WoW-Addons repository,
with no separate docs folder elsewhere, so it can move to its own repository later.
- `KingsGambit/` now holds the addon (`src/`, with the TOC and Lua files directly in it), `docs/`, `tests/`, `tools/`, `simulator/`, the data and
  build `scripts/`, and the earlier SuicideKings prototype (`archive/`). Every command runs from that folder
  (`lua tests/run.lua`, `lua scripts/build-simulator.lua`).
- The files were moved with `git mv`, so their history follows them. Splitting it out later:
  `git subtree split --prefix=KingsGambit`.
- What stays at the repository root, because it serves every addon:
  - the deploy scripts, which now also find a project whose `src/` folder is the addon (it holds `<Project>.toc`)
    and link it into the game under the project's name, `KingsGambit`;
  - the GitHub workflow (GitHub only reads workflows at the root; it now runs inside `KingsGambit/`);
  - the WoW API reference (`docs/api.json`), which the client code was checked against.
- After pulling this, **re-run the deploy script**: the game's link to the old `src/KingsGambit` no longer points
  anywhere.

### Exercising the simulation: gaps found and closed (2026-10-30)

Sixty simulated nights (30 Molten Core, 30 Ahn'Qiraj, 1,530 items) ran clean: no stuck session, no failed
hand-out, no ledger conflicts, and the same result run after run. Probing the cases a smooth night never produces
found three real gaps, all in how a session treats the raid after it starts (it read the roster once, at the start):
- **A winner who couldn't be handed the item.** A raider who left, went offline or was out of loot range (not a
  candidate for that slot) could still win; the hand-out then failed at confirm and the item sat in the loot window.
  Now the draft and the backstop pass over anyone who can't receive the item (and a gift whose target can't).
- **A leaver held the bidding up.** Early close waited for everyone who was in the raid at the start. Now it counts
  only who is still there, and the session watches roster changes: a turn waiting on someone who left moves on.
- **A late joiner couldn't answer.** Anyone who joins and is on the list (or is enrolled, with `autoEnroll`) is
  admitted when they first answer or when the roster changes.
- A hand-out can still fail at confirm if things change after the draft (the Master Looter loses the role, someone
  else looted the slot). That is reported as before, and still writes nothing to the ledger.
- **Still open:** after such a failure there is no "re-offer this item" step; the Master Looter fixes it by hand.

### Confirmed: item-fit overrides last, with their author (2026-10-30)

**Decided by the guild leader:** the default for who an item suits never depends on a list (it is the heuristic).
When the guild master, an officer or the raid's Master Looter overrides it, the override persists indefinitely and
is attributed to whoever set it.
- This is how `ItemSuits` already worked, and is now pinned by a test: the ledger keeps who set it, when, why and
  which event, with no expiry. A year on, long after a Master Looter's raid authority lapsed, their override still
  holds. A later override replaces it (attributed to its new author); `auto` hands the item back to the heuristic.
  Anyone else's attempt is refused.
- **Changed:** the hint a raider sees now names the author and the reason ("suits: ... (Name's call: reason)"), not
  just "officer's call", so the attribution is visible where the override is used.

### Naming: the salvage round and the salvager (2026-10-30)

**Asked by the guild leader:** the simulator used two terms ("backstop" and "salvager") for what looked like the same
thing. One vocabulary now: the **salvage round** is the stage where items nobody drafted are offered lowest-first
to everyone, and a **salvager** is whoever is offered and claims an item (the player at the bottom of the list is
offered first, and the page tags them). This matches the ledger's existing `Salvage` event, which records what the
salvager did with the item.
- "Backstop" is retired everywhere: the session phase and tier are now `salvage`, and so are the code, the text
  commands, the simulator page, the tests and the docs. Entries above that say "backstop" are the record of what we
  called it then, and are left as written.

### Fixed: the training scenarios used items the game client didn't know (2026-10-30)

**Reported by the guild leader from the simulator page:** in "The first drop", a paladin could bid on the
warrior-only Gauntlets of Might. The class rule was right; the scenarios never reached it. Their items were plain
names, never taught to the simulated game client, so the session saw an unknown item, which restricts nobody. And
the scenario raiders' classes came from a rotation (the "druids" in the off-spec lesson were a priest and a hunter).
- `Sim:drop` now teaches any link that names a known raid item (Molten Core, Ahn'Qiraj) to the client first, with its
  slot, stats and named classes, and passes its item id, so scenario drops are judged like real ones.
- Each scenario raider now has a class that fits the lesson (warriors for the gauntlets, druids for the leather
  legs, a mage for the staff). A test pins both: a paladin is refused on the gauntlets, and no scenario has a
  bidder whose class can't have the item.
- **Principle:** an item the game hasn't described restricts nobody (so a slow cache never blocks a bid), which is
  why anything that stands in for a drop has to describe it.

### Only realistic items can be dropped in the simulation (2026-10-30)

**Asked by the guild leader:** nothing in the simulation should drop an item without a slot; items don't always
have class restrictions, and needn't have stats, though nearly all do. Sampled from the real loot tables
(Molten Core 127 items, Ahn'Qiraj 106):
- **Gear** (216 items) all has an equipment slot and is armor or a weapon. 205 of them have stats; the other 11 are
  trinkets and relics whose whole value is a use or equip effect (Shard of the Flame, Totem of Life, Badge of the
  Swarmguard), which is real. Class restrictions are rare (tier pieces and class tokens), as in the game.
- **17 items genuinely have no equipment slot:** quest items, reagents and tokens (Eye of Sulfuras, Ancient Petrified
  Leaf, the Qiraji Bindings, Imperial Qiraji Armaments). That is what the game reports for them, so they stay, and
  are judged by what they become.
- **What was unrealistic was the free-play mode and the scenarios:** free play used six invented names (no slot,
  stats or class) and bots that bid at random. It now draws 3 items from the real Molten Core table, only gear with a
  slot and stats, for a 7-raider roster with real classes and specs (the learner too), and the bots decide from
  the same fit heuristic as a raid night, so a bid is refused for no one. `Sim.FreePlay` builds it.
- Tests pin all of this: the loot tables' shape (above), every scenario item is a real equippable item with stats,
  and 60 seeds of free play run with no refused bid.
- The mechanics tests still use placeholder names ("X"); they exercise the engine, not the training content.

### Simulator: the Master Looter and the disenchanter are labeled, and are different people (2026-10-30)

**Asked by the guild leader:** label who the disenchanter and the Master Looter are in the simulator. **Added:**
they need not be the same person, and often aren't.
- The page tags both wherever a name appears (standings, answers): "Master Looter" on the learner, "disenchanter"
  on whoever holds that role, and a pending disenchant reads "goes to the disenchanter, <name>".
- Every simulated raid now has a disenchanter who is a **raider, not the Master Looter**: by default the first
  mage, warlock or priest (cloth-wearers, the usual enchanters), otherwise another raider. `Sim.NewRaid` takes
  `disenchanter` to choose. Unwanted loot goes to them, and a test pins that it does.
- The engine already allowed this (`deHandler` in the session config); only the simulator defaulted it to the
  Master Looter, which hid the case.
- Decided next (below): the Master Looter chooses the disenchanter per raid, and loot can't be handed out until they have.

### Decision: the Master Looter designates the disenchanter, per raid, before loot is handed out (2026-10-30)

**Decided by the guild leader:** the disenchanter is a **per-raid choice by the Master Looter**, and **must be designated
before loot can be distributed**. (It need not be the Master Looter, and often isn't.)
- **A ledger event, `SetDisenchanter`** (`raid`, `name`): written only by the raid's Master Looter, while the raid
  is active. The latest choice stands and the Master Looter can change it during the raid. It is recorded and
  synced like any raid authority event, so everyone can see who was chosen, by whom and when, and it appears in
  `history` and the audit tool. Anyone else's attempt is refused by the ledger (`notml`).
- **No designation, no session.** `Session:start` refuses with `nodisenchanter` unless the session was given a
  disenchanter or the Master Looter's raid has one. The `loot` command says what to do (`disenchanter <name>`).
  Items nobody wants go to the designated person, as before.
- **Text interface:** `disenchanter [name]` sets it (Master Looter) or shows who it is.
- **Simulator:** the learner is the Master Looter of an open raid and the simulated raid starts with a raider chosen
  (the first cloth-wearer); the new Roles card lets you pick any raider, which is written to the ledger. It is locked
  while loot is being handed out.
- **Tests:** the ledger refuses a forged designation and agrees across peers; `loot` is refused until one is set;
  the engine refuses a bare session; the simulator records and uses the choice. Most other tests get a default
  disenchanter through the harness, since they are about other rules.
- **Still open:** what happens if the designated disenchanter leaves the raid before the hand-out (today the give
  fails and is reported, like any failed hand-out); requiring the disenchanter to be in the raid when chosen.

### Simulator: a lesson that ran out of time says so (2026-10-30)

**Reported:** "Different from the lesson: no award was recorded" in the simulator. Played through the page's own calls,
the scenario ("A small upgrade nobody will spend a turn on") passes, so the cause is most likely the learner's offer
timing out: the salvage offer lasts 10 seconds (the engine default, suited to a raid), nobody else claims, and the
ring is disenchanted. Changed:
- Training scenarios on the page give the learner's turns 60 seconds (pick and claim), since a person is reading and
  learning. The engine defaults are unchanged.
- That lesson's check now says when the ring went unclaimed and was disenchanted, and what to do, instead of "no
  award was recorded". A test covers it.
- If it recurs with a claim made in time, we have a real bug and need the steps.

### Simulator: choosing who to gift to is a picker, and it works (2026-10-30)

**Asked by the guild leader:** should naming the recipient of a gift be verbal or a UI choice? **A UI choice**: the
learner picks from a list, "nobody" by default, and the text interface keeps `claim <name>` for people who type.
Reports from the page (a pass that wasn't acknowledged; a "Gift to" list that closed as soon as it opened) found real
faults:
- **The page redrew itself four times a second,** which closed an open drop-down and lost the choice. It no longer
  redraws while a list has focus, and releases it once a recipient is chosen, so the clock keeps drawing.
- **The picker starts blank** (no placeholder text), and **the gift can't be confirmed until someone is chosen**: the
  Gift and "Claim and gift" buttons stay disabled, with a hint, instead of silently picking the first raider. It sits before its button ("Gift to: [..] Claim and gift") and lists only raiders who are
  eligible for the item.
- **A chosen answer is unmistakable:** a tick, a filled button, and "Your answer: Pass (you can change it until
  bidding closes)".
- **Engine rule closed:** a salvager's gift is checked like a gift bid. The recipient must be eligible for the item
  (`wrongclassto` / `cantequipto`), whoever the giver is.
- Found while checking in a browser: a string I added broke the page's script. The simulator page can't be checked by
  the test suite, so it was loaded and played in the browser pane (pass, wait for the offer, choose a recipient,
  confirm: "Matches the lesson").

### Fixed: a lesson must not hardcode the learner's choice (2026-10-30)

**Reported:** gifting the ring to Dara in "A small upgrade nobody will spend a turn on" was treated as if it had
gone to Aldric. The lesson text named Aldric and its check required Aldric as the recipient, so any other eligible
raider showed "Different from the lesson". The lesson is that the salvager claims the item at no cost and hands it
up, so **any raider who can use it is a correct recipient**. The check now accepts any of them (naming who it went
to), still checks that no one else's place changed, and says so if the learner kept the ring. The engine already
checks the recipient is eligible. A test gifts to Aldric, Dara and Brann, and to nobody. Lessons where the learner is
only watching (the bots decide) keep their scripted names.

### Simulator wording: verbs agree with "You" (2026-10-30)

The "Will be recorded" panel said "You wins" and "You joins". The page now makes the verb agree ("You win", "Brann
wins", "You join"), names the stage in plain words ("salvage round", "main draft") and says "and give it to Dara"
for a gift. Checked in the browser pane with a gift by the learner and a bot's win. No design change.

### Decision: a gift's recipient is always an explicit choice, and the draft waits for it (2026-10-30)

**Decided by the guild leader**, after the "Gift to" list in the simulator appeared to default to a raider (and a choice
made earlier leaked into the next prompt):
- **A recipient is never defaulted.** Every "Gift to" choice starts blank and is set only by the player. A chosen
  value is used once and cleared.
- **A gift bid may leave the recipient open.** If the bidder wins and still hasn't said, the draft **pauses and waits
  for them**, with no timer. It publishes a note to the raid: "X won item N as a gift and is choosing who gets it."
  Nothing is guessed, and the Master Looter can still cancel the session.
- **When they decide:** they name a recipient (who must be in the raid and eligible for the item), or they **keep it**
  (allowed only if they are eligible for it, or are the salvager: the lowest on the list, who may take anything), or
  they **withdraw**, which counts as a **pass** after a confirmation: the win is undone, they keep their place, and the
  draft goes on without them for that item. A winner who leaves the raid while we wait counts as withdrawn.
- **Built:** `Session:chooseRecipient`, `keepGift`, `withdrawGift` and a `recipient` turn; text commands `gift <n> [name]`,
  `recipient <name>`, `keep`, `withdraw yes`; the simulator's turn card. The ledger is unchanged: an `Award`
  is written only once its recipient is known.
- **Also decided:** in the salvage round the gift is explicit already ("Claim it" or "Claim and gift", disabled until
  someone is chosen).
- **Master Looter override (decided by the guild leader):** if the gifter never says who gets it, the Master Looter may
  override as they see fit. The gifter's win is **downgraded to a pass for that individual**: they keep their place, the
  item goes on to the next bidder, and the ledger records a `Pass` of kind `undecided` (shown in `history` as "won it as
  a gift but didn't say who gets it"), so the failure is visible. It is not an upgrade pass. Built: `Session:overrideGift`,
  the `override` command (Master Looter only, since only their client holds the session), and a confirmed button on the
  simulator's waiting card.
- **Decided by the guild leader: the Master Looter does not pick a recipient on a gifter's behalf.** Held off on
  purpose, to be revisited only if stalled gifts turn out to be a real problem: the system should not give the Master
  Looter much power over individuals' agency. The override only ends the wait, and its outcome (a recorded pass for the
  gifter) is the only thing it can do to them.

### Decisions logged, not yet built: the raid leader, and the loot method (2026-10-30)

**Raised by the guild leader**, to be logged before any design change:
1. **The simulator should let you choose the Master Looter.** The Master Looter is a role like any other (it is an
   official role in the game's raid UI), so the simulation should let you pick who holds it among the raiders
   instead of always making the learner the Master Looter.
2. **Loot must not be distributed until the loot method is set to Master Looter in the raid configuration.** That is
   done by the **raid leader**, a separate role the system must recognise and acknowledge. The game decides who may
   change the loot method; the addon should refuse to run a session until it has been set (the Client already reports
   the loot method and who the Master Looter is).
3. **There is always a raid leader** in every raid, and a **leader in every dungeon group**. The raid leader is not the
   Master Looter, not necessarily an officer and not the guild master. The model should treat the leader as a role that
   always exists (as opposed to the Master Looter and the disenchanter, which have to be chosen).
- **Open design questions, for the design pass:**
  - how the raid leader relates to the ledger's authority (who may open a raid today: officers. May the raid leader,
    if they aren't one?);
  - what the addon does when the loot method is not Master Looter (refuse, or explain how to set it), and when it
    changes mid-session;
  - how the simulator models the leader, the Master Looter and the disenchanter as three roles that may be one,
    two or three people, and lets the learner take any of them or none;
  - whether the Master Looter should be derived from the game's setting (as the loot protocol already does for who is
    believed) rather than chosen again in the ledger.
- Nothing here is built yet. The role cards already show the Master Looter and the disenchanter; the leader is not shown.

### Simulator: a lesson isn't judged before its last step; undo is offered only when there is something to undo (2026-10-30)

**Reported:** in "Fixing a mistake", "Different from the lesson" appeared the moment the staff was handed out, before the
learner could undo it (the check ran at the end of the hand-out, but the lesson's point is the undo that follows).
- A scenario can now say what is still to do (`todo`). Until it is done the page shows "Your turn to fix it" with the
  instruction, and only then judges. The page asks again each time, so the verdict follows the undo.
- **Undo last award** is a Master Looter ability in every scenario and raid night (you can undo your own most recent
  award; the undo is recorded, never erased). It is now offered only when there is an award of yours to undo
  (`canUndo`), not after a hand-out that awarded nothing.
- Tests: the lesson reports its pending step, clears it after the undo, and no finished scenario is left waiting.

### Simulator: every scenario starts paused; buttons act on press (2026-10-30)

**Reported:** the clock started running the moment a scenario loaded, so there was no time to read it, and the Pause
button sometimes needed two presses.
- **Start button.** Every scenario and raid night now loads paused, with the instruction "read the lesson, then press
  Start". The button reads Start, then Pause, then Resume. Nothing (bids, timers) runs until then.
- **The cause of the double press:** the page redraws several times a second, so a button could be replaced between
  the press and the release and never get its click. That would swallow any button, not only Pause. Buttons now act on
  press (a keyboard activation still works through click, and a press followed by its click acts once).
- The sync lab has its own Pause/Run, separate from the loot clock.
- Checked in the browser pane: starts paused with the clock fixed at 0, Start runs it, one press pauses, and a press
  plus its click toggles once.

### Scaling: measured, not guessed (2026-10-28)

Measured with plain Lua 5.4 on a development machine (the game's Lua is slower, so treat these as
best cases). One event is about 280 bytes serialized.

| Ledger size | Append all | Full hash verification | Replay only | Saved size |
|---|---|---|---|---|
| 1,000 events | 0.13 s | 0.07 s | under 1 ms | 270 KB |
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
