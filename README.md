# Chillout Data Engineerin'

A collection of notebooks and other code related to experiments in data engineering. This repository contains hands-on examples and exercises for exploring modern data engineering tools and technologies.

## Projects

### Apache Iceberg (`/iceberg`)

A Docker Compose stack with Jupyter notebooks demonstrating how to work with Apache Iceberg tables on top of S3-compatible storage. The stack includes:

- Jupyter environment with PySpark, Polars, and DuckDB
- Single-node Trino cluster for SQL queries
- Lakekeeper catalog for Iceberg metadata management
- MinIO for S3-compatible object storage
- PostgreSQL for metadata storage

See `/iceberg/README.md` for detailed setup instructions and usage examples.
