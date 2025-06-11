#!/bin/bash

MOODLE_DB_NAME=${MOODLE_DB_NAME:-moodle}
MOODLE_DB_USER=${MOODLE_DB_USER:-moodleuser}
MOODLE_DB_PASSWORD=${MOODLE_DB_PASSWORD:-moodlepass}
MOODLE_ADMIN_PASSWORD=${MOODLE_ADMIN_PASSWORD:-admin123}

# Start MariaDB manually in background
mysqld_safe &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    echo "Waiting for database server to start..."
    sleep 2
done

# Create DB and user if not already done
mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $MOODLE_DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$MOODLE_DB_USER'@'localhost' IDENTIFIED BY '$MOODLE_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $MOODLE_DB_NAME.* TO '$MOODLE_DB_USER'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Install Moodle if not already installed
if [ ! -f /var/www/html/moodle/config.php ]; then
    sudo -u www-data /usr/bin/php /var/www/html/moodle/admin/cli/install.php \
        --non-interactive \
        --lang=en \
        --wwwroot=http://localhost:8080/moodle \
        --dataroot=/var/www/moodledata \
        --dbtype=mariadb \
        --dbhost=localhost \
        --dbname=$MOODLE_DB_NAME \
        --dbuser=$MOODLE_DB_USER \
        --dbpass=$MOODLE_DB_PASSWORD \
        --fullname="My Moodle Site" \
        --shortname="Moodle" \
        --adminuser=admin \
        --adminpass=$MOODLE_ADMIN_PASSWORD \
        --adminemail=admin@example.com \
        --agree-license
fi

echo "username,password,firstname,lastname,email" >/tmp/user.csv
echo "testuser,TestPass123!,Test,User,testuser@example.com" >>/tmp/user.csv

sudo -u www-data php /var/www/html/moodle/admin/tool/uploaduser/cli/uploaduser.php --file=/tmp/user.csv --mode=addnew

# Kill MariaDB
mysqladmin shutdown
