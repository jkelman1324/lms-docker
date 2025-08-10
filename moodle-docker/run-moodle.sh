#!/bin/bash

MOODLE_DB_NAME=moodle
MOODLE_DB_USER=moodleuser
MOODLE_DB_PASSWORD=moodlepass
MOODLE_ADMIN_PASSWORD=server-admin

docker build -t my-moodle .
docker run --rm -p 8080:80 \
    --name moodle \
    my-moodle
