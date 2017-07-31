### install
	进入docker目录
	docker build -t  fastdfs:dev .
	如果比较慢可以换一下网易的源
	docker pull hub.c.163.com/qieangel2013/ngx-fastdfs:latest
### 使用
	docker run --net=host -idt -p 80:80 fastdfs:dev '/etc/rc.local'
### 测试
	进入容器执行test目录下的./test.sh或者直接执行下面脚本
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
### php调用
 	首先进入php_client
	./configure --with-php-config=/usr/local/php/bin/php-config
	make&&make install
	在php.ini里添加
	extension=fastdfs_client.so
	[fastdfs_client]
	fastdfs_client.base_path = /home/fastdfs/fastdfs
	fastdfs_client.connect_timeout = 2
	fastdfs_client.network_timeout = 60
	fastdfs_client.log_level = info
	fastdfs_client.log_filename =
	fastdfs_client.tracker_group_count = 1
	fastdfs_client.tracker_group0 = /etc/fdfs/client.conf
	fastdfs_client.use_connection_pool = true
	fastdfs_client.connection_pool_max_idle_time = 3600
	根据自己的情况做相应的修改
	重启php-fpm
	执行test目录下的fastdfs.php就可以看到效果了
### 使用效果
![](https://github.com/qieangel2013/ngx-fastdfs/blob/master/images/cut.png)
### 自动压缩
	自动压缩采用减少图片质量来达到减小图片体积的效果
	使用方法是把nginx里的nginxauto.conf替换原有的或者自己按着该文件修改
	把lua里的thumbnailauto.lua文件替换原有的或者自己按着该文件修改
	注意：fastdfs的storage的配置/etc/fdfs/storage.conf中run_by_group和run_by_user，最好跟nginx的用户组配置一样
### liveim是一款直播平台，内置im聊天功能
	由于未开源，需要授权可以获取源代码
http://www.weivq.com:88/ (演示地址)<br/>
http://www.weivq.com:88/public/uploads/LiveIm.apk (安卓演示)
![](https://github.com/qieangel2013/yaf/blob/master/public/images/jt.png)
![](https://github.com/qieangel2013/yaf/blob/master/public/images/jtmobile.png)
### 交流使用
	交流群：337937322
### 如果你对我的辛勤劳动给予肯定，请给我捐赠，你的捐赠是我最大的动力
![](https://github.com/qieangel2013/zys/blob/master/public/images/pay.png)
[项目捐赠列表](https://github.com/qieangel2013/zys/wiki/%E9%A1%B9%E7%9B%AE%E6%8D%90%E8%B5%A0)
