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

# Swap out fake systemd for real systemd and add dbus.
ENV container docker
RUN yum -y update &&\
 yum clean all &&\
 yum -y swap\
 -- remove\
 systemd-container\
 systemd-container-libs\
 -- install\
 systemd\
 systemd-libs\
 dbus

# Run some systemctl mask'ing.
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

# Add a dbus service for systemd so we don't get dbus errors.
RUN systemctl enable dbus.service

# These volumes are required to be able to run systemctl commands.
VOLUME ["/sys/fs/cgroup", "/run"]

CMD ["/usr/lib/systemd/systemd"]
