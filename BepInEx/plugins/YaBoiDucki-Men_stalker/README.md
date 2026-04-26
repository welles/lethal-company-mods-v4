# Men-stalker (Additional mob)

**Add a new dungeon monster who heavily rely on prolonged stalking phase and explosive chase phase**

## Content
Add a new dungeon monster "Men stalker". 
A rare monster with a power level of 3 who can only spawn once per day.
It takes the apparence of a tall, slender, rough looking human.

## Behavior 

[![Capture-d-cran-2024-03-30-201347.png](https://i.postimg.cc/52gBpBTQ/Capture-d-cran-2024-03-30-201347.png)](https://postimg.cc/FYfkHL9h)

When it finds a player, it will begin to stalk him from a distance, while trying to hide from scavengers as much as possible. 

When stalking, Men-stalker makes no sound (except when opening door), and will continue to stay passive and stalk the player for a considerable amount of time.

When it is finally done stalking, it will seemingly run away, before finally deciding to transition into an explosive chase phase, chasing the closest player until either all scavengers are out of the dungeon, or whenever there isn't any scavenger nearby after some time. 

However, It can be killed, and you can lose it during the stalking phase by running far enough from it. 

When they are chasing you, remember that they don't do much damage per attack and struggle to open door.

<strong>Since they are a rare mob who likes to stalk before chasing the player, Men-stalker are a difficult monster to deal with. Once spotted however, they are significantly easier to deal with, which is itself a somewhat difficult thing to do especially if you don't actively look out for them.</strong>

## Credit
A massive shoutout to the lethal company modding's discord server : they have helped me on many occasion to solve problems.
I also would like to thank the writers of the lethal company modding's wiki, and to the creator of the ExampleEnemy's unity project.

## Changes
 - v1.0.0 : 
        ALPHA : Online testing phase.
 - v1.0.1 : 
        Updated the mod's page 
 - v1.1.0 : 

        Fixed buggy backward-walk animation

        Greatly increased spawn chance 

        Fixed "Scared" backward walk
 - v1.2.0 : 

        Improved pathfinding (A buff)

        Fixed buggy run-animation

        Reduced "target lost cooldown" (Nerf)
 - v1.2.1 :

        Overall increase to spawn chance

        Changed the spawning probability mechanism : spawn probability increase rapidly over the day

        Fixed a few lines of code to make it "more likely" to bump into the entity

        Dependency updates

        Massive thank you to an anonymous player for letting me know of an issue with spawn probability
- v1.3.2 : 

        Fixed id's naming problem : thanks to the people of the lethal company's modding server ! 

        Fixed the unresponsive HitEnemy function 

        Fixed rotation angle
- v1.4.0 :

        Default State swaped to STALK instead of IDLE
        Explanation : Minor impact overall, even if all of the playe suddenly went out of the dungeon, would remain in STALK state for a while, this should make it more frequent for it to enter it's RUSH state.

        RUSH state's move speed decreased
        Explanation : This is to give a player without a weapon a decent chance to escape the Men-stalker, so long as he knows how to exploit the map layout (mainly knowing where each doors are at)

        STALK state duration extended, STALK state movement speed reduced overall
        Explanation : This should make it easier to spot the Men-stalker, as it was previously too difficult to do so.


- v1.5.0 : A very much needed but late bux-fixing + dependance update. Removed the deprecated tag. Reverted the change of making the "default" state being STALK instead of IDLE. 
- v1.6.1 : 
       
        Improvement on the IDLE state
        Explanation : Roams around the map a lot more, should make it more frequent to find it.
        Balancing : 

        While stalking, if it doesn't have a direct LOS to the nearest player, it's speed is halved 
        Explanation : this should allow the player to have an easier time spotting it during it's stalking phase 

        While stalking, if all player quit the dungeon, would remain in stalking state until the cooldown goes down
        Explanation : Minor impact in multiplayer, major one in single player. Back then, if player constantly went in and out of the dungeon, if all were out, then it would be harder for it to enter it's attack phase
- v2.0.0 : 

        Updated the model 

        Increased the IDLE state's roaming speed
        Explanation : Even more likely to "encounter" (not "see") the Men-stalker

        New sub-state to the IDLE state : When a scavenger is within a certain distance, will begin the "investigate" phase :
        This doesn't mean it will transition to a STALK state, but means that the Men-stalker will slowly approach the position of the scavenger, 
        until the Men-stalker fully detect the scavenger (close distance), and then would finally enter his STALK state.
        Explanation : Should massively increase the likelyhood of encounter with the Men-stalker.

        While in STALK state, changed various speed parameter depending on the existance of LOS and the distance between the targetPlayer and the Men-stalker
        Explanation : Improve the feeling that you are being stalked by always making it stay far from you, but not invisible if you pay attention. +immersion

        While in IDLE state, increased detection range (significantly)
        Explanation : to reduce the amount of "awkward bump" with the Men-stalker

        Updated the Terminal Entry
        
        Update the mod's page
- v2.1.0

        Updated the namespace's "name" (pun unintended)
        
        Updated the terminal entries's background video to be more transparent

        Shortened the "RUSH" state's "chase cooldown" 

        Updated the "RUSH" state's voiceclip

        Updated the mod's page
- v2.1.1
        Damage decrease : 35 -> 20 
        Unfortunately, since I moved on from the project a bit, there won't be an update to add a config file. Sorry to the guy who asked if I could for taking so long !

- v2.2.0
        Compatibility update

- v2.3.0-
        Cleaning up the texture
        Typo fixed
- v2.4.0
        A series of extra-fat nerf

        Chase sequence speed : 15 -> 9 (For reference : slightly faster than Thumper, while being leagues better at turning corner)
        Explanation : Extreme speed made it night very hard to escape him even if RNG is on your side by overcrowding the dungeon with door. It also indirectly made his chase sequence essentially endless.

        Extended his max chase sequence duration by 10 seconds

        Fixed a bug that affected when his chase sequence ended 
        Explanation : Should make his chase sequence actually end. 

        Stalk sequence changes : Men_stalker cannot transition into his chase sequence so long as he hasn't directly stared at a scavenger for a least 5 seconds.
        Explanation : This should make it easier to spot the Men_stalker during his stalk sequence. You now are guaranteed to have at the very least 5 seconds to spot him during the stalk sequence. Additionally, if he didn't had at least 5 seconds of visual contact with a scavenger when his stalking cooldown ends, he will also start to "aggresively" stalk you (Thus giving scavengers more opportunity to catch him)
- v2.5.0 

        Various changes : 
        The minimum amount of time the men-stalker has a LOS to a player before it can transition into his rush phase : 5 -> 15

        The chase sequence's timer : Used to start as soon as a scavenger is within 30 units, now it can only start when the men-stalker has a LOS to a scavenger.

        The stalking phase's duration : 55/75 seconds ->  40/60 seconds

        Smoother animation transition 

        Double the spawn probability

        Tweaked the model 

        Explanation : It was decided that the Men-stalker would need to have a longer eye contact with a scavenger (Double) to actually offer the players a chance to spot him. We have also doubled his spawn ratio and shortened his stalking time to make him more present in a game.

- v2.5.2

        Updated the model (Fixed gap, reajusted material).
        
        Fixed a bug where the man-stalker will "bounce around" during a specific time of the stalking phase.
        
        Rush sequence's chase speed : 11 -> 9.5 

        When it fails the stalk sequence, will ROAM, intead of IDLE. This is to actually reward the player team who lost it.

        While stalking : when the target is lost, increase the total duration of the stalking phase by 2 sec every 1 sec it has lost it's target : further means to reward player who loses it. (So up to +30s of gained time, or losing it, whichever comes first)

- v2.5.3

        Bug fixing

- v2.5.4

        ...

- v2.5.7

        Bug fixing, if there is.

        Slight increase in "Rushing" speed (9.5 -> 10.5)

- v2.6.0
        Huge code cleanup/revamp : Less prone to bug and a lot more readable

        Roaming duration -> 120s : Properly evading the MS now ensures the scavengers gets proper reward by getting rid of it for 2 minutes. Also improves the gameplay feedback : that's because you can't see it for 2 minutes after evading it, which means it should be more obvious for the player when you actually evade it. But since the entirety of the design behind this Dungeon entity revolves around "the unknown", you sometime still can't be too sure, although this can be discarded as simply being part of it's design.

        Stalking sequence -> lowered by 10s : direct consequence of the above.

        Stalking sequence -> triggering the stalk phase while an initial eyecontact hasn't been made beforehand extends the stalking sequence's duration : Prior to this it was the opposite, which made sense "lore" wise, but gameplay wise it just penalizes player who couldn't see it beforehand while giving an unnecessary reward to player who did see it beforehand

        Chase sequence -> chase duration increased by a flat +5s (Duration span between 25s-35s): Felt too short prior, ended too abruptly. Small ajustement to make it longer. Also a direct consequence of the above Roaming sequence's change.
        
        Several bug fixing 

        Fixed an issue where the MS's mesh was not set to be in Enemy layer

        Stalking sequence, each seconds where the MS has lost it's target, increases the stalking sequence's duration by; from 3.0s -> to 1.5s : Direct consequence of ---, before this said change was implemented, this mechanic acted as the "reward" for losing it, but the reward had poor gameplay feedback on the player due to it being too subtle, so now in theory this mechanic is obsolete. That being said, we will still keep it, although the effect are greatly mitigated.

        The general trend of this patch being : When MS is setting up for an attack, it's more likely to attack and it's more impactful, but evading it will lead to an abruptly long pause, long enough to be noticeable, which should make it worthy to attempt at losing it (instead of just sitting down and giving up), on top of being more obvious in how to deal with the MS.

- v3.0.0
        New Model : Higher poly count (12k vs 7k), but is much cleaner and allows for much smoother animation
        
        New animation : Improved animation, much smoother and a more organic movement

        Bug fixes : Now plays a walking-backward animation when the MS is retreating during its stalk phase.

- v3.1.0
        v73 support. (Not fully tested yet : please report any bugs in the lethal company modding discord ! Thanks)

- v3.1.1
        Thunderstore front page updated

- v3.1.2
        Bug fixes