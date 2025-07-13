#!/bin/bash

MOODLE_DB_NAME=moodle
MOODLE_DB_USER=moodleuser
MOODLE_DB_PASSWORD=moodlepass
MOODLE_ADMIN_PASSWORD=admin123

docker build --progress plain -t my-moodle .
docker run --rm -p 8080:80 \
    --name moodle \
    -e MOODLE_DB_NAME=$MOODLE_DB_NAME \
    -e MOODLE_DB_USER=$MOODLE_DB_USER \
    -e MOODLE_DB_PASSWORD=$MOODLE_DB_PASSWORD \
    -e MOODLE_ADMIN_PASSWORD=$MOODLE_ADMIN_PASSWORD \
    my-moodle
