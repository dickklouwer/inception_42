#This Dockerfile creates an image based on Debian Buster, 
# installs MariaDB server and client on it, makes the 
# necessary changes to the MariaDB configuration to allow
# external connections, and finally uses the script to set 
# up the MariaDB server when the container is started.

FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client

# Ensure the mysqld runtime directory exists
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY tools/init_mariadb.sh /tmp/

RUN chmod +x /tmp/init_mariadb.sh

# Sed changes bind address to '0.0.0.0' to accept connections from any IP address
#RUN sed 's/bind-address\*s=\*s127.0.0.1/bind-address = 0.0.0.0/' -i /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Uncomments the skip networking option, so it's allow to listen to IP Connections
RUN sed 's/skip-networking/#skip-networking/g' -i /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["/tmp/init_mariadb.sh"]
