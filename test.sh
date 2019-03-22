#!/bin/bash

# dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
# mysql -e "$dbsetup"

curl -o /var/www/html/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ -zxvf /var/www/html/latest.tar.gz
rm -rf /var/www/html/latest.tar.gz
chown -R www-data /var/www/html/wordpress
rm -rf /var/www/html/wordpress/wp-config-sample.php
mkdir /var/www/html/wordpress/wp-content/uploads
chmod 775 /var/www/html/wordpress/wp-content/uploads
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/wp-config.php -O /var/www/html/wordpress/wp-config.php
