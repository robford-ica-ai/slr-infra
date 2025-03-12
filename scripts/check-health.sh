#!/bin/bash

# Health check script for SLR System
# This script checks the health of all services

# Set environment variables
ENV=${1:-production}
COMPOSE_FILE="../docker-compose.yml"

if [ "$ENV" = "development" ]; then
  COMPOSE_FILE="../docker-compose.dev.yml"
  echo "Checking health in DEVELOPMENT environment"
else
  echo "Checking health in PRODUCTION environment"
fi

# Check if Docker Compose is running
if ! docker-compose -f $COMPOSE_FILE ps > /dev/null 2>&1; then
  echo "ERROR: Docker Compose services are not running."
  echo "Run './deploy.sh' to start the services."
  exit 1
fi

# Function to check service health
check_service() {
  local service=$1
  local url=$2
  
  echo -n "Checking $service... "
  
  # Check if service is running in Docker Compose
  if ! docker-compose -f $COMPOSE_FILE ps $service | grep -q "Up"; then
    echo "NOT RUNNING"
    return 1
  fi
  
  # Check if service is healthy
  if curl -s -o /dev/null -w "%{http_code}" $url | grep -q "200\|204"; then
    echo "HEALTHY"
    return 0
  else
    echo "UNHEALTHY"
    return 1
  fi
}

# Check all services
echo "Checking service health..."
echo "=========================="

check_service "web" "http://localhost:3000/api/health"
check_service "n8n" "http://localhost:5678/healthz"
check_service "doc-ai" "http://localhost:8000/health"
check_service "vector-db" "http://localhost:8001/health"
check_service "quarto-export" "http://localhost:8002/health"

# Check Supabase (special case)
echo -n "Checking supabase... "
if docker-compose -f $COMPOSE_FILE ps supabase | grep -q "Up"; then
  if docker-compose -f $COMPOSE_FILE exec supabase pg_isready -U postgres > /dev/null 2>&1; then
    echo "HEALTHY"
  else
    echo "UNHEALTHY"
  fi
else
  echo "NOT RUNNING"
fi

echo "=========================="
echo "Health check complete!" 