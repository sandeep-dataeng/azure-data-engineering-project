--- create external tables

create EXTERNAL TABLE revenue_ext_table(
    Dealer_ID varchar(4000),
    Model_ID varchar(4000),
    Branch_ID varchar(4000),
    Date_ID varchar(4000),
    Units_Sold varchar(4000),
    Revenue varchar(4000)
)
WITH
(
    LOCATION='revenue',
    DATA_SOURCE=raw_ext_source,
    FILE_FORMAT=csv_format
)




