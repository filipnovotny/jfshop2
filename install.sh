apt-get --assume-yes install  build-essential mysql-server python3-dev python-virtualenv libpng-dev zlib1g-dev libmysqlclient-dev python-mysqldb nginx git
git clone git@github.com:filipnovotny/jfshop2.git
pip install --upgrade virtualenv
virtualenv ../jfshop2-env
source ../jfshop2-env/bin/activate
pip install -r requirements.txt
./update.sh
