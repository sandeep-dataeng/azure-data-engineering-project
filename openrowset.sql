CREATE MASTER key ENCRYPTION by PASSWORD='S@nd33p#2026!Secure';

create DATABASE SCOPED CREDENTIAL sandcreds
WITH IDENTITY='Managed Identity';

create EXTERNAL DATA SOURCE raw_ext_source
WITH
(
    location='https://datalake14.dfs.core.windows.net/raw',
    CREDENTIAL=sandcreds
)


-- OPENROWSET
SELECT * FROM OPENROWSET(
    BULK 'revenue',
    Data_Source='raw_ext_source',
    FORMAT='csv',
    PARSER_VERSION='2.0',
    HEADER_ROW=True
) as query1


-- create file format
CREATE EXTERNAL FILE FORMAT csv_format
WITH(
    FORMAT_TYPE=DELIMITEDTEXT,
    FORMAT_OPTIONS(
        FIELD_TERMINATOR=','
    )
)



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



--creating the parquet file format

CREATE EXTERNAL FILE FORMAT PARQUET_format
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);

-- views

create view revenu_view
AS
SELECT * FROM OPENROWSET(
    BULK 'revenue',
    Data_Source='raw_ext_source',
    FORMAT='csv',
    PARSER_VERSION='2.0',
    HEADER_ROW=True
)  as query1


select * from revenu_view;

CREATE view revenue_cetas_view
AS
SELECT *
FROM OPENROWSET(
    BULK 'revenue',
    DATA_SOURCE = 'raw_ext_source',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS query2;

select * from revenue_cetas_view;