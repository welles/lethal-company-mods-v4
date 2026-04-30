# v2.4.6
#### Fixed
- Fixed an issue where the constellations compatibility would break after the game resets on getting fired.

# v2.4.5
#### Fixed
- Fixed a NullReferenceException in the alert queue system that could occur when other mods would send an alert.
  - Should solve issues with 'ReviveCompany Patched' and maybe others that haven't been reported.  

# v2.4.4
> **BREAKING!**  
> This update changes the `Reset when fired` config option.  
> Check your config if you had this set to _not_ reset when getting fired. More info below.

#### Added
- Added alert queue exceptions
  - Prevents some mods that spam alerts (Imperium, LethalCasino) from congesting the queue
  - Exception list in config. Add mods by GUID. (You can probably ignore this.)

#### Changed

- `Reset when fired` now has three modes:
  - **All**: wipes all LMU progression. Default.
  - **AllButStoryProgression**: wipes all LMU progression except unlocked story locks. When story lock behavior is set to 'ImmediateDiscovery' moons will be discovered after reset.
  - **Nothing**: keeps LMU progression (per save). 
- LMU now follows the same saving logic as the base game to prevent inconsistencies after crashes or savescumming.
  - When the game is quit mid-round, the state will load back to what it was at the start of that day.
  - All progression made from routing the ship after the day had started will be lost.
  - This aligns with the base game's logic that puts you back on the moon you finished the previous day on.
- The Band-Aid config setting to save and restore group Credits was changed:
  - when enabled LMU will also save when the game is quit mid-round.
  - use it when another mod is saving and restoring the current level. LLL was doing this in the past. I honestly don't know if it's still a thing.
  - it keeps its name because theoretically it solves the same inconsistencies, so this update doesn't break it for people who need it in their setups and are using it.

#### Fixed
- No longer replacing Dawn's `ProgressivePredicates`.
  - Should fix an issue preventing Oxyde from being unlocked after using the tablet. 

# v2.4.3
#### Fixed
- Fixed config file not being created on first time setups. 

# v2.4.2 
#### Changed
- **TerminalStuff Compatibility:**
  - Ensure LMU pricing immediately applies after routing on clients
- **LethalConstellations Compatibility:**
  - Sort logging table by constellation regardless of discovery mode being enabled.
#### Fixed
- Fixed a bug where LMU pricing would not apply after taking off from company moon with an incomplete quota until another event triggered a refresh.

# v2.4.1
#### Fixed
- Fixed clients buying moons through the TerminalStuff MoonsPlus menu sometimes not registering as paid route.

# v2.4.0
> **BREAKING UPDATE!**  
> Parts of your config will reset! Previous saves are incompatible!  
> This is **NOT** targeted at v80+! Might still work though. May fully depend on LLL and Dawn. You let me know.  
#### Added
- **LethalConstellations progression rewrite**:
  - Added separate constellation progression state with its own discovery, unlock, discount and sales handling. Also configurable as quota reward.
  - Added constellation-specific discovery settings for starter selection, whitelist/backlog handling, per-trigger moon vs constellation targeting, and separate constellation-discovery chances.
  - Added constellation tags for LMU state such as `[NEW]`, `[UNLOCKED]`, `[DISCOUNT ...]`, and `[SALE ...]`.
- **LethalConstellations custom unlock conditions**:
  - LMU now generates new config `LethalMoonUnlocks - Constellations.cfg`
  - You can configure unlock conditions for each constellation. For now..
    - minimum completed quota count
    - minimum number of moons visited
    - list of moons required to be visited once
    - list of bestiary logs required to scan and read on terminal
    - list of story logs required to find and read on terminal
  - For each you can choose whether one or all conditions have to be satisfied.
  - You can optionally choose to ignore any type of story progression gated access to the constellation's default moon.
- **Discovery Mode**:
  - Added a config option to control whether moons that are locked behind story progression will be added as new discovery immediateyly or added to the pool of moons available for discovery 

#### Changed
- **LethalConstellations**:
  - Once discovered, constellations stay discovered for the run instead of being shuffled away with the moon rotation.
  - When a constellations default moon is locked behind story progression, that will apply to the entire constellation.
  - Each constellation now has its own moon rotation. Your rotation specific configurations apply per constellation. 
  - In addition to the rotation each constellation will have its default moon discovered (always) plus additional temporary and permanent discovered moons. 
  - Constellation routing can optionally be mirrored onto the default moon so it also gets the unlock, discount, potential travel discovery, etc..
- **Story/Progression Locks**:
  - `UnlockManager.OnCollectStoryLockedMoons` is now obsolete.
  - `UnlockManager.TryReleaseStoryLock()` now works on any moon that starts locked and hidden. 
  - `UnlockManager.TryReleaseStoryLockShowAlert()` now works on any moon that starts locked and hidden. 
- Many config options have been updated or reworded. Some have been moved (mostly constellations related ones).
- Continued improvement to logging and in-game messages/alerts. 

#### Fixed
- Bunch of stuff in the process of rewriting the LethalConstellations extension. 
- Various client sync issues with Vanilla story mode.
- Rounding error causing terminal tags to show incorrect discount rates.
- Removed now redundant patches for LethalConstellations and TerminalStuff.

# v2.3.5
#### Changed
- **LethalConstellations:**
  - Improved formatting of the moon table in logs. 
    - With LethalConstellations present, it is now grouped by constellation. 

#### Fixed
- **LethalConstellations:**
  - Fixed an issue where LMU was assigning default moons to constellations when not in discovery mode. 

# v2.3.4
#### Added
- Added a config option to only allow moons to go on sale after a specified number of days
- Added a compatibility setting to prefer **Galetry** over **Gordion** for LMU's automatic deadline reroute.
  - When enabled and Galetry is available and routable, LMU will reroute there instead of the Company building.
- Added progression config to lock Galetry behind selling a customizable number of paintings to the company. 
  - In discovery mode Galetry will be discovered immediately and permanently after selling the required number of paintings. 

#### Changed
- Updated DawnLib reference to `0.8.x`.
- **LethalConstellations**:
  - Default moon assignment is now more robust in both discovery and non-discovery modes.
  - In non-discovery mode, constellations now prefer a valid visible/unlocked default moon instead of keeping an invalid hidden or locked default.
- **Wesley's moons / JLL compatibility**:
  - Route discovery alerts are rewritten to better align with LMU's language. Varies between discovery and non-discovery modes.
- **Random selection / Cheap moon bias**:
  - Using our own source of randomness. Avoids issues with other mods that might interfere with the game's randomness.
  - Updated the cheap moon bias formula to more closely reflect the behaviour described in config descriptions.
  - Updated cheap moon bias config description to simpler wording.

#### Fixed
- **DawnLib compatibility**:
  - More robust matching of moons with DawnLib's registry.
  - Moon defaults are now initialized properly from DawnLib on every lobby creation.
  - Baseline hidden, locked and price defaults are now pulled correctly from DawnLib even for moons with funky names.
- **TerminalStuff compatibility**:
  - Buying a moon from the MoonsPlus menu now counts as purchasing that moon even when TerminalStuff skips the vanilla buy nodes.
  - LMU terminal tags are now cleared cleanly when tag display is disabled.
  - (Temporary fix) StorePlus page size now correctly follows the user's TerminalStuff config.
- **LethalConstellations compatibility**:
  - Constellations no longer duplicate after reloading a save.
  - Moons in the currently routed constellation now have their full LMU state reapplied instead of being forced into an incorrect routable state.
  - (Temporary fix) Constellations menu now correctly hides hidden constellations. 
- Fixed a bug where moon prices and hidden/locked states were not restored to original values on disconnect and could leak into the next savefile.
- Loading a save no longer overwrites *fresh* original hidden/locked defaults with stale LMU saved data.
- Hidden-by-default moons now recompute whether they should remain hidden from defaults and current progression instead of relying on potentially inaccurate saved state.
- The `Permanently discover hidden moons on visit` setting now correctly keeps visited hidden moons permanently discovered.
- Moon prices will now correctly reset to original price when a discount or unlock expires. 

# v2.3.3
#### Fixed
- Fixed compatibility with darmuh's TerminalStuff
  - Restored full LMU terminal tags in the catalog.
  - Added a line break for visual clarity when tags are enabled.
  - Added a temporary fix so the user configured page size in TerminalStuff's MoonsPlus config is properly applied.
  - I recommend using something around 3-5 moons per MoonsPlus page to avoid unnecessary scrolling. Of course this depends on how many tags you have enabled (per line). 
	
# v2.3.2
#### Fixed
- Fixed a `NullReferenceException` which could prevent players from rerouting the ship.   
  - This would happen with DawnLib present and certain moons installed.
  - Added extra safety checks to my terminal patch to avoid entirely bricking the routing if this were to occur again. 

# v2.3.1
#### Added
- **DawnLib compatibility** (soft dependency):
  - Moon visibility and pricing are applied via DawnLib APIs when DawnLib is present.
  - LMU terminal tags are injected into the DawnLib moon catalog.

#### Changed
- LethalConstellations extension is no longer shipped as a separate `.dll`.
  - Merged back into the main assembly as a concrete class.
  - No more TypeLoadExceptions on my side. Let me know.
- Updated LLL reference to v1.6.8.
- Terminal scroll amount is now properly normalized giving consistent behaviour regardless of catalog size.
  - LLL's own scroll prefix is unpatched when LMU's custom scroll is active.
  - Config description updated to clarify behaviour. 

#### Fixed
- Embrion story unlock condition no longer triggers before the bestiary entry has been read. 

# v2.3.0
#### Added
- Dynamic compatibility layer for LethalConstellations
  - LethalConstellationsExtension is now shipped as separate `.dll`

#### Changed
- Recompiled for game version v73
- Temporarily added dependency to pacoito-LethalLevelLoaderUpdated-1.5.1 to make mod work

#### Fixed
- TypeLoadException that prevented game initialization when LethalConstellations was not present
- Various other TypeLoadException Errors or warnings when LethalConstellation was not present

# v2.2.3
#### Added
- Added `UnlockManager.TryReleaseStoryLockShowAlert(string)` for other mods to use.
	- Will make LMU display a generic alert message on releasing a story lock.

#### Fixed
- Fixed a compatibility issue with Wesley's moons (JLL) introduced with **LMU v2.2.1** where playing a tape failed to release the story lock.

# v2.2.2
#### Fixed
- Compatibility hotfix attempt

# v2.2.1
#### Added
- Added a config setting to globally enable (or disable) the **Story Lock** feature introduced in **v2.2.0**.
	- Enabled by default.
	- Disabling this ignores any requests to lock moons behind story progression. Such moons will be handled like any other regular moon. 
- Added alert messages when the LMU vanilla story progression is advanced.
- Added a config setting to enable (or disable) automatically rerouting the ship to company on deadline.
	- Located in advanced config section.
	- Enabled by default.

#### Changed
- Any changes to story locked moons by other mods (like Wesley's moons / JLL) will now apply immediately.
	- This resolves some inconsistencies when looking at the moon catalog before taking off.
- Switched to using the BepInEx default config file (`BaseUnityPlugin.Config`).
	- Your config is automatically migrated. Just in case a backup is created (`com.xmods.lethalmoonunlocks.cfg.legacy`).
	- This enables LethalConfig to automatically detect LMU's configuration and allows to change it in-game.
	- *Note:* You can expect most settings to apply mid-game unless stated otherwise. Messing with settings may or may not lead to unexpected behaviour in certain scenarios.
- Moved Story Lock/Progression config settings to their own section under `6 - Advanced settings`.
	- If you previously enabled `Vanilla Story Progression` it may reset.
- The moon preview text in the terminal will no longer be replaced when `Display Tags in Terminal` and `Override Terminal Font Size` are both disabled.
- `UnlockManager.TryReleaseStoryLock(string, bool=false)` was extended to support showing a generic alert message on releasing a story lock.

# v2.2.0
#### Added
- **Story Lock feature:**
	- Allows mod and moon creators to exclusively lock moons behind story progression.
	- Reference LethalMoonUnlocks and check if the assembly is loaded using `BepInEx.Chainloader.PluginInfos`.
	- Subscribe to `UnlockManager.OnCollectStoryLockedMoons`. Your subscriber should return a list of moons.
	- To release the lock on your moon, call `UnlockManager.TryReleaseStoryLock(string)`.
	- Once the lock is released, LMU will handle your moon like any other, showing it in the terminal immediately or, in discovery mode, adding it to the pool of moons that can be picked by various mechanics.
- **Vanilla Story Progression:**
	- Exemplary use of story lock feature.
	- Configurable in advanced section. Disabled by default.
	- Applies story locks to **Embrion** and **Artifice**:
		- **Embrion:** Gain access by scanning a certain bird.
		- **Artifice:** Gain access by landing on Adamance three times.
	- After gaining access, these moons will be added to the moon catalog or made available for discovery. They will not be hidden.
	- This feature was initially used for testing the story lock system but has been kept in the release. 

#### Changed
- Adapted to LLL's new loading/saving system to ensure correct defaults for moons.
- Reworked how overrides are applied to prevent saving overridden defaults.
- Improved the table of moons and their states in the console/logs.
- Streamlined internal logic to reduce complexity introduced over time.

#### Fixed
- Fixed an error that occurred during Quota Discovery (group) when LethalConstellations was selected for matching but not present.

# v2.1.11
#### Fixed
- Fixed an issue that would occur on creating a new save when a moon you put on the locked override list was selected as part of the discovery shuffle rotation

# v2.1.10
#### Added
- **Overrides:**
	- Added advanced config options to hard override hidden and locked moons (what LMU considers default)
	- Adds two new lists to the advanced config section.
	- When the override is enabled LMU will consider **only** moons in that list as hidden or locked by default respectively.
	- Every other source for that information (vanilla, LLL config, other mods) will be ignored.
	- Attempt to avoid bugs around moons that are hidden or locked by default (vanilla or custom) for some players.
- Added config option to include the weather in 'preview risk' moon preview text

#### Changed
- Recompiled for v69 *- Nice!*
- Bumped dependency versions
- Improved compatibility with LQ prices
- Continued improvements to in-game messages and alerts
- Clarified some logs

#### Fixed
- Fixed Discovery Mode being completely broken on loading existing saves
	- At some point LLL started saving and restoring locked and hidden information of moons which interfered with LMU's save and restore logic. Sorry for not realizing this sooner..
	- Unfortunately this also means that LMU can no longer fetch baseline information set in LLL config when loading existing saves
		- Use the new hard override advanced config options if you want to change which moons are always hidden/locked on existing saves
		- LMU still retrieves this information from LLL on fresh saves
- Fixed the *free moon exploit* - bad news for all you *filthy cheaters* out there ;)
	- This is an 'issue' where you could buy a moon, quit to menu, load back into the save and still be at the moon you bought without any credits lost.
	- This is probably an interaction between
		- The base game logic not saving the moon you're at or the amount of credits you have if you quit from the lobby.
		- LLL saving the moon you're currently located at as soon as you arrive.
	- Since this was only happening for some users there are likely other mods out there that already address this.
	- If this band aid solution happens to cause any issues, it can be disabled in the advanced settings section.
- Fixed an issue where loading a save with Discovery Mode enabled that previously had it disabled would result in no moons showing in moons catalog.

# v2.1.9
#### Added
- **Terminal Scrolling**:
	- Added an option to smooth terminal scrolling and avoid skipping moons when you have a lot visible at once.
	- Disabled by default. Toggling requires game restart.
	- Can be configured in Advanced config section. 
	- This is the same patch used by StoreConfigRotation and TerminalFormatter. Don't use more than one or the effect will multiply!
	- Currently has no effect when AdvancedCompany is installed.
	- Thanks @pacoito123 for the transpiler patch!
	- Thanks BULLETBOT for making me aware of the skipping moons issue!
- **Quota Discovery**:
	- New `Match cheapest constellation` option
	- Use this config setting to change the behaviour of `Match cheapest group` to discover the next cheapest undiscovered constellation instead of the one that has the cheapest undiscovered moon. 

#### Changed
- **Quota Discovery**:
	- Chat message will now print the group name similar to other chat messages.

#### Fixed
- Fixed an issue where disabling Discovery Mode and loading an existing savegame that previously had it enabled would not show all moons.

# v2.1.8

#### Fixed
- An issue where certain moon names could break the moons catalog.

# v2.1.7

#### Added
- **WeatherTweaks**:
	- Added a compatibility workaround to ensure WT's custom weather types are displayed on terminal until a better solution is found.


#### Changed
- **Alert messages**: removed redundant alert messages when an entire LethalConstellation or custom group was discovered on Quota Discovery with `Match cheapest group` enabled.

#### Fixed
- An issue with `Reset permanent discoveries on .. expiry` config settings resetting the discovery status more often than they should.
- An issue where the `new day discoveries are permanent` config setting was not respected.

# v2.1.6

#### Changed
- Group tags (custom groups and LethalConstellation) will now show on terminal regardless of whether they are used for any discovery mechanic group matching..
	- .. as long as the respective group matching method is selected and the tag itself is enabled.

#### Fixed
- Fixed/changed a few chat messages being sent even if chat messages were disabled. 


# v2.1.5

#### Fixed
- An issue where group tags wouldn't display when using custom groups and `Quota Discoveries match cheapest group` was the only group matching option enabled.
- An issue where `Quota Discovery match cheapest group` wouldn't correctly match moons under certain conditions.


# v2.1.4

#### Added
- **Terminal Formatting**:
	- Customizable font size config for the moons catalog.

#### Changed
- **LethalConstellations**:
	- Ensured the default constellation is set correctly for better integration.
- **Terminal Formatting**:
	- Attempting to prevent some inconsistent ugly line breaks in the moons catalog.
	- LLL changes the font size depending on the numbers of moons visible.
	- LMU now overrides that behaviour and enforces a constant font size.
	- The max line width config was changed accordingly to allow for longer lines when using smaller font sizes
- **Group tags**:
	- All Custom groups and LethalConstellations tags are now displayed in uppercase for visual consistency with the LethalConstellations page and other LMU terminal tags.

#### Fixed 
- Minor bugs, inconsistencies and config descriptions.

# v2.1.3
#### Changed
- **LethalConstellations**:
	- Removed LethalConstellations patch.
	- Subscribed to the new `RouteConstellationSuccess` event (thanks @darmuh!)

#### Fixed
- Resolved warnings and errors that occurred when LethalConstellations was not installed.
	- This was due to an interaction between Linq compiler magic and referenced types that are not present, along with runtime reflection.
- Fixed a bug where attempting to route to an unaffordable constellation was incorrectly interpreted as purchasing the constellation's default moon.
- Corrected an error when LethalConstellations was selected as the group matching method but was not installed.

# v2.1.2
#### Fixed
- Addressed an issue where the assembly was missing from the v2.1.1 release package.

# v2.1.1
#### Fixed
- Hotfix for the moon catalog breaking when LethalConstellations was not present.

# v2.1.0
#### Added
- **LethalConstellations compatibility**:
	- Introduced a new group matching method for LethalConstellations.
	- In Discovery Mode, constellations are discovered when at least one moon is discovered.
	- The number of discovered moons is displayed in the LethalConstellations Terminal screen ([optionals] in your LethalConstellations config)
	- Terminal tag (shares 'Group tag' config)
	- Show alerts when discovering new constellations.
	- Config option to override constellation prices with the cheapest discovered moon, applying unlocks and discounts to constellations.
- **Quota Discovery**:
	- New option to match the currently cheapest not fully discovered group (custom group or LethalConstellation).
- **Fallback options**:
	- Added fallback options for group matching in all additional discovery mechanics.

#### Changed
- **Cheap Moon Bias**:
	- Now applies to Quota Unlocks, Quota Discounts, and Quota Full Discounts.
	- Separate toggle and bias values for each applicable mechanic.
	- Added an option to ignore price changes.
- updated in-game messages

#### Fixed
- Corrected some incorrect logs and other minor issues.


# v2.0.3
#### Added
- **Alert Messages Networking**:
	- Improved alert message handling across the network.

#### Changed
- **Discovery Mode Safety Check**:
	- Now considers moons on the whitelist.
  - Added several fallbacks for better reliability.
- **Whitelist Verbosity**:
	- Enhanced error messages for incorrect entries in the whitelist.

#### Fixed
- Resolved issues with alert messages not displaying on clients.
- Fixed a bug where a moon was incorrectly added to the rotation when both free and dynamic free base counts were set to 0 but a whitelist was used.


# v2.0.2
#### Fixed
- Corrected the display of terminal tags, which were shown with default settings.
- 
## v2.0.0
> **Note**: This is a major update. Please refer to the README and configuration for detailed information on new features and options. It is recommended to delete your existing config for optimal performance.

#### Added
- **New Unlock Mode Mechanics**: 
  - Unlocks can expire.
  - Introduced Quota Unlocks.
- **New Discount Mode Mechanics**: 
  - Discounts can expire.
  - Added Quota Discounts and Quota Full Discounts.
- **Discovery Mode**: 
  - Base selections and shuffling mechanics.
  - Introduced Quota Discoveries, Travel Discoveries, and New Day Discoveries.
  - Added Cheap Moon Bias
  - Added Moon Group Matching (including custom groups).
  - Automated ship rerouting on deadlines and after shuffles.
  - Extensive configuration options for all features.
- **Terminal Tags and Formatting**: 
  - Improved compatibility with LethalQuantities (LQ risk level preference).
- **Alert Messages**: 
  - Implemented a queue system for alerts, with compatibility for other alert sources.
- **Malfunctions Compatibility**: Navigation malfunction can be handled as buying a moon.

#### Changed
- **Code Rewrite**: A significant portion of the old code was rewritten to improve functionality while maintaining existing features.
> The behavior of LethalMoonUnlocks in default configuration remains unchanged.

#### Fixed
- Resolved a bug where purchasing equipment after routing to a free moon was incorrectly counted as buying the moon.
- Fixed several smaller bugs from v1.0.1.

# v1.0.1
#### Changed
- **Code Optimization**: Refactored and optimized code related to original prices.
  - Always retrieve original prices from LLL and restore them on disconnect.
- Updated chat message on new quota unlock.
- Updated various logs.
	- Consolidated excessive logs from development.
- Minor performance and stability improvements.

#### Fixes
- Corrected issues with discounted prices not reflecting changes to moon prices (e.g., via LLL config) when loading existing saves.
- Fixed incorrect log data during saving.

# v1.0.0
- **Initial Release**
