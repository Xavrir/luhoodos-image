#!/usr/bin/env bash
set -euxo pipefail

IMAGE_NAME="${IMAGE_NAME:-luhoodos}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

docker run --rm "${IMAGE_NAME}:${IMAGE_TAG}" cat /usr/share/luhoodos/manifest.json
docker run --rm "${IMAGE_NAME}:${IMAGE_TAG}" cat /usr/share/luhoodos/onboarding-defaults.json
