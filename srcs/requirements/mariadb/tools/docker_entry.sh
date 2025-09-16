#!/usr/bin/env bash

DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_user_password)

echo >> $DB_CONF_ROUTE
echo "[mysqld]" >> $DB_CONF_ROUTE
echo "bind-address=0.0.0.0" >> $DB_CONF_ROUTE

mysql_install_db --datadir=$DB_INSTALL

mysqld_safe &
mysql_pid=$!

until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

mysql -u root -e "CREATE DATABASE $DB_NAME;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    FLUSH PRIVILEGES;"

wait $mysql_pid
