# RegExpReplace Add-on (v4.4.9) — Retrospective Design

## Purpose & Scope
- MediaMonkey 4 add-on to batch find/replace tag values and file paths using presets (INI-driven).
- Provides dialogs, menus, and toolbar entries for quick preset execution and ad-hoc regex/VBScript transformations.

## Core Artifacts
- **RegExpReplace.vbs**: Main logic, UI wiring, preset parsing, execution engine, persistence.
- **RegExpReplace.ini**: Preset storage in `[RegExpPresets]` with serialized field/value strings.
- **Resources (icons/toolbar/menu)**: Bound at runtime based on preset metadata.

## Data Model
- Presets stored as key/value pairs (`Preset1=Name:"...", FindWhat:"...", ...`) in the INI.
- Parsed into an internal object/dictionary with fields: `Name`, `Description`, `FindWhat`, `FindInto`, `FindRegExp`, `WholeWord`, `ReplaceWith`, `ReplaceFrom`, `ReplaceRegExp`, `ReplaceVBScr`, `MatchCase`, plus optional grouping (`Menu`), shortcut, icon, toolbar visibility.

## Load & Parse Flow
1) **INI read**: `SDB.IniFile.Keys("RegExpPresets")` to enumerate preset keys.  
2) **Preset fetch**: `SDB.IniFile.StringValue("RegExpPresets", "PresetN")`.  
3) **Parsing**: Parser (e.g., `l()` in readable source) tokenizes `Name:"..."` pairs into fields; handles quoted strings and flags.  
4) **Validation**: Minimal validation—assumes well-formed serialized preset strings.

## UI Composition
- **Dialogs**: Single preset picker dialog plus per-preset execution dialog (shows Find/Replace fields and target tag/path options).
- **Menus/Toolbar**: Items generated from parsed presets; grouped by optional `Menu` tag; placed in main menu, tracklist, now playing, and toolbar collections.
- **Shortcuts/Icons**: Read from preset metadata; applied if present.

## Execution Pipeline
1) **Context selection**: Uses current track selection (tracklist/Now Playing) or focused item.  
2) **Source text retrieval**: Reads from `ReplaceFrom` field (or same as target if not specified).  
3) **Find step**: Regex vs literal based on `FindRegExp`; `WholeWord` and `MatchCase` adjust regex flags.  
4) **Replace step**: Literal replace or regex replace if `ReplaceRegExp`. If `ReplaceVBScr` is set, runs VBScript expression (`Eval`) to compute replacement (allows swaps, computed values, min/max, etc.).  
5) **Write-back**: Writes to `FindInto` (target field) via SDB tag setters; special cases for path-related operations.  
6) **Batch loop**: Iterates tracks; may show progress; limited error handling.

## Notable Features
- **Swap fields**: Uses VBScript eval and temporary vars to swap source/destination.
- **Copy-if-empty**: Uses regex `^$` to gate replacements.
- **Field list**: Dictionary (`c4`) maps user-facing field names to tag properties.
- **Menu grouping**: Presets with same `Menu` label appear under a submenu.

## Limitations / Risks
- **Parser fragility**: Relies on specific serialized format; little error reporting.
- **VBScript execution**: Powerful but brittle; minimal sandboxing.
- **Regex engine**: Depends on VBScript.RegExp; no multiline/lookbehind nuances.
- **Undo/preview**: Lacks full preview/undo; changes commit immediately.
- **Encoding/path edge cases**: Path updates can mis-handle special chars or forbidden names on Windows.

## Opportunities for Improvement
- Add schema validation for presets and richer error messages.
- Provide dry-run/preview with diff and undo.
- Centralize field mapping with capabilities (read/write, multi-line support).
- Safer expression evaluation (limit VBScript surface).
- Improve logging and progress reporting for large batches.
- Unit-testable extraction of parser and executor logic; decouple UI from core.