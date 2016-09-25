#!/bin/bash
user=`whoami`
echo yes | git pull
source ../jfshop2-env/bin/deactivate
source ../jfshop2-env/bin/activate
cp -rf deploy/local_settings.py.template local_settings.py
cp -rf deploy/gunicorn.conf.py.template ./gunicorn.conf.py

pip3 install -r requirements.txt
python manage.py createdb
python manage.py migrate

