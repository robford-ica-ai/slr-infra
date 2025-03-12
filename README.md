# SLR Infrastructure

This repository contains the infrastructure configuration for the Systematic Literature Review (SLR) system.

## Overview

The SLR system consists of several microservices that work together to provide a comprehensive platform for conducting systematic literature reviews. This repository contains the Docker Compose configurations and deployment scripts for orchestrating these services.

## Services

The following services are part of the SLR system:

- **Web App**: Next.js frontend with Supabase integration
- **Supabase**: Database and authentication service
- **n8n**: Workflow automation service
- **Document AI**: PDF processing service
- **Vector DB**: Vector database for semantic search
- **Quarto Export**: Document generation service

## Directory Structure

```
slr-infrastructure/
├── docker-compose.yml         # Production Docker Compose configuration
├── docker-compose.dev.yml     # Development Docker Compose configuration
├── scripts/                   # Deployment and utility scripts
│   ├── deploy.sh              # Script to deploy the system
│   ├── check-health.sh        # Script to check the health of all services
│   └── stop.sh                # Script to stop all services
└── secrets/                   # Directory for storing secrets (not committed to Git)
```

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git
- Bash shell

### Deployment

1. Make sure you have all the required environment variables in a `.env` file in the parent directory.

2. Run the deployment script:

```bash
cd scripts
./deploy.sh
```

For development mode:

```bash
cd scripts
./deploy.sh development
```

### Checking Service Health

To check the health of all services:

```bash
cd scripts
./check-health.sh
```

### Stopping Services

To stop all services:

```bash
cd scripts
./stop.sh
```

## Environment Variables

The following environment variables are required:

- `SUPABASE_URL`: URL of the Supabase instance
- `SUPABASE_ANON_KEY`: Anonymous key for Supabase
- `SUPABASE_SERVICE_KEY`: Service key for Supabase
- `POSTGRES_PASSWORD`: Password for PostgreSQL
- `JWT_SECRET`: Secret for JWT tokens
- `N8N_BASIC_AUTH_USER`: Username for n8n basic auth
- `N8N_BASIC_AUTH_PASSWORD`: Password for n8n basic auth
- `OPENAI_API_KEY`: API key for OpenAI
- `ANTHROPIC_API_KEY`: API key for Anthropic
- `PINECONE_API_KEY`: API key for Pinecone
- `PINECONE_ENVIRONMENT`: Environment for Pinecone
- `PINECONE_INDEX`: Index name for Pinecone

See the `.env.example` file in the parent directory for a complete list of required environment variables.
