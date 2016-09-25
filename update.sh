echo yes | git pull
source ../jfshop2-env/bin/deactivate
source ../jfshop2-env/bin/activate
cp -rf deploy/local_settings.py.template local_settings.py
cp -rf deploy/gunicorn.conf.py.template ./gunicorn.conf.py

pip3 install -r requirements.txt

if [ -f password.txt ];
then
   cp -rf deploy/nginx.conf.template /usr/local/nginx/conf/nginx.conf
else
    echo "please create a password.txt file here with your mysql password"
    exit
fi
password=`cat password.txt`
sed -i -- "s/<%PASSWORD%>/$password/g" local_settings.py
mysql -uroot -p$password -e "create database 'jfshop2'"

if [ -f /usr/local/nginx/conf/nginx.conf ];
then
   cp -rf deploy/nginx.conf.template /usr/local/nginx/conf/nginx.conf
fi

if [ -f /etc/nginx/nginx.conf ];
then
   cp -rf deploy/nginx.conf.template /etc/nginx/nginx.conf
fi

if [ -f /usr/local/etc/nginx/nginx.conf ];
then
   cp -rf deploy/nginx.conf.template /usr/local/etc/nginx/nginx.conf
fi

python manage.py createdb
python manage.py migrate
reload gunicorn
service nginx restart

