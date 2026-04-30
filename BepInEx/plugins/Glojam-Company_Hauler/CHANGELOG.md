## 1.1.2 - 2026/2/8

- Added sittable 5th seat between the two rear ones, great for MoreCompany
- Chime for driving away with one of the side doors open
- Fixed manual
- Fix key mesh being the wrong mesh

## 1.1.1 - 2026/2/1

- Fixed issue causing hauler to permanently break when loading a save with one magneted to ship
- Removed redundant patch files
- Fixed issues caused by modded damage triggers

## 1.1.0 - 2026/1/31

- Undeprecated
 - Finally fixed out-of-date networking problems relating to v73 unity version change, which solves issues such as back seats causing the car to fly
- Implemented multiple QOL stuffs with the assistance of ScandalTheVandal:
 - Protect seated players from getting hit by the giant kiwi bird
 - Protect seated players from getting bit by mouthdogs
 - Protect seated players from getting grabbed by radmechs
 - Fix visual issues caused by vanilla interactable objects that messed with animations
 - Improve network syncying for various things, including car health & wheel speed
 - Better collision
 - Mute audio in orbit
 - Wheel physics improvements
 - Hauler no longer passively heals while in orbit
 - Some other things

 In addition, Scandal is now a maintainer of the project and is currently working on a major overHaul.

## 1.0.5 - 2025/8/22

- (Probably) fixed instability at high angular velocity causing the vehicle to fly off
- Removed extra wheel colliders causing instability
- Added collider to prevent the giant bird from erroring

## 1.0.4 - 2025/8/3

- Raised the vertical driver camera position component to better allow you to see over the hood
  - *Note: this makes the sunroof button a little harder to see. Not interested in changing the whole vehicle mesh for this right now though.*
- Added a config for vehicle health, changed default health from 200->100
  - *This stat only reflects small amounts damage. If you drive into a wall at full speed, you will always explode.*
- Fixed being able to trigger the chime sound when not seated in the driver seat
- Removed glare on the windshield
- Increased headlight range, intensity, and width, and angled them toward the ground more
- Added a few more game objects to hide when the vehicle blows up

## 1.0.3 - 2025/7/9

- Quick fix for incorrect giant patch code

## 1.0.2 - 2025/7/9

- Reduced the cost of the hauler 600 -> 530
- Fixed a prefix patch with incorrect logic causing giants to never eat you outside of the car
- Adjusted the front collider zone to *hopefully* improve jank when colliding into seemingly flat surfaces
- Driver override animations are now visible to other clients
- Reduced the texture resolution of the mirrors by half
- Added a config to disable the side mirror rendering (clientside only)
- Fixed Collider layer objects being visible in mirrors

## 1.0.1 - 2025/7/1

- Removed the LobbyCompatibility dependency
- Fixed the license being blank

## 1.0.0 - 2025/6/30

- Feature complete
- Currently, driver animations don't sync to non-drivers. I am trying to fix this, but it may not be possible.
- Traction control light currently only shows for the server host due to an oversight in Cruiser code
