FROM local/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

# Install various web applications and php.
RUN yum -y install\
 MariaDB-client\
 wget\
 patch\
 tar\
 bzip2\
 unzip\
 openssh-clients\
 rsync &&\
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
 yum clean all &&\
 rm -rf /tmp/yum*

RUN cp /etc/php-fpm.conf /etc/php-fpm.conf.original &&\
 mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.original
COPY container /

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN systemctl enable php-fpm.service

EXPOSE 9000

# It seems we need these volumes for php-fpm to work okay.
VOLUME ["/tmp"]

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" UID="$UID"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME /var/log/php-fpm /usr/local/bin/composer

ONBUILD RUN printf "$(cat /etc/php-fpm.d/pool.conf.template)"\
 "$USERNAME"\
 "$USERNAME"\
 "$USERNAME"\
 > /etc/php-fpm.d/$USERNAME.conf
