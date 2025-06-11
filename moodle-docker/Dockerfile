FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install everything
RUN apt-get update && apt-get install -y \
    apache2 php libapache2-mod-php php-mysql mariadb-server git \
    php-curl php-gd php-intl php-xml php-mbstring php-zip unzip cron sudo

WORKDIR /var/www/html

# Get Moodle
RUN git clone https://github.com/moodle/moodle.git && \
    cd moodle && git checkout MOODLE_405_STABLE

# Setup permissions
RUN mkdir -p /var/www/moodledata && \
    chown -R www-data:www-data /var/www/moodledata && \
    chown -R www-data:www-data /var/www/html/moodle

# Max input vars 5000
COPY moodle-custom.ini /etc/php/8.1/apache2/conf.d/99-moodle.ini
COPY moodle-custom.ini /etc/php/8.1/cli/conf.d/99-moodle.ini

# Copy start script
COPY initialize.sh /initialize.sh
RUN chmod +x /initialize.sh
RUN /initialize.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
