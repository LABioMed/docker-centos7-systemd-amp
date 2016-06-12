FROM labiomed/centos7-systemd-amp:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV MARIADB_MAJOR=10.1
ENV VOLUME_HOME=/var/lib/mysql

RUN yum -y install\
 epel-release &&\
 yum -y install\
 MariaDB-server\
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

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ONBUILD ARG MARIADB_ROOT_PASS
ONBUILD ARG MARIADB_DATABASE
ONBUILD ARG MARIADB_USER
ONBUILD ARG MARIADB_PASS
ONBUILD ENV MARIADB_ROOT_PASS="$MARIADB_ROOT_PASS"\
 MARIADB_DATABASE="$MARIADB_DATABASE"\
 MARIADB_USER="$MARIADB_USER"\
 MARIADB_PASS="$MARIADB_PASS"

# Use a custom entrypoint that does other customization to MariaDB.
ENTRYPOINT ["docker-entrypoint.sh"]
