#centos
# Version 0.1

FROM qieangel2013d/centos:latest

MAINTAINER 904208360@qq.com

RUN yum -y update && yum install -y httpd

CMD ["/etc/init.d/httpd start", "-D", "FOREGROUND"]
