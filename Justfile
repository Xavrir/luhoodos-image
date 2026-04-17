set shell := ["bash", "-cu"]

image_name := "luhoodos"
default_tag := "latest"

build target_image=image_name tag=default_tag:
    podman build --tag {{target_image}}:{{tag}} .

build-gnome target_image="luhoodos-gnome" tag=default_tag:
    podman build -f gnome/Containerfile --tag {{target_image}}:{{tag}} gnome

run target_image=image_name tag=default_tag:
    podman run --rm -it {{target_image}}:{{tag}} /bin/bash

clean:
    podman image rm {{image_name}}:{{default_tag}} || true

clean-gnome:
    podman image rm luhoodos-gnome:{{default_tag}} || true
