docker pull mariadb
docker build -f phpmyadmin/Dockerfile . -t myphpmyadmin
docker build -f joomla/Dockerfile . -t myjoomla
