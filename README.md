# Postgres_fdw example

Example of postgres_fdw plugins with docker

## Demo

You can start all databases

```
$ make up
```

and stop

```
$ make down
```

There are 3 databases with on master `postgres-1` and two slaves. Just one main
table `temperatures`, with partitionning on `at`.

Each temperatures in 2016 will be stored in postgres-2 and all temperatures in
2017 will be stored in postgres-3.

```
$ make enter-master
poc-sharding=# INSERT INTO temperatures (at, city, mintemp, maxtemp) VALUES ('2016-08-03', 'London', 63, 73);
INSERT 0 1
poc-sharding=# select * from temperatures;
     at     |  city  | mintemp | maxtemp
------------+--------+---------+---------
 2016-08-03 | London |      63 |      73
(1 row)

poc-sharding=# select * from temperatures_2016;
     at     |  city  | mintemp | maxtemp
------------+--------+---------+---------
 2016-08-03 | London |      63 |      73
(1 row)
poc-sharding=# select * from temperatures_2017;
     at     |  city  | mintemp | maxtemp
------------+--------+---------+---------
(0 row)
```

## Configuration

All postgres setup all in migrations and are sorted by containers names. You can
update some setup by editing files inside this folder.

## License

[MIT](https://en.wikipedia.org/wiki/MIT_License)

