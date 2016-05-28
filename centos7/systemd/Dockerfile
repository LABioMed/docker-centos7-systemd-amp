FROM centos:centos7
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ONBUILD ENV container docker
ONBUILD RUN yum -y update &&\
 yum clean all &&\
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
 rm -f /lib/systemd/system/multi-user.target.wants/*;\
 rm -f /etc/systemd/system/*.wants/*;\
 rm -f /lib/systemd/system/local-fs.target.wants/*; \
 rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
 rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
 rm -f /lib/systemd/system/basic.target.wants/*;\
 rm -f /lib/systemd/system/anaconda.target.wants/*;

ONBUILD RUN touch /etc/profile.d/environment-variables &&\
 chmod 755 /etc/profile.d/environment-variables

ONBUILD VOLUME ["/sys/fs/cgroup", "/run", "/tmp"]

