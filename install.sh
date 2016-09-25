apt-get --assume-yes install  build-essential mysql-server python3-dev python-virtualenv libpng-dev libjpeg-dev zlib1g-dev libmysqlclient-dev python-mysqldb nginx git python3-pip
#git clone git@github.com:filipnovotny/jfshop2.git
pip3 install --upgrade virtualenv
virtualenv ../jfshop2-env
source ../jfshop2-env/bin/activate
./update.sh
