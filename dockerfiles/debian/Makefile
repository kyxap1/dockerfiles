# Docker image builder
#
SHELL := /bin/bash

IMAGE_NAME = "pro-manage.net/debian-basic:latest"
IMAGE_ID = "$(shell docker inspect --format='{{ .id }}' $(IMAGE_NAME) )"

TEST_CONTAINER = "myTest"
CONTAINER_ID = "$(shell docker inspect --format='{{ .id }}' $(TEST_CONTAINER) )"

all: build

build:
	@mispipe "docker build -t $(IMAGE_NAME) --rm=true ." "tee build.log" || :

rmi: rm
	@docker rmi $(IMAGE_NAME) || @docker rmi -f $(IMAGE_NAME)

reinstall: uninstall install

run:
	@docker run --hostname=$(TEST_CONTAINER) --name=$(TEST_CONTAINER) -d $(IMAGE_ID) || :

stop:
	@docker stop $(TEST_CONTAINER) && echo Success

restart: stop start

rm:
	@docker rm $(TEST_CONTAINER) || docker rm -f $(TEST_CONTAINER)

image:
	@echo $(IMAGE_ID)

ps:
	@docker ps -n=1 || :

