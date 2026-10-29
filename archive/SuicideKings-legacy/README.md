# suicide-kings
Attempt at getting a true suicide kings lua

## TODO
- [x] Make a copy of the left list for the right to show all the players in the real list
- [x] Fix the scrollbar so that it fits properly in the frame
- [x] Fix the scrollbar so that it actually scrolls the content
- [x] Allow a member to be selected when clicked on
- [x] Add buttons in the center to be able to add the selected member to the right
- [ ] Add new list management buttons at top and list the existing list. Allow creating new lists and deleting existing lists. Add confirmation box where user can name their list. List dropdown should list all existing lists
- [ ] Move SK list to the left
- [ ] Add buttons to add member and switch to a set of options when selected
- [ ] Add buttons to manage list members
- [ ] Fix the tab layout for config vs list
- [ ] Allow the window to be draggable
- [ ] Fix initialization so when the app loads, it properly fills in details
- [x] Make button click independent from guild selection and sk list selection
- [x] Reconcile list with guild members so you cannot have the same person in both
- [ ] Add ability to select folks above a certain rank
- [ ] Add ability to create a new list by name
- [ ] Add CRUD operations for 
- [ ] Add new tab to handle managing transaction log (list of buttons with metadata for the item)
- [ ] Investigate how to detect a piece of loot was given to someone to be able to add this to the transaction log
- [ ] Create a simulation mode to allow folks to test without having to be in a real raid
## UX
### Creating first list
- First run experience shows welcome pane with instructions on how to use suicide kings
- No tabs or other UI is available until a list is created
- Create new list will present a "wizard" like experience to create the new list
- Some of the UX will be reused for editing a list

### Create new list wizard flow
1. Pop-up appears requesting a name for the list
    - Input options: Name textbox, create button, cancel button
    - create button: requires valid name. overlay error within popup if null or conflicting
    - cancel button: immediately closes without continuing
    - Acceptable values: cannot be empty or same as existing list name
1. Member selection frame appears (see below)
    - Purpose: identify all the individuals who should be on the sk list
1. List position edit frame
    - Purpose: set the order of the members of the list

### SK List Member Selection Frame:
- Names in list on right
- Name of list at top of the 
- Can add members from guild list

- Button to add by rank
  1. Dialog appears showing available ranks
  1. Multi-select rank to add multiple
  1. Clicking "OK" will add all members for all ranks specified

- Button to add by name
  1. Pop-up dialog to enter name
  1. Needs to reconcile with /who. If the player is not found, respond with an error (player not found), but don't dismiss dialog
  1. Ok adds verified player to the list

- Button to add/remove selected member (from guild and member lists)
  1. Sorted by rank (highst -> lowest)
  1. Allows individual member selection
  1. Toggles between add and remove depending on whether user is selected on left or right (mutually exclusive selection)
  1. When member is moved over, selection is defaulted to next player (player should apper on sk list and disappear from guild)

1. Select list membership

### Managing an existing list

### Reviewing Transaction History

#### Filter to current raid only

#### Show entire transaction history across all raids

### Running a raid

#### Starting a raid

console commands (/sk)
- ```startraid``` to start a raid. Prints the name of the list being used for that raid.

- ```startbidding [ItemLink]```: Starts bidding for the linked item. Reports error if item link is broken or missing.
- ```cancelbidding```: Ends bidding without changing list
- ```closebidding```: Reports the winner of the bid to the raid. Loot is handed to the winner

/sk undoLastTransaction: Reverts the previous transaction.
/sk redo: 

whisper commands:
- /t <admin> suicide(sui): Submits a bid and responds with relative position in the list. Only available during bidding
- /t <admin> retract(ret): Retracts a bid, returning previous bidder to the top. Only available during bidding 
- /t <admin> position(pos): reports your position out of the total positions in the list. Always available

#### Selecting a list to use
#### Showing raid members who are not on the selected list
### Sharing the list with others