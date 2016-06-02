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

ONBUILD COPY $KEYFILE /tmp/authorized_keys
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME/.ssh &&\
 mv /tmp/authorized_keys /home/$USERNAME/.ssh/ &&\
 chmod 700 /home/$USERNAME/.ssh &&\
 chown $USERNAME:$USERNAME /home/$USERNAME/.ssh -R &&\
 chmod 600 /home/$USERNAME/.ssh/authorized_keys &&\
 mkdir /home/$USERNAME-copy &&\
 for i in /home/$USERNAME/; do mv $i /home/$USERNAME-copy/; done &&\
 rm -rf /home/$USERNAME &&\
 for i in /home/$USERNAME-copy/; do mv $i /home/$USERNAME/; done &&\
 rm -rf /home/$USERNAME-copy &&\
 chmod 755 /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME
