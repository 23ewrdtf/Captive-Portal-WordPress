#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root, run sudo -i before running that script."
	exit
fi

echo "┌─────────────────────────────────────────"
echo "|Configuring MySQL, Pa$$w0rd123 is temporary,
echo "|CHANGE BEFORE RUN THIS SCRIPT"
echo "└─────────────────────────────────────────"
mysql -e "create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$mysqlhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
