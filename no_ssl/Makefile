#!make

DOCKER_COMPOSE_CMD = docker-compose

# docker

build:
	$(DOCKER_COMPOSE_CMD) build --no-cache

status:
	$(DOCKER_COMPOSE_CMD) ps
up:
	$(DOCKER_COMPOSE_CMD) up -d
	@$(MAKE) --no-print-directory status
stop:
	$(DOCKER_COMPOSE_CMD) stop
	@$(MAKE) status

restart: stop up


# logs
logs-traefik:
	$(DOCKER_COMPOSE_CMD) logs -f traefik

# bash/sh
console-traefik:
	$(DOCKER_COMPOSE_CMD) exec traefik sh

create-password:
	htpasswd -nb admin password

generate-ssl:
	bash .docker/traefik/with_ssl/bin/generate-ssl.sh
