sudo apt-get install -y apache2 apache2-utils php libapache2-mod-php php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip mariadb-server mariadb-client
sudo apt-get install phpmyadmin
sudo cp /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/
sudo mv /etc/apache2/conf-available/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
cd /etc/apache2/sites-available/

sudo cat > wordpress.conf << EOF
<VirtualHost *:80>
        ServerName jishnn.wp
        ServerAdmin jishnn@localhost
        DocumentRoot /var/www/html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite wordpress.conf
sudo systemctl reload apache2
sudo a2dismod mpm_event
sudo systemctl restart apache2
sudo a2enmod mpm_prefork
sudo systemctl restart apache2
sudo a2enmod php7.0
sudo systemctl restart apache2

cd /etc/apache2/
sudo cat > wordpress.conf << EOF
    ServerName jishnn.wp
EOF

sudo systemctl restart apache2
sudo mysql_secure_installation

wget http://wordpress.org/latest.tar.gz
sudo tar xvzf latest.tar.gz
sudo cp -r wordpress/*  /var/www/html
sudo tar xvzf latest.tar.gz
sudo mkdir -p  /var/www/html
sudo cp -r wordpress/*  /var/www/html

sudo service apache2 restart
sudo service mysql restart
sudo chown -R www-data  /var/www/html
sudo chmod -R 755  /var/www/html
sudo chown -R root /var/www/html

cd /var/www/html
sudo cat > wp-config.php << EOD
    define('DB_NAME', 'wordpress');
    define('DB_USER', 'jishnn');
    define('DB_PASSWORD', '324b21');
    define('DB_HOST', 'EXTERNAL IP');

EOD

curl -X GET http://wordpress.lan/index.php
