FROM labiomed/centos7-systemd:base
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

ONBUILD ARG USERNAME
ONBUILD ENV USERNAME="$USERNAME" UID="1024"
ONBUILD RUN useradd -u $UID -d /home/$USERNAME -m -s /bin/bash $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME
