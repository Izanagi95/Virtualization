#!/bin/sh
test -f /config/config.inc.php && exit
mv /var/www/html/config.sample.inc.php /config/config.inc.php
sed -i "s/localhost/${DB_HOST}/g" /config/config.inc.php 
secret=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1)
echo "\$cfg['blowfish_secret'] = '$secret';" >> /config/config.inc.php 
