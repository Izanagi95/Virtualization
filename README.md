# Virtualization
Virtualization and Cloud Computing project <br> Authors: _@izanagi95_ & _@davsen39_

![alt text](https://github.com/Izanagi95/Virtualization/blob/master/architettura.png?raw=true)

# Files description
Per facilitare e velocizzare la configurazione del progetto sono stati creati i seguenti script: <br>
+ Create_all_images.sh: al proprio interno troviamo il seguente codice
>docker pull mariadb <br>
>docker build -f phpmyadmin/Dockerfile . -t myphpmyadmin <br>
>docker build -f joomla/Dockerfile . -t myjoomla <br>
Questo script è utilizzato per creare le immagini di phpmyadmin, mariadb e joomla ed assegnarli un tag. <br>

+ Delete_containers.sh: questo script è utilizzato per stoppare ed eliminare con un solo comando tutti i container. <br>
Al proprio interno troviamo il seguente codice:<br>
>docker container stop $(docker container ps -a -q)<br>
>docker container rm $(docker container ps -a -q)<br>
>docker volume rm $(docker volume ls -q)<br>

+ Delete_images.sh: questo script è utilizzato per eliminare con un solo comando tutte le immagini. <br>
Al proprio interno troviamo il seguente codice:<br>
>docker image rm $(docker image ls -a -q)<br>

+ Delete_images.sh: questo script è utilizzato per eliminare con un solo comando tutti le immagini. <br>
Al proprio interno troviamo il seguente codice:<br>
>docker image rm $(docker image ls -a -q)<br>

+ Delete_networks.sh: questo script è utilizzato per eliminare con un solo comando tutti i network creati. <br>
Al proprio interno troviamo il seguente codice:<br>
>docker network rm $(docker network ls -q)<br>

+ Delete_all.sh: questo script è utilizzato per eliminare con un solo comando tutti i network, immagini e containers. <br>
Al proprio interno troviamo il seguente codice:<br>
>./delete_containers.sh<br>
>./delete_images.sh<br>
>./delete_networks.sh<br>

+ docker-compose.yml: file di configurazione dei servizi. <br>
Sono stati implementati i seguenti servizi: <br>
  1. Joomla<br>
  2. MariaDB<br>
  3. Prometheus<br>
  4. Grafana<br>
  5. AlertManager<br>
  6. cAdvisor<br>
  7. Nginx<br>
  8. Phpmyadmin<br>
  9. Visualizer<br>
  10. Node-exporter<br>






