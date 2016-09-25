#!/bin/bash
user=`whoami`
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
echo yes | git reset --hard HEAD
echo yes | git pull
source ../jfshop2-env/bin/deactivate
source ../jfshop2-env/bin/activate
cp -rf deploy/local_settings.py.template ./jfshop2/local_settings.py
cp -rf deploy/gunicorn.conf.py.template ./gunicorn.conf.py
cp -rf deploy/upstart.conf.template ./upstart.conf

pip3 install -r requirements.txt

if [ -f password.txt ];
then
   cp -rf deploy/nginx.conf.template /usr/local/nginx/conf/nginx.conf
else
    echo "please create a password.txt file here with your mysql password"
    exit
fi
password=`cat password.txt`
sed -i -- "s/<%PASSWORD%>/$password/g" ./jfshop2/local_settings.py
echo "create database jfshop2" | mysql -uroot -p$password

MY_PATH_ESC=`echo $MY_PATH | sed -e 's/[\/&]/\\&/g'`
VIRTUALENVPATH_ESC=`echo $VIRTUALENVPATH | sed -e 's/[\/&]/\\&/g'`
sed -i -- "s/<%CURRENTDIR%>/$MY_PATH_ESC/g" ./jfshop2/upstart.conf
VIRTUALENVPATH="`( cd \"$MY_PATH/../jfshop2-env\" && pwd )`"
sed -i -- "s/<%VIRTUALENVDIR%>/$VIRTUALENVPATH_ESC/g" ./jfshop2/upstart.conf

cp -rf ./jfshop2/local_settings.py build/lib/jfshop2/local_settings.py


python manage.py createdb --noinput --nodata
python manage.py migrate

