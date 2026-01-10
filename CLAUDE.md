# Zenith Grafana Stack

See parent directory `../CLAUDE.md` for project-wide instructions including Linear issue management rules.

## Overview

Railway-deployed observability stack for Zenith infrastructure monitoring.

## Components

- **Grafana**: Dashboards and visualization
- **Loki**: Log aggregation
- **Prometheus**: Metrics collection (if configured)

## Development

```bash
# Start local stack
docker compose up

# Access Grafana
open http://localhost:3000
```

## Dashboards

Dashboards are provisioned automatically from the `dashboards/` directory.

## Log Queries (Loki)

Common LogQL patterns:
```logql
# API errors
{app="zenith-api"} |= "ERROR"

# Specific user activity
{app="zenith-api"} |~ "user_id.*<uuid>"

# Celery task failures
{app="celery-worker"} |= "Task failed"
```

## Conventions

- Dashboard JSON files should be version controlled
- Use variables for environment-specific values
- Document alert thresholds in dashboard descriptions
