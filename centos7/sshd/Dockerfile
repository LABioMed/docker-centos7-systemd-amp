FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum clean all &&\
 yum -y install\
 openssh-server\
 passwd &&\
 yum clean all &&\
 mkdir /var/run/sshd &&\
 ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' &&\
 systemctl enable sshd.service

EXPOSE 22
ONBUILD ARG USERNAME
ONBUILD ARG KEYFILE
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" KEYFILE="$KEYFILE" UID="$UID"

ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 chmod 755 /home/$USERNAME
ONBUILD USER $USERNAME
ONBUILD COPY $KEYFILE /home/$USERNAME/.ssh/
ONBUILD USER root
ONBUILD RUN ls -la /home/$USERNAME/.ssh &&\
 chown $USERNAME:$USERNAME /home/$USERNAME -R &&\
 chmod 700 /home/$USERNAME/.ssh