# Course repo for DE zoom camp 2023

All the course related things will be here.

## Clone, install docker and docker-compose

The instructions were tested on Ubuntu 20.04 LTS. It is recommended to run these instruction in an Ubuntu based machine. 

```
sudo apt update && sudo apt install make git gzip unzip -y
cd ~ && git clone https://github.com/dr563105/de_zc2023.git
cd de_zc2023
make install_docker
source ~/.bashrc
```
Logout and log in back to the instance. To test docker if it is working, run

```
docker run --rm hello-world # should return "Hello from Docker!" without errors
```

## Download the dataset

Make a folder and download the necessary files.
```
cd ~/de_zc2023
make download_data
```
## Initialise Postgres DB and start it

Export postgres environment variables.
```
export POSTGRES_USER=yourDBname #postgres
export POSTGRES_PASSWORD=yourDBuserpassword #postgres
export POSTGRES_DB=yourDBname #nyc-taxi-db
```

Run the following to initialise DB and start it. On the first run, the command will create a DB, create the tables and ingest data into it. It will take about 2 minutes to be active. Successive calls will be much quicker.

```
cd ~/de_zc2023
make start_db (if you get an docker-compose not found error. Run `source ~/.bashrc`)
```

To log into the docker container and check if DB is setup properly,
```
docker exec -it de_zc2023-nytaxi_postgres-1 psql -U postgres nyc-taxi-db
```

To learn more about PSQL, read [this](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546) Github gist.

Navigate to the [homework](./hw/) folder and try to execute queries inside the `sql` file. If everything is setup properly, you should be able to get the results.
## Stop DB

```
make stop_db
```

## ETL using Prefect

Install Miniconda. We will conda as base and use `pipenv` to install other libraries.
```
make install_conda
```
Log out/in again into the machine.

Install pipenv
```
cd ~/de_zc2023
make setup_pipenv
```
Add port `4200` to ingress firewall rule.

Setup and start prefect
**In terminal 1**
```
export EC2_IP="" # replace double quotes with the EC2 IP address
make setup_prefect && make start_prefect
```




