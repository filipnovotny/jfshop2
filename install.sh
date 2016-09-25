#!/bin/bash
user=`whoami`
#git clone git@github.com:filipnovotny/jfshop2.git
pip3 install --upgrade virtualenv
virtualenv ../jfshop2-env -p python3
source ../jfshop2-env/bin/activate
./update.sh
