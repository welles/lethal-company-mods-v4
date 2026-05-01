![YPlayBoombox](https://img.shields.io/badge/Lethal_Company_-V81-blue?style=flat-square) [![](https://img.shields.io/badge/Troubleshooting-blue?style=flat-square)](https://thunderstore.io/c/lethal-company/p/kerotein/YPlayBoombox/wiki/3319-troubleshooting/)

## Features
- Boombox and cruiser YouTube audio playback.
- Accurate audio pausing, resuming, and syncing between players.
- Networked customizable boombox colors.
- Networked volume control, with local muting.
- Play different audio on separate boomboxes.
- Play audio without the host (offline mode).
- Playback history to play your previously entered URLs.
- Progress updates so you know exactly when each player is ready.
- Simple error reporting and documentation.
- Low memory and disk space usage (files are stored temporarily while in the lobby).
- Handsfree playback.
- Audio duplication (with "Sync" enabled).
- Automatic tool updating.

## Compatibility
Supports the base game boombox and cruiser only.

## Installation
- All players must have the latest version of YPlayBoombox installed to hear the audio.
- Install using a compatible mod manager or place the YPlayBoombox folder into your BepInEx/plugins folder.
- You may need to disable other boombox and cruiser mods if they cause compatibility issues.

## Usage
To use YPlayBoombox:   
1. Hold or look at a boombox, or sit in a cruiser.   
2. Type **/yp** into the chat, followed by a space and then any of the following commands:   
*Round brackets - select a value, square brackets - enter your own value.*

## Commands
**View all commands**   
/yp   

**Load audio**   
/yp [url]   
/yp https://www.youtube.com/watch?v=dQw4w9WgXcQ   
*You can grab the YouTube URL by right-clicking the video and clicking "Copy Video URL".*

**View and select play history**   
/yp (history | hist | h) ?[index]   
/yp history   
/yp history 2

**Actions**   
/yp actions   
View a list of possible commands that can be used on the boombox and cruiser.

### Boombox and cruiser

**Change playback time**   
/yp (time | t) [seconds]   
/yp time 60   
*YouTube timestamps are also supported, right click the video and click "Copy Video URL at current time".   
Seek accuracy is not guaranteed*.

**Mute locally**   
/yp mute ?(none | all | always)   
/yp mute all   
*"always" will mute all boomboxes and cruisers until turned off using the "/yp mute none" command.*

### Boombox only

**Change color**   
/yp (color | col | c) ([r,g,b] | [color] | random | randomloop | rainbow)   
/yp color 255,255,255   
*You can find a list of valid color names on [[w3schools](https://www.w3schools.com/cssref/css_colors.php)].*

**Change volume**   
/yp (volume | vol | v) [1-10]   
/yp volume 5

### Settings

**Settings**   
/yp (settings | config | conf)   
View the current YPlayBoombox settings.

**Sync**   
/yp sync   
Toggle sync for the lobby (if host), this is saved in the host config.   
This command can only be used if no download has been initiated yet. Restarting the lobby will allow this command to be used.   
*See "Config" below for more information about this command.*

**Boombox random color**   
/yp (boomboxrandomcolor | brandcolor | brc)   
Toggle boombox random color for the lobby (if host), or for you (if offline), this is saved in the host config.   
*See "Config" below for more information about this command.*

### Misc

**Status**   
/yp (status | stat)   
View the network mode and installation information.

**Update tools**   
/yp update   
This will redownload FFmpeg, yt-dlp and Deno which are used to download the audio - this command is useful if they are invalid or out of date.

**Offline mode**   
/yp (offline | off)   
This will disable YPlayBoombox networking between you and the host.   
*Offline mode is not recommended, as it will create different play states between players.*

## Keybinds
**Sync**   
Q   
Rebindable   
Sync to another boombox or cruiser, or resync (redownload) the audio.   
*Only available if "Sync" is enabled in the config.*

**Reset**   
R   
Rebindable   
Reset the playback time to 0 and stop playback.

**Mute locally**   
Backspace   
This will mute the boombox or cruiser for you only, and will not affect other players.

**Boombox volume up**   
PageUp   
Rebindable   
Increase the boombox volume.

**Boombox volume down**   
PageDown   
Rebindable   
Decrease the boombox volume.

**Play history next**   
RightArrow   
Rebindable   
Navigate to the next page in your play history.

**Play history previous**   
LeftArrow   
Rebindable   
Navigate to the previous page in your play history.

## Config
**Sync**   
false* | true   
Overriden by host   
Copy the audio and time of another boombox or cruiser, and allow them to play the same audio.   
*This is resource intensive but offers more features and accurate syncing.*

**Boombox random color**   
false* | true   
Overriden by host   
Boomboxes are spawned with a random color!