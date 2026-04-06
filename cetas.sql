-- cetas -create table as select

CREATE EXTERNAL TABLE revenue_cetas
WITH
(
    LOCATION = 'cetas_revenue',
    DATA_SOURCE = raw_ext_source,
    FILE_FORMAT = PARQUET_format
)
AS
SELECT *
FROM OPENROWSET(
    BULK 'revenue',
    DATA_SOURCE = 'raw_ext_source',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS query2;


CREATE EXTERNAL TABLE ext_revenue
(
    -- define columns properly
    col1 INT,
    col2 VARCHAR(100)
)
WITH (
    LOCATION = 'revenue',
    DATA_SOURCE = raw_ext_source,
    FILE_FORMAT = CSV_format
);