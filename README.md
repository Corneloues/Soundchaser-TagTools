# New Action Instructions

## File based activities

1. Copy the **action_ActionTemplate.js**
2. Rename **action_ActionTemplate - Copy.js** to **action_<ActionName>.js**
3. Create a jpg from a material icon 64x64
4. Create a transparent svg from the jpg using [link](https://www.photopea.com/)
5. Place a **<ActionName>.svg** and **<ActionName>.jpg** in the skin\icon folder

## Action naming and registration
1. Open the template **action_<ActionName>.js**
2. Search for "ActionTemplate" and replace with <ActionName>
3. Add `requirejs('action_<actionName>')` to **init.js**
4. Copy the commented `// (function () { ... })();` at the end of **local.js**
5. Search for "ActionTemplate" and replace with <ActionName>
6. Replace "Action Tooltop" with something more meaningful

## Update constants
1. Update the `actionTitle`
2. Update the `confirmMessage` - %s will inject the total number of highlighted tracks to the message
3. Update the `completeMessage`

## Code the worker
1. The template will always expect one or more files to have been selected in the MediaMonkey browser
2. the `TrackWorker()` function receives a `list` of `tracks`.
3. A single `track` is processed in the `tracks.forEach(track => { /* here */ });`
4. Always code for a single track and let the scaffolding do the hard work