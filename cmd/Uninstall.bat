@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[����"�R�}���h �v�����v�g"���폜���܂��B
@PAUSE
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@SET REG_DRIVE_SHELL=HKCU\Software\Classes\Drive\shell
@REG DELETE %REG_DIRECTORY_SHELL%\cmd_admin /f
@REG DELETE %REG_DIRECTORY_SHELL%\cmd_user /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\cmd_admin /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\cmd_user /f
@REG DELETE %REG_DRIVE_SHELL%\cmd_admin /f
@REG DELETE %REG_DRIVE_SHELL%\cmd_user /f
@PAUSE
