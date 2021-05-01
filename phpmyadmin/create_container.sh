#docker container run --name pmy --network intnet -p 8081:80 myphpmyadmin 
docker container run -d --name pmy -h pmy -e DB_HOST="db" -p 8081:80 --network mydocker_intnet myphpmyadmin
