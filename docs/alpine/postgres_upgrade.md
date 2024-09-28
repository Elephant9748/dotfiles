# migration postgres data in `docker container` Major Version
###### 1. backup all data
```
docker-compose exec postgres pg_dumpall -U "[user postgres]" > postgres[version]_willy_data_backup_[date].sql
```

###### 2. stop container
```
./stop.sh
```

###### 3. get new image
```
./pull-image.sh
```

###### 4. restore all data
```

stop-container

sudo cp -r [docker-volume-postgres-old] [docker-volume-postgres-new]

changed: docker-compose.yml to match [docker-volume-postgres-new]

run-container

stop-container

sudo cp postgres[version]_willy_data_backup_[date].sql [docker-volume-postgres-new]/

docker-compose exec postgres sh

psql -U "willy" -d- "db_nxcloud"<  /var/lib/postgresql/data/postgres[version]_willy_data_backup_[data].sql

run-container
```


###### important note
```
1. helpful link : https://hollo.me/devops/upgrade-postgresql-database-with-docker.html
2. create temp persistence data postgres in docker-compose.yml
3. user pass admin at postgres_db.txt postgres_user.txt postgres_password.txt
```
