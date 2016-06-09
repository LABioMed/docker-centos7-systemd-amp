FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum -y clean all &&\
 rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm &&\
 rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm &&\
 yum -y install\
 httpd &&\
 yum clean all &&\
 rm -rf /tmp/yum*

RUN cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.original &&\

# Logging all goes to our httpd logs.
RUN ln -sf /dev/stdout /var/log/httpd/access.log &&\
 ln -sf /dev/stderr /var/log/httpd/error.log
COPY container /

RUN systemctl enable httpd.service

EXPOSE 80

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ARG DOMAINNAME
ONBUILD ARG PHPFPMSERVER
ONBUILD ENV USERNAME="$USERNAME" UID="$UID" DOMAINNAME="$DOMAINNAME" PHPFPMSERVER="$PHPFPMSERVER"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME /var/www/$USERNAME/logs &&\
 chown $USERNAME:$USERNAME /home/$USERNAME &&\
 chgrp $USERNAME /var/log/httpd &&\
 chmod g+rx /var/log/httpd

# Replace the httpd.conf with our own, we then use virtualhost files in sub-images.
ONBUILD RUN printf "$(cat /etc/httpd/conf/httpd.conf)"\
 "$USERNAME"\
 "$USERNAME"\
 "$DOMAINNAME"\
 > /etc/httpd/conf/httpd.conf &&\
 printf "$(cat /etc/httpd/sites-available/vhost.conf.template)"\
 "$DOMAINNAME"\
 "$USERNAME"\
 "$DOMAINNAME"\
 "$PHPFPMSERVER"\
 > /etc/httpd/sites-available/$DOMAINNAME.conf &&\
 ln -s ../sites-available/$DOMAINNAME.conf /etc/httpd/sites-enabled/$DOMAINNAME.conf &&\
 printf "$(cat /etc/httpd/conf.d/php-fpm.conf)"\
 "$PHPFPMSERVER"\
 > /etc/httpd/conf.d/php-fpm.conf
