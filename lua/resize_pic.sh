#!/bin/bash

#du -sk `find /usr/local/fastDFS/storage/data/ |grep "$1"`| sort -n -k 1 -r |awk  '{if ($1>1000) print $2}' >/tmp/resize_pic.log
cp /tmp/resize_pic_new.log /tmp/resize_pic_old.log
find /usr/local/fastDFS/storage/data/ |grep "\." |grep -v "\_bak" |grep -v "\_water">/tmp/resize_pic_new.log

comm -23 <(sort /tmp/resize_pic_new.log|uniq ) <(sort /tmp/resize_pic_old.log|uniq ) > /tmp/resize_pic.log

for v_file in `grep -v 'original' /tmp/resize_pic.log`
do
    v_file_short=${v_file%%.*}
    v_file_type=${v_file#*.}
    v_count=`grep $v_file_short\_original /tmp/resize_pic.log|wc -l`
#    echo $v_file_short\_original >>/tmp/resize.log
#    echo 'v_file_short='$v_file_short>>/tmp/resize.log
#    echo 'v_file='$v_file>>/tmp/resize.log
#    echo 'v_count='$v_count>>/tmp/resize.log
    if [ $v_count -lt 1 ];then
#        echo 'this is 0' >> /tmp/resize.log
#        cp $v_file $v_file_short\_original\.$v_file_type
        
        if [ $v_file_type == "png" ];then 
        cp $v_file $v_file_short\_original\.$v_file_type
        convert $v_file -resize '70%' PNG8:$v_file
        echo "/usr/local/bin/gm convert $v_file -resize '70%' PNG8:$v_file" >> /tmp/resize.log
        fi

        if [ $v_file_type == "JPEG" ];then
        cp $v_file $v_file_short\_original\.$v_file_type
        /usr/local/bin/gm convert -quality 30 $v_file $v_file
        echo "/usr/local/bin/gm convert -quality 30 $v_file $v_file" >> /tmp/resize.log
        fi

        if [ $v_file_type == "jpeg" ];then
        cp $v_file $v_file_short\_original\.$v_file_type
        /usr/local/bin/gm convert -quality 30 $v_file $v_file
        echo "/usr/local/bin/gm convert -quality 30 $v_file $v_file" >> /tmp/resize.log
        fi

        
        if [ $v_file_type == "jpg" ];then
        cp $v_file $v_file_short\_original\.$v_file_type
        /usr/local/bin/gm convert -quality 30 $v_file $v_file
        echo "/usr/local/bin/gm convert -quality 30 $v_file $v_file" >> /tmp/resize.log
        fi

        if [ $v_file_type == "JPG" ];then
        cp $v_file $v_file_short\_original\.$v_file_type
        /usr/local/bin/gm convert -quality 30 $v_file $v_file
        echo "/usr/local/bin/gm convert -quality 30 $v_file $v_file" >> /tmp/resize.log
        fi



    
        if [ $v_file_type == "gif" ];then
        cp $v_file $v_file_short\_original\.$v_file_type
        /usr/bin/convert $v_file -fuzz 8% -layers optimize $v_file
        echo "convert $v_file -fuzz 8% -layers optimize $v_file" >> /tmp/resize.log
        fi

        wide=`gm identify -format " %w %h" $v_file |awk '{print $1}'`
        high=`gm identify -format " %w %h" $v_file |awk '{print $2}'`

        if [ $wide -gt 1080 ];then
             newhigh=$(((($high * 1080))/$wide))
             gm convert $v_file -thumbnail "1080x$newhigh" $v_file
        fi


        
        else
        echo 'this is not 0' >> /tmp/resize.log
    fi
done

rq=`date "+%Y%m%d"`
cat /tmp/resize_pic.log >> /tmp/resize_pic_$rq\.log


