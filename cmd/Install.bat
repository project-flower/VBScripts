@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[��"�R�}���h �v�����v�g"��ǉ����܂��B
@PAUSE
@CD /D %~dp0
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@SET REG_DRIVE_SHELL=HKCU\Software\Classes\Drive\shell
@SET COMMANDNAME_ADMIN=�R�}���h �v�����v�g (�Ǘ���)
@SET COMMANDNAME_USER=�R�}���h �v�����v�g
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\cmd_admin "%COMMANDNAME_ADMIN%" "\"%%%%1\" 1"
@CALL :AddShellCommand %REG_DIRECTORY_SHELL%\cmd_user "%COMMANDNAME_USER%" "\"%%%%1\""
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\cmd_admin "%COMMANDNAME_ADMIN%" "\"%%%%V\" 1"
@CALL :AddShellCommand %REG_DIRECTORY_BACKGROUND_SHELL%\cmd_user "%COMMANDNAME_USER%" "\"%%%%V\""
@CALL :AddShellCommand %REG_DRIVE_SHELL%\cmd_admin "%COMMANDNAME_ADMIN%" "%%%%1 1"
@CALL :AddShellCommand %REG_DRIVE_SHELL%\cmd_user "%COMMANDNAME_USER%" "%%%%1"
@PAUSE
@EXIT /B

:AddShellCommand
@REG ADD %~1 /t REG_SZ /ve /d "%~2" /f
@REG ADD %~1 /t REG_EXPAND_SZ /v Icon /d %%ComSpec%% /f
@REG ADD %~1\command /t REG_EXPAND_SZ /ve /d "WScript \"%~dp0cmd.vbs\" %~3" /f
@EXIT /B
