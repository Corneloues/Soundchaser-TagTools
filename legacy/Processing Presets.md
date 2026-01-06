I'm GitHub Copilot. Looking at the RegExpReplace files in your workspace, I can explain how the presets are loaded from the INI file.

### How Presets Are Loaded
The presets are loaded from the RegExpReplace.ini file using the MediaMonkey SDB (SongDatabase) INI file API. Here's the key process:

1. **Initial Loading** - Around line 424-450 in RegExpReplace-readable.vbs:

`Set m=SDB.InIfIle.KeYS("RegExpPresets")`

This retrieves all keys from the `[RegExpPresets]` section of the INI file. Each preset is stored as a key-value pair like:

* Key: `Preset1`, `Preset2`, etc.
* Value: The entire preset definition string

2. **Parsing Presets** - The `l()` function around line 3292:
This function extracts individual fields from the preset string using a pattern like:

`Name: "...", Description: "...", FindWhat: "...", etc.`

3. **Building UI Elements** - Functions like `ja()` (line 4631) and `df()` (line 724):
These functions take the parsed preset data and create menu items and toolbar buttons. The presets are organized into:

* **Main Menu** (`mnuRegExpMainMenu`)
* **Toolbar** (`mnuRegExpToolbar`)
* **Tracklist** context menu (`mnuRegExpTracklist`)
* **Now Playing** panel (`mnuRegExpNowPlaying`)

4. **Menu Groups** - Around line 745:
Presets with the same Menu: value are grouped together as submenus using mnuRegExpGroup collections.

5. **Preset Execution** - Functions like `hj()` (line 4631) and `kx()`:
When a user clicks a preset menu item, the preset data is retrieved and applied to selected tracks.

## Key Variables & Collections

* `c4` (line 46): Dictionary storing all available fields for mapping
* `SDB.Objects("mnuRegExpPreset*")`: Dictionary collections storing preset menu items by category (Toolbar, MainMenu, Tracklist, NowPlaying)
* `q8()` (line 3263): Function that retrieves preset string by number: `sDb.iNiFiLE.STriNGvaLuE("RegExpPresets","Preset"&q)`
The preset format is designed to be human-readable while containing all necessary information for the find/replace operation in a single string value.