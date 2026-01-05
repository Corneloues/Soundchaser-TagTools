' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
'
'                "CapitaliseAndFix.vbs", Oct-13-2024, v1.00
'         VBScript for MediaMonkey 2.3.1 (or above), written by Soundchaser
'
' Purpose:
' - Capitalise All Words and Fix Apostrophe's and Other Oddities.
'
' Notes:
' - Add some as we go
'
' ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

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

        'MsgBox(song.Title)
		
		song.Title = CapAndFix(song.Title)
		song.ArtistName = CapAndFix(song.ArtistName)
		song.AlbumName = CapAndFix(song.AlbumName)
		song.AlbumArtistName = CapAndFix(song.AlbumArtistName)

        'MsgBox(song.Title)

		updated.Add(song)
	Next

	updated.UpdateAll
End Sub

Function CapAndFix(strWords)
	Dim strApostWordKeys, strApostWordItems, strOtherKeys, strOtherItems
	Dim dictReplace

	strApostWordKeys = "aint|cant|couldnt|didnt|dont|ill|im|lets|ones|shouldnt|wont|wouldnt"
	strApostWordItems = "ain't|can't|couldn't|didn't|don't|i'll|i'm|let's|one's|shouldn't|won't|wouldn't"

	strOtherKeys =  "(po|dj|flo rida|mk|vip|anne-marie|ne yo|ksi|aj|mc|zz|b2k|inxs|abc|pm|kc|jx|dmc|sl2|beyonce|psy|kesha|lmfao|xcx|ll cool j"
	strOtherItems = "(PO|DJ|Flo-Rida|MK|VIP|Anne-Marie|Ne-Yo|KSI|AJ|MC|ZZ|B2K|INXS|ABC|PM|KC|JX|DMC|SL2|Beyoncé|PSY|Ke$ha|LMFAO|XCX|LL Cool J"

	arrWords = Split(strWords, " ")
	CapAndFix = ""

    Set dictReplace = ArraytoDict(strApostWordKeys & "|" & strOtherKeys, strApostWordItems & "|" & strOtherItems, "|")

	For Each word in arrWords
		' Sort out bad words
		word = FixWord(word, dictReplace)

        'MsgBox(word & " - " & CStr(word = UCase(word)))

		' Now capitalise
		If word = UCase(word) Then
			CapAndFix = CapAndFix & word & " "
		ElseIf Left(word, 1) = "(" Then
            CapAndFix = CapAndFix & UCase(Left(word, 2)) & Mid(word, 3) & " "
        Else
			CapAndFix = CapAndFix & UCase(Left(word, 1)) & Mid(word, 2) & " "
		End If
	Next

    'MsgBox(CapAndFix)
    
    'CapAndFix = strWords
    CapAndFix = Trim(CapAndFix)
End Function


'
' Handle each word list
'
Function FixWord(strWord, dictReplace)
	FixWord = strWord
	LowerWord = LCase(strWord)

	If dictReplace.Exists(LowerWord) Then
        FixWord = dictReplace.Item(LowerWord)
	Elseif dictReplace.Exists(Replace(LowerWord, "(", "")) Then
        FixWord = "(" & dictReplace.Item(Replace(LowerWord, "(", ""))
	Elseif dictReplace.Exists(Replace(LowerWord, ")", "")) Then
        FixWord = dictReplace.Item(Replace(LowerWord, ")", "")) & ")"
    End If
End Function

'
' Convert the "fix" words to a dictionary
' Key = bad
' Item - Good
'
Function ArraytoDict(strkeys, strValues, strSep)
	Dim arrKeys, arrValues
	Dim i

	arrKeys = Split(strKeys, strSep)
	arrValues = SPlit(strValues, strSep)

	Set ArrayToDict = CreateObject("Scripting.Dictionary")
	ArrayToDict.CompareMode = vbTextCompare

	For i = 0 To UBound(arrKeys)
		ArrayToDict.Add arrKeys(i), arrValues(i)
	Next
End Function