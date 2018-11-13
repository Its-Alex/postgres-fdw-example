CREATE EXTENSION postgres_fdw;

CREATE SERVER db2
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres-2', dbname 'poc-sharding', port '5432');
CREATE SERVER db3
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres-3', dbname 'poc-sharding', port '5432');

CREATE USER MAPPING FOR user
        SERVER db2
        OPTIONS (user 'poc-sharding', password 'password');
CREATE USER MAPPING FOR user
        SERVER db3
        OPTIONS (user 'poc-sharding', password 'password');

CREATE TABLE temperatures (
    at      date,
    city    text,
    mintemp integer,
    maxtemp integer
)
PARTITION BY RANGE (at);

CREATE FOREIGN TABLE temperatures_2016
    PARTITION OF temperatures
    FOR VALUES FROM ('2016-01-01') TO ('2017-01-01')
    SERVER db2;

CREATE FOREIGN TABLE temperatures_2017
    PARTITION OF temperatures
    FOR VALUES FROM ('2017-01-01') TO ('2018-01-01')
    SERVER db3;
