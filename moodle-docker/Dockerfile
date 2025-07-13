FROM ubuntu:24.04

ENV MOODLE_DB_NAME=moodle
ENV MOODLE_DB_USER=moodleuser
ENV MOODLE_DB_PASSWORD=moodlepass
ENV MOODLE_ADMIN_PASSWORD=admin123

ENV DEBIAN_FRONTEND=noninteractive

# Install everything
COPY update.sh /update.sh
RUN chmod +x /update.sh
RUN /update.sh

WORKDIR /var/www/html

# Get Moodle
RUN git clone https://github.com/moodle/moodle.git && \
    cd moodle && git checkout v5.0.1

# Setup permissions
RUN mkdir -p /var/www/moodledata && \
    chown -R www-data:www-data /var/www/moodledata && \
    chown -R www-data:www-data /var/www/html/moodle

# Max input vars 5000
COPY moodle-custom.ini /etc/php/8.3/apache2/conf.d/99-moodle.ini
COPY moodle-custom.ini /etc/php/8.3/cli/conf.d/99-moodle.ini

# Copy test data
COPY load-test-data.py /
COPY users.json /
RUN chmod +x /load-test-data.py

# Copy start script
COPY initialize.sh /initialize.sh
RUN chmod +x /initialize.sh
WORKDIR /
RUN /initialize.sh
WORKDIR /var/www/html

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
