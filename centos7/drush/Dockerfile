FROM labiomed/centos7-systemd:php-fpm
MAINTAINER Nicholas Alipaz <nalipaz@labiomed.org>

ENV DRUSH_VERSION 8.1.2

ARG DOMAINNAME
ARG PORT

RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" &&\
 chmod +x /usr/local/bin/drush

COPY container /
RUN printf "$(cat /etc/drush/site-aliases/aliases.drushrc.php)"\
 "$USERNAME"\
 "$USERNAME"\
 "$PORT"\
 "$DOMAINNAME"\
 > /etc/drush/site-aliases/aliases.drushrc.php &&\
 drush core-status -y &&\
 drush init -y

USER $USERNAME
RUN drush init -y

USER root
