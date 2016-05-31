FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ONBUILD ARG USERNAME
ONBUILD ENV USERNAME="$USERNAME" UID="1024"
ONBUILD RUN useradd --UID $UID -d /home/$USERNAME -m -s /bin/bash $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd

# This is really just sort of an empty dockerfile for consistency, we are doing everything in another image.
