FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV MARIADB_MAJOR=10.1
RUN printf "# MariaDB %s CentOS repository list\n"\
"# http://mariadb.org/mariadb/repositories/\n"\
"[mariadb]\n"\
"name = MariaDB\n"\
"baseurl = http://yum.mariadb.org/%s/centos7-amd64\n"\
"gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\n"\
"gpgcheck=1\n"\
 "$MARIADB_MAJOR"\
 "$MARIADB_MAJOR"\
 >> /etc/yum.repos.d/MariaDB.repo

RUN yum -y update &&\
 yum clean all &&\
 yum -y install\
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
 yum clean all

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mv /etc/php-fpm.conf /etc/php-fpm.conf-backup &&\
printf "include=/etc/php-fpm.d/*.conf\n"\
"\n"\
"[global]\n"\
"daemonize = no\n"\
"pid = /var/run/php-fpm.pid\n"\
"error_log = /var/log/php-fpm/daemon.log\n"\
"log_level = warning\n"\
"clear_env = no\n"\
 >> /etc/php-fpm.conf

# Make environment variables get sourced and passed to php-fpm.
RUN touch /etc/php.d/zz-variables.ini &&\
 printf "variables_order = 'EGPCS'\n"\
"date.timezone = 'America/Los_Angeles'\n"\
 >> /etc/php.d/zz-variables.ini &&\
 mkdir -p /usr/lib/systemd/system/php-fpm.service.d &&\
 printf "[Service]\n"\
"EnvironmentFile=/etc/profile.d/environment-variables.sh\n"\
 > /usr/lib/systemd/system/php-fpm.service.d/environment.conf

RUN systemctl enable php-fpm.service &&\
 yum clean all &&\
 rm -rf /tmp/yum*

EXPOSE 9000

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" UID="$UID"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME /var/log/php-fpm /usr/local/bin/composer
