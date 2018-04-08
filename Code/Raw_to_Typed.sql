/***************************************************************************
Name: Capital Bikeshare - Raw to Typed.sql
Author: Nikila Venkat
Date: 4/7/2018

Purpose:
****************************************************************************/

-- drop table CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw

-- Drop typed table if exists
	if object_ID('CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed') is not null
		drop table CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed

-- Cast from raw to typed
	select
		 cast(duration as int) as duration
		,isnull(cast([start date] as datetime),'1900-01-01') as start_date
		,isnull(cast([end date] as datetime),'1900-01-01') as end_date
		,isnull(cast([start station number] as int),-99) as start_station_number
		,isnull(cast([start station] as varchar(255)),'Unknown') as start_station
		,isnull(cast([end station number] as int),-99) as end_station_number
		,isnull(cast([end station] as varchar(255)),'Unknown') as end_station
		,isnull(cast([bike number] as varchar(20)),'Unknown') as bike_number
		,isnull(cast([member type] as varchar(20)),'Unknown') as member_type
		,isnull(cast('2012-12-31' as date),'1900-01-01') as file_date
	into CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_raw
	go

-- Add primary key
	alter table CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed
	add constraint pk_etl_capitalbikeshare_tripdata_typed
	primary key (start_date,bike_number) with (data_compression = page)

-- Populate master table
	insert into CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed_master (
		 start_date
		,end_date
		,start_station_number
		,start_station
		,end_station_number
		,end_station
		,bike_number
		,member_type
		,file_date
		)
	select
		 start_date
		,end_date
		,start_station_number
		,start_station
		,end_station_number
		,end_station
		,bike_number
		,member_type
		,file_date
	from CapitalBikeshare.dbo.etl_capitalbikeshare_tripdata_typed

	

