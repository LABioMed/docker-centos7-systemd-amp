FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV MARIADB_MAJOR=10.1
ENV VOLUME_HOME=/var/lib/mysql

RUN printf "# MariaDB %s CentOS repository list\n\
# http://mariadb.org/mariadb/repositories/\n\
[mariadb]\n\
name = MariaDB\n\
baseurl = http://yum.mariadb.org/%s/centos7-amd64\n\
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\n\
gpgcheck=1\n"\
 "$MARIADB_MAJOR"\
 "$MARIADB_MAJOR"\
 >> /etc/yum.repos.d/MariaDB.repo

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

# Set TERM env to avoid mysql client error message "TERM environment variable not set" when running from inside the container
ENV TERM xterm

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
