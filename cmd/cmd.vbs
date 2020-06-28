Option Explicit

Dim Arguments
Set Arguments = WScript.Arguments
Dim ArgumentsCount
ArgumentsCount = Arguments.Count

If ArgumentsCount < 1 Then
    WScript.Quit
End If

Dim WorkDirectory
WorkDirectory = Arguments(0)

Select Case ArgumentsCount
    Case 1
        LaunchPrompt WorkDirectory, ""

    Case 2, 3
        Dim Operation
        Operation = "runas"

        Select Case Arguments(ArgumentsCount - 1)
            Case "1"
                ShellExecute "WScript", """" & WScript.ScriptFullName & """ """ & WorkDirectory & """ 2", "", Operation, 1

            Case "2"
                LaunchPrompt WorkDirectory, Operation
        End Select
End Select

WScript.Quit

Sub LaunchPrompt(ByVal Directory, ByVal Operation)
    Dim Shell
    Set Shell = WScript.CreateObject("WScript.Shell")
    Dim ComSpec
    ComSpec = Shell.ExpandEnvironmentStrings("%ComSpec%")
    Dim FileSystem
    Set FileSystem = WScript.CreateObject("Scripting.FileSystemObject")

    If FileSystem.FolderExists(WorkDirectory) Then
        ShellExecute ComSpec, "", WorkDirectory, Operation, 1
    End If

    Set FileSystem = Nothing
    Set Shell = Nothing
End Sub

Function ShellExecute(ByVal File, ByVal Arguments, ByVal Directory, ByVal Operation, ByVal Show)
    Dim Application
    Set Application = WScript.CreateObject("Shell.Application")
    ShellExecute = Application.ShellExecute(File, Arguments, Directory, Operation, Show)
    Set Application = Nothing
End Function
