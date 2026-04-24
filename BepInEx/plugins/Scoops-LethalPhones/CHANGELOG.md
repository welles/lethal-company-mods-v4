### [1.3.23]

* Repackaged Assetbundles to add v80 motion vector support. Now moving while holding a phone should not be sickening.

### [1.3.22]

* Rebuilt to reference the newer version of weather registry for compatibility.

### [1.3.21]

* Rebuilt for v80.

### [1.3.20]

* Fixed Depth of Field not working correctly on objects that can be inspected (clipboards). This was caused by the phone DoF code for dialing running even when the phone wasn't actively out.

### [1.3.19]

* Added a new General config option 'Disable Menu' that will remove the phone personalization button from the main menu. You phone will still use whatever personalization you set last, you just won't have the button on the menu anymore.

### [1.3.18]

* Updated the mod for v73.
* It's now using the new netcode patcher, so 1.3.18 will no longer work on onlder Lethal Company versions.

### [1.3.17]

* Fixed null reference error caused by re-joining a lobby after being kicked.

### [1.3.16]

* Updated the mod for v70.

### [1.3.15]

* Updated Mirage compatibility version to fix errors.

### [1.3.14]

* Fixed null reference exception when loading a save with Switchboard active.

### [1.3.13]

* Made even more performance optimizations
* Fixed another null reference related to enemies and Mirage compat

### [1.3.12]

* Made some performance optimizations
* Fixed null reference related to hoarding bugs and Mirage compat

### [1.3.11]

* Fixed Phone Sanity calculations incorrectly thinking you were always on a call (and making sanity always heal)

### [1.3.10]

* Enemies will no longer spawn with phones if Personal Phones haven't been unlocked.
* Added a few more edge case checks.

### [1.3.9]

* Added the ability to use Text Chat while on the phone!
* Hopefully fixed a few more edge case null references.

### [1.3.8]

* Fixed null reference exception on Hoarding Bug destruction with Mirage Compat.
* Fixed being able to toggle your phone while dead.

### [1.3.7]

* Fixed a number of oversights for Enemy Phones from the new rework. Masked can call again, and enemies can pick up calls again.
* Reworked Enemy Phone audio values to be more in line with player values.

### [1.3.6]

* Fixed a black screen error on clients if another mod tried to spawn a null NetworkPrefab.

### [1.3.5]

* Fixed being able to take out the phone while actively using the jetpack, which would make you unable to stop jetpacking until you DIED.
* Removed specific compatibility for ReviveCompany, and did a small rework so the phones should be compatible with all revive mods.

### [1.3.4]

* Fixed a Harmony patching error that caused the Personalize Phone button to not show up.

### [1.3.3]

* Changed the method for gathering audio sources to avoid some edge-case compatibility issues. (Specifically an issue when running LethalPhones + Bozoros + BetterFog)

### [1.3.2]

* Fixed a null reference exception a the start of the round if you weren't using WeatherRegistry.

### [1.3.1]

* Fixed audio sources that use a custom spatialization curve not resetting correctly after ending a call. (The Company Cruiser being the primary example)

### [1.3.0]

* Call Quality rework. Static should sound more realistic and be more prevalent. To combat this, Radar Boosters and the Switchboard will increase call quality around them.
* Complete rewrite of all audio management and call quality code. Phones should sound more accurate and be more performant.
* Rework should hopefully catch the audio edge cases where sounds weren't getting unmuted or would be audible even when not on a call.
* Removed many audio-related general configs and replaced them with new ones for the new system, I recommend looking them over.
* Fixed being able to call while already on a call using Switchboard.
* Fixed the Hangup button on switchboard hanging up your active call if you were on a call and had an incoming call. Now it will deny the incoming first.
* Fixed incoming calls on the personal phones not displaying the incoming number.
* Fixed number displays breaking while using the simplified Chinese localization mod. Hopefully this handles any other localizations too.
* Fixed the rotary still being able to spin too far in extreme cases of lag.
* Added WeatherTweaks compatibility for progressing and compound weather types.
* Added ReviveCompany compatibility.

### [1.2.3]

* Improved performance for phone call-quality checks.

### [1.2.2]

* HOTFIX those last two fixes may not have actually gone out last time. They're here now.
* Fixed the rotary being able to spin past the stopper on low framerates.

### [1.2.1]

* Fixed being able to send multiple outgoing calls with the Switchboard.
* Fixed custom ringtones not falling back to default ringtone if not found.

### [1.2.0]

* The Switchboard Update!
* The Switchboard can now be purchased from the store. It can have its price changed (and be disabled) in the config.
* Default number for the switchboard is 1111, but this can be changed in the config.
* Switchboard has an up-to-date list of all phones, and can call them at the press of a button.
* Pick up the Headset on the left side of the switchboard to become the Operator, allowing you to hear/be heard on all switchboard calls.
* Operator headset auto-returns when leaving the ship or dying.
* The switchboard adds a new call feature in: Transferring. While on a call on the switchboard, select another number and press the Yellow button to transfer the person you're on a call with to the selected number.

### [1.1.11]

* Hotfix for the last update where I accidentally removed a clipboard respawn check. Oopsie!

### [1.1.10]

* Reworked how the Unlockable Phones are tracked. This should fix some issues, notably keeping the phones after failing a quota.
* Fixed the customization menu showing even if you had no customizations loaded.

### [1.1.9]

* Fixed spawning an extra clipboard on loading a save.
* Changed the phone item swapping check to work better with other mods that mess with item slots (like ItemQuickSwitchFix).

### [1.1.8]

* Integrated the phone customization menu into the main menu better.
* Added the phone open/close animation to other players too.
* Fixed a longstanding audio effect cleanup bug where phone effects may not be cleaned up if you are eavesdropping on someone elses' call and they enter the facility/teleport.
* Fixed Masked not taking out their phones while calling anymore.
* Added a new Balance config to disable the starter phonebook clipboard.
* Moved the default Toggle Phone keybind to Y instad of ~.

### [1.1.7]

* Added Phonebook Clipboards as a shop item. They can be disabled/have their price changed through config.
* Added Shop Info for the Personal Phones ship unlockable.
* Added a quick opening and closing animation for the phones.
* Added a Ringtone Volume config option, and lowered the default volume of ringtones by 40%.
* Reworked ringtone audio falloff. Should sound better in game.
* Tweaked a few other volume defaults to be slightly lower, I reccomend checking over your configs as they may not update automatically.
* Added 2 new skins.

### [1.1.6]

* Added Mirage Compatibility! Hoarding Bugs and Masked are supported. Masked will copy player's phone cosmetics.
* Added new Enemy config options related to Masked Phones.
* Added a new Balance config to reduce the total number of phone numbers, if you want to remember less digits.
* Added a new General config to specify a customization blacklist, for customizations that shouldn't be loaded.
* Fixed longstanding error on the host if the server was shut down with clients still connected.
* Added a hangup sound effect after the error tone when calling an invalid number.

### [1.1.5]

* Fixed an error where unlockable phones would not be loaded correctly on loading a save.
* Fixed an error with unlockable phones where late-joining clients would not have phones unlocked.
* Tweaked some phone quality values. Drops in connection quality should be more noticable when taking damage.
* The apparatus will now effect connection quality even when unplugged.
* Added a scan node to the phonebook clipboard so you can scan for it. Also fixed it not being parented to the ship properly.
* Added a new 'Balance' section to config and moved the auto-hangup config there.
* Added a Balance config to respawn the Phonebook Clipboard next round if it is lost/sold.
* Added a 3 new config options to remove all of the base customizations, if you want to only use your own customizations.
* Changed the disableRingtones config to only set all other player's ringtones to default, not your own.
* Added a new remixed Delivery ringtone by Absolute Lambda
* Added Pajama, Bee, Bunny, Missing, Pacman, Lego, Rusty, and City Rug Skins.
* Added Mask, Cruiser, and Beehive Charms.
* Added 4 Egg Charms.
* Added 8 Pride Charms.
* Added 1 Phone Charm Phone Charm.

### [1.1.4]

* Fixed errors being thrown whenever a player connected/disconnected if you had lost the Phonebook Clipboard
* Added a new remixed Boombox5 ringtone by Absolute Lambda

### [1.1.3]

* Added a config to auto-hangup phones if they're put away, so that you cannot remain on a call if the phone is not actively out

### [1.1.2]

* Fixed a longstanding error that was causing clients to not get cleaned up properly when disconnecting, which would leave "ghosts"
* Fixed customization ui scaling for non-1920x1080 screen sizes

### [1.1.1]

* Fixed an error caused by using customization addons
* Added a link to the new github wiki page on how to make your own customizations

### [1.1.0]

* Added a new menu button that will open Phone Customization
* Added 10 skins, 6 charms, and 18 ringtones
* Implemented new syncing method, so phone numbers can now be seen written on the tape of other player's phones
* Added a clipboard to the ship which has every player's phone number written on it
* Added a config option to disable phones until they are purchased as a ship upgrade, as well as a config setting for how much they should cost
* Added a config option to set all player's ringtones to default, in case you want the classic auditory experience
* Added optional WeatherRegisty compat, which will allow the phones to have accurate connection quality during LethalElements' Weather
* Added support for customization addons, so additional skins/charms/ringtones can be loaded from separate mods.

### [1.0.11]

* Added a config option to use a dialing indicator instead of the character's right hand, in case you're using a model with hands that don't fit the phone.

### [1.0.10]

* Updated .net version, which seems to have fixed issues with hoarding bug calling?

### [1.0.9]

* Fix for a compatibility issue with LateCompany

### [1.0.8]

* Fixed background noises not coming through on calls that you are spectating
* Calling a corpse now correctly plays the ring audio from the corpse itself
* Added a few more config values for death timing and volume levels
* Fixed an edge case where rotary audio wouldn't stop playing if you quickly clicked on a number

### [1.0.7]

* Complete refactor of phones under the hood to allow for non-player phones (enemies and ship equipment)
* Added a config file for some basic settings, this will be expanded more over time
* Hoarding bug phones!
* More audio from phones is now shared with players around you, like pickup/hangup noises
* More sounds are now audible on calls while eavesdropping
* New known issue of background noises not coming through on calls that you are spectating

### [1.0.6]

* Compatibility fix for TooManyEmotes

### [1.0.5]

* Fixed errors caused by having a player disconnect and reconnect to an active lobby
* Added default controller bindings
* Improved performance on audio source distance checking
* Listening in on someone else's phone has a more accurate audio direction
* Being on a call will now restore sanity, akin to walkies
* Fixed some consistency problems with phone static
* Fixed some edge cases that could have caused players to be silent on calls

### [1.0.4]

* Taking out your phone will now only drop your held item if your inventory is full. Otherwise it swaps to the first empty slot.
* Inverse teleporting will now severely damage your connection quality for a bit.
* Fixed some edge case errors.

### [1.0.3]

* Fixed some edge case errors when audio sources had components removed unexpectedly.

### [1.0.2]

* Added a video to description.

### [1.0.1]

* Updated credits.

### [1.0.0]

* Initial Release.