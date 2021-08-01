@SETLOCAL
@ECHO エクスプローラーのコンテキスト メニューから"一括置換 (正規表現)"を削除します。
@PAUSE
@SET REG_DIRECTORY_SHELL=HKCU\Software\Classes\Directory\shell
@SET REG_DIRECTORY_BACKGROUND_SHELL=HKCU\Software\Classes\Directory\Background\shell
@REG DELETE %REG_DIRECTORY_SHELL%\ReplaceRegex /f
@REG DELETE %REG_DIRECTORY_SHELL%\ReplaceRegexRecursive /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegex /f
@REG DELETE %REG_DIRECTORY_BACKGROUND_SHELL%\ReplaceRegexRecursive /f
@PAUSE
