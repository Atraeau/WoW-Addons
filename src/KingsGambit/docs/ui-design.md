# King's Gambit — UI design (proposal, under review)

*Status: the two-surface structure (section 4, option B) was accepted on 2026-11-06 and is in the [design journal](design-journal.md); the
open questions in section 11 are not yet settled. The Loot window is built; the Guild book is started (2026-11-06: the shell, Lists and History in the game window). When a decision is accepted it goes into the
journal, and this file is updated to match. The rules themselves are in the
[rationale](rationale.md); this file is only about how people meet them on screen.*

## 1. Why redesign

The window we have grew by adding a button for every command, so its structure follows the command list, not the people using it.
Symptoms we have already hit: a Tools tab with groups of forms, a page for everything, one window that must serve a raider with five
seconds to answer and a guild master reorganizing lists. A good design starts from who is using it, when, and what they need to
get done, and only then decides what is on screen.

## 2. Who uses it, and in what moment

| Person | Moment | What they need | Pressure |
|---|---|---|---|
| **Raider** | An item drops; they are asked | See the item, answer in one click, know the answer was received, know when it is their turn | Seconds. Hands busy, possibly mid-fight. Must never block play |
| **Raider** | Between pulls / after a raid | Where am I on the list? Why did I lose that? What did I win? | None. Curiosity and trust |
| **Master Looter** | A boss dies | Start a session in one action, watch answers arrive, resolve, check the result, confirm | Time pressure, a raid waiting, errors are public |
| **Officer** | Between raids | Fix a list, add or remove players, correct a mistake, with a reason | Care. Must be deliberate, reversible, auditable |
| **Guild master** | Rarely | Found the ledger, appoint officers, migrate, set which list a raid plays | Low frequency, high stakes |
| **Anyone, new** | First time | Try it without a real group; understand what the buttons do | Needs confidence |

Two things follow. The **raider moment** and the **management moment** have almost nothing in common: one is fast, narrow and
time-boxed, the other is slow, wide and deliberate. And **most people are raiders most of the time**, so that is the surface that must
be right.

## 3. Standards we hold ourselves to

These are checkable, so each design below is reviewed against them (section 9).

**Usability heuristics (Nielsen).**
1. *Visibility of status*: always show where a session is (waiting for answers, whose turn, how long left) and what you answered.
2. *Match the real world*: use the guild's words (Need, Off-spec, Gift, Pass, the bottom of the list), the same as the rationale. No internal terms (`ledger entry`, `tier`, `enrollment`) on a raider's screen.
3. *User control and freedom*: change your answer until bidding closes; preview any list change and cancel it; undo a Master Looter award.
4. *Consistency*: the same action looks and is worded the same everywhere; same colors mean the same thing.
5. *Error prevention*: don't offer what can't work. A control that is unavailable is grayed with the reason on hover, never hidden (decided 2026-11-05); a name is picked, never typed.
6. *Recognition over recall*: item links, class icons and colors, tooltips; nothing needs a remembered command.
7. *Flexibility*: the common path is one click; shortcuts (hotkeys, modifier-click) exist for the experienced, never required.
8. *Minimalist design*: show only what the current moment needs; the rest is one step away (progressive disclosure).
9. *Help recover from errors*: say what happened and what to do, in plain words.
10. *Help and documentation*: tooltips explain the rule, not just the button; practice mode is the tutorial.

**Interaction laws.** Fitts: the main action is large and near where the eye already is; destructive ones are small and apart.
Hick: few choices per moment (a raider has four answers, never more). Miller: no more than about seven things grouped together.
Doherty: every click acknowledged within 100 ms (a pressed state, then the real state).

**World of Warcraft conventions.** Look like the game (Blizzard frame styles, fonts, tooltips) so it feels native. Movable, remembers
its place, scales with the user's UI scale, Esc closes it. Never steal keyboard focus, never open a modal that blocks play, don't open
during combat unless it is the prompt the player is waiting for. Respect combat lockdown (no protected-frame changes in combat).
Dim and slim by default, bigger on request.

**Accessibility.** Never color alone (an icon or letter as well: Need `N`, Off-spec `O`, Gift `G`, Pass `P`); contrast of at least 4.5:1
for text; no text under 12 pt; every function reachable by mouse; common ones by keyboard; sound is optional and off by default;
a size option for the loot window.

**Honesty of state.** A screen must say whether something is a **preview** (staged, nothing recorded), **pending** (sent, waiting
for the Master Looter), or **recorded** (in the ledger). This is the rule that matters most for an auditable ledger.

## 4. Information architecture: the alternatives

**A. One window with tabs (what we have).** Simple to find, one thing to learn. But it forces both moments into one frame: the raider
gets management they can't use, officers get a layout shaped by the loot flow, and the window is big enough to cover the game while
bidding. *Rejected.*

**B. Two surfaces by task.** A small **Loot window** for the live session (everyone) and a **Guild book** for lists, history and
administration (opened on purpose). Matches the two moments. Cost: two things to build and a clear boundary between them.

**C. Three surfaces by role.** A tiny raider popup, a separate Master Looter console, and a management window. Every role gets exactly
its own thing. But the raider popup and ML console are the same session seen by two people, and splitting them duplicates logic and
means the Master Looter, who is also a raider, juggles two windows. *Rejected in favor of B with a role-aware strip (below).*

**D. No management window; work in place.** Tooltips show your place and whether you would be asked, right-click a name in the raid
frame or chat to act on it, modifier-click an item to start a session (Gargul's approach). Lowest footprint, and it reaches people
where they already are. But lists, history and rules need a real overview that does not belong to any one item or name, and in-place
menus are hard to discover. *Good as a complement, not as the whole answer.*

| | Raider flow | ML flow | Officer work | Discoverable | Build cost |
|---|---|---|---|---|---|
| A one window | poor | ok | ok | ok | done |
| **B two surfaces** | **good** | **good** | **good** | good | medium |
| C three surfaces | good | good | good | ok | high |
| D in-place only | good | good | poor | poor | medium |

**Recommendation: B, plus the light touches from D.** Two surfaces, a role-aware Loot window, and a few in-place helpers.

## 5. The surfaces

### 5.1 Loot window (the live session)

Opens by itself when a session starts, closes when it ends, can be reopened with `/gambit loot`. Compact, no tabs, no scrolling for
the usual one to four items (a scroll list takes over past that). One row per item.

```
┌─ King's Gambit ─ Ragnaros ─────────── 0:24 ▮▮▮▮▯ ─ x ┐
│ [icon] Sulfuras Hand      you may need   [N] [O] [G] [P] │  <- waiting for you
│ [icon] Band of Accuria    not for you          (G) [P]   │  <- Need/Off grayed with reason
│ [icon] Eye of Divinity    you: Need ✓      change ▾      │  <- answered; can change
│                                                          │
│  Draft order:  Kirk ▸ Aleria ▸ Bo …      Your place: 12  │
└────────────────────────────────────────────────────────┘
```

States, each of which must look different at a glance:

| State | What the raider sees |
|---|---|
| Bidding | Rows with four answers; timer; a count of "6 of 20 answered"; their own answer marked |
| Waiting | Their answers locked in view; "waiting for the others"; who is still out |
| Your turn | The row lights up, a clear "Your turn: pick one", a short timer; the others dim |
| Someone else's turn | Who is up, what they chose when they choose, in order |
| Salvage offer | "Nobody wanted this. Claim it or decline." Two buttons |
| Gift target | "You won a gift. Who gets it?" A dropdown of the eligible, plus keep/withdraw |
| Result | Who got what, where each moved on the list, what you won; then it fades |

**Master Looter strip.** The same window, with one extra row only for the person running it: Start from loot window, Add time, Resolve
now, Confirm, Cancel. Others see the window without it, not with the buttons grayed (here the layout is *not* held constant because the
strip is a different role's area, and a raider needs the space; the grayed-button rule applies to actions a person may do elsewhere).
After the draft the strip becomes **Review**: exactly what will be recorded, with Confirm and Cancel. Nothing is recorded before that.

**Why a raider's window must not have rule text, lists or history.** Every extra thing is a second to read. Rule text lives in tooltips;
lists and history live in the Guild book.

### 5.2 Guild book (lists, history, administration)

Opened with `/gambit`, a minimap/launcher button, or from the Loot window. Larger, calm, a master–detail layout: a short navigation
column on the left, content on the right, the way Blizzard's own Group Finder and Character panes work.

```
┌─ King's Gambit ───────────────────────────────── x ┐
│ Lists        │  Main list            [Which list ▾]  │
│ Raids        │  #  Player       Class   Last win      │
│ People       │  1  Aleria       ▣ Pal   2 weeks ago   │
│ History      │  2  Bo           ▣ War   …             │
│ Rules        │  ...                                   │
│ Practice     │  ┌ Selected: Bo ────────────────────┐ │
│              │  │ Move  Remove  Record a win        │ │
│              │  └──────────────────────────────────┘ │
│              │  ● 1 pending change  [Apply] [Discard] │
└──────────────────────────────────────────────────┘
```

| Section | For | Contents |
|---|---|---|
| **Lists** | everyone reads, officers change | The list as a scroll table; sort and drag; the selected player's actions in a detail panel (not a toolbar above everyone) |
| **Raids** | officers | Open or close a raid, choose its list and Master Looter |
| **People** | officers, guild master | Roster from group and guild, classes, officers, designated disenchanter |
| **History** | everyone | The ledger as readable sentences: *"Kirk won Sulfuras, moved 3 → 40, 12 Nov, by Aleria"*, filterable by player and item; a "why am I here?" view for the player's own position |
| **Rules** | guild master, officers | Item value, eligibility overrides, defaults; each shown with its effect |
| **Practice** | anyone | Start or leave a simulated raid |

A change to a list is **staged** (the pending-changes bar), previewed in the table, and applied as one recorded entry with a reason;
this keeps the staged-move model already built. Dangerous or rare actions (founding the ledger, migration) are in a clearly separate,
confirmable place, never next to everyday ones.

### 5.3 Practice mode

Not a tab. A persistent, obvious **banner** on every window ("Practice: nothing here is saved or sent") and a way out in one click, so a
person never wonders whether the action was real. It drives the same Loot window with simulated raiders, so what you practise is
exactly what you will use.

### 5.4 In-place helpers (from the Gargul-style approach)

Small, optional, and each reachable another way:
- **Tooltips** on items: "King's Gambit: you would be asked (main)" or "not for your class", and your place on the list.
- **Launcher button** (minimap or Titan/ChatThrottle-style data broker) that shows your place and opens the Guild book.
- **Master Looter shortcuts**: modifier-click an item in the loot window, a bag or a chat link to start a session or record a win.
  Replaces the Award form's typed item, and builds on what we have for shift-click links.
- **Right-click a name** in the Lists table for that player's actions (the same ones as the detail panel).
- **Hotkeys** in the Loot window (e.g. `1`–`4` for the four answers while it has the mouse over it), off by default, shown on the buttons.

## 6. Visual language

- Native Blizzard frame, title bar, close button and fonts; 8 px spacing grid; item icon with a quality-colored border; class color
  plus a class icon on every name.
- A small set of semantic colors: *answerable* (neutral buttons), *your turn* (gold), *recorded* (green check), *preview* (dashed or
  blue border), *unavailable* (gray + reason on hover). Color is always paired with an icon or word.
- The timer is a bar plus seconds; it turns amber under ten seconds, and never flashes.
- Motion is minimal: a short highlight when your turn begins, a fade at the end. No bounce.

### Layout rules (applied to the Loot window, 2026-11-06)

A window that works but looks cramped fails the "professional" bar, so these hold for every window we build:

1. **One grid.** A 16 px margin all round, an 8 px unit of spacing, one content width, and widths that divide it (four equal buttons across a row and across the Master Looter's strip). Nothing is placed by eye.
2. **Heights follow the text.** A wrapped line is measured, not guessed, so a message that runs to three lines pushes things down instead of overlapping them.
3. **Proximity and grouping.** What belongs together sits together, groups are separated by thin dividers and a small heading (the turn, your order, the items, the Master Looter, practice), and the space between groups is larger than the space within one.
4. **Hierarchy.** The item (what is being decided) is the most prominent; status and counts are small and muted; one short sentence says what to do now (long explanations live in tooltips).
5. **Alignment.** Left edges line up down the window. An item is its name on its own line and the choices across the full width beneath it; no narrow side columns where text has to wrap.
6. **Consistent controls.** Buttons in a row are one size; the primary action of a group is in the same place every time (Confirm on the right of its heading).
7. **State is shown by the game's own idioms**: a choice is a push-button toggle held pressed in (the game's micro-menu, Damage Meter and Edit Mode buttons do exactly this, with `SetButtonState("PUSHED", true)`), reinforced with an inset bevel where the game's pressed art is faint (the label itself is left alone). Never by a color change of text alone, and no decorative marks (a stray tick or brackets looked unprofessional); the pressed button itself says what was chosen, so the choice is not repeated in words. A control that isn't drawn is cleared so nothing carries over.
8. **Say a thing once.** Repeating a state in words next to the control that already shows it (an "Off-spec" label above a pressed Off-spec button) is noise.
9. **A state mark must tell things apart.** A highlight that applies to every row at once says nothing and only adds weight (the selected-row band was tried, and when every item was answered the whole window went gray); use a mark only where it distinguishes one thing from another.

## 7. How the website simulator stays the same as the game

The rules are already shared: the page runs the addon's real engine files. The window can be shared at the level that matters most by
a small change in structure:

1. **View models** (pure Lua, no frames): for the Loot window, the Guild book sections and History, each a function from the
   engine's state and "me" to a plain table: rows, which buttons are enabled and why, the text and tooltip ids, the current state
   name. Much of this exists (`UI.Model`, `UILoot.Model`, `UITools.Compose`, `UITips.TEXT`) and gets consolidated.
2. **Two renderers** that only draw a view model: Blizzard frames in the game, HTML on the page. All decisions live in the view model,
   so there is nothing for the renderers to disagree about.
3. **A parity test**: replay a scripted session, snapshot the view model at each step, and fail CI when the engine's behavior or the
   model changes without an updated snapshot. The Blizzard renderer is tested for "draws every field of the model"; the HTML one the
   same.

What will differ: fonts, window chrome and exact pixels (the page cannot use WoW's templates), and drag, tooltip and scroll feel.
The aim is the **same screens, the same states, the same words and the same enabled/disabled logic**, not pixel identity.

**A practical benefit.** I can see and test the web page but not the game. Designing and refining the layouts on the page first, then
porting the renderer to Blizzard frames, shortens the loop (the game then needs only a confirmation pass instead of many
screenshots).

## 8. Alternatives considered for individual choices

| Question | Chosen | Alternative and why not |
|---|---|---|
| How is a raider asked? | Auto-opening compact window | Chat prompts only (no clear state, easy to miss); fullscreen overlay (blocks the game) |
| Where does the list live? | Guild book | Inside the Loot window (clutters the time-pressured moment) |
| Acting on a player | Select a row, act in the detail panel, plus right-click | Toolbar above the table (acts on a selection you may have lost); a form of typed names (error-prone, rejected) |
| Changing the list | Stage, preview, apply once with a reason | Write each click (noise in the record, rejected 2026-11-05) |
| Unavailable actions | Grayed with the reason | Hidden (looks like a missing feature, rejected 2026-11-05) |
| History | Readable sentences with filters | Raw entries (accurate, but nobody reads them) |
| Master Looter control | Role strip in the same window | A separate console (two windows for one session) |
| Sound and flash on a new session | Off by default, soft sound option | On (raid noise, accessibility) |

## 9. How we will check it

1. **Heuristic review** against section 3 for each state of each surface, recorded as a checklist in this file.
2. **Scripted walkthroughs** in practice mode for each person in section 2: the raider answers four items in under ten seconds; the
   Master Looter runs a boss start to confirm; the officer fixes a mistake and finds it in History; the guild master founds a ledger.
3. **A guild test**: two or three real raiders use it in a real run and we note where they hesitate. Hesitation, not praise, is the signal.
4. **Regression**: the parity snapshots, and the existing tests.

## 10. Order of work

1. Settle this document with the guild master (the open questions below).
2. Journal the accepted decisions.
3. Extract the **Loot view model**, build the Loot window on the web page, refine it there, then port its renderer to the game.
4. Rebuild the **Guild book** (Lists, then History, then People, Raids, Rules) the same way.
5. Retire the old tabs window, keeping `/gambit` for the Guild book and the Loot window for sessions.
6. Add the in-place helpers.

*Status (2026-11-06): step 3 is done. Step 4 is started: the navigation shell, Lists (the older standings page), History, and the former Tools forms split into Awards, Raids, People, Rules and Admin are in the game window. Practice as a section, the page renderer for the Guild book, and staged list changes are still to do.*

## 11. Open questions

1. Is two surfaces (recommended) right, or do you want the three-role split?
2. Should the Loot window open on its own for everyone, or only ask (a small toast to open it)? Recommended: opens on its own, since a missed prompt costs a raider their turn.
3. How much of the History view should be public to every raider? Recommended: all of it, since the record is already visible to the guild.
4. Hotkeys for answering: want them at all?
5. A launcher/minimap button: yes, and should it show your place?
6. Which comes first: the Loot window (most used) or the Guild book (most is already built)? Recommended: Loot window.
