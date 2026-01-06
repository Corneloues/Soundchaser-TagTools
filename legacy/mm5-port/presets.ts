export type FieldName =
  | 'Title' | 'Artist' | 'Album' | 'AlbumArtist'
  | 'Genre' | 'Year' | 'TrackNumber' | 'DiscNumber'
  | 'Comment' | 'Lyrics'
  | 'Path' | 'Filename' | 'Folder'
  | 'Custom1' | 'Custom2' | 'Custom3' | 'Custom4' | 'Custom5';

export interface Preset {
  id: string;                // stable identifier (uuid or slug)
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
  replaceExpr?: boolean;     // indicates expression evaluation (JS-based)
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

export interface PlaceholderContext {
  intoField: FieldName;
  fromField: FieldName;
  numberParams: string[];
  stringParams: string[];
}

export interface ReplacementContext {
  track: any;                // MM5 track object
  preset: Preset;
  srcValue: string;
  dstField: FieldName;
}

export type Getter = (track: any) => string;
export type Setter = (track: any, value: string) => Promise<void>;

export interface FieldMapEntry {
  get: Getter;
  set: Setter;
}

export type FieldMap = Record<FieldName, FieldMapEntry>;