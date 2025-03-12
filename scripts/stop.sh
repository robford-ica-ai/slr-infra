#!/bin/bash

# Stop script for SLR System
# This script stops all services

# Set environment variables
ENV=${1:-production}
COMPOSE_FILE="../docker-compose.yml"

if [ "$ENV" = "development" ]; then
  COMPOSE_FILE="../docker-compose.dev.yml"
  echo "Stopping services in DEVELOPMENT environment"
else
  echo "Stopping services in PRODUCTION environment"
fi

# Stop services
echo "Stopping all services..."
docker-compose -f $COMPOSE_FILE down

echo "All services have been stopped." 