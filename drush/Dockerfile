FROM quay.io/labiomed/centos7-systemd-amp:php-base
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV DRUSH_VERSION 8.1.2

RUN yum -y install\
 git

RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" &&\
 curl -fsSL -o /usr/local/bin/drupal "https://drupalconsole.com/installer" &&\
 chmod +x /usr/local/bin/drush &&\
 chmod +x /usr/local/bin/drupal

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

ONBUILD RUN printf "$(cat /usr/lib/systemd/system/drush-cron.service)"\
 "$DOMAINNAME"\
 "$USERNAME"\
 "$USERNAME"\
 > /usr/lib/systemd/system/drush-cron.service &&\
 printf "$(cat /usr/lib/systemd/system/drush-cron.timer)"\
 "$DOMAINNAME"\
 > /usr/lib/systemd/system/drush-cron.timer &&\
 systemctl enable drush-cron.timer &&\
 systemctl enable drush-cron
