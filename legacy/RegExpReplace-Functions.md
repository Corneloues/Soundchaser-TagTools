# RegExpReplace-readable.vbs — Sub/Function Catalog (v4.4.9)

## Startup & UI Wiring
- **OnStartUp** – Registers option sheet, loads/converts presets, sets defaults, builds menus/toolbar/buttons, attaches handlers.  
- **OptionsDialog / iz / b3** – Show and persist add-on options UI.  
- **q4** – Adds “Manage Presets…” and “Options…” menu entries plus last-executed placeholders.  
- **nx** – “Manage Presets” dialog scaffold.  
- **b8** – Main Find/Replace dialog scaffold (builds controls, binds events).  
- **mw** – Syncs checked state across toolbar/menu entries; enable/disable UI during operations.  
- **ln** – Enable/disable UI during operations.

## Preset Storage & Parsing
- **ae, cq, q8** – Write/delete/read preset lines in INI.  
- **l** – Parse a named field or indexed token from a preset string.  
- **pj** – Unquote a value.  
- **dg** – Quote/escape for preset serialization.  
- **pc** – Serialize current preset state back to INI.  
- **ra** – Load preset fields into in-memory state.  
- **ih** – Expand `<Into/From Field>` placeholders in preset names.  
- **e7** – Normalize preset key ordering (sorting).  
- **ha** – Import/merge presets between INIs; add missing samples.  
- **ql** – Rewrite INI section after deletions/cleanups.  
- **pi** – Delete preset (reindex, menus cleanup).  
- **mr** – Swap two presets (and regroup menus/toolbars).  
- **kz** – Edit/update a preset row in the manage dialog.  
- **pw, py, de, j7, p9** – Maintain menu/toolbar dictionaries when presets move/change groups.  
- **po** – Count presets in a menu group.  
- **ho** – Build toolbar buttons for presets flagged “Toolbar.”  
- **et** – Resolve icon + name for a preset (register icon if file).  
- **kg, pl** – Track and expose last-executed preset buttons.

## Preset Management Dialogs
- **dv, nw, eq, p6, gf, fg, h4, ko, d9, cz, ar** – Field-change handlers that refresh preview or state.  
- **p7** – Save/create/update preset from dialog into INI + menus.  
- **mh** – Delete selected preset (with confirmation).  
- **ll** – Bulk delete selected presets in manage dialog.  
- **bd, lh, ic, pg** – Toggle source INI (app vs external), browse file, load presets table.  
- **fv, a3, fl** – Render/manage presets table HTML, word-wrap toggle.  
- **k7, ig, dy, il, ge, mm, ca, h5, qs, k5** – Row selection and drag/hold move (up/down) behaviors.  
- **mb** – Click handling in manage list (select/move/sort checkboxes).  
- **bf** – Resort/refresh table timer handler.

## Execution Flow (Apply Preset)
- **kx** – Execute a preset by name; optional adjust dialog; confirmation; restore state; returns preset number.  
- **hg** – Apply current find/replace across selected/visible tracks; progress, error handling.  
- **oh** – Orchestrate per-field replacement; resolves target fields; calls `jy`.  
- **jy** – Apply replacement to a specific field/path; handles filesystem moves, tags, cleanup of emptied folders.  
- **r2** – Compute replacement text for one value (regex/VBScript/whole-word/match-case logic).  
- **hv** – Highlight matches/replacements for preview panes.  
- **bp** – Test if pattern is found in a string (find side).  
- **cm, mv** – Resolve current song field expression.  
- **d1, ht (dict)** – Setter helpers for composite fields (date, path, etc.).  
- **ep** – First regex match for highlighting.  
- **MapChr, MapChrCase, MapArray, MapArrayCase, MapArrayEx** – Mapping utilities for replacements.  
- **RegExp, RegExpEx, RegSub** – Regex helper wrappers.  
- **k6** – Expand parameter placeholders (<NUMBER/STRING>, <Into/From Field>) in find/replace patterns.  
- **mf** – Placeholder handling in preset names/expressions.  
- **SetVar, GetVar, LetVar** – Temp variable storage for VBScript expressions.  
- **DateISO, DateTimeISO, Choose, IIf, IfNull, Min, Max, SQLQuery** – Utility helpers exposed to expressions.  
- **bp, ep, hv, r2** – Core find/replace matching pipeline.

## Track List & Navigation
- **q0** – Initialize track list (selected vs visible vs now playing).  
- **io, iv, e2, gg, nl, qw, px, ah** – Navigation/find-next/prev, replace, replace-all commands.  
- **am** – Build per-track preview table rows.  
- **cy** – Update preview row after replacement.  
- **bm** – Keep/remove/select matched/unmatched/replaced tracks (playlist/main list manipulation).  
- **eu** – Determine if current view is Now Playing vs main list.  
- **aw, es, mq, g8, jm** – Sync with MM selections/track changes.  
- **ai** – Checkbox handling in preview table.  
- **f9, lb, it, lj, qb, c3, o5** – Enable/disable controls based on state/selection.

## Sorting, Moving, Timers
- **hs timers (ge/mm/qs/h5/k5/ca/d2)** – Smooth scrolling row move (press/hold).  
- **kc/bf** – Initial refresh timer for manage dialog.  
- **l0/bx** – Safeguard unexpected errors during preview refresh.

## Misc Utilities
- **pf** – HTML-escape with spaces/newlines preserved; render preset row highlight (with `ls`).  
- **a6** – Locate skin CSS; choose default background.  
- **be** – Timezone adjust datetime.  
- **lr** – Maintain recent find/replace history lists.  
- **hm, no** – Read/write history/opts from INI.  
- **le, em** – Respond to Options changes; refresh fields/menus; update skin CSS links.  
- **gw, ml** – Fill default regex patterns for comment/lyrics vs others.  
- **dr, hp, ci** – Track “dirty” state for current preset edits.  
- **fp** – Prompt to save modified preset on close/change.  
- **n8** – Close dialog cleanup.  
- **nd, jl, hj, an** – Menu/toolbar click entry points (execute preset or open dialog).  
- **kg, pl, nd** – Last executed preset handling/visibility.  
- **j5** – Show regex/VBScript quick reference HTML.  
- **n0** – Open project homepage.

## Field Mapping Dictionaries
- **c4** – Maps friendly field names to song data expressions (title/artist/album/path/custom, etc.).  
- **ht** – Field setter overrides (dates, path pieces, playback %, track type, etc.).  
- **d7** – Custom field labels cache; refreshed in `em`.  
- **c8** – SQL query cache for `SQLQuery`.

## State Variables (note)
- Numerous globals track UI state, selection, histories, options flags, and cached regex objects (`ef`).