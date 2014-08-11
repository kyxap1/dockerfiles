# Docker image builder
#
SHELL := /bin/bash

IMAGE_NAME= "pro-manage.net/logs"
IMAGE_ID= $(shell docker inspect --format='{{ .id }}' $(IMAGE_NAME) )

CONTAINER_NAME= "logs"
CONTAINER_ID= $(shell docker inspect --format='{{ .id }}' $(CONTAINER_NAME) )

all: build
build:
	@mispipe "docker build -t $(IMAGE_NAME) --rm=true ." "tee build.log"
rmi:
	-@[[ '$(IMAGE_ID)' ]] && docker rmi -f $(IMAGE_NAME)
reinstall: rmi | build
run:
	@[[ '$(IMAGE_ID)' ]] && docker run --name=$(CONTAINER_NAME) -d $(IMAGE_ID)
run-debug:
	@docker run --name=$(CONTAINER_NAME) --rm=true -it $(IMAGE_ID) /bin/bash
attach:
	@docker attach --sig-proxy=false $(CONTAINER_NAME)
logs:
	@docker logs $(CONTAINER_NAME)
stop:
	@docker stop $(CONTAINER_NAME)
restart: stop run | rm
rm: stop
	-@[[ '$(CONTAINER_ID)' ]] && docker rm -f $(CONTAINER_NAME)
images:
	@docker images $(IMAGE_NAME)
ps:
	@docker ps -n=1

#.PHONY : rmi rm
