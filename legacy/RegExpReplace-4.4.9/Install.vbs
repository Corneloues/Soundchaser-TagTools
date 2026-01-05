Dim i, a

If Not SDB.Objects("tbrRegExpReplaceDialog") Is Nothing Then
    SDB.Objects("tbrRegExpReplaceDialog").Visible = False
    Set SDB.Objects("tbrRegExpReplaceDialog") = Nothing
End If
If Not SDB.Objects("tbrRegExpExecuted") Is Nothing Then
    SDB.Objects("tbrRegExpExecuted").Visible = False
    Set SDB.Objects("tbrRegExpExecuted") = Nothing
End If

' Remove old menu/toolbar when upgrading from some version older than 4.4
For i = 1 To 300
    If Not SDB.Objects("MnuRegExpPreset" & i) Is Nothing Then
        With SDB.Objects("MnuRegExpPreset" & i)
            .Shortcut = ""
            .Caption = ""
            .Hint = ""
            .Visible = False
        End With
    End If
    If Not SDB.Objects("TbbRegExpButton" & i) Is Nothing Then
        With SDB.Objects("TbbRegExpButton" & i)
            .Caption = ""
            .Hint = ""
            .IconIndex = -1
            .Visible = False
        End With
    End If
Next
If Not SDB.Objects("tbrRegExpPresets") Is Nothing Then
    SDB.Objects("tbrRegExpPresets").Visible = False
End If
If Not SDB.Objects("mnuRegExpReplaceDialog") Is Nothing Then
    SDB.Objects("mnuRegExpReplaceDialog").Visible = False
End If
If Not SDB.Objects("mnuRegExpPresets") Is Nothing Then
    SDB.Objects("mnuRegExpPresets").Visible = False
End If
If Not SDB.Objects("mnuRegExpExportImport") Is Nothing Then
    SDB.Objects("mnuRegExpExportImport").Visible = False
End If

' Remove menu/toolbar when upgrading version 4.4 or higher:
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

On Error Resume Next
Dim oForm, oCtrl, oBttn
Set oForm = SDB.UI.NewForm
With oForm
    .BorderStyle = 2
    With .Common
        .SetRect 100, 100, 365 + .Width - .ClientWidth, _
                175 + .Height - .ClientHeight
        .MinWidth = 365
        .MinHeight = 175
    End With
    .FormPosition = 4
    .Caption = "RegExp Find and Replace"
End With

Set oCtrl = SDB.UI.NewActiveX(oForm, "Shell.Explorer")
With oCtrl
    With .Common
        .Anchors = 1 + 2 + 4 + 8
        .SetRect 0, 0, 365, 130
    End With
    .SetHTMLDocument "<html><head><style type='text/css'>" _
            & "body {margin: 10px 10px; overflow: hidden; border: none} " _
            & "</style></head><body>" _
            & "This is freely available version of the add-on.<br /><br />" _
            & "There is also the <a href=""" _
            & "http://solair.eunet.rs/~zvezdand/RegExpReplaceNew.htm" _
            & """>new enhanced version</a> that is available only to donors." _
            & "</body></html>"
End With

Set oBttn = SDB.UI.NewButton(oForm)
With oBttn
    With .Common
        .Anchors = 4 + 8
        .SetRect 280, 143, 73, 24
    End With
    .Caption = "&OK"
    .Default = True
    .ModalResult = 1
End With

oForm.showModal
On Error GoTo 0
