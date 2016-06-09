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
ONBUILD ARG AUTHORIZED_KEYS
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" AUTHORIZED_KEYS="$AUTHORIZED_KEYS" UID="$UID"

ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 chmod 755 /home/$USERNAME
ONBUILD COPY $AUTHORIZED_KEYS /home/$USERNAME/.ssh/authorized_keys
ONBUILD RUN chmod 700 /home/$USERNAME/.ssh/ &&\
 chmod 600 /home/$USERNAME/.ssh/authorized_keys &&\
 chown $USERNAME:$USERNAME /home/$USERNAME -R
