#!/bin/bash
user=`whoami`
apt-get --assume-yes install  build-essential mysql-server python3-dev python-virtualenv libpng-dev libjpeg-dev zlib1g-dev libmysqlclient-dev python-mysqldb nginx git python3-pip
#git clone git@github.com:filipnovotny/jfshop2.git
runuser -l  $user -c pip3 install --upgrade virtualenv
runuser -l  $user -c virtualenv ../jfshop2-env
runuser -l  $user -c source ../jfshop2-env/bin/activate
./update.sh
