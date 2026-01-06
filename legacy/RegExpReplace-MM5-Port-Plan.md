# RegExpReplace → MediaMonkey 5 Port (JS) — Plan & Data Structures

## Goals
- Port the legacy VBScript/INI-based add-on to MM5 using JS/HTML/CSS.
- Preserve preset-driven find/replace; modernize UI and storage; improve safety.

## Migration Plan (Concise)
1) **Scaffold Add-on**
   - Create `addon.xml`, `src/` JS entry (`main.js`) plus HTML dialogs.
   - Bundle with ES modules or TypeScript → single JS output.

2) **Presets Model & Storage**
   - Define a JSON schema for presets; add validation/defaults.
   - Import legacy INI once (parser/converter); store in add-on data folder or MM5 settings.

3) **Field Mapping**
   - Map friendly names → MM5 track properties (Title, Artist, Album, Path, Custom1-5, etc.).
   - Getter/setter helpers; commit via `track.commitAsync()`.

4) **Engine (Find/Replace)**
   - `applyPreset(tracks, preset)` handles: resolve source/target, regex/literal, whole-word/match-case, optional JS expression evaluator (safer than VBScript Eval), path safety.
   - Add dry-run/preview option and error logging.

5) **UI (MM5)**
   - HTML dialogs for: preset picker, manage presets, main find/replace.
   - Commands registered to main menu, toolbar, and context menus; last-used preset shortcuts.

6) **Persistence & Safety**
   - JSON settings/presets; optional backup/export.
   - Guard filesystem moves; consider simple undo (session cache of originals).

7) **Testing**
   - Unit-test parser/engine; manual UI tests; sample presets migrated from legacy.

## Data Structure Sketches (JS/TS)

```typescript
export type FieldName =
  | 'Title' | 'Artist' | 'Album' | 'AlbumArtist' | 'Genre' | 'Year'
  | 'TrackNumber' | 'DiscNumber' | 'Comment' | 'Lyrics'
  | 'Path' | 'Filename' | 'Folder'
  | 'Custom1' | 'Custom2' | 'Custom3' | 'Custom4' | 'Custom5';

export interface Preset {
  id: string;                // stable id
  name: string;
  description?: string;
  menuGroup?: string;        // optional submenu label
  shortcut?: string;
  icon?: string;
  toolbar?: boolean;

  findWhat: string;
  findInto: FieldName;
  findRegExp: boolean;
  wholeWord: boolean;
  matchCase: boolean;

  replaceWith: string;
  replaceFrom?: FieldName;   // defaults to findInto if omitted
  replaceRegExp: boolean;
  replaceExpr?: boolean;     // indicates expression evaluation
}

export interface PresetStore {
  version: number;
  presets: Preset[];
  lastUsedIds?: string[];
}

export interface ApplyOptions {
  dryRun?: boolean;
  previewLimit?: number;
  stopOnError?: boolean;
}
```

### Helpers (outline)
- `parseLegacyIni(iniText): Preset[]` — one-time importer.
- `serializeStore(store): string` — JSON persistence.
- `expandPlaceholders(text, ctx)` — handles `<NUMBER/STRING>`, `<Into/From Field>`.
- `getField(track, fieldName)`, `setField(track, fieldName, value)`.
- `computeReplacement(input, preset, ctx)` — regex/literal/expression pathway.
- `applyPreset(tracks, preset, opts)` — main engine with progress and optional dry-run.