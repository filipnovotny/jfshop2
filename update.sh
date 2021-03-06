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
cp -rf deploy/runit.conf.template ./runit.conf
cp -rf deploy/nginx.conf.template ./nginx.conf
cp -rf deploy/apache2.conf.template ./apache2.conf

pip3 install -r requirements.txt

MY_PATH_ESC=$(echo $MY_PATH | sed -e 's/[\/&]/\\&/g')
VIRTUALENVPATH="`( cd \"$MY_PATH/../jfshop2-env\" && pwd )`"
VIRTUALENVPATH_ESC=$(echo $VIRTUALENVPATH | sed -e 's/[\/&]/\\&/g')

sed -i -- "s/<%CURRENTDIR%>/$MY_PATH_ESC/g" ./nginx.conf
sed -i -- "s/<%CURRENTDIR%>/$MY_PATH_ESC/g" ./apache2.conf

if [ -f password.txt ];
then
  password=`cat password.txt`
  sed -i -- "s/<%PASSWORD%>/$password/g" ./jfshop2/local_settings.py
  echo "create database jfshop2" | mysql -uroot -p$password
else
    echo "please create a password.txt file here with your mysql password"
    exit
fi


sed -i -- "s/<%CURRENTDIR%>/$MY_PATH_ESC/g" ./runit.conf
sed -i -- "s/<%VIRTUALENVDIR%>/$VIRTUALENVPATH_ESC/g" ./runit.conf

cp -rf ./jfshop2/local_settings.py build/lib/jfshop2/local_settings.py


python manage.py createdb --noinput --nodata
python manage.py migrate
FILES=./fixtures/*.json
for f in $FILES
do
  echo "Processing $f file..."
  python manage.py loaddata $f
  cat $f
done

cd ./mezzanine_themes/metro/static
npm install
cd node_modules/portfolio
npm install
npm run gulp
cd ../..
npm run tsc
cd ../../..



echo yes | python manage.py collectstatic

