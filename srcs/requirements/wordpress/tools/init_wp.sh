#!/bin/bash

WP_DIR="/var/www/wordpress"
mkdir -p $WP_DIR
echo "$WP_DIR made"

cd $WP_DIR
#Dowload WordPress core
wp core download --allow-root --force

#Create wp-config.php file
wp config create --allow-root --dbname=$MDB_DB_NAME --dbuser=$WP_USER1 --dbpass=$WP_PWD1 --dbhost=mariadb --config-file=$WP_DIR/wp-config.php --skip-plugins --skip-themes
echo "Created wp-config.php file ..."

#Install WordPress with first (admin) user.
wp core install --allow-root --url=$WP_URL --admin_user=$WP_USER1 --admin_password=$WP_PWD1 --title=$DB_HOST --admin_email=user1@42.fr

#Create Second User
wp user create $WP_USER2 user2@42.fr --allow-root --user_pass=$WP_PWD2

#Change ownership so the webserver has the necessary permissions.
chown -R www-data:www-data $WP_DIR

echo "WordPress initialized and started..."
php-fpm7.3 -R -F
