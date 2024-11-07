IF OBJECT_ID('dbo.dim_date') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dim_date];
END

-- Declare variables for date range
DECLARE @MinDate DATE, @MaxDate DATE;
SET @MinDate = (SELECT CAST(MIN(started_at) AS DATE) FROM [dbo].[staging_trip]);
SET @MaxDate = (SELECT CAST(MAX(ended_at) AS DATE) FROM [dbo].[staging_trip]);

-- Generate date range using a CTE
WITH GeneratedDates AS (
    SELECT DATEADD(DAY, number, @MinDate) AS date
    FROM master..spt_values
    WHERE type = 'P'
    AND number BETWEEN 0 AND DATEDIFF(DAY, @MinDate, @MaxDate)
)
-- Create a staging table for the generated dates
CREATE TABLE #GeneratedDates AS
SELECT date
FROM GeneratedDates;
-- Create temporary table with generated dates
CREATE TABLE #GeneratedDates (
    date DATE
);

-- Insert generated dates into temporary table
INSERT INTO #GeneratedDates
SELECT DATEADD(DAY, number, @MinDate) AS date
FROM master..spt_values
WHERE type = 'P'
AND number BETWEEN 0 AND DATEDIFF(DAY, @MinDate, @MaxDate);

-- Create external table
CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION     = 'dim_station',
    DATA_SOURCE = [bikeshare-storage_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
    CONVERT(VARCHAR, date, 112) AS [day_key],
    date AS [date],
    YEAR(date) AS [year],
    DATEPART(QUARTER, date) AS [quarter],
    DATEPART(MONTH, date) AS [month],
    DATENAME(MONTH, date) AS [month_name],
    DATEPART(DAY, date) AS [day],
    DATEPART(WEEKDAY, date) AS [day_of_week],
    DATENAME(WEEKDAY, date) AS [day_name]
FROM #GeneratedDates;

DROP TABLE #GeneratedDates;

-- Verify creation of external table
SELECT TOP 100 * FROM [dbo].[dim_date];