#!/bin/bash

set -e
set -u
source ./mariadb-functions.sh

ERROR_LOG="$VOLUME_HOME/error.log"
MYSQLD_PID_FILE="$VOLUME_HOME/mysql.pid"

# Trap INT and TERM signals to do clean DB shutdown
trap terminate_db SIGINT SIGTERM

install_db
tail -F $ERROR_LOG & # tail all db logs to stdout

/usr/bin/mysqld_safe & # Launch DB server in the background
MYSQLD_SAFE_PID=$!

wait_for_db
show_db_status
create_db_user
secure_and_tidy_db
terminate_db