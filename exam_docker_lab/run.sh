docker stop $(docker ps -aq);docker rm $(docker ps -aq);docker rmi $(docker images -a -q);docker volume rm $(docker volume ls -q);docker-compose up
