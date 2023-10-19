# ----------------- #
# 文字列を結合して、for文で結合して出力するシェルスクリプト
array=(`ls ./img`)

for i in {1..`expr ${#array[@]} / 3`}
do
    num=1
    img_var=$array[$num]$array[$(($num + 1))]$array[$(($num + 2))]
    echo $img_var
    num=$(($num + 3))
done

# awkコマンド使えば、もっとスマート
ls ./img | awk '{print $1$2$3}'
# ----------------- #
# スクリーンショットファイルをまとめて、改名するシェルスクリプト
var_img=`ls ./img | awk -F'[png]' '{print $1$2$3}'`

num=0
echo $var_img | while read img
do
    num=$(($num + 1))
    mv ./img/$img"png" ./img/ws-$num
done
# ----------------- #
# １７箇所の、ファイル内の文章を、一括で変換するシェルスクリプト
num=0
cat ./index.html | grep -n "data-lightbox=" | awk -F'[:]' '{print $1}' | while read line
do
    num=$(($num + 1))
    echo $line" lines named $num"
    sed -i -e "${line}s/ws-2/ws-$num/" ./index.html
done

num=0
cat ./index.html | grep -n 'alt=""' | awk -F'[:]' '{print $1}' | while read line
do
    num=$(($num + 1))
    sed -i -e "${line}s/ws-2/ws-$num/" ./index.html
done
# ----------------- #
