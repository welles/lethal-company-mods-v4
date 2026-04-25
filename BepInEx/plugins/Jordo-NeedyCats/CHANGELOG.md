## v1.2.5
- Fixed NeedyCats breaking the terminal and not spawning in v80

## v1.2.4
- Fixed the netcode issue that occured because of the Lethal Company v73 update

## v1.2.3
- Fixed an issue that conflicted with Terminal Formatter

## v1.2.2
- Fixed cats not applying the grabbed animation when grabbed in v60+

## v1.2.1
- Fixed cats not respecting the "Chance of cats fleeing dogs" setting, it should now work properly.

## v1.2.0
- Added cat food! It can be purchased for 5 credits at the terminal and, if open and on the ground, will feed any number of cats within a few meters for 12 hours! It has two possible effects, selectable in the mod's config:
	- Delay the cats meows by a *substantial amount*, default, recommended for multiplayer as you'll still need someone to pet them regularly
	- Silence the cats meows for the entire 12 hours duration, recommended for solo play
- Added a chance for the cats to flee if being attacked by dogs, the percentage of chance is by default 10% every 2.5 seconds, you can configure the chance percentage in the mod's config.
- Slightly buffed the decorations meow timer bonus
- Cats no longer flee from boomboxes or the dropship
- Cats will now meow faster if they were just fleeing
- Fixed a bug where cats wouldn't refresh the AI nodes on level load (caused issues with the fleeing behaviour)
- Fixed cats not appearing on LLL custom moons
- Fixed cats SFX not having correct audio mixer

## v1.1.1
- Fixed incomplete & confusing description of the names config option

## v1.1.0
- Cat names have been moved to the mod's config, albeit less readable, it allows for easier sharing with profile codes
	- Names are delimited by a comma (,)
	- Furs can also be assigned using colon (:)
	- [Read more about the cat names changes including a list of the possible fur colors here](https://thunderstore.io/c/lethal-company/p/Jordo/NeedyCats/wiki/1048-modifying-the-cats-names/) 
- Cats have been tweaked to be a bit less needy:
	- By default
	- After being pet
	- In the ship *next to an employee*
	- If certain decorations are present on the ship
- Cats will now be much more quiet in walkie-talkies
- Cats will now meow slightly more quietly (according to the dogs) if they are in the ship
- Fixed a bug where cats would not sit in the ship for some players
- Fixed a bug where cats would not appear on custom moons created using LethalExpansion (thanks broiiler for reporting the issue)
<details><summary>Spoilers changelog:</summary>

- Added some extra time to the base meow timer (very small)
- Added some extra time to the meow timer (small) after petting
- Added some extra time to the meow timer (small) if there is at least one person in the ship
- Added some extra time to the meow timer (small to large) if you own certain decorations
<details><summary>Possible decorations spoiler:</summary>

- Welcome mat (small extra time)
- Cozy lights (medium extra time)
- Goldfish (large extra time)
</details>
</details>

## v1.0.2
- Accidentally uploaded 1.0.1 as debug (removes all scraps but the cats)

## v1.0.1
- Fixed a bug that added the cat to the scrap pool every time a new game would be started
- Fixed a bug where picking up the cat would have it stuck in the idle/movement animation for a few frames
- Fixed a bug where teleporting while holding the cat would drop the cat in "Held" pose
- Added a hint about the usefulness of petting cats the first time you grab one
- Cats are a bit quieter, but keep them happy or the dogs will get you!
<details><summary>Spoilers changelog:</summary>

- Added some extra time to the meow timer (small) after petting
</details>


## v1.0.0
- Initial release