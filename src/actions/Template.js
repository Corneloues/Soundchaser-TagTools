/**
 * Script: ActionTemplate()
 * 
 * Give a description of the purpose of this script
 */

(function() {
	"use strict";

	const actionTitle = 'Action Title';
	const confirmMessage = 'Adding %s will add the total number of selected tracks to the message?';
	const completeMessage = 'Everything is cleared!';

	function TrackWorker(tracks) {
		var blnModified = false;		

		// Process all selected tracks
		tracks.forEach(track => {
			// track.Title
		});

		// Write back to DB and update tags
		if (blnModified == true) {
			tracks.commitAsync();
		};

		messageDlg(_(completeMessage), 'Information', ['btnOK'], {
			defaultButton: 'btnOK'
		}, undefined);
		
	}

	async function ActionTemplate() {
		// Define variables
		var tracks = uitools.getSelectedTracklist();
		await tracks.whenLoaded()

		// No highlighted tracks
		if (tracks.count === 0) {
			messageDlg(_("Select tracks to be updated"), 'Error', ['btnOK'], {
				defaultButton: 'btnOK'
			}, function (result) {
				modalResult = 0;
			});
			return;
		};

		// Start the action
		messageDlg(sprintf(_(confirmMessage), tracks.count), 'Warning', ['btnYes', 'btnNo'], {
			defaultButton: 'btnNo'
		}, function (result) {
			if (result.btnID === 'btnYes') {
				TrackWorker(tracks);
			};
		});
	}

	actions.ActionTemplate = {
		title: _(actionTitle),
		hotkeyAble: true,
		icon: 'ActionTemplate',
		disabled: uitools.notMediaListSelected,
		visible: window.uitools.getCanEdit,
		execute: function() { ActionTemplate(); }
	}

	window._menuItems.editTags.action.submenu.push({
			action: actions.ActionTemplate,
			order: 0,
			grouporder: 100
	});
})();
