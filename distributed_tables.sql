-- Round robin
create table round_table
(
    id int,
    name varchar(4000),
    salary int
)
WITH(
    DISTRIBUTION=ROUND_ROBIN
)

insert into round_table values(1,'a',2000);

select * from round_table;

-- Replicate table
create schema gold;

create table gold.dim_product(
    dim_key_prod INT,
    prod_id INT,
    prod_name varchar(4000)
)WITH
(
    DISTRIBUTION=REPLICATE
)



-- Hash Table

create table gold.facttable(
    dim_key_prod int,
    revenue int,
    cost int
)
WITH(
    DISTRIBUTION=HASH(dim_key_prod)
)