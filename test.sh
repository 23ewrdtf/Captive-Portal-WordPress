#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root, run sudo -i before running that script."
	exit
fi

#dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
#mysql -e "$dbsetup"

cd /var/www/html
curl -O https://wordpress.org/latest.tar.gz
#tar xzf latest.tar.gz
#rm -rf latest.tar.gz
#chown -R www-data /var/www/html/wordpress
#mv wp-config-sample.php wp-config.php
#perl -pi -e "s'database_name_here'"wordpress_db"'g" wp-config.php
#perl -pi -e "s'username_here'"wordpress_user"'g" wp-config.php
#perl -pi -e "s'password_here'"Pa66w0rd123"'g" wp-config.php
#perl -pi -e "s/\'wp_\'/\'wp_\'/g" wp-config.php
#set WP salts
#perl -i -pe'
#	  BEGIN {
#	    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
#	    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
#	    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
#	  }
#	  s/put your unique phrase here/salt()/ge
#	' wp-config.php
#create uploads folder and set permissions
#mkdir wp-content/uploads
#chmod 775 wp-content/uploads
