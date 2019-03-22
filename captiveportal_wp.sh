#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root, run sudo -i before running that script."
	exit
fi

echo "┌─────────────────────────────────────────"
echo "|This script might take a while,"
echo "|so if you dont see much progress,"
echo "|wait till you see --all done-- message."
echo "└─────────────────────────────────────────"
read -p "Press enter to continue"

echo "┌─────────────────────────────────────────"
echo "|Updating repositories"
echo "└─────────────────────────────────────────"
apt-get update -yqq

# echo "┌─────────────────────────────────────────"
# echo "|Upgrading packages, this might take a while|"
# echo "└─────────────────────────────────────────"
# apt-get upgrade -yqq

echo "┌─────────────────────────────────────────"
echo "|Installing and configuring nginx"
echo "└─────────────────────────────────────────"
apt-get install nginx -yqq
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/default_nginx -O /etc/nginx/sites-enabled/default

echo "┌─────────────────────────────────────────"
echo "|Installing PHP7"
echo "└─────────────────────────────────────────"
apt-get install php7.0-fpm -yqq

echo "┌─────────────────────────────────────────"
echo "|Installing and configuring MySQL"
echo "└─────────────────────────────────────────"
apt-get install mysql-server php-mysql -yqq
dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
mysql -e "$dbsetup"

echo "┌─────────────────────────────────────────"
echo "|Installing and configuring WordPress"
echo "└─────────────────────────────────────────"
curl -o /var/www/html/latest.tar.gz -O https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ -zxvf /var/www/html/latest.tar.gz
rm -rf /var/www/html/latest.tar.gz
chown -R www-data /var/www/html/wordpress
rm -rf /var/www/html/wordpress/wp-config-sample.php
mkdir /var/www/html/wordpress/wp-content/uploads
chmod 775 /var/www/html/wordpress/wp-content/uploads
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/wp-config.php -O /var/www/html/wordpress/wp-config.php

echo "┌─────────────────────────────────────────"
echo "|Installing dnsmasq"
echo "└─────────────────────────────────────────"
apt-get install dnsmasq -yqq

echo "┌─────────────────────────────────────────"
echo "|Configuring wlan0"
echo "└─────────────────────────────────────────"
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal/master/dhcpcd.conf -O /etc/dhcpcd.conf

echo "┌─────────────────────────────────────────"
echo "|Configuring dnsmasq"
echo "└─────────────────────────────────────────"
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal/master/dnsmasq.conf -O /etc/dnsmasq.conf

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
wget -q https://raw.githubusercontent.com/tretos53/Captive-Portal/master/hostapd.conf -O /etc/hostapd/hostapd.conf
sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd

echo "┌─────────────────────────────────────────"
echo "|Configuring iptables"
echo "└─────────────────────────────────────────"
iptables -t nat -A PREROUTING -s 192.168.24.0/24 -p tcp --dport 80 -j DNAT --to-destination 192.168.24.1:80
iptables -t nat -A POSTROUTING -j MASQUERADE
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -y install iptables-persistent

echo "┌─────────────────────────────────────────"
echo "|configuring hostapd to start at boot"
echo "└─────────────────────────────────────────"
update-rc.d hostapd defaults

echo "┌─────────────────────────────────────────"
echo "|After the next step is complete,"
echo "|please reboot your pi and test."
echo "└─────────────────────────────────────────"
read -p "Press enter to install PHP"
