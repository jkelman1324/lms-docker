#!/bin/bash

# Start MariaDB manually in background
mysqld_safe &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    echo "Waiting for database server to start..."
    sleep 2
done

# Start Apache in foreground
exec apachectl -D FOREGROUND
