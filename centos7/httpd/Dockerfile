FROM labiomed/centos7-systemd:base
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
 printf "[Service]\n"\
"ExecStartPre=/usr/bin/bash -c \"/usr/local/bin/generate-plain-environment-file\"\n"\
"EnvironmentFile=/etc/profile.d/environment.env\n"\
 > /usr/lib/systemd/system/httpd.service.d/environment.conf

RUN mkdir -p /etc/httpd/sites-available /etc/httpd/sites-enabled
COPY 00-base.conf /etc/httpd/conf.modules.d/

EXPOSE 80

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ARG DOMAINNAME
ONBUILD ENV USERNAME="$USERNAME" UID="$UID" DOMAINNAME="$DOMAINNAME"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME &&\
 chgrp $USERNAME /var/log/httpd &&\
 chmod g+rx /var/log/httpd

# Replace the httpd.conf with our own, we then use virtualhost files in sub-images.
ONBUILD RUN mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf-backup &&\
 printf "ServerRoot \"/etc/httpd\"\n"\
"Listen 80\n"\
"Include conf.modules.d/*.conf\n"\
"User %s\n"\
"Group %s\n"\
"ServerAdmin root@%s\n"\
"<Directory />\n"\
"  AllowOverride none\n"\
"  Require all denied\n"\
"</Directory>\n"\
"<IfModule dir_module>\n"\
"  DirectoryIndex index.html\n"\
"</IfModule>\n"\
"<Files \".ht*\">\n"\
"  Require all denied\n"\
"</Files>\n"\
"ErrorLog \"logs/error_log\"\n"\
"LogLevel warn\n"\
"<IfModule log_config_module>\n"\
"  LogFormat \"%%h %%l %%u %%t \\\\\"%%r\\\\\" %%>s %%b \\\\\"%%{Referer}i\\\\\" \\\\\"%%{User-Agent}i\\\\\"\" combined\n"\
"  LogFormat \"%%h %%l %%u %%t \\\\\"%%r\\\\\" %%>s %%b\" common\n"\
"  <IfModule logio_module>\n"\
"    LogFormat \"%%h %%l %%u %%t \\\\\"%%r\\\\\" %%>s %%b \\\\\"%%{Referer}i\\\\\" \\\\\"%%{User-Agent}i\\\\\" %%I %%O\" combinedio\n"\
"  </IfModule>\n"\
"  CustomLog \"logs/access_log\" combined\n"\
"</IfModule>\n"\
"<IfModule mime_module>\n"\
"  TypesConfig /etc/mime.types\n"\
"  AddType application/x-compress .Z\n"\
"  AddType application/x-gzip .gz .tgz\n"\
"  AddType text/html .shtml\n"\
"  AddOutputFilter INCLUDES .shtml\n"\
"</IfModule>\n"\
"AddDefaultCharset UTF-8\n"\
"<IfModule mime_magic_module>\n"\
"  MIMEMagicFile conf/magic\n"\
"</IfModule>\n"\
"EnableSendfile on\n"\
"IncludeOptional conf.d/*.conf\n"\
"IncludeOptional sites-enabled/*.conf\n"\
 "$USERNAME"\
 "$USERNAME"\
 "$DOMAINNAME"\
 >> /etc/httpd/conf/httpd.conf
