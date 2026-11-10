# King's Gambit — Rationale & Player Guide

Inspired by Suicide Kings, King's Gambit is a list-centric loot system, valuing transparency, agency and fairness. Where it is distinct is through how it attempts to address one of the most painful flaws in Suicide Kings: wasting useful loot.

## The strengths of Suicide Kings

Suicide Kings (SK) is a low-maintenance system that rewards loyalty and attendance. Every raider has a genuine opportunity at every item, the rules are
identical from one raid to the next, and leadership applies them rather than adjudicating them. The alternatives each carry a cost. Dragon kill points (DKP)
require someone to maintain a balance for every player; a loot council makes fairness contingent on the council; and random rolls, including "soft reserve",
rely on chance, which is fair in aggregate but feels arbitrary when one player wins twice in succession while another loses ten times. SK is, in effect,
round-robin distribution in which a player's place persists between raids, so loot spreads evenly across those who attend. King's Gambit retains all of this.

## The limitations of Suicide Kings

1. **Useful loot is wasted.** Because a win costs the winner their position, experienced players withhold their bids for the best-in-slot (BiS) item and pass
   on every other piece, including items that would still benefit them. When no one lower on the list bids, a useful item is disenchanted.
2. **The conventional remedy introduces an exploit.** Awarding a free roll when all players pass allows a group to coordinate their passes and then roll for an
   item at no cost.
3. **Legitimacy rests on a single officer's list.** In most guilds the list is a spreadsheet or an addon note kept by one officer. When a position appears
   incorrect, or an item is traded after the raid, there is no independent record against which to verify it, and no clean way to correct it.
4. **Players are asked about everything.** Prompts for equipment a player cannot use obscure the decisions that matter.

## How King's Gambit responds

| Limitation of SK | The King's Gambit mechanism | Effect |
|---|---|---|
| A player passes on a side-grade to preserve their position, and it is disenchanted | **Gifting:** the winner may give the item to any player, in any direction. The winner bears the positional cost; the recipient receives the item. | A minor upgrade reaches a player who can use it, even when that player is too high on the list to bid economically. Gifting is optional and always visible. |
| No one bids, so the item is rolled or lost | **Salvage:** the item passes to the player at the bottom of the list at that moment, who may keep, gift, sell, disenchant or bank it. | Because there is no roll, collusion yields no advantage. The recipient is determined by the list, not selected by the group, and the position rotates as players win. |
| The list is whatever the officer reports it to be | **A shared, tamper-evident ledger:** every win, move and correction is an entry that each player holds and can verify. | The record can be audited rather than merely trusted, and anyone can see why the list appears as it does. |
| A mistake requires rewriting history | **Corrections made forward:** any of the Master Looter's awards can be reversed exactly; an after-the-fact trade is detected and recorded as a correction or as a gift. | Corrections are as visible as the original decisions, and the default reflects what usually occurred. |
| Players are asked about equipment they cannot use | **Eligibility:** a player is asked only about items their class and specialization could use. | Fewer prompts, so that meaningful decisions are not obscured. Eligibility determines who is asked; it never determines who wins. |
| Wishlists and officers decide in advance | **Live decisions by the player,** made after the drop. Officers administer the process and do not determine who deserves loot. | Each choice is made with knowledge of that drop, by the person it affects. |
| Several simultaneous drops are contested | **A draft** with each player's ranking submitted in advance, **a separate off-spec list**, and main-spec always taking precedence over off-spec. | Picks occur in a fair order, item order confers no advantage, and an off-spec bid can never displace a player who needs the item for their main specialization. |

Passing carries no cost. A player's position falls only when that player wins, and every other player's win raises it. None of this complicates the system for the
raider, who still needs to learn one rule and four responses.

*How loot works in our raids, and why. Read the [manifesto](manifesto.md) for the values behind it and the [design journal](design-journal.md) for how each
rule was decided.*

---

## How it works in 60 seconds

1. **One list.** Every member of the guild holds a position on a single, shared list. The top of the list belongs to the player who has gone longest without
   winning an item.
2. **An item drops.** A small, unobtrusive window asks each eligible player to respond: **Need**, **Off-spec**, **Gift** or **Pass**. Responses are made at the
   time of the drop; nothing is decided in advance.
3. **The highest position among those who want the item wins.** The winner moves to the **bottom** of the list. Winning is the only way a player's position
   falls.
4. **Passing is always free.** A player may pass for any reason at no cost.
5. **Every action is recorded** in a shared, tamper-evident log that the whole guild can inspect and verify.

This is the complete procedure. The remainder of this document sets out the edge cases and the reasoning.

### What King's Gambit adds to Suicide Kings

The table above gives the reasoning; the list below summarizes what King's Gambit adds.

- **Gifting as a rule (the principal difference).** A winner may give the item to any player, in any direction, including upward. The winner pays the positional
  cost and the recipient receives the item. A minor upgrade is not wasted because the player who would use it sits too high to bid, and generosity is
  inexpensive, never required, and visible.
- **A ledger rather than a maintained list.** Every change is an entry in a shared, tamper-evident record that each player holds and can verify.
- **Live decisions by the player,** made after the drop. There are no wishlists, and officers administer the process without deciding who deserves loot.
- **A separate off-spec list,** with main-spec always taking precedence over off-spec.
- **A draft** for several simultaneous drops, with each player's ranking submitted in advance.
- **A salvage round** in place of a roll when no one bids: the player at the bottom of the list decides.
- **Eligibility:** a player is asked only about items they could use.
- **Free passing,** with a player's position falling only through a win.
- **A list per raid,** and every correction and disenchant result recorded in the open.

---

## The rules, and the reasoning behind them

### Position is the only currency
A player's position falls only through winning an item. There is no decay for absence, no bonus for attendance, and no penalty for passing. (Other players'
wins raise a player's position relative to the winners; this is a consequence of their wins, not a cost to the player who passes.)

**Rationale:** The system remains predictable and free of dispute. Anyone can examine the list and understand exactly why it appears as it does.

### Needing an item
Among all players who responded *Need*, the highest position wins and drops to the bottom.

**Rationale:** One rule, applied identically every time, is easy to follow and difficult to exploit. No one has to argue about who "deserves" the item.

### Who is asked about an item
Only players who could actually use it. The addon verifies that the item is equippable by the player's class and that it carries a sufficient share of the
stats that the player's specialization values (a warlock is not asked about a blade made of strength and agility). The threshold is deliberately generous (15% of
the item's stat weight), because a small upgrade can still be a choice a player wishes to make. An officer may override the default for a particular item, and the
override is a visible entry in the record. The same check applies to a *gift*: it requires only that the recipient be eligible, never the giver.

**Rationale:** Asking every player about every item obscures the decisions that matter. Eligibility filters who is asked; it never determines who wins.

### Several items at once (the draft)
When a boss drops multiple items, the highest-ranked remaining player who needs an item chooses any available item, claims it, and drops to the bottom; the next
player then chooses. There is no cap, so if the room passes, a player may win again from the bottom.

**Players rank their preferences in advance.** A player who responds *Need* (or *Off-spec*, or *Gift*) on two or more items is asked to place them in order,
most wanted first, and to confirm the order; the session waits for this, so bidding cannot close before the player has ranked. When the player's turn arrives,
the draft takes the highest-ranked item that remains available, without a prompt and without time pressure. (If the timer expires before the player has
ranked, the player is asked at the time of their turn, as before.) Whispering the Master Looter is equivalent: the order written is the ranking ("need 3, need 1"
ranks item 3 first).

**Rationale:** The first pick is an *earned* choice, and no arbitrary item order confers an advantage.

### Off-spec
Off-spec bids use a separate, persistent off-spec list. Winning off-spec moves a player down that list only. A main-spec bid always takes precedence over an
off-spec bid.

**Rationale:** Off-spec carries a genuine cost (a player's position on the off-spec list), yet it can never displace a player who needs the item for their main
specialization. Otherwise it would be a free means of avoiding the cost of spending one's main position.

### Gifting
Gifting is *winning an item and then giving it to another player*, in any direction, including upward. The giver pays the positional cost; the recipient
receives the item. The giver may change the target before the item resolves, or re-route it afterward, and may also leave the target open and choose upon
winning, in which case the draft waits for the choice.

A gift is a proxy rather than a want, so it ranks **after** every player who wants the item: main-spec (need) bids are drafted first, then off-spec, then gifts.
Even a gift from the bottom of the list, which costs nothing, cannot override an off-spec bid.

**Rationale:** A minor upgrade should not be wasted merely because the player who would use it sits too high on the list to bid economically. A player near
the bottom can claim it at little cost and pass it upward. Because the cost is real, the mechanism resists abuse, and generosity is recognized in the record.

### When no one bids (the salvage round)
Items that receive no Need or Off-spec bids go to the *salvager*, the player at the bottom of the list at that moment, whether or not that player can use the
item. The salvager decides: claim it (and keep it, gift it onward, sell it, disenchant it, or donate it to the guild bank) or decline, in which case it goes to
the designated disenchanter and the guild bank. No one else is asked, and there is no second round of offers up the list.

**Rationale:** Usable loot should find a home rather than become a shard. The player at the bottom serves as salvager because dropping to the bottom costs them
no position, and no one higher on the list is asked to give up a place for an item that no one wanted. A free roll was rejected because a costless roll can be
exploited through collusion.

### Which list a raid plays on
By default there is a single list, `main`. When an officer opens a raid, the officer may name another list (for example `20man`), and that raid's Master Looter
then writes only to it: wins, passes and the draft all occur on that list, and the winner drops to the bottom of **that** list, not the others. A new list begins in
`main`'s order, so the record of who has waited longest carries over. The ledger owner may require every raid to have a list of its own
([ledger owner's guide](ledger-owner.md)), so that no one can spend the wrong list by accident.

**Rationale:** A raid has a quality ceiling, and loot from an earlier tier should not cost a place that loot from a later tier is worth. The choice is made once,
at the start, by an officer, and is recorded; it does not change part-way through a raid.

### Item value
Items are not assigned a score or rank.

**Rationale:** An item is worth whatever a player is willing to spend on it. Minor items clear cheaply, best-in-slot items clear dearly, and the standings reveal
the difference.

### Hoarding
Hoarding is not penalized. It is made visible: last win, passes on upgrades, raids since last win, time at position, and an officer "camp-watch" flag.

**Rationale:** Penalties punish legitimate passes (an item that does not suit a player's playstyle, or one left for a friend). Visibility lets the guild hold
itself accountable without a mechanism that penalizes the wrong behavior.

### Mistakes and regret-trades
Mistakes are corrected forward. Any award by the Master Looter can be undone exactly, in isolation, without disturbing the awards made since; awards from before
a manual move are corrected by an officer through a visible correction entry. If a player trades an item away after winning it, the addon detects the trade: if
the recipient had bid, it is treated as a *mistake correction* (the giver is restored and the recipient pays); if not, it is treated as a *gift* (standings
unchanged). Either interpretation can be overridden.

**Rationale:** History is never silently rewritten, so corrections are as visible as the original decisions, and the default matches what usually occurred.

### The record and the officers
Every decision is an entry in an append-only, hash-chained log that is synchronized across the guild. Officers administer the process; they do not decide who
deserves loot.

**Rationale:** Trust comes first. Any player can verify that their copy matches everyone else's.

---

## Running a loot session (for the Master Looter)

This section describes what occurs, in order, when a boss drops loot. Practice it in the [simulator](../simulator/README.md) before the real thing.

1. **Put the items up.** The addon picks up what the Master Looter sees in the loot window (an item may also be added by link). Raiders without the addon receive
   a short announcement in raid chat and answer by whisper ("1 need", "2 off", "1 pass", "1 gift Name").
2. **Bidding.** Each player responds to each item: Need, Off-spec, Gift or Pass. Responses are public. The timer ends early as soon as every eligible player has
   responded; a player who has not responded when it expires is counted as passing. The Master Looter may add time or close bidding.
3. **The draft.** The highest-ranked player who wants an item goes first. If that player wants only one item, it is awarded automatically; if several, the player
   chooses one (a choice that times out counts as a skip). The next player then proceeds, and so on, until no one wants what remains. Off-spec bids come into
   play only for items that no main-spec player wanted, and gifts follow, for items that no one wanted for themselves.
4. **Salvage.** Items that no one wanted go to the salvager, the player at the bottom of the list, whether or not that player could use them. The salvager
   claims the item or declines, in which case the disenchanter takes it. No one else is asked. This occurs as the draft executes: every pick drops its winner to
   the bottom, so the next unwanted item goes to the player who has just picked, and the salvager role rotates in the order of the draft. Unwanted items remaining
   after the draft (more than there were picks) go to the lowest player, who, because claiming at the bottom costs no position, may take several.
5. **Review, then confirm.** The Master Looter sees exactly what will be recorded. Nothing is written to the ledger and nothing is handed out until the Master
   Looter confirms. If handing over an item fails, that award is not recorded and the Master Looter is informed, so the record never claims something that did not
   happen.
6. **Correct mistakes in the open.** Any one of the Master Looter's awards can be undone exactly, without disturbing those made since. Older awards are corrected
   by an officer's correction, which is itself a visible entry in the history.

## What this system does *not* do

- **It is not an optimizer.** It does not guarantee that the "best" item reaches the "best" use. It guarantees a fair, transparent process.
- **It does not replace culture.** It makes behavior visible; people still choose how to behave.
- **It is not trustless.** It assumes that officers act in good faith. The log detects mistakes, dropped messages and desynchronization, but not a determined
  bad-faith officer.

---

## Glossary

- **Suicide:** moving to the bottom of the list after winning.
- **Position / standing:** a player's place on the list.
- **Need / Off-spec / Gift / Pass:** a player's response when an item drops.
- **Draft:** the ordered selection that takes place when several items drop at once.
- **Salvage round:** the offer, to the lowest-ranked player first, of items that no one bid on.
- **Salvager:** the player who claims a salvage item and decides its fate.
- **Camp-watch:** an officer flag for players whose pattern suggests hoarding.
- **Fix-forward:** correcting mistakes with new visible entries rather than edits.
