@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[��"�ꊇ�u��"��ǉ����܂��B
@PAUSE
@CD /D %~dp0
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@SET COMMANDNAME=�ꊇ�u��
@SET COMMANDNAME_R=�ꊇ�u�� (�ċA�I)
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\Replace "%COMMANDNAME%" "\"%%%%1\""
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\ReplaceRecursive "%COMMANDNAME_R%" "\"%%%%1\" /R"
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\Replace "%COMMANDNAME%" "\"%%%%V\""
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRecursive "%COMMANDNAME_R%" "\"%%%%V\" /R"
@PAUSE
@EXIT /B

:AddShellCommand
@REG ADD %~1 /t REG_SZ /ve /d "%~2" /f
@REG ADD %~1 /t REG_SZ /v Icon /d WScript.exe /f
@REG ADD %~1\command /t REG_SZ /ve /d "WScript \"%~dp0Replace.vbs\" %~3" /f
@EXIT /B
