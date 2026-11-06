# King's Gambit — Guild master's guide

Everything the guild master can configure, what each option is for, and how to use it. Every one of these is an entry in the
shared ledger, not a private setting, so **every client enforces it the same way**, and anyone can see who chose what and when
(`history`, or the audit tool). Nothing here can be changed quietly.

**The windows.** Type `/gambit` to open the Guild book: a column of sections down the left (Lists, History, Awards, Raids, People, Rules, and Admin below them), with a form for every
command below spread across them. A running loot session has its own small **Loot window**, which opens by itself when a
session starts (`/gambit window`, or the Loot window button, brings it back). The commands shown in this guide are what those forms and buttons run, so either way works,
and the foot of the window shows what the command answered, including why a refusal was refused. **Practice** runs all of it on a simulated raid and guild
that is never saved or sent. `/gambit help` lists the commands.

*Who can do what, at a glance:*

| Who | Can |
|---|---|
| **Guild master** (whoever founded the ledger) | name the officers · set how raids pick their list · move the ledger to a new format |
| **Officers** | open, extend and revoke raids · name a raid's list · set which classes may bid on an item and who it suits · edit lists directly when no raid is running |
| **A raid's Master Looter** | run loot sessions · write to the raid's list (and no other) · choose who disenchants · answer requests |
| **Everyone** | bid, request changes, verify the ledger |

The guild master is also an officer, so everything under "Officers" applies to them too.

---

## 1. Founding the ledger (once)

**What it is for:** the ledger belongs to whoever starts it. That character is the guild master, for ever, unless the role is handed over.

**How:** on the guild master's character, in a group where they are the raid leader or an assistant, create the first list:

```
create main
```

This writes the first entry (the *Genesis*, which names you guild master) and then the list. Other players receive your ledger by syncing with
you; a ledger founded separately (another guild, a training session) never mixes in.

**Take care:** do it on the character you mean to be guild master. Two people each founding a ledger end up with two unrelated ledgers.
Handing the role to someone else exists in the ledger format (`SetGuildMaster`) but has no command yet.

## 2. Officers

**What it is for:** officers run the raids and fix the list between raids. Keeping the set small and named keeps the record accountable.

**How:**

```
officers                    show the guild master and the officers
officers set Aldric Brann   replace the officer list with exactly these characters
officers set                no officers: only the guild master
```

`officers set` always replaces the whole list (give every name you want, not just the new one). Write each character as `First_Last` (a character is its first and
last name; there are no realms).

## 3. How raids pick their list

**What it is for:** the guild keeps one list for everything (`main`) by default. Some guilds want a separate list per raid, because a
raid has a quality ceiling (once Naxxramas is out, spending your place on Molten Core loot is a poor trade) or because 20-player and
40-player raids should not share one. A raid that plays on the wrong list is the easiest mistake to make, so this setting decides
whether that choice is left to whoever opens the raid, or required and enforced.

| Policy | What happens when an officer opens a raid |
|---|---|
| `choose` *(the default)* | The raid plays on `main`, unless the officer names another list. |
| `perraid` | The officer **must** name a list, and it **can't be `main`**. The raid's Master Looter can't write anything until it has one. |

**How:**

```
raid policy                 show the current policy
raid policy perraid         require every new raid to have a list of its own
raid policy choose          back to the default
```

**What it changes, and what it does not:**

- It applies to raids **opened after** the change. A raid already open keeps the rule it was opened under, so changing the policy never
  rewrites history.
- It does not create lists for you. Name one when opening the raid (below); a list that doesn't exist yet is created, in `main`'s order,
  when the raid's first loot session starts.
- Whatever the policy, **a Master Looter can only write to their raid's list and its off-spec list**, so a raid can't be split across lists
  by accident. Officers outside a raid are not restricted (that is how mistakes are fixed).

### Opening a raid on a list (officers)

```
raid open <Master Looter> [hours] [list <id>]
raid list                   show the list the open raid plays on
raid list <id>              name it, if it was not named when the raid opened
```

For example `raid open Aldric 4 list naxx`. Rules for the list id: lower-case letters, digits and `_`, up to 24 characters, not `off`.
**The first list named stands.** A raid never changes list part-way through. If it was the wrong one, `raid revoke` it and open it again.

The raid's off-spec list is worked out from its list (`off` for `main`, `<id>-off` for any other), so there is nothing more to choose.

A new list starts as a copy of `main`'s **order** ("who has waited longest" carries over); wins and passes start level.

### Fixing a list between raids (officers)

Add, move, award and undo commands change one list. By default that is your raid's list if you are running one, else `main`. To fix another:

```
list                        the lists, and which one you are working on
list use <id>               change this list from now on
list use                    back to the default
standings <id>              look at a list without switching
```

## 4. Moving the ledger to a new format

**What it is for:** now and then a release changes how the ledger is written in a way old versions cannot read. The ledger never rewrites its
history; instead the guild master writes a *cutover*, and from then on everyone writes in the new format. See
[ledger-format.md](ledger-format.md) ("Migrating the ledger") for the details.

**How:**

```
migrate status              the ledger's format, and which players can already read the next one
migrate <format> <reason>   move to the next format (the current one plus one)
```

**When:** only when `migrate status` shows the guild is ready. Anyone who cannot read the new format is told to update the moment the cutover
reaches them, and cannot write until they do. A client that cannot reproduce the cutover from its own copy of the history refuses to write
rather than disagree with everyone else. The cutover is permanent.

## 5. Who must update

**What it is for:** knowing whether the guild is on versions that can play together.

```
version                     this addon's version, and what every other player runs
```

Two versions share a ledger when they are on the same compatibility line (the same major version, or the same major.minor while the
major is 0). Players on an older line see that they must update; you do not configure this, but `version` tells you who is behind. Rules:
[ledger-format.md](ledger-format.md) ("Versions").

---

## Officers' other settings (for reference)

These are officers' to set, so the guild master can do them as well. They are guild-wide and in the ledger, like the options above.

| Command | What it is for |
|---|---|
| `eligible <item> <classes\|any> <reason>` | Restrict which classes may bid on an item before it drops (a token, a class set piece). `eligible` alone lists every rule. |
| `suits <item> <roles\|auto> <reason>` | Override who an item suits (tank, melee, hunter, caster, healer) when the addon's stat check gets it wrong. `auto` goes back to the addon's own judgment. |
| `raid extend [name] [hours]` | Give a running raid more time (a raid lasts 4 hours by default, 24 at most). |
| `raid revoke [name]` | Take the Master Looter's right to write away at once. It is in the record. |

The Master Looter (not the guild master) chooses the disenchanter for their raid (`disenchanter <name>`), and loot is not handed out until they
have.

## Things the guild master does *not* control

These are deliberate. They are what stop one person from deciding for everyone:

- **Nobody can edit or delete history.** A mistake is fixed by a new entry that says why (`undo`, `trade`, `move`), and the old one stays visible.
- **The Master Looter does not choose gifters' or winners' outcomes.** Their writes follow the draft; a gift only needs an eligible recipient.
- **Individual players' bids and passes are theirs.** No setting overrides a player's own answer.
