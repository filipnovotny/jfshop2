
if [ -f /usr/local/nginx/conf/nginx.conf ];
then
   cp -rf ./nginx.conf /usr/local/nginx/conf/nginx.conf
fi

if [ -f /etc/nginx/nginx.conf ];
then
   cp -rf ./nginx.conf /etc/nginx/nginx.conf
fi

if [ -f /usr/local/etc/nginx/nginx.conf ];
then
   cp -rf ./nginx.conf /usr/local/etc/nginx/nginx.conf
fi

mkdir /etc/sv
mkdir /etc/sv/jfshop2

cp -rf ./runit.conf /etc/sv/jfshop2/run
chmod u+x /etc/sv/jfshop2/run
ln -s /etc/sv/jfshop2 /etc/service/jfshop2

cp -rf ./apache2.conf /etc/apache2/sites-available/jfshop2.conf
a2ensite jfshop2

sv reload jfshop2
service nginx reload
service apache2 reload
