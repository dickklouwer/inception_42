#!/bin/bash

# Check if it's the first run
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB for the first time..."

    # Setting up directory permissions
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
    chown -R mysql:mysql /var/lib/mysql

    # Initialize MariaDB
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Setting up initial databases and users
    cat << EOF > /tmp/init.sql
        USE mysql;
        SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PWD');
        FLUSH PRIVILEGES;

        CREATE DATABASE IF NOT EXISTS $DB_NAME;
        
        CREATE USER '$WP_USER1'@'%' IDENTIFIED BY '$WP_PWD1';
        GRANT ALL ON $DB_NAME.* to '$WP_USER1'@'%';
        FLUSH PRIVILEGES;
        
        CREATE USER '$WP_USER2'@'%';
        SET PASSWORD FOR '$WP_USER2'@'%' = PASSWORD('$WP_PWD2');
        GRANT ALL PRIVILEGES ON $DB_NAME.* to '$WP_USER2'@'%';
        GRANT GRANT OPTION ON $DB_NAME.* TO '$WP_USER2'@'%';
        FLUSH PRIVILEGES;
EOF

    # Execute SQL script
    mysqld --user=mysql --bootstrap < /tmp/init.sql
fi

# Start MariaDB
exec mysqld --user=mysql --console

