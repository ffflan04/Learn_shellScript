# ----------------- #
# if の後のコマンド、[], cd が競合している。
unix_documents="my_website"
unix_backDir=".."
if [ cd $unix_backDir ];then
    echo "to arrive $1 is succeed !"
    ls
fi
# ----------------- #
# ""の意味について
# cd のpath を記述するとき、""で囲ってもまぁ、問題ない。
cd $unix_backDir/"my_website"
[ -d "my_website" ] # これも問題ない。
# ----------------- #

# ----------------- #
# cpコマンドの仕様
find ~/Documents/my_website/ -name index.html -type f | xargs -IXXX cp XXX ./
# なんで、複数のhtmlファイルがコピーされないんだろう？
# って思ってたけど、そもそも、検索結果は、複数のindex.htmlファイルで、
# そもそも、一つのフォルダの中に、同じ名前のファイルは存在できないだろ。笑
# ----------------- #
# ターミナルにてスペースに注意
cp ./スクリーンショット 2023-09-08* ./img
# ワイルドカードを指定するなら、""で囲う必要がありますよん。
cp ./"スクリーンショット 2023-09-08"* ./img
# 上記が正しい形ですねぇ。
# ----------------- #
# grepコマンドをカウントします。
# grepコマンドを出力する度にカウントするコマンドできた。
cat ./index.html | grep "data-lightbox=" | while read line
# ----------------- #
# 実行結果がカレントディレクトリのコマンドは、cdをはさめ。
# cdコマンドに引数を渡したいなら、バッククォートを使います。
# unzip他のディレクトリで実行したら、カレントディレクトリに、zipファイル展開された。
find ~/Downloads -name "snow-animation*" -type f | xargs -IXXX unzip XXX
# cdコマンドに引数は
find ~/Documents/my_website -name img -type d | grep 'Lightbox' | xargs -IXXX cd XXX && mv ./"ス  クリーンショット 2023-09-11 22.42.00.png" ./ws-19
# ----------------- #
# この返り値は、&の並行したコマンドの処理結果を表します。
[1] 37201
[1]  + done       echo '' > index.html
# ----------------- #
# mvコマンドは、ちゃんと名前書かないと改名できません。
mv ./"change*" ./done.txt
# ----------------- #
# シェルスクリプトにて、$がエラーを発生させた。
# このトラブルシューティングは、HTML&CSSを、クォーテーションで囲わなかったことです。
mv HTML&CSS ~/Documents/
# 正しくは下記
mv ./"HTML&CSS" ~/Documents/
# ----------------- #
# シェルスクリプトは、スペースがエラーを発生させる。
# コマンドの出力結果にスペースが入ってたから、うまくコマンドが実行できなかった。
mv `find . -name "スクリーンショット*" -type f | grep "09-13"` ./ws-21

# ----------------- #
# 結局、パイプ + xargs を使うべき。
find . -name test.txt -type f | cat # catは標準入力のはずなのに、エラーでた。
# xargs使ってちゃんと動いた。
find . -name test.txt -type f | xargs -I{} cat {} 
# これは、動かんかったわ。
# いやー、理論的には、できるはずなんだけどなぁ。
# chatgptに聞いてもわからんかったわ。
find . -name test.txt -type f | xargs -I{} cat ./test01.txt > {}
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #
# ----------------- #







