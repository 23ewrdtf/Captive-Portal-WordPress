#!/bin/bash

# dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
# mysql -e "$dbsetup"

curl -o /var/www/html/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ -zxvf /var/www/html/latest.tar.gz
rm -rf /var/www/html/latest.tar.gz
chown -R www-data /var/www/html/wordpress
mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
perl -pi -e "s'database_name_here'"wordpress_db"'g" /var/www/html/wordpress/wp-config.php
perl -pi -e "s'username_here'"wordpress_user"'g" /var/www/html/wordpress/wp-config.php
perl -pi -e "s'password_here'"Pa66w0rd123"'g" /var/www/html/wordpress/wp-config.php
perl -pi -e "s/\'wp_\'/\'wp_\'/g" /var/www/html/wordpress/wp-config.php
mkdir /var/www/html/wordpress/wp-content/uploads
chmod 775 /var/www/html/wordpress/wp-content/uploads
