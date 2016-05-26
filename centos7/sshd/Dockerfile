FROM labiomed/centos7-systemd
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum clean all &&\
 yum -y install\
 openssh-server\
 openssh-clients\
 passwd &&\
 yum clean all &&\
 mkdir -p /var/run/sshd &&\
 ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' &&\
 ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' &&\
 echo 'OPTIONS="-o UseDNS=no -o UsePAM=no -o PasswordAuthentication=yes"' >> /etc/sysconfig/sshd &&\
 systemctl enable sshd.service
COPY .ssh/sshkey.pub /home/$USERNAME/.ssh/authorized_keys
RUN chown $USERNAME:$USERNAME /home/$USERNAME/.ssh -R

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
