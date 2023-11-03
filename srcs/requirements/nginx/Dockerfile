FROM debian:buster

# Update packages and install necessary dependencies
RUN apt-get -y update && \
    apt-get install -y nginx openssl curl && \ 
    apt-get install -y libfcgi0ldbl

# Copy Nginx config file and script
COPY conf/nginx.conf /etc/nginx/sites-available/default.conf
COPY start_nginx.sh .

# Make nginx executable, Create nginx config symlink and get self-signed certificate
RUN chmod +x start_nginx.sh && \
    ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/tklouwer.key -out /etc/nginx/tklouwer.crt -subj "/CN=tklouwer.42.fr" 
    
# Expose port 443 for HTTPS acces
EXPOSE 443

# Set entrypoint to start script.
ENTRYPOINT ["./start_nginx.sh"]

