include .env
RUNSRV = docker-compose run --no-deps --rm -u root gaj-service

build-server:
	docker build --debug -t gaj-service:2.5 -f Dockerfile.server .

build-front:
	docker build --debug -t gaj-front:4.1.16 -f Dockerfile.frontend .

start:
	@docker-compose up -d

stop:
	@docker-compose down

restart: stop start

consola-server:
	./conf/shell.sh

consola-front:
	./conf/shell-front.sh

maven:
	${RUN} /usr/local/bin/compilar.sh

ps:
	@docker-compose ps


logs-front:
	docker logs -f gaj-front4116

logs-server:
	docker logs -f gaj-service25

logs-server-tofile:
	docker logs gaj-service25 > keys/server.log 2>&1

rebuild:	stop build-server build-front start logs-server