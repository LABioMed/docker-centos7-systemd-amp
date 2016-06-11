FROM labiomed/centos7-systemd-amp:php-base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

# Install various web applications and php.
RUN yum -y install\
 php-fpm &&\
 yum clean all &&\
 rm -rf /tmp/yum*

RUN cp /etc/php-fpm.conf /etc/php-fpm.conf.original &&\
 mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.original

COPY container /

RUN systemctl enable php-fpm.service

EXPOSE 9000

# It seems we need these volumes for php-fpm to work okay.
VOLUME ["/tmp"]

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" UID="$UID"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME\
 /var/log/php-fpm &&\
 chown $USERNAME:$USERNAME /home/$USERNAME /var/log/php-fpm /usr/local/bin/composer &&\
 chgrp $USERNAME /var/log/php-fpm

ONBUILD RUN printf "$(cat /etc/php-fpm.d/pool.conf.template)"\
 "$USERNAME"\
 "$USERNAME"\
 "$USERNAME"\
 > /etc/php-fpm.d/$USERNAME.conf
