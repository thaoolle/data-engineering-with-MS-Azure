IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dim_rider];
END

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION     = 'dim_rider',
    DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT [rider_id], [first_name], [last_name], [address], [birthday], [account_start_date], [account_end_date], [is_member]
FROM [dbo].[staging_rider];
GO

SELECT TOP 100 * FROM [dbo].[dim_rider];