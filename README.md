## Captive Portal on Rapsberry Pi with WordPress [DRAFT, DO NOT USE]

## Replace Passwords with your own

Image: 2019-04-08-raspbian-stretch-lite.zip

Part 1 - Installing Wordpress

```
sudo -i

#!/bin/bash

echo "┌─────────────────────────────────────────"
echo "|Updating repositories"
echo "└─────────────────────────────────────────"
apt-get update -y

echo "┌─────────────────────────────────────────"
echo "|Installing Nginx"
echo "└─────────────────────────────────────────"
apt install nginx -y
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/default_nginx -O /etc/nginx/sites-enabled/default

echo "┌─────────────────────────────────────────"
echo "|Installing MySQL"
echo "└─────────────────────────────────────────"
apt-get install mysql-server -y
mysql_secure_installation <<EOF
y
Pa55w04d123
Pa55w04d123
y
y
y
y
EOF

dbsetup="create database wordpress;GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@$localhost IDENTIFIED BY 'Pa55w04d123';FLUSH PRIVILEGES;"
mysql -e "$dbsetup"

echo "┌─────────────────────────────────────────"
echo "|Installing PHP"
echo "└─────────────────────────────────────────"
apt install php-fpm php-mysql -y
apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y
systemctl restart php7.0-fpm

echo "┌─────────────────────────────────────────"
echo "|Installing Wordpress"
echo "└─────────────────────────────────────────"
curl -o /var/www/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/ -zxvf /var/www/latest.tar.gz
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
chown -R www-data:www-data /var/www/wordpress

MANUAL
curl -s https://api.wordpress.org/secret-key/1.1/salt/
nano /var/www/wordpress/wp-config.php
edit salts and DB details and add define('FS_METHOD', 'direct');
```

Part 1 - Installing Captive Portal
