FROM php:7.2-apache
WORKDIR /var/www/html
RUN docker-php-ext-install mysqli
ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-all-languages.tar.gz /var/www/html
RUN tar xvfz phpMyAdmin-4.9.1-all-languages.tar.gz --strip 1; rm -f *.tar.gz
RUN mkdir /config
RUN ln -s /config/config.inc.php
ADD firstrun.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/firstrun.sh
RUN sed -i '3i/usr/local/bin/firstrun.sh' /usr/local/bin/docker-php-entrypoint
