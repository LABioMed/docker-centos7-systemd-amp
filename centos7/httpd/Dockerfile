FROM labiomed/centos7-systemd
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN yum -y update &&\
 yum -y clean all &&\
 rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm &&\
 rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm &&\
 yum -y install\
 httpd &&\
 yum clean all &&\
 systemctl enable httpd.service

RUN mkdir -p /usr/lib/systemd/system/httpd.service.d &&\
 printf "[Service]\n\
EnvironmentFile=/etc/profile.d/environment-variables\n"\
 > /usr/lib/systemd/system/httpd.service.d/environment.conf

COPY 00-base.conf /etc/httpd/conf.modules.d/

EXPOSE 80

ONBUILD ARG USERNAME
ONBUILD ENV USERNAME="$USERNAME"
ONBUILD RUN if [ ! -z "$USERNAME" ]; then\
 useradd -d /home/$USERNAME -m -s /bin/bash $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME &&\
 sed -i "s@\("^User" * *\).*@\1$USERNAME@" /etc/httpd/conf/httpd.conf &&\
 sed -i "s@\("^Group" * *\).*@\1$USERNAME@" /etc/httpd/conf/httpd.conf &&\
 chgrp $USERNAME /var/log/httpd &&\
 chmod g+rx /var/log/httpd;\
fi

CMD ["/usr/sbin/init"]
