@SETLOCAL
@ECHO �G�N�X�v���[���[�̃R���e�L�X�g ���j���[����"�ꊇ�u�� (���K�\��)"���폜���܂��B
@PAUSE
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@REG DELETE %REG_DIRECTORY_SHELL%\ReplaceRegex /f
@REG DELETE %REG_DIRECTORY_SHELL%\ReplaceRegexRecursive /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegex /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegexRecursive /f
@PAUSE
