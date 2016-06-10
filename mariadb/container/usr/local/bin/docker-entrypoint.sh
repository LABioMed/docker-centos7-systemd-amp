#!/bin/bash

set -e
set -u
cd /usr/local/bin/
source mariadb-functions.sh

ERROR_LOG="$VOLUME_HOME/error.log"
MYSQLD_PID_FILE="$VOLUME_HOME/mysql.pid"

# Trap INT and TERM signals to do clean DB shutdown
#trap terminate_db SIGINT SIGTERM

install_db

/usr/bin/mysqld_safe & # Launch DB server in the background
MYSQLD_SAFE_PID=$!

wait_for_db
show_db_status
create_db_user
import_db_files
secure_and_tidy_db
terminate_db

# Execute the systemd command from base image.
exec "/usr/lib/systemd/systemd"
