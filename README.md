# New Action Instructions

## File based activities

1. Go to the **src/actions** folder
2. Open the **template.js**
3. Save the new template as **\<ActionName\>.js**
4. Find a suitable [material icon](https://mui.com/material-ui/material-icons/)
5. Download the icon from the material icon [GitHub](https://github.com/mui/material-ui/tree/master/packages/mui-icons-material/material-icons). You will need to search for the icon due to GitHub limits
6. Load the svg into [Photopea](https://www.photopea.com/)
7. Resize to 64x64
8. Save as **svg** and **jpg**
9. Place a **\<ActionName\>.svg** and **\<ActionName\>.jpg** in the skin\icon folder

## Action naming and registration
1. Open the template **\<ActionName\>.js**
2. Search for "ActionTemplate" and replace with \<ActionName\>
3. Add `requirejs('actions/<ActionName>')` to **init.js**
4. Copy the commented `// (function () { ... })();` at the end of **local.js**
5. Search for "ActionTemplate" and replace with \<ActionName\>
6. Replace "Action Tooltop" with something more meaningful

## Update constants
1. Update the `actionTitle`
2. Update the `confirmMessage` - **%s** will inject the total number of highlighted tracks to the message
3. Update the `completeMessage`

## Menu item ordering
1. `grouporder: 100` - All custom actions use the same group order to keep menu items together
2. `order:` - Set to 10 higher than the highest order value in existing action files
   - ClearComments: order 10
   - ClearEverything: order 20
   - PadTrackNo: order 30
   - New actions should follow this pattern

## Code the worker
1. The template will always expect one or more files to have been selected in the MediaMonkey browser
2. the `TrackWorker()` function receives a `list` of `tracks`.
3. A single `track` is processed in the `tracks.forEach(track => { /* here */ });`
4. Always code for a single track and let the scaffolding do the hard work



