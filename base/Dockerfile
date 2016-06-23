FROM quay.io/labiomed/centos7-systemd-amp:base-centos7
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

COPY container /

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
 systemd-libs &&\
 yum -y install\
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
