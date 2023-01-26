--SELECT * FROM nyc_taxi.taxi_zones_lookup

--Question 3 - How many taxi trips were totally made on January 15? 
--Ans: 20530

select
    count(id) as trips
from
    nyc_taxi.green_taxi
where
    lpep_pickup_datetime >= timestamp '2019-01-15 00:00:00' and
    lpep_dropoff_datetime < timestamp '2019-01-16 00:00:00';

--Question 4 - Which was the day with the largest trip distance? 
--Ans: 2019-01-15

select
    cast(green_taxi.lpep_pickup_datetime as date) as day, max(trip_distance) as "Max trip distance on a day"
from
    nyc_taxi.green_taxi
group by green_taxi.lpep_pickup_datetime, trip_distance
order by green_taxi.trip_distance DESC
limit 1;

--Question 5 - In 2019-01-01 how many trips had 2 and 3 passengers? 
--Ans: 2:1282, 3:254.
--If 'lpep_dropoff_datetime' is used the answer is 2:1266, 3:253.

select
    passenger_count, count(id) as trips
from
    nyc_taxi.green_taxi
where
    lpep_pickup_datetime >= timestamp '2019-01-01 00:00:00' and
    lpep_pickup_datetime < timestamp '2019-01-02 00:00:00' and
    (passenger_count = 2 or passenger_count = 3)
group by passenger_count;


--Question 6 - For the passengers picked up in the Astoria Zone which was the drop up zone that had the largest tip?
--Ans: Long Island City/Queens Plaza

WITH cte_tip AS(
SELECT
     gt.DOLocationID, max(gt.tip_amount) as "max_tip in $"
FROM
    nyc_taxi.green_taxi gt
        JOIN nyc_taxi.taxi_zones_lookup tzl
            ON gt.PULocationID = tzl.locationid
where
    tzl.locationid in (7, 8, 179)
group by gt.DOLocationID, gt.tip_amount
order by gt.tip_amount desc)

select zone as "Drop off Zone", cte_tip."max_tip in $"
from nyc_taxi.taxi_zones_lookup tzl, cte_tip
where tzl.locationid = cte_tip.dolocationid 
limit 1;


