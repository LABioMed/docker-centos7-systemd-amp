FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV MARIADB_MAJOR=10.1
ENV VOLUME_HOME=/var/lib/mysql

RUN yum -y update &&\
 yum clean all &&\
 yum -y install\
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
 rm -rf /var/lib/mysql/* &&\
 mkdir /docker-entrypoint-initdb.d\
 /var/log/mysql/

RUN systemctl enable mariadb.service

COPY my.cnf.d/* /etc/my.cnf.d/
COPY docker-entrypoint.sh /usr/local/bin/
COPY mariadb-functions.sh /

ONBUILD ARG MARIADB_ROOT_PASS
ONBUILD ARG MARIADB_DATABASE
ONBUILD ARG MARIADB_USER
ONBUILD ARG MARIADB_PASS
ONBUILD ENV MARIADB_ROOT_PASS="$MARIADB_ROOT_PASS"\
 MARIADB_DATABASE="$MARIADB_DATABASE"\
 MARIADB_USER="$MARIADB_USER"\
 MARIADB_PASS="$MARIADB_PASS"
ONBUILD RUN /mariadb-setup.sh &&\
 yum -y remove expect &&\
 yum clean all

# Set TERM env to avoid mysql client error message "TERM environment variable not set" when running from inside the container
ENV TERM xterm

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]