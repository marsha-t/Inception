all: build up 

up:
	mkdir -p /home/mateo/data/mariadb
	mkdir -p /home/mateo/data/wordpress
	cd srcs && docker-compose up -d

down:
	cd srcs && docker-compose down

build:
	cd srcs && docker-compose build

clean: down
	-docker rmi -f $(shell docker images -q)

re: clean all

fclean:
	- docker rm nginx wordpress mariadb -f 
	- docker volume rm mariadb_data wordpress
	- sudo rm -rf /home/mateo/data
	- yes | docker system prune -a --volumes

.PHONY: up down build clean re  
 #