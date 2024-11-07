IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[fact_trip];
END

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION     = 'fact_trip',
    DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT [trip_id], [rideable_type], [started_at], [ended_at], [start_station_id], [end_station_id], [rider_id]
FROM [dbo].[staging_trip];
GO

SELECT TOP 100 * FROM [dbo].[fact_trip];