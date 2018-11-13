up:
	docker-compose up -d

down:
	docker-compose down -v

enter-master:
	docker-compose exec --user postgres postgres-1 bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec psql -U poc-sharding"

enter-slave-1:
	docker-compose exec --user postgres postgres-2 bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec psql -U poc-sharding"

enter-slave-2:
	docker-compose exec --user postgres postgres-3 bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec psql -U poc-sharding"

.PHONY: up down enter-master enter-slave-1 enter-slave-2