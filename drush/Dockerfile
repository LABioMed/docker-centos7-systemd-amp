FROM labiomed/centos7-systemd-amp:php-base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV DRUSH_VERSION 8.1.2

RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" &&\
 chmod +x /usr/local/bin/drush

COPY container /

ONBUILD ARG USERNAME
ONBUILD ARG UID
ONBUILD ARG DOMAINNAME
ONBUILD ARG PORT
ONBUILD ENV USERNAME="$USERNAME" UID="$UID" DOMAINNAME="$DOMAINNAME" PORT="$PORT"
ONBUILD RUN useradd -d /home/$USERNAME -m -s /bin/bash --uid $UID $USERNAME &&\
 echo "$USERNAME":"$USERNAME" | chpasswd &&\
 mkdir -p /home/$USERNAME &&\
 chown $USERNAME:$USERNAME /home/$USERNAME /usr/local/bin/composer

ONBUILD RUN printf "$(cat /etc/drush/site-aliases/aliases.drushrc.php)"\
 "$USERNAME"\
 "$USERNAME"\
 "$PORT"\
 "$DOMAINNAME"\
 > /etc/drush/site-aliases/aliases.drushrc.php &&\
 drush core-status -y &&\
 drush init -y

ONBUILD USER $USERNAME
ONBUILD RUN drush init -y
