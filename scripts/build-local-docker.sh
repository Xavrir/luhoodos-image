#!/usr/bin/env bash
set -euxo pipefail

IMAGE_NAME="${IMAGE_NAME:-luhoodos}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

docker build -f Containerfile -t "${IMAGE_NAME}:${IMAGE_TAG}" .

IMAGE_NAME="${IMAGE_NAME}" IMAGE_TAG="${IMAGE_TAG}" "$(dirname "$0")/verify-image-metadata.sh"

echo
echo "Built ${IMAGE_NAME}:${IMAGE_TAG}"
echo "Verified LuhoodOS metadata inside ${IMAGE_NAME}:${IMAGE_TAG}"
