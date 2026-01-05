Dim i, a, sPath, sFolder, oFile

If Not SDB.Objects("tbrRegExpReplaceDialog") Is Nothing Then
    SDB.Objects("tbrRegExpReplaceDialog").Visible = False
    Set SDB.Objects("tbrRegExpReplaceDialog") = Nothing
End If
If Not SDB.Objects("tbrRegExpExecuted") Is Nothing Then
    SDB.Objects("tbrRegExpExecuted").Visible = False
    Set SDB.Objects("tbrRegExpExecuted") = Nothing
End If

i = 1
Do While Not SDB.Objects("tbbRegExpButton" & i) Is Nothing
    With SDB.Objects("tbbRegExpButton" & i)
        .Caption = ""
        .Hint = ""
        .IconIndex = -1
        .Visible = False
    End With
    i = i + 1
Loop
If Not SDB.Objects("mnuRegExpPresetToolbar") Is Nothing Then
    With SDB.Objects("mnuRegExpPresetToolbar")
        a = .Keys
        For i = UBound(a) To 0 Step -1
            If Not .Item(a(i)) Is Nothing Then
                With .Item(a(i))
                    .Caption = ""
                    .Hint = ""
                    .Shortcut = ""
                    .Visible = False
                End With
                Set .Item(a(i)) = Nothing
            End If
            .Remove a(i)
        Next
    End With
End If
If Not SDB.Objects("mnuRegExpToolbar") Is Nothing Then
    SDB.Objects("mnuRegExpToolbar").Visible = False
    Set SDB.Objects("mnuRegExpToolbar") = Nothing
End If
If Not SDB.Objects("mnuRegExpPresetMainMenu") Is Nothing Then
    With SDB.Objects("mnuRegExpPresetMainMenu")
        a = .Keys
        For i = UBound(a) To 0 Step -1
            If Not .Item(a(i)) Is Nothing Then
                With .Item(a(i))
                    .Caption = ""
                    .Hint = ""
                    .Shortcut = ""
                    .Visible = False
                End With
                Set .Item(a(i)) = Nothing
            End If
            .Remove a(i)
        Next
    End With
End If
If Not SDB.Objects("mnuRegExpMainMenu") Is Nothing Then
    SDB.Objects("mnuRegExpMainMenu").Visible = False
    Set SDB.Objects("mnuRegExpMainMenu") = Nothing
End If
If Not SDB.Objects("mnuRegExpPresetTracklist") Is Nothing Then
    With SDB.Objects("mnuRegExpPresetTracklist")
        a = .Keys
        For i = UBound(a) To 0 Step -1
            If Not .Item(a(i)) Is Nothing Then
                With .Item(a(i))
                    .Caption = ""
                    .Hint = ""
                    .Shortcut = ""
                    .Visible = False
                End With
                Set .Item(a(i)) = Nothing
            End If
            .Remove a(i)
        Next
    End With
End If
If Not SDB.Objects("mnuRegExpTracklist") Is Nothing Then
    SDB.Objects("mnuRegExpTracklist").Visible = False
    Set SDB.Objects("mnuRegExpTracklist") = Nothing
End If
If Not SDB.Objects("mnuRegExpPresetNowPlaying") Is Nothing Then
    With SDB.Objects("mnuRegExpPresetNowPlaying")
        a = .Keys
        For i = UBound(a) To 0 Step -1
            If Not .Item(a(i)) Is Nothing Then
                With .Item(a(i))
                    .Caption = ""
                    .Hint = ""
                    .Shortcut = ""
                    .Visible = False
                End With
                Set .Item(a(i)) = Nothing
            End If
            .Remove a(i)
        Next
    End With
End If
If Not SDB.Objects("mnuRegExpNowPlaying") Is Nothing Then
    SDB.Objects("mnuRegExpNowPlaying").Visible = False
    Set SDB.Objects("mnuRegExpNowPlaying") = Nothing
End If
If SDB.VersionHi >= 3 Then
    If Not SDB.Objects("mnuRegExpPresetTracklistNP") Is Nothing Then
        With SDB.Objects("mnuRegExpPresetTracklistNP")
            a = .Keys
            For i = UBound(a) To 0 Step -1
                If Not .Item(a(i)) Is Nothing Then
                    With .Item(a(i))
                        .Caption = ""
                        .Hint = ""
                        .Shortcut = ""
                        .Visible = False
                    End With
                    Set .Item(a(i)) = Nothing
                End If
                .Remove a(i)
            Next
        End With
    End If
    If Not SDB.Objects("mnuRegExpTracklistNP") Is Nothing Then
        SDB.Objects("mnuRegExpTracklistNP").Visible = False
        Set SDB.Objects("mnuRegExpTracklistNP") = Nothing
    End If
End If

If SDB.VersionHi >= 4 Then
    If SDB.VersionBuild >= 1378 Then
        If Not SDB.Objects("RegExpToolbar") Is Nothing Then
            SDB.Objects("RegExpToolbar").Visible = False
            Set SDB.Objects("RegExpToolbar") = Nothing
        End If
    End If
End If

If Not SDB.Objects("RegExpObject") Is Nothing Then
    On Error Resume Next
    SDB.UI.DeleteOptionSheet _
            SDB.Objects("RegExpObject").Item("OptionSheet")
    If Err = 0 Then Set SDB.Objects("RegExpObject") = Nothing
    On Error GoTo 0
End If

If SDB.Tools.FileSystem.FileExists(SDB.ApplicationPath _
        & "Scripts\Auto\RegExpReplace.vbs") Then

    sFolder = SDB.ApplicationPath & "Scripts\"
Else
    sFolder = Left(SDB.Database.Path, InStrRev(SDB.Database.Path, "\")) _
            & "Scripts\"
End If
sPath = sFolder & "Auto\SkinStyle"
Set oFile = CreateObject("Scripting.FileSystemObject")
If Not oFile.FileExists(sFolder & "Auto\MagicNodes.vbs") _
        And Not oFile.FileExists(sFolder & "Auto\EventLogger.vbs") _
        And Not oFile.FileExists(sFolder & "Auto\StatsFiltered.vbs") _
        And Not oFile.FileExists(sFolder & "TreeReport.vbs") _
        And oFile.FolderExists(sPath) Then

    On Error Resume Next
    oFile.DeleteFolder sPath
    On Error GoTo 0
End If

If SDB.IniFile Is Nothing Then
ElseIf SDB.MessageBox("Do you want to remove RegExp Find and Replace" _
        & " add-on settings as well?" & vbNewLine  & vbNewLine _
        & "If you click No, add-on settings will be left in MediaMonkey.ini.", _
        mtConfirmation, Array(mbYes, mbNo)) = mrYes Then

    SDB.IniFile.DeleteSection("RegExpReplace")
    SDB.IniFile.DeleteSection("RegExpOptions")
    SDB.IniFile.DeleteSection("RegExpPresets")
End If
