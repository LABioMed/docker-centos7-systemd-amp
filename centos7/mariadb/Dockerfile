FROM labiomed/centos7-systemd
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
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/init"]
