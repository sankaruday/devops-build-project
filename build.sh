#!/bin/bash
# Variable definitions
DOCKER_USER="uday2097"
REPO_NAME="dev"
IMAGE_TAG="latest"

echo "Building Docker image for $DOCKER_USER/$REPO_NAME..."
docker build -t $DOCKER_USER/$REPO_NAME:$IMAGE_TAG .
