
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

mkdir /etc/sv
mkdir /etc/sv/jfshop2

cp -rf ./runit.conf /etc/sv/jfshop2/run
chmod u+x /etc/sv/jfshop2/run
ln -s /etc/sv/jfshop2 /etc/service/jfshop2

reload gunicorn
service nginx restart

