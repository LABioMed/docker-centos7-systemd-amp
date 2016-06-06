FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

RUN mkdir -p /etc/httpd/sites-available /etc/httpd/sites-enabled

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" UID="$UID"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 chown $USERNAME:$USERNAME /home/$USERNAME &&\
 chmod 755 /home/$USERNAME

# This is really just sort of an empty dockerfile for consistency, we are doing everything in another image.
