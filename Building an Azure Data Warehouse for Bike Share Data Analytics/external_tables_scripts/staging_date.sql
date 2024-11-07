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

CREATE EXTERNAL TABLE dbo.staging_date (
	[day_key] bigint,
	[date] datetime2(0),
	[year] bigint,
	[quarter] bigint,
	[month] bigint,
	[month_name] nvarchar(4000),
	[day] bigint,
	[day_of_week] bigint,
	[day_name] nvarchar(4000)
	)
	WITH (
	LOCATION = 'date_table.csv',
	DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_date
GO