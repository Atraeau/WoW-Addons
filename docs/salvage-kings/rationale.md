# Salvage Kings — Rationale & Player Guide
n*Salvage Kings is derived from the classic Suicide Kings strategy and named for the bottom-of-the-list "salvager" role. "Suicide" below still means dropping to the bottom after a win.*

*How loot works in our raids, and why. Read the [manifesto](manifesto.md) for the
values behind it and the [design journal](design-journal.md) for how each rule
was decided.*

---

## How it works in 60 seconds

1. **One list.** Everyone in the guild has a position on a single, shared list.
   Top of the list = longest since you last won something.
2. **Something drops.** A small, unobtrusive popup asks: **Need**, **Off-spec**,
   **Gift**, or **Pass**. You make the call live. Nothing is decided in advance.
3. **Highest position among those who want it wins.** If you win, you move to the
   **bottom** of the list. That is the *only* thing that ever changes your
   position.
4. **Passing is always free.** Pass for any reason: it doesn't cost you anything.
5. **Everything is recorded** in a shared, tamper-evident log the whole guild can
   see and verify.

That's the whole game. The rest of this document explains the edge cases and the
reasoning.

---

## The rules, and why

### Your position is your currency
Your position changes only when you win an item. No decay for being
absent, no bonus for attendance, no penalty for passing.

**Why:** It keeps the system predictable and drama-free. Anyone can look at the
list and know exactly why it looks the way it does.

### Needing an item
Among everyone who bid *Need*, the highest position wins and drops to
the bottom.

**Why:** One rule, applied the same way every time, is easy to follow and hard to
game. Nobody has to argue about who "deserves" it.

### Several items at once (the draft)
When a boss drops multiple items, the top remaining needer picks any
available item, claims it, and drops to the bottom; then the next player up picks.
There's no cap, so if the room passes you can win again from the bottom.

**Why:** The first pick is an *earned* choice, and there is no arbitrary
item order for anyone to benefit from.

### Off-spec
Off-spec bids use a separate, persistent off-spec list. Winning off-spec
moves you down *that* list only. A main-spec bid always beats an off-spec bid.

**Why:** Off-spec has a real cost (your off-list position), but it can never
jump ahead of someone who needs the item for their main. Otherwise it would be a
free way to dodge spending your main position.

### Gifting
Gifting is *winning and then handing the item to someone else*, in any
direction, including upward. You pay the position cost; the recipient gets the
item. You can change the target before the item resolves, or re-route it
afterward.

**Why:** A minor upgrade shouldn't be wasted just because the player who'd use
it sits too high to bid economically. A player near the bottom can claim it cheaply
and pass it up. Because the cost is real, it can't be gamed, and generosity is
recognized in the record.

### When nobody bids (the backstop)
Items with no Need or Off-spec bids are offered in *reverse* order
(lowest position first) to everyone, whether or not they can use the item. The
claimer drops to the bottom (nearly free for someone already there) and can keep it,
gift it up, sell it, disenchant it, or donate it to the guild bank. If everybody
passes, it goes to the Master Looter or the designated disenchanter, and then to
the guild bank.

**Why:** Usable loot should find a home, not a shard. Offering lowest-first keeps
high-position players from farming scraps. We rejected a free roll because a
costless roll can be gamed by collusion.

### Item value
We don't assign items a score or rank.

**Why:** An item is worth whatever someone will spend on it. Minor items clear
cheap, best-in-slot clears dear, and the standings reveal the difference.

### Hoarding
We don't penalize it. We make it visible: last win, passes on upgrades,
raids since last win, time at position, and an officer "camp-watch" flag.

**Why:** Penalties punish legitimate passes (an item that doesn't fit your
playstyle, or one you're leaving for a friend). Visibility lets the guild hold
itself accountable without a mechanic that punishes the wrong thing.

### Mistakes and regret-trades
Mistakes are fixed forward. A recent award can be undone exactly; older
ones are corrected by an officer with a visible correction event. If someone
trades an item away after winning it, the addon detects it: if the recipient had
bid, it's treated as a *mistake correction* (the giver is restored, the recipient
pays); if they hadn't, it's a *gift* (standings unchanged). Either can be
overridden.

**Why:** History is never silently rewritten, so corrections are as visible as
the original decisions, and the default matches what usually happened.

### The record and the officers
Every decision is an entry in an append-only, hash-chained log, synced
across the guild. Officers run the process; they don't decide who deserves loot.

**Why:** Trust comes first. Anyone can verify that their copy matches everyone
else's.

---

## What this system does *not* do

- **It is not an optimizer.** It won't guarantee that the "best" item reaches the
  "best" use. It guarantees a fair, transparent process.
- **It doesn't replace culture.** It makes behavior visible; people still choose
  how to behave.
- **It isn't trustless.** It assumes officers act in good faith. The log catches
  mistakes, dropped messages, and desync, not a determined bad-faith officer.

---

## Glossary

- **Suicide:** moving to the bottom of the list after winning.
- **Position / standing:** where you sit on the list.
- **Need / Off-spec / Gift / Pass:** your response when an item drops.
- **Draft:** the ordered picking when several items drop at once.
- **Backstop:** the lowest-first offer for items nobody bid on.
- **Salvager:** whoever claims a backstop item and decides its fate.
- **Camp-watch:** an officer flag for players whose pattern suggests hoarding.
- **Fix-forward:** correcting mistakes with new visible entries, not edits.
