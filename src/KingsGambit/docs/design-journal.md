# King's Gambit — Design Journal

*King's Gambit is inspired by the classic Suicide Kings strategy: it keeps what works (one simple rule, earned turns, loot spread evenly) and fixes what does not (useful loot lost to disenchanting) with gifting. It is named for the chess gambit: a deliberate sacrifice of position for advantage. "Suicide" below still means dropping to the bottom after a win, and the player at the bottom is the "salvager".*

*A compressed record of the design conversation behind the SK loot addon: the
decisions we made, the alternatives we weighed, and why we landed where we did.
It exists so the work can be **resumed** without re-deriving everything, and so
the guild can **audit** how each rule came to be.*

**Status:** the engine, sync, loot session, disputes, item fit and simulator are built and tested (570 tests passing, plus the ledger under Lua 5.1 and LuaJIT in CI); no UI frames yet (the text interface is complete), and nothing has been field-tested in the game. Last updated **2026-11-04**.
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
   done by the **raid leader**, a separate role the system must recognize and acknowledge. The game decides who may
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

### Wording: off-spec is bidding, not rolling (2026-10-30)

The off-spec scenario was titled "Off-spec rolls" and didn't say who wins. There is no rolling anywhere (the free
roll was rejected, above). Who wins an off-spec item is deterministic: the first player on the off-spec list with an
off-spec bid. A player's first off-spec bid enrolls them at the bottom of that list, newcomers in main-list order, so
with two newcomers the one higher on the main list is ahead. The scenario is now "Off-spec bids", and its lesson states
this. No rule change.

### Decision (direction): the order newcomers join the off-spec list is a guild-master setting (2026-10-30)

**Raised by the guild leader**, after the off-spec scenario showed that a newcomer's place on the off-spec list comes from their
main-list place: the rule should be **configurable by the guild master**, because both views have merit.
- **For using main-list order:** a higher main-list place suggests more commitment or contribution, so it follows
  that they should have higher status.
- **Against:** someone may simply have dropped to the bottom by winning loot, so main-list rank is not reliably a sign
  of commitment (and winning would then cost them off-spec priority too).
- Like other guild-wide rules, the choice should be **recorded in the ledger** (so every peer and the audit tool agree, and
  a change of policy is itself visible), set by the guild master.
- **Open (to decide before building):** which orders to offer, and the default. Candidates: main-list order (today);
  the order players first bid off-spec; time on the list (when they joined, so winning doesn't cost it). Nothing is
  built yet; current behavior (main-list order) stands until then.

### Decision (direction, supersedes the "options" above): the off-spec list starts from a random seed (2026-10-30)

**Decided by the guild leader**, in answer to which orders the guild master should be able to choose: none of the three.
The off-spec list should not borrow the main list's order at all, because **players at the top of the main list would
otherwise also get an unfair off-spec advantage.** Instead:
- **The off-spec list is created at the very first session (not lazily), with all raiders in a random seed order.**
- **Newcomers after that start at the bottom**, just like the main list.
- **The roll seeds the first list only (decided).** One roll when the list is created; after that it is list order only,
  newcomers at the bottom, and no further rolls (no tie-breaker rolls, no roll per item). The result is kept in the
  ledger as the order the raiders were added in, so every peer and the audit tool replay the same order and nothing
  depends on who ran it.
- This replaces today's behavior (lazy enrollment, newcomers ordered by main-list place), and revisits the earlier
  rejection of a "free roll" for loot, which was about a costless roll over scarce items, not about seeding an order.
- **Built (off-spec list):** created at the first session with all raiders present, shuffled; newcomers at the bottom.
  The list is written at confirm, with the awards.

### Decision: the main list is created the same way, and the two lists are independent random orders (2026-10-30)

**Raised by the guild leader:** how the main list is created had not been established, and it should follow similar
rules; **the main list and the off-spec list must be unique random orders on initialization.**
- **Main list:** when the first session starts and the list has no members, everyone present is added in a random
  order (the roll, recorded as the order of the `AddMember` events). Anyone who comes later goes to the bottom, as
  already happens. A guild that wants to hand-build its list can still use `create` and `add` before the first session:
  the seed applies only to an empty list.
- **Independent:** the off-spec list is shuffled separately, not copied from the main list. If a draw happens to match
  the main order exactly, it is redrawn (a few tries), so the two start as different orders.
- **Scenarios** that teach a specific layout still set their own lists; raid nights seed from their seed.
- **Built:** `Session:refreshRoster` seeds an empty main list at the first session (a shuffle from the client's random
  source, `Loot.Shuffle`); the off-spec list is seeded and redrawn if it matches the main order; both are the order of the
  `AddMember` events in the ledger. List creation moved out of the "will be recorded" awards into `enrollments`
  (written first at confirm), and the page shows one line for it instead of one per raider.
- **Tests:** seeding differs by seed and the ledger holds the order; a hand-built list is left alone and latecomers go to
  the bottom; the off list never equals the main order across 30 seeds of a 3-raider raid; the off-spec scenario checks
  the real seeded order (three seeds in the browser: different orders, ahead-of-the-other bidder wins).
- **Settled:** only raiders present at the first session are seeded (see the guild-roster proposal below, not adopted).

### Proposal: create both lists from the guild roster before the first raid (2026-10-30)

**Proposed by the guild leader** (tentatively: "we could perhaps"): instead of seeding the lists from whoever is present at
the first session, create them **from the guild roster, before the first raid starts.** That settles the open question
about absent members (everyone on the roster is on both lists from the start) and means the first session never has to
create anything.
- **Same rules as decided:** each list is its own random order, and anyone who joins the guild/list later goes to the
  bottom, no further rolls. The roll is still recorded in the ledger as the order of the `AddMember` events.
- **Who sets it up:** a one-time action by the guild master (or an officer) before the first raid, e.g. `lists init`, written
  to the ledger; the first-session seeding stays only as a fallback for a guild that never ran it.
- **Open questions:** whether every guild member is on the list (a guild roster includes alts, casuals and
  inactive members, who would sit at random places in the order); how an officer trims it (remove after, exclude at
  init, or choose by rank); and the Client's guild roster currently reports name, class and online status but **not
  rank**, so any rank filter needs a small Client extension.
- **Decided by the guild leader: not adopted.** Both lists are seeded from **whoever is present at the first raid**, as
  built. It is the fairest rule: people who have never raided should not get priority over someone who has. Members
  who were absent at the first raid join the bottom of each list when they first attend, like any newcomer. This also
  closes the open question above about absent members, and the guild roster (and the Client's missing rank field) is not
  needed for list creation.

### Decision: the salvage round offers from the bottom of the live list, as is (2026-10-30)

**Raised by the guild leader** from the simulator: in an Ahn'Qiraj night, the winner of the Hammer (who had just dropped to the
bottom) was also offered the Wristguards first in the salvage round, after everyone passed on them.
- **Decided: leave it.** The salvage round stays lowest-first on the live list, including players who won earlier in
  the same hand-out. Reasoning: if everyone passed, the item was legitimately of no interest to anyone, so who gets to
  decide its fate hardly matters; and a rule that depended on a "session" would push guilds to hand out in tiny sessions
  (one or two items) just to make the salvager rotate. Loot may be held until the end of the raid or a break and handed
  out in one batch, so no rule may depend on how loot was batched.
- **Finding (not a bug in the draft, but contrary to the premise):** the salvager does **not** rotate within a batch.
  Claiming moves a player to the bottom, which is where the lowest player already is, so the same player is offered every
  leftover first (checked: four leftover items, everyone willing, one player gets all four). Rotation only happens
  across batches, as other players' wins push people below them. If the intent is that "whoever is salvager doesn't get
  to be salvager for everything", that needs a rule: see the open question below.
- **Decided by the guild leader (after playing out a 10-item batch):** keep the priority draft and ranked choice, and **rotate
  the leftovers**: within a salvage round, a player who claims an item goes to the back of the queue for the remaining
  items. The round still starts lowest-first on the live list; in the example (items 5 and 7 passed by everyone), item 5
  goes to the lowest player and item 7 to the next one down, without any rule about how the loot was batched.
  Considered and not chosen: resolving strictly in drop order (each unwanted item to whoever is lowest at that
  moment), which would replace the priority draft and ranked choice and make drop order matter, the "arbitrary order
  advantage" the draft was designed to avoid.
- **Built:** `Session.offerQueue`: the round starts from the live list, lowest first; a claimer (including one who gifts
  it on) moves to the back for the remaining items; a decliner keeps their place. Tests: four willing claimers get four
  different leftovers; a decliner stays first in line; and the shape of a long batch (two wins, then two passed items go
  to the latest winner and the one before).

### Simulator: a scenario for the big hand-out (2026-10-30)

**Asked by the guild leader**, because the rotation could confuse people: ranked choice determines the draft order, and the
salvagers rotate as the leftovers are handed out. "A big hand-out: ranked choice, then the salvagers rotate":
- **Ten real Molten Core items** held until a break, eight raiders with classes who rank what they want, and four items
  nobody wants (interleaved with the contested ones). Six players win through ranked choice (first on the list takes
  their first choice and drops; Dara gets her helm once the gauntlets are gone; Eira and Hale lose out because what they
  ranked was taken). The four leftovers go to four **different** salvagers: Garo, Fenn, Dara, Cass, the last four winners,
  latest first.
- The learner has nothing to decide: pass on everything, Start, confirm. The point is to watch.
- The lesson is three numbered steps (ranking, the draft, the salvagers); the page now keeps line breaks in lessons.
- The scenario's check reads the ledger (who won what, and how) and runs under five other seeds in a test, since the
  lesson is about the rules, not luck. `RunScenario` also accepts a learner class now.

### Simulator wording: "Request eligibility", and what happens after a salvage claim (2026-10-30)

**Asked by the guild leader:** the button for an item your class can't bid on said "Make Warlocks eligible", which reads
as a demand. It now says **"Request eligibility"** (and the prompt asks why you are asking), since it is an ask to the
Master Looter, as `request eligible` already is in the text interface. In the simulator the learner is the Master
Looter, so the request is granted at once and recorded with their reason, like an accepted request; the button's hover
text says so.
- **After a salvage claim:** the item is yours. It is handed to you when the Master Looter confirms, and recorded as
  your win (it moves you to the bottom, where the salvager already is). Nothing new pops up: no follow-up asks what you
  did with it.
- **Gap found:** the ledger has a `Salvage` event (keep, gift, sell, disenchant or bank: what the claimer did with it,
  for transparency only), but nothing in the commands or the simulator writes it. **Open:** whether to offer an optional
  "what did you do with it?" note after a salvage claim.

### Decision: unwanted items are salvaged as the draft executes, one per pick (2026-10-30)

**Clarified by the guild leader**, from the big hand-out scenario, where Garo (the *last* winner) got the first unwanted item.
The expectation: **Aldric** (the first pick) gets the Heavy Dark Iron Ring as the first salvager, **Brann** (the second
pick) the Quick Strike Ring as the second, and so on: *salvagers rotate in the order of the draft.*
- **Why my first build was wrong:** it ran the whole salvage round after the draft ended, so the lowest player was the
  last winner, and the queue went last-winner-first. The intended model is **interleaved**: every pick drops its winner to
  the bottom, which makes them the lowest player *at that moment*, so the next unwanted item is offered to them first
  (lowest-first is unchanged; it is just applied while the draft runs, as in the guild leader's 10-item example).
- **The rule:** during the main draft, after each pick (and after a gift's recipient is settled), the next unwanted item
  (no bids of any kind, taken in item order) is offered lowest-first on the live list: normally the player who just
  picked. If they decline it goes up the list; if everyone declines it is disenchanted. Unwanted items left after the
  draft ends (more unwanted items than picks) go through the end-of-draft salvage round, where a claimer still goes to
  the back of the queue, as already built.
- **Unchanged:** the priority draft, ranked choice, and no dependence on how the loot was batched.
- **Built:** a pick sets `owedSalvage`; the draft loop settles it first (`offerLeftover`), pausing the draft on a claim
  offer and resuming when it is settled (`afterSalvageItem`). Whoever salvaged during the draft goes to the back of the
  end-of-draft queue, so nobody takes an unwanted item twice in a row. The big hand-out now gives Aldric, Brann, Cass
  and Dara the four unwanted items, as expected. Tests: the pick-by-pick offer, a decline going up the list and a
  full decline disenchanting while the draft carries on, more unwanted items than picks, and a pending gift delaying
  the offer until its recipient is settled.
- **Supersedes** the earlier "rotate the leftovers" build, whose queue started from the last winner.
- **A property worth keeping (the guild leader's framing):** treat salvage as just another drop to the bottom of the list. Because
  the salvager is the player who just picked (already at the bottom), claiming changes nothing, so **the list returns to the
  order in which the main items were won**: after the big hand-out it ends Eira, Hale, You (untouched, in their old order),
  then Aldric, Brann, Cass, Dara, Fenn, Garo (the picks in draft order). A test pins it on five seeds. It holds whenever
  each unwanted item is salvaged by the player who just picked; in the overflow case (more unwanted items than picks)
  the end-of-draft claims move other players to the bottom after the winners, by design.

### The principle behind the salvager, stated by the guild leader (2026-10-30)

**Why the last person on the list is the salvager:** when they "suicide" (drop to the bottom) they can go no further down,
so **they sacrifice no position.** Claiming an unwanted item is free only for the player at the bottom; anyone higher
who claims drops below the people beneath them, so it costs them a place.
- **Consistent with what is built:** in the draft, whoever has just picked is at the bottom, so offering the next unwanted
  item to them costs nothing and leaves the order unchanged. A player who declines passes the offer up the list, to someone
  who would pay a place to take it.
- **A tension to watch:** in the end-of-draft round (more unwanted items than picks) the rotation puts the bottom
  player *last* in the queue after they have claimed, so later items are offered first to players who would have to give up
  a place to accept them. Many will decline, so such overflow items tend to end up disenchanted. Rotation is fairer to
  everyone but is not free for the people it reaches. **Open:** whether the overflow round should let the bottom player keep
  first call (free, but not rotating) or keep the rotation as built.

### Decision: the overflow round is pure suicide, with no rotation (2026-10-30)

**Decided by the guild leader**, on the tension noted above: for unwanted items left after the draft, **pure suicide is fine.**
Whenever you get an item while you are at the bottom, you stay at the bottom until someone wants something; that
salvager may persist over several items, and "they get lucky that nobody wants so many items."
- **Removed:** the "claimer goes to the back of the queue" rotation, and the back-of-queue treatment of players who
  salvaged during the draft. Items left after the draft are offered lowest-first on the live list, each time.
- **Kept:** the salvage that happens as the draft executes (each pick is followed by the next unwanted item, offered to
  the player who just picked), which is what makes the salvagers follow the order of the draft.
- **Net effect:** the earlier "rotate the leftovers" and "overflow tension" entries above are superseded. A player who
  declines is passed over and a claimer lower down than the bottom pays for it by dropping below the people who
  declined; the lowest player keeps first call. Tests updated: no picks to interleave with gives one player all the items
  and moves nobody; a decline lets the next player pay a place; and more unwanted items than picks all go to the player who
  just picked.

### Simulator: a scenario for the lucky salvager (2026-10-30)

**Asked by the guild leader**, so the overflow rule is clear: "Nobody wants most of it: the lucky salvager". Six real items, only two
wanted (the gauntlets by Aldric, the blade by Brann), four unwanted.
- **As the draft goes:** Aldric picks, drops to the bottom, and is offered the first unwanted item (the Heavy Dark Iron
  Ring); Brann picks, drops, and is offered the next (the Quick Strike Ring). Claiming at the bottom costs nothing.
- **After the draft:** two unwanted items remain with no picks left to hand them out with. They are plain suicide:
  the lowest player, Brann, is offered them and takes both, still at the bottom afterward. Lucky, since nobody wanted
  so much. Nobody else's place moves; the list ends ... Aldric, Brann.
- The lesson is two numbered steps; a test runs it on five seeds and checks who took what. In the page, the pending list
  reads Aldric twice and Brann four times, which is the point.

### Fixed: the simulator page was broken by a quote mismatch (2026-10-30)

**Reported:** "the html seems broken": the page stopped at "Starting the engine...". The "Request eligibility" wording change
left a JavaScript string opened with `'` and closed with `"`, a syntax error that stops the whole page script. It went in
with that commit and was pushed. The engine and its `KG` API are Lua and run separately from the page's JavaScript, so the
checks made through the API afterwards kept passing while the page itself was dead; only a look at the real page
showed it. Fixed, and every scenario was then clicked through in the browser pane with the console watched
(no errors; the Request eligibility button appears where a class can't bid). Practice from now on: after any
page-template edit, load the built page and read the console, not only the API.

### Decision: undo asks for confirmation; no general redo (2026-10-30)

**Question from the guild leader:** should there be a redo in addition to undo? **Decided: not now; undo asks first.**
- **Why no general redo:** the ledger is append-only and fix-forward, so an undo is already its own recorded event; a redo
  would add back-and-forth to the record for little gain, undo only restores the list (the item was already handed
  out), and redo gets ambiguous once anything else has moved. If an undo was a mistake, the award can be recorded again
  in the normal way (the winner lands at the bottom: the true cost of winning now).
- **Built:** `undo` now says what it would undo ("C won X") and does nothing until `undo yes`; the simulator's button asks
  with a confirmation first. Declining changes nothing.
- **Kept as an option for later:** a narrow redo, allowed only straight after your own undo and before anything else is
  written, as its own event restoring the award exactly where it was (the same limit undo has). Worth adding only if misclicks
  prove to be a real problem for guilds.

### Simulator: the scenarios run from simple to nuanced (2026-10-30)

**Asked by the guild leader:** put the Molten Core and Ahn'Qiraj nights at the end of the list, so the page starts simple and
progresses to the more nuanced parts of loot management. The page now opens on the first scenario (it used to open on the
Molten Core night), and the order is a teaching order:
1. The first drop (one item, one winner)  2. Two items, one player who wants both (ranking)  3. Off-spec bids (the second
list)  4. Nobody wants it (disenchant)  5. A small upgrade nobody will spend their rank on (salvage and gifting)  6. Gifting an
item to a friend  7. Fixing a mistake (undo)  8. The lucky salvager  9. A big hand-out  then the two full raid nights.
A test pins the start, the end, and that unwanted items come before salvaging them.

### Decisions for building the raid leader role and the Master Looter requirement (2026-10-30)

**Asked by the guild leader:** implement the raid leader role and the requirement to establish a Master Looter, with the
addon assisting where the game's API allows. The game provides `C_PartyInfo.GetLootMethod`, `C_PartyInfo.SetLootMethod(method,
[lootMaster])` (returns success), `C_PartyInfo.IsLootMethodAvailable` and `GetAvailableLootMethods`, and `UnitIsGroupLeader` /
`UnitIsGroupAssistant`. Defaults chosen for the open questions logged earlier (all easy to change):
- **The raid leader is read from the game, never the ledger.** There is always one (in a raid, and a leader in every
  dungeon group). New Client call `leader()`. The leader is shown wherever roles are shown. **The ledger's authority is not
  changed:** officers (and the guild master) still open raids and name their Master Looter; the leader is a game role, not
  an addon authority. (A guild's raid leader will normally be an officer; if not, an officer opens the raid.)
- **The requirement:** a loot session starts only when **(1) the loot method is Master Looter and (2) the player starting it is
  the named Master Looter.** Otherwise it is refused with a plain reason that names the raid leader, who is the one who can
  fix it. This is enforced in `Session:start`, so no front end (text commands, the simulator, a future UI) can bypass it.
- **Addon assist:** `masterloot [name]` for the raid leader sets the loot method to Master Looter with the named
  Master Looter (default: themselves) through `C_PartyInfo.SetLootMethod`, after checking `IsLootMethodAvailable`. It never
  changes the setting on its own, only on that command. A player who isn't the leader is told who is, and to ask them.
  The addon says when the loot method changes (and to whom).
- **If the loot method or Master Looter changes during a session, the session is cancelled** and everyone is told. Nothing
  has been written to the ledger before confirm, so nothing is lost but the answers; they restart once it is fixed.
- **A mismatch to surface, not enforce:** the raid the ledger has open (an officer's `raid open`) names a Master Looter; if
  the game's Master Looter is someone else, `raid` says so, since only the ledger's Master Looter may write.
- **Simulator:** the Roles card shows the **raid leader**, the **loot method** and the **Master Looter**, and each can be
  changed. You can pick another raider as Master Looter; then a bot Master Looter runs and confirms the loot and you play a
  raider, so both seats can be learned. Loot is not handed out until the loot method is Master Looter, and the page says
  why. When you are not the raid leader, setting the loot method means asking them, as in the game.

### Fixed: a gift's recipient was wiped by a repeated press (2026-10-30)

**Reported:** after gifting the first drop to Brann, the answer read "gift → undefined". Pressing Gift with Brann chosen recorded it
correctly, but the page cleared the chosen recipient as soon as it was used, so any second press (a double click, a slow click)
sent a gift with no recipient and overwrote the answer; and a blank recipient was printed as "undefined".
- A recipient you chose now **stays chosen until the question changes**: it is cleared when the phase or the turn changes (so it
  never leaks into the next question, and never defaults to a raider), but not by pressing the button again.
- A gift with no recipient yet reads "gift → (to be chosen)".
- Verified in the real page: Brann chosen, Gift pressed twice, the answer and the Answers table both read Brann.
- Not reproduced: one earlier run of the page refused every warrior as a gift recipient ("can't wear or wield it") with only the
  priest listed; a fresh start and a rebuilt page gave the right recipients each time. Worth watching.

### Decision: an unwanted item goes to the salvager, who decides; no second round of offers (2026-10-30)

**Clarified by the guild leader**, reading the "Nobody wants it" lesson, which said the item was offered up the list again after
everyone passed: **when nobody wants something, it goes to the salvager, not bottom-up through everyone. The salvager decides; there
is no further round of bidding.**
- **The rule:** an unwanted item is offered to **one** player, the salvager (the lowest on the list at that moment, normally the
  player who just picked). They decide: **claim it** (keep it, or gift it on, as before) or **decline it**, and then it goes to the
  disenchanter. It is never offered to the next player up.
- **Replaces:** the cascade ("declined, so the next lowest player is asked, and so on until everyone declined"). Everything
  else is unchanged: the interleaving with the draft, that the salvager follows the order of the draft, and that in the
  end-of-draft round the lowest player may take several items.
- **Consistent with the principle:** the salvager is the one player for whom claiming is free; nobody higher up is asked to
  give up a place for an item nobody wanted.
- The "Nobody wants it" lesson, the page's decline button, the text prompts and the rationale were reworded to match.

### Simulator: the History is the ledger, in full (2026-10-30)

**Asked by the guild leader:** the history should be a more verbose representation of the ledger. It used to show only list events since
the scenario began, one terse line each ("Brann joined the list"). It now shows **every event in the ledger**, in write order, each with
its kind, what it says in plain words, when (since the ledger began), **who wrote it**, and its **id**:
- Founding and setup (Genesis, the lists created, who was added in what order, the Master Looter's raid, the disenchanter chosen), the
  awards ("won X on the main list and dropped to the bottom"; "the item went to Y" for a gift), passes, disenchants, and rules
  and overrides set on items.
- An undo says what it undid ("The award of X to Brann was undone, and they went back up the list"), found from the event it targets.
- Consecutive "added to the list" events are grouped into one row listing the order, since a 40-raider night would otherwise
  bury everything. Only the latest 40 rows show, with a count of earlier ones, because the page redraws as the clock runs.
- Ties within a second are ordered by each writer's own sequence number (the true write order), so the ledger is founded
  before its lists are created.

### Built: the raid leader and the Master Looter requirement (2026-10-30)

Following the decisions logged above (these supersede the "not built yet" notes in the earlier entry):
- **Client:** `leader()` (the raid's rank-2 member) and `setLootMethod(method, looter)` (the game's `C_PartyInfo.SetLootMethod`, after
  `IsLootMethodAvailable`; refused unless this player is the leader). The mock models the same refusals.
- **The requirement, in `Session:start`:** `notmasterloot` unless the loot method is Master Looter, and `notml` unless the starter is the
  named Master Looter. Enforced at the session level, so every front end is covered. If either changes during a session (even in the review
  step) the session is **cancelled** with reason `lootmethod` and nothing is recorded; an unrelated roster change does not cancel it.
- **Addon assist (text):** `loot` says what is missing and who can fix it (naming the raid leader); `masterloot [name]` lets the leader set it
  through the game's API (never on its own); `raid` shows the leader, the loot method and Master Looter, and warns when the game's
  Master Looter differs from the ledger's open raid; a change of loot method is announced. The ledger's authority is unchanged.
- **Simulator:** the Roles card now has **Raid leader**, **Loot method**, **Master Looter** and the disenchanter. A bot is the leader by
  default; if you are not the leader the loot-method button reads "Ask <leader>" and they do it. The Master Looter is **a setup
  choice** because their addon runs the session: pick a raider and restart, and that bot's client hosts the loot (the ledger shows entries
  written by them), confirms it itself, and you play a raider, with the Master Looter's controls hidden. With the method not Master Looter,
  a boss still dies but the loot is **held, not lost**, and is handed out once the leader sets it again.
- Found while building: restructuring the page's script once deleted six functions between two edit points (caught at once by loading
  the page and reading the console); the committed copy was used to restore them.
- **Not done:** lessons that expect you as Master Looter (for example the salvager scenarios) will say "different from the lesson" when
  another raider is the Master Looter; the request-eligibility button is auto-granted by the bot Master Looter.

### Decision: the name stays King's Gambit (2026-10-30)

**Raised by the guild leader:** a quest named "The King's Gambit" exists in the game; should the system be called "Queen's Gambit"?
**Decided: no, it stays King's Gambit.**
- A quest title is game content, not an addon identifier: it does not conflict with the addon's folder, slash command or
  saved data. (The quest itself was not looked up.)
- The name keeps the pun on **Suicide Kings**, which the system derives from, and the **meaning**: the King's Gambit is the
  opening where a pawn is deliberately sacrificed for position, which is what dropping to the bottom to win loot is. The
  Queen's Gambit is a gambit mostly in name, since the pawn is usually regained, and has no tie to Suicide Kings.
- If findability ever matters, a subtitle (for example "King's Gambit: a transparent loot ledger") is cheaper than a rename,
  which would touch the folder, TOC, saved variables, slash command, docs and tests.

### Decision: gifts come after off-spec; the salvager can't override an off-spec bid with a gift (2026-10-30)

**Raised by the guild leader** as an edge case: at the bottom of the list you can bid to **gift** as a main bid for an item that others bid
off-spec on, and win it, because gift bids competed in the main tier by the gifter's own position (the bottom player pays nothing).
**Decided:** off-spec is prioritized over gifting. The salvager shouldn't be able to override off-spec.
- **Need still beats off-spec:** a main (need) bid, including the bottom player's, still gets the item for themselves ahead of off-spec.
- **A gift is not a want, it is a proxy,** so it does not outrank anyone who wants the item. The draft order is now: **main (need), then
  off-spec, then gifts**, then the salvage of items nobody wanted. Previously gifts sat inside the main tier.
- **A gift still costs its position:** the gifter wins at their own place on the main list (the gift tier runs in main-list order) and drops
  to the bottom. For a gift where nobody else wants the item, nothing changes: the minor-upgrade proxy still works. It only stops a
  gift from preempting an item someone wanted for off-spec.
- Supersedes the earlier line "Gift bids compete in the main tier at the gifter's own position". Everything else about gifts is
  unchanged (the recipient must be eligible; an open recipient makes the draft wait; the override and the pass).
- **Built:** a third draft tier, `gift`, after `main` and `off` (phases: bidding, main, off, gift, salvage). `main` takes need
  bids only. Tests pin it: an off-spec bid beats a gift from the bottom of the list; need beats a gift whatever the positions and
  still beats off-spec; a gift alone works as before. In the simulator the same bids as the report now give the item to the
  off-spec bidder and never prompt for a recipient. Also fixed: an open gift showed "You -> undefined" in the item row; it now
  says it is choosing who gets it, and the new phase has its own label.

### Published: the simulator is on GitHub Pages (2026-10-30)

**Asked by the guild leader:** let someone other than the author play with the simulator, ideally running the same Lua engine.
- **Where:** <https://atraeau.github.io/WoW-Addons/kings-gambit/>. The repository already serves `docs/` on Pages, so the build now also
  writes the page to `docs/kings-gambit/index.html`. (If the folder later moves to its own repository, the build takes a folder
  to publish into.) The hand-written API browser links to it.
- **The same engine:** the page inlines the addon's real source (all the modules) and runs it on fengari, a Lua 5.3 VM in
  JavaScript. Same files, different VM from the game's Lua 5.1 variant and from the tests' 5.4.
- **Vendored, not fetched:** fengari-web 0.1.4 is kept in `simulator/vendor/` (verified byte-for-byte against the integrity hash the
  page used to pin) and inlined, so the page needs no CDN and no network: loaded over HTTP, the browser makes one request, for
  the page itself. The page grew from 360 to about 575 KB.
- **Credits** are in a footer: fengari (MIT), the CMaNGOS classic database (GPL-3.0) for item stats, Wowhead Classic for observed
  drop rates, and a note that it is a training simulation not affiliated with Blizzard.
- **Kept current by CI:** the existing "simulator page is up to date" check now covers the published copy as well.
- **Not done yet:** a Node syntax check of the page's JavaScript in CI (it would have caught the two breakages of the page's
  script that happened by hand); and a CI step that publishes automatically. The browser pane can no longer open the file directly
  (it loads files as data URLs and the page is now too large), so it is tested over local HTTP.

### Mistakes: an audit, and what the Master Looter needs to put one right (2026-10-30)

**Asked by the guild leader:** test exhaustively the cases where people make mistakes; the addon must handle each one
gracefully, and the process must be fair and straightforward for the Master Looter. Then, specifically: *the Master
Looter needs a way to award an item to the correct recipient after the fact, once the mistake is acknowledged, and that
recipient moves to the bottom of the list as if they had won the bid.*

**What exists (read from the code):** answers can be changed until bidding closes; a pick is final; nothing is written
until `confirm`, so `cancel` throws a whole session away without touching the list; after `confirm`, `undo` reverses the
writer's own most recent award; officers and raiders ask through `request`; `move`, `add`, `remove` all need a reason.

**Gaps found, to be closed one by one (each gets tests):**
1. **No direct `award`.** The Master Looter can only *record* an award through a session. If a hand-out failed ("give it
   manually"), or the item went to the wrong person, there is no way to record the real winner except asking someone
   else to send a request, and a request to yourself is refused ("make the change directly"). Decided: a Master Looter
   (or an officer outside a raid) can `award <name> <item> <reason>`. It is an ordinary `Award` event: the recipient
   drops to the bottom exactly as if they had won the bid, and the reason and the writer are in the record.
2. **Undo is only for the very last award.** A session hands out several items; if the first was wrong, the Master
   Looter would have to undo everything after it and re-enter it. Under test; the aim is to undo one named award
   without disturbing the others, giving the same list as if it had never been awarded.
3. **Confirm does not re-check write authority.** If the raid expires or the Master Looter is revoked mid-session, the
   items could be handed over (`give`) and then fail to record. Under test.
4. **`move` and `remove` do not say where the player was**, so a mistaken one cannot be put back by hand.

**Decision (guild leader): a correction must not replay history.** In a big bulk session, items are already in
people's bags; asking for "undo everything after the wrong one, then re-award it all" is not tenable. So gap 2 is
solved by undoing *one named award*, leaving every later award exactly where it is, and the list ends up as if that one
award had never happened. How (kept deterministic, since every peer must agree): the winner goes back just above the
highest-placed of the players who were below them when they won, *or who have won since* (those are at the bottom now
and would be below them anyway); and the later awards' own "who was below me" notes forget the winner where they
were above them originally. One rule keeps it exact: if the same player won something *later*, undo that later one
first (their place would otherwise be wrong); the reply says so. Tested against a plain replay of the other awards.

**Built, with tests (`tests/test_mistakes.lua`, plus the ledger tests):**
- **`award <name> <item> <reason>`** (Master Looter during a raid; officers outside one; others are pointed to
  `request award`). An ordinary `Award`: the recipient drops to the bottom as if they had won the bid. A name that is
  not on the list is explained (add them first). The failed-hand-out message now points to it.
- **`undo [name] [yes]`** undoes the named player's latest award of yours, leaving later awards alone; with no name it is
  your latest. It says what it would do and asks first; with a name it cannot undo it lists what it can. Requests
  (`request undo`) use the same rule. The refusal reasons are plain ("that player won something later: undo that
  later award first"). A property test checks 300 random sessions: undoing any one award equals replaying the others.
- **`confirm` checks the right to write before handing anything over.** If the raid ended or the Master Looter was
  revoked mid-session, nothing is given or recorded, the session stays in review, and the message says what to do
  (an officer reopens the raid; the same session then confirms). It used to hand the items over first.
- **`move` and `remove` say where the player was** and how to put them back (`move X <place> <reason>`, `add X <place>`).
  `remove` now takes an optional reason.
- **Checked and already fine:** a changed answer counts until bidding closes, a late one is explained; `cancel`
  writes nothing and the loot can be run again; a second `confirm` records nothing; a failed hand-out is never recorded;
  a Master Looter's reload mid-session loses only the unconfirmed session.
- **Fixed on the way:** a failure with no item (the off-spec list entry) crashed the `confirm` message.

**Not done, deliberately:** a wrong *gift* recipient is still fixed with `request gift`, which moves nobody (the winner
already paid). Whether a regret-trade to someone who had bid should instead send the recipient to the bottom is the
earlier "bid-test" idea; it needs a decision from the guild leader before it is built.

### Decision: a trade after the fact is a regret-trade by default; a gift is explicit (2026-10-30)

**Decided by the guild leader:** a *gift* must be explicit (the session already has the UI for it: gift, then name the
recipient). When an item turns out to have gone to someone else after the award, the default reading is a **regret-trade**:
the original winner's position is **restored** and the **recipient moves to the bottom**, as if the recipient had won the
bid. This closes the "bid-test" question left open above (it is no longer about whether the recipient had bid).
- **Trade** (the default correction): `trade <name> <to> <reason>` for the Master Looter, `request trade ...` for
  everyone else. It undoes the named award (the same rule as `undo`) and records the same item as won by the recipient.
  It is refused as a whole, changing nothing, if either half would fail (the recipient is not on the list, or the
  award can no longer be undone), so it never leaves the list half-corrected.
- **Built:** one ledger entry, not two: `Award` carries `replaces = <earlier award>`, so it is atomic on every peer
  and reads as a single line in the history ("Cass took Gauntlets, which had been recorded for Brann (Brann restored)").
  The undo rule is the same as `undo`'s (so a later win by the first winner blocks it until undone). Tests: the ledger
  rule and its refusals, the `trade` command and its explanations, and `request trade` against `request gift`
  (gift moves nobody).
- **Gift** stays what it was: `request gift` records that the item went elsewhere *by the winner's choice* and moves
  nobody. It is the explicit, deliberate case.

### Simulator: the Master Looter's corrections, as controls (2026-10-30)

The simulator page now has a **Corrections (Master Looter)** card, shown to the learner when they are the Master Looter
and nothing is mid-session. One row per award of theirs, latest first:
- **Undo this** (one named award; later awards stay; disabled, with the reason, if that player won something later).
- **It went to: [player] + Regret-trade** (the winner is restored, the recipient pays) or **It was a gift** (records
  where it went, nobody moves). Both ask for a reason, which goes in the record.
- **Record a win the session didn't** (who, which item, reason): the plain `award`.
The old "Undo last award" button stays for the simple lesson. Refusals are in plain words (the same reasons as the
commands). When a bot is the Master Looter the card is hidden: the learner would ask through a request, which the
simulator does not model yet. Checked in the browser (a trade, an award and an undo gave the standings the engine
tests expect); the engine rules themselves are the tested part (`test_ledger`, `test_mistakes`).

### Simulator: a scenario for the regret-trade (2026-10-30)

New scenario, "The item went to someone else", right after "Fixing a mistake": Brann and Dara both need the warrior
gloves, Brann wins and is handed them, then Brann says he traded them to Dara at the door. The lesson draws the line
between a regret-trade (Dara wanted them: Brann restored, Dara pays) and a gift (deliberate: nobody moves). It judges the
final list, not the route: the regret-trade in one step passes, so does undo then "Record a win" (the note says which was
used), a gift or a bare undo get a plain hint saying what is wrong, and a wrong try that was then put right is not held
against the learner. Tested for all five routes; played in the page, gift first and then the trade. Ten scenarios now.

### Decision: an earlier award can be undone even if its winner won again later (2026-10-31)

Found by thinking through a regret-trade after a big hand-out. In a draft the first pickers are also the
salvagers, so one player holds two awards in a row (the pick, then the leftover they claimed). Until now undoing
the first was refused (`laterwin`), which would have left the Master Looter stuck: "Aldric traded his gauntlets
to Hale" could not be fixed without taking the hand-out apart.

It is safe to allow, and the rule is simple: the later win already dropped that player to the bottom, so with or
without the earlier win they stand in the same place. Undoing the earlier one therefore **moves nobody**; it only
takes one win off the count, and everyone who was passed over by it is unaffected. What has to be kept right is the
bookkeeping a later undo needs: the later win inherits "who was below me" from the undone one (so undoing both,
in either order, puts the player back where they started), and the saved win counts of the later entries drop by
one. Entries made after the player's later win are untouched (the list is the same either way from there).

Also decided (the guild leader): **a gift only needs its destination to be eligible.** The gifter needs no
eligibility for the item. A rule limiting gifters to items they could use themselves was considered and dropped.

Checked the way the rest of undo is: a random-session test against a replay without the award, now with repeated
winners and chains of undo and regret-trade.

The simulator's old "Undo last award" button goes. The Corrections card undoes any one award, so one place does
it, and the lesson "Fixing a mistake" points there. A new lesson for the regret-trade after a draft follows.

### Decision: default eligibility needs stats that help the class, not only the ability to equip it (2026-10-31)

**Decided by the guild leader**, after seeing a warlock offered the Brutality Blade: a warlock can wield a sword, but
it has nothing on it for them. The default for who may bid ("can they wear or wield it", from the earlier decision on
armor type) now also asks whether the item's stats help the class.

- **The check** (`ItemFit.Worthwhile`, used by `MayHave`): a class is eligible by default when some spec of it
  scores at least 15% of the best spec's score for the item (`ItemFit.USEFUL`). That is deliberately well below the
  "ok" rating (35%), which ranks suggestions: this only keeps out a class the stats are nothing to. A warrior in
  mail boots or a mage with a tank's stamina cloak is a poor fit but not a pointless one, and stays eligible.
- **Where it doesn't apply:** an item the heuristic can't judge (no stats it values: a use-effect trinket), an item
  with an officer's suggestion (`ItemSuits` is a suggestion, as decided before), and any item with a guild rule
  (`eligible`): a deliberate guild call decides on its own. The salvager and the disenchanter are still not
  restricted.
- **Same rule for bids and gifts:** need, off-spec, and a gift's recipient. New refusal `nostats` / `nostatsto`
  (in plain words: "its stats don't help your class").
- **Asking still works:** `request eligible` is offered for it (the page too). Accepting writes the rule as the
  classes the item helps plus the requester, not "everyone who can wield it", so a warlock's request doesn't also
  open the sword to a mage.
- **Tuning is one number.** If the threshold lets in or keeps out the wrong classes in a real raid, change
  `USEFUL`; the stats and the weights per spec are the heuristic's, as before.

### Simulator: the regret-trade after a big hand-out (2026-10-31)

The single-drop lesson is easy: the winner goes back up, the recipient drops. After a draft the standings are harder,
and this lesson (the last one, after the big hand-out) is built to meet that. Brann's blade was traded to Hale, who got
nothing in the draft (he only wanted the blade). Brann is also the second salvager, so he holds a second award, the
Quick Strike Ring, after the blade, and the draft went on after him.

- The right answer: Brann does not move (the ring already put him at the bottom), Hale drops to the bottom, nobody
  else moves, and the draft is not replayed. The lesson says so, and why Brann seems not to move.
- It is judged on the list at the end, like the earlier lessons: a gift (nobody moves), a bare undo (Hale unpaid), the
  one-step regret-trade and undo-then-award are all told apart, and a wrong try that is put right is not held against
  the learner. Undoing the wrong row (the ring) doesn't pass.
- Tested at the engine level with random sessions that include repeat winners and chains of undo and trade.
- The simulator's old "Undo last award" button is gone; the Corrections card does it (any award), so there is one place.
- The learner is told which row to use ("Brann's Brutality Blade, not the ring"). A harder version could let them find
  it themselves; for now the lesson is about the standings, not hunting for the row.

### Built: CI plays the simulator page, and a push to main publishes it (2026-10-31)

Asked for by the guild leader: fixes should deploy live without anyone running the build by hand, and the page's
JavaScript, which no test covered, should be checked.

- **`tests` workflow, three jobs.**
  - `lua`: the engine's tests, as before. On a pull request it still fails if the committed simulator page is stale.
  - `page`: builds the page from the sources, parses every JavaScript script in it (`scripts/check-simulator.mjs`,
    which catches a quote mismatch like the one we once shipped), and plays every lesson in headless Chromium
    (`simulator/test/smoke.mjs`, with the driver in `smoke-driver.js`). The driver passes on everything, goes to the
    confirm button, and finishes the three "fix a mistake" lessons with the Corrections card, which must then match.
    It runs unchanged in the browser pane, which is how it was written and checked.
  - `publish` (a push to main only, after both pass): rebuilds the page and, if the committed copies
    (`simulator/index.html`, `docs/kings-gambit/index.html`) differ, commits them as `github-actions[bot]` with
    `[skip ci]`, pushes, and asks GitHub Pages for a build (a push with the workflow's own token doesn't start one by itself).
- **What this means day to day:** change the engine or the template, push; if the built page wasn't rebuilt locally,
  CI rebuilds and commits it, and the live page follows. The commit the bot adds sits on top of yours, so
  `git pull` before the next push. Pull requests never publish.
- **Not changed:** Pages still serves `docs/` on main (a settings change to "deploy from Actions" wasn't needed).
- **Limits:** the smoke test plays each lesson as a learner who passes on everything, so it proves the pages work and the
  fixes can be applied, not that every lesson's "right answer" is reachable by a person (the engine tests judge that).

### Simulator: asking a bot Master Looter, the phone layout, and a note for the salvager (2026-10-31)

Three loose ends closed together.

- **Requests when a bot is the Master Looter.** Until now the Corrections card was hidden when a bot held the role, and
  the page had no way to show what a raider can do about a wrong result. A raider can't write to the ledger; they ask.
  The new card, "Ask the Master Looter", lists each player's latest standing award with three asks: undo it, a
  regret-trade (who it went to), or "it was a gift". Each takes a reason. The bot Master Looter answers at once with
  the real rules (`Requests.EventFor`): what can be done is written as the Master Looter's entry, naming the
  requester and the reason (the history shows "at the request of You"); what can't is declined, and the decline, with
  its reason, is in the ledger. It is `Sim:ask`, so it is tested like the rest (accepted, declined, nothing changes on a
  decline). The bot always accepts what is possible: a bot that declines for judgment is a later extra, not needed for
  the mechanics. `Requests` joined the simulator's engine modules.
- **Phone layout.** On a 375px screen the page overflowed sideways: the middle grid column grew to the width of the
  answers table, so every card was 740px wide. Grid children now have `min-width: 0` and cards scroll sideways if
  something inside is wider (the answers table), so the page itself no longer scrolls. Checked in the browser pane at
  phone size; not on a physical phone.
- **Salvage note.** The `Salvage` ledger entry (what the salvager did with it: keep, gift, sell, disenchant, bank) had
  nobody to write it. The Master Looter now can: `salvaged <name> <action>` notes it against that player's latest
  standing award; nobody moves, and it shows in the history. It is for transparency only. The salvager can't write to
  the ledger themselves (only the Master Looter does during a raid); a request kind for it can come later if guilds
  want the salvager to say it themselves.
- The browser smoke test plays the bot-Master-Looter flow too.

### Fixed: the live simulator page did not start, and CI could not see it (2026-11-01)

Reported by the guild leader: the published page showed "The engine did not start". The browser console had Lua
syntax errors "near <eof>" from both embedded scripts.

- **Cause.** The page's Lua was in `<script type="application/lua">`, which fengari-web runs the moment the element
  is inserted into the page. A browser builds that element while the download is still arriving, so on a real
  connection it can run a script that has only part of its text. Opening the file locally delivers all of it at once,
  so it worked there. It grew likelier as the page grew (635 KB now). Reproduced by feeding the live page to the
  browser in 60 KB pieces: the same two errors.
- **Why CI passed.** The smoke test opened the page from a local file, the one way it can't fail. That is a gap in
  the test I wrote, and the journal entry above that called the page "played in CI" overstated what it proved.
- **Fix.** The Lua now sits in inert `text/x-kg-lua` scripts, and a classic script right after them loads both with
  `fengari.load`. A classic script runs only once everything above it has been parsed, so the text is whole. A load
  error is shown on the page ("The engine did not start" plus the error), not only in the console.
- **Test.** CI's smoke test now serves the page over HTTP in 40 KB pieces with gaps, like a slow connection, and plays every
  lesson that way, and also opens the local file. Checked by hand against both the old page (fails the same way as live)
  and the new one (starts, 14 lessons and nights play, no errors) in the browser pane.
- **Lesson for the publish job.** It deploys whatever passes CI, so CI has to test the way the page is really served.
  After a publish, the live URL itself is worth a look.

### Fixed: "Undo this" did nothing where the browser's own dialogs aren't shown (2026-11-01)

Reported by the guild leader: in "Fixing a mistake" the Undo this button did not work. It asked "Undo this award?"
with the browser's `confirm()`. Where native dialogs aren't shown (an embedded browser such as the app's pane, or a
page with dialogs blocked) `confirm()` answers "no" at once, so the press was silently dropped. The same went for
every action that asks for a reason with `prompt()` (regret-trade, gift, award, the raider's asks, the eligibility
request) and for "stop waiting" / "give up this gift". Reproduced with a real click in the pane: nothing happened;
with `confirm` stubbed to yes it worked.

- **Fix.** The page has its own confirm and prompt, a small dialog in the page (`ask`): Enter or the button accepts,
  Escape or Cancel doesn't, and a reason can't be empty. No native dialog is left in the template.
- **Test.** The smoke driver now makes `confirm` and `prompt` answer "no" and drives the page's dialog instead, so any
  future native dialog fails the lesson. This is the check that was missing: the earlier driver stubbed the dialogs to
  "yes", which hid the problem. Checked in the pane with real clicks.

### Simulator: the sync lab says what each control does, and tests itself (2026-11-01)

Asked for by the guild leader: it wasn't clear what "split" or the "lost" and "duplicated" percentages meant, or what to do
to see that the sync works.

- **Every control is explained where it sits**, in words that don't assume the sync's vocabulary:
  - **Split** became "Cut Aldric off" and "Cut in half": players only hear their own side, and every message across the line is
    discarded (the page now says so). **Reconnect** doesn't replay lost messages; players notice what's missing at their next
    heartbeat and ask.
  - **Lost** became "Thrown away" (None / 1 in 5 / 2 in 5): that share of all messages is destroyed in transit.
    **Duplicated** became "Delivered twice" (Never / Half of them): a repeat must change nothing.
  - **Restrict** became **Mute**: the player's addon can't send (as in a boss fight), what they write waits in a queue.
  - **+ member / + award** became "Add a raider" / "Award an item", each with a tooltip saying it writes one entry at that
    player only, until the network carries it. The figures line says what each number is. A short glossary covers ledger,
    fingerprint, own chain, heartbeat and muted.
- **A verdict banner says whether everyone has the same ledger**, and when not, why: the split, who is muted, the loss rate,
  or "still on their way". It also says what will fix it.
- **Checks: run a test.** Five buttons (split and reconnect, lose 2 in 5, deliver half twice, mute then unmute, a late player)
  each reset the lab, do a fixed set of the things above, let the clock run and report each expectation with a tick or a cross
  and the numbers (events per player, seconds to converge, messages really lost or duplicated). They judge by the same rule as
  the banner: same fingerprint everywhere and nothing waiting to send. The checks are in `api.lua` (`lab_check`), so they
  drive the same engines the buttons do.
- **Guarded in CI:** the smoke driver opens the lab, runs all five and fails the build if any doesn't pass.

### Decision: src/<Addon> is everything, AddOns/<Addon> is what the client loads, and every push can be a release (2026-11-01)

**Decided by the guild leader**, after we considered splitting King's Gambit into its own repository (a submodule) and
set that aside as more pain than it is worth for now: it can still be split later if the repository gets unwieldy.

- **Layout.** `src/<Addon>/` holds all of an addon's files, game or not: code, tests, the simulator, docs, tools. King's
  Gambit moved from the top level to `src/KingsGambit/` (its game files stay in its own `src/`, named by a `build.lua`
  with `root = "src"`). The build output is `AddOns/<Addon>/`, mirroring the game's `Interface/AddOns` folder, and is
  gitignored.
- **What ships is worked out, not listed** (`scripts/build-addons.lua`, written in Lua so it runs on a dev machine and in CI
  alike): the TOC files, every file they list, following XML `<Script>` and `<Include>`, assets the code names by their
  `Interface\AddOns\<Addon>\` path, a license beside the TOC, and whatever `build.lua` adds. Files are copied byte for byte,
  so an in-game error names the same file and line as the source. It reports a Lua file no TOC loads (probably forgotten)
  and an asset the code names that isn't there, and fails on a listed file that is missing. `--check` also verifies the output
  is exactly the plan, that every TOC has an Interface and a Title line, and that no `tests`, `docs`, `simulator`, `tools`
  or `scripts` folder shipped. A fixture test pins these rules (`scripts/test-build-addons.lua`).
- **Training stays in the game** (the guild leader): the same situations will be run with the real UI and the real APIs, and
  the API abstractions exist in game on purpose, so the simulation code (`Sim`, `Scenarios`, `MockClient`, `SimNetwork`,
  the raid data) keeps shipping. This is one more reason the TOC, not a folder, decides what ships.
- **Deploying.** `scripts/deploy.ps1` (and `.sh`) build first, then junction `AddOns/<Addon>` into the game. The loop is
  edit, rebuild, `/reload`; `-Watch` rebuilds an addon when one of its files changes. Edits are no longer visible the
  instant they are saved: that is the cost of a folder that holds only what the client expects.
- **Releases from every push.** CI (`tests.yml`) builds every addon, checks it, and keeps the zips on the run. On a push to `main`,
  after the tests pass, `release` publishes a GitHub pre-release `<Addon>-v<version>` per addon with `<Addon>-<version>.zip`
  (the addon folder at the top: what CurseForge takes). The version is the TOC's `## Version:` plus the run number
  (`0.0.1.57`); the TOC in the zip is stamped with it, the source TOC is not. A release is made only when the **shipped files**
  changed: CI hashes the built folder and compares it with the hash in the addon's latest release notes, so a change to tests,
  docs or the simulator publishes nothing. The newest 30 releases per addon are kept; older ones are deleted with their tags.
  An addon opts out of releases with `release = false` in its `build.lua`: the example and dev-tool addons (HelloForever, WowApiExport,
  BTPCompatCheck) do. Uploading to CurseForge itself is still by hand: it needs a project id and an API token, which we don't have yet.

### Decision: versions: a build number for people, protocol numbers for compatibility (2026-11-01)

*Superseded the same day by the Semantic Versioning decision below, for the two protocol integers (`Sync.PROTOCOL`, `LootNet.PROTOCOL`): they
are gone. The addon reporting its TOC version, the heartbeat carrying it, `/gambit version` and the "announce, don't act" idea stay.*

Raised by the guild leader: with a release from every push, players will run different builds and the addon talks to
other players, so it needs versioning. What existed was a ledger format number on every event (`v = 2`, a mismatch is rejected)
and nothing else: no build version was read or sent, and a client that couldn't read another's messages said nothing.

- **Three numbers, three jobs.** The **addon build** (the stamped TOC version) is for people. The **ledger format** (`v`)
  is what an entry means. The **protocols** (`Sync.PROTOCOL`, `LootNet.PROTOCOL`, both 1) are what the addon messages mean.
  Builds change every push; the others rarely, and only for a change an older client can't live with. Adding an optional
  field to a message changes none of them.
- **The client reports the build** (`client:addonVersion()`, from `GetAddOnMetadata`; `"dev"` when running from source). It is part
  of the client contract, so every client has it.
- **Sync heartbeats carry `p` (protocol) and `a` (build).** A peer on another protocol is announced once ("X runs a King's
  Gambit this one can't talk to") and ignored: nothing is requested from them, so neither side acts on messages it
  may misread. A newer build is announced once ("a new version is available"). No `p` means a heartbeat from before the field:
  protocol 1, so existing installs keep working.
- **The loot session start carries `p`.** A raider whose addon speaks another loot protocol ignores the session and is told why, rather
  than answering questions it may not understand.
- **`/gambit version`** shows this build, the three numbers, and each other player seen with how their build compares
  (same, newer, older, can't compare, incompatible).
- **First release, checked 2026-11-01:** KingsGambit-v0.0.1.84 and WowBagSorter-v3.0.84 were published by CI (the dev tools opted out). The
  KingsGambit zip holds the `KingsGambit` folder with the 25 files its TOCs load and `## Version: 0.0.1.84` stamped in.
- **Not decided yet:** what to do about a ledger format change (`v = 3`). Today a different `v` is rejected, which is safe
  but means two builds can't share a ledger; a migration plan is needed before the first such change.

### Decision: Semantic Versioning, and compatibility by line, not by exact version (2026-11-02)

**Decided by the guild leader:** the addon uses Semantic Versioning, players advertise their version, and a client is required to update
only for changes that break ledger compatibility, following the SemVer standard, not because it differs in any way from the
others. (This replaces the two protocol numbers of the previous decision, which would have drifted from the version people see.)

- **The version is SemVer.** `## Version: 0.1.0` in the TOC (it was `0.0.1`; this is the first real line). CI stamps `+<run>` as build
  metadata (`0.1.0+84`), which SemVer says never affects precedence, so continuous builds of one version are "the same version". The
  build tool fails King's Gambit's build if the TOC version isn't SemVer (`semver = true` in its `build.lua`). Release zips are
  named `KingsGambit-0.1.0_84.zip` (a `+` is awkward in a file name); the release tag keeps it.
- **A line, not an exact match.** Two clients work together exactly when they share `MAJOR`, or `MAJOR.MINOR` while `MAJOR` is 0. The
  reason for the 0.x rule: SemVer item 4 says anything may change in 0.y.z, so for a ledger MINOR has to be the breaking step until 1.0.
  Within a line the versions may differ freely; a newer MINOR/PATCH on the same line is announced once as an optional update.
  `Version.lua` (pure Lua) implements the SemVer 2.0.0 parsing and precedence, including pre-release ordering, and is tested against
  the examples in the spec.
- **What counts as breaking for a ledger is stricter than for most software.** An older client rejects an event type or message it
  doesn't know, and its standings then silently differ, so *adding* an event type or a message is a breaking change here, not a
  compatible feature. Bug fixes, UI, new commands and optional message fields older clients ignore are compatible.
- **Enforced by a test, not memory.** `tests/compat_baseline.lua` records the ledger-facing surface (ledger format, event types,
  request kinds, message types found in the source) and the line; `tests/test_compat.lua` fails with the exact additions and removals
  when the code drifts, and checks the TOC version is valid SemVer on the recorded line. Changing the surface forces a choice: new line
  (bump the TOC and the baseline's `line`) or an explicit statement that it is compatible. What an existing event *does* isn't visible
  to it and still needs the same decision by hand. Checked by temporarily removing entries from the baseline: the failure lists them.
- **Advertised on every message.** `Sync:post` stamps the sender's version (`a`) on every addon message, so even the first event a player
  pushes can be judged: a test found that judging only heartbeats let a client on another line be heard for the first second.
  A player on another line is announced once with who must update, and their messages are dropped. The exception: the loot session start
  also reaches `LootNet` so a raider is told the Master Looter's version can't be used. A version that can't be read (a development copy, the
  four-part `0.0.1.84` built before this decision) is let through; the ledger's own checks still apply.
- **Not decided:** migration. A different ledger format `v` is still rejected outright; nothing converts old entries when a new line
  changes the format. That needs a plan before the first change to `v` itself.

### Decision: ledger migration: immutable history, a schema for every published event, upcast on read, a signed cutover (2026-11-02)

**Asked for by the guild leader:** a migration strategy for the ledger, with a simulated breaking change to test it against, and
(added while we were designing it) *a data structure for every published ledger event type, so that any ledger can be migrated no matter
how old it has become.*

**What is hard here.** The ledger is append-only and hash-chained, written by many players, merged deterministically, and replayed in full
into the standings. Rewriting old entries would break every hash and the tamper-evidence that is the point of the ledger, and players
update at different times. So history can never be rewritten, and no one can be asked to switch at one instant.

**The strategy (expand, cut over, contract).**
1. **History is never rewritten.** Every event keeps the format (`v`) it was written in. Chains, hashes and authors stay exactly as they
   were, so a ledger written years ago still verifies.
2. **Upcast on read.** A release that changes the format carries a pure function per old format that maps an old event to the next
   format's equivalent (`Migrations.upcast[f]`: event of format f -> event of format f+1, never mutating the stored one). Replaying an old
   ledger runs every event through the chain of upcasters, so the *current* code can read *any* old ledger. An upcaster must make the old
   meaning explicit where the new rules would differ (for example, a default that changed becomes an explicit value), so past outcomes
   are never re-decided: nobody's place moves because the rules changed.
3. **A schema for every published event type, per format, frozen once published** (`Schemas.lua`): the fields, their types, which are
   required. It is the record of what every event ever looked like, so an old ledger can always be validated, and it drives the checks
   below. Changing a published (format, type) schema is refused by a test; the way to change an event is a new format and an upcaster.
4. **A golden ledger for every published format** (`tests/ledgers/`): a real saved ledger covering every event type, with the standings it
   must replay to. Every release's code must load it, verify it, and replay it to the same standings, forever. This corpus is the actual proof
   that "any ledger, however old" still works; a test also checks each upcaster maps every event type of its format to a valid event of the next.
5. **Expand: a bridge release reads both formats and keeps writing the old one.** It is compatible with the line it sits on (see
   Semantic Versioning), so players update on their own schedule. Heartbeats advertise which formats a client can read, so the guild
   master can see who is ready (`migrate status`).
6. **Cut over: the guild master writes a `Migrate` entry** (authority event, guild master only): `{ from, to, cut, digest, reason }`.
   `cut` names exactly how many events of each chain are before the change, so which events are old and which new is the same on every
   machine whatever order they arrive in (a vector cut, not a timestamp). `digest` is the standings those events produce, as the guild
   master's client computes them. Every client replays the cut under its own code and checks it gets the same digest: that is the migration
   proving itself on every machine. A client that gets a different answer refuses to write and says so. After the cut, events must be in the
   new format; an event still in the old format after the cut is recorded as a conflict ("stale format": its writer needs to update), not
   silently applied. The first new-format event anyone sees is the `Migrate` entry itself, so an unprepared client learns that the
   ledger has moved on the moment it arrives ("this ledger moved to format 3: update").
7. **Contract (later):** once nobody writes the old format, a signed checkpoint can let a future release drop old upcasters. Not built:
   the golden corpus means we only do it deliberately.

**Writing.** A client writes in the ledger's *current* format (taken from the last `Migrate`), never in the newest it knows, so a bridge
release never writes something an old client can't read before the guild master says so.

**Versions.** The `Migrate` machinery is itself a change to the ledger's surface (a new event type, readable formats), so it ships once as
a new line (0.2.0). After that a breaking change to the *data* needs no line bump on its own: the bridge release is compatible with its line,
and the cutover is a ledger decision, not a download. What changes the requirement for players is the guild master's cutover, and only
for clients that can't read the new format.

**What building it showed.**
- The digest covers the whole public record, not just the order: orders, wins, passes, awards and where an undo would put each winner back. A first version
  hashed only order and wins, and a wrong upcaster's effect was hidden by a later move in one random guild. A migration is only as well tested as its corpus,
  so the evaluation always includes the one case this change breaks (a member added with no position by the old release), placed where nothing can mask it.
- A digest proves *this* ledger's history reproduces, not that an upcaster is right in general; the golden ledger covers every event type and the upcaster tests cover
  the rest. Both are needed.
- Events written in the old format after the cutover (by someone who has not updated) are recorded, not applied, on every new client identically, and recovered
  deterministically when that player updates. A write made at the same moment as the cutover loses; it is visible, not lost silently.
- The evaluation has teeth: removing the digest check, breaking the cut, or recording a wrong digest each makes it fail (tested).

**The simulated breaking change** (a test fixture, never shipped): a hypothetical format 3 with a structural change (Award's `member` and
`to` become `winner` and `recipient`) and a semantic one (a new member with no stated position goes to the top, not the bottom). It is used
to score the strategy: history preserved, digests agree, convergence under loss and reordering, old clients told rather than corrupted,
stale writes recorded, a deliberately wrong upcaster caught by the digest. See `tests/test_migration.lua`.

### Decision: the ledger format is one whole number, separate from the addon's Semantic Version (2026-11-02)

Asked by the guild leader (who leaned to a single number): should the ledger's format version be Semantic Versioning too, or one number? **One whole
number (`v`), independent of the addon version.** Reasons:

- **It answers a different question.** The addon's SemVer says which *players* may work together (a line). The format says whether *this build can read this event*:
  membership in the set of formats a build reads (`2`, `3`), not a range or a precedence. A bridge release adds a readable format without changing its line.
- **Ledger events have no compatible-change class today.** An older reader rejects an event type it doesn't know, so there is no safe "MINOR" for the data: every change is a
  new format, an upcaster and a cutover. A second number would always be 0.
- **It is hashed into every event.** Keeping it a plain integer keeps every old id valid, and `Schemas`/`Migrations` key on it directly.
- **Compatible additions are handled where they actually happen:** an added optional field is a deliberate edit of the frozen schema baseline (a reviewed change with its
  hash), not a number.
- **What would change this:** a mechanism for old readers to *skip* informational event types safely (an "ignorable" marker on the event). Then a compatible
  additive class exists and a minor revision would mean something. Not built; we would revisit then.

Files for each published format's golden ledger are named with an underscore, `tests/ledgers/format_2.lua` (generated once by `make_format_2.lua`).

### Simulator: the migration lab (2026-11-02)

Asked for by the guild leader: a way to try the migration strategy in the simulator. A third tab, **Migration lab**, next to the loot session and the sync lab.

- **An interactive world:** five real engines on a simulated network. GM (guild master) and two raiders run the new release, which can read formats 2 and 3 and writes the
  ledger's current format; Off (an officer) and Eira are still on the old release. Buttons write entries at the guild master and the officer (a new member with no position, an
  award), move the ledger to format 3 (the cutover), update an old player, and let a client with a wrong conversion join. Every player card shows its release, the ledger
  format it sees, its standings, and what it was told or recorded (checked the digest, told to update, frozen, stale entries). A verdict banner says what is true now and what to
  try next. Each control says what it does, as in the sync lab.
- **A scored evaluation:** "Run the evaluation" runs a whole migration on a separate guild (random history, the cutover, writes after it, a wrong client, the updates) and lists
  every check with a tick or a cross. "Run it over 8 random guilds" does it eight times, half on a network that drops and repeats messages. "Prove the evaluation can fail" breaks
  the strategy three ways on purpose and checks the scoring notices each. In a browser: one guild ~1 s, eight ~11 s, the three breaks ~5 s.
- **One implementation, two uses:** the simulated format 3, the evaluation, the three breaks and the interactive world are one pure-Lua file, `simulator/src/migration_lab.lua`. The tests
  load it (`tests/test_migration.lua`) and the page embeds it, so what a person clicks is exactly what CI runs. It is development-only: the build embeds it in the page and it is not one of
  the addon's modules, so it never ships in the game.
- **A fix after first use:** the "Move the ledger to format 3" button was reported as always disabled. It is disabled only once the ledger has moved (a ledger moves once) or while a check
  runs, but it gave no reason, and the way back (Reset) was hidden in another section. It now says "Already moved to format 3" with a note, Reset sits beside the verdict, and a check that
  fails can no longer leave the lab stuck busy.
- **Guarded in CI:** the smoke driver walks a cutover with the buttons, expects the wrong client to freeze, and requires the evaluation and the "can it fail" check to pass.

### Decision: a character is identified by first and last name, not Name-Realm (2026-11-02)

**Decided by the guild leader:** WoW: Forever has no realms. A character has a first and a last name, the pair is unique, and it takes the place `Name-Realm` had. The game is
not released until Nov 4, so there is no real ledger to preserve and no migration: names are opaque strings to the ledger, so the golden format-2 ledger (written with
`Name-Realm`) still loads and replays unchanged.

- **One module knows what a name is** (`src/Identity.lua`). The canonical identity is `First_Last` (joined by `_`: no spaces, because commands split on spaces, and no hyphen, because
  `short()` used to cut a name at it and would have conflated two characters sharing a first name). People read and type `First Last`. Nothing else in the addon parses a name.
- **The fetch is isolated in the real client**, because the guild leader knows the names exist but not how the API returns them. The exported API (Interface 16001) shows only hints:
  `C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator(fullName)` ("replaces the character surname separator with a link separator in a full name string"),
  `ShouldDisplaySurname()`, `UnitNameUnmodified`, `UnitFullName`, `UnitName` (each returns a name and a "server"). So:
  - **Which source:** the client asks `UnitNameUnmodified`, `UnitFullName` and `UnitName` and takes the answer with the **most parts**. `ShouldDisplaySurname` suggests `UnitName`
    can leave the surname out depending on a player's own settings, which would make one character look like two to everyone else; an identity must not depend on a display setting.
  - **The separator is learned, not assumed:** comparing a name with `ReplaceSurnameSeparatorWithLinkSeparator` of it shows exactly which bytes the game uses between the names.
    Splitting also accepts whitespace, `-` and `_`, so the code works if that function is missing.
  - **The "server" return is ignored**: there are no realms.
  - **Names sent back to the game** (whispers, the loot-method target, loot candidates) use the spelling the game gave us (remembered per identity), else the display form with the learned separator.
- **To confirm in the live game** (Nov 4): run `/gambit check`; it prints, for the player, each name API's raw return, `ShouldDisplaySurname`, the bytes of the chosen name, its link form,
  the learned separator and the resulting identity. If anything differs from the assumptions above, the fix is in `RealClient`'s name block and `Identity.lua` only.
- **Typing names:** a command takes one word per name: `Aldric_Stormwind`, or `"Aldric Stormwind"` in quotes. Two words that make a name the addon knows (on a list, in the raid or the
  guild) are joined automatically, so `gift Aldric Stormwind Brann Ironforge` works; only the first few words are looked at, so a free-text reason is never rewritten.
- **Version line 0.3:** what every name in the ledger and every addon message means changed, so players on 0.2.x and 0.3.x are not compatible (the compatibility baseline's line is 0.3).

### Fixed: an older release over a newer ledger lost the whole ledger; and the ledger is now checked under the game's Lua (2026-11-04)

Found by probing the real loader while asked what else could break backward compatibility.

- **The bug.** A saved ledger with one entry in a format the loaded build can't read (the usual way: a newer release saved it, then an older one was installed over it, e.g. a
  rollback from CurseForge) made `LoadStore` drop that writer's *whole* chain. If it was the guild master's chain the genesis went with it and every other chain failed with "no ledger":
  0 of 42 events survived in the probe. An unreadable format is not damage, it is a ledger that has moved on.
- **The fix.** For `badversion` the readable entries before the unreadable one are kept, and the chain is marked `ahead` (with the format found). The engine then shows the ledger as of the last
  entry it can read, says so once ("this ledger has entries in a newer format... nothing was lost: update"), and **pauses all writing** (`ahead`): a write would build on a truncated view and could fork the
  player's own chain. It also **never writes an ahead chain back to disk**: the load path used to re-save every loaded chain, which would have deleted the unreadable entries. Real tampering (`badhash` and the
  like) is still dropped whole. When the player updates, the same saved data loads in full (tested end to end with the simulated format 3).
- **Lua 5.1.** The game runs Lua 5.1 (every number a double); the suite runs on a newer Lua. `tests/lua51_golden.lua` is a standalone, plain-5.1 script that checks the hash goldens, the canonical text
  of numbers (1 and 1.0, values past 2^31), the documented worked example and every published format's golden ledger (load, verify every hash, replay to the frozen standings, validate every entry
  against its schema). CI runs it under `lua5.1`, `luajit` and the newer Lua, and the release waits for it.
- **Still open from the same review:** rule changes are format changes (a frozen corpus of random ledgers would guard them), names can change (an alias mechanism), enumerations are closed (class tokens),
  items are recorded as link text, the cutover is irreversible, `acct.schema` is overwritten unconditionally, no checkpoint/lineage yet, no transport codec id.

### Decision: a raid chooses its list when it opens, and the guild master can require a list of its own per raid (2026-11-04)

*Settles the open "list scope" item from 2026-10-29 (see "Tokens, readiness, materials, and list scope"). Decided by the guild leader.*

- **A raid has a list.** When an officer opens a raid they can name the list it plays on (`raid open <Master Looter> [hours] [list <id>]`);
  the default is `main`. Naming a list that doesn't exist yet is how a new one is made (say `20man`). `raid list <id>` sets it right after
  opening if it wasn't named then. In the ledger this is a new authority entry, `SetRaidList {raid, list}`, written by an officer.
  **The first one stands.** A raid never changes list part-way through; if it was the wrong one, revoke the raid and open it again.
  (We chose this over "the latest stands", as the disenchanter does, because the whole point is that loot can't land on the wrong list.)
- **The guild master can make it one list per raid.** `raid policy perraid` (a new authority entry, `SetListPolicy {mode}`; the other value is
  `choose`, the default) means every raid opened from then on **must** name a list of its own and may not use `main`, and its Master
  Looter can't write anything until it has one. So two guilds' officers can't drift apart: everyone who runs a raid gets the same rule, and it
  is enforced by every client's replay, not by habit. The policy a raid was opened under is the one it keeps, so changing the policy later
  never rewrites an earlier raid.
- **Enforcement, not just a default.** While a raid is active, its Master Looter may only write list entries to the raid's list and its
  off-spec list. The off-spec list is derived, `off` for `main` and `<id>-off` otherwise, so there is nothing more to choose and no way to
  split a raid across two off-spec lists. Officers outside a raid are unrestricted (that is how mistakes are fixed), and their manual
  commands take a working list (`list use <id>`, default `main`).
- **A new list is seeded from `main`'s order** (the decision of 2026-10-29: "who has waited longest" carries over), by the raid's Master
  Looter when the first session starts, so an officer opening a raid never needs to write to a list while another raid is running.
  Wins and passes are not carried over; the new list starts level.
- **List ids** are lower-case letters, digits and `_`, up to 24 characters, and not `off` (a hyphen is how an off-spec list is named).
- **It is a ledger change, so a new compatibility line:** two new entry types, a stricter rule on what a Master Looter may write. Version
  0.4.0. The ledger format number does not change (new entry types were added to format 2 before: `Migrate`), and no old entry changes meaning.
- **Documentation:** a new guild-master guide (`docs/guild-master.md`) lists every option the guild master has and what each is for.
- **Left for later:** a lesson in the simulator for choosing a list; per-raid-kind defaults (a raid *named* "Naxxramas" always getting the
  `naxx` list) if choosing by hand proves error-prone.

### Decision: `/gambit` opens a window; the commands stay (2026-11-05)

The addon has been command-only, and `/gambit help` is now a long list. Most players will never read it, so **typing `/gambit` with nothing after it
opens the King's Gambit window** (it used to print the standings). `/gambit help` still lists the commands, and every command keeps working:
the window is a second way to do the same things, built on the same engine calls, so the ledger and its rules are unchanged (no new events, no
compatibility change).

Built in stages, each tested in the game before the next: (1) the window itself with the standings, and a way to switch lists; (2) the bid
popup for a running loot session (need / off-spec / pass / gift, and the draft and salvage turns); (3) the officer actions (add, move, award,
undo, raid open and its list, requests). A window can only be checked in the game, so the tests cover what it would show (the model behind
it) and that it builds against a stand-in for the game's frame functions; how it looks is confirmed by looking at it.

### Decision: a practice mode inside the game's window (2026-11-05)

Testing the window, and later learning the addon, should not need a real party. The simulator page already runs the real engine over a simulated
raid (bots, Molten Core and AQ drops), and the same files ship in the addon, so the window gets a **Practice** button: it builds a
simulated 40-player raid, with you as a member, and points the window at it instead of at the real ledger.

Rules, so practice can never touch the real thing: the practice raid is a separate in-memory engine on a mock client, so it **never reads or
writes your saved variables, never sends an addon message, and never appears in anyone else's ledger**. The window says so on a banner
the whole time (orange, "PRACTICE"), practice output is printed in chat with a "Practice" prefix, and *Leave practice* returns to the real
ledger exactly as it was. The window code reads its engine, client and commands from one context, which is the real one or the practice one,
so every window built later (the bid popup, the officer actions) works in practice with no extra code.

### Decision: the window fills the list from the group and the guild, not from typed names (2026-11-05)

A first window had a box to type a name and an Add button. Nobody wants to type names: the people who should be on the list are the ones in the
group or the guild. So the window has **one button**, "Add N from your group and guild", where N is how many of them are not on the list yet,
and it appears only when N is more than 0. It writes the same `AddMember` events as the `add` command (with each player's class), so the same
rule applies: an officer outside a raid, or the raid's Master Looter inside one; anyone else is told why not. The command form is `addall`.
Removing and moving someone stay commands for now (they need a reason, which is part of the record).

Practice mode gets a simulated guild too (the raid's players plus guild members who are not in the group, some offline), so this button can
be tried without a real guild.

### Decision: every feature gets a button, and a button is a command (2026-11-05)

The goal is that nothing needs typing. The window grows a tab for each kind of user (Standings, Loot, then Officers and Guild master), and
**every button runs the same command a player would type** (`need 1`, `pass 2`, `pick 1`, `resolve`, `confirm`, `addall`...). The window adds no
rule of its own, so the ledger, the messages and who may do what are exactly as with commands, and a button can never do something a command
could not. The commands stay as the fallback and for scripting.

The Loot tab shows the running session (the one this machine runs as Master Looter, or the one it is answering): each item with
Need / Off-spec / Pass / Gift buttons and your answer marked, the phase and the time left, the turn prompts (pick, claim, who gets a gift), and the Master
Looter's Resolve / +30 s / Confirm / Cancel. It opens by itself when a session starts. In practice mode it adds Next boss, Hand out the held loot
and Wait, driving the same simulation as the website.
**Layout follows the game's own windows**, whose source is public (the Gethe/wow-ui-source mirror; this client has the same scroll box, tab
system and dropdown templates). The standings are the game's scroll box with its scroll bar, in an inset panel, with clickable column headers (a click
sorts by that column, again reverses; the list's own order is the default, because the order *is* the list); the list and the practice group size are
dropdowns; the tabs hang along the bottom edge of the window; *Practice mode* is a checkbox (like "show offline members"). Each piece falls back to a
plainer one built from basic frames if a template is missing in this client, so the window works either way.

Items are links, not text: each item in the Loot tab shows the game's own link, hovering shows its tooltip, shift-click puts the link in chat and
control-click tries it on, as anywhere else in the game (simulated drops in practice use their real item ids, so the tooltips work there too). In the Tools forms,
shift-clicking an item while a box has the cursor inserts its link, and a link in a field is turned into `item:ID` before the command is composed (a link contains spaces).

Practice loot comes from items that exist in this game. Molten Core's items are not in Forever's server data until the raid releases (their links never
load), so practice mode takes the wearable gear in the player's bags and equipment, shares it among a few "Practice boss" drops, and shows each as its real
link with a real tooltip; the simulation reads each item's slot, type and stats from the real client, exactly as a real session does. Molten Core's table
stays as the fallback (fewer than three pieces of gear) and for the website, whose items are shown by name.

**Players are picked, never typed.** A name typed into a box is the commonest mistake (a misspelling, the wrong character, a realm that doesn't exist here).
So a player is chosen from the list: in Standings a click selects a row, and the buttons under the table act on that player (Top, Up, Down, Bottom, Remove, Award);
in Tools every player field is a dropdown of the players it could be (the list's members; for "add" those in the group or guild who aren't on the list yet; for
a Master Looter or disenchanter, the group). Choosing a player in Standings pre-fills the form. A move needs a reason (it is part of the record), so the reason
box under the table is required for moves. The controls under the table are always there but grayed out for someone who may not change the list (not an officer, and not the Master Looter inside a raid: the same
check the engine makes), with a line saying why, so a missing permission reads as a permission and not as a missing feature. Typing a name stays only where there is nothing to pick from (the plain-frame fallback, and "set the officers").

Every button has a tooltip that says in full what it does: the rule behind it, what it costs a player's place, who may use it (`UITips`).
A grayed-out button's tooltip also says why (no permission, nobody selected, your class can't have the item), so a disabled control is never a mystery.

**A move is staged, then applied once.** The ledger records every move, so a move made one step at a time (Up, Up, Up...) left a trail of entries for one
intention. In Standings, Up, Down, Top, Bottom, a typed place number and dragging a row onto another only change a *preview* (the selected player is shown at
the place they would take, marked as moving); nothing is written. **Apply move** then writes a single `move` entry, with the reason, and *Cancel* drops the
preview. One intention, one entry, one reason. (Remove and Award stay immediate: each is one entry already.)

**An item is chosen, never typed.** The "Record a win" form's item is a dropdown of what the Master Looter holds: the open loot window plus the tradeable
items in the bags (not soulbound, or still inside the loot-trade window the tooltip reports). A win to correct, though, is often for an item that has already gone
to someone else's bags, so shift-clicking an item link from chat (or the bags, or the loot window) while a form with an item is open fills that field, so no link is
ever typed; for Record a win a held item is matched by id and any other item is taken as it is, shown in the dropdown as "shift-clicked". (The typed `award`
command is unchanged: it still takes any item.)

The **Tools** tab holds a form for every command that needs a name, a reason or a choice, in four groups (Raid; List; Rules and requests; Guild
master and me), chosen with two dropdowns (the area, then the action), so a new action needs no new button and nothing can overlap. A form only composes the
command text (the `Compose` function, tested for every form) and runs it. The foot of the window shows what the last command said, so a refusal ("only the
raid's Master Looter can...") is read where the button was, not in the chat window.

### Decision: two surfaces, a Loot window and a Guild book, replace the one tabbed window (2026-11-06)

The tabbed window grew by adding a button for each command, so its shape followed the command list. It served a raider with seconds to answer and an
officer reorganizing a list from the same frame. The guild master asked for a panel for managing rules and standings and a separate, specialised
interface for in-raid loot (Gargul was named as inspiration), and for solid UX standards instead of functional UI piled up.

Decided (full reasoning and alternatives in [ui-design.md](ui-design.md)):
- **Two surfaces.** A small **Loot window** for the live session, which opens by itself when a session starts; the Master Looter sees an extra control strip in the
  same window. A larger **Guild book** (`/gambit`) with a navigation column: Lists, Raids, People, History, Rules, Practice. Rejected: one window with tabs
  (mixes two unlike moments), three surfaces by role (duplicates the session logic), and in-place helpers only (no overview for lists and history); the
  in-place ideas (item tooltips, a launcher button, Master Looter modifier-click) stay as optional extras.
- **Standards.** Each screen is reviewed against Nielsen's heuristics, the interaction laws, WoW conventions and accessibility rules in the design file. Kept from
  earlier decisions: unavailable controls are grayed with the reason, players are picked and never typed, list changes are staged and applied as one entry. New rule:
  a screen says whether a thing is a preview, pending or recorded.
- **The web simulator and the game share the window's decisions** through view models (plain tables saying what rows, which buttons are enabled and why, and
  which text), drawn by one renderer in the game and one on the page, with a replay test that compares them. Pixels will differ; screens, states, words and
  enabled logic will not. Refining layouts on the page first also gives a faster loop, since the page can be viewed here and the game cannot.

Not yet decided (the design file lists them, each with a recommendation): whether the Loot window opens by itself or asks, how much History every raider sees,
answer hotkeys, the launcher button, and which surface is built first (recommended: the Loot window).

**Build order chosen (2026-11-06): the Loot window first.** `LootView` (a new module, pure Lua) turns what `UILoot.Model` reads from a session into the window as a
table: its state (`bidding`, `waiting`, `myturn`, `turn`, `review`, `result`, `cancelled`), the timer with its fraction, a row per item with the four answers
(each with a letter, a tooltip id, enabled or grayed with the reason, and whether it is the player's answer), the panel for the player's own turn (pick, gift
recipient, salvage claim), and the Master Looter's strip, which only the Master Looter has. A button carries an `act` (`{ name = "bid", item = 2, kind = "need" }`)
and each place runs it its own way (the game as the same command a player could type; the page through the engine), so no rule lives in a drawing.
The web simulator is the design bench: the window is drawn on the page first, where it can be looked at and refined, then drawn with the game's frames from the
same table. Taken from the design file: a raider's window has no rule text, lists or history; the Master Looter's strip is absent for everyone else (not grayed,
since it is another role's area), while a raider's own answers that don't apply are grayed with the reason, as decided on 2026-11-05.

**First version built (2026-11-06).** The page now draws the raider's part of the simulator (the items, the answers, your turn, the Master Looter's buttons) from
`LootView`, through the engine's own bundle (`UITips`, `UILoot` and `LootView` are now in the page), and every scenario runs to its end through it. The game has a
new `LootWindow` module that draws the same table with the game's frames; it opens by itself when a session starts (as the old tab did), shows the practice
buttons (next boss, hand out, wait) in practice, and can be opened with `/gambit window` or the Loot window button on the main window. **The Loot tab is gone
from the main window**: a live session and the lists are different moments, and the main window keeps Standings and Tools until the Guild book replaces them. Rules
unchanged: a button types the command the old button typed. Left as they were, for now: the page still has its teaching material around the window (the lesson,
the scenario list, the answers table), and the page's "Need, ready" button and "Request eligibility" are page-only extras for tokens and the Master Looter.

**The windows are the player's to place (2026-11-06).** Both windows (the Loot window and the main window) can be dragged, can't be dragged off the screen, and the
place they are left is remembered for each character (`KingsGambitCharDB.ui`, which the design had reserved for frame positions). `/gambit window reset` puts both back where
they start; a damaged saved position falls back to the default. The Loot window starts to the left of the main window so the two don't cover each other. (Size and scale
options are still to come.) The Loot window sits in a higher layer than the main window (a live session is the time-critical thing and is never hidden behind the lists), and
clicking either window raises it above others at its own level.

### Fixed: an item with no stats of its own has no class affinity (2026-11-06)

Plain white gear was being refused as "nothing on this helps your class": the stat check (`ItemFit.Worthwhile`) counted an item's armor value and a weapon's damage per second
as stats that some specs value and others don't, and only feral bear druids weigh armor, so a plain chest piece with nothing but armor looked pointless to every other class, and
a plain staff (damage only) to every caster. The rule is now: **an item has an affinity only if it has a stat other than the ones every item of its kind has** (armor, a weapon's
damage per second, a shield's block value). An item with only those, and an item with no stats at all (a shirt, a bag, a trinket with only an effect), is open to every class that
can wear or wield it; what an item is made of still says who can wear it (a mage can't wear plate), and a guild rule (`eligible`) still restricts or opens a particular item.
Items with real stats keep the existing check unchanged (a warlock still isn't asked about a blade of strength and agility; even a little stamina counts as a stat).
This is one rule in the engine, so the game and the web simulator both follow it.

### Decision: practice mode plays as your own class (2026-11-06)

Practice mode made the player a priest (the simulator's usual learner), so a warrior was asked about priest loot and saw the wrong answers grayed. The client now says what
class its player is (`myClass`: the game's `UnitClass`, or the roster's entry in the mock), and starting practice passes it to the simulation, so the Loot window and the
eligibility checks are those of the player's real class. A class the simulation doesn't know falls back to the priest. The simulated spec is the class's first one (a warrior
practises as Arms); the game doesn't give us the player's talent spec in a way we read yet, so that stays a default for now. The raiders around the player are unchanged.

### The Loot window shows who gets what before the Master Looter confirms (2026-11-06)

The draft already knew each item's winner as it went, but the window showed it as a bare name. Each item's line now reads as a result: **who wins it** ("You win" / "Brann wins"), **in which
round** (main-spec, off-spec, gift, salvage), **who it is given to** if not the winner (or that a gift's winner hasn't chosen yet), and **where the winner falls**
("moves from place 4 to the bottom of the list"); an item nobody wanted says it goes to the disenchanter, and names them. These lines appear as the draft proceeds, so everyone who sees the
session (not just the Master Looter) can follow who is getting what, and in review the Master Looter's banner says it plainly: "this is who gets what; nothing is handed out or recorded
until you confirm". Nothing about the rules changed, and nothing is written until Confirm (a test checks the ledger is unchanged while reviewing). The player's own wins are marked.
Also fixed: the Loot window had been raised to a higher layer than the main window, and the game opens dropdown menus in the normal one, so the "who gets this gift" dropdown opened
behind the window and could not be used. The window is back in the normal layer and is raised above the main window when it opens (clicking a window raises it).

### People in the Loot window are drawn like the standings list draws them (2026-11-06)

A winner, a gift's recipient and the player a turn is waiting for are now shown by **name in their class color, with their spec and class beside it** ("Brann (Fury Warrior)"), the way the
standings list and the simulator show people, instead of as plain text. The shared table (`LootView`) carries a line as pieces (`segments`: plain words, and people with their class
color, class name and spec), and each place draws them its own way: the game with color codes, the page with colored spans. The plain `note` is kept alongside, with no color codes,
for anything that can't draw pieces and for the tests. The spec is shown only where it is known: the practice raid knows everyone's; in a real raid the game doesn't tell us another player's
spec, so a real player is shown with their class alone (and we don't guess a spec). The colors are the game's class colors, defined once in `LootView`.

### Decision: ranking is explicit, set up front, and the session waits for it (2026-11-06)

Ranked choice was decided on 2026-10-29 (answers stay up front; a player who wants several items ranks them; the draft takes the highest-ranked item still available with no prompt) and the
engine and the whisper path implemented it, but the Loot window and the typed commands never sent a rank. So a player who needed two items was asked "Pick 1 or Pick 2" live on their turn
and was never asked to prioritize. The guild master chose, from three options, **to require an explicit ranking** (over a silent default order, or leaving the live pick).
- **The rule (engine):** with `requireRanking` on, a player who has two or more answers of one kind (needs, off-spec, gifts) is not counted as having answered until every one of them has a
  rank, so bidding doesn't close early on them. One need, or only passes, has nothing to rank. Changing an answer drops that item's rank (a new rank is needed). If the timer runs out first the
  existing fallback applies (they are asked live on their turn), so a rule can never stall a raid. The setting is off in a bare session (tests and old behavior are unchanged) and **on in the
  game's host and in the practice raid and the web simulator**, so both play the same.
- **The command:** `rank 2 1 3` puts the items in order, most wanted first (each must be answered need, off or gift); the window's buttons run it.
- **The window:** when you want several items of one kind, a panel shows "Your order (most wanted first)" with Up and Down on each item and a **Confirm order** button. Nothing is ranked until you
  press Confirm (see the correction below: a move does not confirm); the banner says the session is waiting for your order, and the answered count doesn't include you yet. After that it reads
  "Order set". It is in the shared view, so the game and the page show the same panel.
- **Bots** in the simulation rank the items they want by their preference list, else item number, so a practice raid isn't held up by them.
- Whispered answers rank in the order written (as before); separate whispers ("1 need", "2 need") are unranked and so keep bidding open to the timer, then fall back to the live pick.

### Fixed: the gift recipient list offers only players who can have the item (2026-11-06)

The Loot window's "who gets this gift" dropdown listed everyone in the group, so it was easy to pick someone whose class can't have the item, and the only feedback was a refusal in
chat afterwards. The rule was already enforced (a gift's recipient must be one who may have the item; the giver never has to), but a rule that can only say no after the fact is the
wrong place for it: **the choices now exclude anyone who can't have it**, so the mistake can't be made (the same principle as greyed-out buttons and picked-not-typed names). The list
comes from one place, `Commands.giftTargets(item)`: group members, other than you, whose class passes the same `Loot.MayHave` check the session applies, including a guild rule for the
item. It reaches the window as `turn.targets` (and `row.giftTargets`) in the shared view, so the game's dropdown and the page's list are the same list, and the menu is rebuilt when the
list changes and drops a choice that is no longer on offer. If nobody in the group can have the item, the window says so and leaves Keep (if allowed) and Withdraw. The same list serves
"Claim and gift" in the salvage round.

### Your choice is shown by highlighting the button, not by changing its text (2026-11-06)

In the game window a chosen answer was shown by wrapping its text in brackets ("[Need]"), which changes the label, can overflow a narrow button, and reads as part of the name. The first
replacement (a lit button with a green label) was tried in the game and judged **too little contrast**: a green label on the game's red button is hard to read and a color change of text alone
does not meet good design practice. A second try (the whole button tinted green, with a check mark) was also set aside: the guild master pointed out that the game's own interface marks a selection by its **background**, and asked to
survey the game's UI and pick the best, not invent a look. Surveyed in the game's UI source (Gethe/wow-ui-source `live`): (1) a **list row** (reputation, dropdown lines) is selected by a translucent
white band behind the whole row, alpha 0.20 selected and 0.10 hovered, from the atlas `charactercreate-customize-dropdown-linemouseover-*`; (2) a **tab** swaps to an "active" texture set and its label
from gold to white; (3) a **dropdown radio or check** gets a tick mark; (4) a **toggled panel button** is held in the pressed state. The game never tints a button green. **Chosen, from those:** an answered
item gets the selected-row band behind it (so a list of items shows what is answered at a glance), and the chosen answer button is held pressed in (`SetButtonState("PUSHED", true)`), its label is white
as on an active tab, and a tick sits inside it. Nothing about the label text changes; un-choosing releases it and restores the label's own font. If the game lacks the atlas the band falls back to a plain
translucent white fill. The page matches (a pressed-in button with a white border and a tick, on a white translucent band). Rule kept for later work: never mark state by a color change of text alone,
and prefer the game's own idioms over new ones.

**Two faults found in the game, fixed the same day.** (1) *Selection persisted between rounds.* The answer buttons are reused for every round, and a button not drawn this time kept what the last
round had put on it. Now a button that is not drawn is cleared, and un-marking is complete: released, and the label set back explicitly to the game's gold (or gray when unavailable), not left to a
font swap. A new round therefore starts with nothing chosen, until the player chooses something. (2) *The tick inside the button looked unprofessional:* a tick at the button's left edge with the label
shifted right left an unnatural gap. **The tick is no longer inside the button**: it sits in the note column directly before "You: Need" (both left-aligned, no gap), in the same place on every
row; the button itself only changes state (pressed in, white label) and its text and position never change. The page does the same.

### The Loot window is laid out on a grid, with the status on the item's own line (2026-11-06)

Looking at the window in the game, the guild master found the text on the right "really tight" and asked for UX and UI principles to make it look professional. The faults: the answer shown in a
narrow side column that wrapped to three lines; fixed row and message heights, so a three-line message ran into the heading under it; a tall, repetitive message; and the selected-row band not
showing at all (it was drawn in the lowest layer, under the window's own background; it is now in the artwork layer). Fixed by one layout pass, written down as rules in `ui-design.md` ("Layout rules"):
a 16 px margin and 8 px spacing on one grid; four equal buttons across the full width; heights measured from the text; thin dividers and small headings between groups; the item's name with what you
answered right-aligned on the same line, and the tick inline against that text (no gap); Confirm beside the heading of your order, Up and Down right-aligned on each line; and shorter copy (the
ranking message is one sentence, the answer reads "Need", "Off-spec", "Pass", "Gift, name later" or "Gift to Name" instead of "You: Gift (you'll choose who if you win)"). The chosen answer is still held
pressed in (a toggle) with a white label, reasserted every refresh. The web page uses the same layout (a grid of four equal buttons, status on the item's line).

**The selected-row band was then removed.** Once it showed (above), the guild master saw that with every item answered the whole window went gray: a mark that applies to every row at once tells
nothing and only adds weight. The choice is now shown by the pressed-in toggle button and the "tick + answer" status on the item's own line, which differ row by row. (Rule 8 in the layout rules.)
The band code, its atlas and its fallback are gone from the window and the page.

**The tick is gone too, and the toggle is made unmistakable.** The guild master disliked the "random" tick (even the old brackets were better) and asked for the button to look pushed in and stay
pushed, like a push-button toggle, and for other examples to follow. Searched in the game's UI source: that is exactly how the game's own **micro-menu buttons** (Character, Spellbook...) behave while
their window is open, and how the **Damage Meter** and **Edit Mode** buttons show what is selected: `SetButtonState("PUSHED", true)`. We already did that, but the game's pressed art is faint on its
red buttons, so a chosen answer now also gets an **inset bevel** drawn on top (a darker body, a shadow along the top and left edges, a light edge along the bottom), which reads as "pressed in" at a
glance and is shading, not a change of hue. The text never changes. The status on the item's line is plain text ("Gift, name later"), no mark. The web page does the same (an
inset shadow, one pixel lower). Removing the bevel on un-choosing is part of the same reset that clears a button between rounds. **Then the label color change was dropped too** ("I don't know that we need to change the text color too"): the bevel alone carries the state, and the label keeps the game's own color, so there is nothing to restore either. **And the echo was dropped:** the status text beside each item ("Off-spec", "Gift, name later", "Yours") repeated what the pressed button already says, so it is gone from the window, the page and the shared view; an item is now its name on its own line with the choices across the full width beneath it (rule 8, "Say a thing once", in the layout rules).

### Guild book, first slice (2026-11-06)

With the Loot window settled, the second surface of the two-surface decision was started: the **Guild book**, the larger, calmer window opened with `/gambit`. This slice is its shell and two sections.
- **A navigation column replaces the bottom tabs.** Lists, History and Tools are buttons down the left, the open one held pushed in (the same idiom as the Loot window's chosen answer), with a thin line between the column and the section. The window is 580 wide so the section keeps the 424-wide layout the older pages were built for; nothing in them had to be re-laid out.
- **History is new.** The ledger as readable sentences, newest first, with when it happened ("3 days ago"), filtered by kind (Everything, Loot, List changes, Rules, Raids) and by words (a player's or an item's name). A long sentence shows two lines and the whole of it in a tooltip. It only reads: nothing in it can be edited, and an empty or over-filtered record says so and what to do.
- **The view model is shared.** `GuildBook` is a pure module (sections, kinds, `History`, `Ago`), like `LootView`, so the web page can draw the same sections and sentences later instead of deciding anything itself. It reuses the command line's own sentences (`describe`), so the window and `history` always agree; the ledger's list-creation entry now reads "started the list" instead of a bare event name.
- **Tools stays as a section for now.** The existing forms are kept whole until they are split into Raids, People and Rules.
- Still to do: the page renderer for the Guild book; Raids, People, Rules and Practice sections; staging list changes behind a pending-changes bar.

### The Tools tab is split into sections (2026-11-06)

The Tools tab was one page with an Area dropdown and an Action dropdown over every form: a person had to know which of four areas held "Add a player". It is now **five sections of the Guild book**, each a page of its own forms with only an Action choice (the Area step is gone):
- **Awards**: record a win the session missed, undo the last award, an item that went elsewhere, note a salvager. The corrections.
- **Raids**: open raids, open, name its list, extend, close, revoke, set the Master Looter, the disenchanter, one list per raid.
- **People**: add, remove and move a player, the officers (show and set), my spec, fit hints.
- **Rules**: class rules and who an item suits, requests to the Master Looter and their answers.
- **Ledger**: create a list, work on a list, the ledger's format and the move to the next one, versions, sync, the game check. A gap above its button keeps the guild master's and maintenance corner apart from the everyday sections, as the design asks for the rare and permanent steps.
Decisions: every form lives in exactly one section (a test fails when a form is in none or two, so nothing becomes unreachable); the old History form is gone because the History section replaced it; `GuildBook.SECTIONS` lists each section's forms, so the page can draw the same sections later; "Award..." on the Lists page opens the Awards section (`SectionOf`); a shift-clicked item link goes to the form page on screen. The forms themselves are unchanged and still run the command a player would type, so what each may do is decided as before. The Master Looter's list-change refusal now points to Rules ("Request a list change").

### Correction: the Guild book has one place for the record, History; the guild master's corner is Admin (2026-11-06)

The split of the Tools tab named its corner of maintenance forms "Ledger", right beside a History section that is the ledger's own record: the guild master asked why they were two things. They were not the same thing, but the names said they were. The record is **History** (the ledger in sentences, with nothing to edit); the forms for starting a list, the record's format, versions and sync are **Admin**, still set apart by a gap. The user-facing wording avoids "ledger" for the corner so there is only one place to read the record.
History rows are also **denser**: one line each (when, then what happened, cut off with the whole sentence in the tooltip) at 20 pixels instead of two lines at 38, so about twice as many entries show without scrolling. The record now has a sentence for a disenchant ("X was disenchanted by Y") instead of a bare event name, and counts it under Loot.

### Stats section, and who was in a raid (2026-11-06)

**Stats** is a new section of the Guild book (after the Ledger). It is worked out from the record, by replaying a list with the entries' own timestamps (`GuildBook.Stats`; cached until the ledger changes): each player's place and **how long they have held it**, their wins and when they last won, a sentence or two about the whole list (who is first and since when, most wins, who has waited longest without one), and, by clicking a player, **every place they have held and for how long** (including a player taken off the list). The times come from the entries, so everyone with the same ledger sees the same numbers.
**Attendance** was the missing piece for raid statistics, and the guild master wanted it to answer "was this player in the raid", especially when someone leaves mid-raid. A new ledger entry, **`Attendance`** (`raid`, `joined`, `left`), is written by the raid's own Master Looter's addon (`Attendance.lua`): when the raid opens (everyone there), and whenever the group changes (it settles for a few seconds so a burst is one entry, and re-checks every half minute). Deltas rather than full rosters, so each entry stays small (a dozen names at most, sent as several entries); a player who leaves is written as having left at that time, so their time in the raid is exact and "was there when the boss died" can be answered later. The ledger rule: it must name an existing raid, be written by that raid's Master Looter, and name at least one player. It is a ledger-surface change (a new event type): schema hash and compatibility baseline updated, **version line 0.6**, TOC 0.6.0. The guild master confirmed nothing real is recorded yet.
- **Reading it:** the Stats table has a **Raids** column ("7/9": raids attended of the raids on that list), and the selected player's panel adds "in the raid 82% of the time, left early twice". A raid with no attendance entries (from before this existed) isn't counted, so nobody is marked absent from it. The Ledger keeps attendance under its own filter (**Attendance**) and out of "What happened", as with passes.
- Not done: attendance per boss (whether someone was present at each kill) is derivable from these entries and the awards' times but isn't shown; the practice raid has everyone present from the start and nobody leaves unless a test makes them.

### Decision: officers are the game's (just-in-time authorization) (2026-11-06)

Decided and built, replacing the open design below. The ledger no longer keeps a list of officers. **An officer is a member of the guild whose rank has the game's "Is Officer" permission** (the Guild Master sets it per rank in the game's guild control; flag 3 of a rank's permissions, "Access officer channels", which is part of it; the Guild Master's rank always counts). Confirmed in the game by the self-check: `IsGuildOfficer()` is true for an ordinary officer, and any member can read every rank's flags.
- **Just in time:** a writer's own addon asks the game at the moment of the action (`Engine:Allowed`): an officer may write anything; anyone else may write only as the Master Looter of a raid they run, and not the officer-only entries (open, revoke, name a raid's list, policy, disregard, format change). A Master Looter whose raid has ended is told so rather than that they aren't an officer. The window and commands use the same answer, so buttons reflect the guild's ranks at once. A character in no guild has a ledger of their own and counts as its officer.
- **The ledger takes what arrives:** the replay no longer checks officership; it accepts an entry from anyone who isn't being disregarded and still enforces the raid's single writer. Old `SetOfficers` entries still read and have no effect, and the `officers set` command now says so. The game keeps no rank history, so a later look at someone's rank can't judge an old entry; that is why nothing is checked on replay.
- **The one remedy:** a new entry, **`Disregard`** (`name`, `reason`, `lift?`), written by an officer, makes every client ignore that player's entries from then on (the same everywhere, in write order; earlier entries stay; `regard` lifts it). The ledger owner can't be disregarded, and a disregarded player's own Disregard is skipped. Commands `disregard` and `regard`, forms in People.
- **The alert:** when an entry arrives from a player the game says is not an officer now (and who isn't, and was never, a raid's Master Looter), the officers' addons print who wrote what and how to answer (`Guard.lua`). It only warns; each player is announced at most once in ten minutes.
- **Remaining ledger-owner powers:** how raids pick their list, and moving the ledger to a new format (and handing the ledger on). The one hole, a modified addon writing without asking the game, is what the alert and Disregard are for; Blizzard authenticates who sent a message, not what a modified addon wrote.
- **Surface:** a new event type and a changed acceptance rule: schema hash and compatibility baseline updated, **version line 0.7** (TOC 0.7.0). Nothing real was recorded before this.
Untried in the game: whether `IsGuildOfficer` stays true for a character who is an officer only through the rank permission after a reload, the alert on real guild traffic, and reading other players' ranks from the roster while they are offline (the game says nothing then, which counts as "unknown", never as "not an officer").

### Open design: officers from the game's own rank permissions (2026-11-06)

Not decided or built yet; recorded because it is the direction the ledger owner is working toward. The addon keeps its own list of officers (named by the ledger owner), which duplicates what the game already knows and asks the guild to maintain two things. Proposed instead: **read "officer" from the game**, and piggy-back on one of the **permissions the guild's Guild Master assigns to each rank** in the game's guild control (so a guild that calls its officers something else still gets the same meaning); the permission to use is to be chosen (the natural one is speaking in officer chat). Trade-offs discussed: the game answers "is this person an officer now" for the local client only and keeps no history, so other clients can't check an entry's author *was* one when it was written. The proposed model is therefore **just-in-time**: the writer's addon checks the permission at the moment of the action and refuses if it isn't there; the entry records who wrote it and when; other clients accept entries and use a live check only to **alert** officers when an entry comes from someone who isn't an officer now, and an officer can record **"disregard entries from X"** (the same on every client, in the append-only way). The ledger's officer list would go; the ledger owner would matter only for founding it and for format changes. Blizzard authenticates who sent a message, not what a (possibly modified) addon wrote, which is the one hole and what the alert and the disregard entry are for. **Next step is a field check:** the self-check now prints a "guild" block (this character's rank, the game's `IsGuildOfficer`, and every rank's permission flags in the game's order) to see whether ordinary members can read the flags and in what order they come.

### The addon's "guild master" is the ledger owner (2026-11-06)

(First called the "ledger keeper"; the player who runs the guild's loot chose "ledger owner".)

The addon called the player who founds the ledger, and names its officers, the "guild master". The guild master is a specific role in the game's guild, and the guild master of Gray Parse is not the player who founded the ledger (they are an officer), so the word was wrong and confusing: the addon must not redefine it. In everything a person reads (messages, forms, tooltips, the window, the docs, the simulator page) the role is now the **ledger owner**: whoever founded the guild's ledger and names its officers. The guide became `docs/ledger-owner.md`, and says plainly that the ledger owner is not the game's Guild Master and that the game's guild ranks decide nothing here. Unchanged on purpose, because they are in the format and its frozen baselines: the ledger's event name `SetGuildMaster`, its internal names (`gm`, the refusal code `notguildmaster`) and the golden ledgers. Earlier journal entries keep the old word as the record of when they were written. Open for later, if wanted: reading the game's guild ranks to say who may be an officer or write (not done: authority stays in the ledger).

### Guilds are first class: a ledger belongs to a guild (2026-11-06)

The guild master: guilds should be first class for this loot system, and a list used across several guilds can wait. So the saved ledger is **the guild's**, within a world: `KingsGambitDB.worlds[<game mode>-<faction>-guild:<name>]`. A character in no guild has a ledger of their own (`solo:<their name>`), which never mixes with anyone else's. Details: the guild's name arrives a moment after login, so startup now **waits for it** (up to 20 seconds, saying so) and, if it never comes, **starts nothing** rather than put the ledger in the wrong place (`/reload` to retry); a guild change while playing prints a message that `/reload` switches to the new guild's ledger (until then it is still the old guild's); a new ledger is founded under the **guild's name**, the window's subtitle says "Ledger of the guild X" (or that it's one's own), and "ready" says which. Guild names compare without regard to case. Not done, on purpose: using one list across guilds, and limiting who the addon talks to by guild (entries carry their ledger's id, so another guild's ledger isn't merged, but the messages are still sent to a shared raid). `C_GameRules` mode, faction and `GetGuildInfo` are as above: FIELD to confirm in the game.

### A ledger belongs to a world, not to the account (2026-11-06)

The guild master's Horde character on a PvP ruleset was told it wasn't an officer by a ledger founded by their Alliance character on a PvE ruleset: both live in the account's one SavedVariables file, and the addon kept a single ledger there. They are different worlds and must share nothing. The saved ledger (with who writes which chain, requests and orphans) is now kept **per world**, `KingsGambitDB.worlds[<game mode>-<faction>]`, where the game mode is `C_GameRules.GetCurrentGameModeRecordID()` (the ruleset) and the faction is `UnitFactionGroup("player")`; the self-check's saved results stay account-wide. Characters of the same faction on the same ruleset share one ledger, as before. Consequences: a character's first login in a world starts with no ledger (the old single ledger, founded by an old name, is left untouched in the file and not read), and the self-check prints "ledger belongs to world ..." with the raw mode and faction, so the scoping can be checked (FIELD: the mode record id for each ruleset, and that it is available at login). Not distinguished: two guilds of the same faction on the same ruleset on one account would share a ledger; a guild name could be added when it is reliably known at login. No change to the ledger itself.

### Practice is off in the middle of a real raid (2026-11-06)

Practice swaps the window's data for a simulated raid and ledger, so doing it during a real raid could hide the real loot window and the real list, and the rehearsal could be mistaken for the real thing. **Practice mode can't be started while the character is in a raid group, a real loot session is running (as Master Looter or as a player), or they run an open raid** (the message says which, and that a raid left open is ended with `raid close`; the checkbox unticks itself). And **practice ends by itself** if a real loot session reaches the player or they join a raid group while practising, saying so, so the window is always showing the real thing when something real happens. Being in a 5-player party is fine. The practice raid's own sessions never trigger this: they run on the simulation's stand-in host, not the real one.

### Practice runs raid after raid (2026-11-06)

Practice opened one raid and never ended it, so it couldn't show how the ledger changes over several raids. The practice strip of the Loot window now has a second row: **End raid N** (the Master Looter closes it with a real `RaidClose`; refused while a session runs or loot is held, with the reason), then **Open the next raid** (days later: the clock moves on three days, a couple of raiders can't make it, the bosses are back, a real `Elevate` and disenchanter for a new raid id `sim2`, `sim3`, ...), and **Someone leaves** / **Someone returns** (a raider drops out of the group mid-raid and comes back; the addon writes it down exactly as it would in a real raid). The kill button says "No raid is open" until the next one opens. So a practice session can run a whole series of nights, and Stats (raids attended, time in the raid, left early), the Ledger, This raid and the place history all change the way they do over weeks. Raids are real raids in the simulated ledger; nothing is saved or sent. `Sim:openRaid/endRaid/leave/rejoin` hold the logic and are tested; the buttons only call them.

### A "This raid" section: the open raid in numbers, and its part of the ledger (2026-11-06)

The guild master asked for a view of just the current raid: how long it has run, how many items dropped and are still to hand out, and how long loot can still be traded. The **This raid** section (`GuildBook.RaidNow`) shows, for the raid that is open (the one you run, else the first):
- the raid, its list and its Master Looter; **how long it has run since it started** (the first kill; or "not started yet");
- **handed out**: the Master Looter's awards and disenchants on the raid's list since it started (with the split);
- **still to hand out**, for the Master Looter only (it is read from their own bags and loot window): how many items they hold, and **how long until the earliest trade window closes** (the two hours a bind-on-pickup drop can be traded), with a note if some item's time can't be read;
- and below, the **raid's part of the ledger**: its entries since it started, on its list and its off-spec list, in the usual rows (What happened: no passes or attendance).
Honest limits: the addon does not record every drop, only what the Master Looter holds and what has been handed out, so "dropped" is not shown as a figure (handed out + still held is the nearest, and a corpse looted straight into someone else's bags isn't seen). The held items come from the bags' tooltips (`tradeableItems`: the line "You may trade this item with players that were also eligible to loot it for the next 1 hour 59 min", parsed for hours, minutes and seconds); that tooltip text and the parsing are untried in the game (FIELD). In practice the held loot and a two-hour window come from the simulation.
**A bug found on the way:** the pattern built from that tooltip string (here and in the Record-a-win form's list of tradeable items) didn't escape the `%` of its `%s`, so it never matched and no item was ever seen as inside a trade window; both are fixed, and a test reads a made-up tooltip.

### The start of the raid has a panel in Raids (2026-11-06)

The commands for choosing when the raid starts were not enough: the guild master wanted them in the window. The Raids section now ends in a **"When the raid starts"** panel (`GuildBook.RaidStart` is its model): a line saying where the raid stands (not running one; waiting for the first kill and starting by itself; not in an instance so nothing will start it by itself; waiting for you; or "Started 25 minutes ago, 38 players in the raid now"), a **checkbox, "Start by itself at the first enemy killed in an instance"** (the same switch as `raid autostart`), and a **Start the raid now** button (`raid start`; enabled only for a Master Looter whose raid hasn't started). They run the commands, so the rules are the commands'. The two forms for these were taken out of the Raids action list, since the panel says them better and a thing is said once; the commands remain.

### The Master Looter can take control of when the raid starts (2026-11-06)

The automatic start (the first kill in an instance) has a manual override: **`raid autostart off`** (form: "Who starts the raid?" in Raids) makes the Master Looter's addon ignore every kill, so a raid starts only when they say `raid start`; `raid autostart on` restores the default; with nothing after it the command says the current setting. It is a preference of the Master Looter's character (kept in their saved settings, not in the ledger), so it changes only when entries are written, not what they are: no format change. `raid start` already worked at any time, inside or outside an instance, before or after a kill.

### Correction: the first kill must be inside an instance; a world boss is started by hand (2026-11-06)

A kill in the open world while in a raid group isn't the raid starting. The Master Looter's addon now only treats a kill (any of the triggers below) as the start when the character is **inside an instance** (`IsInInstance`: a raid or a dungeon; a new client method `inInstance`, true by default in the simulated raid). Raids that aren't in an instance, **world bosses**, are started by hand: `raid start` (and a **Start the raid now** form in the Raids section), which writes everyone in the group at that moment and follows the group from then on; it says so if the raid has already started. The loot-session trigger follows the same rule, so a world boss's loot session in the open world doesn't start it by itself. No format change.

### Correction: a raid starts at the first enemy killed, not the first boss (2026-11-06)

A raid can drop important loot from trash as well as bosses, so the first **enemy** killed, of any kind, is when the raid officially starts. The trigger is now the first of: the game's encounter-ended with a success; the Master Looter **opening a loot window** while their raid is open (they loot the corpse, trash or boss, to hand its loot out); a loot session starting; or `enemyKilled()` (what the practice raid calls). The game's combat log would say a kill directly, but this client's exported API doesn't include the function that reads it (`CombatLogGetCurrentEventInfo`), and reading it would mean watching every combat event, so it isn't used. The opening of the loot window is the dependable one: it fires for any corpse the Master Looter loots. A kill that drops nothing the Master Looter loots isn't seen until something else is, which is fine: the raid starts by the time there is any loot to account for. An unrelated loot window (a node, a chest) while the raid is open also starts it; accepted as rare. No format change.

### A raid officially starts at its first boss kill (2026-11-06)

The attendance entries began when a raid was opened, so time spent gathering counted as time in the raid. The guild master's rule: **a raid officially starts after the first boss has been killed.** The Master Looter's addon now writes nothing until then; the first kill (the game's encounter-ended with a success, or a loot session starting, or `bossKilled()`; whichever comes first) writes everyone there at that moment, and the group is followed from then on. A /reload mid-raid carries on (the ledger already has entries). A raid's recorded start, and the length its attendance percentages are measured against, is its first attendance entry, not the time it was opened; a raid with no kill has no entries and so isn't counted at all, so nobody is marked absent from a raid that never happened. People who arrive after the first kill are present from when they join. No format change: it is only when the existing `Attendance` entries start, so the version line stays 0.6. Untried in the game: that the encounter-ended event fires with a success for every boss (world bosses may not); the loot session starting is the second trigger for that reason.

### Correction: upgrade passes are no longer written at all (2026-11-06)

The entry below kept the "upgrade" passes in the record for the transparency stats. The guild master isn't confident in the heuristic that decides whether something is an upgrade, so **no statistic should be built on it, and the entries are not written any more**: a loot session now records no pass at all, except a gift won but never given to anyone (`undecided`), which is an outcome. Nothing in the format changed (the Pass event still exists and old ledgers' passes still read and still count), so the version line is unchanged; the `passes` and `upgradePasses` counts simply stop growing for new sessions. The Ledger's **Passes** filter remains for the old entries. The stats the anti-hoarding design wanted (last win, time at a place, raids since a win) are better built from things that are certain: wins, the order over time and attendance. A statistics section was proposed: what the ledger already knows can be derived (the place each player held and for how long, by replaying the order with timestamps; wins; last win), while attendance is not recorded anywhere yet and would need a new entry written by the Master Looter (a ledger change).

### Passes stay in the record but the Ledger leaves them out by default (2026-11-06)

The guild master asked whether passes need to be in the ledger at all, since they are by far the most common entries and the question the Ledger answers is what happened to an item, not what could have happened to it. What is actually written is already small: **plain passes were never recorded** (design: "only passes that carry a kind are written, for the transparency stats"). Only a pass that carries a kind, such as an "upgrade" pass, is written, because passing on an upgrade is the signal the anti-hoarding transparency stats are built on (a member's `passes` and `upgradePasses` are part of the standings digest). So the record keeps them, unchanged, and nothing about the ledger's format or version line changes.
What changed is the **view**: the Ledger's filter now starts at **What happened**, which leaves passes out, and has **Passes** (only them) and **Everything** (all of it) beside Loot, List changes, Rules and Raids. One kind of pass stays in the default view because it is an outcome: a gift won but never given to anyone (`undecided`), which the Master Looter counts as a pass, is what happened to the item. The practice raiders' upgrade passes (about a quarter of their answers) were the noise in practice. If the stats are ever judged not worth the entries, stopping the writing of kinded passes is a separate, small decision: old ledgers would still read.

### Correction: the pressed-in button is shaded from both sides (2026-11-07)

The inset bevel had a heavy shadow along the top, a thinner one on the left and one light pixel on the bottom, so a held-down button read as "darker at the top", not
as pressed in. It is now mirrored, as a real inset is lit from above-left: a shadow fading inward over a few pixels along the top and left, a light fading inward
along the bottom and right (each with its crisp outer line), and a body only a little darker than the button. Still shading only: the label and its color are untouched.

### Correction: the pressed-in button changes its face, never its border (2026-11-07)

The bevel was drawn over the button's own border, so the outline changed shade. It is now inset inside the border and only the face changes: a little darker, with a shadow
fading in from the top and left; the light edges along the bottom and right are gone (they read as an outline). The game's mouse-down look stays the bright one, so a
held-down button is clearly not a button being pressed. The shading is drawn under the label (it was over it, which dimmed the text), so a held-down button's label is exactly as bright as any other's. (Too subtle at first, by the guild master's reference picture: the face is now a clearly darker, muted red, its label dimmed with it.)

### Decision: a Welcome section explains the addon, and opens once on the first launch (2026-11-07)

New users had nothing in the game that said what King's Gambit is or how loot works there. The Guild book now starts with **Welcome**, in short what the manifesto
(values, principles, what it is not) and the player guide (the 60 seconds, the rules at the table) say, plus where everything is in the Guild book and how to start.

- **Content is data, not frames:** `GuildBook.WELCOME` (title, headings, text, bullets, numbered items), so the game's window and the web simulator can draw the
  same words later. The window shows it as one scrolling text. A test checks that it says the main things, explains every section of the Guild book by name and
  uses American spelling; when a rule changes, this text changes with the manifesto and the guide.
- **First run is a setting, and nothing opens by itself (a correction):** someone may open the addon and close it at once, in the middle of something else, so
  "seen once" was wrong. The addon says in chat that `/gambit` opens it (and that it starts on Welcome). While **Show the welcome page first** (a checkbox at the foot
  of the Welcome page, or `/gambit welcome off` / `on`) is ticked, `/gambit` opens on Welcome, however often it is closed unread. Once it is off, the window opens on the
  section it was on when last closed (Lists the first time). The switch is per account (`KingsGambitDB.welcomeOff`), the last section per character
  (`KingsGambitCharDB.lastTab`). `/gambit welcome` still opens the page directly.
- **Not a rename (a correction, same day):** "drop to the bottom when you win" is Suicide Kings, not King's Gambit, so the Welcome says so in its first paragraph and
  lists what is different right after it, before the 60 seconds: the ledger instead of a kept list, live decisions by each player, a separate off-spec list, gifting,
  the draft with a ranking made up front, the salvage round instead of a roll, eligibility, free passing, a list per raid, corrections in the open. The same list is in
  the player guide (rationale.md).
- **Its strengths first:** before the flaw, the callout says what Suicide Kings does well and King's Gambit keeps: one simple rule, turns that are earned rather than rolled,
  and loot that spreads evenly across everyone who shows up (the manifesto's "earned turns over the luck of the roll").
- **The flaw it answers (a third correction):** the callout now names what is wrong with Suicide Kings: someone high on the list passes on an item that would help them,
  to save their place for something better, and a useful item is disenchanted. King's Gambit is built so useful loot finds a home, not a shard (gifting lets it be passed on at a
  cost, the salvager takes what nobody bids on, and the draft asks everyone who wants it). The same sentence is in the player guide.
- **"Distribute" only in the explanation (the guild master's call):** the word explains why gifting is the fix (the callout and the first bullet); the addon's own term stays
  "gifting" and "Gift", and the rules and principles keep give and hand over.
- **Gifting is posited as the answer, with its reason (the guild master's call):** it gives the individuals in the raid the agency to decide where loot goes, without the
  penalty that made them pass (a player near the bottom wins for next to nothing and gives it on). The words say "little or no cost", not "no cost": the gifter does pay the place,
  which is nothing from the bottom.
- **Gifting is the fix, said so (the guild master's call):** the callout and the first bullet now tie gifting to that flaw: when the player who would use an item sits too high
  to spend their place on it, someone near the bottom wins it cheaply and passes it up.
- **The READMEs say the same (the guild master's call):** "derived from Suicide Kings" in the READMEs, the manifesto, the guide and this journal became the Welcome's idea: inspired by Suicide Kings, it keeps what works and fixes what does not (gifting).
- **The checkbox is at the very bottom of the window (the guild master's call):** it moved out of the page into the strip below the command output, at the window's bottom edge (shown only with the Welcome page); the output text sits a little higher to make room. The buttons were confirmed good.
- **The checkbox is centered (the guild master's call):** at the bottom edge it is centered across the window, the box and its label as one pair.
- **Gifting leads (the guild master's call):** the biggest difference is gifting, so it is the first item of the list, with its reason, and the callout says so.
- **Not a wall of text (a second correction):** the Welcome is four short pages (Start here, The rules, Using it, Why) behind buttons at the top, one screenful each. Each
  block has its own text: a large gold title, gold headings with room above, a callout with a bar at its left, bullets and numbers with a hanging indent and air between
  them, and a list item's lead words in white with the rest softer so a list can be skimmed. The text is shorter and every item starts with its key words.
- **Not a copy of the docs:** it points to the repository and the browser simulator for the reasons behind each rule.

### Decision: practice mode teaches with the web page's lessons, cancel keeps the loot, the bar is drawn by hand (2026-11-08)

The guild master found practice mode thin: kill a boss, hand out loot, and that was all, where the web page teaches with worked examples that each say what should happen.
Cancel threw the loot away, and the countdown bar looked broken.

- **The lessons come to the game:** the web page's tutorials are the `Scenarios` list, and practice mode now plays the same ones (a lesson picker beside the group size,
  "Raid night (your gear)" first, then the lessons in teaching order). A lesson shows its title and text at the top of the loot window and waits: nothing starts, and
  the clock does not run, until **Start the lesson** (read it first, as on the page). When the hand-out is confirmed the window says whether what happened **matches the
  lesson**, or **what step is still to do** (undoing a mistake, a regret-trade); **Try again** runs it again from the start and **Next lesson** goes on. The check is the
  scenario's own `todo` and `expect`, so the lessons and the rules cannot drift apart (the tests play every lesson through this path). The lessons' "Corrections card" is
  the Awards section in the game, so the window says that.
- **A lesson bug the page had too:** the bots were asked to rank by a default order even where a scenario gave a raider's own rank, so "Two items, one player who wants
  both" came out different from its lesson once rankings were required. A rank the scenario gives itself is now the raider's choice.
- **Cancel keeps the loot:** cancelling records nothing, and the loot is still on the boss, so it goes back to held and **Hand out the loot** offers it again (the banner
  says so); in a lesson it says to press Try again. Before, the loot simply vanished and the next boss came up.
- **The countdown bar is two colored textures:** a track and a fill whose width is the time left (amber, orange in the last ten seconds), not a StatusBar. The model
  gave the right seconds and fraction every tick, so the fault was in drawing; a bar that needs no template or texture file looks the same in every client.
  Unverified in the game until the guild master has seen it.

### Decision: stored ledgers can be retired, and an officer's retirement is told to the guild (2026-11-07)

A character that has played in several guilds, or a ledger founded to try something, leaves stored ledgers nobody uses (the guild master removed two by hand from
the saved variables). Now the addon lists every ledger stored on the computer (`ledgers`, and the foot of the Guild book's **Admin** section) and can **retire** one, after asking.

- **Identity is the Genesis entry's id**, a hash that includes who founded the ledger and when, never the name. A ledger founded again for the same guild after a
  retirement is a different ledger and does not meet the retired one (the "main" list and the name "Guild ledger" are not unique, and need not be).
- **Retiring is local data removal plus a tombstone** (`KingsGambitDB.retired[id]`: name, world, who, when, retired or restored, when this machine removes it).
  Nothing is written to the ledger and nobody else's copy is touched. The ledger in use can't be swapped while it is in use: it is marked and removed at the
  next login, then **Start the ledger** founds a new one.
- **The tombstone stops the nagging:** a machine that retired a ledger never fetches it again from a peer who still has it.
- **Told to the guild in the heartbeat** (field `x`, an addition older clients ignore; no new message type and no ledger entry, so the version line stays 0.7).
  Only an officer's retirement counts (the receiver checks the game's rank, as everywhere now). Each member is told once and can **keep** it (a restoration is
  told to everyone, and a retired ledger whose data was removed is fetched again from whoever has it) or do nothing: it is **removed on their machine after
  30 days**, at a login, as it was on the retirer's. The newest decision about a ledger wins. A restoration is forgotten after 60 days.
- **Confirmation:** the page uses the game's own dialog; the command asks and then wants `ledgers retire <n> yes`.
- **Wording:** the load message says "the ledger of the guild X has N lists" (it said "list(s)" for what is the ledger), and says so when there is no ledger yet.
- **Only your own world is visible (a correction, same day):** the saved file holds every world on the account, but a character sees, retires and restores only the
  ledger of the world being played in (the same ruleset, faction and guild). Atraeau never sees Morla's ledgers, nor those of another guild of the same faction.
  A retirement notice is only about the ledger of the receiver's own world. Retiring a ledger of a guild you have left is therefore done by logging in as a
  character of that guild; the saved file itself is the only place all of them can be seen.
- **Retiring is that guild's officer's act (a second correction):** a guild's ledger is retired only by pressing Retire (or typing `ledgers retire <n> yes`) as an
  officer of THAT guild: the game's "Is Officer" permission in the guild the character is in now, with the ledger being that guild's. Being the Guild Master or an
  officer of another guild gives nothing; a plain member is refused (the button is off and says why). A ledger with no guild is its owner's. Notices from other
  guilds' officers (the heartbeat also travels in a shared raid) are ignored: the sender must be an officer of this guild and the notice must name this guild's world.
  Nothing retires a ledger on its own: the expiry after 30 days only follows an officer's press, and a member can Keep it.
- **Not done:** the web simulator doesn't draw this page (the Guild book page isn't in it yet); cross-guild lists are still later.

### Ledger: an entry's item can be tried on (2026-11-06)

The guild master wanted to click an item in the Ledger and see it on their own paper doll. An entry that is about an item now carries it (`GuildBook.ItemOf`: an item link, or `item:ID`; what disenchanting gave belongs to the item that was disenchanted; a plain name has nothing to look up, so nothing is offered). Three ways in, all through the game's own dressing room (`DressUpItemLink`, else `DressUpLink`; it only shows the item, nothing is equipped or recorded):
- **Ctrl-click an entry**, as Ctrl-clicking an item link does everywhere in the game.
- A **Try it on** button beside the selected entry's record, shown only when the entry has an item.
- Hovering an item entry shows the item's own tooltip (with "Ctrl-click to try it on") instead of repeating the sentence; other entries still show their sentence in full.
If the game has neither function, the window says so. Which of the two dress-up calls this client prefers is untried: the exported API lists both.

### Lists: several changes are staged, previewed, and applied together with one reason (2026-11-06)

The Lists section could stage one move at a time and removed a player at once. It now stages **any number of changes** (moves and removals) in a pending-changes bar, which is the model the design asked for ("stage, preview, apply once with a reason"):
- **Stage, don't write.** Top, Up, Down, Bottom, a typed place, a drag onto a row, and Remove all only stage. The table shows the list as it would be (a moved player at the new place, marked with where they were; a removed player gone), and a line under the buttons says in words what is pending: "2 pending changes: Aldric Stormwind to place 1; remove Ilsa Greywater".
- **What you see is what is written.** The staged operations are applied in order, each against the list the earlier ones left, and the preview is a simulation of exactly that (`GuildBook.Simulate`), so a place number means the same in the preview and in the command. Re-staging a player replaces their earlier move where it stood in the sequence; staging the place they already hold clears it.
- **Apply all** writes each change as its own ledger entry (a `move` or a `remove`, as before) one after another, with the one reason you typed (required: it is part of the record). The ledger has no multi-change entry and none was added: a batch is several ordinary entries that share a reason, so nothing about the record's format changed. If one is refused, those already written are no longer staged and the rest stay, with a message saying where it stopped. **Discard** drops everything.
- The controls moved up to make room (a selected-player line with the place box, the buttons, the pending line, the reason and Apply all / Discard), so the table is a few rows shorter.

### Practice raiders have first and last names, and the Alliance has shamans (2026-11-06)

Practice raiders were single names ("Aldric", "Brann"), unlike every character in the game now. The 39 raiders of a practice raid and the 12 extra guild members now have a first and a last name ("Aldric Stormwind", "Brann Ironforge"), so the lists, the Ledger and the Loot window read as they will with real guildmates. This exposed a latent bug in the simulation: its policies and class/spec records are keyed by the canonical name (`First_Last`) but were looked up by the display name (`First Last`, with a space), so a two-part name found no policy (bots didn't bid) and no spec (the learner's own "Morla Megamule" didn't match its record either). Lookups now use the canonical name and fall back to the plain name a scenario writes. The 40-player roster also gains **4 shamans** (2 Restoration, 1 Enhancement, 1 Elemental; the Alliance can have shamans now), taking one each from Fury warriors, rogues, hunters and Fire mages; shamans are in the guild extras and in free play, and hybrids' off-spec rules cover them.

### Finding: the game restricts outgoing addon messages (2026-11-06)

The in-game self-check's one failure is "send+receive loopback: send failed: restricted", on both runs since the game released. The game's API documentation says `C_ChatInfo.AreOutgoingAddonChatMessagesRestricted()` "is controlled on a realm-by-realm basis (tournament realms allow it)", so this is not the temporary boss-encounter restriction the sync was designed around: on this client addons may not send messages to other players at all, which the ledger's sync (and the Master Looter's session messages) depend on. The self-check now prints a `comms` block (the restriction flag, the chat lockdown flag, every restriction state, and the game's raw answer to a send on each of WHISPER, PARTY and GUILD) so the next run shows exactly what is blocked and whether anything is open. No design change yet: the options are to wait if the setting is expected to change, or to design a fallback that does not need addon messages (to be decided from that output).

**Resolved the same day: the flag was wrong to trust, and we were blocking ourselves.** The probe's output on Forever: `AreOutgoingAddonChatMessagesRestricted = true`, `InChatMessagingLockdown = false`, every addon restriction state 0 (none active), and the game's raw answers to a send: WHISPER → Success, GUILD → Success, PARTY → NotInGroup (not in a group). So the game accepts addon messages while the flag says otherwise, and the client's own check (`send` refused when the flag was true) was what failed the loopback. Gargul (AceComm-3.0 over ChatThrottleLib, one prefix, `C_ChatInfo.SendAddonMessage` on RAID, PARTY, GUILD and WHISPER) and BigWigs never look at the flag: they send and read the result code, `AddOnMessageLockdown` (11) being the one that means "not now". `send` now does the same: the game's answer decides, a lockdown answer is `restricted` (queued and retried as designed), and the flag only feeds the self-check and the restriction-changed event. Whether messages actually arrive is for the self-check's loopback and a second player to show.

### Decision: a character's surname is the second value the game returns (2026-11-06)

The self-check the game itself ran on 2026-11-04 settled the question that had been open since names were designed: `UnitNameUnmodified`, `UnitFullName` and `UnitName` each return the first name and then the **surname as the second value**, in the slot a realm would fill (`"Coreander", "Shoeberry"`). The addon had assumed that second value was empty and kept only the first, so every character was known by their first name alone ("Coreander"); the guild master saw only a first name. The client now joins the two (`First-Last`, which the identity code already normalizes to `First_Last`) unless the first value already has both parts. The game's own folder names and chat names read the same way, so a name sent back (a whisper, a loot candidate) defaults to `First-Last`.
Where a roster or loot candidate arrives without a surname (the game may drop it for someone who shares yours, as it does a realm), the client completes it from the unit it belongs to, or from the one group member with that first name. The old test ledger on this account was founded as "Coreander", which is no longer the identity, so it has to be started again; nothing real had been recorded (the guild master confirmed).

### The record is called the Ledger, names are in class colors, an entry shows its raw record (2026-11-06)

Three decisions by the guild master about the Ledger section (until now called History):
- **It is the Ledger.** The section is named for what it is, the guild's ledger read as sentences, so there is one name and one place for the record. The id is `ledger`; the typed command is still `history` (an old habit that costs nothing to keep). The Admin tip now says "the record itself is the Ledger".
- **Names in class colors.** Each sentence is cut into plain words and people (`GuildBook.Segments`, the same `who` pieces the Loot window uses), a person carrying their class color from the lists' members and the group and guild. Only whole names match, longest first, and never inside an item link (the link is masked first), so "Blade of Aldric" doesn't color Aldric. The pieces travel with the entry, so the web page can draw the same colors.
- **A raw view for whoever wants it.** The simulator page showed each event with its kind, time, writer and id; the in-game rows are one dense line, so the detail is a panel instead: click an entry and the panel under the list shows the record itself (`GuildBook.Detail`): kind of entry, who wrote it, the date and how long ago, the list, the id with its chain and number, and every field the entry carries (a list of results reads as "3 Strange Dust"). The list loses some rows to the panel while it is on screen; the sentence stays one line.

### Decision: record what disenchanting actually gave (2026-11-06)

Who got an item to disenchant was recorded, but not what came of it, and the guild master called that an important thing to record. A new list event, **`DisenchantResult`** (`disenchant` = the id of the `Disenchant` event, `results` = 1 to 8 `{ name, count, item? }`), is written when the disenchanter has actually done it.
- **The Disenchant entry is never edited.** The outcome is its own entry that points at it, so the record keeps both "given to X to disenchant" and what came of it, and nothing is rewritten. History reads them as **one line**: "given to X to disenchant (waiting for the result)" until the result exists, then "X disenchanted [item] and got 3 Strange Dust". The result is a separate entry in the ledger, and the line in History shows its time.
- **Only the disenchanter can say.** The ledger rule: the reporter (`requestedBy`, else the author) must be the `to` of that Disenchant, once, with sane results; a Master Looter can't invent what someone else got. The disenchanter, not being an officer, can't write to the list, so their addon **tells the Master Looter** (a new request kind, `disenchanted`, whose request carries the Disenchant id and the results), whose addon writes it at once with `requestedBy` naming the reporter: there is nothing to decide, so it skips the queue. If the Master Looter is the disenchanter it writes directly.
- **Detected from the game, with a typed fallback.** A Disenchant cast (spell 13262) followed by the loot window it opens is read as the result (`disenchant.loot` in the game client); the oldest item waiting for that player gets it. Any other disenchant, with nothing waiting, is ignored silently. `disenchanted <what you got>` (and a form in Awards) does the same by hand: "3 Strange Dust, Soul Dust x2" or shift-clicked links. The detection is the one part not yet tried in the game (FIELD: confirm the spell id and that the result arrives as a loot window).
- **Practice** rolls a plausible result a few seconds after the practice disenchanter is given an item, so History shows both states.
- **Ledger surface.** A new event type and request kind: schema hash added to the baseline, compatibility baseline updated, **version line 0.5** (TOC 0.5.0). It is added to format 2 like `SetRaidList` was, not as a new format: nothing about any existing event's meaning changed, so no upcaster or cutover is needed, and an older client simply tells its player to update (0.4 and 0.5 don't work together). The guild master confirmed nothing real has been recorded yet, so no live ledger depends on this. A genuine format change (a new format 3 with an upcaster and a Migrate cutover) would be the way to test migration for real, and waits for a change that alters an existing event.

### Correction: moving an item in your order does not confirm it (2026-11-06)

The first version of the ranking panel sent the whole order the moment Up or Down was pressed, so a single move turned the panel to "Order set" and counted the player as answered while they were
still deciding. Moving an item now only rearranges a **draft** kept by whatever draws the window (the game window and the page each hold it, as a list of item ids per kind); the view model takes
it as `rankDraft` and shows the draft's order with `dirty` set. **Only Confirm sends the order** (the `rank` command), and only then does the panel read "Order set" and the player count as answered.
Moving an item after confirming un-sets the panel again (the session still holds the last confirmed order until they confirm the new one, so bidding closing on them uses what they last confirmed).
A draft that doesn't name exactly the items now ranked is ignored, and no draft is carried into a new round. The tooltips say moves aren't saved until Confirm.

### Docs review: wording, flow and links (2026-11-04)

No design change. Every relative link in the hand-written Markdown resolves; what was stale was the wording after the move to `src/<Addon>` and the later
work: the root README still said the game reads source directly (it reads the build, so a rebuild or `-Watch` is needed); the KingsGambit README's
`git subtree split` prefix lacked `src/`; the simulator README said CI only fails on out-of-date pages (a push to `main` now rebuilds and commits it);
the docs index and root README listed a sync lab but not the migration lab; `ledger-v2-design.md` still said "being built" and `Name-Realm`; this
journal's status line carried an old test count. The player guide gained the section "Who is asked about an item" for stat-affinity eligibility (decided
earlier: the 15% threshold, and a gift only checks the destination), which it had never described.

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

### Fix: the page's smoke test looked for buttons the page no longer has (2026-11-08)

The `tests` workflow's `page` job had failed on every push since 2026-11-06, when the page began drawing the Loot window from the same table as the game (buttons that carry their
action as JSON, `data-act="w"`). The smoke driver still looked for the old `confirm`, `decline` and `withdraw` buttons, so every lesson "never reached the confirm button" and the
job ran out its 30-second waits (about six minutes) before failing; each failed push mailed "deployment failed". The driver now finds those buttons by the action in their JSON
and skips grayed-out ones. (The page itself was working: the unit suite plays every lesson headlessly and passed throughout.)

### Decision: a pre-push check keeps a broken page off main; no pull-request rule yet (2026-11-08)

After the page's smoke test sat red for two days, the guild master wants broken pages prevented as the work iterates, without the overhead of a pull request for every change
(they are the only one working on the repository, so a required review would only slow things down; it can come later if others join).
- **`.githooks/pre-push`** (turned on with `git config core.hooksPath .githooks`, set in this clone) runs only when the push changes `src/KingsGambit`: the Lua tests, then the
  simulator page built from its sources, its JavaScript parsed, and every lesson played in a real browser (the machine's own Chrome or Edge, found automatically or named in
  `KG_BROWSER`). About 45 seconds. A failure stops the push and shows the end of the log; `git push --no-verify` skips it once.
- It says so, and does not block, when Node.js or Playwright is missing, so a clone without them still pushes (CI is the backstop either way).
- **Not done, on purpose:** requiring a pull request to change `main`. Revisit when someone else commits.

- **Practice's second row of buttons fits (a correction, 2026-11-08):** "Someone returns" was wider than its 104-pixel button and its label ran over the edge. The row is now 150 + 116 + 126 pixels (End the raid, Someone leaves, Someone returns), exactly the content width with the gaps.
- **"Wait 10 s" only while loot is out (the guild master's call, 2026-11-08):** waiting does nothing between bosses, so the button shows only while a session is running (its timers are what time moves).

### Decision: the stats open with the most active first, and a heading sorts (2026-11-08)

The Stats table listed players in their place on the list, which puts whoever has just won at the bottom, so the most active players were the hardest to see. It now opens sorted
by **activity**: most wins first, ties broken by the latest win, then the most raids attended, then the list's own order (so it is the same on every machine). Every heading is a
button: click one to sort by it, click it again to reverse it. A name starts A to Z (ignoring case); a count (wins, raids, time at the place, last win) starts with the most at the
top; "#" starts from first place. The heading sorted by shows `^` (ascending) or `v` (descending). Ties always fall back to the most active. The sort is a pure function
(`GuildBook.SortStats`), tested; the choice lasts while the window is open and the table opens on activity again next session. "Most activity" was read as wins first; say if it
should weigh raids attended more.

### Decision: the loot window shows who has bid on what, live, and it can be hidden (2026-11-08)

Answers are public by design (the manifesto and the guide say so), and the web page already shows them as they come in; the game's loot window showed only your own. It now lists, while
bidding is open, a line for each item: who said **Need**, **Off-spec** and **Gift** (names in their class colors, in list order), how many **passed**, and how many are **waiting
on**. The Master Looter reads it from the session; any other player from the host's public answers (which the host already sends to the raid), so everyone sees the same.
It is a list by item, not a grid of everyone by item, so a 40-player raid stays readable. A **Hide who has bid / Show who has bid** button above it turns it off for anyone who would rather
not watch, and the choice is remembered per character (`KingsGambitCharDB.bidsHidden`). It goes away when bidding closes (the draft shows who wins). The model (`UILoot` board, `LootView` `bids`) is
shared, so the page could draw the same lines.
- **Everyone's answer on an item: a tick box and a side panel (the guild master's call, same day):** the first version was a single compact line per item, which was too concise. Each item's name
  line now has an **Everyone** tick box (one item at a time), and ticking it opens a window beside the loot window that scrolls: a row per player, those who want it first (Need, Off-spec,
  Gift with who it is for, Pass, then those yet to answer), each with their place on the list. Unticking it, the panel's close button, hiding the bids, or bidding closing, shuts it. The
  per-item summary lines stay as the "bidding in progress" status. Still open: the loot window itself grows with the items (and stops at eight, mentioning the rest); the guild master
  pictures its item list scrolling instead.
- **The panel stays open, and its rows hold still (the guild master's call, same day):** it used to close when bidding did, and its rows were grouped by answer, so people jumped around
  as they bid. Now a ticked item's panel stays through the draft, the review and the result (until it is unticked or the next session starts, which clears the tick), so the answers can
  be read against who won. The rows are in a fixed order, the list's own, with each person's place; only the status on a row changes ("not answered yet", Need, Off-spec, Gift to
  someone, Pass). The summary lines above the items are still only for while bidding is open.
- **No separate hide button (the guild master's call, same day):** a "Hide who has bid" button next to a tick box per item was two ways to do one thing. The button, and its remembered setting
  (`bidsHidden`), are gone: the per-item Everyone tick box is the only control. The status line under each item shows while bidding is open; the side panel opens when an item is ticked.
