VENV_NAME?=.venv
UBUNTU=rolling

build:
	docker build --build-arg UBUNTU=$(UBUNTU) -t isp-dovecot:local -f core/dovecot/Dockerfile .
	docker build --build-arg UBUNTU=$(UBUNTU) -t isp-exim:local -f core/exim/Dockerfile .
	docker build --build-arg UBUNTU=$(UBUNTU) -t isp-postgres:local -f core/postgres/Dockerfile .
	docker build --build-arg UBUNTU=$(UBUNTU) -t isp-roundcube:local -f core/roundcube/Dockerfile .
	docker build --build-arg UBUNTU=$(UBUNTU) -t isp-rspamd:local -f core/rspamd/Dockerfile .

start:
	docker stack deploy -c docker-compose.yaml isp

stop:
	docker stack rm isp
