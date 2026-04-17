#!/usr/bin/env bash
set -euxo pipefail

IMAGE_NAME="${IMAGE_NAME:-luhoodos-gnome}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

docker build -f gnome/Containerfile -t "${IMAGE_NAME}:${IMAGE_TAG}" gnome

echo
echo "Built ${IMAGE_NAME}:${IMAGE_TAG}"
echo "Inspect manifest with: docker run --rm ${IMAGE_NAME}:${IMAGE_TAG} cat /usr/share/luhoodos/manifest.json"
