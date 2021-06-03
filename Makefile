USERNAME = pangteypiyush
REPOSITORY = python
IMAGE ?= $(USERNAME)/$(REPOSITORY)

TARGET = \
	 3.5 \
	 3.6 \
	 3.7 \
	 3.8

.PHONY: build
build: $(TARGET)

$(TARGET): Dockerfile
	@docker build --rm -t $(IMAGE):$@ \
		--build-arg PYTHON_VERSION=$@ . ;

.PHONY: push
push: $(TARGET)
	@docker push -a $(IMAGE)

.PHONY: remove
remove:
	@for version in $(TARGET); do \
		docker rmi $(IMAGE):$${version}; \
	done
