# ----------------- #
# ファイルのpathを検索するfindコマンド
# * 使うときは、""で囲うように。
find . -name "*.html" -type f

# findと、grepで、より精密にファイルを検索します。
find ~/Documents/my_website -name img -type d | grep 'Light'
# ----------------- #
# 標準入力やファイルからリストを読み込み、
# コマンドラインを作成して実行する、xargsコマンド。
# xargsは実行可能ファイルにのみ引数を受け渡すことが出来ますが、
# cdはbuilt-inのコマンドのため使えません。

# コマンドと標準入力・標準出力
# 標準入力・標準出力とは、コマンド用（プログラム・プロセス用）
# にあらかじめ確保されているデータの入出力経路（ストリーム）のことです。
# また、デフォルト設定では、標準入力は端末のキーボードに、
# 標準出力は端末の画面にそれぞれ接続されています。
# 標準出力や標準入力の接続先を変更することで、
# 他のデバイスから"入力"したりファイルに"出力"したりすることも可能です。

# パイプ | は、この接続先の変更を行うための手段の１つになります。
# 接続先の変更を行う手段には、他にもリダイレクトなどがあります
# | を利用することで、コマンドの標準出力を別のコマンドの標準入力に接続することが出来ます。
cat text.txt | hexdump
# 上記の例で言うと、
# cat コマンドの標準出力の接続先は hexdump の標準入力となります。

# ただ、パイプは、
# あくまでも「出力を渡す先がコマンドの標準入力」になります。
# | の右側で実行されるコマンドが標準入力を利用しない場合もあります。
# そういったコマンドは、標準入力からではなく「引数」として入力を受け取ることが多いです。
# そこで使えるのが、xargs
# xargs は、「標準入力からの入力」を引数に指定して
# 別のコマンドを実行するコマンドになります（ファイル等からでも入力できる）。
コマンド１ | xargs コマンド２
# xargs は、コマンド１の標準出力を、引数に、
# コマンド２を実行します。

# つまり、これらのコマンドは、入力経路（標準入力 or 引数）で使い分けましょう。

# Linuxコマンドがデータを受け取る入力経路（標準入力または引数）を判別する方法
# 標準入力を受け入れるコマンドならば、通常、パイプ(|)を使用して他のコマンドと組み合わせます。
# 代表的な、標準入力を入力経路としているLinuxコマンド
cat , grep , sort , wc , pbcopy

# ----------------- #

# xargsと、バッククォートの違いってなに？
# xargsの強みは、-Lオブションで繰り返しxargsコマンドを実行できるところって感じ。

cat test.txt | xargs rm # rm ./{each,time,everyone,has,cant}
cat test.txt | xargs echo # echo 'each time everyone has cant'
# 上記の例では、実質、一度のコマンドに収めてます。
cat test.txt | xargs -p -L1 echo
# -Lコマンドを使えば、複数の引数を受けたとき、複数回xargsコマンドを実行することができる。
# エラーの制御, 進捗の可視化, リソースの制御 などの用途があります。

find . -name "*.html" -type f | xargs open
# 検索したファイル全てにopenコマンドをかける。

find ~/Documents/my_website -name "*.html" -type f | xargs -p open
# xargs -p = ドライラン、実行される予定のコマンドが出力されます。

find ~/Documents/my_website/ -name index.html -type f | xargs -IXXX cp XXX ./
find ~/Documents/my_website/ -name "*.html" -type f | xargs -I{} cp {} ./
cp `find ~/Documents/my_website -name "*.html" -type f` ./
# うーん。上記の３つどれも、実行結果変わらん。

# ----------------- #
# Linuxコマンドを連結して使いたい。

# コマンド1が終了したらコマンド2を実行する（実行結果に関わらず）
sleep 5m ; date 
# コマンド1を実行しつつコマンド2も実行する
sh /home/egawa/egawa.sh >> /var/log/egawa.log & vi /home/egawa/egawa.txt
# コマンド1が正常終了したらコマンド2を実行する
cd /home/egawa/ && touch egawa.txt
# コマンド1の結果をコマンド2に渡して実行
ps aux | grep httpd
# コマンド1が異常終了したらコマンド2が実行される
cd /home/egawa/abc || mkdir /home/egawa/abc

# ----------------- #
# Linuxコマンドの実行結果を他のコマンドの引数にする。

# コマンドをバッククォートで囲みます。
# findで検索したpathに、cdで移動します。
cd `find ~/Documents -name test_dir -type d`

# ----------------- #
# 行単位で、文字列を抽出する、awkコマンド
echo 'hoge01\nhoge02' | awk '{print $1}'
# hoge01
# hoge02

# 任意の文字列で区切り、文字列を抽出する、-Fオプション
ls ./img | awk -F'[png]' '{print $1$2$3}'`

# ----------------- #
# 入力を１行ずつ読み取って出力するreadコマンド。
echo $var_img | while read img
do
    echo $img "１行ずつ読み取って出力してくれます"
done
# ----------------- #
# 複数のファイル名を一括して変更できるrenameコマンド
# renameの強みは、ファイル名を部分的に置換できるところですかね。
rename "s/2017/2018/;" 20170426_01.txt 20170426_02.txt
# ----------------- #
# mvコマンドについて

# 他ディレクトリ内のファイル名を改名。
cd `find ~/Documents/my_website -name img -type d | grep 'Lightbox'` && mv ./"スクリーンショット 2023-09-11 22.42.00.png" ./ws-19

# 複数のファイルを他ディレクトリに移動
find ~/Documents/my_website -name audio -type d | grep "osinoko" | xargs -I{} mv ./fa.mp3 ra.mp3 si.mp3 so.mp3 {}
# ----------------- #
# ----------------- #
# ----------------- #








