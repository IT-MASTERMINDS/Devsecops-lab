#!/bin/bash

# Check if docker-compose.override.yml file exists and remove it
if [ -f docker-compose.override.yml ]; then
  rm docker-compose.override.yml
  echo "Previous docker-compose.override.yml file has been removed."
fi

# Get the group ID of the 'docker' group
DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)

# Create a Docker Compose file with the specified 'user' field
cat <<EOF > docker-compose.override.yml
---
version: "3.8"

services:
  jenkins:
    user: ":$DOCKER_GROUP_ID"
EOF

echo "DockerCompose file has been updated with user ID: $DOCKER_GROUP_ID"
