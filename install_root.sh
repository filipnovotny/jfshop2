apt-get --assume-yes install  build-essential mysql-server python3-dev python-virtualenv libpng-dev libjpeg-dev zlib1g-dev libmysqlclient-dev python-mysqldb nginx git python3-pip runit
sudo a2enmod proxy
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo service apache2 restart
