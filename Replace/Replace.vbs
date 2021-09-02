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
Dim Description
Dim ScriptName
Dim After
Dim FileSystem
Dim Count

BeforeNeeded = True
Before = ""
Set Arguments = WScript.Arguments
Recursive = False

If Arguments.Count < 1 Then
    PathNeeded = True
Else
    Path = Arguments(0)
    PathNeeded = False

    If Arguments.Count > 1 Then
        Select Case Arguments(1)
            Case "/r", "/R"
                Recursive = True
        End Select
    End If
End If

Set FileSystem = CreateObject("Scripting.FileSystemObject")
ScriptName = "�ꊇ���O�ύX"

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
    WScript.Quit
End Function

Function SearchDirectory(ByVal folderspec)
    Dim Folder
    Dim ErrNumber
    Dim ErrDescription

    Do
        On Error Resume Next
        Set Folder = FileSystem.GetFolder(folderspec)
        ErrNumber = Err.Number
        ErrDescription = Err.Description
        On Error GoTo 0
        Err.Clear

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
    ' �t�@�C���ɃA�N�Z�X�ł��邩�`�F�b�N����
    ' (�f�B���N�g���ɓǂݎ�茠�����Ȃ��ꍇ�A�����ŃG���[�ɂȂ�)
    FileCount = Files.Count
    ErrNumber = Err.Number
    ErrDescription = Err.Description
    Err.Clear

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
            AfterFileName = Replace(BeforeFileName, Before, After)

            If AfterFileName <> BeforeFileName Then
                Do
                    File.Name = AfterFileName
                    ErrNumber = Err.Number
                    ErrDescription = Err.Description
                    Err.Clear

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
