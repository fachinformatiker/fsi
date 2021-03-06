#!/bin/bash
# fsi - fachinformatiker server installer
echo ""
echo "-------------------------------------------"
echo ""
echo "fsi - fachinformatiker server installer"
echo "installer and configurator for my servers"
echo "2018 (c) Patrick Szalewicz"
echo ""
echo "-------------------------------------------"
echo ""
echo ""

# Create destination folder
echo "creating setup folder"
FSI="/opt/fsi"
sudo mkdir -p /opt/fsi

# updates
echo "installing updates"
sudo apt update
sudo apt upgrade -y
sudo echo "updates installed" >> /opt/fsi/install.log

# default tools
echo "installing default tools"
sudo apt install -y nano zip unzip git curl htop sudo
sudo echo "default tools installed" >> /opt/fsi/install.log

# samba
echo "installing samba"
sudo apt install -y samba-common samba
sudo echo "samba installed, more inside todo.log" >> /opt/fsi/install.log
sudo echo "samba has to be configured" >> /opt/fsi/todo.log

# mariadb
echo "installing mariadb"
sudo apt install -y mariadb-server mariadb-client
sudo mysql_secure_installation
sudo echo "mariadb installed" >> /opt/fsi/install.log

# apache2
echo "installing apache2"
sudo apt install -y apache2
sudo echo "apache installed" >> /opt/fsi/install.log

# php7.2
echo "installing php7.2"
sudo apt install -y php7.2 libapache2-mod-php7.2
sudo systemctl restart apache2
sudo echo "php7.2 installed" >> /opt/fsi/install.log

# php extras
echo "installing php extras"
sudo apt install -y php-gettext php-cli php-geoip php-mbstring php-xml php7.2-opcache php-apcu php7.2-mysql php7.2-curl php7.2-gd php7.2-intl php-pear php-imagick php7.2-imap php-memcache php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php7.2-json php7.2-xml php7.2-zip
sudo systemctl restart apache2
sudo echo "php extras installed" >> /opt/fsi/install.log

# enable SSL
echo "enabling ssl"
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo systemctl restart apache2
sudo echo "ssl enabled" >> /opt/fsi/install.log

# install Let's Encrypt
echo "installing let's encrypt"
sudo apt install -y python3-certbot-apache
sudo echo "let's encrypt installed, more inside todo.log" >> /opt/fsi/install.log
sudo echo "let's encrypt cert has to be configured" >> /opt/fsi/todo.log

# phpmyadmin
echo "installing phpmyadmin"
sudo apt install -y phpmyadmin
sudo echo "phpmyadmin installed" >> /opt/fsi/install.log

# node.js
echo "installing node.js"
sudo apt install -y nodejs
sudo apt install -y npm
sudo echo "node.js installed" >> /opt/fsi/install.log

# python
echo "installing python & pip"
sudo apt install -y python python-pip
sudo echo "python & pip installed" >> /opt/fsi/install.log

# python3
echo "installing python3 & pip3"
sudo apt install -y python3 python-pip3
sudo echo "python3 & pip3 installed" >> /opt/fsi/install.log

### install nextcloud ###
echo "installing nextcloud"
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xjvf latest.tar.bz2 -C /var/www/html/
sudo rm latest.tar.bz2
sudo mv /var/www/html/nextcloud/ /var/www/html/cloud/
sudo chown -R www-data:www-data /var/www/html
sudo systemctl restart apache2.service
sudo echo "nextcloud installed, more inside todo.log" >> /opt/fsi/install.log
sudo echo "nextcloud has to be configured" >> /opt/fsi/todo.log

echo ""
echo ""
echo "-------------------------------------------"
echo ""
echo "installation complete"
echo ""
echo "check logs for more info"
echo ""
echo "log /opt/fsi/install.log"
echo "todo /opt/fsi/todo.log"
echo ""
echo "-------------------------------------------"
echo ""
exit 0
