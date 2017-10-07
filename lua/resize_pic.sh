#!/bin/bash

>> /tmp/test.log
#for v_dir in `find /tmp/user/ -name month*`
for v_dir in `find /usr/local/fastDFS/storage/data/00/0* -name 0* -type d`
do
echo $v_dir >> /tmp/test.log
  cd $v_dir
    for v_file in `du -sk * | sort -n -k 1 -r |awk  '{if ($1>2000) print $2}' |grep $1$`
    do
    if [ "$1" == ".png" ];then 
    cp $v_file $v_file"_bak"
    /usr/local/bin/gm convert $v_file -resize '70%' PNG8:$v_file
    echo "/usr/local/bin/gm convert $v_file -resize '70%' PNG8:$v_file" >> /tmp/test.log
    fi

    if [ "$1" == ".jpg" ];then
    cp $v_file $v_file"_bak"
    /usr/local/bin/gm convert -quality 30 $v_file $v_file
    echo "/usr/local/bin/gm convert -quality 30 $v_file $v_file" >> /tmp/test.log
    fi

    if [ "$1" == ".gif" ];then
    cp $v_file $v_file"_bak"
    /usr/bin/convert $v_file -fuzz 8% -layers optimize $v_file
    echo "convert $v_file -fuzz 8% -layers optimize $v_file" >> /tmp/test.log
    fi
    done
done

