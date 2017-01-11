###install
        docker build -t  fastdfs:dev .
###使用
        docker -idt -p 80:80 fastdfs:dev /bin/bash
        进入容器执行
        /etc/rc.local
###测试
        fdfs_test /etc/fdfs/client.conf upload /home/steven/01.jpg
        ...
        group_name=group1, ip_addr=192.168.1.181, port=23000
        storage_upload_by_filename
        group_name=group1, remote_filename=M00/00/00/wKgdhFTV0ZmAP3AZAPk-Io7D4w8580.jpg
        ...
        example file url: http://192.168.1.181/group1/M00/00/00/wKgdhFTV0ZmAP3AZAPk-Io7D4w8580.jpg
        storage_upload_slave_by_filename
        group_name=group1, remote_filename=M00/00/00/wKgdhFTV0ZmAP3AZAPk-Io7D4w8580_big.jpg
        ...
        example file url: http://192.168.1.181/group1/M00/00/00/wKgdhFTV0ZmAP3AZAPk-Io7D4w8580_big.jpg
    
