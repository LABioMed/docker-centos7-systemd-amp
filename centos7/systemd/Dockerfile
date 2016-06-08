FROM centos:centos7
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

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

COPY generate-plain-environment-file /usr/local/bin/
ADD dbus.service /etc/systemd/system/dbus.service
RUN systemctl enable dbus.service

RUN touch /etc/profile.d/environment.env &&\
 touch /etc/profile.d/environment.sh &&\
 chmod 755 /etc/profile.d/environment.sh

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]
CMD ["/usr/lib/systemd/systemd"]
