FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ONBUILD ARG USERNAME
ONBUILD ENV USERNAME="$USERNAME" UID="1024"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid 1024 $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd

# This is really just sort of an empty dockerfile for consistency, we are doing everything in another image.
