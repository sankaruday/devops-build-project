#!/bin/bash
echo "Deploying the image to the server on Port 80..."

# Stops existing containers and starts the new one in detached mode
docker compose down || true
docker compose up -d

echo "Deployment complete."
