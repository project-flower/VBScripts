' Replace.vbs
' Copyright (C) Project Flower 2020-2021

Option Explicit

' Global Fields
Dim BeforeNeeded
Dim Before
Dim Arguments
Dim PathNeeded
Dim Path
Dim Recursive
Dim UseRegExp
Dim Description
Dim ScriptName
Dim After
Dim FileSystem
Dim Count
Dim RegExp

BeforeNeeded = True
Before = ""
Set Arguments = WScript.Arguments
Recursive = False
UseRegExp = False

If Arguments.Count < 1 Then
    PathNeeded = True
Else
    Path = Arguments(0)
    PathNeeded = False

    Dim Index

    If Arguments.Count > 1 Then
        For Index = 1 To Arguments.Count - 1

            Select Case Arguments(Index)
                Case "/r", "/R"
                    Recursive = True
                Case "/re", "/RE"
                    UseRegExp = True
            End Select
        Next
    End If
End If

Set FileSystem = CreateObject("Scripting.FileSystemObject")
ScriptName = "�ꊇ���O�ύX"

If UseRegExp Then
    ScriptName = ScriptName & " (���K�\��)"
    Set RegExp = CreateObject("VBScript.RegExp")
    RegExp.Global = True
    RegExp.IgnoreCase = True
End If

If Recursive Then
    ScriptName = ScriptName & " (�ċA�I)"
End If

Do While BeforeNeeded
    Before = InputBox("�u���O�̕��������͂��Ă��������B", ScriptName, Before)

    If IsEmpty(Before) Then
        MsgBox "�L�����Z������܂����B", vbInformation Or vbOkOnly, ScriptName
        Quit
    ElseIf Before = "" Then
        MsgBox "�u���O�̕����񂪓��͂���Ă��܂���B", vbCritical Or vbOkOnly, ScriptName
    ElseIf UseRegExp Then
        RegExp.Pattern = Before
        On Error Resume Next
        Err.Clear
        RegExp.Test ""

        If Err.Number = 0 Then
            BeforeNeeded = False
        Else
            MsgBox "���K�\��������������܂���B" & vbCrLf & vcCrLf & Before, vbCritical Or vbOkOnly, ScriptName
        End If

        On Error GoTo 0
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
SearchDirectory Path
ShowMessageAndQuit

Function Quit()
    Set FileSystem = Nothing
    Set RegExp = Nothing
    WScript.Quit
End Function

Function SearchDirectory(ByVal folderspec)
    Dim Folder
    Dim ErrNumber
    Dim ErrDescription

    Do
        On Error Resume Next
        Err.Clear
        Set Folder = FileSystem.GetFolder(folderspec)
        ErrNumber = Err.Number
        ErrDescription = Err.Description
        On Error GoTo 0

        If ErrNumber = 0 Then
            Exit Do
        End If

        ' �s���ȃp�X���w�肵���ꍇ
        SearchDirectory = MsgBox(ErrDescription & vbCrLf & vbCrLf & folderspec, vbAbortRetryIgnore Or vbCritical, ScriptName)
        Exit Function
    Loop While True

    Dim Files
    Set Files = Folder.Files
    Dim FileCount
    On Error Resume Next
    Err.Clear
    ' �t�@�C���ɃA�N�Z�X�ł��邩�`�F�b�N����
    ' (�f�B���N�g���ɓǂݎ�茠�����Ȃ��ꍇ�A�����ŃG���[�ɂȂ�)
    FileCount = Files.Count
    ErrNumber = Err.Number
    ErrDescription = Err.Description

    If ErrNumber <> 0 Then
        SearchDirectory = MsgBox(ErrDescription & vbCrLf & vbCrLf & Folder.Path, vbAbortRetryIgnore Or vbCritical, ScriptName)
        Exit Function
    Else
        Dim File

        For Each File In Files
            Dim BeforeFileName
            ' MAX_PATH �����ɂ��G���[�͂����ł͔������Ȃ�
            BeforeFileName = File.Name
            Dim AfterFileName
            Dim Continue
            Continue = False

            If UseRegExp Then
                Err.Clear
                AfterFileName = RegExp.Replace(BeforeFileName, After)
                ErrNumber = Err.Number
                ErrDescription = Err.Description

                If ErrNumber <> 0 Then
                    If MsgBox(ErrDescription & vbCrLf & vbCrLf & File.Path, vbOKCancel Or vbCritical, ScriptName) = vbCancel Then
                        ShowMessageAndQuit
                    End If

                    Continue = True
                End If
            Else
                AfterFileName = Replace(BeforeFileName, Before, After)
            End If

            If Not Continue AND AfterFileName <> BeforeFileName Then
                Do
                    Err.Clear
                    File.Name = AfterFileName
                    ErrNumber = Err.Number
                    ErrDescription = Err.Description

                    If ErrNumber = 0 Then
                        Count = Count + 1
                        Exit Do
                    End If

                    Select Case MsgBox(ErrDescription & vbCrLf & vbCrLf & File.Path, vbAbortRetryIgnore Or vbCritical, ScriptName)
                        Case vbAbort
                            ShowMessageAndQuit
                        Case vbIgnore
                            Exit Do
                    End Select
                Loop While True
            End If
        Next
    End If

    On Error GoTo 0

    If Recursive Then
        Dim SubFolders
        Set SubFolders = Folder.SubFolders
        Dim SubFolder

        For Each SubFolder In SubFolders
            Do
                Select Case SearchDirectory(SubFolder)
                    Case vbAbort
                        ShowMessageAndQuit
                    Case vbIgnore, vbOK
                        Exit Do
                End Select
            Loop While True
        Next
    End If

    SearchDirectory = vbOK
End Function

Function ShowMessageAndQuit()
    MsgBox Count & " �� �u�����܂����B" & vbCrLf & vbCrLf & Description, vbInformation Or vbOkOnly, ScriptName
    Quit
End Function
