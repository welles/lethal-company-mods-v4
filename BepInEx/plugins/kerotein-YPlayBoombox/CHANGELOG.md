- **2.7.0**
    - YPlayBoombox will now only work with the base game cruiser to prevent issues with modded vehicles.

- **2.6.1**
    - v81 compatibility
    - Pocket play is now always enabled
    - Fixed settings synchronisation
    - Updated BepInEx version

- **2.6.0**
    - Fixed pocket play causing visual glitches with ReservedItemSlot
    - Fixed control tips hanging around longer than necessary
    - Added automatic tool updating
    - Replaced the reset-tools command with update

- **2.5.0**
    - Moved temporary file saving to the YPlayBoombox folder to fix path encoding errors
    - Fixed cruiser audio time mismatch
    - User interface changes
    - Bug fixes

- **2.4.0**
    - Updated tools
    - Added Deno JS runtime dependency
    - Added cookies.txt support

- **2.3.91**
    - Fixed reset null reference exception
    - Fixed resync audio time mismatch

- **2.3.9**
    - Updated tools

- **2.3.8**
    - v73 compatibility
    - Updated tools

- **2.3.7**
    - Fixed server host version error message showing prematurely

- **2.3.6**
    - Updated tools
    - Updated error failure logic

- **2.3.5**
    - Fixed error catching preventing download

- **2.3.4**
    - v70 compatibility

- **2.3.3**
    - Updated tools

- **2.3.2**
    - Updated tools
    - Changed format selection

- **2.3.1**
    - User interface fixes

- **2.3.0: ONE YEAR ANNIVERSARY UPDATE!**
    - Added support for the cruiser!
    - Fixed error when changing boombox color on invalid mesh renderer
    - Improved compatibility with chat modifying mods
    - Improved resync accuracy
    - Improved error reporting
    - Stricter offline mode networking
    - Added mute "always" command
    - You can now mute boomboxes in another player's inventory
    - Sync, pocket play and random boombox color can now be toggled in game, this is saved in the host config
    - Synced config changes will no longer save on non-hosts
    - "rainbow" boombox color is now a gradient (added "randomloop" as a replacement)
    - Changed the download timeout to be based on the audio length
    - Updated config
    - User interface changes

- **2.2.1**
    - Boombox color range fix

- **2.2.0**
    - Tools verification changes
    - Moved audio folder to temporary files directory
    - Moved tools folder to Lethal Company directory (prevents unnecessary redownloading)
    - Added reset-tools command
    - Added colored boombox color text
    - Commands can be prefixed with a dash again
    - Added config tag to console messages
    - Warn host if a request fails because of them

- **2.1.4**
    - Skip checking for existing tools if they already exist
    - Fixed wrong video id being shown for some requests
    - Fixed YPlayBoombox not working with some mods

- **2.1.3**
    - Fixed invalid URL error not being caught
    - Potential fix for getting stuck in downloading tools state
    - NiceChat compatibility patch (messages will no longer delete the rest of the chat history)

- **2.1.2**
    - Fixed time parameter not always working

- **2.1.0-2.1.1**
    - Fixed whitespace in multi-commands
    - Added help (displays the YPlayBoombox wiki link) and status commands
    - Fixed temporary files not deleting
    - Fixed audio clearing prematurely when using multiple boomboxes
    - Fixed cancellation exception
    - Boombox will now unmute locally automatically if muted and toggled on
    - Removed "random" boombox color aliases
    - Potential conflicting mods warning will now only show in the console
    - User interface changes

- **2.0.4**
    - Temporary file management

- **2.0.3**
    - Fixed "Boombox sync" keybind working even if it was disabled
    - Temporary file cleanup
    - Increased maximum audio duration to 12 minutes

- **2.0.1-2.0.2**
    - Bug fixes

- **2.0.0**
    - Fixed YPlayBoombox not working on some boomboxes
    - Changed bindable mute key from [#] to [Backspace] for compatibility with more keyboard layouts
    - Added "rainbow" boombox color
    - User interface changes
    - Added YPlayUtil.dll dependency
    - Changed mod folder structure
    - Updated tools and added checksum
    - Asynchronous tools downloading
    - Increased server-side timeouts
    - Audio normalisation

- **1.1.4**
    - Changed chat message implementation to improve mod compatibility
    - Removed bindable mute key [M], now changed to [#] for compatibility with TooManyEmotes random emoting
    - Possible fix for the boombox showing as muted
    - Added more boombox colors
    - User interface changes
    - Updated tools

- **1.1.3**
    - Fixed keybinds activating in the terminal menu
    - Fixed random boombox colors sometimes not working
    - Fixed resync not being available when "Boombox sync" was disabled
    - Increased server-side timeouts
    - Fixed long URLs not loading in offline mode

- **1.1.0-1.1.2: ONE MONTH ANNIVERSARY UPDATE!**
    - Audio resuming and syncing now only apply to YPlayBoombox audio
    - Improved mod compatibility
    - Play history formatting
    - You can view your play history without a boombox
    - Added server-side timeouts
    - Improved multi-boombox sync
    - Improved memory management/reduced memory usage
    - Boombox volume can be set to 0
    - Boombox can be muted locally
    - Tools caching changes
    - Improved stability
    - Added randomized boombox colors ("Boombox random color" in the config, disabled by default)
    - Added warning if the host does not have YPlayBoombox installed or there is a version mismatch
    - Added boombox resync for late-joiners
    - Updated and optimised user interface
    - Added more informative logging
    - Added experimental offline mode so you can bring your music with you wherever you go (even if the host doesn't have YPlayBoombox installed!)

- **1.0.8**
    - Tools caching
    - Play history now shows the most recently played audio first
    - URL parsing fix

- **1.0.7**
    - Fixed encoded titles not downloading
    - Fixed error messages not sending

- **1.0.5-1.0.6**
    - Improved audio syncing

- **1.0.4**
    - Fixed audio file limits
	- Audio quality changes

- **1.0.1-1.0.3**
    - Fixed invalid package

- **1.0.0**
    - Initial release