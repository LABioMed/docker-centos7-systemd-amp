FROM centos:centos7
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV container docker
RUN yum -y update &&\
 yum clean all &&\
 yum -y swap\
 --\
 remove systemd-container\
 systemd-container-libs\
 --\
 install\
 systemd\
 systemd-libs\
 initscripts\
 dbus

RUN systemctl mask\
 dev-mqueue.mount\
 dev-hugepages.mount\
 systemd-remount-fs.service\
 sys-kernel-config.mount\
 sys-kernel-debug.mount\
 sys-fs-fuse-connections.mount\
 display-manager.service\
 graphical.target\
 systemd-logind.service

ADD dbus.service /etc/systemd/system/dbus.service
RUN systemctl enable dbus.service

RUN touch /etc/profile.d/environment-variables.sh &&\
 chmod 755 /etc/profile.d/environment-variables.sh

RUN printf "# MariaDB 10.1 CentOS repository list - created 2015-11-30 13:13 UTC\n\
# http://mariadb.org/mariadb/repositories/\n\
[mariadb]\n\
name = MariaDB\n\
baseurl = http://yum.mariadb.org/10.1/centos7-amd64\n\
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\n\
gpgcheck=1\n"\
 >> /etc/yum.repos.d/MariaDB.repo

VOLUME ["/sys/fs/cgroup", "/run"]
CMD ["/usr/lib/systemd/systemd"]
