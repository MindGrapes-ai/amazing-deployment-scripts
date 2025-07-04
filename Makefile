TAG = dev

deploy: pull clean env up

all: pull clean up logs

env:
	docker pull ghcr.io/managedkaos/create-env-file:main
	docker run --rm --env PARAMETER_PATH="/coursehub/$(TAG)" ghcr.io/managedkaos/create-env-file:main > /root/.env

up:
	mkdir -p /mnt/elastic_file_system/database
	mkdir -p /mnt/elastic_file_system/redis
	mkdir -p /mnt/elastic_file_system/media
	mkdir -p /mnt/elastic_file_system/static
	ENVIRONMENT=production docker compose up --detach

down:
	-docker compose down

logs:
	-docker compose logs -f

pull:
	docker pull 248631993760.dkr.ecr.us-east-1.amazonaws.com/coursehub-frontend:$(TAG)
	docker pull 248631993760.dkr.ecr.us-east-1.amazonaws.com/coursehub-backend:$(TAG)

list-images:
	-docker image ls | grep course

status:
	-docker compose ps | grep course

clean: down
	-docker rm frontend
	-docker rm backend

frontend-exec:
	docker exec -it frontend /bin/sh

backend-exec:
	docker exec -it backend /usr/bin/bash