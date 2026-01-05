/**
 * 
 * Script to clear all comments from used and abused tags
 */

(function() {
	"use strict";

	const actionTitle = 'Clear Everything';
	const confirmMessage = 'Are you sure you want to clear EVERYTHING on %s tracks?';
	const completeMessage = 'Everything is cleared!';

	function TrackWorker(tracks) {
		var blnModified = false;		

		// Process all selected tracks
		tracks.forEach(track => {
			// Basic
			if (track.author) { track.author = ""; blnModified = true; };
			if (track.conductor) { track.conductor = ""; blnModified = true; };
			if (track.rating !== -1) { track.rating = -1; blnModified = true; };
			if (track.commentShort.length > 0) { track.setCommentAsync(""); blnModified = true; };

			// Details
			if (track.groupDesc !== "") { track.groupDesc = ""; blnModified = true; };
			if (track.initialKey !== "") { track.initialKey = ""; blnModified = true; };
			if (track.bpm !== -1) { track.bpm = -1; blnModified = true; };
			if (track.involvedPeople !== "") { track.involvedPeople = ""; blnModified = true; };
			if (track.origArtist !== "") { track.origArtist = ""; blnModified = true; };
			if (track.origTitle !== "") { track.origTitle = ""; blnModified = true; };
			if (track.origLyricist !== "") { track.origLyricist = ""; blnModified = true; };
			if (track.isrc !== "") { track.isrc = ""; blnModified = true; };
			if (track.publisher !== "") { track.publisher = ""; blnModified = true; };
			if (track.encoder !== "") { track.encoder = ""; blnModified = true; };
			if (track.copyright !== "") { track.copyright = ""; blnModified = true; };

			// Classification
			if (track.tempo !== "") { track.tempo = ""; blnModified = true; };
			if (track.mood !== "") { track.mood = ""; blnModified = true; };
			if (track.occasion !== "") { track.occasion = ""; blnModified = true; };
			if (track.quality !== "") { track.quality = ""; blnModified = true; };

			//Custom
			if (track.custom1 !== "") { track.custom1 = ""; blnModified = true; };
			if (track.custom2 !== "") { track.custom2 = ""; blnModified = true; };
			if (track.custom3 !== "") { track.custom3 = ""; blnModified = true; };
			if (track.custom4 !== "") { track.custom4 = ""; blnModified = true; };
			if (track.custom5 !== "") { track.custom5 = ""; blnModified = true; };
			if (track.custom6 !== "") { track.custom6 = ""; blnModified = true; };
			if (track.custom7 !== "") { track.custom7 = ""; blnModified = true; };
			if (track.custom8 !== "") { track.custom8 = ""; blnModified = true; };
			if (track.custom9 !== "") { track.custom9 = ""; blnModified = true; };
			if (track.custom10 !== "") { track.custom10 = ""; blnModified = true; };
		});

		// Write back to DB and update tags
		if (blnModified == true) {
			tracks.commitAsync();
		};

		messageDlg(_(completeMessage), 'Information', ['btnOK'], {
			defaultButton: 'btnOK'
		}, undefined);
		
	}

	async function ClearEverything() {
		// Define variables
		var tracks = uitools.getSelectedTracklist();
		await tracks.whenLoaded()

		if (tracks.count === 0) {
			messageDlg(_("Select tracks to be updated"), 'Error', ['btnOK'], {
				defaultButton: 'btnOK'
			}, function (result) {
				modalResult = 0;
			});
			return;
		};

		messageDlg(sprintf(_(confirmMessage), tracks.count), 'Warning', ['btnYes', 'btnNo'], {
			defaultButton: 'btnNo'
		}, function (result) {
			if (result.btnID === 'btnYes') {
				TrackWorker(tracks);
			};
		});
	}

	actions.ClearEverything = {
		title: _(actionTitle),
		hotkeyAble: true,
		icon: 'ClearEverything',
		disabled: uitools.notMediaListSelected,
		visible: window.uitools.getCanEdit,
		execute: function() { ClearEverything(); }
	}

	window._menuItems.editTags.action.submenu.push({
			action: actions.ClearEverything,
			order: 20,
			grouporder: 100
	});
})();