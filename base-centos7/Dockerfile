FROM centos:centos7
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

COPY container /

RUN chmod 755 /etc/profile.d/environment.sh

# Make official MariaDB repo available on all images.
ENV MARIADB_MAJOR=10.1
RUN printf "$(cat /etc/yum.repos.d/MariaDB.repo)"\
 "$MARIADB_MAJOR"\
 "$MARIADB_MAJOR"\
 > /etc/yum.repos.d/MariaDB.repo &&\
 rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
