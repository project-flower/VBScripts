@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[����"�ꊇ�u��"���폜���܂��B
@PAUSE
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@REG DELETE %REG_DIRECTORY_SHELL%\Replace /f
@REG DELETE %REG_DIRECTORY_SHELL%\ReplaceRecursive /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\Replace /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRecursive /f
@PAUSE
