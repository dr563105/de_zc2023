CREATE SCHEMA if NOT EXISTS nyc_taxi;

DROP TABLE IF EXISTS nyc_taxi.green_taxi;

CREATE TABLE if NOT EXISTS nyc_taxi.green_taxi(
id bigserial primary key,
VendorID smallint,
lpep_pickup_datetime timestamp without time zone,
lpep_dropoff_datetime timestamp without time zone,
store_and_fwd_flag varchar(2),
RatecodeID smallint,
PULocationID smallint,
DOLocationID smallint,
passenger_count int,
trip_distance numeric(14,2),
fare_amount numeric(12,2),
extra numeric(8,2),
mta_tax numeric(8,2),
tip_amount numeric(8,2),
tolls_amount numeric(8,2),
ehail_fee varchar(4),
improvement_surcharge numeric(5,2),
total_amount numeric(12,2),
payment_type smallint,
trip_type smallint,
congestion_surcharge varchar(4)
);

DROP TABLE IF EXISTS nyc_taxi.taxi_zones_lookup;

CREATE TABLE IF NOT EXISTS nyc_taxi.taxi_zones_lookup(
    LocationID smallint,
    Borough varchar(15),
    Zone varchar(250),
    service_zone varchar(250)
);

COPY
    nyc_taxi.green_taxi(VendorID, lpep_pickup_datetime, 
        lpep_dropoff_datetime, store_and_fwd_flag, RatecodeID, 
        PULocationID, DOLocationID, passenger_count, trip_distance, 
        fare_amount, extra, mta_tax, tip_amount, tolls_amount, 
        ehail_fee, improvement_surcharge, total_amount, 
        payment_type, trip_type, congestion_surcharge)
FROM
    '/home/input_data/green_tripdata_2019-01.csv' DELIMITER ',' CSV HEADER;


COPY
    nyc_taxi.taxi_zones_lookup(locationid, borough, zone, service_zone)
FROM
    '/home/input_data/taxi+_zone_lookup.csv' DELIMITER ',' CSV HEADER;