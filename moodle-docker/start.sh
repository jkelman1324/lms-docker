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

# Start Apache in foreground
exec apachectl -D FOREGROUND
