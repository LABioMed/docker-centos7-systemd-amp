FROM labiomed/centos7-systemd
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum clean all &&\
 yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm &&\
 sed -i '0,/enabled=0/{s//enabled=1/}' /etc/yum.repos.d/remi.repo &&\
 sed -i '0,/enabled=0/{s//enabled=1/}' /etc/yum.repos.d/remi.repo &&\
 yum -y install\
 php-bcmath\
 php-cli\
 php-fpm\
 php-gd\
 php-ldap\
 php-mbstring\
 php-mcrypt\
 php-mysql\
 php-opcache\
 php-pdo\
 php-process\
 php-tidy\
 php-xml &&\
 yum clean all

RUN systemctl enable php-fpm.service

EXPOSE 9000

ONBUILD ARG PHP_USER
ONBUILD ENV PHP_USER="$PHP_USER"
ONBUILD RUN if [ ! -z "$PHP_USER" ]; then\
 usermod -u 1000 "$PHP_USER";\
fi

CMD ["/usr/sbin/init"]