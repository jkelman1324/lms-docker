#!/bin/bash

set -e 

# Install everything
apt-get update 
apt-get install -y \
    apache2 php libapache2-mod-php php-mysql mariadb-server git \
    php-curl php-gd php-intl php-xml php-mbstring php-zip unzip cron sudo python3 vim
