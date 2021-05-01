docker run --name db -h db -e MYSQL_ROOT_PASSWORD=secret -d mariadb
# testing
docker network connect mydocker_intnet db
#docker network connect intnet db

