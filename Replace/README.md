# 概要
ディレクトリ内のファイル名を一括変更します。

# 構成ファイル
- Install.bat
- Install_RE.bat
- Readme.md
- Replace.vbs
- Uninstall.bat
- Uninstall_RE.bat

# インストール
1. Replace.vbs, Install.bat を任意の場所にダウンロードし、Install.bat を実行します。<br>
正規表現版をインストールする場合は、Install_RE.bat を実行してください。<br>
"続行するには何かキーを押してください . . ."と表示されたら、何かキーを押してください。<br>
 - Replace.vbs, Uninstall.bat, Uninstall_RE.bat はアンインストールするまで移動しないでください。

# 使用方法
1. エクスプローラから、ディレクトリのアイコン、ディレクトリの背景で右ボタンをクリックし、<br>
"一括置換"、"一括置換 (再帰的)"、"一括置換 (正規表現)"または"一括置換 (正規表現) (再帰的)"をクリックしてください。<br>
"(再帰的)"をクリックした場合、サブディレクトリのファイル名も変更されます。
2. "置換前の文字列を入力してください。"と表示されたら、置換前の文字列をテキスト ボックスに入力し、<br>
[OK]をクリックしてください。<br>
"(正規表現)"をクリックした場合、正規表現で入力してください。<br>
[キャンセル]をクリックすると、スクリプトを中断します。
3. "置換後の文字列を入力してください。"と表示されたら、置換後の文字列をテキスト ボックスに入力し、<br>
[OK]をクリックしてください。<br>
[キャンセル]をクリックすると、2.に戻ります。
4. ファイル名変更時にエラーが発生した場合、エラー メッセージと[中止(A)][再試行(R)][無視(I)]のボタンが表示されます。<br>
 - [中止(A)]をクリックすると、それ以降のファイル名変更を中止します。
 - [再試行(R)]をクリックすると、もう一度ファイル名変更を実行します。
 - [無視(I)]をクリックすると、そのファイルをスキップし、以降のファイル名変更へ進みます。
5. ファイル名変更が完了すると、"X 件 置換しました。"と表示されます(X には変更されたファイルの数が入ります)。

# アンインストール
1. Uninstall.bat を実行します。<br>
正規表現版をアンインストールする場合は Uninstall_RE.bat を実行してください。<br>
"続行するには何かキーを押してください . . ."と表示されたら、何かキーを押してください。
