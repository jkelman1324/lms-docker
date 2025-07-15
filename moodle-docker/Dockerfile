FROM ubuntu:24.04

ENV MOODLE_DB_NAME=moodle
ENV MOODLE_DB_USER=moodleuser
ENV MOODLE_DB_PASSWORD=moodlepass
ENV MOODLE_ADMIN_USER=server-admin
ENV MOODLE_ADMIN_PASSWORD=server-admin
ENV MOODLE_ADMIN_EMAIL=server-admin@test.edulinq.org

ENV DEBIAN_FRONTEND=noninteractive

# Copy Scripts
COPY scripts /scripts
RUN chmod +x /scripts/*

# Update Ubuntu and install packages.
RUN /scripts/update.sh

WORKDIR /var/www/html

# Clone Moodle Repo
RUN /scripts/fetch-moodle.sh

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
RUN /scripts/initialize.sh

EXPOSE 80
CMD ["/scripts/start.sh"]
