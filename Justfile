set shell := ["bash", "-cu"]

image_name := "luhoodos"
default_tag := "latest"

build target_image=image_name tag=default_tag:
    podman build --tag {{target_image}}:{{tag}} .

run target_image=image_name tag=default_tag:
    podman run --rm -it {{target_image}}:{{tag}} /bin/bash

clean:
    podman image rm {{image_name}}:{{default_tag}} || true
