## Version 1.2.4
- Updated for the latest version (v81), should no longer cause errors
- New radar sprites to reflect the rework of March
- Removed some redundancies due to vanilla radar changes:
	- Changed default vertical render distance extension to 0 (new vanilla value is about what Universal Radar already did)
	- Removed a fix for contour maps not appearing since it seems like vanilla works fine now
- Fixed a vanilla issue (though more obvious with Universal Radar) where radar objects on Gordion would all render at once due to the new extended clipping plane

## Version 1.2.3
- Fixed ignored moons still having their contour maps disabled
- Fixed terrain being treated as a radar object if radar objects are enabled on a moon set to Ignore
- Water radar objects are now linked to contour maps (won't generate if the contour map is disabled in Ignore mode)
- Fixed possible soft locks/crashes on moons with identical hierarchy paths for terrain objects

## Version 1.2.2
- Fixed soft locks/crashes if a moon has the nav mesh surface on the same object as a mesh (Pikmoons)

## Version 1.2.1
- Fixed an issue with sprite fetching that could cause errors on rehosting

## Version 1.2.0
- **Fallback system to switch to the old radar when a player is in an interior lacking any radar sprites** (similar to RadarEdits, but fully automatic)
- Reworked and expanded the system for configuring colours on the radar:
	- Separate config section specifically for colours to allow for more options to be added without cluttering the main config
	- Colour options for line vs. shading are now always separately configurable (no longer requires manual mode to be enabled)
	- New colour options for the radar background colour and the colour of vanilla radar sprites (the transition animation on the radar will also change colour to match the background)
	- Configurable colour for the ship sprite (can either be set to one specific colour, or automatically match the colour of the moon's radar sprites/radar objects)
- Config system now still shows the radar objects option even when a moon is set to Ignore, so you can have a contour map disabled while still generating radar sprites (note that when you first set a moon to Ignore, the radar sprites will be automatically disabled until you turn them on)
	- (This change means the retroactive config values from last update will be reapplied, so Wesley's moons will all be set to ignore again after updating if they aren't already)
- Changes and additions to the vanilla radar sprites:
	- New set of sprites for Gordion to put it stylistically in line with the rest of the moons (and Gordion is now registered as a configurable moon)
	- Many moons now come with a set of "fixed" radar sprites which don't change height with the player, meaning objects should now pop in on the radar alongside terrain when landing and vertical areas like Titan won't show the entire map at once
- Various fixes and cleanup:
	- Fixed radar object cleanup not working and leaving leftover objects and components in the scene (would result in radar objects made from LOD groups behaving strangely)
	- Fixed radar booster camera render distance being incorrect outside
	- Added some debug log timings to show how long certain processes are taking
	- Removed some leftover testing logs from last update

## Version 1.1.0
- Internally reworked config system to allow for defaults to be changed retroactively upon updating
	- This reworked config system also allows you to clear orphaned config entries by checking a box then joining a game (the box then unchecks itself, so it acts basically like a button)
- Wither and all of Wesley's moons are now ignored by default since they have good existing contour maps (any existing configs for these moons will be changed to ignore upon updating and joining a game, but they can be changed back if Universal Radar's contour map is preferred)
- Generally improved radar patches (should be compatible with TwoRadarMaps if it wasn't before) and made it so radar patches only come into effect on non-ignored moons
- Fixed contour maps on DemonMae's moons not being disabled since they aren't tagged correctly (these tags will likely be fixed by DemonMae later)
- Removed map geometry generation edge case for RebalancedMoons since it now uses the same sprite assets as Universal Radar in its own scenes (and updated README accordingly)
- Added compatibility for TonightWeDine which hides the main entrance/fire exit structure when the mod is installed
- Fixed fatal errors when a moon has multiple objects with identical hierarchy paths (e.g. Utril)
- Possibly fixed incompatibilities with certain mods that would cause the radar on Gordion to not display normally
- Fixed Universal Radar (probably) breaking without LLL installed

## Version 1.0.10
- Fix for interior camera clipping distance when viewing radar booster

## Version 1.0.9
- Fixed an obscure error in my nav mesh calculation code

## Version 1.0.8
- Made camera clipping distance normal in interior (probably still iffy with TwoRadarMaps)

## Version 1.0.7
- Fixed fatal errors thrown on objects with mesh renderers but not mesh filters

## Version 1.0.6
- Fixed material checking issue that led to monitor update failures with General Improvements (and generally mess with anything else that checks materials)

## Version 1.0.5
- Fixed errors with moon names containing special characters
- Fixed a few issues caused by increased camera clipping distance:
	- Gordion now looks normal
	- Ship icon no longer displays on radar
	- Clipping distance of other cameras should now be unaffected
- Raised the maximum camera clipping distance you can set in config

## Version 1.0.4
- Saved radar data should now persists for as long as the game is open (instead of per run)
- Fixed radar changes not going through after quitting in the middle of a game

## Version 1.0.3
- Added more config error checks

## Version 1.0.2
- Added some checks to config setup to avoid possible errors on startup

## Version 1.0.1
- README and manifest changes

## Version 1.0.0
- Initial release