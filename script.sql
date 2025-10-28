SELECT * FROM assembly;

SELECT * FROM duration;

SELECT * FROM payment;

SELECT * FROM trips;

SELECT * FROM trip_details;

SELECT count(*) FROM trips;

SELECT count(*) FROM trip_details;

-- total trips
-- select count(distinct w) from trip_details;

ALTER TABLE trip_details
CHANGE w tripid INT; -- Replace INT with your column’s actual data type

SELECT * FROM trip_details
where tripid<10;

-- total trips
select count(distinct tripid) from trip_details;

-- total drivers
select count(distinct driverid) from trips;

-- total earning
select sum(fare) from trips;

-- completed trips
select count(distinct tripid) trip from trips;

-- total searches
select sum(searches) from trip_details;

-- total searches which got estimated
select sum(searches_got_estimate) from trip_details;

-- total searches which got quotes
select sum(searches_got_quotes) from trip_details;

-- total customer cancelled
select count(*) - (customer_not_cancelled) from trip_details;

-- total driver cancelled
select count(*) - sum(driver_not_cancelled) from trip_details;

-- average fare
select avg(fare) from trips;

-- dist travelled
select sum(distance) from trips;

-- most used payment method
select faremethod,count(distinct tripid) from trips
group by faremethod
order by count(distinct tripid) desc
limit 1;

-- select t.faremethod,count(faremethod),p.method
-- from trips t join payment p
-- on t.tripid=p.id
-- group by t.faremethod
-- order by count(t.faremethod) desc;

select p.method from payment p inner join
(select faremethod,count(distinct tripid) from trips
group by faremethod
order by count(distinct tripid) desc
limit 1) t
on p.id=t.faremethod;

-- highest payment
select p.method,t.fare from payment p inner join
(select * from trips
order by fare desc
limit 3) t
on p.id=t.faremethod;

select faremethod,sum(fare) from trips
group by faremethod
order by sum(fare) desc
limit 1;

-- 2 locations with most trips
select loc_from, loc_to, count(distinct tripid) from trips
group by loc_from,loc_to
order by count(distinct tripid) desc ;

-- duration with most trips
select * from
(select *,rank() over(order by cnt desc) rnk from
(select duration, count(distinct tripid) cnt from trips
group by duration)b)c
where rnk<6;