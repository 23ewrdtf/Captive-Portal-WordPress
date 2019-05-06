## Captive Portal on Rapsberry Pi with WordPress [DRAFT, DO NOT USE]

## Replace Passwords with your own including SALTS and wp-config.php

Image: 2019-04-08-raspbian-stretch-lite.zip

Part 1 - Installing Wordpress

```
sudo -i

#!/bin/bash

echo "┌─────────────────────────────────────────"
echo "|Updating repositories"
echo "└─────────────────────────────────────────"
apt-get update -yqq

echo "┌─────────────────────────────────────────"
echo "|Installing Nginx"
echo "└─────────────────────────────────────────"
apt install nginx -yqq
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/default_nginx -O /etc/nginx/sites-enabled/default

echo "┌─────────────────────────────────────────"
echo "|Installing MySQL"
echo "└─────────────────────────────────────────"
apt-get install mysql-server -yqq
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
apt install php-fpm php-mysql -yqq
apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -yqq
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

Part 2 - Installing Captive Portal

```
echo "┌─────────────────────────────────────────"
echo "|Installing dnsmasq"
echo "└─────────────────────────────────────────"
apt-get install dnsmasq -yqq

echo "┌─────────────────────────────────────────"
echo "|Configuring wlan0"
echo "└─────────────────────────────────────────"
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/dhcpcd.conf -O /etc/dhcpcd.conf

echo "┌─────────────────────────────────────────"
echo "|Configuring dnsmasq"
echo "└─────────────────────────────────────────"
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/dnsmasq.conf -O /etc/dnsmasq.conf

echo "┌─────────────────────────────────────────"
echo "|configuring dnsmasq to start at boot"
echo "└─────────────────────────────────────────"
update-rc.d dnsmasq defaults

echo "┌─────────────────────────────────────────"
echo "|Installing hostapd"
echo "└─────────────────────────────────────────"
apt-get install hostapd -yqq

echo "┌─────────────────────────────────────────"
echo "|Configuring hostapd"
echo "└─────────────────────────────────────────"
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/hostapd.conf -O /etc/hostapd/hostapd.conf
sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd

echo "┌─────────────────────────────────────────"
echo "|configuring hostapd to start at boot"
echo "└─────────────────────────────────────────"
systemctl unmask hostapd.service
systemctl enable hostapd.service

echo "┌─────────────────────────────────────────"
echo "|Configuring iptables"
echo "└─────────────────────────────────────────"
iptables -t nat -A PREROUTING -s 192.168.24.0/24 -p tcp --dport 80 -j DNAT --to-destination 192.168.24.1:80
iptables -t nat -A POSTROUTING -j MASQUERADE
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -yqq install iptables-persistent
```
