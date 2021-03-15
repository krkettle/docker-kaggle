.PHONY:	setup
setup:
	mkdir -p data
	@echo LOCAL_UID=$(shell id -u $(USER)) > .env
	@echo LOCAL_GID=$(shell id -g $(USER)) >> .env

.PHONY:	up
up:
	docker-compose up -d

.PHONY:	build-up
build-up:
	docker-compose up -d --build

.PHONY:	exec
exec:
	docker-compose exec -u user jupyter bash

.PHONY:	down
down:
	docker-compose down