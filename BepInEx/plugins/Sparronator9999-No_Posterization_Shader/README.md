# No Posterization Shader

Disables Lethal Company's posterization/cel-shading ("outline") effect. Useful if you don't like the effect, or want to use a program like [ReShade](https://reshade.me/) to inject your own post-processing effects.

Tested on v80 only. Earlier versions (v73 or below) should use [LethalSponge](https://thunderstore.io/c/lethal-company/p/Scoops/LethalSponge/) v1.3.6 or lower, with `removePosterizationShader` set to `true` and both `useCustomShader` and `useLegacyCustomShader` set to `false`.

## Installation

### Mod Manager

1.  Install a mod manager if you don't have one already (e.g. [Gale](https://kesomannen.com/gale) or [r2modman](https://github.com/ebkr/r2modmanPlus)).
2.  On this mod's [Thunderstore page](https://thunderstore.io/c/lethal-company/p/Sparronator9999/No_Posterization_Shader/), click "Install with Mod Manager".
    - You can also search for "No Posterization Shader" in your mod manager of choice.
3.  To configure this mod in-game, install [LethalConfig](https://thunderstore.io/c/lethal-company/p/AinaVT/LethalConfig/) (optional).
    - Despite the warning this mod will give when changing settings, you do **not** need to restart the game to apply config changes.

### Manual install

See [this Steam Community post](https://steamcommunity.com/sharedfiles/filedetails/?id=3094256402). Releases can be downloaded from [Thunderstore](https://thunderstore.io/c/lethal-company/p/Sparronator9999/No_Posterization_Shader/), or this mod's [releases](https://codeberg.org/Sparronator9999/LCNoPosterization/releases) page on Codeberg.

## Screenshots

<details><summary><b>Screenshots</b> (click to expand)</summary>

![Interior of the autopilot ship, facing towards the main monitors](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/AutopilotShip.apng)

*Remove weird lighting artifacts!* ([before](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/AutopilotShip_Before.png), [after](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/AutopilotShip_After.png))

![Marsh, as viewed from the autopilot ship's front balcony](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/Marsh.apng)

*Works on v80!* ([before](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/Marsh_Before.png), [after](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/Marsh_After.png))

![A dark Facility room](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/FacilityInterior.apng)

*See (slightly) farther in dark rooms\*!* ([before](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/FacilityInterior_Before.png), [after](https://codeberg.org/Sparronator9999/LCNoPosterization/raw/branch/main/Images/FacilityInterior_After.png))

<sub>\* **WARNING:** may be considered cheating by some people!</sub>

</details>

## Compiling

1.  Install [Visual Studio](https://visualstudio.microsoft.com/) with the `.NET Desktop Development` workload checked.
    - This mod was made using Visual Studio 2022, however the link above will download Visual Studio 2026 instead. See [here](https://visualstudio.microsoft.com/vs/older-downloads/) for older downloads (requires a Microsoft account that has joined the free [Dev Essentials](https://visualstudio.microsoft.com/dev-essentials/) service).
2.  Download the code repository, or clone it with `git` ([download link](https://git-scm.com/install/windows) for Windows).
3.  Extract the downloaded code, if needed.
4.  Copy your game's `Assembly-CSharp.dll`, `Unity.RenderPipelines.HighDefinition.Runtime.dll` and `MMHOOK_Assembly-CSharp.dll` to the `lib` folder of your downloaded code.
    - See the `lib` folder's [README](https://codeberg.org/Sparronator9999/LCNoPosterization/src/branch/main/lib/README.md) for details on how to locate these files.
6.  Open `LCNoPosterization.sln` in Visual Studio.
7.  Click `Build` > `Build Solution` to build everything.
8.  Your output, assuming eveything went well, should be located in `bin\Debug\netstandard2.1\` (with the default `Debug` config).
9.  ???
10. Profit!

## License and Copyright

Copyright © 2026 Sparronator9999.

This mod is licensed under the [MIT License](https://codeberg.org/Sparronator9999/LCNoPosterization/src/branch/main/LICENSE.md).
