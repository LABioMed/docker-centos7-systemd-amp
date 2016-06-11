FROM labiomed/centos7-systemd-amp:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

# Install various web applications and php.
RUN yum -y install\
 bzip2\
 MariaDB-client\
 openssh-clients\
 patch\
 rsync\
 tar\
 unzip\
 wget\
 which &&\
 yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm &&\
 sed -i '0,/enabled=0/{s//enabled=1/}' /etc/yum.repos.d/remi.repo &&\
 sed -i '0,/enabled=0/{s//enabled=1/}' /etc/yum.repos.d/remi.repo &&\
 yum -y install\
 php-bcmath\
 php-cli\
 php-gd\
 php-ldap\
 php-mbstring\
 php-mcrypt\
 php-mysql\
 php-opcache\
 php-pecl-redis\
 php-pdo\
 php-pgsql\
 php-process\
 php-tidy\
 php-xml &&\
 yum clean all &&\
 rm -rf /tmp/yum*

COPY container /

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
 echo "export PATH=~/.composer/vendor/bin:\$PATH" >> ~/.bash_profile
