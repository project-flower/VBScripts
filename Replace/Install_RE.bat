@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[��"�ꊇ�u�� (���K�\��)"��ǉ����܂��B
@PAUSE
@CD /D %~dp0
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@SET COMMANDNAME=�ꊇ�u�� (���K�\��)
@SET COMMANDNAME_R=�ꊇ�u�� (���K�\��) (�ċA�I)
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\ReplaceRegex "%COMMANDNAME%" "\"%%%%1\" /RE"
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\ReplaceRegexRecursive "%COMMANDNAME_R%" "\"%%%%1\" /RE /R"
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegex "%COMMANDNAME%" "\"%%%%V\" /RE"
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegexRecursive "%COMMANDNAME_R%" "\"%%%%V\" /RE /R"
@PAUSE
@EXIT /B

:AddShellCommand
@REG ADD %~1 /t REG_SZ /ve /d "%~2" /f
@REG ADD %~1 /t REG_SZ /v Icon /d WScript.exe /f
@REG ADD %~1\command /t REG_SZ /ve /d "WScript \"%~dp0Replace.vbs\" %~3" /f
@EXIT /B
