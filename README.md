# Course repo for DE zoom camp 2023

All the course related things will be here.

## Clone, install docker and docker-compose

Run
```
sudo apt update && sudo apt install make git -y
cd ~ && git clone https://github.com/dr563105/de_zc2023.git
cd de_zc2023
make docker_install
```
Logout and log in back to the instance. To test docker if it is working, run

```
docker run --rm hello-world # should return hello world without errors
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
make start_db
```
## Stop DB

```
make stop_db
```



