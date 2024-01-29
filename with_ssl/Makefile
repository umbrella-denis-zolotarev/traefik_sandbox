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

download-traefik-me-certs:
	mkdir -p .docker/traefik/certs
	curl traefik.me/privkey.pem > .docker/traefik/certs/privkey.pem
	curl traefik.me/cert.pem > .docker/traefik/certs/cert.pem

check-cert:
	openssl x509 -in .docker/traefik/certs/cert.pem -text -noout

generate-ssl:
	mkdir -p .docker/traefik/certs
	# arguments: 1 - ssl folder; 2 - domain name; 3 - privkey file name; 3 - cert file name
	bash .docker/traefik/bin/generate-ssl.sh .docker/traefik/certs traefik.me privkey.pem cert.pem
trust-cert:
	sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" .docker/traefik/certs/cert.pem
