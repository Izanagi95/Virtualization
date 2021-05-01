FROM kwindsor/php7-apache-ubuntu
#FROM php:7.2-apache
WORKDIR /var/www/html
ARG VERSION=3.6.4
ENV JOOMLA_VERSION=$VERSION
RUN apt -y update && apt install -y wget mariadb-client unzip
RUN mkdir /var/www/tmp
RUN mkdir /var/www/logs
RUN rm -f /var/www/html/index.html
RUN wget https://github.com/joomla/joomla-cms/releases/download/$JOOMLA_VERSION/Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip -P /var/tmp/
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh
COPY firstrun.sh /usr/local/bin/firstrun.sh
RUN chmod +x /usr/local/bin/firstrun.sh
RUN sed -i '3i/usr/local/bin/firstrun.sh' /usr/local/bin/docker-php-entrypoint
