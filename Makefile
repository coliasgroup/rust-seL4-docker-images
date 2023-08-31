id := rust-sel4

TAG ?= $(id)

SRC ?= https://github.com/coliasgroup/rust-seL4.git\#HEAD

MOUNT_SRC ?=

image_tag := $(TAG)
container_name := $(id)

context_src := $(SRC)
mount_src := $(MOUNT_SRC)

ifneq ($(mount_src),)
mount_arg := \
	--mount type=bind,src=$(abspath $(mount_src)),dst=/work \
	--workdir /work
endif

.PHONY: none
none:

.PHONY: build
build:
	docker buildx build \
		-t $(image_tag) \
		-f Dockerfile \
		--build-context src=$(context_src) \
		context

.PHONY: run
run: build
	docker run --rm \
		--name $(container_name) \
		$(mount_arg) \
		-it $(image_tag) \
		bash
