' Replace.vbs
' Copyright (C) Project Flower 2020

Option Explicit

' Global Fields
Dim BeforeNeeded
Dim Before
Dim Arguments
Dim PathNeeded
Dim Path
Dim Description
Dim ScriptName
Dim After
Dim FileSystem
Dim Count

BeforeNeeded = True
Before = ""
Set Arguments = WScript.Arguments

If Arguments.Count < 1 Then
    PathNeeded = True
Else
    Path = Arguments(0)
    PathNeeded = False
End If

Set FileSystem = CreateObject("Scripting.FileSystemObject")
ScriptName = "一括名前変更"

Do While BeforeNeeded
    Before = InputBox("置換前の文字列を入力してください。", ScriptName, Before)

    If IsEmpty(Before) Then
        MsgBox "キャンセルされました。", vbInformation Or vbOkOnly, ScriptName
        Quit
    ElseIf Before = "" Then
        MsgBox "置換前の文字列が入力されていません。", vbCritical Or vbOkOnly, ScriptName
    Else
        BeforeNeeded = False
    End If

    Dim AfterNeeded
    AfterNeeded = True

    Do While (Not BeforeNeeded) And AfterNeeded
        Description = "置換前の文字列:" & vbCrLf & Before
        After = InputBox("置換後の文字列を入力してください。" & vbCrLf & vbCrLf & Description, ScriptName, After)

        If IsEmpty(After) Then
            BeforeNeeded = True
            Exit Do
        Else
            AfterNeeded = False
        End If

        Description = Description & vbCrLf & "置換後の文字列:" & vbCrLf & After

        Do While (Not AfterNeeded) And (PathNeeded Or Not FileSystem.FolderExists(Path))
            Path = InputBox("ディレクトリを指定してください。" & vbCrLf & vbCrLf & Description, ScriptName, Path)

            If IsEmpty(Path) Then
                AfterNeeded = True
                Exit Do
            End If

            PathNeeded = False
        Loop
    Loop
Loop

Count = 0
SearchDirectory Path, True
MsgBox Count & " 件 置換しました。" & vbCrLf & vbCrLf & Description, vbInformation Or vbOkOnly, ScriptName
Quit

Function Quit()
    Set FileSystem = Nothing
    WScript.Quit
End Function

Function QuitWhenError()
    If Err.Number = 0 Then
        Exit Function
    End If

    MsgBox Err.Description, vbInformation Or vbOkOnly, ScriptName
    Quit
End Function

Function SearchDirectory(ByVal folderspec, ByVal Recursive)
    Dim Folder
    On Error Resume Next
    Set Folder = FileSystem.GetFolder(folderspec)

    If Err.Number <> 0 Then
        MsgBox "GetFolder 失敗"
        On Error GoTo 0
        Exit Function
    End If

    Dim Files
    Set Files = Folder.Files

    If Err.Number = 0 Then
        On Error GoTo 0
        Dim File

        For Each File In Files
            Dim BeforeFileName
            Dim AfterFileName
            On Error Resume Next
            BeforeFileName = File.Name

            If Err.Number = 0 Then
                AfterFileName = Replace(BeforeFileName, Before, After)

                If AfterFileName <> BeforeFileName Then
                    File.Name = AfterFileName

                    If Err.Number = 0 Then
                        Count = Count + 1
                    End If
                End If
            End If

            On Error GoTo 0
        Next
    Else
        MsgBox Err.Description
    End If

    If Recursive Then
        Dim SubFolders
        Set SubFolders = Folder.SubFolders

        If Err.Number = 0 Then
            Dim SubFolder

            For Each SubFolder In SubFolders
                SearchDirectory SubFolder, True
            Next
        End If
    End If
End Function
