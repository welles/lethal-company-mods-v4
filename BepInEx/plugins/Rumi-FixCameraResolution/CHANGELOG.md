# 1.5.3

* Preserve Stingray spit effect with hidden visors
  * Thank you, Auuueser!

# 1.5.2

* Fixed a bug where changes made in Lethal Config were not reflected in the game.

# 1.5.1

* Fixed a bug where the resolution would revert when entering the pause settings screen.
* Removed motion blur disable setting (just noticed it in the settings window)

# 1.5.0

* Fixed a bug where changes made in the config were not applied immediately.
* Added a setting to disable motion blur.

# 1.4.0

* Added a setting to unlock the HUD aspect ratio.  
* Added a setting to check the resolution every frame.

# 1.3.4

Fixed a weird bug where the fog disappears at certain angles

# 1.3.3

Fixed a bug where HDRP settings, except for fog settings, were not applied while spectating.

# 1.3.2

Fixed a bug where resolution settings wouldn't apply if the LethalConfig mod wasn't installed by ensuring proper detection of the LethalConfig mod.

# 1.3.1

Fixed a bug where other HDRP settings wouldn't apply when the Fog setting was in vanilla mode.

# 1.3.0

* Overhauled the Fog settings to HDRP, adding several new options:  
  * Antialiasing  
  * Bloom  
  * Shadow  
  * Post Processing  
  * Vignette  
* This version is **not compatible** with the previous version's settings.

# 1.2.2

* Fixed a bug that required a restart when changing fog settings (I never noticed until now...)

# 1.2.1

* While digging through the Unity API I found an interesting setting\
  So I modified the implementation of the hide setting in the fog mode settings.\
  Now it will be more natural :)

# 1.2.0

* The configuration file structure has changed and is not compatible with previous versions
* Added a setting to reduce fog to a level that doesn't obstruct your view, rather than completely removing it.

# 1.1.0

* The configuration file structure has changed and is not compatible with previous versions
* Added setting to disable fog rendering
* Added setting to disable visor
* Fixed a bug where the camera ratio was not updated

# 1.0.2

* Scan node location bug fix

# 1.0.1

* Fixed a bug where CanModifyCallback was written in reverse in Lethal Config related code.

# 1.0.0

* Release
