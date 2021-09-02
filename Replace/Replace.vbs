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
ScriptName = "�ꊇ���O�ύX"

Do While BeforeNeeded
    Before = InputBox("�u���O�̕��������͂��Ă��������B", ScriptName, Before)

    If IsEmpty(Before) Then
        MsgBox "�L�����Z������܂����B", vbInformation Or vbOkOnly, ScriptName
        Quit
    ElseIf Before = "" Then
        MsgBox "�u���O�̕����񂪓��͂���Ă��܂���B", vbCritical Or vbOkOnly, ScriptName
    Else
        BeforeNeeded = False
    End If

    Dim AfterNeeded
    AfterNeeded = True

    Do While (Not BeforeNeeded) And AfterNeeded
        Description = "�u���O�̕�����:" & vbCrLf & Before
        After = InputBox("�u����̕��������͂��Ă��������B" & vbCrLf & vbCrLf & Description, ScriptName, After)

        If IsEmpty(After) Then
            BeforeNeeded = True
            Exit Do
        Else
            AfterNeeded = False
        End If

        Description = Description & vbCrLf & "�u����̕�����:" & vbCrLf & After

        Do While (Not AfterNeeded) And (PathNeeded Or Not FileSystem.FolderExists(Path))
            Path = InputBox("�f�B���N�g�����w�肵�Ă��������B" & vbCrLf & vbCrLf & Description, ScriptName, Path)

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
ShowMessageAndQuit

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
    Dim MsgBoxResult
    Dim Ignore
    On Error Resume Next

    Do
        Set Folder = FileSystem.GetFolder(folderspec)

        If Err.Number = 0 Then
            Exit Do
        End If

        MsgBoxResult = MsgBox(Err.Description & vbCrLf & vbCrLf & folderspec, vbAbortRetryIgnore Or vbCritical, ScriptName)

        Select Case MsgBoxResult
            Case vbAbort
                ShowMessageAndQuit
            Case vbIgnore
                On Error GoTo 0
                Exit Function
        End Select
    Loop While True

    Dim Files
    Ignore = False

    Do
        Set Files = Folder.Files

        If Err.Number = 0 Then
            Exit Do
        End If

        MsgBoxResult = MsgBox(Err.Description & vbCrLf & vbCrLf & Folder.Path, vbAbortRetryIgnore Or vbCritical, ScriptName)

        Select Case MsgBoxResult
            Case vbAbort
                ShowMessageAndQuit
            Case vbIgnore
                Ignore = True
                Exit Do
        End Select
    Loop While True

    If Not Ignore Then
        Dim File

        For Each File In Files
            Dim BeforeFileName
            Dim AfterFileName

            Do
                BeforeFileName = File.Name

                If Err.Number = 0 Then
                    Exit Do
                End If

                MsgBoxResult = MsgBox(Err.Description & vbCrLf & vbCrLf & File.Path, vbAbortRetryIgnore Or vbCritical, ScriptName)

                Select Case MsgBoxResult
                    Case vbAbort
                        ShowMessageAndQuit
                    Case vbIgnore
                        Ignore = True
                        Exit Do
                End Select
            Loop While True

            If Not Ignore Then
                AfterFileName = Replace(BeforeFileName, Before, After)

                If AfterFileName <> BeforeFileName Then
                    Do
                        File.Name = AfterFileName

                        If Err.Number = 0 Then
                            Count = Count + 1
                            Exit Do
                        End If

                        MsgBoxResult = MsgBox(Err.Description & vbCrLf & vbCrLf & File.Path, vbAbortRetryIgnore Or vbCritical, ScriptName)

                        Select Case MsgBoxResult
                            Case vbAbort
                                ShowMessageAndQuit
                            Case vbIgnore
                                Exit Do
                        End Select
                    Loop While True
                End If
            End If

            On Error GoTo 0
        Next
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

Function ShowMessageAndQuit()
    MsgBox Count & " �� �u�����܂����B" & vbCrLf & vbCrLf & Description, vbInformation Or vbOkOnly, ScriptName
    Quit
End Function
