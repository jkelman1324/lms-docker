FROM ubuntu:24.04

ENV MOODLE_DB_NAME=moodle
ENV MOODLE_DB_USER=moodleuser
ENV MOODLE_DB_PASSWORD=moodlepass
ENV MOODLE_ADMIN_PASSWORD=admin123

ENV DEBIAN_FRONTEND=noninteractive

# Copy scripts
COPY scripts /scripts
RUN chmod +x /scripts/*.sh
RUN chmod +x /scripts/load-test-data.py

# Install everything
RUN /scripts/update.sh

WORKDIR /var/www/html

# Clone moodle repo
RUN /scripts/moodle.sh

# Setup permissions
RUN mkdir -p /var/www/moodledata && \
    chown -R www-data:www-data /var/www/moodledata && \
    chown -R www-data:www-data /var/www/html/moodle

# Max input vars 5000
COPY moodle-custom.ini /etc/php/8.3/apache2/conf.d/99-moodle.ini
COPY moodle-custom.ini /etc/php/8.3/cli/conf.d/99-moodle.ini

# Copy test data
COPY data /data

# Copy start script
WORKDIR /
RUN /scripts/initialize.sh
WORKDIR /var/www/html

EXPOSE 80
CMD ["/scripts/start.sh"]
