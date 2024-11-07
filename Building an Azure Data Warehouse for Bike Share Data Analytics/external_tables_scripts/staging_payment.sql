IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'bikeshare-storage_bikesharestorage_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [bikeshare-storage_bikesharestorage_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://bikeshare-storage@bikesharestorage.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_payment (
	[payment_id] bigint,
	[date] datetime2(0),
	[amount] float,
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'publicpayment.csv',
	DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_payment
GO