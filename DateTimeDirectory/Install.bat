@SETLOCAL
@ECHO エクスプローラーのコンテキスト メニューに"DateTimeDirectory"を追加します。
@PAUSE
@CD /D %~dp0
@SET REG_FOLDER_SHELL=HKCU\Software\Classes\Folder\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@SET REG_LIBRARYFOLDER_BACKGROUND_SHELL=HKCU\Software\Classes\LibraryFolder\Background\shell
@SET COMMANDNAME=DateTimeDirectory
@CALL :AddShellCommand %REG_FOLDER_SHELL%\DateTimeDirectory "%COMMANDNAME%" "\"%%%%1\""
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\DateTimeDirectory "%COMMANDNAME%" "\"%%%%V\""
@CALL :AddShellCommand %REG_LIBRARYFOLDER_BACKGROUND_SHELL%\DateTimeDirectory "%COMMANDNAME%" "\"%%%%V\""
@PAUSE
@EXIT /B

:AddShellCommand
@REG ADD %~1 /t REG_SZ /ve /d "%~2" /f
@REG ADD %~1 /t REG_SZ /v Icon /d WScript.exe /f
@REG ADD %~1\command /t REG_SZ /ve /d "WScript \"%~dp0DateTimeDirectory.vbs\" %~3" /f
@EXIT /B
