/**
 * Script: PadTrackNo()
 * 
 * Pad track numbers with zeros depending on the highest track number in the selection
 */

(function() {
	"use strict";

	const actionTitle = 'Pad Track Numbers';
	const confirmMessage = 'Pad track numbers for %s tracks?';
	const completeMessage = 'Track numbers have been padded!';

	function TrackWorker(tracks) {
		var blnModified = false;

		// Calculate the padding size based on highest track number
		let highestTrack = 0;
		tracks.forEach(track => {
			if (track.trackNumber > highestTrack) {
				highestTrack = track.trackNumber;
			}
		});

		let size = highestTrack.toString().length;
		if (size === 1) {
			size = 2;
		}

		// Process all selected tracks
		tracks.forEach(track => {
			const paddedTrack = ("0000000" + track.trackNumber).slice(-size);
			
			if (paddedTrack !== track.trackNumber) {
				blnModified = true;
				track.trackNumber = paddedTrack;
			}
		});

		// Write back to DB and update tags
		if (blnModified == true) {
			tracks.commitAsync();
		};

		messageDlg(_(completeMessage), 'Information', ['btnOK'], {
			defaultButton: 'btnOK'
		}, undefined);
		
	}

	async function PadTrackNo() {
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

	actions.PadTrackNo = {
		title: _(actionTitle),
		hotkeyAble: true,
		icon: 'PadTrackNo',
		disabled: uitools.notMediaListSelected,
		visible: window.uitools.getCanEdit,
		execute: function() { PadTrackNo(); }
	}

	window._menuItems.editTags.action.submenu.push({
			action: actions.PadTrackNo,
			order: 30,
			grouporder: 100
	});
})();
