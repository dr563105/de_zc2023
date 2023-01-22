SHELL:=/bin/bash

docker_install:
	source ./scripts/install_docker.sh 

start_db:
	docker-compose up -d

stop_db:
	docker-compose down