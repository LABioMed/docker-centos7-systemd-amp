FROM labiomed/centos7-systemd
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum -y clean all &&\
 rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm &&\
 rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm &&\
 yum -y install\
 httpd &&\
 yum clean all &&\
 systemctl enable httpd.service

COPY app/00-base.conf /etc/httpd/conf.modules.d/

EXPOSE 80
ONBUILD ARG HTTPD_USER
ONBUILD ENV HTTPD_USER="$HTTPD_USER"

<<<<<<< HEAD
ONBUILD RUN /docker-onbuild.sh CMD ["/usr/sbin/init"]
=======
ONBUILD RUN /docker-onbuild.sh
CMD ["/usr/sbin/init"]
>>>>>>> origin/master
