FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd

# This is really just sort of an empty dockerfile for consistency, we are doing everything in another image.
