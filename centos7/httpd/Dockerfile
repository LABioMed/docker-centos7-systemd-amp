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

RUN mkdir -p /usr/lib/systemd/system/httpd.service.d &&\
 printf "[Service]\n\
EnvironmentFile=/etc/environment\n"\
 > /usr/lib/systemd/system/httpd.service.d/environment.conf

COPY app/00-base.conf /etc/httpd/conf.modules.d/

EXPOSE 80
ONBUILD ARG HTTPD_USER
ONBUILD ENV HTTPD_USER="$HTTPD_USER"
ONBUILD RUN if [ ! -z "$HTTPD_USER" ]; then\
 sed -i "s@\("^User" * *\).*@\1$HTTPD_USER@" /etc/httpd/conf/httpd.conf &&\
 sed -i "s@\("^Group" * *\).*@\1$HTTPD_USER@" /etc/httpd/conf/httpd.conf &&\
 chgrp $SITENAME /var/log/httpd &&\
 chmod g+rx /var/log/httpd;\
fi

CMD ["/usr/sbin/init"]
