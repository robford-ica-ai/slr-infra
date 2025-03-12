#!/bin/bash

# Deployment script for SLR System
# This script deploys the entire SLR system using Docker Compose

# Set environment variables
ENV=${1:-production}
COMPOSE_FILE="../docker-compose.yml"

if [ "$ENV" = "development" ]; then
  COMPOSE_FILE="../docker-compose.dev.yml"
  echo "Deploying in DEVELOPMENT mode"
else
  echo "Deploying in PRODUCTION mode"
fi

# Create secrets directory if it doesn't exist
mkdir -p ../secrets

# Check if Google credentials file exists
if [ ! -f "../secrets/google-credentials.json" ]; then
  echo "WARNING: Google credentials file not found at ../secrets/google-credentials.json"
  echo "You will need to provide this file for the Document AI service to work properly."
fi

# Check if .env file exists
if [ ! -f "../.env" ]; then
  echo "ERROR: .env file not found at ../.env"
  echo "Please create this file with the required environment variables."
  exit 1
fi

# Pull latest images
echo "Pulling latest images..."
docker-compose -f $COMPOSE_FILE pull

# Build and start services
echo "Building and starting services..."
docker-compose -f $COMPOSE_FILE up -d --build

# Check service health
echo "Checking service health..."
sleep 10
docker-compose -f $COMPOSE_FILE ps

echo "Deployment complete!"
echo "You can access the services at:"
echo "- Web UI: http://localhost:3000"
echo "- Supabase: http://localhost:54321"
echo "- n8n: http://localhost:5678"
echo "- Document AI: http://localhost:8000"
echo "- Vector DB: http://localhost:8001"
echo "- Quarto Export: http://localhost:8002" 