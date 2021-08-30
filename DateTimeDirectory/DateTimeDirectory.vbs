' DateTimeDirectory.vbs
' Copyright (C) Project Flower 2021

Option Explicit

Dim NowDateTime
NowDateTime = Now
Dim Arguments
Set Arguments = WScript.Arguments
Dim ScriptName
ScriptName = "DateTimeDirectory"

If Arguments.Count < 1 Then
    MsgBox "第1引数にパスを指定してください。", vbOkOnly Or vbCritical, ScriptName
    WScript.Quit
End If

Dim FileSystem
Set FileSystem = CreateObject("Scripting.FileSystemObject")
On Error Resume Next
Err.Clear
Dim Folder
Set Folder = FileSystem.GetFolder(Arguments(0))
Dim ErrNumber
ErrNumber = Err.Number
Dim ErrDescription
ErrDescription = Err.Description
On Error GoTo 0

If ErrNumber <> 0 Then
    MsgBox ErrDescription, vbOkOnly Or vbCritical, ScriptName
    Quit
End If

On Error Resume Next
Err.Clear
Folder.SubFolders.Add Replace(Replace(Replace(NowDateTime, "/", ""), ":", ""), " ", "")
ErrNumber = Err.Number
ErrDescription = Err.Description
On Error GoTo 0

If ErrNumber <> 0 Then
    MsgBox ErrDescription, vbOkOnly Or vbCritical, ScriptName
    Quit
End If

Quit

Function Quit()
    Set Folder = Nothing
    Set FileSystem = Nothing
    WScript.Quit
End Function
