## Captive Portal on Rapsberry Pi with WordPress [DRAFT, DO NOT USE]

# Copy of https://github.com/tretos53/Captive-Portal, trying to get WP working with Captive Portal. NOT EASY and it doesnt work at the moment.

Test 1 - below didn't work. Got configuration screen, enter DB details, enter username etc and error. Check db connection. In the config file it is refered as localhost.


```
apt-get update -y
apt-get install nginx -y
apt-get install php7.0-fpm -y
apt-get install mysql-server php-mysql -y
dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
mysql -e "$dbsetup"
curl -o /var/www/html/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ -zxvf /var/www/html/latest.tar.gz
rm -rf /var/www/html/latest.tar.gz
chown -R www-data /var/www/html/wordpress
mkdir /var/www/html/wordpress/wp-content/uploads
chmod 775 /var/www/html/wordpress/wp-content/uploads
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/default_nginx -O /etc/nginx/sites-enabled/default
reboot
```

Error: Gateway Timeout
Error: Error establishing a database connection
