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

RUN touch /etc/profile.d/environment-variables &&\
 chmod 755 /etc/profile.d/environment-variables

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/lib/systemd/systemd"]
