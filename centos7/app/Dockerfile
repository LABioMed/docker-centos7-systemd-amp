FROM labiomed/centos7-systemd:base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

COPY generate-plain-environment-file /usr/local/bin/
ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ENV USERNAME="$USERNAME" UID="$UID"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 chown $USERNAME:$USERNAME /home/$USERNAME &&\
 chmod 755 /home/$USERNAME

# This is really just sort of an empty dockerfile for consistency, we are doing everything in another image.
