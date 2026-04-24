Additions for the cruiser. all features are client-sided and have configs

(client-sided as in all features will work even if you're playing with other players that don't have this mod)

* <details><summary>Screenshots</summary></p>

  * <details><summary>Storage light</summary></p><img src="https://i.ibb.co/Q6N7WL8/cruiser-screenshot-1.png"></p><img src="https://i.ibb.co/PZ1Bpqj/cruiser-screenshot-2.png"></p><img src="https://i.ibb.co/FBY5bv8/cruiser-screenshot-5.png"></details>
  * <details><summary>Scrap items</summary></p><img src="https://i.ibb.co/b7ykvFL/cruiser-screenshot-4.png"></p><img src="https://i.ibb.co/pb3fMzs/cruiser-screenshot-8.png"></p><img src="https://i.ibb.co/T150Xqq/cruiser-screenshot-6.png"></details>
  * <details><summary>Speedometer</summary></p><img src="https://i.ibb.co/vH3H4r0/cruiser-screenshot-3.png"></details>
  * <details><summary>Magnet lever</summary></p><img src="https://i.ibb.co/LR9W814/cruiser-screenshot-7.png"></details>
</details>

* Magnet rotation
  * fixes the cruiser rotation when magneted to only be 90 or 270 (parallel to the ship). otherwise at certain angles (~225 or 315-360) it can be magneted to 180 or 360 and be partially inside the ship
  * host must have this enabled for it to apply. all clients will see the fixed rotation if host has this enabled
* Move items
  * move items from the cruiser to the ship when going into orbit. the items are only moved if they were collected (like with the magnet)
  * this is client sided so items are only shown to have been moved to players with this enabled
  * if one player has this enabled and another player has this disabled (or doesn't have this mod), the item positions will be different, however picking up the item/s will resync the position
  * in vanilla any collected items in the cruiser will be moved to the ship when leaving and rejoining after the game saved, so this feature is the same as vanilla except without having to leave and rejoin
* Only move scrap items
  * only moves scrap and leaves other items in the cruiser
  * if the host has this mod this will be set to what the host has this set to
* Mute engine/radio audio
  * mute engine/radio audio while in orbit
* Storage light
  * adds a light to the storage area of the cruiser
* Storage light switch
  * adds a button in the storage area of the cruiser for turning on/off the storage light
  * turning the light on/off is synced with other players if the host has this mod
* Scrap items
  * adds a cruiser item and an alternate cruiser item
  * items are a percentage based retexture of v-type engine, and are synced with other players if the synced percentages config is enabled
  * item types are saved to the save file if the save/load config is enabled
* Item interactions
  * adds interacting with the cruiser items by clicking while holding them to play an event
  * events are a mix of audio and visual effects, there are about 49 events, some events have follow-up effects that are related to or continue the previous effect
  * host must have the item interactions config and the scrap config enabled for the events to be synced between players. if host has either config disabled or doesn't have this mod then the events will play locally instead
  * <details><summary>Toy car interact events</summary></p><pre>
    Toy car
    1.01 - Music1             - plays radio 1, stops playing music (0.2s cooldown)
    1.02 - Music2             - plays radio 2, stops playing music (0.2s cooldown)
    1.03 - Music3             - plays radio 3, stops playing music (0.2s cooldown)
    1.04 - Music4             - plays radio 4, stops playing music (0.2s cooldown)
    1.05 - ExtremeStress      - plays extreme stress audio and switches gear to park (0.2s cooldown, 5s duration), switches gear to reverse/drive
    1.06 - SwitchGear         - switches gear to park/reverse/drive
    1.07 - PressSpace         - plays jump or boost audio
    1.08 - SetPlayerInCar     - plays getting in cruiser audio
    1.09 - Key                - plays 1/3 key audio
    1.10 - Collisions1        - plays 1/2 minimum collision audio, 30% chance to play 1/2 maximum collision audio or break windshield effect
    1.11 - Collisions2        - plays 1/3 medium collision audio, 30% chance to play 1/2 maximum collision audio or break windshield effect
    1.12 - FrontHood          - opens the hood, 40% chance to play pour oil/pour turbo audio, closes the hood
    1.13 - Rolling            - plays wheels rolling on terrain audio, stops playing rolling audio (0.2s cooldown)
    1.14 - LeftDoor           - opens the left door, 5% chance to play getting in cruiser audio, closes the left door
    1.15 - RightDoor          - opens the right door, 5% chance to play getting in cruiser audio, closes the right door
    1.16 - Spring             - activates the ejector seat (1.7s cooldown)
    1.17 - Windshield         - turns on the windshield wipers, turns off the windshield wipers
    1.18 - CabinWindow        - closes the cabin window (0.2s cooldown), opens the cabin window (0.2s cooldown)
    1.19 - LiftGlass          - opens the eject button glass, 30% chance to play spring effect, closes the eject button glass
    1.20 - FrontHoodFire      - opens the hood and starts fire, 10% chance to play pour oil audio, closes the hood and stops fire
    1.21 - StorageDoor        - opens the storage door, 15% chance to play storage light switch audio, closes the storage door
    1.22 - Headlights         - turns on the headlights, turns off the headlights
    1.23 - StorageLightSwitch - plays storage light switch audio
    1.24 - Magnet             - plays magnet on audio, 50% chance to play item collected audio, plays magnet off audio
    1.25 - OpenRandomDoors    - opens 1-4 doors, 20% chance to start fire when hood is opened, closes doors. [80% rarity]
    1.26 - ScaleToyCar        - decreases toy car scale over time (3s cooldown, 8s duration), resets scale after duration or interacting (0.2s cooldown). [60% rarity]
    1.27 - ColoredHeadlights  - turns on the headlights with a random color, turns off the headlights. [60% rarity]
    1.28 - Pumpkin            - spawns the Jack-o-Lantern and plays pumpkin audio (0.2s cooldown, chain), despawns pumpkin (0.2s cooldown). [40% rarity]
    1.29 - Plushie            - spawns the Plushie pajama man and plays plushie audio (0.2s cooldown, chain), despawns plushie (0.2s cooldown). [70% rarity]
    1.30 - Goldfish           - spawns the Goldfish and plays goldfish audio, despawns goldfish (0.2s cooldown). [60% rarity]
    1.31 - DiscoBall          - spawns the Disco ball and plays disco audio, despawns discoball (0.2s cooldown). [70% rarity]
    1.32 - Boombox            - spawns the Boombox and plays 1/5 boombox audio or 40% chance to play 1/4 cruiser radio audio, despawns boombox. [40% rarity]
    </pre><pre>
    Toy car (Exploded)
    2.01 - Collisions1                - plays 1/2 minimum collision audio
    2.02 - Collisions2                - plays 1/3 medium collision audio
    2.03 - Collisions3                - plays 1/2 maximum collision audio
    2.04 - Collisions4                - plays 1/3 obstacle collision audio
    2.05 - ChainedCollisions          - plays any 1-3 collision audio (0.2s cooldown, chain)
    2.06 - ChainedCollisionsExplosion - plays any 1-3 collision audio (0.2s cooldown, chain), explosion when chain ends, stops fire
    2.07 - Explosion                  - plays explosion effect and starts fire, 10% chance to play pour oil audio, stops fire
    2.08 - ChainedBoost               - plays boost audio, 30% chance to also play any 2-3 collision audio (0.2s cooldown, chain)
    2.09 - ChainedBoostExplosion      - plays boost audio, 30% chance to also play any 2-3 collision auido (0.2s cooldown, chain), explosion when chain ends, stops fire
    2.10 - ExtremeStressExplosion     - plays extreme stress audio (0.2s cooldown, 5s duration), plays explosion effect, stops fire
    2.11 - CollectToyCar              - plays item collected effect (15s duration), 20% chance to rotate faster and or reversed, stops playing item collected effect (0.2s cooldown)
    2.12 - Pumpkin                    - spawns the Jack-o-Lantern and plays pumpkin audio (0.2s cooldown, chain), despawns pumpkin (0.2s cooldown). [60% rarity]
    2.13 - Plushie                    - spawns the Plushie pajama man and plays plushie audio (0.2s cooldown, chain), despawns plushie (0.2s cooldown). [20% rarity]
    2.14 - Goldfish                   - spawns the Goldfish and plays goldfish audio, despawns goldfish (0.2s cooldown). [20% rarity]
    2.15 - DiscoBall                  - spawns the Disco ball and plays disco audio, despawns discoball (0.2s cooldown). [60% rarity]
    2.16 - Boombox                    - spawns the Boombox and plays 1/5 boombox audio or 40% chance to play 1/4 cruiser radio audio, despawns boombox. [60% rarity]
    </pre><pre>
    - default cooldown = 0.5s
    - chain = clicking again within 2s has a decreasing chance to play the same effect
    - rarity = percentage that this event is played and not rerolled
</pre></details>
* Speedometer
  * adds a speedometer
* Cruiser position/rotation when joining
  * when joining a lobby with a cruiser, it will be on the magnet instead of on the opposite side of the ship
  * also fixes the 'rotation quaternions must be unit length' error from the cruiser after joining
* Cruiser 1up
  * allows purchasing another cruiser in the same day if the current cruiser is destroyed
* Magnet lever
  * adds a lever to the cruiser for turning on/off the ship magnet
* Headlights
  * config for setting whether the headlights are on or off when the cruiser is spawned
* Disable input while typing
  * config for setting whether driving the cruiser (wasd/space) is disabled while typing in chat
* Separate jump/boost keybinds
  * config for setting if an additional key needs to be pressed to use boost, so jump and boost can be used separately

cs in zip. source code in changelog. discord@4902