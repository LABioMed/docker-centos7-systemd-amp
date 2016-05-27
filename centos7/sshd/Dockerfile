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
ONBUILD ENV USERNAME="$USERNAME" KEYFILE="$KEYFILE"

ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME/.ssh &&\
 chmod 700 /home/$USERNAME/.ssh
ONBUILD COPY $KEYFILE /home/$USERNAME/.ssh/authorized_keys
ONBUILD RUN chown $USERNAME:$USERNAME /home/$USERNAME/.ssh -R

CMD ["/usr/sbin/init"]
