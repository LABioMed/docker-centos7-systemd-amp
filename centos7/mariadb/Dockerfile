FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV VOLUME_HOME=/var/lib/mysql

RUN yum -y install\
 epel-release &&\
 rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB &&\
 yum -y install\
 MariaDB-server\
 MariaDB-client\
 hostname\
 net-tools\
 pwgen\
 expect &&\
 yum clean all &&\
 rm -rf /tmp/yum* &&\
 rm -rf /var/lib/mysql/* &&\
 mkdir /docker-entrypoint-initdb.d\
 /var/log/mysql/

RUN systemctl enable mariadb.service

COPY container /

# Set TERM env to avoid mysql client error message "TERM environment variable not set" when running from inside the container
ENV TERM xterm

EXPOSE 3306

# Use a custom entrypoint that does other customization to MariaDB.
ENTRYPOINT ["docker-entrypoint.sh"]
