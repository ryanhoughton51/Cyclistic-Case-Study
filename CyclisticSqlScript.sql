--This is the SQL script used to import, compile and analyse the Cyclistic Case 
--Study for the Capstone Project of the Google Data Analytics Professional Certificate.

--It uses the data from Divvy Bikes (https://www.divvybikes.com/system-data).


--First, we will create separate columns for month, day, and year.
--We will do this by pulling each data point respectively from the started_at column
--which is the column that contains the day in which a ride was started

alter table dbo.information
add ride_day nvarchar(100) 

update information
set ride_day = day(started_at)

alter table dbo.information
add ride_month nvarchar(100) 

update information
set ride_month = month(started_at)

alter table dbo.information
add ride_year nvarchar(100) 

update information
set ride_year = year(started_at)

--Next, we will check every distinct instance of the rideable_type column
select distinct rideable_type 
from information

--Now, we will set every instance of each bike type equal to the formatting of our choosing
update information
set rideable_type = 'docked bike'
where rideable_type = 'docked_bike'

update information
set rideable_type = 'electric bike'
where rideable_type = 'electric_bike'

update information
set rideable_type = 'classic bike'
where rideable_type = 'classic_bike'

--Next, we will begin deleting rows that contain null values
delete from dbo.information
where end_station_name is null

delete from dbo.information
where end_station_id is null

delete from dbo.information
where start_station_name is null

delete from dbo.information
where start_station_id is null

--Before converting the ride_length data type we must ensure every row is 7 chartacters long exactly
select distinct len(ride_length)
from information

--Next, we will remove all spaces or whitespace from the ride_length column so it can be coverted to a time data type
update information
set ride_length = REPLACE(ride_length, ' ', '')

--Next, we can convert ride_length into a data type of time
update information
set ride_length = cast(ride_length as time)

--Finally, we can write a basic query that will be uploaded to Tableau for further analysis
select *
from information
order by started_at