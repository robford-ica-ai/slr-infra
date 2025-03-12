# slr-infrastructure: Orchestration repository for deployment and coordination
slr-infrastructure/
├── .github/workflows/           # CI/CD pipelines for deployment
├── .gitignore
├── README.md
├── docker-compose.yml           # Production configuration
├── docker-compose.dev.yml       # Development configuration
├── docker-compose.test.yml      # Testing configuration
├── .env.example                 # Example environment variables
├── scripts/                     # Utility scripts
│   ├── clone-all-repos.sh       # Clone all repositories
│   ├── build-all.sh             # Build all services
│   ├── deploy-prod.sh           # Deploy to production
│   └── generate-test-data.sh    # Generate test data
├── monitoring/                  # Monitoring configuration
│   ├── prometheus/              # Prometheus configuration
│   └── grafana/                 # Grafana dashboards
├── nginx/                       # NGINX configuration for production
│   ├── conf.d/                  # Site configurations
│   └── ssl/                     # SSL certificates
├── docs/                        # Documentation
│   ├── architecture.md          # System architecture
│   ├── deployment.md            # Deployment guide
│   └── diagrams/                # Architecture diagrams
└── tests/                       # Integration and E2E tests
    ├── integration/             # Integration tests
    └── e2e/                     # End-to-end tests