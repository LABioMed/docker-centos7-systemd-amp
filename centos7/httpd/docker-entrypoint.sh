#!/bin/bash

set -e
set -u

chown $USERNAME:USERNAME /var/www/$USERNAME

# Execute the systemd command from base image.
exec "/usr/lib/systemd/systemd"