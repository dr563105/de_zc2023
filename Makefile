SHELL:=/bin/bash

install_conda:
	source ./scripts/install_conda.sh

install_docker:
	source ./scripts/install_docker.sh 

download_data:
	source ./scripts/download_data.sh

start_db:
	docker-compose up -d

stop_db:
	docker-compose down

setup_pipenv:
	pip install pipenv
	pipenv install --dev

setup_prefect:
	source ./scripts/setup_prefect.sh

start_prefect:
	pipenv run prefect orion start --host 0.0.0.0
