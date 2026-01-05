' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
'
'                "Soundchaser.vbs", Dec-24-2018, v2.00
'         VBScript for MediaMonkey 2.3.1 (or above), written by Soundchaser
'
' Purpose:
' - Various scripts for speeding up the processing of media files.
'
' Notes:
' - Add some as we go
'
' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

'
' Pad track numbers with zeros dependng on highest track number
'
Sub PadTrackNo
	' Define variables
	Dim current, updated, song, i, size

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If
	
	size = HighestLength(GetHighestTrackNumber(current))

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		If PadItem(song, size) Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Clear comments from the tag
'
Sub ClearComments
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)

		If Len(song.Comment) > 0 Then
			song.Comment = Empty
			song.Author = Empty
			Song.Grouping = Empty
			Song.Lyricist = Empty
			Song.Lyrics = Empty
			Song,Publisher = Empty
			Song.Producer = Empty
			song.Custom1 = Empty
			song.Custom2 = Empty
			song.Custom3 = Empty
			song.Custom4 = Empty
			song.Custom5 = Empty
			
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Split the Title and Artist from Title
'
Sub SplitTitleArtist
	' Define variables
	Dim current, updated, song, i, sTitle, sArtist, iPos, iSplitPos, hasChanged

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		hasChanged = false

		iPos = InStr(UCase(song.Title), " - ")

		If iPos > 0 Then
			iSplitPos = iPos + 3

			sArtist = Mid(song.Title, iSplitPos)
			sTitle = Trim(Left(song.Title, iPos))
			
			song.Title = sTitle
			song.ArtistName = sArtist
			
			hasChanged = true
		End If

		If hasChanged Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Trim all leading and trailing spaces from the title, artist and album
'
Sub TrimTitleArtist
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		song.Title = LTrim(RTrim(song.Title))
		song.ArtistName = LTrim(RTrim(song.ArtistName))
		song.AlbumName = LTrim(RTrim(song.AlbumName))
		song.AlbumArtistName = LTrim(RTrim(song.AlbumArtistName))

		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
' Replaces square brackets '[]' with normal brackets '()'
'
Sub ReplaceSquareBrackets
	' Define variables
	Dim current, updated, song, i, hasChanged

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		hasChanged = false
		
		If InStr(song.Title, "[") Then
			song.Title = Replace(song.Title, "[", "(")
			song.Title = Replace(song.Title, "]", ")")
			
			hasChanged = true
		End If

		If InStr(song.ArtistName, "[") Then
			song.ArtistName = Replace(song.ArtistName, "[", "(")
			song.ArtistName = Replace(song.ArtistName, "]", ")")
			
			hasChanged = true
		End If

		If hasChanged Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Runs Set Featuring on the currently selected list of tracks
'
Sub Featuring
	' Define variables
	Dim current, updated, song, i

	MsgBox("Here")

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)

		If SetFeaturing(song) Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Standardises featuring artist to the title field
'
Function SetFeaturing(song)
	' Define variables
	Dim strFeaturing, intPos
	Dim strArtistName, strTitle

    strArtistName = song.ArtistName
	strTitle = song.Title
	
	MsgBox(strArtistName + " - " + strTitle)

	SetFeaturing = false

    ' Check Title Field First
    If FeaturePos(strTitle) > 0 Then
		strTitle = CompleteFeaturing(strTitle)
		SetFeaturing = true
		
    ' Check ArtistName Field
    ElseIf FeaturePos(strArtistName) > 0 Then
		strArtistName = CompleteFeaturing(strArtistName)
		strFeaturing = Mid(strArtistName, InStr(strArtistName, "(Featuring"))

		intPos = InStr(strTitle, "(")

		If intPos = 0 Then
			strTitle = strTitle + " " + strFeaturing
		Else
			strTitle = Left(strTitle, intPos - 1) + strFeaturing + " " + Mid(strTitle, intPos)
		End If

		strArtistName = Trim(Replace(strArtistName, strFeaturing, ""))
		
		SetFeaturing = true
    End If
	
	If SetFeaturing Then
		song.ArtistName = strArtistName
		song.Title = strTitle
	End If
End Function

Function FeaturePos(strTitleArtist)
	Dim ftDict

	Set ftDict	= FeatureDictionary()
	
	For Each strKey In ftDict
		FeaturePos = InStr(LCase(strTitleArtist), strKey)
		
		If FeaturePos > 0 Then
			Exit For
		End If
	Next

	If FeaturePos > 0 Then
		If InStr(FeaturePos - 1, LCase(strTitleArtist), "(") Then
			Featurepos = FeaturePos - 1
		End If
	End If
End Function

Function FeatureDictionary()
	Dim dict
	
	Set dict = CreateObject("Scripting.Dictionary")
	dict.Add " featuring", false
	dict.Add " feat.", false
	dict.Add " feat ", false
	dict.Add " ft.", false
	dict.Add " fe.", false
	dict.Add " ft ", false
	dict.Add " f. ", false
	dict.Add " f.;", false
	dict.Add " f./", false
	dict.Add " ft,", false
	
	Set FeatureDictionary = dict
End Function

Function CompleteFeaturing(strTitleArtist)
	Dim intStart, intEnd, strFeat, strStart, strMid, strEnd

	intStart = FeaturePos(strTitleArtist)
	intEnd = InStr(intStart + 1, strTitleArtist, " ")
	strFeat = Mid(strTitleArtist, intStart, intEnd - intStart + 1)

	MsgBox(intStart)
	MsgBox(intEnd)
	MsgBox(":" + strFeat + ":")

	strStart = Left(strTitleArtist, intStart - 1) + " (Featuring "
	strEnd = Mid(strTitleArtist, intEnd)' + ")"

	If InStr(strEnd, "(") Then
		strMid = Trim(Left(strEnd, InStr(strEnd, "(") - 1)) + ") "
		strEnd = Mid(strEnd, InStr(strEnd, "("))
		strEnd = strMid + strEnd
	Else
		strEnd = strEnd + ")"
	End If

	CompleteFeaturing = strStart + strEnd
	CompleteFeaturing = Replace(CompleteFeaturing, "  ", " ")
	CompleteFeaturing = Replace(CompleteFeaturing, "))", ")")

	'  CompleteFeaturing = Left(strTitleArtist, intStart - 1) + " (Featuring"
	'  CompleteFeaturing = CompleteFeaturing + Mid(strTitleArtist, intEnd) + ")"
	'  CompleteFeaturing = Replace(CompleteFeaturing, "))", ")")

	'  MsgBox(CompleteFeaturing)
	'  CompleteFeaturing = strTitleArtist
End Function

'
' Runs SetVersus on the currently selected list of tracks
'
Sub Versus
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		If SetVersus(song) Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Locates different declarations of 'VS' and converts to 'Vs.'
'
Function SetVersus(song)
	SetVersus = false
	
	If InStr(LCase(song.ArtistName), " vs ") > 0 Or InStr(LCase(song.ArtistName), " vs. ") > 0 Then
		song.ArtistName = ReplaceVS(song.ArtistName)
		SetVersus = true
	End If

	If InStr(LCase(song.Title), " vs ") > 0 Or InStr(LCase(song.Title), " vs. ") > 0 Then
		song.Title = ReplaceVS(song.Title)
		SetVersus = true
	End If

	If InStr(LCase(song.AlbumArtistName), " vs ") > 0 Or InStr(LCase(song.AlbumArtistName), " vs. ") > 0 Then
		song.AlbumArtistName = ReplaceVS(song.AlbumArtistName)
		SetVersus = true
	End If
End Function

Function ReplaceVS(strTag)
	strTag = Replace(strTag, " vs ", " Vs. ")
	strTag = Replace(strTag, " VS ", " Vs. ")
	strTag = Replace(strTag, " Vs ", " Vs. ")
	strTag = Replace(strTag, " vS ", " Vs. ")

	strTag = Replace(strTag, " vs. ", " Vs. ")
	strTag = Replace(strTag, " VS. ", " Vs. ")
	strTag = Replace(strTag, " vS. ", " Vs. ")
	
	ReplaceVS = strTag
End Function

'
' Runs SetDJ on the currently selected list of tracks
'
Sub DJ
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)

		If SetDJ(song) Then
			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub

'
' Locates different declarations of 'DJ' and converts to upper case
'
Function SetDJ(song)
	If InStr(LCase(song.ArtistName), "dj ") > 0 Then
		song.ArtistName = ReplaceDJ(song.ArtistName)
		SetDJ = true
	End If

	If InStr(LCase(song.Title), "dj ") > 0 Then
		song.Title = ReplaceDJ(song.Title)
		SetDJ = true
	End If

	If InStr(LCase(song.AlbumArtistName), "dj ") > 0 Then
		song.AlbumArtistName = ReplaceDJ(song.AlbumArtistName)
		SetDJ = true
	End If
End Function 

Function ReplaceDJ(strTag)
	strTag = Replace(strTag, "dj ", "DJ ")
	strTag = Replace(strTag, "Dj ", "DJ ")
	strTag = Replace(strTag, "dJ ", "DJ ")
	
	ReplaceDJ = strTag
End Function

'
' Set Track # To 0
'
Sub ClearTrackNumber
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)

		song.TrackOrderStr = "00"
		
		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
' Set Track and Disk # To 0
'
Sub ClearTrackDiscNumber
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		song.TrackOrderStr = "00"
		song.DiscNumberStr = "0"
		
		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
' Remove Track Artwork
'
Sub RemoveArtwork
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		RemoveArt song
		
		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
' Set Cover Artwork
'
Sub FolderCover
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		RemoveArt song
		SetCover song
		
		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
' Capitalise All Words and Fix Apostrophe's and Other Oddities
'
Sub CapitaliseAndFix
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		song.Title = CapAndFix(song.Title)
		song.ArtistName = CapAndFix(song.ArtistName)
		song.AlbumName = CapAndFix(song.AlbumName)
		song.AlbumArtistName = CapAndFix(song.AlbumArtistName)

		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
' DJ Pool Scripts
' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

'
Sub DJcity
	' Define variables
	Dim current, updated, song, i, title, pos, divider, albumname

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)

		title = song.Title

		divider = InStr(title, " - ")
		
		If divider > 0 Then
			title = Replace(title, " - ", " (") + ")"
		End If

		title = Replace(title, "(Intro (", "(Intro ")
		title = Replace(title, "))", ")")
		title = Replace(title, "((", "(")

		pos = InStr(title, "(")
		
		If InStr(title, "(") > 0 Then
			albumname = Trim(Left(title, pos - 1))
		Else
			albumname = Trim(title)
		End If

		song.Title = title
		song.AlbumName = albumname
		song.AlbumArtistName = "DJcity"
		song.DiscNumberStr = "1"
		song.TrackOrderStr = "01"
		song.Comment = Empty
		song.Year = Year(Date)
		
		SetFeaturing(song)
		SetVersus(song)
		PadItem song, 2
		RemoveArt(song)
		SetCover(song)

		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

'
Sub PromoOnlyUK
	' Define variables
	Dim current, updated, song, i

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		song.TrackOrderStr = Right("00" + song.TrackOrderStr, 2)
		song.DiscNumberStr = "1"
		song.AlbumArtistName = "Promo Only"
		song.ArtistName = Trim(Replace(Replace(song.ArtistName, "f./", "f./ "), "f./  ", "f./ "))
		song.Year = Year(Date)	

		SetFeaturing(song)
		SetVersus(song)
		PadItem song, 2

		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
' Supporting functions
' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

'
' Pad A Track Number
'
Function PadItem(song, size)
	PadItem = false
    strTrackOrder = Right("0000000" + song.TrackOrderStr, size)
	
	If strTrackOrder <> song.TrackOrderStr Then
		PadItem = true
		song.TrackOrderStr = strTrackOrder
	End If
End Function

'
' remove Artwork
'
Function RemoveArt(song)
	Dim AlbumArt
	
	Set AlbumArt = song.AlbumArt
	
	While AlbumArt.Count > 0
		AlbumArt.Delete(0)
	WEnd
	
	AlbumArt.UpdateDB
End Function

Function SetCover(song)
	Dim AlbumArt, Cover
	
	Set AlbumArt = song.AlbumArt
	
	Set Cover = AlbumArt.AddNew
	Cover.RelativePicturePath = "Folder.jpg"
	Cover.ItemType = 3
	Cover.ItemStorage = 0
	
	AlbumArt.UpdateDB
End Function

'
' Get Highest Track Number
'
Function GetHighestTrackNumber(list)
	highest = 0
	
	For i = 0 To list.count - 1
		Set itm = list.Item(i)

		If itm.TrackOrder > highest Then
			highest = itm.TrackOrder
		End If
	Next
	
	GetHighestTrackNumber = highest
End Function

'
' Get the length of the highest track number (minimum size is 2)
'
Function HighestLength(highest)	
	size = Len(CStr(highest))
	
	If size = 1 Then
		size = 2
	End If
	
	HighestLength = size
End Function

' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
' Older scripts not used often
' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Sub BPMInTitleToBPM
	' Define variables
	Dim current, updated, song, i, sBPM, iPos, iStart, iEnd

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		iPos = InStr(UCase(song.Title), "BPM")

		If InStr(UCase(song.Title), "BPM)") > 0 Then
			iStart = InStrRev(song.Title, "(", iPos) + 1
			iEnd = InStr(iStart, song.Title, " ")

			sBPM = Mid(song.Title, iStart, iEnd-iStart)
			iStart = InStr(sBPM, "-")

			If iStart > 0 Then
				sBPM = Left(sBPM, iStart -1)
			End If

			song.BPM = CInt(sBPM)
			updated.Add(song)
			
		ElseIf InStr(UCase(song.Title), "(BPM") > 0 Then
			iStart = InStr(iPos, song.Title, " ") + 1
			iEnd = InStr(iStart, song.Title, ")")

			sBPM = Mid(song.Title, iStart, iEnd-iStart)
			iStart = InStr(sBPM, "-")

			If iStart > 0 Then
				sBPM = Left(sBPM, iStart -1)
			End If

			song.BPM = CInt(sBPM)
			updated.Add(song)

		End If
	Next

	updated.UpdateAll
End Sub

Sub RemoveBPMFromTitle
	' Define variables
	Dim current, updated, song, i, iPos, iStart, iEnd

	' Get list of selected tracks from MediaMonkey
	Set current = SDB.CurrentSongList
	Set updated = SDB.NewSongList
	
	' Exit if no tracks selected
	If current.Count = 0 Then
		Exit Sub
	End If

	For i = 0 To current.count - 1
		Set song = current.Item(i)
		
		iPos = InStr(UCase(song.Title), "BPM")

		If iPos > 0 Then
			iStart = InStrRev(song.Title, "(", iPos)
			iEnd = InStr(iStart, UCase(song.Title), ")") + 1

			sBPM = Mid(song.Title, iStart, iEnd-iStart)
			sTitle = Trim(Replace(song.Title, sBPM, ""))

			song.Title = sTitle

			updated.Add(song)
		End If
	Next

	updated.UpdateAll
End Sub
