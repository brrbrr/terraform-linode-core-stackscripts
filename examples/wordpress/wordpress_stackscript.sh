#!/bin/bash 
## Source : https://cloud.linode.com/stackscripts/998743
#<UDF name="ssuser" Label="New user" example="username" />
#<UDF name="sspassword" Label="New user password" example="Password" />
#<UDF name="hostname" Label="Hostname" example="examplehost" />
#<UDF name="website" Label="Website" example="example.com" />
# <UDF name="db_password" Label="MySQL root Password" />
# <UDF name="dbuser" Label="MySQL Username" />
# <UDF name="dbuser_password" Label="MySQL User Password" />

exec > >(tee /dev/ttyS0 /var/log/stackscript.log) 2>&1
set -xo pipefail
## Import the Bash StackScript Library
source <ssinclude StackScriptID=1>
# add sudo user
adduser $SSUSER --disabled-password --gecos "" && \
echo "$SSUSER:$SSPASSWORD" | chpasswd
adduser $SSUSER sudo
# updates
apt-get -o Acquire::ForceIPv4=true update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold"  install grub-pc
apt-get -o Acquire::ForceIPv4=true update -y
#SET HOSTNAME	
hostnamectl set-hostname $HOSTNAME
echo "127.0.0.1   $HOSTNAME" >> /etc/hosts
#INSTALL APACHE
apt-get install apache2 -y
# edit apache config
sed -ie "s/KeepAlive Off/KeepAlive On/g" /etc/apache2/apache2.conf
#Create a copy of the default Apache configuration file for your site:
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$WEBSITE.conf
# configuration of vhost file
cat <<END >/etc/apache2/sites-available/$WEBSITE.conf
<Directory /var/www/html/$WEBSITE/public_html>
    Require all granted
</Directory>
<VirtualHost *:80>
        ServerName $WEBSITE
        ServerAlias www.$WEBSITE
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/$WEBSITE/public_html
        ErrorLog /var/www/html/$WEBSITE/logs/error.log
        CustomLog /var/www/html/$WEBSITE/logs/access.log combined
</VirtualHost>
END
# Make public_html & logs
mkdir -p /var/www/html/$WEBSITE/{public_html,logs,src}
# Remove default apache page
rm /var/www/html/index.html
# Install PHP
sudo apt install -y php php-curl php-common openssl php-imagick php-json php-mbstring php-mysql pcre2-utils php-xml php-zip apache2 unzip 
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
sudo sed -i s/post_max_size\ =.*/post_max_size\ =\ 100M/ /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i s/upload_max_filesize\ =.*/upload_max_filesize\ =\ 100M/ /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i s/memory_limit\ =.*/memory_limit\ =\ 256M/ /etc/php/$PHP_VERSION/apache2/php.ini
# Install wordpress
cd /var/www/html/$WEBSITE/src/
sudo chown -R www-data:www-data /var/www/html/$WEBSITE/
sudo wget http://wordpress.org/latest.tar.gz
sudo -u www-data tar -xvf latest.tar.gz
sudo mv latest.tar.gz wordpress-`date "+%Y-%m-%d"`.tar.gz
sudo mv wordpress/* ../public_html/
sudo chown -R www-data:www-data /var/www/html/$WEBSITE/public_html
#Link your virtual host file from the sites-available directory to the sites-enabled directory:
sudo a2ensite $WEBSITE.conf
#Disable the default virtual host to minimize security risks:
a2dissite 000-default.conf
# restart apache
systemctl reload apache2
systemctl restart apache2
# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server mysql-server/root_password password $DB_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DB_PASSWORD" | sudo debconf-set-selections
apt-get -y install mysql-server
mysql -uroot -p$DB_PASSWORD -e "create database wordpress"
mysql -uroot -p$DB_PASSWORD -e "CREATE USER '$DBUSER' IDENTIFIED BY '$DBUSER_PASSWORD';"
mysql -uroot -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO '$DBUSER';"
service mysql restart
sudo systemctl restart apache2
stackscript_cleanup