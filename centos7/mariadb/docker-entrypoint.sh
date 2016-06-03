#!/bin/bash

VOLUME_HOME="/var/lib/mysql"
echo >&2 "out"
if [[ ! -d $VOLUME_HOME/mysql ]]; then
  echo >&2 "in"
  if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
    echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
    echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
    exit 1
  fi

  echo >&2 'Initializing database'
  mysql_install_db --datadir="$VOLUME_HOME"
  echo >&2 'Database initialized'

  mysql=( mysqld_safe --protocol=socket -uroot )
  RET=1
  while [[ RET -ne 0 ]]; do
    echo >&2 "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    "${mysql[@]}" -e "status" > /dev/null 2>&1
    RET=$?
  done

  echo "SET @@SESSION.SQL_LOG_BIN=0;" | "${mysql[@]}"
  echo "DELETE FROM mysql.user ;" | "${mysql[@]}"
  echo "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" | "${mysql[@]}"
  echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" | "${mysql[@]}"
  echo "DROP DATABASE IF EXISTS test ;" | "${mysql[@]}"
  echo "FLUSH PRIVILEGES ;" | "${mysql[@]}"


    if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
        mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
    fi

    if [ "$MYSQL_DATABASE" ]; then
        echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
        mysql+=( "$MYSQL_DATABASE" )
    fi

    if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
        echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | "${mysql[@]}"

        if [ "$MYSQL_DATABASE" ]; then
            echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
        fi

        echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
    fi

    ls -la /docker-entrypoint-initdb.d/
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)     echo >&2 "$0: running $f"; . "$f" ;;
            *.sql)    echo >&2 "$0: running $f"; "${mysql[@]}" < "$f" && echo ;;
            *.sql.gz) echo >&2 "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
            *)        echo >&2 "$0: ignoring $f" ;;
        esac
    done

    echo >&2
    echo >&2 'MySQL init process done. Ready for start up.'
    echo >&2
fi

chown -R mysql:mysql "$VOLUME_HOME"

mysql=("${mysql[@]:1}")
mysqladmin ${mysql[@]} shutdown

exec "/usr/lib/systemd/systemd"