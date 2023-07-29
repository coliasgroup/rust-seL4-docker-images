id := rust-sel4

TAG ?= $(id)

SRC ?= https://github.com/coliasgroup/rust-seL4.git\#HEAD

image_tag := $(TAG)
container_name := $(id)

src_context := $(SRC)

.PHONY: none
none:

.PHONY: build
build:
	docker buildx build \
		-t $(image_tag) \
		-f Dockerfile \
		--build-context src=$(src_context) \
		context

.PHONY: run
run: build
	docker run --rm \
		--name $(container_name) \
		--mount type=bind,src=$(abspath $(src_context)),dst=/work \
		--workdir /work \
		-it $(image_tag) \
		bash
