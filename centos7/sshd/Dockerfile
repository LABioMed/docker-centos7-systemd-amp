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

#RUN sed -i 's@GSSAPIAuthentication yes@#GSSAPIAuthentication yes@' /etc/ssh/sshd_config &&\
# sed -i 's@GSSAPICleanupCredentials no@#GSSAPICleanupCredentials no@' /etc/ssh/sshd_config &&\
# sed -i 's@UsePrivilegeSeparation sandbox.*@UsePrivilegeSeparation no@' /etc/ssh/sshd_config &&\
# sed -i 's@#UseDNS yes@UseDNS no@' /etc/ssh/sshd_config &&\
# sed -i 's@#Port 22@Port 22@' /etc/ssh/sshd_config &&\
# sed -i 's@#Protocol 2@Protocol 2@' /etc/ssh/sshd_config &&\
# sed -i 's@#LoginGraceTime 2m@LoginGraceTime 2m@' /etc/ssh/sshd_config &&\
# sed -i 's@#PermitRootLogin yes@PermitRootLogin no@' /etc/ssh/sshd_config &&\
# sed -i 's@#StrictModes yes@StrictModes yes@' /etc/ssh/sshd_config &&\
# sed -i 's@#RSAAuthentication yes@RSAAuthentication yes@' /etc/ssh/sshd_config &&\
# sed -i 's@#PubkeyAuthentication yes@PubkeyAuthentication yes@' /etc/ssh/sshd_config &&\
# sed -i 's@PasswordAuthentication yes@PasswordAuthentication no@' /etc/ssh/sshd_config

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
