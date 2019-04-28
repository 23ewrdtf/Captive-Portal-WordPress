## Captive Portal on Rapsberry Pi with WordPress [DRAFT, DO NOT USE]

## Copy of https://github.com/tretos53/Captive-Portal, trying to get WP working with Captive Portal. NOT EASY and it doesnt work at the moment.

Below works.

```
apt-get update -y
apt-get install nginx -y
apt-get install mysql-server php-mysql -y
apt-get install php7.0-fpm -y

curl -o /var/www/html/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ -zxvf /var/www/html/latest.tar.gz
rm -rf /var/www/html/latest.tar.gz
chown -R www-data /var/www/html/wordpress
mkdir /var/www/html/wordpress/wp-content/uploads
chmod 775 /var/www/html/wordpress/wp-content/uploads
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/default_nginx -O /etc/nginx/sites-enabled/default

service nginx restart

To create DB
https://projects.raspberrypi.org/en/projects/lamp-web-server-with-wordpress/8

FOr some reason WP installs but it doesnt create all the tables. DO below to fix it

define('WP_ALLOW_REPAIR', true); to repair db http://192.168.0.20/wp-admin/maint/repair.php
```
