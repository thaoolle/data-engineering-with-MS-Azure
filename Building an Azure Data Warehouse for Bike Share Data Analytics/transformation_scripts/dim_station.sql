IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dim_station];
END

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION     = 'dim_station',
    DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT [station_id], [name], [latitude], [longtitude]
FROM [dbo].[staging_station];
GO

SELECT TOP 100 * FROM [dbo].[dim_station];