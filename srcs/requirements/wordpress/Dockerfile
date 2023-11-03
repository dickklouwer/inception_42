# Dockerfile to set up a WordPress environment with PHP-FPM and MariaDB Client.

#Base Image.
FROM debian:buster

RUN apt-get update

#Install all requiered packages.
RUN apt-get install -y php-fpm php-mysql wget mariadb-client

#Download WP-CLI
#WP-CLI is the WordPress Command-Line-Interface, with CLI you can manage you WP site from the command line.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Make WP-CLI executable
RUN chmod u+x wp-cli.phar

#Making it globally accessible from the CLI within the container.
RUN mv wp-cli.phar /usr/local/bin/wp

# Configure to to listen to port '9000' instead of a local socket.
RUN sed 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|g' -i /etc/php/7.3/fpm/pool.d/www.conf

# Create the directory for hte PHP-FPM socket
RUN mkdir -p /run/php

# Copy WordPress script to the container.
COPY tools/init_wp.sh .

# Making the WordPress script runnable.
RUN chmod +x init_wp.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Specifies the script that's run everytime the container starts.
ENTRYPOINT ["./init_wp.sh"]
