# Suicide Kings — Design Journal

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
  two clients prove they agree (or detect desync/corruption) cheaply.
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
  (2) standings UI + manual ops, (3) sync, (4) loot session + draft, (5)
  transparency + corrections/trades, (6) external sync, (7) polish.
- Verification leans on **deterministic replay unit checks** (replay a crafted
  event log, assert the standings), multi-client convergence tests, and
  validating every WoW API call against the exported `docs/api.json`.
