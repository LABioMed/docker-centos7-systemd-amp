#!/bin/bash

# Setup httpd.service with a Service entry to load up Environment
#   variables by adding another EnvironmentFile directive.
mkdir -p /usr/lib/systemd/system/httpd.service.d
printf "[Service]\n\
EnvironmentFile=/etc/environment\n"\
 > /usr/lib/systemd/system/httpd.service.d/environment.conf

# Set the apache user/group to run as.
if [ ! -z "$HTTPD_USER" ]; then
  sed -i "s@\("^User" * *\).*@\1$HTTPD_USER@" /etc/httpd/conf/httpd.conf &&\
  sed -i "s@\("^Group" * *\).*@\1$HTTPD_USER@" /etc/httpd/conf/httpd.conf &&\
  chgrp $SITENAME /var/log/httpd &&\
  chmod g+rx /var/log/httpd
fi
