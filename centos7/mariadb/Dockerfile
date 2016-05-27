FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV MARIADB_MAJOR=10.1

RUN printf "# MariaDB 10.1 CentOS repository list - created 2015-11-30 13:13 UTC\n\
# http://mariadb.org/mariadb/repositories/\n\
[mariadb]\n\
name = MariaDB\n\
baseurl = http://yum.mariadb.org/10.1/centos7-amd64\n\
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\n\
gpgcheck=1"\
 >> /etc/yum.repos.d/MariaDB.repo

RUN yum -y update &&\
 yum clean all &&\
 rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB &&\
 yum -y install\
 MariaDB-server\
 MariaDB-client &&\
 yum clean all &&\
 mkdir /docker-entrypoint-initdb.d &&\
 systemctl enable mariadb

COPY server.cnf /etc/my.cnf.d/server.cnf
COPY docker-onbuild.sh /docker-onbuild.sh

EXPOSE 3306
ONBUILD ARG MYSQL_ROOT_PASSWORD
ONBUILD ARG MYSQL_DATABASE
ONBUILD ARG MYSQL_USER
ONBUILD ARG MYSQL_PASSWORD
ONBUILD ENV MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD"\
 MYSQL_DATABASE="$MYSQL_DATABASE"\
 MYSQL_USER="$MYSQL_USER"\
 MYSQL_PASSWORD="$MYSQL_PASSWORD"

ONBUILD RUN /docker-onbuild.sh

CMD ["/usr/sbin/init"]
