# Apache Iceberg

This folder contains a Docker Compose stack with notebooks demonstrating how to work with Apache Iceberg tables. It spawns following services:

- a Jupyter notebook environment that includes PySpark, Polars and DuckDB (https://jupyter.org/)
- a single-node Trino cluster (https://trino.io/)
- an instance of Lakekeeper catalog (https://lakekeeper.io/)
- a MinIO storage service, compatible with AWS S3 and used as the underlying storage (https://min.io/)
- a PostgreSQL database for Lakekeeper metadata storage

### Requirements

The only required component is `docker` and `docker-compose`, which can be downloaded as a single package from https://www.docker.com/products/docker-desktop. Shortcut scripts prepared in this repository assume that a *nix operating system is being used, offering one of the standard shell environments like `sh` or `bash`.

**On Windows**

In order to use the contents of this repository on Windows, WSL (Windows Subsystem for Linux) is required. In addition to that, an option in Docker Desktop to integrate with WSL needs to be enabled.

**All commands described here should be executed from the main folder of the repository.**

### Project Structure

The structure of the folders and files in this project is as follows:

```
.
├── _data/      # stores data generated when working with provided notebooks
├── _notebooks/ # Jupyter notebooks with examples and exercises
├── docker/     # definitions of Docker images and the Docker Compose stack
├── dbuild      # build command (see below)
├── dclean      # clean command (see below)
└── drun        # run command (see below)
```

To understand how each service is configured to work together, please familiarise yourself with the `./docker/docker-compose.yaml` file, as well as with `Dockerfile` definitions and configuration files in subfolders responsible for each of the services.

### Preparations

Build Docker images (it may take some time):

```sh
./dbuild
```

### Running and Testing

The Docker Compose stack can be started with:

```sh
./drun
```

After the stack is up, following UIs can be accessed in the browser:

- the Jupyter environment at http://localhost:8888, with notebooks in `/_notebooks/`
- the Trino UI at http://localhost:8080 (any user name will do)
- the MinIO console at http://localhost:9001 (user: `minioadmin`, password: `minioadmin`)

To intialise the environment and verify that everything works, execute cells in the notebook called `prepare.ipynb`, one by one.

### Notebooks

The `_notebooks/` directory contains the following sets of examples and exercises:

#### `prepare.ipynb`

Initial setup notebook that must be run first. This notebook:
- Creates the S3 bucket in MinIO for table storage
- Bootstraps the Lakekeeper catalog
- Initializes the Iceberg warehouse
- Verifies that Spark and Trino clients can connect properly

#### `iceberg_overview/`

A series of notebooks demonstrating different ways to work with Apache Iceberg tables:

- **01_pyspark.ipynb** - Introduction to Iceberg with PySpark
  - Creating tables with SQL and the DataFrame API
  - Inserting, updating, and deleting data
  - Exploring table metadata: partitions, snapshots, manifests, and history

- **02_python.ipynb** - Using the pure Python client (pyiceberg)
  - Loading tables from the catalog
  - Inspecting table metadata and schemas
  - Working with snapshots and partition specs

- **03_pyspark_again.ipynb** - Additional PySpark examples

- **04_trino.ipynb** - Querying Iceberg tables with Trino SQL engine

- **05_polars.ipynb** - Reading and querying Iceberg tables using Polars

- **06_duckdb.ipynb** - Accessing Iceberg tables with DuckDB

- **07_views.ipynb** - Creating and managing Iceberg views

#### `buzzwords_2025_workshop/`

A comprehensive workshop notebook covering advanced Iceberg features:

- Setting up PyIceberg and Spark clients
- Creating and managing tables
- **Partitioning strategies**
  - Changing partition layouts on existing tables
  - Using different partition transforms (years, buckets)
- **Snapshot management**
  - Time-travel queries using snapshot IDs
  - Creating and querying tags for specific snapshots
  - Expiring old snapshots
- **Multi-library access**
  - Querying tables with Polars and DuckDB
  - Exploring the PyIceberg API
- **Data file lifecycle**
  - Understanding data files vs. deleted files
  - Inspecting metadata tables (data_files, all_data_files)

### Cleanup

All Docker containers and images can be removed by running:

```sh
./dclean
```

Afterwards the images will have to be rebuilt from scratch if necessary. Additionally, to remove data files generated during the execution of the notebooks, delete all subfolders in `./_data/`.
