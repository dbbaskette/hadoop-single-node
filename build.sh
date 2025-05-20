#!/bin/bash
# Multiarch build & push script for Hadoop Single Node Docker image
set -e

# Set your Docker Hub username here
DOCKER_USER="dbbaskette"
IMAGE_NAME=hadoop-single-node
IMAGE_TAG=latest
PLATFORMS=linux/amd64,linux/arm64

if [ "$DOCKER_USER" = "" ]; then
  echo "Please edit build.sh and set your Docker Hub username in the DOCKER_USER variable."
  exit 1
fi

# Optionally, ensure buildx is initialized
if ! docker buildx inspect multiarch-builder &>/dev/null; then
  docker buildx create --name multiarch-builder --use
fi

FULL_IMAGE_NAME="docker.io/$DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG"
echo "Building and pushing $FULL_IMAGE_NAME for platforms: $PLATFORMS"

docker buildx build --platform $PLATFORMS -t $FULL_IMAGE_NAME . --push

echo "Image pushed to $FULL_IMAGE_NAME"

docker pull $FULL_IMAGE_NAME
