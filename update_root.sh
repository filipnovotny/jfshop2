
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

reload gunicorn
service nginx restart

