#!/bin/sh

#########################################################
# Check in the loop (every 1s) if the database backend
#   service is already available for connections.
# Globals:
#   $ERROR_LOG
#########################################################
function wait_for_db() {
  set +e

  echo "Waiting for DB service..."
  while true; do
    if grep "ready for connections" ${ERROR_LOG}; then
      break;
    else
      echo "Still waiting for DB service..." && sleep 1
    fi
  done

  set -e
}

#########################################################
# Check in the loop (every 1s) if the database backend
#   service is already available for connections.
# Globals:
#   $VOLUME_HOME
#   $ERROR_LOG
#########################################################
function terminate_db() {
  local pid=$(cat ${VOLUME_HOME}/mysql.pid)
  echo "Caught SIGTERM signal, shutting down DB..."
  kill -TERM ${pid}

  while true; do
    if tail ${ERROR_LOG} | grep -s -E "mysqld .+? ended" ${ERROR_LOG}; then break; else sleep 0.5; fi
  done
}

#########################################################
# Calls `mysql_install_db` if empty volume is detected.
# Globals:
#   $VOLUME_HOME
#   $ERROR_LOG
#########################################################
function install_db() {
  if [ ! -d ${VOLUME_HOME}/mysql ]; then
    echo "=> An empty/uninitialized MariaDB volume is detected in ${VOLUME_HOME}"
    echo "=> Installing MariaDB..."
    mysql_install_db --user=mysql > /dev/null 2>&1
    echo "=> Installing MariaDB... Done!"
  else
    echo "=> Using an existing volume of MariaDB."
  fi

  # Move previous error log (which might be there from previously running container
  # to different location. We do that to have error log from the currently running
  # container only.
  if [ -f ${ERROR_LOG} ]; then
    echo "----------------- Previous error log -----------------"
    tail -n 20 ${ERROR_LOG}
    echo "----------------- Previous error log ends -----------------" && echo
    mv -f ${ERROR_LOG} "${ERROR_LOG}.old";
  fi

  touch ${ERROR_LOG} && chown mysql ${ERROR_LOG}
}

#########################################################
# Check in the loop (every 1s) if the database backend
#   service is already available for connections.
# Globals:
#   $MARIADB_USER
#   $MARIADB_PASS
#########################################################
function create_db_user() {
  echo "Creating DB user..." && echo
  local users=$(mysql -s -e "SELECT count(User) FROM mysql.user WHERE User='${MARIADB_USER}'")
  if [[ ${users} == 0 ]]; then
    echo "=> Creating MariaDB user '${MARIADB_USER}' with '${MARIADB_PASS}' password."
    mysql -uroot -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}'"
  else
    echo "=> User '${MARIADB_USER}' exists, updating its password to '${MARIADB_PASS}'"
    mysql -uroot -e "SET PASSWORD FOR '${MARIADB_USER}'@'%' = PASSWORD('${MARIADB_PASS}')"
  fi;

  mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'%' WITH GRANT OPTION"

  echo "========================================================================"
  echo "    You can now connect to this MariaDB Server using:                   "
  echo "    mysql -u${MARIADB_USER} -p${MARIADB_PASS} -h<host>                      "
  echo "========================================================================"
}

#########################################################
# Output the current mysql database status.
#########################################################
function show_db_status() {
  echo "Showing DB status..." && echo
  mysql -uroot -e "status"
}

#########################################################
# Run mysql_secure_installation using expect to populate
#   the answers to all the questions.
# Globals:
#   $MARIADB_ROOT_PASS=
#########################################################
function secure_and_tidy_db() {
  SECURE_MYSQL=$(expect -c "
    set timeout 3
    spawn mysql_secure_installation

    expect \"Enter current password for root (enter for none):\"
    send \"\r\"

    expect \"Set root password? \[Y/n\]\"
    send \"y\r\"

    expect \"New password:\"
    send \"${MARIADB_ROOT_PASS}\r\"

    expect \"Re-enter new password:\"
    send \"${MARIADB_ROOT_PASS}\r\"

    expect \"Remove anonymous users? \[Y/n\]\"
    send \"y\r\"

    expect \"Disallow root login remotely? \[Y/n\]\"
    send \"n\r\"

    expect \"Remove test database and access to it? \[Y/n\]\"
    send \"y\r\"

    expect \"Reload privilege tables now? \[Y/n\]\"
    send \"y\r\"

    expect eof
  ")

  echo "${SECURE_MYSQL}"

  yum -y remove expect && yum clean all
}