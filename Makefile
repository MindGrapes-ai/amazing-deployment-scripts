TAG = dev

deploy: pull clean up

all: pull clean up logs

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
