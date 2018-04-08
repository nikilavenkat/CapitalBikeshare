/***************************************************************************
Name: Capital Bikeshare - Data Validations.sql
Author: Nikila Venkat
Date: 4/7/2018

Purpose:
****************************************************************************/

-- Determine the primary key of the file

	-- This works!
	select [start date], [start station number], [bike number], count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by [start date], [start station number], [bike number]
	having count(*) > 1

	-- This also works
	select [start date], [bike number], count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by [start date], [bike number]
	having count(*) > 1

-- What is the min/max of duration? 60 to 85644
	select cast(duration as int), count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by cast(duration as int)
	order by 1


-- What's the range of dates? 2010-09-20 to 2010-12-31 (end date goes until 2011-01-01)
	select cast([start date] as date), count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by cast([start date] as date)
	order by 1

	select cast([end date] as date), count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by cast([end date] as date)
	order by 1

-- How many stations are there? 106/107
	select count(distinct [start station number])
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw

	select count(distinct [end station number])
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw

-- Does each station map to a unique address? Yes
	select [start station number], count(distinct [start station])
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by [start station number]
	having 	count(distinct [start station]) > 1

	select [end station number], count(distinct [end station])
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by [end station number]
	having 	count(distinct [end station]) > 1

-- Does the number of bikes change a lot from day to day?
	select cast([start date] as date), count(distinct [bike number])
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by cast([start date] as date)
	order by 1

-- What are the different member types? Member, Casual, Unknown
	select [member type], count(*)
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	group by [member type]
	order by 2 desc


	


