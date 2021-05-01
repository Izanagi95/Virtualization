docker container stop $(docker container ps -a -q)
docker container rm $(docker container ps -a -q)
docker volume rm $(docker volume ls -q)
