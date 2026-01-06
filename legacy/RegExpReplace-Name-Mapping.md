# RegExpReplace-readable.vbs → JS Port Name Mapping

| Current name | Suggested JS name | Purpose |
| --- | --- | --- |
| OnStartUp | registerAddon | Initialize add-on, menus, options |
| OptionsDialog / iz / b3 | showOptionsDialog | Render/save options |
| q4 | buildBaseMenus | Add Manage/Options/last-used menu items |
| nx | showManagePresetsDialog | Manage presets UI |
| b8 | showFindReplaceDialog | Main find/replace UI |
| mw | syncMenuStates | Sync checked/enabled states |
| ln | setUiBusy | Enable/disable UI during work |
| ae / cq / q8 | writePreset / deletePreset / readPreset | INI preset CRUD |
| l | parsePresetField | Parse field from preset string |
| pj | unquoteValue | Strip surrounding quotes |
| dg | quoteValue | Escape/quote for serialization |
| pc | serializePreset | Write preset to storage |
| ra | loadPresetState | Load preset into memory/UI |
| ih | expandFieldPlaceholders | Expand `<Into/From Field>` |
| e7 | normalizePresetOrder | Sort/reindex presets |
| ha | importPresets | Import/merge presets (INI) |
| ql | rewritePresetSection | Rewrite INI after deletes |
| pi | deletePreset | Remove preset and menus |
| mr | swapPresets | Reorder presets |
| kz | updatePresetRow | Edit preset in manage table |
| pw / py / de / j7 / p9 | refreshPresetMenus | Keep menus/toolbar in sync |
| po | countGroupPresets | Count presets in a menu group |
| ho | buildToolbarButtons | Build toolbar items for presets |
| et | resolvePresetIcon | Resolve icon/name and register |
| kg / pl | updateLastUsed | Track last-executed presets |
| dv / nw / eq / p6 / gf / fg / h4 / ko / d9 / cz / ar | handleFieldChange | Field-change handlers in dialogs |
| p7 | savePresetFromDialog | Save/create/update preset |
| mh | deleteSelectedPreset | Delete selected preset |
| ll | bulkDeletePresets | Multi-delete in manage dialog |
| bd / lh / ic / pg | togglePresetSource | Switch/load external INI |
| fv / a3 / fl | renderPresetsTable | Render/manage presets table |
| k7 / ig / dy / il / ge / mm / ca / h5 / qs / k5 | handleRowMove | Row selection/drag/hold move |
| mb | handleTableClick | Click handling in manage list |
| bf | refreshTable | Resort/refresh timer |
| kx | executePresetByName | Run preset (optionally show adjust dialog) |
| hg | applyCurrentPreset | Apply find/replace to tracks |
| oh | applyPresetToFields | Orchestrate field replacements |
| jy | applyReplacement | Apply to field/path; handle file ops |
| r2 | computeReplacement | Regex/literal/expression replacement |
| hv | highlightMatches | Highlight matches/replacements |
| bp | hasMatch | Test pattern presence |
| cm / mv | getFieldValue | Resolve current song field |
| d1 / ht | setFieldValue | Composite field setters |
| ep | firstMatch | First regex match for highlight |
| MapChr / MapChrCase / MapArray / MapArrayCase / MapArrayEx | mapChars / mapArray | Mapping utilities |
| RegExp / RegExpEx / RegSub | regexMatch / regexAll / regexSub | Regex helpers |
| k6 | expandPlaceholders | Expand numbered/string/field placeholders |
| mf | expandNamePlaceholders | Placeholder handling in names |
| SetVar / GetVar / LetVar | setTemp / getTemp / letTemp | Temp var storage |
| DateISO / DateTimeISO / Choose / IIf / IfNull / Min / Max / SQLQuery | dateIso / dateTimeIso / choose / iif / ifNull / min / max / sqlQuery | Expression helpers |
| q0 | initTracklist | Build tracklist (selected/visible/NP) |
| io / iv / e2 / gg / nl / qw / px / ah | navigateMatches | Find/next/prev/replace commands |
| am | renderTrackPreviewRow | Build preview row |
| cy | updatePreviewRow | Update preview row after replace |
| bm | filterTracklist | Keep/remove/select matched/unmatched |
| eu | isNowPlayingView | Determine current view |
| aw / es / mq / g8 / jm | syncWithSelection | Sync with MM selection changes |
| ai | togglePreviewCheckbox | Checkbox handling |
| f9 / lb / it / lj / qb / c3 / o5 | updateControlsState | Enable/disable controls |
| hs timers (ge/mm/qs/h5/k5/ca/d2) | handleRowMoveTimer | Smooth move timers |
| kc / bf | initialRefreshTimer | Refresh timer manage dialog |
| l0 / bx | safeRefreshPreview | Guarded refresh |
| pf / ls | htmlEscape / renderPresetRow | Escape and render rows |
| a6 | resolveSkinCss | Locate skin CSS |
| be | adjustTimezone | TZ adjust datetime |
| lr | updateHistory | Maintain find/replace history |
| hm / no | loadSettings / saveSettings | Read/write INI settings |
| le / em | onOptionsChanged | Respond to options changes |
| gw / ml | fillDefaultPatterns | Default regex patterns |
| dr / hp / ci | markDirty / clearDirty / isDirty | Dirty-state tracking |
| fp | promptSaveIfDirty | Prompt to save edits |
| n8 | closeDialog | Dialog cleanup |
| nd / jl / hj / an | handleMenuCommand | Menu/toolbar entry points |
| j5 | showHelp | Show regex/VBScript quick ref |
| n0 | openHomepage | Open project page |
| c4 | fieldMap | Friendly → field expressions |
| ht | setterMap | Field setter overrides |
| d7 | customFieldLabels | Custom label cache |
| c8 | sqlCache | SQL query cache |
| ef | regexCache | Cached regex objects |